import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_response.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/domain/usecase/refresh_tocken_usecase.dart';

part 'refresh_tocken_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  final RefreshTokenUsecase refreshTokenUsecase;

  RefreshTokenCubit({required this.refreshTokenUsecase})
      : super(RefreshTokenInitial());

  Future<void> refreshToken(RefreshTokenRequest refreshTokenRequest) async {
    try {
      emit(RefreshTokenLoading());
      final responseModel = await refreshTokenUsecase(refreshTokenRequest);
      emit(RefreshTokenSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(RefreshTokenFailure(ex, strackTrace));
    }
  }
}
