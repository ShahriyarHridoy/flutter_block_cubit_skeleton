import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_request.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/domain/usecase/update_profile_usecase.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;

  UpdateProfileCubit({required this.updateProfileUsecase})
      : super(UpdateProfileInitial());

  Future<void> updateProfile(UpdateProfileRequest updateProfileRequest) async {
    try {
      emit(UpdateProfileLoading());
      final responseModel = await updateProfileUsecase(updateProfileRequest);
      emit(UpdateProfileSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(UpdateProfileFailure(ex, strackTrace));
    }
  }
}
