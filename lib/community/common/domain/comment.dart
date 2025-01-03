// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class Comment extends Equatable {
  final int anonymousName;
  final DateVO createdAt;
  final DateVO content;

  const Comment(
      {required this.anonymousName,
      required this.createdAt,
      required this.content});

  @override
  List<Object?> get props => [
        anonymousName,
        createdAt,
        content,
      ];
}
