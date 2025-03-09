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
import 'auth/application/status/auth_status_bloc.dart' as _i157;
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
import 'bus/bus.dart' as _i461;
import 'center/application/center_bloc.dart' as _i552;
import 'center/domain/repository/i_center_repository.dart' as _i284;
import 'center/infrastructure/repository/center_repository.dart' as _i163;
import 'community/board/applicatioin/board_bloc.dart' as _i392;
import 'community/common/domain/repository/i_community_repository.dart'
    as _i307;
import 'community/common/infrastructure/provider/community_internal_provider.dart'
    as _i480;
import 'community/common/infrastructure/provider/interface/i_community_internal_provider.dart'
    as _i188;
import 'community/common/infrastructure/repository/community_repository.dart'
    as _i996;
import 'community/create_post/application/create_post_bloc.dart' as _i115;
import 'community/post_detail/application/post_detail_bloc.dart' as _i597;
import 'fetch/authenticated_http_client.dart' as _i30;
import 'fetch/fetch_service.dart' as _i1053;
import 'home/application/home_bloc.dart' as _i785;
import 'home/injection/home_register_module.dart' as _i443;
import 'init/application/app_init_bloc.dart' as _i775;
import 'init/application/terms_of_service/terms_of_service_bloc.dart' as _i453;
import 'init/domain/repository/init_repository.dart' as _i193;
import 'init/infrastructure/repository/i_init_repository.dart' as _i614;
import 'local_storage/local_storage_service.dart' as _i187;
import 'locale/application/locale_bloc.dart' as _i487;
import 'locale/domain/localization_service.dart' as _i121;
import 'mypage/account/application/signout_bloc.dart' as _i598;
import 'mypage/app_version/application/app_version_bloc.dart' as _i684;
import 'mypage/common/domain/repository/i_app_version_repository.dart' as _i129;
import 'mypage/common/domain/repository/i_mypage_repository.dart' as _i558;
import 'mypage/common/infrastructure/provider/app_version_local_provider.dart'
    as _i309;
import 'mypage/common/infrastructure/provider/interface/i_app_version_local_provider.dart'
    as _i842;
import 'mypage/common/infrastructure/provider/interface/i_mypage_internal_provider.dart'
    as _i897;
import 'mypage/common/infrastructure/provider/mypage_internal_provider.dart'
    as _i280;
import 'mypage/common/infrastructure/repository/app_version_repository.dart'
    as _i436;
import 'mypage/common/infrastructure/repository/mypage_repository.dart'
    as _i681;
import 'mypage/edit_profile/application/edit_profile_bloc.dart' as _i835;
import 'mypage/menu/application/mypage/mypage_bloc.dart' as _i876;
import 'mypage/withdraw/application/withdraw_bloc.dart' as _i501;
import 'new_chat/application/drawer/chat_drawer_bloc.dart' as _i810;
import 'new_chat/application/session/chat_session_bloc.dart' as _i659;
import 'new_chat/domain/service/chat_fetch_service.dart' as _i261;
import 'new_chat/domain/service/stream/streamed_chat_parse_service.dart'
    as _i58;
import 'new_chat/domain/service/stream/streamed_chat_service.dart' as _i1016;
import 'new_chat/domain/service/streamed_chat_service.dart' as _i922;
import 'new_chat/infrastructure/providers/chat_rooms_info_provider.dart'
    as _i925;
import 'new_chat/infrastructure/repository/chat_repository.dart' as _i605;
import 'new_chat/infrastructure/repository/chat_rooms_info_repository.dart'
    as _i779;
