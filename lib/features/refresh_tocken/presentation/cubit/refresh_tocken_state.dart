part of 'refresh_tocken_cubit.dart';

abstract class RefreshTokenState extends Equatable {
  const RefreshTokenState();

  @override
  List<Object> get props => [];
}

class RefreshTokenInitial extends RefreshTokenState {}
class RefreshTokenLoading extends RefreshTokenState {}
class RefreshTokenSuccess extends RefreshTokenState {
  final RefreshTokenResponse model;

  const RefreshTokenSuccess({
    required this.model,
  });}
class RefreshTokenFailure extends RefreshTokenState {
  final StackTrace stackTrace;
  final Object exception;

  const RefreshTokenFailure(this.exception, this.stackTrace);
}
