// This is a generated file - do not edit.
//
// Generated from routes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use categoryKindDescriptor instead')
const CategoryKind$json = {
  '1': 'CategoryKind',
  '2': [
    {'1': 'CATEGORY_KIND_UNSPECIFIED', '2': 0},
    {'1': 'CATEGORY_KIND_INCOME', '2': 1},
    {'1': 'CATEGORY_KIND_EXPENSE', '2': 2},
  ],
};

/// Descriptor for `CategoryKind`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List categoryKindDescriptor = $convert.base64Decode(
    'CgxDYXRlZ29yeUtpbmQSHQoZQ0FURUdPUllfS0lORF9VTlNQRUNJRklFRBAAEhgKFENBVEVHT1'
    'JZX0tJTkRfSU5DT01FEAESGQoVQ0FURUdPUllfS0lORF9FWFBFTlNFEAI=');

@$core.Deprecated('Use invoiceStatusDescriptor instead')
const InvoiceStatus$json = {
  '1': 'InvoiceStatus',
  '2': [
    {'1': 'INVOICE_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'INVOICE_STATUS_DRAFT', '2': 1},
    {'1': 'INVOICE_STATUS_OPEN', '2': 2},
    {'1': 'INVOICE_STATUS_PAID', '2': 3},
    {'1': 'INVOICE_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `InvoiceStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List invoiceStatusDescriptor = $convert.base64Decode(
    'Cg1JbnZvaWNlU3RhdHVzEh4KGklOVk9JQ0VfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGAoUSU5WT0'
    'lDRV9TVEFUVVNfRFJBRlQQARIXChNJTlZPSUNFX1NUQVRVU19PUEVOEAISFwoTSU5WT0lDRV9T'
    'VEFUVVNfUEFJRBADEhwKGElOVk9JQ0VfU1RBVFVTX0NBTkNFTExFRBAE');

@$core.Deprecated('Use fieldKindDescriptor instead')
const FieldKind$json = {
  '1': 'FieldKind',
  '2': [
    {'1': 'FIELD_KIND_TEXT', '2': 0},
    {'1': 'FIELD_KIND_SECRET', '2': 1},
    {'1': 'FIELD_KIND_MULTILINE', '2': 2},
    {'1': 'FIELD_KIND_SELECT', '2': 3},
    {'1': 'FIELD_KIND_BOOL', '2': 4},
  ],
};

/// Descriptor for `FieldKind`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fieldKindDescriptor = $convert.base64Decode(
    'CglGaWVsZEtpbmQSEwoPRklFTERfS0lORF9URVhUEAASFQoRRklFTERfS0lORF9TRUNSRVQQAR'
    'IYChRGSUVMRF9LSU5EX01VTFRJTElORRACEhUKEUZJRUxEX0tJTkRfU0VMRUNUEAMSEwoPRklF'
    'TERfS0lORF9CT09MEAQ=');

@$core.Deprecated('Use connectionStatusDescriptor instead')
const ConnectionStatus$json = {
  '1': 'ConnectionStatus',
  '2': [
    {'1': 'CONNECTION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'CONNECTION_STATUS_PENDING', '2': 1},
    {'1': 'CONNECTION_STATUS_ACTIVE', '2': 2},
    {'1': 'CONNECTION_STATUS_EXPIRED', '2': 3},
    {'1': 'CONNECTION_STATUS_ERROR', '2': 4},
  ],
};

/// Descriptor for `ConnectionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List connectionStatusDescriptor = $convert.base64Decode(
    'ChBDb25uZWN0aW9uU3RhdHVzEiEKHUNPTk5FQ1RJT05fU1RBVFVTX1VOU1BFQ0lGSUVEEAASHQ'
    'oZQ09OTkVDVElPTl9TVEFUVVNfUEVORElORxABEhwKGENPTk5FQ1RJT05fU1RBVFVTX0FDVElW'
    'RRACEh0KGUNPTk5FQ1RJT05fU1RBVFVTX0VYUElSRUQQAxIbChdDT05ORUNUSU9OX1NUQVRVU1'
    '9FUlJPUhAE');

@$core.Deprecated('Use transactionStatusDescriptor instead')
const TransactionStatus$json = {
  '1': 'TransactionStatus',
  '2': [
    {'1': 'TRANSACTION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'TRANSACTION_STATUS_UNEXPLAINED', '2': 1},
    {'1': 'TRANSACTION_STATUS_EXPLAINED', '2': 2},
    {'1': 'TRANSACTION_STATUS_APPROVED', '2': 3},
  ],
};

/// Descriptor for `TransactionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionStatusDescriptor = $convert.base64Decode(
    'ChFUcmFuc2FjdGlvblN0YXR1cxIiCh5UUkFOU0FDVElPTl9TVEFUVVNfVU5TUEVDSUZJRUQQAB'
    'IiCh5UUkFOU0FDVElPTl9TVEFUVVNfVU5FWFBMQUlORUQQARIgChxUUkFOU0FDVElPTl9TVEFU'
    'VVNfRVhQTEFJTkVEEAISHwobVFJBTlNBQ1RJT05fU1RBVFVTX0FQUFJPVkVEEAM=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');

@$core.Deprecated('Use idRequestDescriptor instead')
const IdRequest$json = {
  '1': 'IdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
  ],
};

/// Descriptor for `IdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idRequestDescriptor =
    $convert.base64Decode('CglJZFJlcXVlc3QSDgoCaWQYASABKARSAmlk');

@$core.Deprecated('Use companyRequestDescriptor instead')
const CompanyRequest$json = {
  '1': 'CompanyRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
  ],
};

/// Descriptor for `CompanyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List companyRequestDescriptor = $convert.base64Decode(
    'Cg5Db21wYW55UmVxdWVzdBIdCgpjb21wYW55X2lkGAEgASgEUgljb21wYW55SWQ=');

@$core.Deprecated('Use companyIdRequestDescriptor instead')
const CompanyIdRequest$json = {
  '1': 'CompanyIdRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'id', '3': 2, '4': 1, '5': 4, '10': 'id'},
  ],
};

/// Descriptor for `CompanyIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List companyIdRequestDescriptor = $convert.base64Decode(
    'ChBDb21wYW55SWRSZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZBIOCgJpZB'
    'gCIAEoBFICaWQ=');

@$core.Deprecated('Use fileResponseDescriptor instead')
const FileResponse$json = {
  '1': 'FileResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'filename', '3': 2, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'mime', '3': 3, '4': 1, '5': 9, '10': 'mime'},
  ],
};

/// Descriptor for `FileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileResponseDescriptor = $convert.base64Decode(
    'CgxGaWxlUmVzcG9uc2USEgoEZGF0YRgBIAEoDFIEZGF0YRIaCghmaWxlbmFtZRgCIAEoCVIIZm'
    'lsZW5hbWUSEgoEbWltZRgDIAEoCVIEbWltZQ==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'has_password', '3': 4, '4': 1, '5': 8, '10': 'hasPassword'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgEUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSEgoEbmFtZRgDIA'
    'EoCVIEbmFtZRIhCgxoYXNfcGFzc3dvcmQYBCABKAhSC2hhc1Bhc3N3b3JkEjkKCmNyZWF0ZWRf'
    'YXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhIKBG5hbWUYAiABKAlSBG'
    '5hbWUSGgoIcGFzc3dvcmQYAyABKAlSCHBhc3N3b3Jk');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgASgJUg'
    'hwYXNzd29yZA==');

@$core.Deprecated('Use authResponseDescriptor instead')
const AuthResponse$json = {
  '1': 'AuthResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounting.User',
      '10': 'user'
    },
  ],
};

/// Descriptor for `AuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authResponseDescriptor = $convert.base64Decode(
    'CgxBdXRoUmVzcG9uc2USFAoFdG9rZW4YASABKAlSBXRva2VuEiQKBHVzZXIYAiABKAsyEC5hY2'
    'NvdW50aW5nLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use requestRecoveryRequestDescriptor instead')
