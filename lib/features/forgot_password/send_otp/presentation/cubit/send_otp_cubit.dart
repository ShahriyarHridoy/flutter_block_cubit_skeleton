import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/domain/usecase/send_otp_usecase.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  final SendOtpUsecase sendOtpUsecase;

  SendOtpCubit({required this.sendOtpUsecase}) : super(SendOtpInitial());

  Future<void> sendOtp(SendOtpRequest sendOtpRequest) async {
    try {
      emit(SendOtpLoading());
      final responseModel = await sendOtpUsecase(sendOtpRequest);
      emit(SendOtpSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(SendOtpFailure(ex, strackTrace));
    }
  }
}
