import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_request.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_response.dart';

abstract class UpdateProfileRepository {
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest updateProfileRequest);
}
