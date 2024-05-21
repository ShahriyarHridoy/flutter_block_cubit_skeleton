import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/domain/usecase/profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase profileUsecase;

  ProfileCubit({required this.profileUsecase}) : super(ProfileInitial());

  Future<void> profile() async {
    try {
      log('try');
      emit(ProfileLoading());
      final responseModel = await profileUsecase();
      emit(ProfileSuccess(profileResponse: responseModel));
    } catch (ex, stackTrace) {
      emit(ProfileFailure(ex, stackTrace));
    }
  }
}