const RequestRecoveryRequest$json = {
  '1': 'RequestRecoveryRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestRecoveryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestRecoveryRequestDescriptor =
    $convert.base64Decode(
        'ChZSZXF1ZXN0UmVjb3ZlcnlSZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbA==');

@$core.Deprecated('Use recoveryTokenRequestDescriptor instead')
const RecoveryTokenRequest$json = {
  '1': 'RecoveryTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `RecoveryTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recoveryTokenRequestDescriptor =
    $convert.base64Decode(
        'ChRSZWNvdmVyeVRva2VuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use recoveryTokenResponseDescriptor instead')
const RecoveryTokenResponse$json = {
  '1': 'RecoveryTokenResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RecoveryTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recoveryTokenResponseDescriptor = $convert.base64Decode(
    'ChVSZWNvdmVyeVRva2VuUmVzcG9uc2USFAoFdmFsaWQYASABKAhSBXZhbGlkEhQKBWVtYWlsGA'
    'IgASgJUgVlbWFpbA==');

@$core.Deprecated('Use recoverAccountRequestDescriptor instead')
const RecoverAccountRequest$json = {
  '1': 'RecoverAccountRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `RecoverAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recoverAccountRequestDescriptor = $convert.base64Decode(
    'ChVSZWNvdmVyQWNjb3VudFJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEiEKDG5ld19wYX'
    'Nzd29yZBgCIAEoCVILbmV3UGFzc3dvcmQ=');

@$core.Deprecated('Use changePasswordRequestDescriptor instead')
const ChangePasswordRequest$json = {
  '1': 'ChangePasswordRequest',
  '2': [
    {'1': 'current_password', '3': 1, '4': 1, '5': 9, '10': 'currentPassword'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ChangePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordRequestDescriptor = $convert.base64Decode(
    'ChVDaGFuZ2VQYXNzd29yZFJlcXVlc3QSKQoQY3VycmVudF9wYXNzd29yZBgBIAEoCVIPY3Vycm'
    'VudFBhc3N3b3JkEiEKDG5ld19wYXNzd29yZBgCIAEoCVILbmV3UGFzc3dvcmQ=');

@$core.Deprecated('Use beginPasskeyLoginRequestDescriptor instead')
const BeginPasskeyLoginRequest$json = {
  '1': 'BeginPasskeyLoginRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `BeginPasskeyLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beginPasskeyLoginRequestDescriptor =
    $convert.base64Decode(
        'ChhCZWdpblBhc3NrZXlMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use passkeyOptionsResponseDescriptor instead')
const PasskeyOptionsResponse$json = {
  '1': 'PasskeyOptionsResponse',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'options_json', '3': 2, '4': 1, '5': 9, '10': 'optionsJson'},
  ],
};

/// Descriptor for `PasskeyOptionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List passkeyOptionsResponseDescriptor =
    $convert.base64Decode(
        'ChZQYXNza2V5T3B0aW9uc1Jlc3BvbnNlEh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZB'
        'IhCgxvcHRpb25zX2pzb24YAiABKAlSC29wdGlvbnNKc29u');

@$core.Deprecated('Use finishPasskeyRequestDescriptor instead')
const FinishPasskeyRequest$json = {
  '1': 'FinishPasskeyRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'credential_json', '3': 2, '4': 1, '5': 9, '10': 'credentialJson'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `FinishPasskeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finishPasskeyRequestDescriptor = $convert.base64Decode(
    'ChRGaW5pc2hQYXNza2V5UmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQSJw'
    'oPY3JlZGVudGlhbF9qc29uGAIgASgJUg5jcmVkZW50aWFsSnNvbhISCgRuYW1lGAMgASgJUgRu'
    'YW1l');

@$core.Deprecated('Use passkeyDescriptor instead')
const Passkey$json = {
  '1': 'Passkey',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'created_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'last_used_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastUsedAt'
    },
  ],
};

/// Descriptor for `Passkey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List passkeyDescriptor = $convert.base64Decode(
    'CgdQYXNza2V5Eg4KAmlkGAEgASgEUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjkKCmNyZWF0ZW'
    'RfYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPAoMbGFz'
    'dF91c2VkX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdA'
    '==');

@$core.Deprecated('Use listPasskeysResponseDescriptor instead')
const ListPasskeysResponse$json = {
  '1': 'ListPasskeysResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Passkey',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListPasskeysResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPasskeysResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UGFzc2tleXNSZXNwb25zZRIpCgVpdGVtcxgBIAMoCzITLmFjY291bnRpbmcuUGFzc2'
    'tleVIFaXRlbXM=');

@$core.Deprecated('Use companyDescriptor instead')
const Company$json = {
  '1': 'Company',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'reg_number', '3': 3, '4': 1, '5': 9, '10': 'regNumber'},
    {'1': 'vat_number', '3': 4, '4': 1, '5': 9, '10': 'vatNumber'},
    {'1': 'address', '3': 5, '4': 1, '5': 9, '10': 'address'},
    {'1': 'email', '3': 6, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 7, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'iban', '3': 8, '4': 1, '5': 9, '10': 'iban'},
    {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'invoice_prefix', '3': 11, '4': 1, '5': 9, '10': 'invoicePrefix'},
    {
      '1': 'next_invoice_number',
      '3': 12,
      '4': 1,
      '5': 13,
      '10': 'nextInvoiceNumber'
    },
    {'1': 'default_vat_rate', '3': 13, '4': 1, '5': 9, '10': 'defaultVatRate'},
    {'1': 'default_due_days', '3': 14, '4': 1, '5': 13, '10': 'defaultDueDays'},
    {'1': 'role', '3': 15, '4': 1, '5': 9, '10': 'role'},
    {
      '1': 'created_at',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Company`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List companyDescriptor = $convert.base64Decode(
    'CgdDb21wYW55Eg4KAmlkGAEgASgEUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCnJlZ19udW'
    '1iZXIYAyABKAlSCXJlZ051bWJlchIdCgp2YXRfbnVtYmVyGAQgASgJUgl2YXROdW1iZXISGAoH'
    'YWRkcmVzcxgFIAEoCVIHYWRkcmVzcxIUCgVlbWFpbBgGIAEoCVIFZW1haWwSFAoFcGhvbmUYBy'
    'ABKAlSBXBob25lEhIKBGliYW4YCCABKAlSBGliYW4SGwoJYmFua19uYW1lGAkgASgJUghiYW5r'
    'TmFtZRIaCghjdXJyZW5jeRgKIAEoCVIIY3VycmVuY3kSJQoOaW52b2ljZV9wcmVmaXgYCyABKA'
    'lSDWludm9pY2VQcmVmaXgSLgoTbmV4dF9pbnZvaWNlX251bWJlchgMIAEoDVIRbmV4dEludm9p'
    'Y2VOdW1iZXISKAoQZGVmYXVsdF92YXRfcmF0ZRgNIAEoCVIOZGVmYXVsdFZhdFJhdGUSKAoQZG'
    'VmYXVsdF9kdWVfZGF5cxgOIAEoDVIOZGVmYXVsdER1ZURheXMSEgoEcm9sZRgPIAEoCVIEcm9s'
    'ZRI5CgpjcmVhdGVkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYX'
    'RlZEF0');

@$core.Deprecated('Use listCompaniesResponseDescriptor instead')
const ListCompaniesResponse$json = {
  '1': 'ListCompaniesResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Company',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListCompaniesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCompaniesResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0Q29tcGFuaWVzUmVzcG9uc2USKQoFaXRlbXMYASADKAsyEy5hY2NvdW50aW5nLkNvbX'
    'BhbnlSBWl0ZW1z');

@$core.Deprecated('Use projectDescriptor instead')
const Project$json = {
  '1': 'Project',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'company_id', '3': 2, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'contact_name', '3': 6, '4': 1, '5': 9, '10': 'contactName'},
    {'1': 'address', '3': 7, '4': 1, '5': 9, '10': 'address'},
    {'1': 'reg_number', '3': 8, '4': 1, '5': 9, '10': 'regNumber'},
    {'1': 'vat_number', '3': 9, '4': 1, '5': 9, '10': 'vatNumber'},
    {'1': 'is_active', '3': 10, '4': 1, '5': 8, '10': 'isActive'},
    {
      '1': 'created_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {'1': 'invoiced_cents', '3': 12, '4': 1, '5': 3, '10': 'invoicedCents'},
    {
      '1': 'outstanding_cents',
      '3': 13,
      '4': 1,
      '5': 3,
      '10': 'outstandingCents'
    },
    {'1': 'invoice_count', '3': 14, '4': 1, '5': 13, '10': 'invoiceCount'},
  ],
};

/// Descriptor for `Project`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectDescriptor = $convert.base64Decode(
    'CgdQcm9qZWN0Eg4KAmlkGAEgASgEUgJpZBIdCgpjb21wYW55X2lkGAIgASgEUgljb21wYW55SW'
    'QSEgoEbmFtZRgDIAEoCVIEbmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSIAoLZGVzY3JpcHRp'
    'b24YBSABKAlSC2Rlc2NyaXB0aW9uEiEKDGNvbnRhY3RfbmFtZRgGIAEoCVILY29udGFjdE5hbW'
    'USGAoHYWRkcmVzcxgHIAEoCVIHYWRkcmVzcxIdCgpyZWdfbnVtYmVyGAggASgJUglyZWdOdW1i'
    'ZXISHQoKdmF0X251bWJlchgJIAEoCVIJdmF0TnVtYmVyEhsKCWlzX2FjdGl2ZRgKIAEoCFIIaX'
    'NBY3RpdmUSOQoKY3JlYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'CWNyZWF0ZWRBdBIlCg5pbnZvaWNlZF9jZW50cxgMIAEoA1INaW52b2ljZWRDZW50cxIrChFvdX'
    'RzdGFuZGluZ19jZW50cxgNIAEoA1IQb3V0c3RhbmRpbmdDZW50cxIjCg1pbnZvaWNlX2NvdW50'
    'GA4gASgNUgxpbnZvaWNlQ291bnQ=');

@$core.Deprecated('Use listProjectsRequestDescriptor instead')
const ListProjectsRequest$json = {
  '1': 'ListProjectsRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'include_inactive', '3': 2, '4': 1, '5': 8, '10': 'includeInactive'},
  ],
};

/// Descriptor for `ListProjectsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProjectsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0UHJvamVjdHNSZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZBIpCh'
    'BpbmNsdWRlX2luYWN0aXZlGAIgASgIUg9pbmNsdWRlSW5hY3RpdmU=');

@$core.Deprecated('Use listProjectsResponseDescriptor instead')
const ListProjectsResponse$json = {
  '1': 'ListProjectsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Project',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListProjectsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProjectsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UHJvamVjdHNSZXNwb25zZRIpCgVpdGVtcxgBIAMoCzITLmFjY291bnRpbmcuUHJvam'
    'VjdFIFaXRlbXM=');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'company_id', '3': 2, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'kind',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.accounting.CategoryKind',
      '10': 'kind'
    },
    {'1': 'sort_order', '3': 5, '4': 1, '5': 13, '10': 'sortOrder'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJpZBgBIAEoBFICaWQSHQoKY29tcGFueV9pZBgCIAEoBFIJY29tcGFueU'
    'lkEhIKBG5hbWUYAyABKAlSBG5hbWUSLAoEa2luZBgEIAEoDjIYLmFjY291bnRpbmcuQ2F0ZWdv'
    'cnlLaW5kUgRraW5kEh0KCnNvcnRfb3JkZXIYBSABKA1SCXNvcnRPcmRlcg==');

