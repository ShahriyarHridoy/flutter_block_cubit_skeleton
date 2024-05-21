import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/token_source.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_request.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/remote/update_profile_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/domain/repository/update_profile_repository.dart';

class UpdateProfileRepositoryImpl implements UpdateProfileRepository {
  final ConnectionChecker _connectionChecker;
  final UpdateProfileRemote updateProfileRemote;
  final TokenSource tokenSource;

  UpdateProfileRepositoryImpl(
      this._connectionChecker, this.updateProfileRemote, this.tokenSource);

  @override
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    UpdateProfileResponse updateProfileResponse =
        await updateProfileRemote.updateProfile(updateProfileRequest);
    // await tokenSource.saveToken(updateProfileResponse.accessToken!);

    return updateProfileResponse;
  }
}
