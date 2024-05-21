part of 'send_otp_cubit.dart';

abstract class SendOtpState extends Equatable {
  const SendOtpState();

  @override
  List<Object> get props => [];
}

class SendOtpInitial extends SendOtpState {}
class SendOtpLoading extends SendOtpState {}
class SendOtpSuccess extends SendOtpState {
  final SendOtpResponse model;

  const SendOtpSuccess({
    required this.model,
  });}
class SendOtpFailure extends SendOtpState {
  final StackTrace stackTrace;
  final Object exception;

  const SendOtpFailure(this.exception, this.stackTrace);
}