@$core.Deprecated('Use listCategoriesResponseDescriptor instead')
const ListCategoriesResponse$json = {
  '1': 'ListCategoriesResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Category',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCategoriesResponseDescriptor =
    $convert.base64Decode(
        'ChZMaXN0Q2F0ZWdvcmllc1Jlc3BvbnNlEioKBWl0ZW1zGAEgAygLMhQuYWNjb3VudGluZy5DYX'
        'RlZ29yeVIFaXRlbXM=');

@$core.Deprecated('Use invoiceItemDescriptor instead')
const InvoiceItem$json = {
  '1': 'InvoiceItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'position', '3': 2, '4': 1, '5': 13, '10': 'position'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 9, '10': 'quantity'},
    {'1': 'unit_price_cents', '3': 5, '4': 1, '5': 3, '10': 'unitPriceCents'},
    {'1': 'vat_rate', '3': 6, '4': 1, '5': 9, '10': 'vatRate'},
    {'1': 'net_cents', '3': 7, '4': 1, '5': 3, '10': 'netCents'},
    {'1': 'vat_cents', '3': 8, '4': 1, '5': 3, '10': 'vatCents'},
  ],
};

/// Descriptor for `InvoiceItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceItemDescriptor = $convert.base64Decode(
    'CgtJbnZvaWNlSXRlbRIOCgJpZBgBIAEoBFICaWQSGgoIcG9zaXRpb24YAiABKA1SCHBvc2l0aW'
    '9uEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghxdWFudGl0eRgEIAEoCVII'
    'cXVhbnRpdHkSKAoQdW5pdF9wcmljZV9jZW50cxgFIAEoA1IOdW5pdFByaWNlQ2VudHMSGQoIdm'
    'F0X3JhdGUYBiABKAlSB3ZhdFJhdGUSGwoJbmV0X2NlbnRzGAcgASgDUghuZXRDZW50cxIbCgl2'
    'YXRfY2VudHMYCCABKANSCHZhdENlbnRz');

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = {
  '1': 'Invoice',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'company_id', '3': 2, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'project_id', '3': 3, '4': 1, '5': 4, '10': 'projectId'},
    {'1': 'project_name', '3': 4, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'number', '3': 5, '4': 1, '5': 9, '10': 'number'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.accounting.InvoiceStatus',
      '10': 'status'
    },
    {'1': 'issue_date', '3': 7, '4': 1, '5': 9, '10': 'issueDate'},
    {'1': 'due_date', '3': 8, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'subtotal_cents', '3': 10, '4': 1, '5': 3, '10': 'subtotalCents'},
    {'1': 'vat_cents', '3': 11, '4': 1, '5': 3, '10': 'vatCents'},
    {'1': 'total_cents', '3': 12, '4': 1, '5': 3, '10': 'totalCents'},
    {'1': 'notes', '3': 13, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    {
      '1': 'paid_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'paidAt'
    },
    {
      '1': 'paid_transaction_id',
      '3': 16,
      '4': 1,
      '5': 4,
      '10': 'paidTransactionId'
    },
    {
      '1': 'sent_at',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'sentAt'
    },
    {
      '1': 'created_at',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'items',
      '3': 19,
      '4': 3,
      '5': 11,
      '6': '.accounting.InvoiceItem',
      '10': 'items'
    },
    {'1': 'is_overdue', '3': 20, '4': 1, '5': 8, '10': 'isOverdue'},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode(
    'CgdJbnZvaWNlEg4KAmlkGAEgASgEUgJpZBIdCgpjb21wYW55X2lkGAIgASgEUgljb21wYW55SW'
    'QSHQoKcHJvamVjdF9pZBgDIAEoBFIJcHJvamVjdElkEiEKDHByb2plY3RfbmFtZRgEIAEoCVIL'
    'cHJvamVjdE5hbWUSFgoGbnVtYmVyGAUgASgJUgZudW1iZXISMQoGc3RhdHVzGAYgASgOMhkuYW'
    'Njb3VudGluZy5JbnZvaWNlU3RhdHVzUgZzdGF0dXMSHQoKaXNzdWVfZGF0ZRgHIAEoCVIJaXNz'
    'dWVEYXRlEhkKCGR1ZV9kYXRlGAggASgJUgdkdWVEYXRlEhoKCGN1cnJlbmN5GAkgASgJUghjdX'
    'JyZW5jeRIlCg5zdWJ0b3RhbF9jZW50cxgKIAEoA1INc3VidG90YWxDZW50cxIbCgl2YXRfY2Vu'
    'dHMYCyABKANSCHZhdENlbnRzEh8KC3RvdGFsX2NlbnRzGAwgASgDUgp0b3RhbENlbnRzEhQKBW'
    '5vdGVzGA0gASgJUgVub3RlcxIcCglyZWZlcmVuY2UYDiABKAlSCXJlZmVyZW5jZRIzCgdwYWlk'
    'X2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIGcGFpZEF0Ei4KE3BhaWRfdH'
    'JhbnNhY3Rpb25faWQYECABKARSEXBhaWRUcmFuc2FjdGlvbklkEjMKB3NlbnRfYXQYESABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgZzZW50QXQSOQoKY3JlYXRlZF9hdBgSIAEoCz'
    'IaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBItCgVpdGVtcxgTIAMoCzIX'
    'LmFjY291bnRpbmcuSW52b2ljZUl0ZW1SBWl0ZW1zEh0KCmlzX292ZXJkdWUYFCABKAhSCWlzT3'
    'ZlcmR1ZQ==');

@$core.Deprecated('Use listInvoicesRequestDescriptor instead')
const ListInvoicesRequest$json = {
  '1': 'ListInvoicesRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.accounting.InvoiceStatus',
      '10': 'status'
    },
    {'1': 'project_id', '3': 3, '4': 1, '5': 4, '10': 'projectId'},
    {'1': 'only_overdue', '3': 4, '4': 1, '5': 8, '10': 'onlyOverdue'},
    {'1': 'page', '3': 5, '4': 1, '5': 13, '10': 'page'},
    {'1': 'page_size', '3': 6, '4': 1, '5': 13, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInvoicesRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0SW52b2ljZXNSZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZBIxCg'
    'ZzdGF0dXMYAiABKA4yGS5hY2NvdW50aW5nLkludm9pY2VTdGF0dXNSBnN0YXR1cxIdCgpwcm9q'
    'ZWN0X2lkGAMgASgEUglwcm9qZWN0SWQSIQoMb25seV9vdmVyZHVlGAQgASgIUgtvbmx5T3Zlcm'
    'R1ZRISCgRwYWdlGAUgASgNUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgGIAEoDVIIcGFnZVNpemU=');

@$core.Deprecated('Use listInvoicesResponseDescriptor instead')
const ListInvoicesResponse$json = {
  '1': 'ListInvoicesResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Invoice',
      '10': 'items'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 13, '10': 'total'},
  ],
};

/// Descriptor for `ListInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInvoicesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0SW52b2ljZXNSZXNwb25zZRIpCgVpdGVtcxgBIAMoCzITLmFjY291bnRpbmcuSW52b2'
    'ljZVIFaXRlbXMSFAoFdG90YWwYAiABKA1SBXRvdGFs');

