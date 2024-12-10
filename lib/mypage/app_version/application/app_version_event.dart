part of 'app_version_bloc.dart';

sealed class AppVersionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetAppVersion extends AppVersionEvent {
  GetAppVersion();

  @override
  List<Object> get props => [];
}
