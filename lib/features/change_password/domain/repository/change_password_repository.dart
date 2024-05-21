import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_response.dart';

abstract class ChangePasswordRepository {
  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest);
}
