part of 'locale_bloc.dart';

sealed class LocaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SetLocale extends LocaleEvent {
  final Locale locale;
  SetLocale({required this.locale});

  @override
  List<Object> get props => [locale];
}
