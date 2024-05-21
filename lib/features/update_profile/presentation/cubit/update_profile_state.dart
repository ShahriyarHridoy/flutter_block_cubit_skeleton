part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}
class UpdateProfileLoading extends UpdateProfileState {}
class UpdateProfileSuccess extends UpdateProfileState {
  final UpdateProfileResponse model;

  const UpdateProfileSuccess({
    required this.model,
  });}
class UpdateProfileFailure extends UpdateProfileState {
  final StackTrace stackTrace;
  final Object exception;

  const UpdateProfileFailure(this.exception, this.stackTrace);
}
