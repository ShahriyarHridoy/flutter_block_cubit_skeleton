part of 'check_otp_cubit.dart';

abstract class CheckOtpState extends Equatable {
  const CheckOtpState();

  @override
  List<Object> get props => [];
}

class CheckOtpInitial extends CheckOtpState {}
class CheckOtpLoading extends CheckOtpState {}
class CheckOtpSuccess extends CheckOtpState {
  final CheckOtpResponse model;

  const CheckOtpSuccess({
    required this.model,
  });}
class CheckOtpFailure extends CheckOtpState {
  final StackTrace stackTrace;
  final Object exception;

  const CheckOtpFailure(this.exception, this.stackTrace);
}
