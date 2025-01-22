// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authority.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Authority extends Authority {
  @override
  final String name;

  factory _$Authority([void Function(AuthorityBuilder)? updates]) =>
      (new AuthorityBuilder()..update(updates))._build();

  _$Authority._({required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'Authority', 'name');
  }

  @override
  Authority rebuild(void Function(AuthorityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthorityBuilder toBuilder() => new AuthorityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Authority && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Authority')..add('name', name))
        .toString();
  }
}

class AuthorityBuilder implements Builder<Authority, AuthorityBuilder> {
  _$Authority? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  AuthorityBuilder() {
    Authority._defaults(this);
  }

  AuthorityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Authority other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Authority;
  }

  @override
  void update(void Function(AuthorityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Authority build() => _build();

  _$Authority _build() {
    final _$result = _$v ??
        new _$Authority._(
          name:
              BuiltValueNullFieldError.checkNotNull(name, r'Authority', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
