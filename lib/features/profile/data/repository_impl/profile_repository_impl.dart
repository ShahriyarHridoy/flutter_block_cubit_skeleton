import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/remote/profile_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ConnectionChecker _connectionChecker;
  final ProfileRemote profileRemote;

  ProfileRepositoryImpl(this._connectionChecker, this.profileRemote);

  @override
  Future<ProfileResponse> profile() async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    ProfileResponse profileResponse = await profileRemote.profile();

    return profileResponse;
  }
}
