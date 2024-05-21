// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/common/exception_handle.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_loading.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
// import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
// import 'package:flutter_block_cubit_skeleton/core/utils/lang/app_localizations.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/presentation/cubit/courier_update/profile_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/presentation/widget/profile_widget.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/presentation/cubit/refresh_tocken_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:agent_app/features/reciever_information_request_for_courier/presentation/screen/reciever_info_request_for_courier_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(refreshToken: "");

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getRefreshToken();
    // refreshTokenRequest.refreshToken=refreshToken.toString();
    // print("refreshTokenRequest.refreshToken=refreshToken.toString():::${refreshTokenRequest.refreshToken=refreshToken.toString()}");
    profile();
  }

  profile() async {
    await BlocProvider.of<ProfileCubit>(context).profile();
  }

  callRefreshToken() async {
    await BlocProvider.of<RefreshTokenCubit>(context)
        .refreshToken(refreshTokenRequest);
  }

  String refreshToken = "";

  getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      getrefreshToken = sharedPreferences.getString("refreshToken")!;
      log("sharedPreferences.getString(refreshToken) :::${sharedPreferences.getString("refreshToken")}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
      log("refreshToken shared preference: $getrefreshToken\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    });
  }

  String? accessToken;
  String getrefreshToken = "";
  String name = "";
  String email = "";

  saveAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('accessToken', accessToken!);
  }

  saveRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('refreshToken', refreshToken);
  }

  @override
  Widget build(BuildContext context) {
    // final locale = AppLocalizations.of(context).locale.languageCode;
    // isLangBangla = locale.contains('bn');

    return BlocListener<RefreshTokenCubit, RefreshTokenState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is RefreshTokenLoading) {
          log("in RefreshTokenLoading\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
          showAppLoading(context);
          Navigator.pop(context);
        } else if (state is RefreshTokenFailure) {
          // Navigator.pop(context);
          log("in RefreshTokenFailure\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
        } else if (state is RefreshTokenSuccess) {
          log("in RefreshTokenSuccess\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
          final responseModel = state.model;
          log("RefreshTokenSuccess:: ${json.encode(responseModel)}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

          refreshToken = responseModel.data!.refreshToken!;
          accessToken = responseModel.data!.accessToken!;
          // name = responseModel.fullName.toString();
          saveAccessToken();
          saveRefreshToken();
          print(
              "access tocken: $accessToken\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
          print(
              "refreshToken : $refreshToken\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
          profile();
          // Navigator.pushNamed(context, RouteName.profile);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (ctx, ProfileState state) {
        switch (state.runtimeType) {
          case ProfileSuccess:
            print("ProfileSuccess");
            ProfileResponse profileData =
                (state as ProfileSuccess).profileResponse;

            return ProfileWidget(
              profileData: profileData,
            );
          case ProfileLoading:
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: Colors.white.withOpacity(0.5),
                size: 50,
              ),
            );
          case ProfileFailure:
            final ex = (state as ProfileFailure).exception;
            if (ex is ServerException) {
              if (ex.statusCode == 401) {
                // getRefreshToken();
                print("in 401 screen");
                refreshTokenRequest.refreshToken = getrefreshToken;
                print(
                    "refreshTokenRequest.refreshToken=getrefreshToken:${refreshTokenRequest.refreshToken = getrefreshToken}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
                callRefreshToken();
              }
              return Text(ex.message.toString());
            } else {
              ExceptionHandle(context);
              return Center(
                  child: Text(
                      "Something Went Wrong, Please check your internet connection first"));
            }
          default:
            return Center(child: Text("Something Went Wrong; try again"));
        }
      }),
    );
  }
}
