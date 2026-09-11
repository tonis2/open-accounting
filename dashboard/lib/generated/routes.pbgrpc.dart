// This is a generated file - do not edit.
//
// Generated from routes.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'routes.pb.dart' as $0;

export 'routes.pb.dart';

@$pb.GrpcServiceName('accounting.AccountingService')
class AccountingServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AccountingServiceClient(super.channel, {super.options, super.interceptors});

  /// Auth (no token required)
  $grpc.ResponseFuture<$0.AuthResponse> register(
    $0.RegisterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> login(
    $0.LoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> requestRecovery(
    $0.RequestRecoveryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestRecovery, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecoveryTokenResponse> validateRecoveryToken(
    $0.RecoveryTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateRecoveryToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> recoverAccount(
    $0.RecoverAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$recoverAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.PasskeyOptionsResponse> beginPasskeyLogin(
    $0.BeginPasskeyLoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$beginPasskeyLogin, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> finishPasskeyLogin(
    $0.FinishPasskeyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$finishPasskeyLogin, request, options: options);
  }

  /// Account
  $grpc.ResponseFuture<$0.User> me(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$me, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> changePassword(
    $0.ChangePasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$changePassword, request, options: options);
  }

  $grpc.ResponseFuture<$0.PasskeyOptionsResponse> beginPasskeyRegistration(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$beginPasskeyRegistration, request, options: options);
  }

  $grpc.ResponseFuture<$0.Passkey> finishPasskeyRegistration(
    $0.FinishPasskeyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$finishPasskeyRegistration, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPasskeysResponse> listPasskeys(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listPasskeys, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deletePasskey(
    $0.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deletePasskey, request, options: options);
  }

  /// Companies
  $grpc.ResponseFuture<$0.Company> createCompany(
    $0.Company request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createCompany, request, options: options);
  }

  $grpc.ResponseFuture<$0.Company> updateCompany(
    $0.Company request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateCompany, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListCompaniesResponse> listCompanies(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listCompanies, request, options: options);
  }

  $grpc.ResponseFuture<$0.Company> getCompany(
    $0.CompanyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCompany, request, options: options);
  }

  /// Projects
  $grpc.ResponseFuture<$0.Project> createProject(
    $0.Project request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.Project> updateProject(
    $0.Project request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteProject(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListProjectsResponse> listProjects(
    $0.ListProjectsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listProjects, request, options: options);
  }

  $grpc.ResponseFuture<$0.Project> getProject(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProject, request, options: options);
  }

  /// Categories
  $grpc.ResponseFuture<$0.ListCategoriesResponse> listCategories(
    $0.CompanyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listCategories, request, options: options);
  }

  $grpc.ResponseFuture<$0.Category> createCategory(
    $0.Category request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createCategory, request, options: options);
  }

  $grpc.ResponseFuture<$0.Category> updateCategory(
    $0.Category request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateCategory, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteCategory(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteCategory, request, options: options);
  }

  /// Invoices
  $grpc.ResponseFuture<$0.Invoice> createInvoice(
    $0.Invoice request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> updateInvoice(
    $0.Invoice request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListInvoicesResponse> listInvoices(
    $0.ListInvoicesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> getInvoice(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> issueInvoice(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$issueInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> sendInvoice(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.FileResponse> getInvoicePdf(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoicePdf, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> markInvoicePaid(
    $0.MarkInvoicePaidRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$markInvoicePaid, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> unlinkInvoicePayment(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unlinkInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.Invoice> cancelInvoice(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteInvoice(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteInvoice, request, options: options);
  }

  /// Banking
  $grpc.ResponseFuture<$0.ListBankProvidersResponse> listBankProviders(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listBankProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListInstitutionsResponse> listInstitutions(
    $0.ListInstitutionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listInstitutions, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateBankConnectionResponse> createBankConnection(
    $0.CreateBankConnectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createBankConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.BankConnection> completeBankConnection(
    $0.CompleteBankConnectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeBankConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.BankConnection> updateBankConnection(
    $0.UpdateBankConnectionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateBankConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateBankConnectionResponse> reconnectBankConnection(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reconnectBankConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListBankConnectionsResponse> listBankConnections(
    $0.CompanyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listBankConnections, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteBankConnection(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteBankConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListBankAccountsResponse> listBankAccounts(
    $0.CompanyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listBankAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> setPrimaryAccount(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setPrimaryAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.SyncNowResponse> syncNow(
    $0.CompanyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$syncNow, request, options: options);
  }

  $grpc.ResponseFuture<$0.BalanceHistoryResponse> getBalanceHistory(
    $0.BalanceHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getBalanceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadStatementResponse> uploadStatement(
    $0.UploadStatementRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadStatement, request, options: options);
  }

  /// Transactions
  $grpc.ResponseFuture<$0.ListTransactionsResponse> listTransactions(
    $0.ListTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.Transaction> explainTransaction(
    $0.ExplainTransactionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$explainTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> approveTransactions(
    $0.ApproveTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$approveTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.Transaction> linkTransactionToInvoice(
    $0.LinkTransactionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$linkTransactionToInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Attachment> uploadAttachment(
    $0.UploadAttachmentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadAttachment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListAttachmentsResponse> listAttachments(
    $0.ListAttachmentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listAttachments, request, options: options);
  }

  $grpc.ResponseFuture<$0.FileResponse> getAttachment(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAttachment, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteAttachment(
    $0.CompanyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteAttachment, request, options: options);
  }

  /// Dashboard
  $grpc.ResponseFuture<$0.OverviewResponse> getOverview(
    $0.OverviewRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOverview, request, options: options);
  }

  // method descriptors

  static final _$register = $grpc.ClientMethod<$0.RegisterRequest, $0.AuthResponse>(
      '/accounting.AccountingService/Register', ($0.RegisterRequest value) => value.writeToBuffer(), $0.AuthResponse.fromBuffer);
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.AuthResponse>(
      '/accounting.AccountingService/Login', ($0.LoginRequest value) => value.writeToBuffer(), $0.AuthResponse.fromBuffer);
  static final _$requestRecovery = $grpc.ClientMethod<$0.RequestRecoveryRequest, $0.Empty>(
      '/accounting.AccountingService/RequestRecovery', ($0.RequestRecoveryRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$validateRecoveryToken = $grpc.ClientMethod<$0.RecoveryTokenRequest, $0.RecoveryTokenResponse>(
      '/accounting.AccountingService/ValidateRecoveryToken', ($0.RecoveryTokenRequest value) => value.writeToBuffer(), $0.RecoveryTokenResponse.fromBuffer);
  static final _$recoverAccount = $grpc.ClientMethod<$0.RecoverAccountRequest, $0.AuthResponse>(
      '/accounting.AccountingService/RecoverAccount', ($0.RecoverAccountRequest value) => value.writeToBuffer(), $0.AuthResponse.fromBuffer);
  static final _$beginPasskeyLogin = $grpc.ClientMethod<$0.BeginPasskeyLoginRequest, $0.PasskeyOptionsResponse>(
      '/accounting.AccountingService/BeginPasskeyLogin', ($0.BeginPasskeyLoginRequest value) => value.writeToBuffer(), $0.PasskeyOptionsResponse.fromBuffer);
  static final _$finishPasskeyLogin = $grpc.ClientMethod<$0.FinishPasskeyRequest, $0.AuthResponse>(
      '/accounting.AccountingService/FinishPasskeyLogin', ($0.FinishPasskeyRequest value) => value.writeToBuffer(), $0.AuthResponse.fromBuffer);
  static final _$me = $grpc.ClientMethod<$0.Empty, $0.User>('/accounting.AccountingService/Me', ($0.Empty value) => value.writeToBuffer(), $0.User.fromBuffer);
  static final _$changePassword = $grpc.ClientMethod<$0.ChangePasswordRequest, $0.Empty>(
      '/accounting.AccountingService/ChangePassword', ($0.ChangePasswordRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$beginPasskeyRegistration = $grpc.ClientMethod<$0.Empty, $0.PasskeyOptionsResponse>(
      '/accounting.AccountingService/BeginPasskeyRegistration', ($0.Empty value) => value.writeToBuffer(), $0.PasskeyOptionsResponse.fromBuffer);
  static final _$finishPasskeyRegistration = $grpc.ClientMethod<$0.FinishPasskeyRequest, $0.Passkey>(
      '/accounting.AccountingService/FinishPasskeyRegistration', ($0.FinishPasskeyRequest value) => value.writeToBuffer(), $0.Passkey.fromBuffer);
  static final _$listPasskeys = $grpc.ClientMethod<$0.Empty, $0.ListPasskeysResponse>(
      '/accounting.AccountingService/ListPasskeys', ($0.Empty value) => value.writeToBuffer(), $0.ListPasskeysResponse.fromBuffer);
  static final _$deletePasskey = $grpc.ClientMethod<$0.IdRequest, $0.Empty>(
      '/accounting.AccountingService/DeletePasskey', ($0.IdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$createCompany = $grpc.ClientMethod<$0.Company, $0.Company>(
      '/accounting.AccountingService/CreateCompany', ($0.Company value) => value.writeToBuffer(), $0.Company.fromBuffer);
  static final _$updateCompany = $grpc.ClientMethod<$0.Company, $0.Company>(
      '/accounting.AccountingService/UpdateCompany', ($0.Company value) => value.writeToBuffer(), $0.Company.fromBuffer);
  static final _$listCompanies = $grpc.ClientMethod<$0.Empty, $0.ListCompaniesResponse>(
      '/accounting.AccountingService/ListCompanies', ($0.Empty value) => value.writeToBuffer(), $0.ListCompaniesResponse.fromBuffer);
  static final _$getCompany = $grpc.ClientMethod<$0.CompanyRequest, $0.Company>(
      '/accounting.AccountingService/GetCompany', ($0.CompanyRequest value) => value.writeToBuffer(), $0.Company.fromBuffer);
  static final _$createProject = $grpc.ClientMethod<$0.Project, $0.Project>(
      '/accounting.AccountingService/CreateProject', ($0.Project value) => value.writeToBuffer(), $0.Project.fromBuffer);
  static final _$updateProject = $grpc.ClientMethod<$0.Project, $0.Project>(
      '/accounting.AccountingService/UpdateProject', ($0.Project value) => value.writeToBuffer(), $0.Project.fromBuffer);
  static final _$deleteProject = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Empty>(
      '/accounting.AccountingService/DeleteProject', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$listProjects = $grpc.ClientMethod<$0.ListProjectsRequest, $0.ListProjectsResponse>(
      '/accounting.AccountingService/ListProjects', ($0.ListProjectsRequest value) => value.writeToBuffer(), $0.ListProjectsResponse.fromBuffer);
  static final _$getProject = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Project>(
      '/accounting.AccountingService/GetProject', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Project.fromBuffer);
  static final _$listCategories = $grpc.ClientMethod<$0.CompanyRequest, $0.ListCategoriesResponse>(
      '/accounting.AccountingService/ListCategories', ($0.CompanyRequest value) => value.writeToBuffer(), $0.ListCategoriesResponse.fromBuffer);
  static final _$createCategory = $grpc.ClientMethod<$0.Category, $0.Category>(
      '/accounting.AccountingService/CreateCategory', ($0.Category value) => value.writeToBuffer(), $0.Category.fromBuffer);
  static final _$updateCategory = $grpc.ClientMethod<$0.Category, $0.Category>(
      '/accounting.AccountingService/UpdateCategory', ($0.Category value) => value.writeToBuffer(), $0.Category.fromBuffer);
  static final _$deleteCategory = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Empty>(
      '/accounting.AccountingService/DeleteCategory', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$createInvoice = $grpc.ClientMethod<$0.Invoice, $0.Invoice>(
      '/accounting.AccountingService/CreateInvoice', ($0.Invoice value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$updateInvoice = $grpc.ClientMethod<$0.Invoice, $0.Invoice>(
      '/accounting.AccountingService/UpdateInvoice', ($0.Invoice value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$listInvoices = $grpc.ClientMethod<$0.ListInvoicesRequest, $0.ListInvoicesResponse>(
      '/accounting.AccountingService/ListInvoices', ($0.ListInvoicesRequest value) => value.writeToBuffer(), $0.ListInvoicesResponse.fromBuffer);
  static final _$getInvoice = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Invoice>(
      '/accounting.AccountingService/GetInvoice', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$issueInvoice = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Invoice>(
      '/accounting.AccountingService/IssueInvoice', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$sendInvoice = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Invoice>(
      '/accounting.AccountingService/SendInvoice', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$getInvoicePdf = $grpc.ClientMethod<$0.CompanyIdRequest, $0.FileResponse>(
      '/accounting.AccountingService/GetInvoicePdf', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.FileResponse.fromBuffer);
  static final _$markInvoicePaid = $grpc.ClientMethod<$0.MarkInvoicePaidRequest, $0.Invoice>(
      '/accounting.AccountingService/MarkInvoicePaid', ($0.MarkInvoicePaidRequest value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$unlinkInvoicePayment = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Invoice>(
      '/accounting.AccountingService/UnlinkInvoicePayment', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$cancelInvoice = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Invoice>(
      '/accounting.AccountingService/CancelInvoice', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Invoice.fromBuffer);
  static final _$deleteInvoice = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Empty>(
      '/accounting.AccountingService/DeleteInvoice', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$listBankProviders = $grpc.ClientMethod<$0.Empty, $0.ListBankProvidersResponse>(
      '/accounting.AccountingService/ListBankProviders', ($0.Empty value) => value.writeToBuffer(), $0.ListBankProvidersResponse.fromBuffer);
  static final _$listInstitutions = $grpc.ClientMethod<$0.ListInstitutionsRequest, $0.ListInstitutionsResponse>(
      '/accounting.AccountingService/ListInstitutions', ($0.ListInstitutionsRequest value) => value.writeToBuffer(), $0.ListInstitutionsResponse.fromBuffer);
  static final _$createBankConnection = $grpc.ClientMethod<$0.CreateBankConnectionRequest, $0.CreateBankConnectionResponse>(
      '/accounting.AccountingService/CreateBankConnection',
      ($0.CreateBankConnectionRequest value) => value.writeToBuffer(),
      $0.CreateBankConnectionResponse.fromBuffer);
  static final _$completeBankConnection = $grpc.ClientMethod<$0.CompleteBankConnectionRequest, $0.BankConnection>(
      '/accounting.AccountingService/CompleteBankConnection', ($0.CompleteBankConnectionRequest value) => value.writeToBuffer(), $0.BankConnection.fromBuffer);
  static final _$updateBankConnection = $grpc.ClientMethod<$0.UpdateBankConnectionRequest, $0.BankConnection>(
      '/accounting.AccountingService/UpdateBankConnection', ($0.UpdateBankConnectionRequest value) => value.writeToBuffer(), $0.BankConnection.fromBuffer);
  static final _$reconnectBankConnection = $grpc.ClientMethod<$0.CompanyIdRequest, $0.CreateBankConnectionResponse>(
      '/accounting.AccountingService/ReconnectBankConnection',
      ($0.CompanyIdRequest value) => value.writeToBuffer(),
      $0.CreateBankConnectionResponse.fromBuffer);
  static final _$listBankConnections = $grpc.ClientMethod<$0.CompanyRequest, $0.ListBankConnectionsResponse>(
      '/accounting.AccountingService/ListBankConnections', ($0.CompanyRequest value) => value.writeToBuffer(), $0.ListBankConnectionsResponse.fromBuffer);
  static final _$deleteBankConnection = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Empty>(
      '/accounting.AccountingService/DeleteBankConnection', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$listBankAccounts = $grpc.ClientMethod<$0.CompanyRequest, $0.ListBankAccountsResponse>(
      '/accounting.AccountingService/ListBankAccounts', ($0.CompanyRequest value) => value.writeToBuffer(), $0.ListBankAccountsResponse.fromBuffer);
  static final _$setPrimaryAccount = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Empty>(
      '/accounting.AccountingService/SetPrimaryAccount', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$syncNow = $grpc.ClientMethod<$0.CompanyRequest, $0.SyncNowResponse>(
      '/accounting.AccountingService/SyncNow', ($0.CompanyRequest value) => value.writeToBuffer(), $0.SyncNowResponse.fromBuffer);
  static final _$getBalanceHistory = $grpc.ClientMethod<$0.BalanceHistoryRequest, $0.BalanceHistoryResponse>(
      '/accounting.AccountingService/GetBalanceHistory', ($0.BalanceHistoryRequest value) => value.writeToBuffer(), $0.BalanceHistoryResponse.fromBuffer);
  static final _$uploadStatement = $grpc.ClientMethod<$0.UploadStatementRequest, $0.UploadStatementResponse>(
      '/accounting.AccountingService/UploadStatement', ($0.UploadStatementRequest value) => value.writeToBuffer(), $0.UploadStatementResponse.fromBuffer);
  static final _$listTransactions = $grpc.ClientMethod<$0.ListTransactionsRequest, $0.ListTransactionsResponse>(
      '/accounting.AccountingService/ListTransactions', ($0.ListTransactionsRequest value) => value.writeToBuffer(), $0.ListTransactionsResponse.fromBuffer);
  static final _$explainTransaction = $grpc.ClientMethod<$0.ExplainTransactionRequest, $0.Transaction>(
      '/accounting.AccountingService/ExplainTransaction', ($0.ExplainTransactionRequest value) => value.writeToBuffer(), $0.Transaction.fromBuffer);
  static final _$approveTransactions = $grpc.ClientMethod<$0.ApproveTransactionsRequest, $0.Empty>(
      '/accounting.AccountingService/ApproveTransactions', ($0.ApproveTransactionsRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$linkTransactionToInvoice = $grpc.ClientMethod<$0.LinkTransactionRequest, $0.Transaction>(
      '/accounting.AccountingService/LinkTransactionToInvoice', ($0.LinkTransactionRequest value) => value.writeToBuffer(), $0.Transaction.fromBuffer);
  static final _$uploadAttachment = $grpc.ClientMethod<$0.UploadAttachmentRequest, $0.Attachment>(
      '/accounting.AccountingService/UploadAttachment', ($0.UploadAttachmentRequest value) => value.writeToBuffer(), $0.Attachment.fromBuffer);
  static final _$listAttachments = $grpc.ClientMethod<$0.ListAttachmentsRequest, $0.ListAttachmentsResponse>(
      '/accounting.AccountingService/ListAttachments', ($0.ListAttachmentsRequest value) => value.writeToBuffer(), $0.ListAttachmentsResponse.fromBuffer);
  static final _$getAttachment = $grpc.ClientMethod<$0.CompanyIdRequest, $0.FileResponse>(
      '/accounting.AccountingService/GetAttachment', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.FileResponse.fromBuffer);
  static final _$deleteAttachment = $grpc.ClientMethod<$0.CompanyIdRequest, $0.Empty>(
      '/accounting.AccountingService/DeleteAttachment', ($0.CompanyIdRequest value) => value.writeToBuffer(), $0.Empty.fromBuffer);
  static final _$getOverview = $grpc.ClientMethod<$0.OverviewRequest, $0.OverviewResponse>(
      '/accounting.AccountingService/GetOverview', ($0.OverviewRequest value) => value.writeToBuffer(), $0.OverviewResponse.fromBuffer);
}

@$pb.GrpcServiceName('accounting.AccountingService')
abstract class AccountingServiceBase extends $grpc.Service {
  $core.String get $name => 'accounting.AccountingService';

  AccountingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.AuthResponse>('Register', register_Pre, false, false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value), ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.AuthResponse>('Login', login_Pre, false, false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value), ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestRecoveryRequest, $0.Empty>('RequestRecovery', requestRecovery_Pre, false, false,
        ($core.List<$core.int> value) => $0.RequestRecoveryRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecoveryTokenRequest, $0.RecoveryTokenResponse>('ValidateRecoveryToken', validateRecoveryToken_Pre, false, false,
        ($core.List<$core.int> value) => $0.RecoveryTokenRequest.fromBuffer(value), ($0.RecoveryTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecoverAccountRequest, $0.AuthResponse>('RecoverAccount', recoverAccount_Pre, false, false,
        ($core.List<$core.int> value) => $0.RecoverAccountRequest.fromBuffer(value), ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BeginPasskeyLoginRequest, $0.PasskeyOptionsResponse>('BeginPasskeyLogin', beginPasskeyLogin_Pre, false, false,
        ($core.List<$core.int> value) => $0.BeginPasskeyLoginRequest.fromBuffer(value), ($0.PasskeyOptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FinishPasskeyRequest, $0.AuthResponse>('FinishPasskeyLogin', finishPasskeyLogin_Pre, false, false,
        ($core.List<$core.int> value) => $0.FinishPasskeyRequest.fromBuffer(value), ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.User>(
        'Me', me_Pre, false, false, ($core.List<$core.int> value) => $0.Empty.fromBuffer(value), ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChangePasswordRequest, $0.Empty>('ChangePassword', changePassword_Pre, false, false,
        ($core.List<$core.int> value) => $0.ChangePasswordRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.PasskeyOptionsResponse>('BeginPasskeyRegistration', beginPasskeyRegistration_Pre, false, false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value), ($0.PasskeyOptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FinishPasskeyRequest, $0.Passkey>('FinishPasskeyRegistration', finishPasskeyRegistration_Pre, false, false,
        ($core.List<$core.int> value) => $0.FinishPasskeyRequest.fromBuffer(value), ($0.Passkey value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ListPasskeysResponse>('ListPasskeys', listPasskeys_Pre, false, false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value), ($0.ListPasskeysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.IdRequest, $0.Empty>('DeletePasskey', deletePasskey_Pre, false, false,
        ($core.List<$core.int> value) => $0.IdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Company, $0.Company>('CreateCompany', createCompany_Pre, false, false,
        ($core.List<$core.int> value) => $0.Company.fromBuffer(value), ($0.Company value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Company, $0.Company>('UpdateCompany', updateCompany_Pre, false, false,
        ($core.List<$core.int> value) => $0.Company.fromBuffer(value), ($0.Company value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ListCompaniesResponse>('ListCompanies', listCompanies_Pre, false, false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value), ($0.ListCompaniesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyRequest, $0.Company>('GetCompany', getCompany_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyRequest.fromBuffer(value), ($0.Company value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Project, $0.Project>('CreateProject', createProject_Pre, false, false,
        ($core.List<$core.int> value) => $0.Project.fromBuffer(value), ($0.Project value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Project, $0.Project>('UpdateProject', updateProject_Pre, false, false,
        ($core.List<$core.int> value) => $0.Project.fromBuffer(value), ($0.Project value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Empty>('DeleteProject', deleteProject_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListProjectsRequest, $0.ListProjectsResponse>('ListProjects', listProjects_Pre, false, false,
        ($core.List<$core.int> value) => $0.ListProjectsRequest.fromBuffer(value), ($0.ListProjectsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Project>('GetProject', getProject_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Project value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyRequest, $0.ListCategoriesResponse>('ListCategories', listCategories_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyRequest.fromBuffer(value), ($0.ListCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Category, $0.Category>('CreateCategory', createCategory_Pre, false, false,
        ($core.List<$core.int> value) => $0.Category.fromBuffer(value), ($0.Category value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Category, $0.Category>('UpdateCategory', updateCategory_Pre, false, false,
        ($core.List<$core.int> value) => $0.Category.fromBuffer(value), ($0.Category value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Empty>('DeleteCategory', deleteCategory_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Invoice, $0.Invoice>('CreateInvoice', createInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.Invoice.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Invoice, $0.Invoice>('UpdateInvoice', updateInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.Invoice.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListInvoicesRequest, $0.ListInvoicesResponse>('ListInvoices', listInvoices_Pre, false, false,
        ($core.List<$core.int> value) => $0.ListInvoicesRequest.fromBuffer(value), ($0.ListInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Invoice>('GetInvoice', getInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Invoice>('IssueInvoice', issueInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Invoice>('SendInvoice', sendInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.FileResponse>('GetInvoicePdf', getInvoicePdf_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.FileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkInvoicePaidRequest, $0.Invoice>('MarkInvoicePaid', markInvoicePaid_Pre, false, false,
        ($core.List<$core.int> value) => $0.MarkInvoicePaidRequest.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Invoice>('UnlinkInvoicePayment', unlinkInvoicePayment_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Invoice>('CancelInvoice', cancelInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Empty>('DeleteInvoice', deleteInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ListBankProvidersResponse>('ListBankProviders', listBankProviders_Pre, false, false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value), ($0.ListBankProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListInstitutionsRequest, $0.ListInstitutionsResponse>('ListInstitutions', listInstitutions_Pre, false, false,
        ($core.List<$core.int> value) => $0.ListInstitutionsRequest.fromBuffer(value), ($0.ListInstitutionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateBankConnectionRequest, $0.CreateBankConnectionResponse>(
        'CreateBankConnection',
        createBankConnection_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateBankConnectionRequest.fromBuffer(value),
        ($0.CreateBankConnectionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteBankConnectionRequest, $0.BankConnection>('CompleteBankConnection', completeBankConnection_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompleteBankConnectionRequest.fromBuffer(value), ($0.BankConnection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBankConnectionRequest, $0.BankConnection>('UpdateBankConnection', updateBankConnection_Pre, false, false,
        ($core.List<$core.int> value) => $0.UpdateBankConnectionRequest.fromBuffer(value), ($0.BankConnection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.CreateBankConnectionResponse>('ReconnectBankConnection', reconnectBankConnection_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.CreateBankConnectionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyRequest, $0.ListBankConnectionsResponse>('ListBankConnections', listBankConnections_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyRequest.fromBuffer(value), ($0.ListBankConnectionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Empty>('DeleteBankConnection', deleteBankConnection_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyRequest, $0.ListBankAccountsResponse>('ListBankAccounts', listBankAccounts_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyRequest.fromBuffer(value), ($0.ListBankAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Empty>('SetPrimaryAccount', setPrimaryAccount_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyRequest, $0.SyncNowResponse>('SyncNow', syncNow_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyRequest.fromBuffer(value), ($0.SyncNowResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BalanceHistoryRequest, $0.BalanceHistoryResponse>('GetBalanceHistory', getBalanceHistory_Pre, false, false,
        ($core.List<$core.int> value) => $0.BalanceHistoryRequest.fromBuffer(value), ($0.BalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadStatementRequest, $0.UploadStatementResponse>('UploadStatement', uploadStatement_Pre, false, false,
        ($core.List<$core.int> value) => $0.UploadStatementRequest.fromBuffer(value), ($0.UploadStatementResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListTransactionsRequest, $0.ListTransactionsResponse>('ListTransactions', listTransactions_Pre, false, false,
        ($core.List<$core.int> value) => $0.ListTransactionsRequest.fromBuffer(value), ($0.ListTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExplainTransactionRequest, $0.Transaction>('ExplainTransaction', explainTransaction_Pre, false, false,
        ($core.List<$core.int> value) => $0.ExplainTransactionRequest.fromBuffer(value), ($0.Transaction value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ApproveTransactionsRequest, $0.Empty>('ApproveTransactions', approveTransactions_Pre, false, false,
        ($core.List<$core.int> value) => $0.ApproveTransactionsRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LinkTransactionRequest, $0.Transaction>('LinkTransactionToInvoice', linkTransactionToInvoice_Pre, false, false,
        ($core.List<$core.int> value) => $0.LinkTransactionRequest.fromBuffer(value), ($0.Transaction value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadAttachmentRequest, $0.Attachment>('UploadAttachment', uploadAttachment_Pre, false, false,
        ($core.List<$core.int> value) => $0.UploadAttachmentRequest.fromBuffer(value), ($0.Attachment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListAttachmentsRequest, $0.ListAttachmentsResponse>('ListAttachments', listAttachments_Pre, false, false,
        ($core.List<$core.int> value) => $0.ListAttachmentsRequest.fromBuffer(value), ($0.ListAttachmentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.FileResponse>('GetAttachment', getAttachment_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.FileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompanyIdRequest, $0.Empty>('DeleteAttachment', deleteAttachment_Pre, false, false,
        ($core.List<$core.int> value) => $0.CompanyIdRequest.fromBuffer(value), ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OverviewRequest, $0.OverviewResponse>('GetOverview', getOverview_Pre, false, false,
        ($core.List<$core.int> value) => $0.OverviewRequest.fromBuffer(value), ($0.OverviewResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthResponse> register_Pre($grpc.ServiceCall $call, $async.Future<$0.RegisterRequest> $request) async {
    return register($call, await $request);
  }

  $async.Future<$0.AuthResponse> register($grpc.ServiceCall call, $0.RegisterRequest request);

  $async.Future<$0.AuthResponse> login_Pre($grpc.ServiceCall $call, $async.Future<$0.LoginRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$0.AuthResponse> login($grpc.ServiceCall call, $0.LoginRequest request);

  $async.Future<$0.Empty> requestRecovery_Pre($grpc.ServiceCall $call, $async.Future<$0.RequestRecoveryRequest> $request) async {
    return requestRecovery($call, await $request);
  }

  $async.Future<$0.Empty> requestRecovery($grpc.ServiceCall call, $0.RequestRecoveryRequest request);

  $async.Future<$0.RecoveryTokenResponse> validateRecoveryToken_Pre($grpc.ServiceCall $call, $async.Future<$0.RecoveryTokenRequest> $request) async {
    return validateRecoveryToken($call, await $request);
  }

  $async.Future<$0.RecoveryTokenResponse> validateRecoveryToken($grpc.ServiceCall call, $0.RecoveryTokenRequest request);

  $async.Future<$0.AuthResponse> recoverAccount_Pre($grpc.ServiceCall $call, $async.Future<$0.RecoverAccountRequest> $request) async {
    return recoverAccount($call, await $request);
  }

  $async.Future<$0.AuthResponse> recoverAccount($grpc.ServiceCall call, $0.RecoverAccountRequest request);

  $async.Future<$0.PasskeyOptionsResponse> beginPasskeyLogin_Pre($grpc.ServiceCall $call, $async.Future<$0.BeginPasskeyLoginRequest> $request) async {
    return beginPasskeyLogin($call, await $request);
  }

  $async.Future<$0.PasskeyOptionsResponse> beginPasskeyLogin($grpc.ServiceCall call, $0.BeginPasskeyLoginRequest request);

  $async.Future<$0.AuthResponse> finishPasskeyLogin_Pre($grpc.ServiceCall $call, $async.Future<$0.FinishPasskeyRequest> $request) async {
    return finishPasskeyLogin($call, await $request);
  }

  $async.Future<$0.AuthResponse> finishPasskeyLogin($grpc.ServiceCall call, $0.FinishPasskeyRequest request);

  $async.Future<$0.User> me_Pre($grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return me($call, await $request);
  }

  $async.Future<$0.User> me($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.Empty> changePassword_Pre($grpc.ServiceCall $call, $async.Future<$0.ChangePasswordRequest> $request) async {
    return changePassword($call, await $request);
  }

  $async.Future<$0.Empty> changePassword($grpc.ServiceCall call, $0.ChangePasswordRequest request);

  $async.Future<$0.PasskeyOptionsResponse> beginPasskeyRegistration_Pre($grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return beginPasskeyRegistration($call, await $request);
  }

  $async.Future<$0.PasskeyOptionsResponse> beginPasskeyRegistration($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.Passkey> finishPasskeyRegistration_Pre($grpc.ServiceCall $call, $async.Future<$0.FinishPasskeyRequest> $request) async {
    return finishPasskeyRegistration($call, await $request);
  }

  $async.Future<$0.Passkey> finishPasskeyRegistration($grpc.ServiceCall call, $0.FinishPasskeyRequest request);

  $async.Future<$0.ListPasskeysResponse> listPasskeys_Pre($grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return listPasskeys($call, await $request);
  }

  $async.Future<$0.ListPasskeysResponse> listPasskeys($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.Empty> deletePasskey_Pre($grpc.ServiceCall $call, $async.Future<$0.IdRequest> $request) async {
    return deletePasskey($call, await $request);
  }

  $async.Future<$0.Empty> deletePasskey($grpc.ServiceCall call, $0.IdRequest request);

  $async.Future<$0.Company> createCompany_Pre($grpc.ServiceCall $call, $async.Future<$0.Company> $request) async {
    return createCompany($call, await $request);
  }

  $async.Future<$0.Company> createCompany($grpc.ServiceCall call, $0.Company request);

  $async.Future<$0.Company> updateCompany_Pre($grpc.ServiceCall $call, $async.Future<$0.Company> $request) async {
    return updateCompany($call, await $request);
  }

  $async.Future<$0.Company> updateCompany($grpc.ServiceCall call, $0.Company request);

  $async.Future<$0.ListCompaniesResponse> listCompanies_Pre($grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return listCompanies($call, await $request);
  }

  $async.Future<$0.ListCompaniesResponse> listCompanies($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.Company> getCompany_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyRequest> $request) async {
    return getCompany($call, await $request);
  }

  $async.Future<$0.Company> getCompany($grpc.ServiceCall call, $0.CompanyRequest request);

  $async.Future<$0.Project> createProject_Pre($grpc.ServiceCall $call, $async.Future<$0.Project> $request) async {
    return createProject($call, await $request);
  }

  $async.Future<$0.Project> createProject($grpc.ServiceCall call, $0.Project request);

  $async.Future<$0.Project> updateProject_Pre($grpc.ServiceCall $call, $async.Future<$0.Project> $request) async {
    return updateProject($call, await $request);
  }

  $async.Future<$0.Project> updateProject($grpc.ServiceCall call, $0.Project request);

  $async.Future<$0.Empty> deleteProject_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return deleteProject($call, await $request);
  }

  $async.Future<$0.Empty> deleteProject($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.ListProjectsResponse> listProjects_Pre($grpc.ServiceCall $call, $async.Future<$0.ListProjectsRequest> $request) async {
    return listProjects($call, await $request);
  }

  $async.Future<$0.ListProjectsResponse> listProjects($grpc.ServiceCall call, $0.ListProjectsRequest request);

  $async.Future<$0.Project> getProject_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return getProject($call, await $request);
  }

  $async.Future<$0.Project> getProject($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.ListCategoriesResponse> listCategories_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyRequest> $request) async {
    return listCategories($call, await $request);
  }

  $async.Future<$0.ListCategoriesResponse> listCategories($grpc.ServiceCall call, $0.CompanyRequest request);

  $async.Future<$0.Category> createCategory_Pre($grpc.ServiceCall $call, $async.Future<$0.Category> $request) async {
    return createCategory($call, await $request);
  }

  $async.Future<$0.Category> createCategory($grpc.ServiceCall call, $0.Category request);

  $async.Future<$0.Category> updateCategory_Pre($grpc.ServiceCall $call, $async.Future<$0.Category> $request) async {
    return updateCategory($call, await $request);
  }

  $async.Future<$0.Category> updateCategory($grpc.ServiceCall call, $0.Category request);

  $async.Future<$0.Empty> deleteCategory_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return deleteCategory($call, await $request);
  }

  $async.Future<$0.Empty> deleteCategory($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Invoice> createInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.Invoice> $request) async {
    return createInvoice($call, await $request);
  }

  $async.Future<$0.Invoice> createInvoice($grpc.ServiceCall call, $0.Invoice request);

  $async.Future<$0.Invoice> updateInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.Invoice> $request) async {
    return updateInvoice($call, await $request);
  }

  $async.Future<$0.Invoice> updateInvoice($grpc.ServiceCall call, $0.Invoice request);

  $async.Future<$0.ListInvoicesResponse> listInvoices_Pre($grpc.ServiceCall $call, $async.Future<$0.ListInvoicesRequest> $request) async {
    return listInvoices($call, await $request);
  }

  $async.Future<$0.ListInvoicesResponse> listInvoices($grpc.ServiceCall call, $0.ListInvoicesRequest request);

  $async.Future<$0.Invoice> getInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return getInvoice($call, await $request);
  }

  $async.Future<$0.Invoice> getInvoice($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Invoice> issueInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return issueInvoice($call, await $request);
  }

  $async.Future<$0.Invoice> issueInvoice($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Invoice> sendInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return sendInvoice($call, await $request);
  }

  $async.Future<$0.Invoice> sendInvoice($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.FileResponse> getInvoicePdf_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return getInvoicePdf($call, await $request);
  }

  $async.Future<$0.FileResponse> getInvoicePdf($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Invoice> markInvoicePaid_Pre($grpc.ServiceCall $call, $async.Future<$0.MarkInvoicePaidRequest> $request) async {
    return markInvoicePaid($call, await $request);
  }

  $async.Future<$0.Invoice> markInvoicePaid($grpc.ServiceCall call, $0.MarkInvoicePaidRequest request);

  $async.Future<$0.Invoice> unlinkInvoicePayment_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return unlinkInvoicePayment($call, await $request);
  }

  $async.Future<$0.Invoice> unlinkInvoicePayment($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Invoice> cancelInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return cancelInvoice($call, await $request);
  }

  $async.Future<$0.Invoice> cancelInvoice($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Empty> deleteInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return deleteInvoice($call, await $request);
  }

  $async.Future<$0.Empty> deleteInvoice($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.ListBankProvidersResponse> listBankProviders_Pre($grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return listBankProviders($call, await $request);
  }

  $async.Future<$0.ListBankProvidersResponse> listBankProviders($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.ListInstitutionsResponse> listInstitutions_Pre($grpc.ServiceCall $call, $async.Future<$0.ListInstitutionsRequest> $request) async {
    return listInstitutions($call, await $request);
  }

  $async.Future<$0.ListInstitutionsResponse> listInstitutions($grpc.ServiceCall call, $0.ListInstitutionsRequest request);

  $async.Future<$0.CreateBankConnectionResponse> createBankConnection_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.CreateBankConnectionRequest> $request) async {
    return createBankConnection($call, await $request);
  }

  $async.Future<$0.CreateBankConnectionResponse> createBankConnection($grpc.ServiceCall call, $0.CreateBankConnectionRequest request);

  $async.Future<$0.BankConnection> completeBankConnection_Pre($grpc.ServiceCall $call, $async.Future<$0.CompleteBankConnectionRequest> $request) async {
    return completeBankConnection($call, await $request);
  }

  $async.Future<$0.BankConnection> completeBankConnection($grpc.ServiceCall call, $0.CompleteBankConnectionRequest request);

  $async.Future<$0.BankConnection> updateBankConnection_Pre($grpc.ServiceCall $call, $async.Future<$0.UpdateBankConnectionRequest> $request) async {
    return updateBankConnection($call, await $request);
  }

  $async.Future<$0.BankConnection> updateBankConnection($grpc.ServiceCall call, $0.UpdateBankConnectionRequest request);

  $async.Future<$0.CreateBankConnectionResponse> reconnectBankConnection_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return reconnectBankConnection($call, await $request);
  }

  $async.Future<$0.CreateBankConnectionResponse> reconnectBankConnection($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.ListBankConnectionsResponse> listBankConnections_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyRequest> $request) async {
    return listBankConnections($call, await $request);
  }

  $async.Future<$0.ListBankConnectionsResponse> listBankConnections($grpc.ServiceCall call, $0.CompanyRequest request);

  $async.Future<$0.Empty> deleteBankConnection_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return deleteBankConnection($call, await $request);
  }

  $async.Future<$0.Empty> deleteBankConnection($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.ListBankAccountsResponse> listBankAccounts_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyRequest> $request) async {
    return listBankAccounts($call, await $request);
  }

  $async.Future<$0.ListBankAccountsResponse> listBankAccounts($grpc.ServiceCall call, $0.CompanyRequest request);

  $async.Future<$0.Empty> setPrimaryAccount_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return setPrimaryAccount($call, await $request);
  }

  $async.Future<$0.Empty> setPrimaryAccount($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.SyncNowResponse> syncNow_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyRequest> $request) async {
    return syncNow($call, await $request);
  }

  $async.Future<$0.SyncNowResponse> syncNow($grpc.ServiceCall call, $0.CompanyRequest request);

  $async.Future<$0.BalanceHistoryResponse> getBalanceHistory_Pre($grpc.ServiceCall $call, $async.Future<$0.BalanceHistoryRequest> $request) async {
    return getBalanceHistory($call, await $request);
  }

  $async.Future<$0.BalanceHistoryResponse> getBalanceHistory($grpc.ServiceCall call, $0.BalanceHistoryRequest request);

  $async.Future<$0.UploadStatementResponse> uploadStatement_Pre($grpc.ServiceCall $call, $async.Future<$0.UploadStatementRequest> $request) async {
    return uploadStatement($call, await $request);
  }

  $async.Future<$0.UploadStatementResponse> uploadStatement($grpc.ServiceCall call, $0.UploadStatementRequest request);

  $async.Future<$0.ListTransactionsResponse> listTransactions_Pre($grpc.ServiceCall $call, $async.Future<$0.ListTransactionsRequest> $request) async {
    return listTransactions($call, await $request);
  }

  $async.Future<$0.ListTransactionsResponse> listTransactions($grpc.ServiceCall call, $0.ListTransactionsRequest request);

  $async.Future<$0.Transaction> explainTransaction_Pre($grpc.ServiceCall $call, $async.Future<$0.ExplainTransactionRequest> $request) async {
    return explainTransaction($call, await $request);
  }

  $async.Future<$0.Transaction> explainTransaction($grpc.ServiceCall call, $0.ExplainTransactionRequest request);

  $async.Future<$0.Empty> approveTransactions_Pre($grpc.ServiceCall $call, $async.Future<$0.ApproveTransactionsRequest> $request) async {
    return approveTransactions($call, await $request);
  }

  $async.Future<$0.Empty> approveTransactions($grpc.ServiceCall call, $0.ApproveTransactionsRequest request);

  $async.Future<$0.Transaction> linkTransactionToInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.LinkTransactionRequest> $request) async {
    return linkTransactionToInvoice($call, await $request);
  }

  $async.Future<$0.Transaction> linkTransactionToInvoice($grpc.ServiceCall call, $0.LinkTransactionRequest request);

  $async.Future<$0.Attachment> uploadAttachment_Pre($grpc.ServiceCall $call, $async.Future<$0.UploadAttachmentRequest> $request) async {
    return uploadAttachment($call, await $request);
  }

  $async.Future<$0.Attachment> uploadAttachment($grpc.ServiceCall call, $0.UploadAttachmentRequest request);

  $async.Future<$0.ListAttachmentsResponse> listAttachments_Pre($grpc.ServiceCall $call, $async.Future<$0.ListAttachmentsRequest> $request) async {
    return listAttachments($call, await $request);
  }

  $async.Future<$0.ListAttachmentsResponse> listAttachments($grpc.ServiceCall call, $0.ListAttachmentsRequest request);

  $async.Future<$0.FileResponse> getAttachment_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return getAttachment($call, await $request);
  }

  $async.Future<$0.FileResponse> getAttachment($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.Empty> deleteAttachment_Pre($grpc.ServiceCall $call, $async.Future<$0.CompanyIdRequest> $request) async {
    return deleteAttachment($call, await $request);
  }

  $async.Future<$0.Empty> deleteAttachment($grpc.ServiceCall call, $0.CompanyIdRequest request);

  $async.Future<$0.OverviewResponse> getOverview_Pre($grpc.ServiceCall $call, $async.Future<$0.OverviewRequest> $request) async {
    return getOverview($call, await $request);
  }

  $async.Future<$0.OverviewResponse> getOverview($grpc.ServiceCall call, $0.OverviewRequest request);
}
