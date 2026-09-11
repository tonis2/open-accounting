// This is a generated file - do not edit.
//
// Generated from routes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart' as $1;

import 'routes.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'routes.pbenum.dart';

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();

  Empty._();

  factory Empty.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Empty.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  @$core.override
  Empty createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class IdRequest extends $pb.GeneratedMessage {
  factory IdRequest({
    $fixnum.Int64? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  IdRequest._();

  factory IdRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IdRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'IdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdRequest copyWith(void Function(IdRequest) updates) => super.copyWith((message) => updates(message as IdRequest)) as IdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdRequest create() => IdRequest._();
  @$core.override
  IdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdRequest>(create);
  static IdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class CompanyRequest extends $pb.GeneratedMessage {
  factory CompanyRequest({
    $fixnum.Int64? companyId,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    return result;
  }

  CompanyRequest._();

  factory CompanyRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompanyRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompanyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompanyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompanyRequest copyWith(void Function(CompanyRequest) updates) => super.copyWith((message) => updates(message as CompanyRequest)) as CompanyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompanyRequest create() => CompanyRequest._();
  @$core.override
  CompanyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CompanyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompanyRequest>(create);
  static CompanyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);
}

class CompanyIdRequest extends $pb.GeneratedMessage {
  factory CompanyIdRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? id,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (id != null) result.id = id;
    return result;
  }

  CompanyIdRequest._();

  factory CompanyIdRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompanyIdRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompanyIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompanyIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompanyIdRequest copyWith(void Function(CompanyIdRequest) updates) => super.copyWith((message) => updates(message as CompanyIdRequest)) as CompanyIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompanyIdRequest create() => CompanyIdRequest._();
  @$core.override
  CompanyIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CompanyIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompanyIdRequest>(create);
  static CompanyIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get id => $_getI64(1);
  @$pb.TagNumber(2)
  set id($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);
}

class FileResponse extends $pb.GeneratedMessage {
  factory FileResponse({
    $core.List<$core.int>? data,
    $core.String? filename,
    $core.String? mime,
  }) {
    final result = create();
    if (data != null) result.data = data;
    if (filename != null) result.filename = filename;
    if (mime != null) result.mime = mime;
    return result;
  }

  FileResponse._();

  factory FileResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'mime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileResponse copyWith(void Function(FileResponse) updates) => super.copyWith((message) => updates(message as FileResponse)) as FileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileResponse create() => FileResponse._();
  @$core.override
  FileResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileResponse>(create);
  static FileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mime => $_getSZ(2);
  @$pb.TagNumber(3)
  set mime($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMime() => $_has(2);
  @$pb.TagNumber(3)
  void clearMime() => $_clearField(3);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $fixnum.Int64? id,
    $core.String? email,
    $core.String? name,
    $core.bool? hasPassword,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (email != null) result.email = email;
    if (name != null) result.name = name;
    if (hasPassword != null) result.hasPassword = hasPassword;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'User', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(2, _omitFieldNames ? '' : 'email')
        ..aOS(3, _omitFieldNames ? '' : 'name')
        ..aOB(4, _omitFieldNames ? '' : 'hasPassword')
        ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasPassword => $_getBF(3);
  @$pb.TagNumber(4)
  set hasPassword($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasPassword() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureCreatedAt() => $_ensure(4);
}

class RegisterRequest extends $pb.GeneratedMessage {
  factory RegisterRequest({
    $core.String? email,
    $core.String? name,
    $core.String? password,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (name != null) result.name = name;
    if (password != null) result.password = password;
    return result;
  }

  RegisterRequest._();

  factory RegisterRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RegisterRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterRequest copyWith(void Function(RegisterRequest) updates) => super.copyWith((message) => updates(message as RegisterRequest)) as RegisterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterRequest create() => RegisterRequest._();
  @$core.override
  RegisterRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RegisterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterRequest>(create);
  static RegisterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => $_clearField(3);
}

class LoginRequest extends $pb.GeneratedMessage {
  factory LoginRequest({
    $core.String? email,
    $core.String? password,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    return result;
  }

  LoginRequest._();

  factory LoginRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest copyWith(void Function(LoginRequest) updates) => super.copyWith((message) => updates(message as LoginRequest)) as LoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  @$core.override
  LoginRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class AuthResponse extends $pb.GeneratedMessage {
  factory AuthResponse({
    $core.String? token,
    User? user,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (user != null) result.user = user;
    return result;
  }

  AuthResponse._();

  factory AuthResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AuthResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOM<User>(2, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthResponse copyWith(void Function(AuthResponse) updates) => super.copyWith((message) => updates(message as AuthResponse)) as AuthResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthResponse create() => AuthResponse._();
  @$core.override
  AuthResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthResponse>(create);
  static AuthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user(User value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  User ensureUser() => $_ensure(1);
}

class RequestRecoveryRequest extends $pb.GeneratedMessage {
  factory RequestRecoveryRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  RequestRecoveryRequest._();

  factory RequestRecoveryRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestRecoveryRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestRecoveryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestRecoveryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestRecoveryRequest copyWith(void Function(RequestRecoveryRequest) updates) =>
      super.copyWith((message) => updates(message as RequestRecoveryRequest)) as RequestRecoveryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestRecoveryRequest create() => RequestRecoveryRequest._();
  @$core.override
  RequestRecoveryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RequestRecoveryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestRecoveryRequest>(create);
  static RequestRecoveryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class RecoveryTokenRequest extends $pb.GeneratedMessage {
  factory RecoveryTokenRequest({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  RecoveryTokenRequest._();

  factory RecoveryTokenRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecoveryTokenRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecoveryTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecoveryTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecoveryTokenRequest copyWith(void Function(RecoveryTokenRequest) updates) =>
      super.copyWith((message) => updates(message as RecoveryTokenRequest)) as RecoveryTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecoveryTokenRequest create() => RecoveryTokenRequest._();
  @$core.override
  RecoveryTokenRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecoveryTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecoveryTokenRequest>(create);
  static RecoveryTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class RecoveryTokenResponse extends $pb.GeneratedMessage {
  factory RecoveryTokenResponse({
    $core.bool? valid,
    $core.String? email,
  }) {
    final result = create();
    if (valid != null) result.valid = valid;
    if (email != null) result.email = email;
    return result;
  }

  RecoveryTokenResponse._();

  factory RecoveryTokenResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecoveryTokenResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecoveryTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecoveryTokenResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecoveryTokenResponse copyWith(void Function(RecoveryTokenResponse) updates) =>
      super.copyWith((message) => updates(message as RecoveryTokenResponse)) as RecoveryTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecoveryTokenResponse create() => RecoveryTokenResponse._();
  @$core.override
  RecoveryTokenResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecoveryTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecoveryTokenResponse>(create);
  static RecoveryTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);
}

class RecoverAccountRequest extends $pb.GeneratedMessage {
  factory RecoverAccountRequest({
    $core.String? token,
    $core.String? newPassword,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (newPassword != null) result.newPassword = newPassword;
    return result;
  }

  RecoverAccountRequest._();

  factory RecoverAccountRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecoverAccountRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecoverAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecoverAccountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecoverAccountRequest copyWith(void Function(RecoverAccountRequest) updates) =>
      super.copyWith((message) => updates(message as RecoverAccountRequest)) as RecoverAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecoverAccountRequest create() => RecoverAccountRequest._();
  @$core.override
  RecoverAccountRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecoverAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecoverAccountRequest>(create);
  static RecoverAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => $_clearField(2);
}

class ChangePasswordRequest extends $pb.GeneratedMessage {
  factory ChangePasswordRequest({
    $core.String? currentPassword,
    $core.String? newPassword,
  }) {
    final result = create();
    if (currentPassword != null) result.currentPassword = currentPassword;
    if (newPassword != null) result.newPassword = newPassword;
    return result;
  }

  ChangePasswordRequest._();

  factory ChangePasswordRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangePasswordRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangePasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currentPassword')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasswordRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasswordRequest copyWith(void Function(ChangePasswordRequest) updates) =>
      super.copyWith((message) => updates(message as ChangePasswordRequest)) as ChangePasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest create() => ChangePasswordRequest._();
  @$core.override
  ChangePasswordRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePasswordRequest>(create);
  static ChangePasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPassword => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPassword($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPassword() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => $_clearField(2);
}

class BeginPasskeyLoginRequest extends $pb.GeneratedMessage {
  factory BeginPasskeyLoginRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  BeginPasskeyLoginRequest._();

  factory BeginPasskeyLoginRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BeginPasskeyLoginRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BeginPasskeyLoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BeginPasskeyLoginRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BeginPasskeyLoginRequest copyWith(void Function(BeginPasskeyLoginRequest) updates) =>
      super.copyWith((message) => updates(message as BeginPasskeyLoginRequest)) as BeginPasskeyLoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BeginPasskeyLoginRequest create() => BeginPasskeyLoginRequest._();
  @$core.override
  BeginPasskeyLoginRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BeginPasskeyLoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BeginPasskeyLoginRequest>(create);
  static BeginPasskeyLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

/// options_json is the standard WebAuthn options object ({"publicKey": {...}})
class PasskeyOptionsResponse extends $pb.GeneratedMessage {
  factory PasskeyOptionsResponse({
    $core.String? sessionId,
    $core.String? optionsJson,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    if (optionsJson != null) result.optionsJson = optionsJson;
    return result;
  }

  PasskeyOptionsResponse._();

  factory PasskeyOptionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PasskeyOptionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PasskeyOptionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..aOS(2, _omitFieldNames ? '' : 'optionsJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasskeyOptionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasskeyOptionsResponse copyWith(void Function(PasskeyOptionsResponse) updates) =>
      super.copyWith((message) => updates(message as PasskeyOptionsResponse)) as PasskeyOptionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PasskeyOptionsResponse create() => PasskeyOptionsResponse._();
  @$core.override
  PasskeyOptionsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PasskeyOptionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PasskeyOptionsResponse>(create);
  static PasskeyOptionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get optionsJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set optionsJson($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOptionsJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptionsJson() => $_clearField(2);
}

/// credential_json is the standard PublicKeyCredential JSON produced by the browser
class FinishPasskeyRequest extends $pb.GeneratedMessage {
  factory FinishPasskeyRequest({
    $core.String? sessionId,
    $core.String? credentialJson,
    $core.String? name,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    if (credentialJson != null) result.credentialJson = credentialJson;
    if (name != null) result.name = name;
    return result;
  }

  FinishPasskeyRequest._();

  factory FinishPasskeyRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinishPasskeyRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FinishPasskeyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..aOS(2, _omitFieldNames ? '' : 'credentialJson')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinishPasskeyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinishPasskeyRequest copyWith(void Function(FinishPasskeyRequest) updates) =>
      super.copyWith((message) => updates(message as FinishPasskeyRequest)) as FinishPasskeyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinishPasskeyRequest create() => FinishPasskeyRequest._();
  @$core.override
  FinishPasskeyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FinishPasskeyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinishPasskeyRequest>(create);
  static FinishPasskeyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get credentialJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set credentialJson($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCredentialJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearCredentialJson() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);
}

class Passkey extends $pb.GeneratedMessage {
  factory Passkey({
    $fixnum.Int64? id,
    $core.String? name,
    $1.Timestamp? createdAt,
    $1.Timestamp? lastUsedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (createdAt != null) result.createdAt = createdAt;
    if (lastUsedAt != null) result.lastUsedAt = lastUsedAt;
    return result;
  }

  Passkey._();

  factory Passkey.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Passkey.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Passkey', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(2, _omitFieldNames ? '' : 'name')
        ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
        ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'lastUsedAt', subBuilder: $1.Timestamp.create)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Passkey clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Passkey copyWith(void Function(Passkey) updates) => super.copyWith((message) => updates(message as Passkey)) as Passkey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Passkey create() => Passkey._();
  @$core.override
  Passkey createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Passkey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Passkey>(create);
  static Passkey? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureCreatedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get lastUsedAt => $_getN(3);
  @$pb.TagNumber(4)
  set lastUsedAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLastUsedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastUsedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureLastUsedAt() => $_ensure(3);
}

class ListPasskeysResponse extends $pb.GeneratedMessage {
  factory ListPasskeysResponse({
    $core.Iterable<Passkey>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListPasskeysResponse._();

  factory ListPasskeysResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPasskeysResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPasskeysResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Passkey>(1, _omitFieldNames ? '' : 'items', subBuilder: Passkey.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPasskeysResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPasskeysResponse copyWith(void Function(ListPasskeysResponse) updates) =>
      super.copyWith((message) => updates(message as ListPasskeysResponse)) as ListPasskeysResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPasskeysResponse create() => ListPasskeysResponse._();
  @$core.override
  ListPasskeysResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListPasskeysResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPasskeysResponse>(create);
  static ListPasskeysResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Passkey> get items => $_getList(0);
}

class Company extends $pb.GeneratedMessage {
  factory Company({
    $fixnum.Int64? id,
    $core.String? name,
    $core.String? regNumber,
    $core.String? vatNumber,
    $core.String? address,
    $core.String? email,
    $core.String? phone,
    $core.String? iban,
    $core.String? bankName,
    $core.String? currency,
    $core.String? invoicePrefix,
    $core.int? nextInvoiceNumber,
    $core.String? defaultVatRate,
    $core.int? defaultDueDays,
    $core.String? role,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (regNumber != null) result.regNumber = regNumber;
    if (vatNumber != null) result.vatNumber = vatNumber;
    if (address != null) result.address = address;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (iban != null) result.iban = iban;
    if (bankName != null) result.bankName = bankName;
    if (currency != null) result.currency = currency;
    if (invoicePrefix != null) result.invoicePrefix = invoicePrefix;
    if (nextInvoiceNumber != null) result.nextInvoiceNumber = nextInvoiceNumber;
    if (defaultVatRate != null) result.defaultVatRate = defaultVatRate;
    if (defaultDueDays != null) result.defaultDueDays = defaultDueDays;
    if (role != null) result.role = role;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Company._();

  factory Company.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Company.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Company', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(2, _omitFieldNames ? '' : 'name')
        ..aOS(3, _omitFieldNames ? '' : 'regNumber')
        ..aOS(4, _omitFieldNames ? '' : 'vatNumber')
        ..aOS(5, _omitFieldNames ? '' : 'address')
        ..aOS(6, _omitFieldNames ? '' : 'email')
        ..aOS(7, _omitFieldNames ? '' : 'phone')
        ..aOS(8, _omitFieldNames ? '' : 'iban')
        ..aOS(9, _omitFieldNames ? '' : 'bankName')
        ..aOS(10, _omitFieldNames ? '' : 'currency')
        ..aOS(11, _omitFieldNames ? '' : 'invoicePrefix')
        ..aI(12, _omitFieldNames ? '' : 'nextInvoiceNumber', fieldType: $pb.PbFieldType.OU3)
        ..aOS(13, _omitFieldNames ? '' : 'defaultVatRate')
        ..aI(14, _omitFieldNames ? '' : 'defaultDueDays', fieldType: $pb.PbFieldType.OU3)
        ..aOS(15, _omitFieldNames ? '' : 'role')
        ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Company clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Company copyWith(void Function(Company) updates) => super.copyWith((message) => updates(message as Company)) as Company;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Company create() => Company._();
  @$core.override
  Company createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Company getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Company>(create);
  static Company? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get regNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set regNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRegNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearRegNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get vatNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set vatNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVatNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearVatNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get address => $_getSZ(4);
  @$pb.TagNumber(5)
  set address($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddress() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get email => $_getSZ(5);
  @$pb.TagNumber(6)
  set email($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEmail() => $_has(5);
  @$pb.TagNumber(6)
  void clearEmail() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get phone => $_getSZ(6);
  @$pb.TagNumber(7)
  set phone($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhone() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhone() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get iban => $_getSZ(7);
  @$pb.TagNumber(8)
  set iban($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIban() => $_has(7);
  @$pb.TagNumber(8)
  void clearIban() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankName => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBankName() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get invoicePrefix => $_getSZ(10);
  @$pb.TagNumber(11)
  set invoicePrefix($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasInvoicePrefix() => $_has(10);
  @$pb.TagNumber(11)
  void clearInvoicePrefix() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get nextInvoiceNumber => $_getIZ(11);
  @$pb.TagNumber(12)
  set nextInvoiceNumber($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNextInvoiceNumber() => $_has(11);
  @$pb.TagNumber(12)
  void clearNextInvoiceNumber() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get defaultVatRate => $_getSZ(12);
  @$pb.TagNumber(13)
  set defaultVatRate($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasDefaultVatRate() => $_has(12);
  @$pb.TagNumber(13)
  void clearDefaultVatRate() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get defaultDueDays => $_getIZ(13);
  @$pb.TagNumber(14)
  set defaultDueDays($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDefaultDueDays() => $_has(13);
  @$pb.TagNumber(14)
  void clearDefaultDueDays() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get role => $_getSZ(14);
  @$pb.TagNumber(15)
  set role($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasRole() => $_has(14);
  @$pb.TagNumber(15)
  void clearRole() => $_clearField(15);

  @$pb.TagNumber(16)
  $1.Timestamp get createdAt => $_getN(15);
  @$pb.TagNumber(16)
  set createdAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCreatedAt() => $_ensure(15);
}

class ListCompaniesResponse extends $pb.GeneratedMessage {
  factory ListCompaniesResponse({
    $core.Iterable<Company>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListCompaniesResponse._();

  factory ListCompaniesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCompaniesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListCompaniesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Company>(1, _omitFieldNames ? '' : 'items', subBuilder: Company.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCompaniesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCompaniesResponse copyWith(void Function(ListCompaniesResponse) updates) =>
      super.copyWith((message) => updates(message as ListCompaniesResponse)) as ListCompaniesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCompaniesResponse create() => ListCompaniesResponse._();
  @$core.override
  ListCompaniesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListCompaniesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCompaniesResponse>(create);
  static ListCompaniesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Company> get items => $_getList(0);
}

class Project extends $pb.GeneratedMessage {
  factory Project({
    $fixnum.Int64? id,
    $fixnum.Int64? companyId,
    $core.String? name,
    $core.String? email,
    $core.String? description,
    $core.String? contactName,
    $core.String? address,
    $core.String? regNumber,
    $core.String? vatNumber,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $fixnum.Int64? invoicedCents,
    $fixnum.Int64? outstandingCents,
    $core.int? invoiceCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (companyId != null) result.companyId = companyId;
    if (name != null) result.name = name;
    if (email != null) result.email = email;
    if (description != null) result.description = description;
    if (contactName != null) result.contactName = contactName;
    if (address != null) result.address = address;
    if (regNumber != null) result.regNumber = regNumber;
    if (vatNumber != null) result.vatNumber = vatNumber;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (invoicedCents != null) result.invoicedCents = invoicedCents;
    if (outstandingCents != null) result.outstandingCents = outstandingCents;
    if (invoiceCount != null) result.invoiceCount = invoiceCount;
    return result;
  }

  Project._();

  factory Project.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Project.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Project', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(3, _omitFieldNames ? '' : 'name')
        ..aOS(4, _omitFieldNames ? '' : 'email')
        ..aOS(5, _omitFieldNames ? '' : 'description')
        ..aOS(6, _omitFieldNames ? '' : 'contactName')
        ..aOS(7, _omitFieldNames ? '' : 'address')
        ..aOS(8, _omitFieldNames ? '' : 'regNumber')
        ..aOS(9, _omitFieldNames ? '' : 'vatNumber')
        ..aOB(10, _omitFieldNames ? '' : 'isActive')
        ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
        ..aInt64(12, _omitFieldNames ? '' : 'invoicedCents')
        ..aInt64(13, _omitFieldNames ? '' : 'outstandingCents')
        ..aI(14, _omitFieldNames ? '' : 'invoiceCount', fieldType: $pb.PbFieldType.OU3)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Project clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Project copyWith(void Function(Project) updates) => super.copyWith((message) => updates(message as Project)) as Project;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Project create() => Project._();
  @$core.override
  Project createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Project getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Project>(create);
  static Project? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get companyId => $_getI64(1);
  @$pb.TagNumber(2)
  set companyId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompanyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompanyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get contactName => $_getSZ(5);
  @$pb.TagNumber(6)
  set contactName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasContactName() => $_has(5);
  @$pb.TagNumber(6)
  void clearContactName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get address => $_getSZ(6);
  @$pb.TagNumber(7)
  set address($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearAddress() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get regNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set regNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRegNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearRegNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get vatNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set vatNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVatNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearVatNumber() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isActive => $_getBF(9);
  @$pb.TagNumber(10)
  set isActive($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsActive() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsActive() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  /// Aggregates filled by the server on list/get
  @$pb.TagNumber(12)
  $fixnum.Int64 get invoicedCents => $_getI64(11);
  @$pb.TagNumber(12)
  set invoicedCents($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasInvoicedCents() => $_has(11);
  @$pb.TagNumber(12)
  void clearInvoicedCents() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get outstandingCents => $_getI64(12);
  @$pb.TagNumber(13)
  set outstandingCents($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasOutstandingCents() => $_has(12);
  @$pb.TagNumber(13)
  void clearOutstandingCents() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get invoiceCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set invoiceCount($core.int value) => $_setUnsignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasInvoiceCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearInvoiceCount() => $_clearField(14);
}

class ListProjectsRequest extends $pb.GeneratedMessage {
  factory ListProjectsRequest({
    $fixnum.Int64? companyId,
    $core.bool? includeInactive,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (includeInactive != null) result.includeInactive = includeInactive;
    return result;
  }

  ListProjectsRequest._();

  factory ListProjectsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListProjectsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListProjectsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(2, _omitFieldNames ? '' : 'includeInactive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListProjectsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListProjectsRequest copyWith(void Function(ListProjectsRequest) updates) =>
      super.copyWith((message) => updates(message as ListProjectsRequest)) as ListProjectsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListProjectsRequest create() => ListProjectsRequest._();
  @$core.override
  ListProjectsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListProjectsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListProjectsRequest>(create);
  static ListProjectsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includeInactive => $_getBF(1);
  @$pb.TagNumber(2)
  set includeInactive($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIncludeInactive() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeInactive() => $_clearField(2);
}

class ListProjectsResponse extends $pb.GeneratedMessage {
  factory ListProjectsResponse({
    $core.Iterable<Project>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListProjectsResponse._();

  factory ListProjectsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListProjectsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListProjectsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Project>(1, _omitFieldNames ? '' : 'items', subBuilder: Project.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListProjectsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListProjectsResponse copyWith(void Function(ListProjectsResponse) updates) =>
      super.copyWith((message) => updates(message as ListProjectsResponse)) as ListProjectsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListProjectsResponse create() => ListProjectsResponse._();
  @$core.override
  ListProjectsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListProjectsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListProjectsResponse>(create);
  static ListProjectsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Project> get items => $_getList(0);
}

class Category extends $pb.GeneratedMessage {
  factory Category({
    $fixnum.Int64? id,
    $fixnum.Int64? companyId,
    $core.String? name,
    CategoryKind? kind,
    $core.int? sortOrder,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (companyId != null) result.companyId = companyId;
    if (name != null) result.name = name;
    if (kind != null) result.kind = kind;
    if (sortOrder != null) result.sortOrder = sortOrder;
    return result;
  }

  Category._();

  factory Category.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Category.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Category', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(3, _omitFieldNames ? '' : 'name')
        ..aE<CategoryKind>(4, _omitFieldNames ? '' : 'kind', enumValues: CategoryKind.values)
        ..aI(5, _omitFieldNames ? '' : 'sortOrder', fieldType: $pb.PbFieldType.OU3)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Category clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Category copyWith(void Function(Category) updates) => super.copyWith((message) => updates(message as Category)) as Category;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Category create() => Category._();
  @$core.override
  Category createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Category getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Category>(create);
  static Category? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get companyId => $_getI64(1);
  @$pb.TagNumber(2)
  set companyId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompanyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompanyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  CategoryKind get kind => $_getN(3);
  @$pb.TagNumber(4)
  set kind(CategoryKind value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get sortOrder => $_getIZ(4);
  @$pb.TagNumber(5)
  set sortOrder($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSortOrder() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortOrder() => $_clearField(5);
}

class ListCategoriesResponse extends $pb.GeneratedMessage {
  factory ListCategoriesResponse({
    $core.Iterable<Category>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListCategoriesResponse._();

  factory ListCategoriesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCategoriesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Category>(1, _omitFieldNames ? '' : 'items', subBuilder: Category.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCategoriesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCategoriesResponse copyWith(void Function(ListCategoriesResponse) updates) =>
      super.copyWith((message) => updates(message as ListCategoriesResponse)) as ListCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCategoriesResponse create() => ListCategoriesResponse._();
  @$core.override
  ListCategoriesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCategoriesResponse>(create);
  static ListCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Category> get items => $_getList(0);
}

class InvoiceItem extends $pb.GeneratedMessage {
  factory InvoiceItem({
    $fixnum.Int64? id,
    $core.int? position,
    $core.String? description,
    $core.String? quantity,
    $fixnum.Int64? unitPriceCents,
    $core.String? vatRate,
    $fixnum.Int64? netCents,
    $fixnum.Int64? vatCents,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (position != null) result.position = position;
    if (description != null) result.description = description;
    if (quantity != null) result.quantity = quantity;
    if (unitPriceCents != null) result.unitPriceCents = unitPriceCents;
    if (vatRate != null) result.vatRate = vatRate;
    if (netCents != null) result.netCents = netCents;
    if (vatCents != null) result.vatCents = vatCents;
    return result;
  }

  InvoiceItem._();

  factory InvoiceItem.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvoiceItem.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(2, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'quantity')
    ..aInt64(5, _omitFieldNames ? '' : 'unitPriceCents')
    ..aOS(6, _omitFieldNames ? '' : 'vatRate')
    ..aInt64(7, _omitFieldNames ? '' : 'netCents')
    ..aInt64(8, _omitFieldNames ? '' : 'vatCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoiceItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoiceItem copyWith(void Function(InvoiceItem) updates) => super.copyWith((message) => updates(message as InvoiceItem)) as InvoiceItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceItem create() => InvoiceItem._();
  @$core.override
  InvoiceItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InvoiceItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceItem>(create);
  static InvoiceItem? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get position => $_getIZ(1);
  @$pb.TagNumber(2)
  set position($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get quantity => $_getSZ(3);
  @$pb.TagNumber(4)
  set quantity($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPriceCents => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPriceCents($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUnitPriceCents() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPriceCents() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get vatRate => $_getSZ(5);
  @$pb.TagNumber(6)
  set vatRate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVatRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearVatRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get netCents => $_getI64(6);
  @$pb.TagNumber(7)
  set netCents($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNetCents() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetCents() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get vatCents => $_getI64(7);
  @$pb.TagNumber(8)
  set vatCents($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVatCents() => $_has(7);
  @$pb.TagNumber(8)
  void clearVatCents() => $_clearField(8);
}

class Invoice extends $pb.GeneratedMessage {
  factory Invoice({
    $fixnum.Int64? id,
    $fixnum.Int64? companyId,
    $fixnum.Int64? projectId,
    $core.String? projectName,
    $core.String? number,
    InvoiceStatus? status,
    $core.String? issueDate,
    $core.String? dueDate,
    $core.String? currency,
    $fixnum.Int64? subtotalCents,
    $fixnum.Int64? vatCents,
    $fixnum.Int64? totalCents,
    $core.String? notes,
    $core.String? reference,
    $1.Timestamp? paidAt,
    $fixnum.Int64? paidTransactionId,
    $1.Timestamp? sentAt,
    $1.Timestamp? createdAt,
    $core.Iterable<InvoiceItem>? items,
    $core.bool? isOverdue,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (companyId != null) result.companyId = companyId;
    if (projectId != null) result.projectId = projectId;
    if (projectName != null) result.projectName = projectName;
    if (number != null) result.number = number;
    if (status != null) result.status = status;
    if (issueDate != null) result.issueDate = issueDate;
    if (dueDate != null) result.dueDate = dueDate;
    if (currency != null) result.currency = currency;
    if (subtotalCents != null) result.subtotalCents = subtotalCents;
    if (vatCents != null) result.vatCents = vatCents;
    if (totalCents != null) result.totalCents = totalCents;
    if (notes != null) result.notes = notes;
    if (reference != null) result.reference = reference;
    if (paidAt != null) result.paidAt = paidAt;
    if (paidTransactionId != null) result.paidTransactionId = paidTransactionId;
    if (sentAt != null) result.sentAt = sentAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (items != null) result.items.addAll(items);
    if (isOverdue != null) result.isOverdue = isOverdue;
    return result;
  }

  Invoice._();

  factory Invoice.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Invoice.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Invoice', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'projectId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(4, _omitFieldNames ? '' : 'projectName')
        ..aOS(5, _omitFieldNames ? '' : 'number')
        ..aE<InvoiceStatus>(6, _omitFieldNames ? '' : 'status', enumValues: InvoiceStatus.values)
        ..aOS(7, _omitFieldNames ? '' : 'issueDate')
        ..aOS(8, _omitFieldNames ? '' : 'dueDate')
        ..aOS(9, _omitFieldNames ? '' : 'currency')
        ..aInt64(10, _omitFieldNames ? '' : 'subtotalCents')
        ..aInt64(11, _omitFieldNames ? '' : 'vatCents')
        ..aInt64(12, _omitFieldNames ? '' : 'totalCents')
        ..aOS(13, _omitFieldNames ? '' : 'notes')
        ..aOS(14, _omitFieldNames ? '' : 'reference')
        ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'paidAt', subBuilder: $1.Timestamp.create)
        ..a<$fixnum.Int64>(16, _omitFieldNames ? '' : 'paidTransactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'sentAt', subBuilder: $1.Timestamp.create)
        ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
        ..pPM<InvoiceItem>(19, _omitFieldNames ? '' : 'items', subBuilder: InvoiceItem.create)
        ..aOB(20, _omitFieldNames ? '' : 'isOverdue')
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Invoice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Invoice copyWith(void Function(Invoice) updates) => super.copyWith((message) => updates(message as Invoice)) as Invoice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Invoice create() => Invoice._();
  @$core.override
  Invoice createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Invoice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invoice>(create);
  static Invoice? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get companyId => $_getI64(1);
  @$pb.TagNumber(2)
  set companyId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompanyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompanyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get projectId => $_getI64(2);
  @$pb.TagNumber(3)
  set projectId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProjectId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProjectId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get projectName => $_getSZ(3);
  @$pb.TagNumber(4)
  set projectName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProjectName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProjectName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get number => $_getSZ(4);
  @$pb.TagNumber(5)
  set number($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  InvoiceStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(InvoiceStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get issueDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set issueDate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIssueDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearIssueDate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get dueDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set dueDate($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDueDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearDueDate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get subtotalCents => $_getI64(9);
  @$pb.TagNumber(10)
  set subtotalCents($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSubtotalCents() => $_has(9);
  @$pb.TagNumber(10)
  void clearSubtotalCents() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get vatCents => $_getI64(10);
  @$pb.TagNumber(11)
  set vatCents($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasVatCents() => $_has(10);
  @$pb.TagNumber(11)
  void clearVatCents() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get totalCents => $_getI64(11);
  @$pb.TagNumber(12)
  set totalCents($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTotalCents() => $_has(11);
  @$pb.TagNumber(12)
  void clearTotalCents() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get notes => $_getSZ(12);
  @$pb.TagNumber(13)
  set notes($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasNotes() => $_has(12);
  @$pb.TagNumber(13)
  void clearNotes() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get reference => $_getSZ(13);
  @$pb.TagNumber(14)
  set reference($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearReference() => $_clearField(14);

  @$pb.TagNumber(15)
  $1.Timestamp get paidAt => $_getN(14);
  @$pb.TagNumber(15)
  set paidAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasPaidAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearPaidAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensurePaidAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $fixnum.Int64 get paidTransactionId => $_getI64(15);
  @$pb.TagNumber(16)
  set paidTransactionId($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasPaidTransactionId() => $_has(15);
  @$pb.TagNumber(16)
  void clearPaidTransactionId() => $_clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get sentAt => $_getN(16);
  @$pb.TagNumber(17)
  set sentAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasSentAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearSentAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureSentAt() => $_ensure(16);

  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $pb.PbList<InvoiceItem> get items => $_getList(18);

  @$pb.TagNumber(20)
  $core.bool get isOverdue => $_getBF(19);
  @$pb.TagNumber(20)
  set isOverdue($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(20)
  $core.bool hasIsOverdue() => $_has(19);
  @$pb.TagNumber(20)
  void clearIsOverdue() => $_clearField(20);
}

class ListInvoicesRequest extends $pb.GeneratedMessage {
  factory ListInvoicesRequest({
    $fixnum.Int64? companyId,
    InvoiceStatus? status,
    $fixnum.Int64? projectId,
    $core.bool? onlyOverdue,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (status != null) result.status = status;
    if (projectId != null) result.projectId = projectId;
    if (onlyOverdue != null) result.onlyOverdue = onlyOverdue;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListInvoicesRequest._();

  factory ListInvoicesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListInvoicesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInvoicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<InvoiceStatus>(2, _omitFieldNames ? '' : 'status', enumValues: InvoiceStatus.values)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'projectId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(4, _omitFieldNames ? '' : 'onlyOverdue')
    ..aI(5, _omitFieldNames ? '' : 'page', fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'pageSize', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInvoicesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInvoicesRequest copyWith(void Function(ListInvoicesRequest) updates) =>
      super.copyWith((message) => updates(message as ListInvoicesRequest)) as ListInvoicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInvoicesRequest create() => ListInvoicesRequest._();
  @$core.override
  ListInvoicesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInvoicesRequest>(create);
  static ListInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  InvoiceStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(InvoiceStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get projectId => $_getI64(2);
  @$pb.TagNumber(3)
  set projectId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProjectId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProjectId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get onlyOverdue => $_getBF(3);
  @$pb.TagNumber(4)
  set onlyOverdue($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOnlyOverdue() => $_has(3);
  @$pb.TagNumber(4)
  void clearOnlyOverdue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get page => $_getIZ(4);
  @$pb.TagNumber(5)
  set page($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get pageSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set pageSize($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPageSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageSize() => $_clearField(6);
}

class ListInvoicesResponse extends $pb.GeneratedMessage {
  factory ListInvoicesResponse({
    $core.Iterable<Invoice>? items,
    $core.int? total,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (total != null) result.total = total;
    return result;
  }

  ListInvoicesResponse._();

  factory ListInvoicesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListInvoicesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInvoicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Invoice>(1, _omitFieldNames ? '' : 'items', subBuilder: Invoice.create)
    ..aI(2, _omitFieldNames ? '' : 'total', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInvoicesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInvoicesResponse copyWith(void Function(ListInvoicesResponse) updates) =>
      super.copyWith((message) => updates(message as ListInvoicesResponse)) as ListInvoicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInvoicesResponse create() => ListInvoicesResponse._();
  @$core.override
  ListInvoicesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInvoicesResponse>(create);
  static ListInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Invoice> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class MarkInvoicePaidRequest extends $pb.GeneratedMessage {
  factory MarkInvoicePaidRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? id,
    $fixnum.Int64? transactionId,
    $core.String? paidDate,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (id != null) result.id = id;
    if (transactionId != null) result.transactionId = transactionId;
    if (paidDate != null) result.paidDate = paidDate;
    return result;
  }

  MarkInvoicePaidRequest._();

  factory MarkInvoicePaidRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkInvoicePaidRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkInvoicePaidRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'paidDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkInvoicePaidRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkInvoicePaidRequest copyWith(void Function(MarkInvoicePaidRequest) updates) =>
      super.copyWith((message) => updates(message as MarkInvoicePaidRequest)) as MarkInvoicePaidRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkInvoicePaidRequest create() => MarkInvoicePaidRequest._();
  @$core.override
  MarkInvoicePaidRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MarkInvoicePaidRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkInvoicePaidRequest>(create);
  static MarkInvoicePaidRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get id => $_getI64(1);
  @$pb.TagNumber(2)
  set id($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get transactionId => $_getI64(2);
  @$pb.TagNumber(3)
  set transactionId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paidDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set paidDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaidDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaidDate() => $_clearField(4);
}

class ConfigField extends $pb.GeneratedMessage {
  factory ConfigField({
    $core.String? key,
    $core.String? label,
    $core.String? hint,
    FieldKind? kind,
    $core.Iterable<$core.String>? options,
    $core.bool? required,
    $core.String? defaultValue,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (label != null) result.label = label;
    if (hint != null) result.hint = hint;
    if (kind != null) result.kind = kind;
    if (options != null) result.options.addAll(options);
    if (required != null) result.required = required;
    if (defaultValue != null) result.defaultValue = defaultValue;
    return result;
  }

  ConfigField._();

  factory ConfigField.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfigField.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConfigField',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aOS(3, _omitFieldNames ? '' : 'hint')
    ..aE<FieldKind>(4, _omitFieldNames ? '' : 'kind', enumValues: FieldKind.values)
    ..pPS(5, _omitFieldNames ? '' : 'options')
    ..aOB(6, _omitFieldNames ? '' : 'required')
    ..aOS(7, _omitFieldNames ? '' : 'defaultValue')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfigField clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfigField copyWith(void Function(ConfigField) updates) => super.copyWith((message) => updates(message as ConfigField)) as ConfigField;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigField create() => ConfigField._();
  @$core.override
  ConfigField createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ConfigField getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfigField>(create);
  static ConfigField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get hint => $_getSZ(2);
  @$pb.TagNumber(3)
  set hint($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHint() => $_has(2);
  @$pb.TagNumber(3)
  void clearHint() => $_clearField(3);

  @$pb.TagNumber(4)
  FieldKind get kind => $_getN(3);
  @$pb.TagNumber(4)
  set kind(FieldKind value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get options => $_getList(4);

  @$pb.TagNumber(6)
  $core.bool get required => $_getBF(5);
  @$pb.TagNumber(6)
  set required($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRequired() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequired() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get defaultValue => $_getSZ(6);
  @$pb.TagNumber(7)
  set defaultValue($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDefaultValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearDefaultValue() => $_clearField(7);
}

class BankProvider extends $pb.GeneratedMessage {
  factory BankProvider({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.Iterable<ConfigField>? configFields,
    $core.bool? needsRedirect,
    $core.bool? hasInstitutions,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (configFields != null) result.configFields.addAll(configFields);
    if (needsRedirect != null) result.needsRedirect = needsRedirect;
    if (hasInstitutions != null) result.hasInstitutions = hasInstitutions;
    return result;
  }

  BankProvider._();

  factory BankProvider.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BankProvider.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BankProvider',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPM<ConfigField>(4, _omitFieldNames ? '' : 'configFields', subBuilder: ConfigField.create)
    ..aOB(5, _omitFieldNames ? '' : 'needsRedirect')
    ..aOB(6, _omitFieldNames ? '' : 'hasInstitutions')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankProvider clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankProvider copyWith(void Function(BankProvider) updates) => super.copyWith((message) => updates(message as BankProvider)) as BankProvider;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BankProvider create() => BankProvider._();
  @$core.override
  BankProvider createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BankProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BankProvider>(create);
  static BankProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<ConfigField> get configFields => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get needsRedirect => $_getBF(4);
  @$pb.TagNumber(5)
  set needsRedirect($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNeedsRedirect() => $_has(4);
  @$pb.TagNumber(5)
  void clearNeedsRedirect() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasInstitutions => $_getBF(5);
  @$pb.TagNumber(6)
  set hasInstitutions($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHasInstitutions() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasInstitutions() => $_clearField(6);
}

class ListBankProvidersResponse extends $pb.GeneratedMessage {
  factory ListBankProvidersResponse({
    $core.Iterable<BankProvider>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListBankProvidersResponse._();

  factory ListBankProvidersResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBankProvidersResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListBankProvidersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<BankProvider>(1, _omitFieldNames ? '' : 'items', subBuilder: BankProvider.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBankProvidersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBankProvidersResponse copyWith(void Function(ListBankProvidersResponse) updates) =>
      super.copyWith((message) => updates(message as ListBankProvidersResponse)) as ListBankProvidersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBankProvidersResponse create() => ListBankProvidersResponse._();
  @$core.override
  ListBankProvidersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListBankProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListBankProvidersResponse>(create);
  static ListBankProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BankProvider> get items => $_getList(0);
}

class ListInstitutionsRequest extends $pb.GeneratedMessage {
  factory ListInstitutionsRequest({
    $fixnum.Int64? companyId,
    $core.String? provider,
    $core.String? country,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? config,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (provider != null) result.provider = provider;
    if (country != null) result.country = country;
    if (config != null) result.config.addEntries(config);
    return result;
  }

  ListInstitutionsRequest._();

  factory ListInstitutionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListInstitutionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInstitutionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..aOS(3, _omitFieldNames ? '' : 'country')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'config',
        entryClassName: 'ListInstitutionsRequest.ConfigEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('accounting'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInstitutionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInstitutionsRequest copyWith(void Function(ListInstitutionsRequest) updates) =>
      super.copyWith((message) => updates(message as ListInstitutionsRequest)) as ListInstitutionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInstitutionsRequest create() => ListInstitutionsRequest._();
  @$core.override
  ListInstitutionsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListInstitutionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInstitutionsRequest>(create);
  static ListInstitutionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get config => $_getMap(3);
}

class Institution extends $pb.GeneratedMessage {
  factory Institution({
    $core.String? id,
    $core.String? name,
    $core.String? bic,
    $core.String? logoUrl,
    $core.int? transactionTotalDays,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (bic != null) result.bic = bic;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (transactionTotalDays != null) result.transactionTotalDays = transactionTotalDays;
    return result;
  }

  Institution._();

  factory Institution.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Institution.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Institution',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'bic')
    ..aOS(4, _omitFieldNames ? '' : 'logoUrl')
    ..aI(5, _omitFieldNames ? '' : 'transactionTotalDays', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Institution clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Institution copyWith(void Function(Institution) updates) => super.copyWith((message) => updates(message as Institution)) as Institution;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Institution create() => Institution._();
  @$core.override
  Institution createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Institution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Institution>(create);
  static Institution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bic => $_getSZ(2);
  @$pb.TagNumber(3)
  set bic($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBic() => $_has(2);
  @$pb.TagNumber(3)
  void clearBic() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionTotalDays => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionTotalDays($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionTotalDays() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionTotalDays() => $_clearField(5);
}

class ListInstitutionsResponse extends $pb.GeneratedMessage {
  factory ListInstitutionsResponse({
    $core.Iterable<Institution>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListInstitutionsResponse._();

  factory ListInstitutionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListInstitutionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInstitutionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Institution>(1, _omitFieldNames ? '' : 'items', subBuilder: Institution.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInstitutionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInstitutionsResponse copyWith(void Function(ListInstitutionsResponse) updates) =>
      super.copyWith((message) => updates(message as ListInstitutionsResponse)) as ListInstitutionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInstitutionsResponse create() => ListInstitutionsResponse._();
  @$core.override
  ListInstitutionsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListInstitutionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInstitutionsResponse>(create);
  static ListInstitutionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Institution> get items => $_getList(0);
}

class BankConnection extends $pb.GeneratedMessage {
  factory BankConnection({
    $fixnum.Int64? id,
    $fixnum.Int64? companyId,
    $core.String? provider,
    $core.String? providerName,
    $core.String? name,
    ConnectionStatus? status,
    $core.String? statusMessage,
    $1.Timestamp? consentExpiresAt,
    $1.Timestamp? lastSyncAt,
    $1.Timestamp? createdAt,
    $core.int? accountCount,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? config,
    $core.bool? statementsOnly,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (companyId != null) result.companyId = companyId;
    if (provider != null) result.provider = provider;
    if (providerName != null) result.providerName = providerName;
    if (name != null) result.name = name;
    if (status != null) result.status = status;
    if (statusMessage != null) result.statusMessage = statusMessage;
    if (consentExpiresAt != null) result.consentExpiresAt = consentExpiresAt;
    if (lastSyncAt != null) result.lastSyncAt = lastSyncAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (accountCount != null) result.accountCount = accountCount;
    if (config != null) result.config.addEntries(config);
    if (statementsOnly != null) result.statementsOnly = statementsOnly;
    return result;
  }

  BankConnection._();

  factory BankConnection.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BankConnection.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BankConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..aOS(4, _omitFieldNames ? '' : 'providerName')
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..aE<ConnectionStatus>(6, _omitFieldNames ? '' : 'status', enumValues: ConnectionStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'statusMessage')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'consentExpiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'lastSyncAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aI(11, _omitFieldNames ? '' : 'accountCount', fieldType: $pb.PbFieldType.OU3)
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'config',
        entryClassName: 'BankConnection.ConfigEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('accounting'))
    ..aOB(13, _omitFieldNames ? '' : 'statementsOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankConnection copyWith(void Function(BankConnection) updates) => super.copyWith((message) => updates(message as BankConnection)) as BankConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BankConnection create() => BankConnection._();
  @$core.override
  BankConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BankConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BankConnection>(create);
  static BankConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get companyId => $_getI64(1);
  @$pb.TagNumber(2)
  set companyId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompanyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompanyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);

  @$pb.TagNumber(6)
  ConnectionStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(ConnectionStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get statusMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set statusMessage($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatusMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatusMessage() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get consentExpiresAt => $_getN(7);
  @$pb.TagNumber(8)
  set consentExpiresAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasConsentExpiresAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearConsentExpiresAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureConsentExpiresAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get lastSyncAt => $_getN(8);
  @$pb.TagNumber(9)
  set lastSyncAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasLastSyncAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastSyncAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureLastSyncAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.int get accountCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set accountCount($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAccountCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAccountCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbMap<$core.String, $core.String> get config => $_getMap(11);

  @$pb.TagNumber(13)
  $core.bool get statementsOnly => $_getBF(12);
  @$pb.TagNumber(13)
  set statementsOnly($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasStatementsOnly() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatementsOnly() => $_clearField(13);
}

class CreateBankConnectionRequest extends $pb.GeneratedMessage {
  factory CreateBankConnectionRequest({
    $fixnum.Int64? companyId,
    $core.String? provider,
    $core.String? name,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? config,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (provider != null) result.provider = provider;
    if (name != null) result.name = name;
    if (config != null) result.config.addEntries(config);
    return result;
  }

  CreateBankConnectionRequest._();

  factory CreateBankConnectionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateBankConnectionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateBankConnectionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'config',
        entryClassName: 'CreateBankConnectionRequest.ConfigEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('accounting'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBankConnectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBankConnectionRequest copyWith(void Function(CreateBankConnectionRequest) updates) =>
      super.copyWith((message) => updates(message as CreateBankConnectionRequest)) as CreateBankConnectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateBankConnectionRequest create() => CreateBankConnectionRequest._();
  @$core.override
  CreateBankConnectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateBankConnectionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBankConnectionRequest>(create);
  static CreateBankConnectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get config => $_getMap(3);
}

class CreateBankConnectionResponse extends $pb.GeneratedMessage {
  factory CreateBankConnectionResponse({
    BankConnection? connection,
    $core.String? redirectUrl,
  }) {
    final result = create();
    if (connection != null) result.connection = connection;
    if (redirectUrl != null) result.redirectUrl = redirectUrl;
    return result;
  }

  CreateBankConnectionResponse._();

  factory CreateBankConnectionResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateBankConnectionResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateBankConnectionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOM<BankConnection>(1, _omitFieldNames ? '' : 'connection', subBuilder: BankConnection.create)
    ..aOS(2, _omitFieldNames ? '' : 'redirectUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBankConnectionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateBankConnectionResponse copyWith(void Function(CreateBankConnectionResponse) updates) =>
      super.copyWith((message) => updates(message as CreateBankConnectionResponse)) as CreateBankConnectionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateBankConnectionResponse create() => CreateBankConnectionResponse._();
  @$core.override
  CreateBankConnectionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateBankConnectionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBankConnectionResponse>(create);
  static CreateBankConnectionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BankConnection get connection => $_getN(0);
  @$pb.TagNumber(1)
  set connection(BankConnection value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasConnection() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnection() => $_clearField(1);
  @$pb.TagNumber(1)
  BankConnection ensureConnection() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get redirectUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set redirectUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRedirectUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedirectUrl() => $_clearField(2);
}

/// Empty values keep the stored setting, so secrets never need to be re-entered.
class UpdateBankConnectionRequest extends $pb.GeneratedMessage {
  factory UpdateBankConnectionRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? id,
    $core.String? name,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? config,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (config != null) result.config.addEntries(config);
    return result;
  }

  UpdateBankConnectionRequest._();

  factory UpdateBankConnectionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBankConnectionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateBankConnectionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'config',
        entryClassName: 'UpdateBankConnectionRequest.ConfigEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('accounting'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBankConnectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBankConnectionRequest copyWith(void Function(UpdateBankConnectionRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateBankConnectionRequest)) as UpdateBankConnectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBankConnectionRequest create() => UpdateBankConnectionRequest._();
  @$core.override
  UpdateBankConnectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateBankConnectionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBankConnectionRequest>(create);
  static UpdateBankConnectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get id => $_getI64(1);
  @$pb.TagNumber(2)
  set id($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get config => $_getMap(3);
}

class CompleteBankConnectionRequest extends $pb.GeneratedMessage {
  factory CompleteBankConnectionRequest({
    $core.String? reference,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? params,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    if (params != null) result.params.addEntries(params);
    return result;
  }

  CompleteBankConnectionRequest._();

  factory CompleteBankConnectionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteBankConnectionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompleteBankConnectionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'params',
        entryClassName: 'CompleteBankConnectionRequest.ParamsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('accounting'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteBankConnectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteBankConnectionRequest copyWith(void Function(CompleteBankConnectionRequest) updates) =>
      super.copyWith((message) => updates(message as CompleteBankConnectionRequest)) as CompleteBankConnectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteBankConnectionRequest create() => CompleteBankConnectionRequest._();
  @$core.override
  CompleteBankConnectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CompleteBankConnectionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteBankConnectionRequest>(create);
  static CompleteBankConnectionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get params => $_getMap(1);
}

class ListBankConnectionsResponse extends $pb.GeneratedMessage {
  factory ListBankConnectionsResponse({
    $core.Iterable<BankConnection>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListBankConnectionsResponse._();

  factory ListBankConnectionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBankConnectionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListBankConnectionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<BankConnection>(1, _omitFieldNames ? '' : 'items', subBuilder: BankConnection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBankConnectionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBankConnectionsResponse copyWith(void Function(ListBankConnectionsResponse) updates) =>
      super.copyWith((message) => updates(message as ListBankConnectionsResponse)) as ListBankConnectionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBankConnectionsResponse create() => ListBankConnectionsResponse._();
  @$core.override
  ListBankConnectionsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListBankConnectionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListBankConnectionsResponse>(create);
  static ListBankConnectionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BankConnection> get items => $_getList(0);
}

class BankAccount extends $pb.GeneratedMessage {
  factory BankAccount({
    $fixnum.Int64? id,
    $fixnum.Int64? connectionId,
    $fixnum.Int64? companyId,
    $core.String? name,
    $core.String? iban,
    $core.String? currency,
    $fixnum.Int64? balanceCents,
    $1.Timestamp? balanceAt,
    $core.bool? isPrimary,
    $core.String? provider,
    $core.String? connectionName,
    ConnectionStatus? connectionStatus,
    $1.Timestamp? consentExpiresAt,
    $1.Timestamp? lastSyncAt,
    $core.int? unexplainedCount,
    $core.int? forApprovalCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (connectionId != null) result.connectionId = connectionId;
    if (companyId != null) result.companyId = companyId;
    if (name != null) result.name = name;
    if (iban != null) result.iban = iban;
    if (currency != null) result.currency = currency;
    if (balanceCents != null) result.balanceCents = balanceCents;
    if (balanceAt != null) result.balanceAt = balanceAt;
    if (isPrimary != null) result.isPrimary = isPrimary;
    if (provider != null) result.provider = provider;
    if (connectionName != null) result.connectionName = connectionName;
    if (connectionStatus != null) result.connectionStatus = connectionStatus;
    if (consentExpiresAt != null) result.consentExpiresAt = consentExpiresAt;
    if (lastSyncAt != null) result.lastSyncAt = lastSyncAt;
    if (unexplainedCount != null) result.unexplainedCount = unexplainedCount;
    if (forApprovalCount != null) result.forApprovalCount = forApprovalCount;
    return result;
  }

  BankAccount._();

  factory BankAccount.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BankAccount.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BankAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'connectionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'iban')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aInt64(7, _omitFieldNames ? '' : 'balanceCents')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'balanceAt', subBuilder: $1.Timestamp.create)
    ..aOB(9, _omitFieldNames ? '' : 'isPrimary')
    ..aOS(10, _omitFieldNames ? '' : 'provider')
    ..aOS(11, _omitFieldNames ? '' : 'connectionName')
    ..aE<ConnectionStatus>(12, _omitFieldNames ? '' : 'connectionStatus', enumValues: ConnectionStatus.values)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'consentExpiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'lastSyncAt', subBuilder: $1.Timestamp.create)
    ..aI(15, _omitFieldNames ? '' : 'unexplainedCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(16, _omitFieldNames ? '' : 'forApprovalCount', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankAccount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BankAccount copyWith(void Function(BankAccount) updates) => super.copyWith((message) => updates(message as BankAccount)) as BankAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BankAccount create() => BankAccount._();
  @$core.override
  BankAccount createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BankAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BankAccount>(create);
  static BankAccount? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get connectionId => $_getI64(1);
  @$pb.TagNumber(2)
  set connectionId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConnectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConnectionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get companyId => $_getI64(2);
  @$pb.TagNumber(3)
  set companyId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompanyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompanyId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get iban => $_getSZ(4);
  @$pb.TagNumber(5)
  set iban($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIban() => $_has(4);
  @$pb.TagNumber(5)
  void clearIban() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get balanceCents => $_getI64(6);
  @$pb.TagNumber(7)
  set balanceCents($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBalanceCents() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceCents() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get balanceAt => $_getN(7);
  @$pb.TagNumber(8)
  set balanceAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasBalanceAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearBalanceAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureBalanceAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get isPrimary => $_getBF(8);
  @$pb.TagNumber(9)
  set isPrimary($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsPrimary() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPrimary() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get provider => $_getSZ(9);
  @$pb.TagNumber(10)
  set provider($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProvider() => $_has(9);
  @$pb.TagNumber(10)
  void clearProvider() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get connectionName => $_getSZ(10);
  @$pb.TagNumber(11)
  set connectionName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasConnectionName() => $_has(10);
  @$pb.TagNumber(11)
  void clearConnectionName() => $_clearField(11);

  @$pb.TagNumber(12)
  ConnectionStatus get connectionStatus => $_getN(11);
  @$pb.TagNumber(12)
  set connectionStatus(ConnectionStatus value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasConnectionStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearConnectionStatus() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get consentExpiresAt => $_getN(12);
  @$pb.TagNumber(13)
  set consentExpiresAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasConsentExpiresAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearConsentExpiresAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureConsentExpiresAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get lastSyncAt => $_getN(13);
  @$pb.TagNumber(14)
  set lastSyncAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasLastSyncAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastSyncAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureLastSyncAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.int get unexplainedCount => $_getIZ(14);
  @$pb.TagNumber(15)
  set unexplainedCount($core.int value) => $_setUnsignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasUnexplainedCount() => $_has(14);
  @$pb.TagNumber(15)
  void clearUnexplainedCount() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get forApprovalCount => $_getIZ(15);
  @$pb.TagNumber(16)
  set forApprovalCount($core.int value) => $_setUnsignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasForApprovalCount() => $_has(15);
  @$pb.TagNumber(16)
  void clearForApprovalCount() => $_clearField(16);
}

class ListBankAccountsResponse extends $pb.GeneratedMessage {
  factory ListBankAccountsResponse({
    $core.Iterable<BankAccount>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListBankAccountsResponse._();

  factory ListBankAccountsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBankAccountsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListBankAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<BankAccount>(1, _omitFieldNames ? '' : 'items', subBuilder: BankAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBankAccountsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBankAccountsResponse copyWith(void Function(ListBankAccountsResponse) updates) =>
      super.copyWith((message) => updates(message as ListBankAccountsResponse)) as ListBankAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBankAccountsResponse create() => ListBankAccountsResponse._();
  @$core.override
  ListBankAccountsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListBankAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListBankAccountsResponse>(create);
  static ListBankAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BankAccount> get items => $_getList(0);
}

class SyncNowResponse extends $pb.GeneratedMessage {
  factory SyncNowResponse({
    $core.int? connectionsSynced,
    $core.int? transactionsAdded,
    $core.int? invoicesMatched,
    $core.Iterable<$core.String>? errors,
  }) {
    final result = create();
    if (connectionsSynced != null) result.connectionsSynced = connectionsSynced;
    if (transactionsAdded != null) result.transactionsAdded = transactionsAdded;
    if (invoicesMatched != null) result.invoicesMatched = invoicesMatched;
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  SyncNowResponse._();

  factory SyncNowResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncNowResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncNowResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'connectionsSynced', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'transactionsAdded', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'invoicesMatched', fieldType: $pb.PbFieldType.OU3)
    ..pPS(4, _omitFieldNames ? '' : 'errors')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncNowResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncNowResponse copyWith(void Function(SyncNowResponse) updates) => super.copyWith((message) => updates(message as SyncNowResponse)) as SyncNowResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncNowResponse create() => SyncNowResponse._();
  @$core.override
  SyncNowResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncNowResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncNowResponse>(create);
  static SyncNowResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get connectionsSynced => $_getIZ(0);
  @$pb.TagNumber(1)
  set connectionsSynced($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConnectionsSynced() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnectionsSynced() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get transactionsAdded => $_getIZ(1);
  @$pb.TagNumber(2)
  set transactionsAdded($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionsAdded() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionsAdded() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get invoicesMatched => $_getIZ(2);
  @$pb.TagNumber(3)
  set invoicesMatched($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInvoicesMatched() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvoicesMatched() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get errors => $_getList(3);
}

/// A CSV statement downloaded from the bank; rows already imported are skipped.
class UploadStatementRequest extends $pb.GeneratedMessage {
  factory UploadStatementRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? accountId,
    $core.String? filename,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (accountId != null) result.accountId = accountId;
    if (filename != null) result.filename = filename;
    if (data != null) result.data = data;
    return result;
  }

  UploadStatementRequest._();

  factory UploadStatementRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadStatementRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadStatementRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'filename')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadStatementRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadStatementRequest copyWith(void Function(UploadStatementRequest) updates) =>
      super.copyWith((message) => updates(message as UploadStatementRequest)) as UploadStatementRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadStatementRequest create() => UploadStatementRequest._();
  @$core.override
  UploadStatementRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadStatementRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadStatementRequest>(create);
  static UploadStatementRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get accountId => $_getI64(1);
  @$pb.TagNumber(2)
  set accountId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get filename => $_getSZ(2);
  @$pb.TagNumber(3)
  set filename($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFilename() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilename() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => $_clearField(4);
}

class UploadStatementResponse extends $pb.GeneratedMessage {
  factory UploadStatementResponse({
    $core.int? imported,
    $core.int? duplicates,
    $core.int? skipped,
    $core.int? invoicesMatched,
    $core.Iterable<$core.String>? warnings,
  }) {
    final result = create();
    if (imported != null) result.imported = imported;
    if (duplicates != null) result.duplicates = duplicates;
    if (skipped != null) result.skipped = skipped;
    if (invoicesMatched != null) result.invoicesMatched = invoicesMatched;
    if (warnings != null) result.warnings.addAll(warnings);
    return result;
  }

  UploadStatementResponse._();

  factory UploadStatementResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadStatementResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadStatementResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'imported', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'duplicates', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'skipped', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'invoicesMatched', fieldType: $pb.PbFieldType.OU3)
    ..pPS(5, _omitFieldNames ? '' : 'warnings')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadStatementResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadStatementResponse copyWith(void Function(UploadStatementResponse) updates) =>
      super.copyWith((message) => updates(message as UploadStatementResponse)) as UploadStatementResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadStatementResponse create() => UploadStatementResponse._();
  @$core.override
  UploadStatementResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadStatementResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadStatementResponse>(create);
  static UploadStatementResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get imported => $_getIZ(0);
  @$pb.TagNumber(1)
  set imported($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImported() => $_has(0);
  @$pb.TagNumber(1)
  void clearImported() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get duplicates => $_getIZ(1);
  @$pb.TagNumber(2)
  set duplicates($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDuplicates() => $_has(1);
  @$pb.TagNumber(2)
  void clearDuplicates() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get skipped => $_getIZ(2);
  @$pb.TagNumber(3)
  set skipped($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSkipped() => $_has(2);
  @$pb.TagNumber(3)
  void clearSkipped() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get invoicesMatched => $_getIZ(3);
  @$pb.TagNumber(4)
  set invoicesMatched($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInvoicesMatched() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvoicesMatched() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get warnings => $_getList(4);
}

class BalanceHistoryRequest extends $pb.GeneratedMessage {
  factory BalanceHistoryRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? accountId,
    $core.int? months,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (accountId != null) result.accountId = accountId;
    if (months != null) result.months = months;
    return result;
  }

  BalanceHistoryRequest._();

  factory BalanceHistoryRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BalanceHistoryRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BalanceHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(3, _omitFieldNames ? '' : 'months', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalanceHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalanceHistoryRequest copyWith(void Function(BalanceHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as BalanceHistoryRequest)) as BalanceHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BalanceHistoryRequest create() => BalanceHistoryRequest._();
  @$core.override
  BalanceHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BalanceHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceHistoryRequest>(create);
  static BalanceHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get accountId => $_getI64(1);
  @$pb.TagNumber(2)
  set accountId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get months => $_getIZ(2);
  @$pb.TagNumber(3)
  set months($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMonths() => $_has(2);
  @$pb.TagNumber(3)
  void clearMonths() => $_clearField(3);
}

class BalancePoint extends $pb.GeneratedMessage {
  factory BalancePoint({
    $core.String? month,
    $fixnum.Int64? balanceCents,
  }) {
    final result = create();
    if (month != null) result.month = month;
    if (balanceCents != null) result.balanceCents = balanceCents;
    return result;
  }

  BalancePoint._();

  factory BalancePoint.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BalancePoint.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BalancePoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'month')
    ..aInt64(2, _omitFieldNames ? '' : 'balanceCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalancePoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalancePoint copyWith(void Function(BalancePoint) updates) => super.copyWith((message) => updates(message as BalancePoint)) as BalancePoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BalancePoint create() => BalancePoint._();
  @$core.override
  BalancePoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BalancePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalancePoint>(create);
  static BalancePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get month => $_getSZ(0);
  @$pb.TagNumber(1)
  set month($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonth() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get balanceCents => $_getI64(1);
  @$pb.TagNumber(2)
  set balanceCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBalanceCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalanceCents() => $_clearField(2);
}

class BalanceHistoryResponse extends $pb.GeneratedMessage {
  factory BalanceHistoryResponse({
    $core.Iterable<BalancePoint>? points,
    $core.String? currency,
  }) {
    final result = create();
    if (points != null) result.points.addAll(points);
    if (currency != null) result.currency = currency;
    return result;
  }

  BalanceHistoryResponse._();

  factory BalanceHistoryResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BalanceHistoryResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BalanceHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<BalancePoint>(1, _omitFieldNames ? '' : 'points', subBuilder: BalancePoint.create)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalanceHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalanceHistoryResponse copyWith(void Function(BalanceHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as BalanceHistoryResponse)) as BalanceHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BalanceHistoryResponse create() => BalanceHistoryResponse._();
  @$core.override
  BalanceHistoryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BalanceHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceHistoryResponse>(create);
  static BalanceHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BalancePoint> get points => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);
}

class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $fixnum.Int64? id,
    $fixnum.Int64? accountId,
    $fixnum.Int64? companyId,
    $1.Timestamp? bookedAt,
    $core.String? valueDate,
    $fixnum.Int64? amountCents,
    $core.String? currency,
    $core.String? description,
    $core.String? counterpartyName,
    $core.String? counterpartyIban,
    $core.String? reference,
    $fixnum.Int64? categoryId,
    $core.String? categoryName,
    $core.String? note,
    TransactionStatus? status,
    $fixnum.Int64? invoiceId,
    $core.String? invoiceNumber,
    $core.int? attachmentCount,
    $fixnum.Int64? runningBalanceCents,
    $core.String? accountName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (accountId != null) result.accountId = accountId;
    if (companyId != null) result.companyId = companyId;
    if (bookedAt != null) result.bookedAt = bookedAt;
    if (valueDate != null) result.valueDate = valueDate;
    if (amountCents != null) result.amountCents = amountCents;
    if (currency != null) result.currency = currency;
    if (description != null) result.description = description;
    if (counterpartyName != null) result.counterpartyName = counterpartyName;
    if (counterpartyIban != null) result.counterpartyIban = counterpartyIban;
    if (reference != null) result.reference = reference;
    if (categoryId != null) result.categoryId = categoryId;
    if (categoryName != null) result.categoryName = categoryName;
    if (note != null) result.note = note;
    if (status != null) result.status = status;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (invoiceNumber != null) result.invoiceNumber = invoiceNumber;
    if (attachmentCount != null) result.attachmentCount = attachmentCount;
    if (runningBalanceCents != null) result.runningBalanceCents = runningBalanceCents;
    if (accountName != null) result.accountName = accountName;
    return result;
  }

  Transaction._();

  factory Transaction.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transaction.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'bookedAt', subBuilder: $1.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'valueDate')
    ..aInt64(6, _omitFieldNames ? '' : 'amountCents')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'counterpartyName')
    ..aOS(10, _omitFieldNames ? '' : 'counterpartyIban')
    ..aOS(11, _omitFieldNames ? '' : 'reference')
    ..a<$fixnum.Int64>(12, _omitFieldNames ? '' : 'categoryId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(13, _omitFieldNames ? '' : 'categoryName')
    ..aOS(14, _omitFieldNames ? '' : 'note')
    ..aE<TransactionStatus>(15, _omitFieldNames ? '' : 'status', enumValues: TransactionStatus.values)
    ..a<$fixnum.Int64>(16, _omitFieldNames ? '' : 'invoiceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(17, _omitFieldNames ? '' : 'invoiceNumber')
    ..aI(18, _omitFieldNames ? '' : 'attachmentCount', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(19, _omitFieldNames ? '' : 'runningBalanceCents')
    ..aOS(20, _omitFieldNames ? '' : 'accountName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction copyWith(void Function(Transaction) updates) => super.copyWith((message) => updates(message as Transaction)) as Transaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  @$core.override
  Transaction createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get accountId => $_getI64(1);
  @$pb.TagNumber(2)
  set accountId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get companyId => $_getI64(2);
  @$pb.TagNumber(3)
  set companyId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompanyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompanyId() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get bookedAt => $_getN(3);
  @$pb.TagNumber(4)
  set bookedAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasBookedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearBookedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureBookedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get valueDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set valueDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasValueDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearValueDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amountCents => $_getI64(5);
  @$pb.TagNumber(6)
  set amountCents($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountCents() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountCents() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get counterpartyName => $_getSZ(8);
  @$pb.TagNumber(9)
  set counterpartyName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCounterpartyName() => $_has(8);
  @$pb.TagNumber(9)
  void clearCounterpartyName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get counterpartyIban => $_getSZ(9);
  @$pb.TagNumber(10)
  set counterpartyIban($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCounterpartyIban() => $_has(9);
  @$pb.TagNumber(10)
  void clearCounterpartyIban() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get categoryId => $_getI64(11);
  @$pb.TagNumber(12)
  set categoryId($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCategoryId() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategoryId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get categoryName => $_getSZ(12);
  @$pb.TagNumber(13)
  set categoryName($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCategoryName() => $_has(12);
  @$pb.TagNumber(13)
  void clearCategoryName() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get note => $_getSZ(13);
  @$pb.TagNumber(14)
  set note($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNote() => $_has(13);
  @$pb.TagNumber(14)
  void clearNote() => $_clearField(14);

  @$pb.TagNumber(15)
  TransactionStatus get status => $_getN(14);
  @$pb.TagNumber(15)
  set status(TransactionStatus value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get invoiceId => $_getI64(15);
  @$pb.TagNumber(16)
  set invoiceId($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasInvoiceId() => $_has(15);
  @$pb.TagNumber(16)
  void clearInvoiceId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get invoiceNumber => $_getSZ(16);
  @$pb.TagNumber(17)
  set invoiceNumber($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasInvoiceNumber() => $_has(16);
  @$pb.TagNumber(17)
  void clearInvoiceNumber() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get attachmentCount => $_getIZ(17);
  @$pb.TagNumber(18)
  set attachmentCount($core.int value) => $_setUnsignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasAttachmentCount() => $_has(17);
  @$pb.TagNumber(18)
  void clearAttachmentCount() => $_clearField(18);

  @$pb.TagNumber(19)
  $fixnum.Int64 get runningBalanceCents => $_getI64(18);
  @$pb.TagNumber(19)
  set runningBalanceCents($fixnum.Int64 value) => $_setInt64(18, value);
  @$pb.TagNumber(19)
  $core.bool hasRunningBalanceCents() => $_has(18);
  @$pb.TagNumber(19)
  void clearRunningBalanceCents() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get accountName => $_getSZ(19);
  @$pb.TagNumber(20)
  set accountName($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasAccountName() => $_has(19);
  @$pb.TagNumber(20)
  void clearAccountName() => $_clearField(20);
}

class ListTransactionsRequest extends $pb.GeneratedMessage {
  factory ListTransactionsRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? accountId,
    TransactionStatus? status,
    $core.String? month,
    $core.String? search,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (accountId != null) result.accountId = accountId;
    if (status != null) result.status = status;
    if (month != null) result.month = month;
    if (search != null) result.search = search;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListTransactionsRequest._();

  factory ListTransactionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransactionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<TransactionStatus>(3, _omitFieldNames ? '' : 'status', enumValues: TransactionStatus.values)
    ..aOS(4, _omitFieldNames ? '' : 'month')
    ..aOS(5, _omitFieldNames ? '' : 'search')
    ..aI(6, _omitFieldNames ? '' : 'page', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'pageSize', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsRequest copyWith(void Function(ListTransactionsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTransactionsRequest)) as ListTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransactionsRequest create() => ListTransactionsRequest._();
  @$core.override
  ListTransactionsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransactionsRequest>(create);
  static ListTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get accountId => $_getI64(1);
  @$pb.TagNumber(2)
  set accountId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  TransactionStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(TransactionStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get month => $_getSZ(3);
  @$pb.TagNumber(4)
  set month($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearMonth() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get search => $_getSZ(4);
  @$pb.TagNumber(5)
  set search($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSearch() => $_has(4);
  @$pb.TagNumber(5)
  void clearSearch() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get page => $_getIZ(5);
  @$pb.TagNumber(6)
  set page($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPage() => $_has(5);
  @$pb.TagNumber(6)
  void clearPage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get pageSize => $_getIZ(6);
  @$pb.TagNumber(7)
  set pageSize($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPageSize() => $_has(6);
  @$pb.TagNumber(7)
  void clearPageSize() => $_clearField(7);
}

class ListTransactionsResponse extends $pb.GeneratedMessage {
  factory ListTransactionsResponse({
    $core.Iterable<Transaction>? items,
    $core.int? total,
    $fixnum.Int64? balanceBroughtForwardCents,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (total != null) result.total = total;
    if (balanceBroughtForwardCents != null) result.balanceBroughtForwardCents = balanceBroughtForwardCents;
    return result;
  }

  ListTransactionsResponse._();

  factory ListTransactionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransactionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Transaction>(1, _omitFieldNames ? '' : 'items', subBuilder: Transaction.create)
    ..aI(2, _omitFieldNames ? '' : 'total', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(3, _omitFieldNames ? '' : 'balanceBroughtForwardCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsResponse copyWith(void Function(ListTransactionsResponse) updates) =>
      super.copyWith((message) => updates(message as ListTransactionsResponse)) as ListTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransactionsResponse create() => ListTransactionsResponse._();
  @$core.override
  ListTransactionsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransactionsResponse>(create);
  static ListTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Transaction> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get balanceBroughtForwardCents => $_getI64(2);
  @$pb.TagNumber(3)
  set balanceBroughtForwardCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBalanceBroughtForwardCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalanceBroughtForwardCents() => $_clearField(3);
}

class ExplainTransactionRequest extends $pb.GeneratedMessage {
  factory ExplainTransactionRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? id,
    $fixnum.Int64? categoryId,
    $core.String? note,
    $core.String? description,
    $core.bool? approve,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (id != null) result.id = id;
    if (categoryId != null) result.categoryId = categoryId;
    if (note != null) result.note = note;
    if (description != null) result.description = description;
    if (approve != null) result.approve = approve;
    return result;
  }

  ExplainTransactionRequest._();

  factory ExplainTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExplainTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExplainTransactionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'categoryId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'note')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOB(6, _omitFieldNames ? '' : 'approve')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExplainTransactionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExplainTransactionRequest copyWith(void Function(ExplainTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as ExplainTransactionRequest)) as ExplainTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExplainTransactionRequest create() => ExplainTransactionRequest._();
  @$core.override
  ExplainTransactionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExplainTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExplainTransactionRequest>(create);
  static ExplainTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get id => $_getI64(1);
  @$pb.TagNumber(2)
  set id($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get categoryId => $_getI64(2);
  @$pb.TagNumber(3)
  set categoryId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategoryId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategoryId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get note => $_getSZ(3);
  @$pb.TagNumber(4)
  set note($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNote() => $_has(3);
  @$pb.TagNumber(4)
  void clearNote() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get approve => $_getBF(5);
  @$pb.TagNumber(6)
  set approve($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasApprove() => $_has(5);
  @$pb.TagNumber(6)
  void clearApprove() => $_clearField(6);
}

class ApproveTransactionsRequest extends $pb.GeneratedMessage {
  factory ApproveTransactionsRequest({
    $fixnum.Int64? companyId,
    $core.Iterable<$fixnum.Int64>? ids,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (ids != null) result.ids.addAll(ids);
    return result;
  }

  ApproveTransactionsRequest._();

  factory ApproveTransactionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApproveTransactionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ApproveTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApproveTransactionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApproveTransactionsRequest copyWith(void Function(ApproveTransactionsRequest) updates) =>
      super.copyWith((message) => updates(message as ApproveTransactionsRequest)) as ApproveTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApproveTransactionsRequest create() => ApproveTransactionsRequest._();
  @$core.override
  ApproveTransactionsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ApproveTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApproveTransactionsRequest>(create);
  static ApproveTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get ids => $_getList(1);
}

class LinkTransactionRequest extends $pb.GeneratedMessage {
  factory LinkTransactionRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? transactionId,
    $fixnum.Int64? invoiceId,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (transactionId != null) result.transactionId = transactionId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    return result;
  }

  LinkTransactionRequest._();

  factory LinkTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LinkTransactionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'invoiceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkTransactionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkTransactionRequest copyWith(void Function(LinkTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as LinkTransactionRequest)) as LinkTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkTransactionRequest create() => LinkTransactionRequest._();
  @$core.override
  LinkTransactionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LinkTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkTransactionRequest>(create);
  static LinkTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get transactionId => $_getI64(1);
  @$pb.TagNumber(2)
  set transactionId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get invoiceId => $_getI64(2);
  @$pb.TagNumber(3)
  set invoiceId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInvoiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvoiceId() => $_clearField(3);
}

class Attachment extends $pb.GeneratedMessage {
  factory Attachment({
    $fixnum.Int64? id,
    $fixnum.Int64? companyId,
    $fixnum.Int64? transactionId,
    $fixnum.Int64? invoiceId,
    $core.String? filename,
    $core.String? mime,
    $fixnum.Int64? sizeBytes,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (companyId != null) result.companyId = companyId;
    if (transactionId != null) result.transactionId = transactionId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (filename != null) result.filename = filename;
    if (mime != null) result.mime = mime;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Attachment._();

  factory Attachment.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Attachment.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo(_omitMessageNames ? '' : 'Attachment', package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
        ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'invoiceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOS(5, _omitFieldNames ? '' : 'filename')
        ..aOS(6, _omitFieldNames ? '' : 'mime')
        ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'sizeBytes', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
        ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
        ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Attachment clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Attachment copyWith(void Function(Attachment) updates) => super.copyWith((message) => updates(message as Attachment)) as Attachment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Attachment create() => Attachment._();
  @$core.override
  Attachment createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Attachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Attachment>(create);
  static Attachment? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get companyId => $_getI64(1);
  @$pb.TagNumber(2)
  set companyId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompanyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompanyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get transactionId => $_getI64(2);
  @$pb.TagNumber(3)
  set transactionId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get invoiceId => $_getI64(3);
  @$pb.TagNumber(4)
  set invoiceId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInvoiceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvoiceId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get filename => $_getSZ(4);
  @$pb.TagNumber(5)
  set filename($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFilename() => $_has(4);
  @$pb.TagNumber(5)
  void clearFilename() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get mime => $_getSZ(5);
  @$pb.TagNumber(6)
  set mime($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMime() => $_has(5);
  @$pb.TagNumber(6)
  void clearMime() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get sizeBytes => $_getI64(6);
  @$pb.TagNumber(7)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSizeBytes() => $_has(6);
  @$pb.TagNumber(7)
  void clearSizeBytes() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);
}

class UploadAttachmentRequest extends $pb.GeneratedMessage {
  factory UploadAttachmentRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? transactionId,
    $fixnum.Int64? invoiceId,
    $core.String? filename,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (transactionId != null) result.transactionId = transactionId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (filename != null) result.filename = filename;
    if (data != null) result.data = data;
    return result;
  }

  UploadAttachmentRequest._();

  factory UploadAttachmentRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadAttachmentRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadAttachmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'invoiceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'filename')
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadAttachmentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadAttachmentRequest copyWith(void Function(UploadAttachmentRequest) updates) =>
      super.copyWith((message) => updates(message as UploadAttachmentRequest)) as UploadAttachmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadAttachmentRequest create() => UploadAttachmentRequest._();
  @$core.override
  UploadAttachmentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadAttachmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadAttachmentRequest>(create);
  static UploadAttachmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get transactionId => $_getI64(1);
  @$pb.TagNumber(2)
  set transactionId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get invoiceId => $_getI64(2);
  @$pb.TagNumber(3)
  set invoiceId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInvoiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvoiceId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get filename => $_getSZ(3);
  @$pb.TagNumber(4)
  set filename($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFilename() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilename() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get data => $_getN(4);
  @$pb.TagNumber(5)
  set data($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => $_clearField(5);
}

class ListAttachmentsRequest extends $pb.GeneratedMessage {
  factory ListAttachmentsRequest({
    $fixnum.Int64? companyId,
    $fixnum.Int64? transactionId,
    $fixnum.Int64? invoiceId,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (transactionId != null) result.transactionId = transactionId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    return result;
  }

  ListAttachmentsRequest._();

  factory ListAttachmentsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAttachmentsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListAttachmentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'transactionId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'invoiceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAttachmentsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAttachmentsRequest copyWith(void Function(ListAttachmentsRequest) updates) =>
      super.copyWith((message) => updates(message as ListAttachmentsRequest)) as ListAttachmentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAttachmentsRequest create() => ListAttachmentsRequest._();
  @$core.override
  ListAttachmentsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAttachmentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAttachmentsRequest>(create);
  static ListAttachmentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get transactionId => $_getI64(1);
  @$pb.TagNumber(2)
  set transactionId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get invoiceId => $_getI64(2);
  @$pb.TagNumber(3)
  set invoiceId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInvoiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvoiceId() => $_clearField(3);
}

class ListAttachmentsResponse extends $pb.GeneratedMessage {
  factory ListAttachmentsResponse({
    $core.Iterable<Attachment>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListAttachmentsResponse._();

  factory ListAttachmentsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAttachmentsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListAttachmentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..pPM<Attachment>(1, _omitFieldNames ? '' : 'items', subBuilder: Attachment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAttachmentsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAttachmentsResponse copyWith(void Function(ListAttachmentsResponse) updates) =>
      super.copyWith((message) => updates(message as ListAttachmentsResponse)) as ListAttachmentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAttachmentsResponse create() => ListAttachmentsResponse._();
  @$core.override
  ListAttachmentsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAttachmentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAttachmentsResponse>(create);
  static ListAttachmentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Attachment> get items => $_getList(0);
}

class OverviewRequest extends $pb.GeneratedMessage {
  factory OverviewRequest({
    $fixnum.Int64? companyId,
    $core.int? months,
  }) {
    final result = create();
    if (companyId != null) result.companyId = companyId;
    if (months != null) result.months = months;
    return result;
  }

  OverviewRequest._();

  factory OverviewRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverviewRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OverviewRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'companyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(2, _omitFieldNames ? '' : 'months', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverviewRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverviewRequest copyWith(void Function(OverviewRequest) updates) => super.copyWith((message) => updates(message as OverviewRequest)) as OverviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverviewRequest create() => OverviewRequest._();
  @$core.override
  OverviewRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverviewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OverviewRequest>(create);
  static OverviewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get companyId => $_getI64(0);
  @$pb.TagNumber(1)
  set companyId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompanyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get months => $_getIZ(1);
  @$pb.TagNumber(2)
  set months($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonths() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonths() => $_clearField(2);
}

class CashflowPoint extends $pb.GeneratedMessage {
  factory CashflowPoint({
    $core.String? month,
    $fixnum.Int64? inCents,
    $fixnum.Int64? outCents,
  }) {
    final result = create();
    if (month != null) result.month = month;
    if (inCents != null) result.inCents = inCents;
    if (outCents != null) result.outCents = outCents;
    return result;
  }

  CashflowPoint._();

  factory CashflowPoint.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CashflowPoint.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CashflowPoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'month')
    ..aInt64(2, _omitFieldNames ? '' : 'inCents')
    ..aInt64(3, _omitFieldNames ? '' : 'outCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CashflowPoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CashflowPoint copyWith(void Function(CashflowPoint) updates) => super.copyWith((message) => updates(message as CashflowPoint)) as CashflowPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CashflowPoint create() => CashflowPoint._();
  @$core.override
  CashflowPoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CashflowPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CashflowPoint>(create);
  static CashflowPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get month => $_getSZ(0);
  @$pb.TagNumber(1)
  set month($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonth() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get inCents => $_getI64(1);
  @$pb.TagNumber(2)
  set inCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearInCents() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get outCents => $_getI64(2);
  @$pb.TagNumber(3)
  set outCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOutCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutCents() => $_clearField(3);
}

class InvoiceTimelinePoint extends $pb.GeneratedMessage {
  factory InvoiceTimelinePoint({
    $core.String? month,
    $fixnum.Int64? paidCents,
    $fixnum.Int64? dueCents,
    $fixnum.Int64? overdueCents,
  }) {
    final result = create();
    if (month != null) result.month = month;
    if (paidCents != null) result.paidCents = paidCents;
    if (dueCents != null) result.dueCents = dueCents;
    if (overdueCents != null) result.overdueCents = overdueCents;
    return result;
  }

  InvoiceTimelinePoint._();

  factory InvoiceTimelinePoint.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvoiceTimelinePoint.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceTimelinePoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'month')
    ..aInt64(2, _omitFieldNames ? '' : 'paidCents')
    ..aInt64(3, _omitFieldNames ? '' : 'dueCents')
    ..aInt64(4, _omitFieldNames ? '' : 'overdueCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoiceTimelinePoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoiceTimelinePoint copyWith(void Function(InvoiceTimelinePoint) updates) =>
      super.copyWith((message) => updates(message as InvoiceTimelinePoint)) as InvoiceTimelinePoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceTimelinePoint create() => InvoiceTimelinePoint._();
  @$core.override
  InvoiceTimelinePoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InvoiceTimelinePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceTimelinePoint>(create);
  static InvoiceTimelinePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get month => $_getSZ(0);
  @$pb.TagNumber(1)
  set month($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonth() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get paidCents => $_getI64(1);
  @$pb.TagNumber(2)
  set paidCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaidCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaidCents() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get dueCents => $_getI64(2);
  @$pb.TagNumber(3)
  set dueCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDueCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearDueCents() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get overdueCents => $_getI64(3);
  @$pb.TagNumber(4)
  set overdueCents($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOverdueCents() => $_has(3);
  @$pb.TagNumber(4)
  void clearOverdueCents() => $_clearField(4);
}

class OverviewResponse extends $pb.GeneratedMessage {
  factory OverviewResponse({
    $core.String? currency,
    $core.Iterable<CashflowPoint>? cashflow,
    $fixnum.Int64? incomingCents,
    $fixnum.Int64? outgoingCents,
    $core.Iterable<BalancePoint>? balanceHistory,
    $fixnum.Int64? totalBalanceCents,
    $core.Iterable<InvoiceTimelinePoint>? invoiceTimeline,
    $fixnum.Int64? outstandingCents,
    $fixnum.Int64? incomeCents,
    $fixnum.Int64? expensesCents,
    $core.int? forApprovalCount,
    $core.int? unexplainedCount,
    $core.bool? hasBankAccounts,
    $core.bool? hasExpiredConnections,
  }) {
    final result = create();
    if (currency != null) result.currency = currency;
    if (cashflow != null) result.cashflow.addAll(cashflow);
    if (incomingCents != null) result.incomingCents = incomingCents;
    if (outgoingCents != null) result.outgoingCents = outgoingCents;
    if (balanceHistory != null) result.balanceHistory.addAll(balanceHistory);
    if (totalBalanceCents != null) result.totalBalanceCents = totalBalanceCents;
    if (invoiceTimeline != null) result.invoiceTimeline.addAll(invoiceTimeline);
    if (outstandingCents != null) result.outstandingCents = outstandingCents;
    if (incomeCents != null) result.incomeCents = incomeCents;
    if (expensesCents != null) result.expensesCents = expensesCents;
    if (forApprovalCount != null) result.forApprovalCount = forApprovalCount;
    if (unexplainedCount != null) result.unexplainedCount = unexplainedCount;
    if (hasBankAccounts != null) result.hasBankAccounts = hasBankAccounts;
    if (hasExpiredConnections != null) result.hasExpiredConnections = hasExpiredConnections;
    return result;
  }

  OverviewResponse._();

  factory OverviewResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverviewResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OverviewResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..pPM<CashflowPoint>(2, _omitFieldNames ? '' : 'cashflow', subBuilder: CashflowPoint.create)
    ..aInt64(3, _omitFieldNames ? '' : 'incomingCents')
    ..aInt64(4, _omitFieldNames ? '' : 'outgoingCents')
    ..pPM<BalancePoint>(5, _omitFieldNames ? '' : 'balanceHistory', subBuilder: BalancePoint.create)
    ..aInt64(6, _omitFieldNames ? '' : 'totalBalanceCents')
    ..pPM<InvoiceTimelinePoint>(7, _omitFieldNames ? '' : 'invoiceTimeline', subBuilder: InvoiceTimelinePoint.create)
    ..aInt64(8, _omitFieldNames ? '' : 'outstandingCents')
    ..aInt64(9, _omitFieldNames ? '' : 'incomeCents')
    ..aInt64(10, _omitFieldNames ? '' : 'expensesCents')
    ..aI(11, _omitFieldNames ? '' : 'forApprovalCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(12, _omitFieldNames ? '' : 'unexplainedCount', fieldType: $pb.PbFieldType.OU3)
    ..aOB(13, _omitFieldNames ? '' : 'hasBankAccounts')
    ..aOB(14, _omitFieldNames ? '' : 'hasExpiredConnections')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverviewResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverviewResponse copyWith(void Function(OverviewResponse) updates) => super.copyWith((message) => updates(message as OverviewResponse)) as OverviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverviewResponse create() => OverviewResponse._();
  @$core.override
  OverviewResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverviewResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OverviewResponse>(create);
  static OverviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<CashflowPoint> get cashflow => $_getList(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get incomingCents => $_getI64(2);
  @$pb.TagNumber(3)
  set incomingCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncomingCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncomingCents() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get outgoingCents => $_getI64(3);
  @$pb.TagNumber(4)
  set outgoingCents($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOutgoingCents() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutgoingCents() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<BalancePoint> get balanceHistory => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalBalanceCents => $_getI64(5);
  @$pb.TagNumber(6)
  set totalBalanceCents($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalBalanceCents() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalBalanceCents() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<InvoiceTimelinePoint> get invoiceTimeline => $_getList(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get outstandingCents => $_getI64(7);
  @$pb.TagNumber(8)
  set outstandingCents($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOutstandingCents() => $_has(7);
  @$pb.TagNumber(8)
  void clearOutstandingCents() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get incomeCents => $_getI64(8);
  @$pb.TagNumber(9)
  set incomeCents($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIncomeCents() => $_has(8);
  @$pb.TagNumber(9)
  void clearIncomeCents() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get expensesCents => $_getI64(9);
  @$pb.TagNumber(10)
  set expensesCents($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpensesCents() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpensesCents() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get forApprovalCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set forApprovalCount($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasForApprovalCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearForApprovalCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get unexplainedCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set unexplainedCount($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasUnexplainedCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearUnexplainedCount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get hasBankAccounts => $_getBF(12);
  @$pb.TagNumber(13)
  set hasBankAccounts($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasHasBankAccounts() => $_has(12);
  @$pb.TagNumber(13)
  void clearHasBankAccounts() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get hasExpiredConnections => $_getBF(13);
  @$pb.TagNumber(14)
  set hasExpiredConnections($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasHasExpiredConnections() => $_has(13);
  @$pb.TagNumber(14)
  void clearHasExpiredConnections() => $_clearField(14);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
