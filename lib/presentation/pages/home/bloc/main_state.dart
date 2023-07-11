part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({
    this.message = '',
    this.status = RequestStatus.empty,
    this.profileData,
  });

  final String message;
  final RequestStatus status;
  final ProfileModel? profileData;

  MainState copyWith({
    RequestStatus? status,
    String? message,
    ProfileModel? profileData,
  }) {
    return MainState(
      status: status ?? this.status,
      message: message ?? this.message,
      profileData: profileData ?? this.profileData,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        profileData,
      ];
}