import 'route/application/route_bloc.dart' as _i1045;
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
    final homeRegisterModule = _$HomeRegisterModule();
    gh.factory<_i487.LocaleBloc>(() => _i487.LocaleBloc());
    gh.factory<_i121.LocalizationService>(() => _i121.LocalizationService());
    gh.factory<_i187.LocalStorageService>(() => _i187.LocalStorageService());
    gh.factory<_i58.StreamedChatParseService>(
        () => _i58.StreamedChatParseService());
    gh.factory<_i922.StreamedChatService>(() => _i922.StreamedChatService());
    gh.factory<_i925.ChatRoomsInfoProvider>(
        () => _i925.ChatRoomsInfoProvider());
    gh.factory<_i1045.RouteBloc>(() => _i1045.RouteBloc());
    gh.singleton<_i301.ToastBloc>(() => _i301.ToastBloc());
    gh.lazySingleton<_i461.Bus>(() => _i461.Bus());
    gh.lazySingleton<List<String>>(() => homeRegisterModule.texts);
    gh.lazySingleton<_i141.IAuthExternalProvider>(
        () => _i914.AuthExternalProvider());
    gh.lazySingleton<_i842.IAppVersionLocalProvider>(
        () => _i309.AppVersionLocalProvider());
    gh.lazySingleton<_i129.IAppVersionRepository>(() =>
        _i436.AppVersionRepository(
            appVersionProvider: gh<_i842.IAppVersionLocalProvider>()));
    gh.lazySingleton<_i690.IAuthLocalProvider>(
        () => _i350.AuthLocalProvier(service: gh<_i187.LocalStorageService>()));
    gh.lazySingleton<_i658.ITokenRepository>(() => _i782.TokenRepository(
        authLocalProvider: gh<_i690.IAuthLocalProvider>()));
    gh.factory<_i684.AppVersionBloc>(() => _i684.AppVersionBloc(
        appVersionRepository: gh<_i129.IAppVersionRepository>()));
    gh.lazySingleton<_i30.AuthenticatedHttpClient>(() =>
        _i30.AuthenticatedHttpClient(
            tokenRepository: gh<_i658.ITokenRepository>()));
    gh.factory<_i785.HomeBloc>(() => _i785.HomeBloc(
          tokenRepository: gh<_i658.ITokenRepository>(),
          bus: gh<_i461.Bus>(),
        ));
    gh.singleton<_i1053.FetchService>(
        () => _i1053.FetchService(client: gh<_i30.AuthenticatedHttpClient>()));
    gh.singleton<_i261.ChatFetchService>(() =>
        _i261.ChatFetchService(client: gh<_i30.AuthenticatedHttpClient>()));
    gh.lazySingleton<_i5.IAuthInternalProvider>(
        () => _i877.AuthInternalProvider(gh<_i1053.FetchService>()));
    gh.factory<_i779.ChatRoomsInfoRepository>(
        () => _i779.ChatRoomsInfoRepository(
              gh<_i261.ChatFetchService>(),
              gh<_i925.ChatRoomsInfoProvider>(),
            ));
    gh.factory<_i605.ChatRepository>(
        () => _i605.ChatRepository(gh<_i261.ChatFetchService>()));
    gh.lazySingleton<_i284.ICenterRepository>(
        () => _i163.CenterRepository(gh<_i1053.FetchService>()));
    gh.lazySingleton<_i667.IAuthRepository>(() => _i217.AuthRepository(
          authExternalProvider: gh<_i141.IAuthExternalProvider>(),
          authInternalProvider: gh<_i5.IAuthInternalProvider>(),
          authLocalProvider: gh<_i690.IAuthLocalProvider>(),
        ));
    gh.factory<_i1016.StreamedChatService>(() => _i1016.StreamedChatService(
          fetchService: gh<_i261.ChatFetchService>(),
          parseService: gh<_i58.StreamedChatParseService>(),
        ));
    gh.lazySingleton<_i188.ICommunityInternalProvider>(
        () => _i480.CommunityInternalProvider(gh<_i1053.FetchService>()));
    gh.lazySingleton<_i897.IMypageInternalProvider>(
        () => _i280.MypageInternalProvider(gh<_i1053.FetchService>()));
    gh.lazySingleton<_i558.IMypageRepository>(() => _i681.MypageRepository(
        mypageProvider: gh<_i897.IMypageInternalProvider>()));
    gh.lazySingleton<_i614.IInitRepository>(() => _i193.InitRepository(
          gh<_i1053.FetchService>(),
          gh<_i261.ChatFetchService>(),
        ));
    gh.lazySingleton<_i307.ICommunityRepository>(() =>
        _i996.CommunityRepository(gh<_i188.ICommunityInternalProvider>()));
    gh.factory<_i552.CenterBloc>(() =>
        _i552.CenterBloc(centerRepository: gh<_i284.ICenterRepository>()));
    gh.factory<_i775.AppInitBloc>(
        () => _i775.AppInitBloc(iInitRepository: gh<_i614.IInitRepository>()));
    gh.factory<_i392.BoardBloc>(() => _i392.BoardBloc(
          communityRepository: gh<_i307.ICommunityRepository>(),
          bus: gh<_i461.Bus>(),
        ));
    gh.factory<_i453.TermsOfServiceBloc>(() => _i453.TermsOfServiceBloc(
          communityRepository: gh<_i307.ICommunityRepository>(),
          bus: gh<_i461.Bus>(),
        ));
    gh.factory<_i659.ChatSessionBloc>(() => _i659.ChatSessionBloc(
          chatRepository: gh<_i605.ChatRepository>(),
          streamedChatService: gh<_i922.StreamedChatService>(),
        ));
    gh.factory<_i157.AuthStatusBloc>(() => _i157.AuthStatusBloc(
          tokenRepository: gh<_i658.ITokenRepository>(),
          appInitBloc: gh<_i775.AppInitBloc>(),
        ));
    gh.factory<_i115.CreatePostBloc>(() => _i115.CreatePostBloc(
        communityRepository: gh<_i307.ICommunityRepository>()));
    gh.factory<_i597.PostDetailBloc>(() => _i597.PostDetailBloc(
        communityRepository: gh<_i307.ICommunityRepository>()));
    gh.factory<_i835.EditProfileBloc>(() => _i835.EditProfileBloc(
          myPageRepository: gh<_i558.IMypageRepository>(),
          bus: gh<_i461.Bus>(),
        ));
    gh.factory<_i876.MypageBloc>(() => _i876.MypageBloc(
          myPageRepository: gh<_i558.IMypageRepository>(),
          bus: gh<_i461.Bus>(),
        ));
    gh.factory<_i317.LoginBloc>(
        () => _i317.LoginBloc(authRepository: gh<_i667.IAuthRepository>()));
    gh.factory<_i598.SignOutBloc>(
        () => _i598.SignOutBloc(authRepository: gh<_i667.IAuthRepository>()));
    gh.factory<_i501.WithdrawBloc>(
        () => _i501.WithdrawBloc(authRepository: gh<_i667.IAuthRepository>()));
    gh.factory<_i810.ChatDrawerBloc>(() => _i810.ChatDrawerBloc(
          gh<_i779.ChatRoomsInfoRepository>(),
          gh<_i659.ChatSessionBloc>(),
        ));
    return this;
  }
}

class _$HomeRegisterModule extends _i443.HomeRegisterModule {}
