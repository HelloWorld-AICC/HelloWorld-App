// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'auth/application/login_bloc.dart' as _i317;
import 'auth/domain/repository/i_auth_repository.dart' as _i667;
import 'auth/domain/repository/i_token_repository.dart' as _i658;
import 'auth/infrastructure/provider/auth_external_provider.dart' as _i914;
import 'auth/infrastructure/provider/auth_internal_provider.dart' as _i877;
import 'auth/infrastructure/provider/auth_local_provider.dart' as _i350;
import 'auth/infrastructure/provider/interface/i_auth_external_provider.dart'
    as _i141;
import 'auth/infrastructure/provider/interface/i_auth_internal_provider.dart'
    as _i5;
import 'auth/infrastructure/provider/interface/i_auth_local_provider.dart'
    as _i690;
import 'auth/infrastructure/repository/auth_repository.dart' as _i217;
import 'auth/infrastructure/repository/token_repository.dart' as _i782;
import 'fetch/authenticated_http_client.dart' as _i30;
import 'fetch/fetch_service.dart' as _i1053;
import 'home/application/home_bloc.dart' as _i785;
import 'local_storage/local_storage_service.dart' as _i187;
import 'toast/toast_bloc.dart' as _i301;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i187.LocalStorageService>(() => _i187.LocalStorageService());
    gh.singleton<_i301.ToastBloc>(() => _i301.ToastBloc());
    gh.lazySingleton<_i141.IAuthExternalProvider>(
        () => _i914.AuthExternalProvider());
    gh.lazySingleton<_i690.IAuthLocalProvider>(
        () => _i350.AuthLocalProvier(service: gh<_i187.LocalStorageService>()));
    gh.lazySingleton<_i658.ITokenRepository>(() => _i782.TokenRepository(
        authLocalProvider: gh<_i690.IAuthLocalProvider>()));
    gh.lazySingleton<_i785.HomeBloc>(
        () => _i785.HomeBloc(tokenRepository: gh<_i658.ITokenRepository>()));
    gh.lazySingleton<_i30.AuthenticatedHttpClient>(() =>
        _i30.AuthenticatedHttpClient(
            tokenRepository: gh<_i658.ITokenRepository>()));
    gh.singleton<_i1053.FetchService>(
        () => _i1053.FetchService(client: gh<_i30.AuthenticatedHttpClient>()));
    gh.lazySingleton<_i5.IAuthInternalProvider>(
        () => _i877.AuthInternalProvider(gh<_i1053.FetchService>()));
    gh.lazySingleton<_i667.IAuthRepository>(() => _i217.AuthRepository(
          authExternalProvider: gh<_i141.IAuthExternalProvider>(),
          authInternalProvider: gh<_i5.IAuthInternalProvider>(),
          authLocalProvider: gh<_i690.IAuthLocalProvider>(),
        ));
    gh.lazySingleton<_i317.LoginBloc>(
        () => _i317.LoginBloc(authRepository: gh<_i667.IAuthRepository>()));
    return this;
  }
}
