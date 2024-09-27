// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_session_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatSessionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() createNewSession,
    required TResult Function() loadPrevSession,
    required TResult Function() checkSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? createNewSession,
    TResult? Function()? loadPrevSession,
    TResult? Function()? checkSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? createNewSession,
    TResult Function()? loadPrevSession,
    TResult Function()? checkSession,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateNewSessionEvent value) createNewSession,
    required TResult Function(LoadPrevSessionEvent value) loadPrevSession,
    required TResult Function(CheckSessionEvent value) checkSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateNewSessionEvent value)? createNewSession,
    TResult? Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult? Function(CheckSessionEvent value)? checkSession,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateNewSessionEvent value)? createNewSession,
    TResult Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult Function(CheckSessionEvent value)? checkSession,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSessionEventCopyWith<$Res> {
  factory $ChatSessionEventCopyWith(
          ChatSessionEvent value, $Res Function(ChatSessionEvent) then) =
      _$ChatSessionEventCopyWithImpl<$Res, ChatSessionEvent>;
}

/// @nodoc
class _$ChatSessionEventCopyWithImpl<$Res, $Val extends ChatSessionEvent>
    implements $ChatSessionEventCopyWith<$Res> {
  _$ChatSessionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatSessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreateNewSessionEventImplCopyWith<$Res> {
  factory _$$CreateNewSessionEventImplCopyWith(
          _$CreateNewSessionEventImpl value,
          $Res Function(_$CreateNewSessionEventImpl) then) =
      __$$CreateNewSessionEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateNewSessionEventImplCopyWithImpl<$Res>
    extends _$ChatSessionEventCopyWithImpl<$Res, _$CreateNewSessionEventImpl>
    implements _$$CreateNewSessionEventImplCopyWith<$Res> {
  __$$CreateNewSessionEventImplCopyWithImpl(_$CreateNewSessionEventImpl _value,
      $Res Function(_$CreateNewSessionEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreateNewSessionEventImpl implements CreateNewSessionEvent {
  const _$CreateNewSessionEventImpl();

  @override
  String toString() {
    return 'ChatSessionEvent.createNewSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateNewSessionEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() createNewSession,
    required TResult Function() loadPrevSession,
    required TResult Function() checkSession,
  }) {
    return createNewSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? createNewSession,
    TResult? Function()? loadPrevSession,
    TResult? Function()? checkSession,
  }) {
    return createNewSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? createNewSession,
    TResult Function()? loadPrevSession,
    TResult Function()? checkSession,
    required TResult orElse(),
  }) {
    if (createNewSession != null) {
      return createNewSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateNewSessionEvent value) createNewSession,
    required TResult Function(LoadPrevSessionEvent value) loadPrevSession,
    required TResult Function(CheckSessionEvent value) checkSession,
  }) {
    return createNewSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateNewSessionEvent value)? createNewSession,
    TResult? Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult? Function(CheckSessionEvent value)? checkSession,
  }) {
    return createNewSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateNewSessionEvent value)? createNewSession,
    TResult Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult Function(CheckSessionEvent value)? checkSession,
    required TResult orElse(),
  }) {
    if (createNewSession != null) {
      return createNewSession(this);
    }
    return orElse();
  }
}

abstract class CreateNewSessionEvent implements ChatSessionEvent {
  const factory CreateNewSessionEvent() = _$CreateNewSessionEventImpl;
}

/// @nodoc
abstract class _$$LoadPrevSessionEventImplCopyWith<$Res> {
  factory _$$LoadPrevSessionEventImplCopyWith(_$LoadPrevSessionEventImpl value,
          $Res Function(_$LoadPrevSessionEventImpl) then) =
      __$$LoadPrevSessionEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadPrevSessionEventImplCopyWithImpl<$Res>
    extends _$ChatSessionEventCopyWithImpl<$Res, _$LoadPrevSessionEventImpl>
    implements _$$LoadPrevSessionEventImplCopyWith<$Res> {
  __$$LoadPrevSessionEventImplCopyWithImpl(_$LoadPrevSessionEventImpl _value,
      $Res Function(_$LoadPrevSessionEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPrevSessionEventImpl implements LoadPrevSessionEvent {
  const _$LoadPrevSessionEventImpl();

  @override
  String toString() {
    return 'ChatSessionEvent.loadPrevSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPrevSessionEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() createNewSession,
    required TResult Function() loadPrevSession,
    required TResult Function() checkSession,
  }) {
    return loadPrevSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? createNewSession,
    TResult? Function()? loadPrevSession,
    TResult? Function()? checkSession,
  }) {
    return loadPrevSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? createNewSession,
    TResult Function()? loadPrevSession,
    TResult Function()? checkSession,
    required TResult orElse(),
  }) {
    if (loadPrevSession != null) {
      return loadPrevSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateNewSessionEvent value) createNewSession,
    required TResult Function(LoadPrevSessionEvent value) loadPrevSession,
    required TResult Function(CheckSessionEvent value) checkSession,
  }) {
    return loadPrevSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateNewSessionEvent value)? createNewSession,
    TResult? Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult? Function(CheckSessionEvent value)? checkSession,
  }) {
    return loadPrevSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateNewSessionEvent value)? createNewSession,
    TResult Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult Function(CheckSessionEvent value)? checkSession,
    required TResult orElse(),
  }) {
    if (loadPrevSession != null) {
      return loadPrevSession(this);
    }
    return orElse();
  }
}

abstract class LoadPrevSessionEvent implements ChatSessionEvent {
  const factory LoadPrevSessionEvent() = _$LoadPrevSessionEventImpl;
}

/// @nodoc
abstract class _$$CheckSessionEventImplCopyWith<$Res> {
  factory _$$CheckSessionEventImplCopyWith(_$CheckSessionEventImpl value,
          $Res Function(_$CheckSessionEventImpl) then) =
      __$$CheckSessionEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckSessionEventImplCopyWithImpl<$Res>
    extends _$ChatSessionEventCopyWithImpl<$Res, _$CheckSessionEventImpl>
    implements _$$CheckSessionEventImplCopyWith<$Res> {
  __$$CheckSessionEventImplCopyWithImpl(_$CheckSessionEventImpl _value,
      $Res Function(_$CheckSessionEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckSessionEventImpl implements CheckSessionEvent {
  const _$CheckSessionEventImpl();

  @override
  String toString() {
    return 'ChatSessionEvent.checkSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckSessionEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() createNewSession,
    required TResult Function() loadPrevSession,
    required TResult Function() checkSession,
  }) {
    return checkSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? createNewSession,
    TResult? Function()? loadPrevSession,
    TResult? Function()? checkSession,
  }) {
    return checkSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? createNewSession,
    TResult Function()? loadPrevSession,
    TResult Function()? checkSession,
    required TResult orElse(),
  }) {
    if (checkSession != null) {
      return checkSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateNewSessionEvent value) createNewSession,
    required TResult Function(LoadPrevSessionEvent value) loadPrevSession,
    required TResult Function(CheckSessionEvent value) checkSession,
  }) {
    return checkSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateNewSessionEvent value)? createNewSession,
    TResult? Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult? Function(CheckSessionEvent value)? checkSession,
  }) {
    return checkSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateNewSessionEvent value)? createNewSession,
    TResult Function(LoadPrevSessionEvent value)? loadPrevSession,
    TResult Function(CheckSessionEvent value)? checkSession,
    required TResult orElse(),
  }) {
    if (checkSession != null) {
      return checkSession(this);
    }
    return orElse();
  }
}

abstract class CheckSessionEvent implements ChatSessionEvent {
  const factory CheckSessionEvent() = _$CheckSessionEventImpl;
}
