import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/common/cubit/locale/locale_cubit.dart';
import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/locale_source.dart';
import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/token_source.dart';
import 'package:flutter_block_cubit_skeleton/common/data/repository_impl/locale_repo_impl.dart';
import 'package:flutter_block_cubit_skeleton/common/domain/repository/locale_repository.dart';
import 'package:flutter_block_cubit_skeleton/common/domain/usecase/locale_usecase.dart';
import 'package:flutter_block_cubit_skeleton/common/response_handler/response_handler.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/remote/change_password_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/repository_impl/change_password_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/domain/repository/change_password_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/domain/usecase/change_password_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/remote/check_otp_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/repository_impl/check_otp_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/domain/repository/check_otp_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/domain/usecase/check_otp_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/presentation/cubit/check_otp_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/remote/reset_password_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/repository_impl/reset_password_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/domain/repository/reset_password_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/domain/usecase/reset_password_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/remote/send_otp_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/repository_impl/send_otp_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/domain/repository/send_otp_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/domain/usecase/send_otp_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/presentation/cubit/send_otp_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/remote/profile_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/domain/usecase/profile_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/presentation/cubit/courier_update/profile_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/remote/refresh_tocken_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/repository_impl/refresh_tocken_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/domain/repository/refresh_tocken_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/domain/usecase/refresh_tocken_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/presentation/cubit/refresh_tocken_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/remote/sign_in_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/repository_impl/sign_in_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/domain/repository/sign_in_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/domain/usecase/sign_in_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/presentation/cubit/sign_in_cubit/cubit/sign_in_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/remote/sign_up_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/repository_impl/sign_up_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/remote/update_profile_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/repository_impl/update_profile_repository_impl.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/domain/repository/update_profile_repository.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/domain/usecase/update_profile_usecase.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/presentation/cubit/update_profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/otp_validate/data/remote/otp_validate_remote.dart';
import '../../features/otp_validate/data/repository_impl/otp_validate_repository_impl.dart';
import '../../features/otp_validate/domain/repository/otp_validate_repository.dart';
import '../../features/otp_validate/domain/usecase/otp_validate_usecase.dart';
import '../../features/otp_validate/presentation/cubit/otp_validate_cubit.dart';

// import '../../features/division_list/presentation/cubit/division_list_cubit.dart';

class Dependency {
  static final sl = GetIt.instance;

  Dependency._init();

  static Future<void> init() async {
//-------------------------------------------------------//
    sl.registerLazySingleton<LocaleSource>(() => LocaleSourceImpl(sl()));

    sl.registerLazySingleton<LocaleRepository>(
        () => LocaleRepositoryImpl(sl()));
    sl.registerLazySingleton(() => ReadLocaleUsecase(sl()));
    sl.registerLazySingleton(() => SaveLocaleUsecase(sl()));
    sl.registerLazySingleton(() => LocaleCubit(
          readLocaleUsecase: sl(),
          saveLocaleUsecase: sl(),
        ));
    final sharedPref = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPref);
    sl.registerLazySingleton(() => Client());

//---------------------------------------------------------//

    sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(),
    );
    sl.registerLazySingleton<TokenSource>(() => TokenSourceImpl(sl()));
    sl.registerLazySingleton<HeaderProvider>(() => HeaderProviderImpl());

    sl.registerLazySingleton(() => AuthHeaderProvider(sl()));
    // sl.registerLazySingleton<HeaderProviderAuth>(
    //     () => HeaderProviderImplAuth());

    // sl.registerLazySingleton(() => AuthHeaderProviderToken(sl()));

    sl.registerLazySingleton<ResponseHandler>(() => ResponseHandlerImpl());

//---------------------------Sign In Start-------------------------------//

    sl.registerLazySingleton<SignInRemote>(
      () => SignInRemoteImpl(sl()),
    );

    sl.registerLazySingleton<SignInRepository>(
      () => SignInRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => SignInUsecase(sl()));
    sl.registerFactory(() => SignInApiCubit(signInUsecase: sl()));

//---------------------------Sign In End-------------------------------//

//---------------------------Sign Up Start-------------------------------//

    sl.registerLazySingleton<SignUpRemote>(
      () => SignUpRemoteImpl(sl()),
    );

    sl.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => SignUpUsecase(sl()));
    sl.registerFactory(() => SignUpCubit(signUpUsecase: sl()));

//---------------------------Sign Up End-------------------------------//
//---------------------------Profile Start-------------------------------//

    sl.registerLazySingleton<ProfileRemote>(
      () => ProfileRemoteImpl(
        sl<AuthHeaderProvider>(),
      ),
    );

    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        sl(),
        sl(),
        // sl(),
      ),
    );
    sl.registerLazySingleton(() => ProfileUsecase(sl()));
    sl.registerFactory(() => ProfileCubit(profileUsecase: sl()));

