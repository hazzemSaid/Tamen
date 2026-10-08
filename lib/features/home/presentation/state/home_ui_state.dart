import 'package:equatable/equatable.dart';

import '../../models/home_trip_models.dart';

/// Home screen states.
sealed class HomeUiState extends Equatable {
  const HomeUiState();

  @override
  List<Object?> get props => [];
}

/// Loading state.
class HomeLoading extends HomeUiState {
  const HomeLoading();
}

/// Empty state (no active trip).
class HomeEmpty extends HomeUiState {
  final List<RecentTripUi> recents;

  const HomeEmpty({this.recents = const []});

  @override
  List<Object?> get props => [recents];
}

/// Has-trip state (ongoing trip).
class HomeHasTrip extends HomeUiState {
  final ActiveTripUi active;
  final List<RecentTripUi> recents;

  const HomeHasTrip({required this.active, this.recents = const []});

  @override
  List<Object?> get props => [active, recents];
}

/// Failure state with retry.
class HomeFailure extends HomeUiState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
