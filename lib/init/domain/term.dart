import 'package:equatable/equatable.dart';

class Term extends Equatable {
  final String title;
  final String body;

  const Term({required this.title, required this.body});

  @override
  List<Object?> get props => [];
}
