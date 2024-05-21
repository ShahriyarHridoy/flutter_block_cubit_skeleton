import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/domain/repository/reset_password_repository.dart';

class ResetPasswordUsecase {
  final ResetPasswordRepository _resetPasswordRepository;

  ResetPasswordUsecase(this._resetPasswordRepository);

  Future<ResetPasswordResponse> call(
          ResetPasswordRequest resetPasswordRequest) =>
      _resetPasswordRepository.resetPassword(resetPasswordRequest);
}
