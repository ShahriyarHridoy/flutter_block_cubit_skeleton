import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_request.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/domain/repository/update_profile_repository.dart';

class UpdateProfileUsecase {
  final UpdateProfileRepository _updateProfileRepository;

  UpdateProfileUsecase(this._updateProfileRepository);

  Future<UpdateProfileResponse> call(
          UpdateProfileRequest updateProfileRequest) =>
      _updateProfileRepository.updateProfile(updateProfileRequest);
}
