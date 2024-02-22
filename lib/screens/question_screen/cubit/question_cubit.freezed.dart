// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestionState {
  int? get topicId => throw _privateConstructorUsedError;
  QuestionModel? get question => throw _privateConstructorUsedError;
  bool? get result => throw _privateConstructorUsedError;
  LoadState get loadState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestionStateCopyWith<QuestionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionStateCopyWith<$Res> {
  factory $QuestionStateCopyWith(
          QuestionState value, $Res Function(QuestionState) then) =
      _$QuestionStateCopyWithImpl<$Res, QuestionState>;
  @useResult
  $Res call(
      {int? topicId,
      QuestionModel? question,
      bool? result,
      LoadState loadState});
}

/// @nodoc
class _$QuestionStateCopyWithImpl<$Res, $Val extends QuestionState>
    implements $QuestionStateCopyWith<$Res> {
  _$QuestionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = freezed,
    Object? question = freezed,
    Object? result = freezed,
    Object? loadState = null,
  }) {
    return _then(_value.copyWith(
      topicId: freezed == topicId
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as QuestionModel?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool?,
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionStateImplCopyWith<$Res>
    implements $QuestionStateCopyWith<$Res> {
  factory _$$QuestionStateImplCopyWith(
          _$QuestionStateImpl value, $Res Function(_$QuestionStateImpl) then) =
      __$$QuestionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? topicId,
      QuestionModel? question,
      bool? result,
      LoadState loadState});
}

/// @nodoc
class __$$QuestionStateImplCopyWithImpl<$Res>
    extends _$QuestionStateCopyWithImpl<$Res, _$QuestionStateImpl>
    implements _$$QuestionStateImplCopyWith<$Res> {
  __$$QuestionStateImplCopyWithImpl(
      _$QuestionStateImpl _value, $Res Function(_$QuestionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = freezed,
    Object? question = freezed,
    Object? result = freezed,
    Object? loadState = null,
  }) {
    return _then(_$QuestionStateImpl(
      topicId: freezed == topicId
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as QuestionModel?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool?,
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ));
  }
}

/// @nodoc

class _$QuestionStateImpl implements _QuestionState {
  _$QuestionStateImpl(
      {this.topicId,
      this.question,
      this.result,
      this.loadState = LoadState.initial});

  @override
  final int? topicId;
  @override
  final QuestionModel? question;
  @override
  final bool? result;
  @override
  @JsonKey()
  final LoadState loadState;

  @override
  String toString() {
    return 'QuestionState(topicId: $topicId, question: $question, result: $result, loadState: $loadState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionStateImpl &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.loadState, loadState) ||
                other.loadState == loadState));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, topicId, question, result, loadState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionStateImplCopyWith<_$QuestionStateImpl> get copyWith =>
      __$$QuestionStateImplCopyWithImpl<_$QuestionStateImpl>(this, _$identity);
}

abstract class _QuestionState implements QuestionState {
  factory _QuestionState(
      {final int? topicId,
      final QuestionModel? question,
      final bool? result,
      final LoadState loadState}) = _$QuestionStateImpl;

  @override
  int? get topicId;
  @override
  QuestionModel? get question;
  @override
  bool? get result;
  @override
  LoadState get loadState;
  @override
  @JsonKey(ignore: true)
  _$$QuestionStateImplCopyWith<_$QuestionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
