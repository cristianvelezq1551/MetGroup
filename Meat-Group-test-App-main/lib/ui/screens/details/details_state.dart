abstract class DetailsStates {}

/// Initial State
class DetailsInitialState extends DetailsStates {}

/// Loading State
class DetailsLoadingState extends DetailsStates {}

/// Loaded State
class DetailsSuccessState extends DetailsStates {}

/// Error State
class DetailsErrorState extends DetailsStates {
  final String message;
  DetailsErrorState({required this.message});
}
