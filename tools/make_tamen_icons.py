#!/usr/bin/env python3
"""Generate Tamen light/dark app-icon + splash assets from the repo logo.

Recreates the "[Image 1]" look — `Tamen.` wordmark with a lime dot —
in both moods, keeping the EXACT logo sizes/positions we used before:

  target (1024x1024)      logo width ratio   vertical centre
  ----------------------  ----------------   ---------------
  app_icon.png            0.877 (898 px)     0.517 (529 px)
  app_icon_foreground     0.835 (855 px)     0.516 (528 px)
  splash_image(_dark)     0.584 (598 px)     0.501 (513 px)

Colours (from lib/core/theme/app_colors.dart + pubspec.yaml):
  LIGHT_TEXT  #071724  midnight navy (brand --t-fg light)
  DARK_TEXT   #F7F7F7  soft white   (brand --t-fg dark)
  LIME        #BDF75C  brand primary (the dot, both moods)
  LIGHT_BG    #FFFFFF  (flutter_launcher_icons background + splash color)
  DARK_BG     #071724  (flutter_native_splash color_dark)

How the logo is built
---------------------
* Geometry source: ``assets/images/Tamen_logo.png`` (1254x1254, transparent,
  black wordmark). Its alpha channel is the shape mask, so the letterforms
  stay pixel-identical — we only recolour.
* The dot is split from the wordmark at the transparent gap column between
  the final `n` and the `.` (around x=1087-1105 at 1254px), then painted
  LIME while the letters get LIGHT_TEXT / DARK_TEXT. Alpha (incl.
  antialiased edges) is preserved, so no halos.
* You can also pass `--source` pointing at your exported [Image 1]
  (black background, black `Tamen` + lime dot). In that case the script
  detects the opaque background, keys it out, keeps any already-lime
  pixels as the dot, and recolours the rest — geometry still normalised
  to the ratios above so sizes stay identical.

Usage
-----
  pip install pillow
  python tools/make_tamen_icons.py
  python tools/make_tamen_icons.py --source assets/images/my_image1_export.png
  python tools/make_tamen_icons.py --no-backup   # skip .bak files

Outputs (all 1024x1024 PNG)
---------------------------
  assets/images/app_icon.png               light launcher  (white bg)
  assets/images/app_icon_dark.png          dark launcher   (navy bg, extra)
  assets/images/app_icon_foreground.png    transparent, light wordmark (adaptive)
  assets/images/app_icon_foreground_dark.png transparent, dark wordmark (extra)
  assets/images/splash_image.png           transparent, light wordmark
  assets/images/splash_image_dark.png      transparent, dark wordmark
  assets/images/Tamen_logo_lime_light.png  full-res 1254 light logo (reference)
  assets/images/Tamen_logo_lime_dark.png   full-res 1254 dark logo  (reference)

Afterwards run:
  dart run flutter_launcher_icons
  dart run flutter_native_splash:create
"""

from __future__ import annotations

import argparse
import os
import shutil
import sys

try:
    from PIL import Image
except ImportError:
    sys.exit("Pillow is required:  pip install pillow")

# ---------------------------------------------------------------- constants

CANVAS = 1024

LIGHT_TEXT = (0x07, 0x17, 0x24)   # #071724 midnight navy
DARK_TEXT = (0xF7, 0xF7, 0xF7)    # #F7F7F7 soft white
LIME = (0xBD, 0xF7, 0x5C)         # #BDF75C brand primary (dot)
LIGHT_BG = (0xFF, 0xFF, 0xFF)     # #FFFFFF
DARK_BG = (0x07, 0x17, 0x24)      # #071724

DEFAULT_SOURCE = "assets/images/Tamen_logo.png"

# Measured legacy geometry: (logo_width_ratio, centre_y_ratio)
GEO_ICON = (0.877, 0.517)   # app_icon.png
GEO_FOREGROUND = (0.835, 0.516)  # app_icon_foreground.png
GEO_SPLASH = (0.584, 0.501)  # splash_image(_dark).png


# ---------------------------------------------------------------- helpers

def hex_color(rgb: tuple[int, int, int]) -> str:
    return "#%02X%02X%02X" % rgb


