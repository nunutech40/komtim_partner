part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent();
  @override
  List<Object?> get props => [];
}

class MainPageDidload extends MainEvent {
  const MainPageDidload();
}
