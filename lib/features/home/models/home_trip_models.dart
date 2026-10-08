import 'package:equatable/equatable.dart';

/// Ongoing-trip hero card data.
class ActiveTripUi extends Equatable {
  final String title;
  final String statusLine;
  final double progress;
  final String etaLabel;
  final String updatedLabel;
  final String sharedWithLabel;

  const ActiveTripUi({
    required this.title,
    required this.statusLine,
    required this.progress,
    required this.etaLabel,
    required this.updatedLabel,
    required this.sharedWithLabel,
  }) : assert(progress >= 0 && progress <= 1, 'progress must be 0..1');

  @override
  List<Object?> get props => [
        title,
        statusLine,
        progress,
        etaLabel,
        updatedLabel,
        sharedWithLabel,
      ];
}

/// One recent-trip row data.
class RecentTripUi extends Equatable {
  final String id;
  final String title;
  final String statusLabel;
  final String dateLabel;

  const RecentTripUi({
    required this.id,
    required this.title,
    required this.statusLabel,
    required this.dateLabel,
  });

  @override
  List<Object?> get props => [id, title, statusLabel, dateLabel];
}