@$core.Deprecated('Use markInvoicePaidRequestDescriptor instead')
const MarkInvoicePaidRequest$json = {
  '1': 'MarkInvoicePaidRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'id', '3': 2, '4': 1, '5': 4, '10': 'id'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 4, '10': 'transactionId'},
    {'1': 'paid_date', '3': 4, '4': 1, '5': 9, '10': 'paidDate'},
  ],
};

/// Descriptor for `MarkInvoicePaidRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInvoicePaidRequestDescriptor = $convert.base64Decode(
    'ChZNYXJrSW52b2ljZVBhaWRSZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZB'
    'IOCgJpZBgCIAEoBFICaWQSJQoOdHJhbnNhY3Rpb25faWQYAyABKARSDXRyYW5zYWN0aW9uSWQS'
    'GwoJcGFpZF9kYXRlGAQgASgJUghwYWlkRGF0ZQ==');

@$core.Deprecated('Use configFieldDescriptor instead')
const ConfigField$json = {
  '1': 'ConfigField',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'hint', '3': 3, '4': 1, '5': 9, '10': 'hint'},
    {
      '1': 'kind',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.accounting.FieldKind',
      '10': 'kind'
    },
    {'1': 'options', '3': 5, '4': 3, '5': 9, '10': 'options'},
    {'1': 'required', '3': 6, '4': 1, '5': 8, '10': 'required'},
    {'1': 'default_value', '3': 7, '4': 1, '5': 9, '10': 'defaultValue'},
  ],
};

/// Descriptor for `ConfigField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configFieldDescriptor = $convert.base64Decode(
    'CgtDb25maWdGaWVsZBIQCgNrZXkYASABKAlSA2tleRIUCgVsYWJlbBgCIAEoCVIFbGFiZWwSEg'
    'oEaGludBgDIAEoCVIEaGludBIpCgRraW5kGAQgASgOMhUuYWNjb3VudGluZy5GaWVsZEtpbmRS'
    'BGtpbmQSGAoHb3B0aW9ucxgFIAMoCVIHb3B0aW9ucxIaCghyZXF1aXJlZBgGIAEoCFIIcmVxdW'
    'lyZWQSIwoNZGVmYXVsdF92YWx1ZRgHIAEoCVIMZGVmYXVsdFZhbHVl');

@$core.Deprecated('Use bankProviderDescriptor instead')
const BankProvider$json = {
  '1': 'BankProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'config_fields',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.accounting.ConfigField',
      '10': 'configFields'
    },
    {'1': 'needs_redirect', '3': 5, '4': 1, '5': 8, '10': 'needsRedirect'},
    {'1': 'has_institutions', '3': 6, '4': 1, '5': 8, '10': 'hasInstitutions'},
  ],
};

/// Descriptor for `BankProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankProviderDescriptor = $convert.base64Decode(
    'CgxCYW5rUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZG'
    'VzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEjwKDWNvbmZpZ19maWVsZHMYBCADKAsyFy5h'
    'Y2NvdW50aW5nLkNvbmZpZ0ZpZWxkUgxjb25maWdGaWVsZHMSJQoObmVlZHNfcmVkaXJlY3QYBS'
    'ABKAhSDW5lZWRzUmVkaXJlY3QSKQoQaGFzX2luc3RpdHV0aW9ucxgGIAEoCFIPaGFzSW5zdGl0'
    'dXRpb25z');

@$core.Deprecated('Use listBankProvidersResponseDescriptor instead')
const ListBankProvidersResponse$json = {
  '1': 'ListBankProvidersResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.BankProvider',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListBankProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBankProvidersResponseDescriptor =
    $convert.base64Decode(
        'ChlMaXN0QmFua1Byb3ZpZGVyc1Jlc3BvbnNlEi4KBWl0ZW1zGAEgAygLMhguYWNjb3VudGluZy'
        '5CYW5rUHJvdmlkZXJSBWl0ZW1z');

@$core.Deprecated('Use listInstitutionsRequestDescriptor instead')
const ListInstitutionsRequest$json = {
  '1': 'ListInstitutionsRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
    {
      '1': 'config',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.accounting.ListInstitutionsRequest.ConfigEntry',
      '10': 'config'
    },
  ],
  '3': [ListInstitutionsRequest_ConfigEntry$json],
};

@$core.Deprecated('Use listInstitutionsRequestDescriptor instead')
const ListInstitutionsRequest_ConfigEntry$json = {
  '1': 'ConfigEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ListInstitutionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInstitutionsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0SW5zdGl0dXRpb25zUmVxdWVzdBIdCgpjb21wYW55X2lkGAEgASgEUgljb21wYW55SW'
    'QSGgoIcHJvdmlkZXIYAiABKAlSCHByb3ZpZGVyEhgKB2NvdW50cnkYAyABKAlSB2NvdW50cnkS'
    'RwoGY29uZmlnGAQgAygLMi8uYWNjb3VudGluZy5MaXN0SW5zdGl0dXRpb25zUmVxdWVzdC5Db2'
    '5maWdFbnRyeVIGY29uZmlnGjkKC0NvbmZpZ0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZh'
    'bHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use institutionDescriptor instead')
const Institution$json = {
  '1': 'Institution',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'bic', '3': 3, '4': 1, '5': 9, '10': 'bic'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {
      '1': 'transaction_total_days',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'transactionTotalDays'
    },
  ],
};

/// Descriptor for `Institution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List institutionDescriptor = $convert.base64Decode(
    'CgtJbnN0aXR1dGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIQCgNiaW'
    'MYAyABKAlSA2JpYxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBI0ChZ0cmFuc2FjdGlvbl90'
    'b3RhbF9kYXlzGAUgASgNUhR0cmFuc2FjdGlvblRvdGFsRGF5cw==');

@$core.Deprecated('Use listInstitutionsResponseDescriptor instead')
const ListInstitutionsResponse$json = {
  '1': 'ListInstitutionsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Institution',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListInstitutionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInstitutionsResponseDescriptor =
    $convert.base64Decode(
        'ChhMaXN0SW5zdGl0dXRpb25zUmVzcG9uc2USLQoFaXRlbXMYASADKAsyFy5hY2NvdW50aW5nLk'
        'luc3RpdHV0aW9uUgVpdGVtcw==');

@$core.Deprecated('Use bankConnectionDescriptor instead')
const BankConnection$json = {
  '1': 'BankConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'company_id', '3': 2, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.accounting.ConnectionStatus',
      '10': 'status'
    },
    {'1': 'status_message', '3': 7, '4': 1, '5': 9, '10': 'statusMessage'},
    {
      '1': 'consent_expires_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'consentExpiresAt'
    },
    {
      '1': 'last_sync_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastSyncAt'
    },
    {
      '1': 'created_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {'1': 'account_count', '3': 11, '4': 1, '5': 13, '10': 'accountCount'},
    {
      '1': 'config',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.accounting.BankConnection.ConfigEntry',
      '10': 'config'
    },
    {'1': 'statements_only', '3': 13, '4': 1, '5': 8, '10': 'statementsOnly'},
  ],
  '3': [BankConnection_ConfigEntry$json],
};

@$core.Deprecated('Use bankConnectionDescriptor instead')
const BankConnection_ConfigEntry$json = {
  '1': 'ConfigEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `BankConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankConnectionDescriptor = $convert.base64Decode(
    'Cg5CYW5rQ29ubmVjdGlvbhIOCgJpZBgBIAEoBFICaWQSHQoKY29tcGFueV9pZBgCIAEoBFIJY2'
    '9tcGFueUlkEhoKCHByb3ZpZGVyGAMgASgJUghwcm92aWRlchIjCg1wcm92aWRlcl9uYW1lGAQg'
    'ASgJUgxwcm92aWRlck5hbWUSEgoEbmFtZRgFIAEoCVIEbmFtZRI0CgZzdGF0dXMYBiABKA4yHC'
    '5hY2NvdW50aW5nLkNvbm5lY3Rpb25TdGF0dXNSBnN0YXR1cxIlCg5zdGF0dXNfbWVzc2FnZRgH'
    'IAEoCVINc3RhdHVzTWVzc2FnZRJIChJjb25zZW50X2V4cGlyZXNfYXQYCCABKAsyGi5nb29nbG'
    'UucHJvdG9idWYuVGltZXN0YW1wUhBjb25zZW50RXhwaXJlc0F0EjwKDGxhc3Rfc3luY19hdBgJ'
    'IAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmxhc3RTeW5jQXQSOQoKY3JlYXRlZF'
    '9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIjCg1hY2Nv'
    'dW50X2NvdW50GAsgASgNUgxhY2NvdW50Q291bnQSPgoGY29uZmlnGAwgAygLMiYuYWNjb3VudG'
    'luZy5CYW5rQ29ubmVjdGlvbi5Db25maWdFbnRyeVIGY29uZmlnEicKD3N0YXRlbWVudHNfb25s'
    'eRgNIAEoCFIOc3RhdGVtZW50c09ubHkaOQoLQ29uZmlnRW50cnkSEAoDa2V5GAEgASgJUgNrZX'
    'kSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use createBankConnectionRequestDescriptor instead')
