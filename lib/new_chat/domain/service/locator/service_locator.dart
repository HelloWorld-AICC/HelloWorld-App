import '../../../../auth/infrastructure/provider/auth_local_provider.dart';
import '../../../../auth/infrastructure/repository/token_repository.dart';
import '../../../../fetch/authenticated_http_client.dart';
import '../../../../fetch/fetch_service.dart';
import '../../../../local_storage/local_storage_service.dart';
import '../fetch/webflux_fetch_service.dart';

class ServiceLocator {
  static final _tokenRepository = TokenRepository(
      authLocalProvider: AuthLocalProvider(service: LocalStorageService()));
  static final _client =
      AuthenticatedHttpClient(tokenRepository: _tokenRepository);

  static final _fetchService = WebFluxFetchService(client: _client);

  static FetchService getFetchService() {
    return _fetchService;
  }
}
