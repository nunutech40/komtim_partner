part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({
    this.message = '',
    this.status = RequestStatus.loading,
  });

  final String message;
  final RequestStatus status;

  MainState copyWith({
    RequestStatus? status,
    String? message,
  }) {
    return MainState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
      ];
}
