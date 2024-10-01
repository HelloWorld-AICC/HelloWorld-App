// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locale_bloc.dart';

class LocaleState extends Equatable {
  final Locale? locale;

  const LocaleState({required this.locale});

  factory LocaleState.initial() => const LocaleState(locale: null);

  @override
  List<Object?> get props => [locale];

  LocaleState copyWith({
    Locale? locale,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}
