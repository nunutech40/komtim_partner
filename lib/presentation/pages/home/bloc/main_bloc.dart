import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/do_logout_use_case.dart';
import 'package:komtim_partner/domain/usecases/get_auth_state_use_case.dart';
import 'package:komtim_partner/domain/usecases/get_profile_use_case.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/enum_status.dart';
import '../../../../common/failure.dart';
import '../../../../domain/entities/profile_model.dart';

part 'main_state.dart';
part 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required this.doLogoutUseCase, required this.getProfileUseCase})
      : super(const MainState()) {
    on<MainPageDidload>(_handleDidLoadMainPage);
    on<LogoutButtonPressedEvent>(_handleButtonLogout);
  }

  final DoLogoutUseCase doLogoutUseCase;
  final GetProfileUseCase getProfileUseCase;

  Future<void> _handleDidLoadMainPage(
    MainPageDidload event,
    Emitter<MainState> emit,
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

  void _handleFailure(Emitter<MainState> emit, Failure failure) {
    emit(state.copyWith(
        message: failure.message, status: RequestStatus.failure));
  }

  Future<void> _handleButtonLogout(
    LogoutButtonPressedEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await doLogoutUseCase.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
            message: failure.message, status: RequestStatus.failure));
      },
      (logoutData) {
        emit(state.copyWith(
            message: 'Success',
            status: RequestStatus.success,
            profileData: null)); // Reset profile data on logout
      },
    );
  }
}
