// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatSessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() newSession,
    required TResult Function() prevSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? newSession,
    TResult? Function()? prevSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? newSession,
    TResult Function()? prevSession,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewSessionState value) newSession,
    required TResult Function(PrevSessionState value) prevSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewSessionState value)? newSession,
    TResult? Function(PrevSessionState value)? prevSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewSessionState value)? newSession,
    TResult Function(PrevSessionState value)? prevSession,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSessionStateCopyWith<$Res> {
  factory $ChatSessionStateCopyWith(
          ChatSessionState value, $Res Function(ChatSessionState) then) =
      _$ChatSessionStateCopyWithImpl<$Res, ChatSessionState>;
}

/// @nodoc
class _$ChatSessionStateCopyWithImpl<$Res, $Val extends ChatSessionState>
    implements $ChatSessionStateCopyWith<$Res> {
  _$ChatSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NewSessionStateImplCopyWith<$Res> {
  factory _$$NewSessionStateImplCopyWith(_$NewSessionStateImpl value,
          $Res Function(_$NewSessionStateImpl) then) =
      __$$NewSessionStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewSessionStateImplCopyWithImpl<$Res>
    extends _$ChatSessionStateCopyWithImpl<$Res, _$NewSessionStateImpl>
    implements _$$NewSessionStateImplCopyWith<$Res> {
  __$$NewSessionStateImplCopyWithImpl(
      _$NewSessionStateImpl _value, $Res Function(_$NewSessionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NewSessionStateImpl implements NewSessionState {
  const _$NewSessionStateImpl();

  @override
  String toString() {
    return 'ChatSessionState.newSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewSessionStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() newSession,
    required TResult Function() prevSession,
  }) {
    return newSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? newSession,
    TResult? Function()? prevSession,
  }) {
    return newSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? newSession,
    TResult Function()? prevSession,
    required TResult orElse(),
  }) {
    if (newSession != null) {
      return newSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewSessionState value) newSession,
    required TResult Function(PrevSessionState value) prevSession,
  }) {
    return newSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewSessionState value)? newSession,
    TResult? Function(PrevSessionState value)? prevSession,
  }) {
    return newSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewSessionState value)? newSession,
    TResult Function(PrevSessionState value)? prevSession,
    required TResult orElse(),
  }) {
    if (newSession != null) {
      return newSession(this);
    }
    return orElse();
  }
}

abstract class NewSessionState implements ChatSessionState {
  const factory NewSessionState() = _$NewSessionStateImpl;
}

/// @nodoc
abstract class _$$PrevSessionStateImplCopyWith<$Res> {
  factory _$$PrevSessionStateImplCopyWith(_$PrevSessionStateImpl value,
          $Res Function(_$PrevSessionStateImpl) then) =
      __$$PrevSessionStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PrevSessionStateImplCopyWithImpl<$Res>
    extends _$ChatSessionStateCopyWithImpl<$Res, _$PrevSessionStateImpl>
    implements _$$PrevSessionStateImplCopyWith<$Res> {
  __$$PrevSessionStateImplCopyWithImpl(_$PrevSessionStateImpl _value,
      $Res Function(_$PrevSessionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PrevSessionStateImpl implements PrevSessionState {
  const _$PrevSessionStateImpl();

  @override
  String toString() {
    return 'ChatSessionState.prevSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PrevSessionStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() newSession,
    required TResult Function() prevSession,
  }) {
    return prevSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? newSession,
    TResult? Function()? prevSession,
  }) {
    return prevSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? newSession,
    TResult Function()? prevSession,
    required TResult orElse(),
  }) {
    if (prevSession != null) {
      return prevSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewSessionState value) newSession,
    required TResult Function(PrevSessionState value) prevSession,
  }) {
    return prevSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewSessionState value)? newSession,
    TResult? Function(PrevSessionState value)? prevSession,
  }) {
    return prevSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewSessionState value)? newSession,
    TResult Function(PrevSessionState value)? prevSession,
    required TResult orElse(),
  }) {
    if (prevSession != null) {
      return prevSession(this);
    }
    return orElse();
  }
}

abstract class PrevSessionState implements ChatSessionState {
  const factory PrevSessionState() = _$PrevSessionStateImpl;
}
