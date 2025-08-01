import 'package:equatable/equatable.dart';

abstract class PanditState extends Equatable {
  const PanditState();

  @override
  List<Object?> get props => []; // Fixed to 'props'

}

// Initial state
class PanditInitial extends PanditState {}

// State when loading PanditState data
class PanditLoading extends PanditState {}

// State when PanditState data is loaded
class PanditLoaded extends PanditState {
  final List<Map<String, String>> poojaTheme;
  final List<Map<String, String>> Theme;

  const PanditLoaded(this.poojaTheme,  this.Theme);

  @override
  List<Object?> get props => [poojaTheme];

}

// State for errors
class PanditLoadedError extends PanditState {
  final String message;

  const PanditLoadedError(this.message);

  @override
  List<Object?> get props => [message];
}