const CreateBankConnectionRequest$json = {
  '1': 'CreateBankConnectionRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'config',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.accounting.CreateBankConnectionRequest.ConfigEntry',
      '10': 'config'
    },
  ],
  '3': [CreateBankConnectionRequest_ConfigEntry$json],
};

@$core.Deprecated('Use createBankConnectionRequestDescriptor instead')
const CreateBankConnectionRequest_ConfigEntry$json = {
  '1': 'ConfigEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CreateBankConnectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBankConnectionRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVCYW5rQ29ubmVjdGlvblJlcXVlc3QSHQoKY29tcGFueV9pZBgBIAEoBFIJY29tcG'
    'FueUlkEhoKCHByb3ZpZGVyGAIgASgJUghwcm92aWRlchISCgRuYW1lGAMgASgJUgRuYW1lEksK'
    'BmNvbmZpZxgEIAMoCzIzLmFjY291bnRpbmcuQ3JlYXRlQmFua0Nvbm5lY3Rpb25SZXF1ZXN0Lk'
    'NvbmZpZ0VudHJ5UgZjb25maWcaOQoLQ29uZmlnRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoF'
    'dmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use createBankConnectionResponseDescriptor instead')
const CreateBankConnectionResponse$json = {
  '1': 'CreateBankConnectionResponse',
  '2': [
    {
      '1': 'connection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounting.BankConnection',
      '10': 'connection'
    },
    {'1': 'redirect_url', '3': 2, '4': 1, '5': 9, '10': 'redirectUrl'},
    {
      '1': 'choice',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.accounting.ChoiceRequired',
      '10': 'choice'
    },
  ],
};

/// Descriptor for `CreateBankConnectionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBankConnectionResponseDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVCYW5rQ29ubmVjdGlvblJlc3BvbnNlEjoKCmNvbm5lY3Rpb24YASABKAsyGi5hY2'
    'NvdW50aW5nLkJhbmtDb25uZWN0aW9uUgpjb25uZWN0aW9uEiEKDHJlZGlyZWN0X3VybBgCIAEo'
    'CVILcmVkaXJlY3RVcmwSMgoGY2hvaWNlGAMgASgLMhouYWNjb3VudGluZy5DaG9pY2VSZXF1aX'
    'JlZFIGY2hvaWNl');

@$core.Deprecated('Use choiceRequiredDescriptor instead')
const ChoiceRequired$json = {
  '1': 'ChoiceRequired',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {
      '1': 'options',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.accounting.ChoiceOption',
      '10': 'options'
    },
  ],
};

/// Descriptor for `ChoiceRequired`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List choiceRequiredDescriptor = $convert.base64Decode(
    'Cg5DaG9pY2VSZXF1aXJlZBIQCgNrZXkYASABKAlSA2tleRIUCgVsYWJlbBgCIAEoCVIFbGFiZW'
    'wSMgoHb3B0aW9ucxgDIAMoCzIYLmFjY291bnRpbmcuQ2hvaWNlT3B0aW9uUgdvcHRpb25z');

@$core.Deprecated('Use choiceOptionDescriptor instead')
const ChoiceOption$json = {
  '1': 'ChoiceOption',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `ChoiceOption`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List choiceOptionDescriptor = $convert.base64Decode(
    'CgxDaG9pY2VPcHRpb24SFAoFdmFsdWUYASABKAlSBXZhbHVlEhQKBWxhYmVsGAIgASgJUgVsYW'
    'JlbA==');

@$core.Deprecated('Use updateBankConnectionRequestDescriptor instead')
const UpdateBankConnectionRequest$json = {
  '1': 'UpdateBankConnectionRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'id', '3': 2, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'config',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.accounting.UpdateBankConnectionRequest.ConfigEntry',
      '10': 'config'
    },
  ],
  '3': [UpdateBankConnectionRequest_ConfigEntry$json],
};

@$core.Deprecated('Use updateBankConnectionRequestDescriptor instead')
const UpdateBankConnectionRequest_ConfigEntry$json = {
  '1': 'ConfigEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UpdateBankConnectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBankConnectionRequestDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVCYW5rQ29ubmVjdGlvblJlcXVlc3QSHQoKY29tcGFueV9pZBgBIAEoBFIJY29tcG'
    'FueUlkEg4KAmlkGAIgASgEUgJpZBISCgRuYW1lGAMgASgJUgRuYW1lEksKBmNvbmZpZxgEIAMo'
    'CzIzLmFjY291bnRpbmcuVXBkYXRlQmFua0Nvbm5lY3Rpb25SZXF1ZXN0LkNvbmZpZ0VudHJ5Ug'
    'Zjb25maWcaOQoLQ29uZmlnRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlS'
    'BXZhbHVlOgI4AQ==');

@$core.Deprecated('Use updateBankConnectionResponseDescriptor instead')
const UpdateBankConnectionResponse$json = {
  '1': 'UpdateBankConnectionResponse',
  '2': [
    {
      '1': 'connection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounting.BankConnection',
      '10': 'connection'
    },
    {
      '1': 'choice',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounting.ChoiceRequired',
      '10': 'choice'
    },
  ],
};

/// Descriptor for `UpdateBankConnectionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBankConnectionResponseDescriptor =
    $convert.base64Decode(
        'ChxVcGRhdGVCYW5rQ29ubmVjdGlvblJlc3BvbnNlEjoKCmNvbm5lY3Rpb24YASABKAsyGi5hY2'
        'NvdW50aW5nLkJhbmtDb25uZWN0aW9uUgpjb25uZWN0aW9uEjIKBmNob2ljZRgCIAEoCzIaLmFj'
        'Y291bnRpbmcuQ2hvaWNlUmVxdWlyZWRSBmNob2ljZQ==');

@$core.Deprecated('Use completeBankConnectionRequestDescriptor instead')
const CompleteBankConnectionRequest$json = {
  '1': 'CompleteBankConnectionRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    {
      '1': 'params',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.accounting.CompleteBankConnectionRequest.ParamsEntry',
      '10': 'params'
    },
  ],
  '3': [CompleteBankConnectionRequest_ParamsEntry$json],
};

@$core.Deprecated('Use completeBankConnectionRequestDescriptor instead')
const CompleteBankConnectionRequest_ParamsEntry$json = {
  '1': 'ParamsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CompleteBankConnectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeBankConnectionRequestDescriptor = $convert.base64Decode(
    'Ch1Db21wbGV0ZUJhbmtDb25uZWN0aW9uUmVxdWVzdBIcCglyZWZlcmVuY2UYASABKAlSCXJlZm'
    'VyZW5jZRJNCgZwYXJhbXMYAiADKAsyNS5hY2NvdW50aW5nLkNvbXBsZXRlQmFua0Nvbm5lY3Rp'
    'b25SZXF1ZXN0LlBhcmFtc0VudHJ5UgZwYXJhbXMaOQoLUGFyYW1zRW50cnkSEAoDa2V5GAEgAS'
    'gJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use listBankConnectionsResponseDescriptor instead')
