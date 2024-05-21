import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/presentation/cubit/refresh_tocken_cubit.dart';

final refreshTokenRequest = RefreshTokenRequest(refreshToken: "");

Future<void> callRefreshToken(BuildContext context) async {
  // Replace with your actual request object

  await BlocProvider.of<RefreshTokenCubit>(context)
      .refreshToken(refreshTokenRequest);
}
