import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_response.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
}
