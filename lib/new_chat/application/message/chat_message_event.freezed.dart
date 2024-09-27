// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatMessageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMessages,
    required TResult Function() clearMessages,
    required TResult Function(String message) addUserMessage,
    required TResult Function(String message) addBotMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMessages,
    TResult? Function()? clearMessages,
    TResult? Function(String message)? addUserMessage,
    TResult? Function(String message)? addBotMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMessages,
    TResult Function()? clearMessages,
    TResult Function(String message)? addUserMessage,
    TResult Function(String message)? addBotMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(ClearMessages value) clearMessages,
    required TResult Function(AddUserMessage value) addUserMessage,
    required TResult Function(AddBotMessage value) addBotMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(ClearMessages value)? clearMessages,
    TResult? Function(AddUserMessage value)? addUserMessage,
    TResult? Function(AddBotMessage value)? addBotMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(ClearMessages value)? clearMessages,
    TResult Function(AddUserMessage value)? addUserMessage,
    TResult Function(AddBotMessage value)? addBotMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageEventCopyWith<$Res> {
  factory $ChatMessageEventCopyWith(
          ChatMessageEvent value, $Res Function(ChatMessageEvent) then) =
      _$ChatMessageEventCopyWithImpl<$Res, ChatMessageEvent>;
}

/// @nodoc
class _$ChatMessageEventCopyWithImpl<$Res, $Val extends ChatMessageEvent>
    implements $ChatMessageEventCopyWith<$Res> {
  _$ChatMessageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
          _$LoadMessagesImpl value, $Res Function(_$LoadMessagesImpl) then) =
      __$$LoadMessagesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
      _$LoadMessagesImpl _value, $Res Function(_$LoadMessagesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMessagesImpl implements LoadMessages {
  const _$LoadMessagesImpl();

  @override
  String toString() {
    return 'ChatMessageEvent.loadMessages()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMessagesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMessages,
    required TResult Function() clearMessages,
    required TResult Function(String message) addUserMessage,
    required TResult Function(String message) addBotMessage,
  }) {
    return loadMessages();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMessages,
    TResult? Function()? clearMessages,
    TResult? Function(String message)? addUserMessage,
    TResult? Function(String message)? addBotMessage,
  }) {
    return loadMessages?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMessages,
    TResult Function()? clearMessages,
    TResult Function(String message)? addUserMessage,
    TResult Function(String message)? addBotMessage,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(ClearMessages value) clearMessages,
    required TResult Function(AddUserMessage value) addUserMessage,
    required TResult Function(AddBotMessage value) addBotMessage,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(ClearMessages value)? clearMessages,
    TResult? Function(AddUserMessage value)? addUserMessage,
    TResult? Function(AddBotMessage value)? addBotMessage,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(ClearMessages value)? clearMessages,
    TResult Function(AddUserMessage value)? addUserMessage,
    TResult Function(AddBotMessage value)? addBotMessage,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class LoadMessages implements ChatMessageEvent {
  const factory LoadMessages() = _$LoadMessagesImpl;
}

/// @nodoc
abstract class _$$ClearMessagesImplCopyWith<$Res> {
  factory _$$ClearMessagesImplCopyWith(
          _$ClearMessagesImpl value, $Res Function(_$ClearMessagesImpl) then) =
      __$$ClearMessagesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearMessagesImplCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$ClearMessagesImpl>
    implements _$$ClearMessagesImplCopyWith<$Res> {
  __$$ClearMessagesImplCopyWithImpl(
      _$ClearMessagesImpl _value, $Res Function(_$ClearMessagesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessagesImpl implements ClearMessages {
  const _$ClearMessagesImpl();

  @override
  String toString() {
    return 'ChatMessageEvent.clearMessages()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearMessagesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMessages,
    required TResult Function() clearMessages,
    required TResult Function(String message) addUserMessage,
    required TResult Function(String message) addBotMessage,
  }) {
    return clearMessages();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMessages,
    TResult? Function()? clearMessages,
    TResult? Function(String message)? addUserMessage,
    TResult? Function(String message)? addBotMessage,
  }) {
    return clearMessages?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMessages,
    TResult Function()? clearMessages,
    TResult Function(String message)? addUserMessage,
    TResult Function(String message)? addBotMessage,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(ClearMessages value) clearMessages,
    required TResult Function(AddUserMessage value) addUserMessage,
    required TResult Function(AddBotMessage value) addBotMessage,
  }) {
    return clearMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(ClearMessages value)? clearMessages,
    TResult? Function(AddUserMessage value)? addUserMessage,
    TResult? Function(AddBotMessage value)? addBotMessage,
  }) {
    return clearMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(ClearMessages value)? clearMessages,
    TResult Function(AddUserMessage value)? addUserMessage,
    TResult Function(AddBotMessage value)? addBotMessage,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages(this);
    }
    return orElse();
  }
}