const ListBankConnectionsResponse$json = {
  '1': 'ListBankConnectionsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.BankConnection',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListBankConnectionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBankConnectionsResponseDescriptor =
    $convert.base64Decode(
        'ChtMaXN0QmFua0Nvbm5lY3Rpb25zUmVzcG9uc2USMAoFaXRlbXMYASADKAsyGi5hY2NvdW50aW'
        '5nLkJhbmtDb25uZWN0aW9uUgVpdGVtcw==');

@$core.Deprecated('Use bankAccountDescriptor instead')
const BankAccount$json = {
  '1': 'BankAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'connection_id', '3': 2, '4': 1, '5': 4, '10': 'connectionId'},
    {'1': 'company_id', '3': 3, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'iban', '3': 5, '4': 1, '5': 9, '10': 'iban'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance_cents', '3': 7, '4': 1, '5': 3, '10': 'balanceCents'},
    {
      '1': 'balance_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'balanceAt'
    },
    {'1': 'is_primary', '3': 9, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'provider', '3': 10, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'connection_name', '3': 11, '4': 1, '5': 9, '10': 'connectionName'},
    {
      '1': 'connection_status',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.accounting.ConnectionStatus',
      '10': 'connectionStatus'
    },
    {
      '1': 'consent_expires_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'consentExpiresAt'
    },
    {
      '1': 'last_sync_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastSyncAt'
    },
    {
      '1': 'unexplained_count',
      '3': 15,
      '4': 1,
      '5': 13,
      '10': 'unexplainedCount'
    },
    {
      '1': 'for_approval_count',
      '3': 16,
      '4': 1,
      '5': 13,
      '10': 'forApprovalCount'
    },
  ],
};

/// Descriptor for `BankAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankAccountDescriptor = $convert.base64Decode(
    'CgtCYW5rQWNjb3VudBIOCgJpZBgBIAEoBFICaWQSIwoNY29ubmVjdGlvbl9pZBgCIAEoBFIMY2'
    '9ubmVjdGlvbklkEh0KCmNvbXBhbnlfaWQYAyABKARSCWNvbXBhbnlJZBISCgRuYW1lGAQgASgJ'
    'UgRuYW1lEhIKBGliYW4YBSABKAlSBGliYW4SGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5Ei'
    'MKDWJhbGFuY2VfY2VudHMYByABKANSDGJhbGFuY2VDZW50cxI5CgpiYWxhbmNlX2F0GAggASgL'
    'MhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJYmFsYW5jZUF0Eh0KCmlzX3ByaW1hcnkYCS'
    'ABKAhSCWlzUHJpbWFyeRIaCghwcm92aWRlchgKIAEoCVIIcHJvdmlkZXISJwoPY29ubmVjdGlv'
    'bl9uYW1lGAsgASgJUg5jb25uZWN0aW9uTmFtZRJJChFjb25uZWN0aW9uX3N0YXR1cxgMIAEoDj'
    'IcLmFjY291bnRpbmcuQ29ubmVjdGlvblN0YXR1c1IQY29ubmVjdGlvblN0YXR1cxJIChJjb25z'
    'ZW50X2V4cGlyZXNfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhBjb25zZW'
    '50RXhwaXJlc0F0EjwKDGxhc3Rfc3luY19hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSCmxhc3RTeW5jQXQSKwoRdW5leHBsYWluZWRfY291bnQYDyABKA1SEHVuZXhwbGFpbm'
    'VkQ291bnQSLAoSZm9yX2FwcHJvdmFsX2NvdW50GBAgASgNUhBmb3JBcHByb3ZhbENvdW50');

@$core.Deprecated('Use listBankAccountsResponseDescriptor instead')
const ListBankAccountsResponse$json = {
  '1': 'ListBankAccountsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.BankAccount',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListBankAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBankAccountsResponseDescriptor =
    $convert.base64Decode(
        'ChhMaXN0QmFua0FjY291bnRzUmVzcG9uc2USLQoFaXRlbXMYASADKAsyFy5hY2NvdW50aW5nLk'
        'JhbmtBY2NvdW50UgVpdGVtcw==');

@$core.Deprecated('Use syncNowResponseDescriptor instead')
const SyncNowResponse$json = {
  '1': 'SyncNowResponse',
  '2': [
    {
      '1': 'connections_synced',
      '3': 1,
      '4': 1,
      '5': 13,
      '10': 'connectionsSynced'
    },
    {
      '1': 'transactions_added',
      '3': 2,
      '4': 1,
      '5': 13,
      '10': 'transactionsAdded'
    },
    {'1': 'invoices_matched', '3': 3, '4': 1, '5': 13, '10': 'invoicesMatched'},
    {'1': 'errors', '3': 4, '4': 3, '5': 9, '10': 'errors'},
  ],
};

/// Descriptor for `SyncNowResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncNowResponseDescriptor = $convert.base64Decode(
    'Cg9TeW5jTm93UmVzcG9uc2USLQoSY29ubmVjdGlvbnNfc3luY2VkGAEgASgNUhFjb25uZWN0aW'
    '9uc1N5bmNlZBItChJ0cmFuc2FjdGlvbnNfYWRkZWQYAiABKA1SEXRyYW5zYWN0aW9uc0FkZGVk'
    'EikKEGludm9pY2VzX21hdGNoZWQYAyABKA1SD2ludm9pY2VzTWF0Y2hlZBIWCgZlcnJvcnMYBC'
    'ADKAlSBmVycm9ycw==');

@$core.Deprecated('Use uploadStatementRequestDescriptor instead')
const UploadStatementRequest$json = {
  '1': 'UploadStatementRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'filename', '3': 3, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'data', '3': 4, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `UploadStatementRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadStatementRequestDescriptor = $convert.base64Decode(
    'ChZVcGxvYWRTdGF0ZW1lbnRSZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZB'
    'IdCgphY2NvdW50X2lkGAIgASgEUglhY2NvdW50SWQSGgoIZmlsZW5hbWUYAyABKAlSCGZpbGVu'
    'YW1lEhIKBGRhdGEYBCABKAxSBGRhdGE=');

@$core.Deprecated('Use uploadStatementResponseDescriptor instead')
const UploadStatementResponse$json = {
  '1': 'UploadStatementResponse',
  '2': [
    {'1': 'imported', '3': 1, '4': 1, '5': 13, '10': 'imported'},
    {'1': 'duplicates', '3': 2, '4': 1, '5': 13, '10': 'duplicates'},
    {'1': 'skipped', '3': 3, '4': 1, '5': 13, '10': 'skipped'},
    {'1': 'invoices_matched', '3': 4, '4': 1, '5': 13, '10': 'invoicesMatched'},
    {'1': 'warnings', '3': 5, '4': 3, '5': 9, '10': 'warnings'},
  ],
};

/// Descriptor for `UploadStatementResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadStatementResponseDescriptor = $convert.base64Decode(
    'ChdVcGxvYWRTdGF0ZW1lbnRSZXNwb25zZRIaCghpbXBvcnRlZBgBIAEoDVIIaW1wb3J0ZWQSHg'
    'oKZHVwbGljYXRlcxgCIAEoDVIKZHVwbGljYXRlcxIYCgdza2lwcGVkGAMgASgNUgdza2lwcGVk'
    'EikKEGludm9pY2VzX21hdGNoZWQYBCABKA1SD2ludm9pY2VzTWF0Y2hlZBIaCgh3YXJuaW5ncx'
    'gFIAMoCVIId2FybmluZ3M=');

@$core.Deprecated('Use balanceHistoryRequestDescriptor instead')
const BalanceHistoryRequest$json = {
  '1': 'BalanceHistoryRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'months', '3': 3, '4': 1, '5': 13, '10': 'months'},
  ],
};

/// Descriptor for `BalanceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceHistoryRequestDescriptor = $convert.base64Decode(
    'ChVCYWxhbmNlSGlzdG9yeVJlcXVlc3QSHQoKY29tcGFueV9pZBgBIAEoBFIJY29tcGFueUlkEh'
    '0KCmFjY291bnRfaWQYAiABKARSCWFjY291bnRJZBIWCgZtb250aHMYAyABKA1SBm1vbnRocw==');

@$core.Deprecated('Use balancePointDescriptor instead')
const BalancePoint$json = {
  '1': 'BalancePoint',
  '2': [
    {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    {'1': 'balance_cents', '3': 2, '4': 1, '5': 3, '10': 'balanceCents'},
  ],
};

/// Descriptor for `BalancePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balancePointDescriptor = $convert.base64Decode(
    'CgxCYWxhbmNlUG9pbnQSFAoFbW9udGgYASABKAlSBW1vbnRoEiMKDWJhbGFuY2VfY2VudHMYAi'
    'ABKANSDGJhbGFuY2VDZW50cw==');

