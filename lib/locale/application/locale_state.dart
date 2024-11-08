// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locale_bloc.dart';

class LocaleState extends Equatable {
  final Locale? locale;
  final int? selectedIndex;

  const LocaleState({required this.locale, required this.selectedIndex});

  factory LocaleState.initial() =>
      const LocaleState(locale: null, selectedIndex: 0);

  @override
  List<Object?> get props => [locale, selectedIndex];

  LocaleState copyWith({
    Locale? locale,
    int? selectedIndex,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
      selectedIndex: selectedIndex,
    );
  }
}
