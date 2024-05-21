import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_response.dart';

abstract class SignInRepository {
  Future<SignInResponse> signin(SignInRequest signInRequest);
}
