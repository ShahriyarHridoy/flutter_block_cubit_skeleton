part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordLoading extends ResetPasswordState {}
class ResetPasswordSuccess extends ResetPasswordState {
  final ResetPasswordResponse model;

  const ResetPasswordSuccess({
    required this.model,
  });}
class ResetPasswordFailure extends ResetPasswordState {
  final StackTrace stackTrace;
  final Object exception;

  const ResetPasswordFailure(this.exception, this.stackTrace);
}
