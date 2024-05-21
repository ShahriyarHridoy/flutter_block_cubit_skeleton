import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_response.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/domain/usecase/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInApiCubit extends Cubit<SignInApiState> {
  final SignInUsecase signInUsecase;

  SignInApiCubit({
    required this.signInUsecase,
  }) : super(SignInApiInitial());

  Future<void> signIn(SignInRequest requestModel) async {
    log("from sign in cubit:::::::${json.encode(requestModel)}");
    try {
      log("in try sign in");
      emit(SignInLoading());

      final responseModel = await signInUsecase(requestModel);

      emit(SignInSucceed(model: responseModel));
    } catch (ex, strackTrace) {
      print("exception: $ex");
      emit(SignInFailed(ex, strackTrace));
    }
  }
}
