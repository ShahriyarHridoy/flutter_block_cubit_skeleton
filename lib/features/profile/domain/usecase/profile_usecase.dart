import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/domain/repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository _profileRepository;

  ProfileUsecase(this._profileRepository);

  Future<ProfileResponse> call() => _profileRepository.profile();
}