def is_lime(px: tuple[int, int, int, int]) -> bool:
    """True if a pixel already looks like the brand lime dot."""
    r, g, b, _ = px
    return g > 170 and r > 140 and b < 150 and (g - b) > 60


def load_logo(source_path: str) -> Image.Image:
    """Load source artwork and return a tight-cropped RGBA logo.

    Handles two cases:
    * transparent PNG (repo Tamen_logo.png) -> use alpha directly;
    * opaque export with dark background ([Image 1]) -> key out the
      corner background colour, keep lime pixels, return RGBA.
    """
    im = Image.open(source_path).convert("RGBA")
    corner = im.getpixel((5, 5))
    if corner[3] > 200:
        # Opaque export -> estimate background from corners and key it out.
        w, h = im.size
        corners = [
            im.getpixel((5, 5)), im.getpixel((w - 6, 5)),
            im.getpixel((5, h - 6)), im.getpixel((w - 6, h - 6)),
        ]
        bg = tuple(sum(c[i] for c in corners) // 4 for i in range(3))
        print(f"source is opaque (bg ~ {hex_color(bg)}), keying out background...")
        src = im.load()
        out = Image.new("RGBA", im.size, (0, 0, 0, 0))
        dst = out.load()
        for y in range(h):
            for x in range(w):
                r, g, b, _ = src[x, y]
                diff = abs(r - bg[0]) + abs(g - bg[1]) + abs(b - bg[2])
                if diff < 30:
                    continue  # background -> transparent
                dst[x, y] = (r, g, b, 255)
        im = out
    bbox = im.getbbox()
    if not bbox:
        sys.exit(f"error: no artwork found in {source_path}")
    return im.crop(bbox)


def split_text_dot(logo: Image.Image) -> tuple[Image.Image, int]:
    """Find the transparent gap column separating the dot; return (logo, dot_x).

    dot_x is the x (in logo-local coords) where the dot starts.
    Falls back to 88% width if no clean gap exists.
    """
    w, h = logo.size
    px = logo.load()
    col_count = [0] * w
    for x in range(w):
        c = 0
        for y in range(h):
            if px[x, y][3] > 10:
                c += 1
        col_count[x] = c
    search_from = int(w * 0.70)
    best_run: tuple[int, int] | None = None
    x = search_from
    while x < w:
        if col_count[x] == 0:
            start = x
            while x < w and col_count[x] == 0:
                x += 1
            if best_run is None or (x - start) > (best_run[1] - best_run[0]):
                best_run = (start, x)
        else:
            x += 1
    if best_run and (best_run[1] - best_run[0]) >= 2:
        dot_x = best_run[1]
        print(f"dot split: transparent gap {best_run[0]}..{best_run[1]-1} "
              f"(logo width {w}), dot starts at x={dot_x}")
        return logo, dot_x
    dot_x = int(w * 0.88)
    print(f"dot split: no clean gap, falling back to x={dot_x} ({w}px wide)")
    return logo, dot_x


def recolour(logo: Image.Image, dot_x: int, text_rgb: tuple[int, int, int],
             dot_rgb: tuple[int, int, int] = LIME) -> Image.Image:
    """Paint letters -> text_rgb, dot region -> dot_rgb, preserving alpha.

    Pixels already lime (when --source is the [Image 1] export) are always
    kept as dot_rgb wherever they appear.
    """
    w, h = logo.size
    out = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    src = logo.load()
    dst = out.load()
    for y in range(h):
        for x in range(w):
            r, g, b, a = src[x, y]
            if a <= 0:
                continue
            if x >= dot_x or is_lime((r, g, b, a)):
                dst[x, y] = (dot_rgb[0], dot_rgb[1], dot_rgb[2], a)
            else:
                dst[x, y] = (text_rgb[0], text_rgb[1], text_rgb[2], a)
    return out


def compose(canvas: int, logo: Image.Image, width_ratio: float,
            cy_ratio: float, bg: tuple[int, int, int] | None) -> Image.Image:
    """Scale logo to width_ratio*canvas and centre it at cy_ratio*canvas."""
    target_w = round(canvas * width_ratio)
    scale = target_w / logo.size[0]
    target_h = max(1, round(logo.size[1] * scale))
    resized = logo.resize((target_w, target_h), Image.LANCZOS)
    if bg is None:
        out = Image.new("RGBA", (canvas, canvas), (0, 0, 0, 0))
    else:
        out = Image.new("RGBA", (canvas, canvas), bg + (255,))
    out.alpha_composite(resized, (round((canvas - target_w) / 2),
                                  round(cy_ratio * canvas - target_h / 2)))
    return out


def backup(path: str) -> None:
    bak = path + ".bak"
    if os.path.exists(path) and not os.path.exists(bak):
        shutil.copy2(path, bak)
        print(f"backup: {path} -> {bak}")


# ---------------------------------------------------------------- main

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--source", default=DEFAULT_SOURCE,
                    help="logo artwork (default: %(default)s). "
                         "May be the transparent repo logo or your "
                         "[Image 1] export with black background.")
    ap.add_argument("--out-dir", default="assets/images")
    ap.add_argument("--no-backup", action="store_true",
                    help="overwrite without writing .bak files")
    args = ap.parse_args()

    if not os.path.exists(args.source):
        sys.exit(f"error: source not found: {args.source}\n"
                 f"tip: export [Image 1] into assets/images/ and pass --source")
    os.makedirs(args.out_dir, exist_ok=True)

    print(f"source : {args.source}")
    print(f"text   : light {hex_color(LIGHT_TEXT)} / dark {hex_color(DARK_TEXT)}")
    print(f"dot    : {hex_color(LIME)} (both moods)")
    print(f"bg     : light {hex_color(LIGHT_BG)} / dark {hex_color(DARK_BG)}")

    base = load_logo(args.source)
    print(f"logo crop: {base.size[0]}x{base.size[1]}")
    base, dot_x = split_text_dot(base)

    light_logo = recolour(base, dot_x, LIGHT_TEXT, LIME)
    dark_logo = recolour(base, dot_x, DARK_TEXT, LIME)

    # Full-res reference logos (same 1254-box as Tamen_logo.png).
    ref_light = Image.new("RGBA", (1254, 1254), (0, 0, 0, 0))
    ref_dark = Image.new("RGBA", (1254, 1254), (0, 0, 0, 0))
    ref_light.alpha_composite(
        light_logo, ((1254 - light_logo.size[0]) // 2,
                     (1254 - light_logo.size[1]) // 2))
    ref_dark.alpha_composite(
        dark_logo, ((1254 - dark_logo.size[0]) // 2,
                    (1254 - dark_logo.size[1]) // 2))

    targets: dict[str, Image.Image] = {
        "app_icon.png": compose(CANVAS, light_logo, *GEO_ICON, LIGHT_BG),
        # RGB, no alpha (matches previous app_icon.png + remove_alpha_ios).
        "app_icon_dark.png": compose(CANVAS, dark_logo, *GEO_ICON, DARK_BG),
        "app_icon_foreground.png":
            compose(CANVAS, light_logo, *GEO_FOREGROUND, None),
        "app_icon_foreground_dark.png":
            compose(CANVAS, dark_logo, *GEO_FOREGROUND, None),
        "splash_image.png": compose(CANVAS, light_logo, *GEO_SPLASH, None),
        "splash_image_dark.png": compose(CANVAS, dark_logo, *GEO_SPLASH, None),
        "Tamen_logo_lime_light.png": ref_light,
        "Tamen_logo_lime_dark.png": ref_dark,
    }

    for name, img in targets.items():
        path = os.path.join(args.out_dir, name)
        if not args.no_backup:
            backup(path)
        if name == "app_icon.png":
            img.convert("RGB").save(path, "PNG")
        else:
            img.save(path, "PNG")
        print(f"wrote  : {path}  {img.size[0]}x{img.size[1]} {img.mode}")

    print("\nDone. Next steps:")
    print("  dart run flutter_launcher_icons")
    print("  dart run flutter_native_splash:create")
    print("pubspec already points at app_icon.png / splash_image(_dark).png;")
    print("wire app_icon_dark.png only if you add a night launcher icon.")


if __name__ == "__main__":
    main()
