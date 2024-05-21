part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}
class ChangePasswordLoading extends ChangePasswordState {}
class ChangePasswordSuccess extends ChangePasswordState {
  final ChangePasswordResponse model;

  const ChangePasswordSuccess({
    required this.model,
  });}
class ChangePasswordFailure extends ChangePasswordState {
  final StackTrace stackTrace;
  final Object exception;

  const ChangePasswordFailure(this.exception, this.stackTrace);
}
