import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';

abstract class ProfileRepository {
  Future<ProfileResponse> profile();
}
