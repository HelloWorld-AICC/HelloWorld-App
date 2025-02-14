part of 'app_init_bloc.dart';

sealed class AppInitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class MarkAppRunnedBefore extends AppInitEvent {}

final class StoreSelectedLanguage extends AppInitEvent {
  final int selectedIndex;

  StoreSelectedLanguage({required this.selectedIndex});
}

final class SendUserLanguage extends AppInitEvent {
  final int languageId;

  SendUserLanguage(this.languageId);
}
