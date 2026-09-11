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

import 'package:protobuf/protobuf.dart' as $pb;

class CategoryKind extends $pb.ProtobufEnum {
  static const CategoryKind CATEGORY_KIND_UNSPECIFIED =
      CategoryKind._(0, _omitEnumNames ? '' : 'CATEGORY_KIND_UNSPECIFIED');
  static const CategoryKind CATEGORY_KIND_INCOME =
      CategoryKind._(1, _omitEnumNames ? '' : 'CATEGORY_KIND_INCOME');
  static const CategoryKind CATEGORY_KIND_EXPENSE =
      CategoryKind._(2, _omitEnumNames ? '' : 'CATEGORY_KIND_EXPENSE');

  static const $core.List<CategoryKind> values = <CategoryKind>[
    CATEGORY_KIND_UNSPECIFIED,
    CATEGORY_KIND_INCOME,
    CATEGORY_KIND_EXPENSE,
  ];

  static final $core.List<CategoryKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CategoryKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CategoryKind._(super.value, super.name);
}

class InvoiceStatus extends $pb.ProtobufEnum {
  static const InvoiceStatus INVOICE_STATUS_UNSPECIFIED =
      InvoiceStatus._(0, _omitEnumNames ? '' : 'INVOICE_STATUS_UNSPECIFIED');
  static const InvoiceStatus INVOICE_STATUS_DRAFT =
      InvoiceStatus._(1, _omitEnumNames ? '' : 'INVOICE_STATUS_DRAFT');
  static const InvoiceStatus INVOICE_STATUS_OPEN =
      InvoiceStatus._(2, _omitEnumNames ? '' : 'INVOICE_STATUS_OPEN');
  static const InvoiceStatus INVOICE_STATUS_PAID =
      InvoiceStatus._(3, _omitEnumNames ? '' : 'INVOICE_STATUS_PAID');
  static const InvoiceStatus INVOICE_STATUS_CANCELLED =
      InvoiceStatus._(4, _omitEnumNames ? '' : 'INVOICE_STATUS_CANCELLED');

  static const $core.List<InvoiceStatus> values = <InvoiceStatus>[
    INVOICE_STATUS_UNSPECIFIED,
    INVOICE_STATUS_DRAFT,
    INVOICE_STATUS_OPEN,
    INVOICE_STATUS_PAID,
    INVOICE_STATUS_CANCELLED,
  ];

  static final $core.List<InvoiceStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static InvoiceStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InvoiceStatus._(super.value, super.name);
}

class FieldKind extends $pb.ProtobufEnum {
  static const FieldKind FIELD_KIND_TEXT =
      FieldKind._(0, _omitEnumNames ? '' : 'FIELD_KIND_TEXT');
  static const FieldKind FIELD_KIND_SECRET =
      FieldKind._(1, _omitEnumNames ? '' : 'FIELD_KIND_SECRET');
  static const FieldKind FIELD_KIND_MULTILINE =
      FieldKind._(2, _omitEnumNames ? '' : 'FIELD_KIND_MULTILINE');
  static const FieldKind FIELD_KIND_SELECT =
      FieldKind._(3, _omitEnumNames ? '' : 'FIELD_KIND_SELECT');
  static const FieldKind FIELD_KIND_BOOL =
      FieldKind._(4, _omitEnumNames ? '' : 'FIELD_KIND_BOOL');

  static const $core.List<FieldKind> values = <FieldKind>[
    FIELD_KIND_TEXT,
    FIELD_KIND_SECRET,
    FIELD_KIND_MULTILINE,
    FIELD_KIND_SELECT,
    FIELD_KIND_BOOL,
  ];

  static final $core.List<FieldKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static FieldKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FieldKind._(super.value, super.name);
}

class ConnectionStatus extends $pb.ProtobufEnum {
  static const ConnectionStatus CONNECTION_STATUS_UNSPECIFIED =
      ConnectionStatus._(
          0, _omitEnumNames ? '' : 'CONNECTION_STATUS_UNSPECIFIED');
  static const ConnectionStatus CONNECTION_STATUS_PENDING =
      ConnectionStatus._(1, _omitEnumNames ? '' : 'CONNECTION_STATUS_PENDING');
  static const ConnectionStatus CONNECTION_STATUS_ACTIVE =
      ConnectionStatus._(2, _omitEnumNames ? '' : 'CONNECTION_STATUS_ACTIVE');
  static const ConnectionStatus CONNECTION_STATUS_EXPIRED =
      ConnectionStatus._(3, _omitEnumNames ? '' : 'CONNECTION_STATUS_EXPIRED');
  static const ConnectionStatus CONNECTION_STATUS_ERROR =
      ConnectionStatus._(4, _omitEnumNames ? '' : 'CONNECTION_STATUS_ERROR');

  static const $core.List<ConnectionStatus> values = <ConnectionStatus>[
    CONNECTION_STATUS_UNSPECIFIED,
    CONNECTION_STATUS_PENDING,
    CONNECTION_STATUS_ACTIVE,
    CONNECTION_STATUS_EXPIRED,
    CONNECTION_STATUS_ERROR,
  ];

  static final $core.List<ConnectionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ConnectionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ConnectionStatus._(super.value, super.name);
}

class TransactionStatus extends $pb.ProtobufEnum {
  static const TransactionStatus TRANSACTION_STATUS_UNSPECIFIED =
      TransactionStatus._(
          0, _omitEnumNames ? '' : 'TRANSACTION_STATUS_UNSPECIFIED');
  static const TransactionStatus TRANSACTION_STATUS_UNEXPLAINED =
      TransactionStatus._(
          1, _omitEnumNames ? '' : 'TRANSACTION_STATUS_UNEXPLAINED');
  static const TransactionStatus TRANSACTION_STATUS_EXPLAINED =
      TransactionStatus._(
          2, _omitEnumNames ? '' : 'TRANSACTION_STATUS_EXPLAINED');
  static const TransactionStatus TRANSACTION_STATUS_APPROVED =
      TransactionStatus._(
          3, _omitEnumNames ? '' : 'TRANSACTION_STATUS_APPROVED');

  static const $core.List<TransactionStatus> values = <TransactionStatus>[
    TRANSACTION_STATUS_UNSPECIFIED,
    TRANSACTION_STATUS_UNEXPLAINED,
    TRANSACTION_STATUS_EXPLAINED,
    TRANSACTION_STATUS_APPROVED,
  ];

  static final $core.List<TransactionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TransactionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TransactionStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
