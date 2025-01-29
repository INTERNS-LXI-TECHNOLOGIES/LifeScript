// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserProfile extends UserProfile {
  @override
  final int? id;
  @override
  final String? nickName;
  @override
  final String? address;
  @override
  final User? user;
  @override
  final BuiltSet<TwisterPractice>? twisterPractices;
  @override
  final int? userId;

  factory _$UserProfile([void Function(UserProfileBuilder)? updates]) =>
      (new UserProfileBuilder()..update(updates))._build();

  _$UserProfile._(
      {this.id,
      this.nickName,
      this.address,
      this.user,
      this.twisterPractices,
      this.userId})
      : super._();

  @override
  UserProfile rebuild(void Function(UserProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserProfileBuilder toBuilder() => new UserProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfile &&
        id == other.id &&
        nickName == other.nickName &&
        address == other.address &&
        user == other.user &&
        twisterPractices == other.twisterPractices &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, nickName.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, twisterPractices.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserProfile')
          ..add('id', id)
          ..add('nickName', nickName)
          ..add('address', address)
          ..add('user', user)
          ..add('twisterPractices', twisterPractices)
          ..add('userId', userId))
        .toString();
  }
}

class UserProfileBuilder implements Builder<UserProfile, UserProfileBuilder> {
  _$UserProfile? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _nickName;
  String? get nickName => _$this._nickName;
  set nickName(String? nickName) => _$this._nickName = nickName;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  SetBuilder<TwisterPractice>? _twisterPractices;
  SetBuilder<TwisterPractice> get twisterPractices =>
      _$this._twisterPractices ??= new SetBuilder<TwisterPractice>();
  set twisterPractices(SetBuilder<TwisterPractice>? twisterPractices) =>
      _$this._twisterPractices = twisterPractices;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  UserProfileBuilder() {
    UserProfile._defaults(this);
  }

  UserProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _nickName = $v.nickName;
      _address = $v.address;
      _user = $v.user?.toBuilder();
      _twisterPractices = $v.twisterPractices?.toBuilder();
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfile other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserProfile;
  }

  @override
  void update(void Function(UserProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserProfile build() => _build();

  _$UserProfile _build() {
    _$UserProfile _$result;
    try {
      _$result = _$v ??
          new _$UserProfile._(
            id: id,
            nickName: nickName,
            address: address,
            user: _user?.build(),
            twisterPractices: _twisterPractices?.build(),
            userId: userId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'twisterPractices';
        _twisterPractices?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UserProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
