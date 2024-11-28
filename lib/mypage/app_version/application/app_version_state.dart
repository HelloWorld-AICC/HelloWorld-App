// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_version_bloc.dart';

class AppVersionState extends Equatable {
  final String? appVersion;
  final AppVersionFailure? failure;
  final bool isLoading;

  const AppVersionState({
    required this.appVersion,
    required this.failure,
    required this.isLoading,
  });

  factory AppVersionState.initial() =>
      const AppVersionState(appVersion: null, failure: null, isLoading: false);

  @override
  List<Object?> get props => [appVersion, failure, isLoading];

  AppVersionState copyWith({
    String? appVersion,
    AppVersionFailure? failure,
    bool? isLoading,
  }) {
    return AppVersionState(
      appVersion: appVersion ?? this.appVersion,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
