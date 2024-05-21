import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/token_source.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_response.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/remote/sign_in_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/domain/repository/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final ConnectionChecker connectionChecker;
  final SignInRemote signInRemote;
  final TokenSource tokenSource;

  SignInRepositoryImpl(
    this.connectionChecker,
    this.signInRemote,
    this.tokenSource,
  );

  @override
  Future<SignInResponse> signin(SignInRequest signInRequest) async {
    print("in repo impl sign in");
    if (!await connectionChecker.isConnected()) throw NoInternetException();
    SignInResponse signInResponse = await signInRemote.signIn(signInRequest);

    await tokenSource.saveToken(signInResponse.data!.accessToken!);
    await tokenSource.saveRefreshToken(signInResponse.data!.refreshToken!);
    return signInResponse;
  }
}
