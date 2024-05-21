part of 'otp_validate_cubit.dart';

abstract class OtpValidateState extends Equatable {
  const OtpValidateState();

  @override
  List<Object> get props => [];
}

class OtpValidateInitial extends OtpValidateState {}

class OtpValidateLoading extends OtpValidateState {}

class OtpValidateSuccess extends OtpValidateState {
  final CheckOtpResponse model;

  const OtpValidateSuccess({
    required this.model,
  });
}

class OtpValidateFailure extends OtpValidateState {
  final StackTrace stackTrace;
  final Object exception;

  const OtpValidateFailure(this.exception, this.stackTrace);
}