//---------------------------Profile End-------------------------------//
//---------------------------UpdateProfile Start-------------------------------//

    sl.registerLazySingleton<UpdateProfileRemote>(
      () => UpdateProfileRemoteImpl(sl<AuthHeaderProvider>()),
    );

    sl.registerLazySingleton<UpdateProfileRepository>(
      () => UpdateProfileRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => UpdateProfileUsecase(sl()));
    sl.registerFactory(() => UpdateProfileCubit(updateProfileUsecase: sl()));

//---------------------------UpdateProfile End-------------------------------//

    //---------------------------Refresh Token-------------------------------//

    sl.registerLazySingleton<RefreshTokenRemote>(
      () => RefreshTokenRemoteImpl(sl<AuthHeaderProvider>()),
    );

    sl.registerLazySingleton<RefreshTokenRepository>(
      () => RefreshTokenRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => RefreshTokenUsecase(sl()));
    sl.registerFactory(() => RefreshTokenCubit(refreshTokenUsecase: sl()));

//---------------------------Refresh Token-------------------------------//

//---------------------------SendOtp Start-------------------------------//

    sl.registerLazySingleton<SendOtpRemote>(
      () => SendOtpRemoteImpl(sl<AuthHeaderProvider>()),
    );

    sl.registerLazySingleton<SendOtpRepository>(
      () => SendOtpRepositoryImpl(
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => SendOtpUsecase(sl()));
    sl.registerFactory(() => SendOtpCubit(sendOtpUsecase: sl()));

//---------------------------SendOtp End-------------------------------//
//---------------------------CheckOtp Start-------------------------------//

    sl.registerLazySingleton<CheckOtpRemote>(
      () => CheckOtpRemoteImpl(sl()),
    );

    sl.registerLazySingleton<CheckOtpRepository>(
      () => CheckOtpRepositoryImpl(
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => CheckOtpUsecase(sl()));
    sl.registerFactory(() => CheckOtpCubit(checkOtpUsecase: sl()));

//---------------------------CheckOtp End-------------------------------//

// ---------------------------OtpValidate Start-------------------------------//

    sl.registerLazySingleton<OtpValidateRemote>(
      () => OtpValidateRemoteImpl(sl()),
    );

    sl.registerLazySingleton<OtpValidateRepository>(
      () => OtpValidateRepositoryImpl(
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => OtpValidateUsecase(sl()));
    sl.registerFactory(() => OtpValidateCubit(otpValidateUsecase: sl()));

//---------------------------OtpValidate End-------------------------------//
//---------------------------ResetPassword Start-------------------------------//

    sl.registerLazySingleton<ResetPasswordRemote>(
      () => ResetPasswordRemoteImpl(sl()),
    );

    sl.registerLazySingleton<ResetPasswordRepository>(
      () => ResetPasswordRepositoryImpl(
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
    sl.registerFactory(() => ResetPasswordCubit(resetPasswordUsecase: sl()));

//---------------------------ResetPassword End-------------------------------//

//---------------------------ChangePassword Start-------------------------------//

    sl.registerLazySingleton<ChangePasswordRemote>(
      () => ChangePasswordRemoteImpl(sl<AuthHeaderProvider>()),
    );

    sl.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => ChangePasswordUsecase(sl()));
    sl.registerFactory(() => ChangePasswordCubit(changePasswordUsecase: sl()));

//---------------------------ChangePassword End-------------------------------//
  }

  static final providers = <BlocProvider>[
    BlocProvider<LocaleCubit>(
      create: (context) => Dependency.sl<LocaleCubit>(),
    ),
//----------------------------------------------------------------//
    BlocProvider<SignInApiCubit>(
      create: (context) => Dependency.sl<SignInApiCubit>(),
    ),
    BlocProvider<SignUpCubit>(
      create: (context) => Dependency.sl<SignUpCubit>(),
    ),
    BlocProvider<ProfileCubit>(
      create: (context) => Dependency.sl<ProfileCubit>(),
    ),
    BlocProvider<UpdateProfileCubit>(
      create: (context) => Dependency.sl<UpdateProfileCubit>(),
    ),
    BlocProvider<RefreshTokenCubit>(
      create: (context) => Dependency.sl<RefreshTokenCubit>(),
    ),

    BlocProvider<SendOtpCubit>(
      create: (context) => Dependency.sl<SendOtpCubit>(),
    ),
    BlocProvider<CheckOtpCubit>(
      create: (context) => Dependency.sl<CheckOtpCubit>(),
    ),
    BlocProvider<OtpValidateCubit>(
      create: (context) => Dependency.sl<OtpValidateCubit>(),
    ),
    BlocProvider<ResetPasswordCubit>(
      create: (context) => Dependency.sl<ResetPasswordCubit>(),
    ),

    BlocProvider<ChangePasswordCubit>(
      create: (context) => Dependency.sl<ChangePasswordCubit>(),
    ),
  ];
}
