// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatisticState {
  Map<String, dynamic> get results => throw _privateConstructorUsedError;
  LoadState get loadState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatisticStateCopyWith<StatisticState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticStateCopyWith<$Res> {
  factory $StatisticStateCopyWith(
          StatisticState value, $Res Function(StatisticState) then) =
      _$StatisticStateCopyWithImpl<$Res, StatisticState>;
  @useResult
  $Res call({Map<String, dynamic> results, LoadState loadState});
}

/// @nodoc
class _$StatisticStateCopyWithImpl<$Res, $Val extends StatisticState>
    implements $StatisticStateCopyWith<$Res> {
  _$StatisticStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? loadState = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatisticStateImplCopyWith<$Res>
    implements $StatisticStateCopyWith<$Res> {
  factory _$$StatisticStateImplCopyWith(_$StatisticStateImpl value,
          $Res Function(_$StatisticStateImpl) then) =
      __$$StatisticStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> results, LoadState loadState});
}

/// @nodoc
class __$$StatisticStateImplCopyWithImpl<$Res>
    extends _$StatisticStateCopyWithImpl<$Res, _$StatisticStateImpl>
    implements _$$StatisticStateImplCopyWith<$Res> {
  __$$StatisticStateImplCopyWithImpl(
      _$StatisticStateImpl _value, $Res Function(_$StatisticStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? loadState = null,
  }) {
    return _then(_$StatisticStateImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ));
  }
}

/// @nodoc

class _$StatisticStateImpl implements _StatisticState {
  _$StatisticStateImpl(
      {final Map<String, dynamic> results = const {},
      this.loadState = LoadState.initial})
      : _results = results;

  final Map<String, dynamic> _results;
  @override
  @JsonKey()
  Map<String, dynamic> get results {
    if (_results is EqualUnmodifiableMapView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_results);
  }

  @override
  @JsonKey()
  final LoadState loadState;

  @override
  String toString() {
    return 'StatisticState(results: $results, loadState: $loadState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticStateImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.loadState, loadState) ||
                other.loadState == loadState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_results), loadState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticStateImplCopyWith<_$StatisticStateImpl> get copyWith =>
      __$$StatisticStateImplCopyWithImpl<_$StatisticStateImpl>(
          this, _$identity);
}

abstract class _StatisticState implements StatisticState {
  factory _StatisticState(
      {final Map<String, dynamic> results,
      final LoadState loadState}) = _$StatisticStateImpl;

  @override
  Map<String, dynamic> get results;
  @override
  LoadState get loadState;
  @override
  @JsonKey(ignore: true)
  _$$StatisticStateImplCopyWith<_$StatisticStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
