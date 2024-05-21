part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileResponse profileResponse;
  const ProfileSuccess({required this.profileResponse});
}

class ProfileFailure extends ProfileState {
  final StackTrace stackTrace;

  // final ProfileResponse profileResponse;
  final Object exception;

  const ProfileFailure(this.exception, this.stackTrace,);
}
