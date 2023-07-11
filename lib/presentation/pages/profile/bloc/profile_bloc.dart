import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/get_profile_use_case.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:komtim_partner/common/enum_status.dart';
import 'package:komtim_partner/domain/entities/profile_model.dart';

import '../../../../common/enum_status.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.getProfileUseCase}) : super(const ProfileState()) {
    on<ProfilePageDidload>(_handleDidLoadPage);
    on<SaveButtonPressedEvent>(_handleButtonSaveProfile);
  }

  final GetProfileUseCase getProfileUseCase;

  Future<void> _handleDidLoadPage(
    ProfilePageDidload event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final profileResult = await getProfileUseCase.execute();

    profileResult.fold(
      (failure) {
        emit(state.copyWith(
            message: failure.message, status: RequestStatus.failure));
      },
      (profileData) {
        emit(state.copyWith(
            message: 'Success',
            status: RequestStatus.success,
            profileData: profileData));
      },
    );
  }

  Future<void> _handleButtonSaveProfile(
    SaveButtonPressedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));
  }
}
