import 'package:equatable/equatable.dart';
import 'package:komtim_partner/domain/usecases/do_logout_use_case.dart';
import 'package:komtim_partner/domain/usecases/get_auth_state_use_case.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/enum_status.dart';

part 'main_state.dart';
part 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required this.getAuthStateUseCase, required this.doLogoutUseCase})
      : super(const MainState()) {
    on<MainPageDidload>(_handleDidLoadMainPage);
    on<LogoutButtonPressedEvent>(_handleButtonLogout);
  }

  final GetAuthStateUseCase getAuthStateUseCase;
  final DoLogoutUseCase doLogoutUseCase;

  Future<void> _handleDidLoadMainPage(
    MainPageDidload event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await getAuthStateUseCase.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
            message: failure.message, status: RequestStatus.failure));
      },
      (loginData) {
        emit(state.copyWith(message: 'Success', status: RequestStatus.success));
      },
    );
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
      (loginData) {
        emit(state.copyWith(message: 'Success', status: RequestStatus.success));
      },
    );
  }
}