@$core.Deprecated('Use balanceHistoryResponseDescriptor instead')
const BalanceHistoryResponse$json = {
  '1': 'BalanceHistoryResponse',
  '2': [
    {
      '1': 'points',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.BalancePoint',
      '10': 'points'
    },
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `BalanceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceHistoryResponseDescriptor =
    $convert.base64Decode(
        'ChZCYWxhbmNlSGlzdG9yeVJlc3BvbnNlEjAKBnBvaW50cxgBIAMoCzIYLmFjY291bnRpbmcuQm'
        'FsYW5jZVBvaW50UgZwb2ludHMSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'company_id', '3': 3, '4': 1, '5': 4, '10': 'companyId'},
    {
      '1': 'booked_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'bookedAt'
    },
    {'1': 'value_date', '3': 5, '4': 1, '5': 9, '10': 'valueDate'},
    {'1': 'amount_cents', '3': 6, '4': 1, '5': 3, '10': 'amountCents'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'counterparty_name',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'counterpartyName'
    },
    {
      '1': 'counterparty_iban',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'counterpartyIban'
    },
    {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'category_id', '3': 12, '4': 1, '5': 4, '10': 'categoryId'},
    {'1': 'category_name', '3': 13, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'note', '3': 14, '4': 1, '5': 9, '10': 'note'},
    {
      '1': 'status',
      '3': 15,
      '4': 1,
      '5': 14,
      '6': '.accounting.TransactionStatus',
      '10': 'status'
    },
    {'1': 'invoice_id', '3': 16, '4': 1, '5': 4, '10': 'invoiceId'},
    {'1': 'invoice_number', '3': 17, '4': 1, '5': 9, '10': 'invoiceNumber'},
    {
      '1': 'attachment_count',
      '3': 18,
      '4': 1,
      '5': 13,
      '10': 'attachmentCount'
    },
    {
      '1': 'running_balance_cents',
      '3': 19,
      '4': 1,
      '5': 3,
      '10': 'runningBalanceCents'
    },
    {'1': 'account_name', '3': 20, '4': 1, '5': 9, '10': 'accountName'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoBFICaWQSHQoKYWNjb3VudF9pZBgCIAEoBFIJYWNjb3'
    'VudElkEh0KCmNvbXBhbnlfaWQYAyABKARSCWNvbXBhbnlJZBI3Cglib29rZWRfYXQYBCABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghib29rZWRBdBIdCgp2YWx1ZV9kYXRlGAUgAS'
    'gJUgl2YWx1ZURhdGUSIQoMYW1vdW50X2NlbnRzGAYgASgDUgthbW91bnRDZW50cxIaCghjdXJy'
    'ZW5jeRgHIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEi'
    'sKEWNvdW50ZXJwYXJ0eV9uYW1lGAkgASgJUhBjb3VudGVycGFydHlOYW1lEisKEWNvdW50ZXJw'
    'YXJ0eV9pYmFuGAogASgJUhBjb3VudGVycGFydHlJYmFuEhwKCXJlZmVyZW5jZRgLIAEoCVIJcm'
    'VmZXJlbmNlEh8KC2NhdGVnb3J5X2lkGAwgASgEUgpjYXRlZ29yeUlkEiMKDWNhdGVnb3J5X25h'
    'bWUYDSABKAlSDGNhdGVnb3J5TmFtZRISCgRub3RlGA4gASgJUgRub3RlEjUKBnN0YXR1cxgPIA'
    'EoDjIdLmFjY291bnRpbmcuVHJhbnNhY3Rpb25TdGF0dXNSBnN0YXR1cxIdCgppbnZvaWNlX2lk'
    'GBAgASgEUglpbnZvaWNlSWQSJQoOaW52b2ljZV9udW1iZXIYESABKAlSDWludm9pY2VOdW1iZX'
    'ISKQoQYXR0YWNobWVudF9jb3VudBgSIAEoDVIPYXR0YWNobWVudENvdW50EjIKFXJ1bm5pbmdf'
    'YmFsYW5jZV9jZW50cxgTIAEoA1ITcnVubmluZ0JhbGFuY2VDZW50cxIhCgxhY2NvdW50X25hbW'
    'UYFCABKAlSC2FjY291bnROYW1l');

@$core.Deprecated('Use listTransactionsRequestDescriptor instead')
const ListTransactionsRequest$json = {
  '1': 'ListTransactionsRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 4, '10': 'accountId'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.accounting.TransactionStatus',
      '10': 'status'
    },
    {'1': 'month', '3': 4, '4': 1, '5': 9, '10': 'month'},
    {'1': 'search', '3': 5, '4': 1, '5': 9, '10': 'search'},
    {'1': 'page', '3': 6, '4': 1, '5': 13, '10': 'page'},
    {'1': 'page_size', '3': 7, '4': 1, '5': 13, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransactionsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0VHJhbnNhY3Rpb25zUmVxdWVzdBIdCgpjb21wYW55X2lkGAEgASgEUgljb21wYW55SW'
    'QSHQoKYWNjb3VudF9pZBgCIAEoBFIJYWNjb3VudElkEjUKBnN0YXR1cxgDIAEoDjIdLmFjY291'
    'bnRpbmcuVHJhbnNhY3Rpb25TdGF0dXNSBnN0YXR1cxIUCgVtb250aBgEIAEoCVIFbW9udGgSFg'
    'oGc2VhcmNoGAUgASgJUgZzZWFyY2gSEgoEcGFnZRgGIAEoDVIEcGFnZRIbCglwYWdlX3NpemUY'
    'ByABKA1SCHBhZ2VTaXpl');

@$core.Deprecated('Use listTransactionsResponseDescriptor instead')
const ListTransactionsResponse$json = {
  '1': 'ListTransactionsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Transaction',
      '10': 'items'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 13, '10': 'total'},
    {
      '1': 'balance_brought_forward_cents',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'balanceBroughtForwardCents'
    },
  ],
};

/// Descriptor for `ListTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransactionsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0VHJhbnNhY3Rpb25zUmVzcG9uc2USLQoFaXRlbXMYASADKAsyFy5hY2NvdW50aW5nLl'
    'RyYW5zYWN0aW9uUgVpdGVtcxIUCgV0b3RhbBgCIAEoDVIFdG90YWwSQQodYmFsYW5jZV9icm91'
    'Z2h0X2ZvcndhcmRfY2VudHMYAyABKANSGmJhbGFuY2VCcm91Z2h0Rm9yd2FyZENlbnRz');

@$core.Deprecated('Use explainTransactionRequestDescriptor instead')
const ExplainTransactionRequest$json = {
  '1': 'ExplainTransactionRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'id', '3': 2, '4': 1, '5': 4, '10': 'id'},
    {'1': 'category_id', '3': 3, '4': 1, '5': 4, '10': 'categoryId'},
    {'1': 'note', '3': 4, '4': 1, '5': 9, '10': 'note'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'approve', '3': 6, '4': 1, '5': 8, '10': 'approve'},
  ],
};

/// Descriptor for `ExplainTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List explainTransactionRequestDescriptor = $convert.base64Decode(
    'ChlFeHBsYWluVHJhbnNhY3Rpb25SZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbn'
    'lJZBIOCgJpZBgCIAEoBFICaWQSHwoLY2F0ZWdvcnlfaWQYAyABKARSCmNhdGVnb3J5SWQSEgoE'
    'bm90ZRgEIAEoCVIEbm90ZRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGAoHYX'
    'Bwcm92ZRgGIAEoCFIHYXBwcm92ZQ==');

@$core.Deprecated('Use approveTransactionsRequestDescriptor instead')
const ApproveTransactionsRequest$json = {
  '1': 'ApproveTransactionsRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'ids', '3': 2, '4': 3, '5': 4, '10': 'ids'},
  ],
};

/// Descriptor for `ApproveTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveTransactionsRequestDescriptor =
    $convert.base64Decode(
        'ChpBcHByb3ZlVHJhbnNhY3Rpb25zUmVxdWVzdBIdCgpjb21wYW55X2lkGAEgASgEUgljb21wYW'
        '55SWQSEAoDaWRzGAIgAygEUgNpZHM=');

@$core.Deprecated('Use linkTransactionRequestDescriptor instead')
const LinkTransactionRequest$json = {
  '1': 'LinkTransactionRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 4, '10': 'transactionId'},
    {'1': 'invoice_id', '3': 3, '4': 1, '5': 4, '10': 'invoiceId'},
  ],
};

/// Descriptor for `LinkTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkTransactionRequestDescriptor = $convert.base64Decode(
    'ChZMaW5rVHJhbnNhY3Rpb25SZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZB'
    'IlCg50cmFuc2FjdGlvbl9pZBgCIAEoBFINdHJhbnNhY3Rpb25JZBIdCgppbnZvaWNlX2lkGAMg'
    'ASgEUglpbnZvaWNlSWQ=');