abstract class ClearMessages implements ChatMessageEvent {
  const factory ClearMessages() = _$ClearMessagesImpl;
}

/// @nodoc
abstract class _$$AddUserMessageImplCopyWith<$Res> {
  factory _$$AddUserMessageImplCopyWith(_$AddUserMessageImpl value,
          $Res Function(_$AddUserMessageImpl) then) =
      __$$AddUserMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddUserMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$AddUserMessageImpl>
    implements _$$AddUserMessageImplCopyWith<$Res> {
  __$$AddUserMessageImplCopyWithImpl(
      _$AddUserMessageImpl _value, $Res Function(_$AddUserMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddUserMessageImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddUserMessageImpl implements AddUserMessage {
  const _$AddUserMessageImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatMessageEvent.addUserMessage(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddUserMessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddUserMessageImplCopyWith<_$AddUserMessageImpl> get copyWith =>
      __$$AddUserMessageImplCopyWithImpl<_$AddUserMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMessages,
    required TResult Function() clearMessages,
    required TResult Function(String message) addUserMessage,
    required TResult Function(String message) addBotMessage,
  }) {
    return addUserMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMessages,
    TResult? Function()? clearMessages,
    TResult? Function(String message)? addUserMessage,
    TResult? Function(String message)? addBotMessage,
  }) {
    return addUserMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMessages,
    TResult Function()? clearMessages,
    TResult Function(String message)? addUserMessage,
    TResult Function(String message)? addBotMessage,
    required TResult orElse(),
  }) {
    if (addUserMessage != null) {
      return addUserMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(ClearMessages value) clearMessages,
    required TResult Function(AddUserMessage value) addUserMessage,
    required TResult Function(AddBotMessage value) addBotMessage,
  }) {
    return addUserMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(ClearMessages value)? clearMessages,
    TResult? Function(AddUserMessage value)? addUserMessage,
    TResult? Function(AddBotMessage value)? addBotMessage,
  }) {
    return addUserMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(ClearMessages value)? clearMessages,
    TResult Function(AddUserMessage value)? addUserMessage,
    TResult Function(AddBotMessage value)? addBotMessage,
    required TResult orElse(),
  }) {
    if (addUserMessage != null) {
      return addUserMessage(this);
    }
    return orElse();
  }
}

abstract class AddUserMessage implements ChatMessageEvent {
  const factory AddUserMessage(final String message) = _$AddUserMessageImpl;

  String get message;

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddUserMessageImplCopyWith<_$AddUserMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddBotMessageImplCopyWith<$Res> {
  factory _$$AddBotMessageImplCopyWith(
          _$AddBotMessageImpl value, $Res Function(_$AddBotMessageImpl) then) =
      __$$AddBotMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddBotMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$AddBotMessageImpl>
    implements _$$AddBotMessageImplCopyWith<$Res> {
  __$$AddBotMessageImplCopyWithImpl(
      _$AddBotMessageImpl _value, $Res Function(_$AddBotMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddBotMessageImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddBotMessageImpl implements AddBotMessage {
  const _$AddBotMessageImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatMessageEvent.addBotMessage(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddBotMessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddBotMessageImplCopyWith<_$AddBotMessageImpl> get copyWith =>
      __$$AddBotMessageImplCopyWithImpl<_$AddBotMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMessages,
    required TResult Function() clearMessages,
    required TResult Function(String message) addUserMessage,
    required TResult Function(String message) addBotMessage,
  }) {
    return addBotMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMessages,
    TResult? Function()? clearMessages,
    TResult? Function(String message)? addUserMessage,
    TResult? Function(String message)? addBotMessage,
  }) {
    return addBotMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMessages,
    TResult Function()? clearMessages,
    TResult Function(String message)? addUserMessage,
    TResult Function(String message)? addBotMessage,
    required TResult orElse(),
  }) {
    if (addBotMessage != null) {
      return addBotMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(ClearMessages value) clearMessages,
    required TResult Function(AddUserMessage value) addUserMessage,
    required TResult Function(AddBotMessage value) addBotMessage,
  }) {
    return addBotMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(ClearMessages value)? clearMessages,
    TResult? Function(AddUserMessage value)? addUserMessage,
    TResult? Function(AddBotMessage value)? addBotMessage,
  }) {
    return addBotMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(ClearMessages value)? clearMessages,
    TResult Function(AddUserMessage value)? addUserMessage,
    TResult Function(AddBotMessage value)? addBotMessage,
    required TResult orElse(),
  }) {
    if (addBotMessage != null) {
      return addBotMessage(this);
    }
    return orElse();
  }
}

abstract class AddBotMessage implements ChatMessageEvent {
  const factory AddBotMessage(final String message) = _$AddBotMessageImpl;

  String get message;

  /// Create a copy of ChatMessageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddBotMessageImplCopyWith<_$AddBotMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
