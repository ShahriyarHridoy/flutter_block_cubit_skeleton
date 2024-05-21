import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_response.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/domain/usecase/sign_up_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUsecase signUpUsecase;

  SignUpCubit({required this.signUpUsecase}) : super(SignUpInitial());

  Future<void> signUp(SignUpRequest signUpRequest) async {
    try {
      emit(SignUpLoading());
      final responseModel = await signUpUsecase(signUpRequest);
      emit(SignUpSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(SignUpFailure(ex, strackTrace));
    }
  }
}
