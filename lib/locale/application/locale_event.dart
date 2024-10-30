part of 'locale_bloc.dart';

sealed class LocaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SetLocale extends LocaleEvent {
  final Locale locale;
  final int index;

  SetLocale({required this.locale, required this.index});

  @override
  List<Object> get props => [locale, index];
}
