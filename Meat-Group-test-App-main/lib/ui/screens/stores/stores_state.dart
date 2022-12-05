abstract class StoresStates {}

/// Initial State
class StoresInitialState extends StoresStates {}

/// Loading State
class StoresLoadingState extends StoresStates {}

///Loading events
class StoresLoadingEventState extends StoresStates {}

/// Loaded State
class StoresSuccessState extends StoresStates {}

/// Loaded State
class StoresSuccessEventState extends StoresStates {}

/// Error State
class StoresErrorState extends StoresStates {
  final String message;
  StoresErrorState({required this.message});
}

/// Error event State
class StoresErrorEventState extends StoresStates {
  final String message;
  StoresErrorEventState({required this.message});
}
