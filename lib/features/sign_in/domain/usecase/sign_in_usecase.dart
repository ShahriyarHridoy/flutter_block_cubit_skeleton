import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_response.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/domain/repository/sign_in_repository.dart';

class SignInUsecase {
  final SignInRepository _signInRepository;

  SignInUsecase(this._signInRepository);

  Future<SignInResponse> call(SignInRequest signInRequest) =>
      _signInRepository.signin(signInRequest);
}