@$core.Deprecated('Use attachmentDescriptor instead')
const Attachment$json = {
  '1': 'Attachment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'company_id', '3': 2, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 4, '10': 'transactionId'},
    {'1': 'invoice_id', '3': 4, '4': 1, '5': 4, '10': 'invoiceId'},
    {'1': 'filename', '3': 5, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'mime', '3': 6, '4': 1, '5': 9, '10': 'mime'},
    {'1': 'size_bytes', '3': 7, '4': 1, '5': 4, '10': 'sizeBytes'},
    {
      '1': 'created_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Attachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentDescriptor = $convert.base64Decode(
    'CgpBdHRhY2htZW50Eg4KAmlkGAEgASgEUgJpZBIdCgpjb21wYW55X2lkGAIgASgEUgljb21wYW'
    '55SWQSJQoOdHJhbnNhY3Rpb25faWQYAyABKARSDXRyYW5zYWN0aW9uSWQSHQoKaW52b2ljZV9p'
    'ZBgEIAEoBFIJaW52b2ljZUlkEhoKCGZpbGVuYW1lGAUgASgJUghmaWxlbmFtZRISCgRtaW1lGA'
    'YgASgJUgRtaW1lEh0KCnNpemVfYnl0ZXMYByABKARSCXNpemVCeXRlcxI5CgpjcmVhdGVkX2F0'
    'GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');

@$core.Deprecated('Use uploadAttachmentRequestDescriptor instead')
const UploadAttachmentRequest$json = {
  '1': 'UploadAttachmentRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 4, '10': 'transactionId'},
    {'1': 'invoice_id', '3': 3, '4': 1, '5': 4, '10': 'invoiceId'},
    {'1': 'filename', '3': 4, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'data', '3': 5, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `UploadAttachmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadAttachmentRequestDescriptor = $convert.base64Decode(
    'ChdVcGxvYWRBdHRhY2htZW50UmVxdWVzdBIdCgpjb21wYW55X2lkGAEgASgEUgljb21wYW55SW'
    'QSJQoOdHJhbnNhY3Rpb25faWQYAiABKARSDXRyYW5zYWN0aW9uSWQSHQoKaW52b2ljZV9pZBgD'
    'IAEoBFIJaW52b2ljZUlkEhoKCGZpbGVuYW1lGAQgASgJUghmaWxlbmFtZRISCgRkYXRhGAUgAS'
    'gMUgRkYXRh');

@$core.Deprecated('Use listAttachmentsRequestDescriptor instead')
const ListAttachmentsRequest$json = {
  '1': 'ListAttachmentsRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 4, '10': 'transactionId'},
    {'1': 'invoice_id', '3': 3, '4': 1, '5': 4, '10': 'invoiceId'},
  ],
};

/// Descriptor for `ListAttachmentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAttachmentsRequestDescriptor = $convert.base64Decode(
    'ChZMaXN0QXR0YWNobWVudHNSZXF1ZXN0Eh0KCmNvbXBhbnlfaWQYASABKARSCWNvbXBhbnlJZB'
    'IlCg50cmFuc2FjdGlvbl9pZBgCIAEoBFINdHJhbnNhY3Rpb25JZBIdCgppbnZvaWNlX2lkGAMg'
    'ASgEUglpbnZvaWNlSWQ=');

@$core.Deprecated('Use listAttachmentsResponseDescriptor instead')
const ListAttachmentsResponse$json = {
  '1': 'ListAttachmentsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounting.Attachment',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListAttachmentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAttachmentsResponseDescriptor =
    $convert.base64Decode(
        'ChdMaXN0QXR0YWNobWVudHNSZXNwb25zZRIsCgVpdGVtcxgBIAMoCzIWLmFjY291bnRpbmcuQX'
        'R0YWNobWVudFIFaXRlbXM=');

@$core.Deprecated('Use overviewRequestDescriptor instead')
const OverviewRequest$json = {
  '1': 'OverviewRequest',
  '2': [
    {'1': 'company_id', '3': 1, '4': 1, '5': 4, '10': 'companyId'},
    {'1': 'months', '3': 2, '4': 1, '5': 13, '10': 'months'},
  ],
};

/// Descriptor for `OverviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overviewRequestDescriptor = $convert.base64Decode(
    'Cg9PdmVydmlld1JlcXVlc3QSHQoKY29tcGFueV9pZBgBIAEoBFIJY29tcGFueUlkEhYKBm1vbn'
    'RocxgCIAEoDVIGbW9udGhz');

@$core.Deprecated('Use cashflowPointDescriptor instead')
const CashflowPoint$json = {
  '1': 'CashflowPoint',
  '2': [
    {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    {'1': 'in_cents', '3': 2, '4': 1, '5': 3, '10': 'inCents'},
    {'1': 'out_cents', '3': 3, '4': 1, '5': 3, '10': 'outCents'},
  ],
};

/// Descriptor for `CashflowPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cashflowPointDescriptor = $convert.base64Decode(
    'Cg1DYXNoZmxvd1BvaW50EhQKBW1vbnRoGAEgASgJUgVtb250aBIZCghpbl9jZW50cxgCIAEoA1'
    'IHaW5DZW50cxIbCglvdXRfY2VudHMYAyABKANSCG91dENlbnRz');

@$core.Deprecated('Use invoiceTimelinePointDescriptor instead')
const InvoiceTimelinePoint$json = {
  '1': 'InvoiceTimelinePoint',
  '2': [
    {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    {'1': 'paid_cents', '3': 2, '4': 1, '5': 3, '10': 'paidCents'},
    {'1': 'due_cents', '3': 3, '4': 1, '5': 3, '10': 'dueCents'},
    {'1': 'overdue_cents', '3': 4, '4': 1, '5': 3, '10': 'overdueCents'},
  ],
};

/// Descriptor for `InvoiceTimelinePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceTimelinePointDescriptor = $convert.base64Decode(
    'ChRJbnZvaWNlVGltZWxpbmVQb2ludBIUCgVtb250aBgBIAEoCVIFbW9udGgSHQoKcGFpZF9jZW'
    '50cxgCIAEoA1IJcGFpZENlbnRzEhsKCWR1ZV9jZW50cxgDIAEoA1IIZHVlQ2VudHMSIwoNb3Zl'
    'cmR1ZV9jZW50cxgEIAEoA1IMb3ZlcmR1ZUNlbnRz');

@$core.Deprecated('Use overviewResponseDescriptor instead')
const OverviewResponse$json = {
  '1': 'OverviewResponse',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'cashflow',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.accounting.CashflowPoint',
      '10': 'cashflow'
    },
    {'1': 'incoming_cents', '3': 3, '4': 1, '5': 3, '10': 'incomingCents'},
    {'1': 'outgoing_cents', '3': 4, '4': 1, '5': 3, '10': 'outgoingCents'},
    {
      '1': 'balance_history',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.accounting.BalancePoint',
      '10': 'balanceHistory'
    },
    {
      '1': 'total_balance_cents',
      '3': 6,
      '4': 1,
      '5': 3,
      '10': 'totalBalanceCents'
    },
    {
      '1': 'invoice_timeline',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.accounting.InvoiceTimelinePoint',
      '10': 'invoiceTimeline'
    },
    {
      '1': 'outstanding_cents',
      '3': 8,
      '4': 1,
      '5': 3,
      '10': 'outstandingCents'
    },
    {'1': 'income_cents', '3': 9, '4': 1, '5': 3, '10': 'incomeCents'},
    {'1': 'expenses_cents', '3': 10, '4': 1, '5': 3, '10': 'expensesCents'},
    {
      '1': 'for_approval_count',
      '3': 11,
      '4': 1,
      '5': 13,
      '10': 'forApprovalCount'
    },
    {
      '1': 'unexplained_count',
      '3': 12,
      '4': 1,
      '5': 13,
      '10': 'unexplainedCount'
    },
    {
      '1': 'has_bank_accounts',
      '3': 13,
      '4': 1,
      '5': 8,
      '10': 'hasBankAccounts'
    },
    {
      '1': 'has_expired_connections',
      '3': 14,
      '4': 1,
      '5': 8,
      '10': 'hasExpiredConnections'
    },
  ],
};

/// Descriptor for `OverviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overviewResponseDescriptor = $convert.base64Decode(
    'ChBPdmVydmlld1Jlc3BvbnNlEhoKCGN1cnJlbmN5GAEgASgJUghjdXJyZW5jeRI1CghjYXNoZm'
    'xvdxgCIAMoCzIZLmFjY291bnRpbmcuQ2FzaGZsb3dQb2ludFIIY2FzaGZsb3cSJQoOaW5jb21p'
    'bmdfY2VudHMYAyABKANSDWluY29taW5nQ2VudHMSJQoOb3V0Z29pbmdfY2VudHMYBCABKANSDW'
    '91dGdvaW5nQ2VudHMSQQoPYmFsYW5jZV9oaXN0b3J5GAUgAygLMhguYWNjb3VudGluZy5CYWxh'
    'bmNlUG9pbnRSDmJhbGFuY2VIaXN0b3J5Ei4KE3RvdGFsX2JhbGFuY2VfY2VudHMYBiABKANSEX'
    'RvdGFsQmFsYW5jZUNlbnRzEksKEGludm9pY2VfdGltZWxpbmUYByADKAsyIC5hY2NvdW50aW5n'
    'Lkludm9pY2VUaW1lbGluZVBvaW50Ug9pbnZvaWNlVGltZWxpbmUSKwoRb3V0c3RhbmRpbmdfY2'
    'VudHMYCCABKANSEG91dHN0YW5kaW5nQ2VudHMSIQoMaW5jb21lX2NlbnRzGAkgASgDUgtpbmNv'
    'bWVDZW50cxIlCg5leHBlbnNlc19jZW50cxgKIAEoA1INZXhwZW5zZXNDZW50cxIsChJmb3JfYX'
    'Bwcm92YWxfY291bnQYCyABKA1SEGZvckFwcHJvdmFsQ291bnQSKwoRdW5leHBsYWluZWRfY291'
    'bnQYDCABKA1SEHVuZXhwbGFpbmVkQ291bnQSKgoRaGFzX2JhbmtfYWNjb3VudHMYDSABKAhSD2'
    'hhc0JhbmtBY2NvdW50cxI2ChdoYXNfZXhwaXJlZF9jb25uZWN0aW9ucxgOIAEoCFIVaGFzRXhw'
    'aXJlZENvbm5lY3Rpb25z');
