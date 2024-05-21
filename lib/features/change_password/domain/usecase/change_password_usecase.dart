import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_response.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/domain/repository/change_password_repository.dart';

class ChangePasswordUsecase {
  final ChangePasswordRepository _changePasswordRepository;

  ChangePasswordUsecase(this._changePasswordRepository);

  Future<ChangePasswordResponse> call(
          ChangePasswordRequest changePasswordRequest) =>
      _changePasswordRepository.changePassword(changePasswordRequest);
}
