part of 'sign_in_cubit.dart';

abstract class SignInApiState extends Equatable {
  const SignInApiState();

  @override
  List<Object> get props => [];
}

class SignInApiInitial extends SignInApiState {}

class SignInLoading extends SignInApiState {}

class SignInFailed extends SignInApiState {
  final StackTrace stackTrace;
  final Object exception;

  const SignInFailed(this.exception, this.stackTrace);
}

class SignInSucceed extends SignInApiState {
  final SignInResponse model;

  const SignInSucceed({
    required this.model,
  });
}
