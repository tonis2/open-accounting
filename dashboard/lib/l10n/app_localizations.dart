import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Open Accounting'**
  String get appTitle;

  /// No description provided for @navOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get navOverview;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get navInvoices;

  /// No description provided for @navBanking.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get navBanking;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navCompanySettings.
  ///
  /// In en, this message translates to:
  /// **'Company settings'**
  String get navCompanySettings;

  /// No description provided for @navCompanies.
  ///
  /// In en, this message translates to:
  /// **'Companies'**
  String get navCompanies;

  /// No description provided for @navCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navCategories;

  /// No description provided for @navSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get navSecurity;

  /// No description provided for @navSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get navSignOut;

  /// No description provided for @switchCompany.
  ///
  /// In en, this message translates to:
  /// **'Switch company'**
  String get switchCompany;

  /// No description provided for @createCompany.
  ///
  /// In en, this message translates to:
  /// **'Create company'**
  String get createCompany;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search…'**
  String get searchHint;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show yet.'**
  String get noResults;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get optional;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get invalidNumber;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @perPage.
  ///
  /// In en, this message translates to:
  /// **'per page'**
  String get perPage;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {total}'**
  String pageOf(int page, int total);

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @last12Months.
  ///
  /// In en, this message translates to:
  /// **'Last 12 months'**
  String get last12Months;

  /// No description provided for @last6Months.
  ///
  /// In en, this message translates to:
  /// **'Last 6 months'**
  String get last6Months;

  /// No description provided for @last3Months.
  ///
  /// In en, this message translates to:
  /// **'Last 3 months'**
  String get last3Months;

  /// No description provided for @lastNMonths.
  ///
  /// In en, this message translates to:
  /// **'Last {n} months'**
  String lastNMonths(int n);

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Open Accounting'**
  String get signInTitle;

  /// No description provided for @signInWithPassword.
  ///
  /// In en, this message translates to:
  /// **'Sign in with password'**
  String get signInWithPassword;

  /// No description provided for @signInWithPasskey.
  ///
  /// In en, this message translates to:
  /// **'Sign in with a passkey'**
  String get signInWithPasskey;

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orDivider;

  /// No description provided for @noAccountYet.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountYet;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get registerTitle;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @recoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get recoveryTitle;

  /// No description provided for @recoverySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send you a link to set a new password.'**
  String get recoverySubtitle;

  /// No description provided for @sendRecoveryLink.
  ///
  /// In en, this message translates to:
  /// **'Send recovery link'**
  String get sendRecoveryLink;

  /// No description provided for @recoveryLinkSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for that email, a recovery link has been sent.'**
  String get recoveryLinkSent;

  /// No description provided for @recoveryInvalidLink.
  ///
  /// In en, this message translates to:
  /// **'This recovery link is invalid or has expired.'**
  String get recoveryInvalidLink;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @setNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set new password'**
  String get setNewPassword;

  /// No description provided for @signedInWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}'**
  String signedInWelcome(String name);

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get signInFailed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// No description provided for @passkeyNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Passkeys are not supported in this browser.'**
  String get passkeyNotSupported;

  /// No description provided for @passkeyFailed.
  ///
  /// In en, this message translates to:
  /// **'Passkey sign-in failed'**
  String get passkeyFailed;

  /// No description provided for @companyWizardTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your first company'**
  String get companyWizardTitle;

  /// No description provided for @companyWizardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices, bank accounts and transactions are kept separate for each company you add.'**
  String get companyWizardSubtitle;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get companyName;

  /// No description provided for @companyRegNumber.
  ///
  /// In en, this message translates to:
  /// **'Registration number'**
  String get companyRegNumber;

  /// No description provided for @companyVatNumber.
  ///
  /// In en, this message translates to:
  /// **'VAT number'**
  String get companyVatNumber;

  /// No description provided for @companyAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get companyAddress;

  /// No description provided for @companyEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get companyEmail;

  /// No description provided for @companyPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get companyPhone;

  /// No description provided for @companyIban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get companyIban;

  /// No description provided for @companyBankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get companyBankName;

  /// No description provided for @companyCurrency.
  ///
  /// In en, this message translates to:
  /// **'Base currency'**
  String get companyCurrency;

  /// No description provided for @companyInvoicePrefix.
  ///
  /// In en, this message translates to:
  /// **'Invoice number prefix'**
  String get companyInvoicePrefix;

  /// No description provided for @companyNextInvoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Next invoice number'**
  String get companyNextInvoiceNumber;

  /// No description provided for @companyDefaultVat.
  ///
  /// In en, this message translates to:
  /// **'Default VAT rate (%)'**
  String get companyDefaultVat;

  /// No description provided for @companyDefaultDueDays.
  ///
  /// In en, this message translates to:
  /// **'Default payment terms (days)'**
  String get companyDefaultDueDays;

  /// No description provided for @companySaved.
  ///
  /// In en, this message translates to:
  /// **'Company settings saved'**
  String get companySaved;

  /// No description provided for @companyCreated.
  ///
  /// In en, this message translates to:
  /// **'Company created'**
  String get companyCreated;

  /// No description provided for @companiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Companies'**
  String get companiesTitle;

  /// No description provided for @companiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You are a member of these companies. Pick one to work in.'**
  String get companiesSubtitle;

  /// No description provided for @companyActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get companyActive;

  /// No description provided for @companyRoleOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get companyRoleOwner;

  /// No description provided for @companyRoleMember.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get companyRoleMember;

  /// No description provided for @companySectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Company details'**
  String get companySectionDetails;

  /// No description provided for @companySectionInvoicing.
  ///
  /// In en, this message translates to:
  /// **'Invoicing'**
  String get companySectionInvoicing;

  /// No description provided for @companySectionPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment details shown on invoices'**
  String get companySectionPayment;

  /// No description provided for @overviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewTitle;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get addNew;

  /// No description provided for @cashflow.
  ///
  /// In en, this message translates to:
  /// **'Cashflow'**
  String get cashflow;

  /// No description provided for @incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get incoming;

  /// No description provided for @outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get outgoing;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @invoiceTimeline.
  ///
  /// In en, this message translates to:
  /// **'Invoice timeline'**
  String get invoiceTimeline;

  /// No description provided for @outstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get outstanding;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @newInvoice.
  ///
  /// In en, this message translates to:
  /// **'New invoice'**
  String get newInvoice;

  /// No description provided for @viewAllInvoices.
  ///
  /// In en, this message translates to:
  /// **'View all invoices'**
  String get viewAllInvoices;

  /// No description provided for @banking.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get banking;

  /// No description provided for @allAccounts.
  ///
  /// In en, this message translates to:
  /// **'All accounts'**
  String get allAccounts;

  /// No description provided for @viewAllBankAccounts.
  ///
  /// In en, this message translates to:
  /// **'View all bank accounts'**
  String get viewAllBankAccounts;

  /// No description provided for @connectBank.
  ///
  /// In en, this message translates to:
  /// **'Connect a bank'**
  String get connectBank;

  /// No description provided for @noBankAccountsYet.
  ///
  /// In en, this message translates to:
  /// **'No bank accounts connected yet.'**
  String get noBankAccountsYet;

  /// No description provided for @profitAndLoss.
  ///
  /// In en, this message translates to:
  /// **'Profit and loss'**
  String get profitAndLoss;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @operatingProfit.
  ///
  /// In en, this message translates to:
  /// **'Operating profit'**
  String get operatingProfit;

  /// No description provided for @forApproval.
  ///
  /// In en, this message translates to:
  /// **'For approval'**
  String get forApproval;

  /// No description provided for @unexplained.
  ///
  /// In en, this message translates to:
  /// **'Unexplained'**
  String get unexplained;

  /// No description provided for @noRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'No recent activity to show.'**
  String get noRecentActivity;

  /// No description provided for @bankConnectionNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Update your bank connection'**
  String get bankConnectionNeedsAttention;

  /// No description provided for @bankConnectionNeedsAttentionBody.
  ///
  /// In en, this message translates to:
  /// **'You have bank connections that need your attention.'**
  String get bankConnectionNeedsAttentionBody;

  /// No description provided for @manageBankConnections.
  ///
  /// In en, this message translates to:
  /// **'Manage bank connections'**
  String get manageBankConnections;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// No description provided for @addNewProject.
  ///
  /// In en, this message translates to:
  /// **'Add new project'**
  String get addNewProject;

  /// No description provided for @editProject.
  ///
  /// In en, this message translates to:
  /// **'Edit project'**
  String get editProject;

  /// No description provided for @activeProjects.
  ///
  /// In en, this message translates to:
  /// **'Active projects'**
  String get activeProjects;

  /// No description provided for @allProjects.
  ///
  /// In en, this message translates to:
  /// **'All projects'**
  String get allProjects;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// No description provided for @projectEmail.
  ///
  /// In en, this message translates to:
  /// **'Invoice email'**
  String get projectEmail;

  /// No description provided for @projectDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get projectDescription;

  /// No description provided for @projectContactName.
  ///
  /// In en, this message translates to:
  /// **'Contact name'**
  String get projectContactName;

  /// No description provided for @projectAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get projectAddress;

  /// No description provided for @projectRegNumber.
  ///
  /// In en, this message translates to:
  /// **'Registration number'**
  String get projectRegNumber;

  /// No description provided for @projectVatNumber.
  ///
  /// In en, this message translates to:
  /// **'VAT number'**
  String get projectVatNumber;

  /// No description provided for @projectIsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get projectIsActive;

  /// No description provided for @projectInvoiced.
  ///
  /// In en, this message translates to:
  /// **'Invoiced'**
  String get projectInvoiced;

  /// No description provided for @projectOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get projectOutstanding;

  /// No description provided for @projectInvoiceCount.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get projectInvoiceCount;

  /// No description provided for @projectContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get projectContact;

  /// No description provided for @projectSaved.
  ///
  /// In en, this message translates to:
  /// **'Project saved'**
  String get projectSaved;

  /// No description provided for @projectDeleted.
  ///
  /// In en, this message translates to:
  /// **'Project removed'**
  String get projectDeleted;

  /// No description provided for @deleteProjectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}? Projects with invoices are archived instead of deleted.'**
  String deleteProjectConfirm(String name);

  /// No description provided for @noProjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'No projects yet'**
  String get noProjectsTitle;

  /// No description provided for @noProjectsBody.
  ///
  /// In en, this message translates to:
  /// **'A project is a client you invoice. Add one to start creating invoices.'**
  String get noProjectsBody;

  /// No description provided for @projectInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices for this project'**
  String get projectInvoices;

  /// No description provided for @invoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesTitle;

  /// No description provided for @invoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice {number}'**
  String invoiceTitle(String number);

  /// No description provided for @draftInvoice.
  ///
  /// In en, this message translates to:
  /// **'Draft invoice'**
  String get draftInvoice;

  /// No description provided for @editInvoice.
  ///
  /// In en, this message translates to:
  /// **'Edit invoice'**
  String get editInvoice;

  /// No description provided for @invoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get invoiceDate;

  /// No description provided for @invoiceDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get invoiceDueDate;

  /// No description provided for @invoiceReference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get invoiceReference;

  /// No description provided for @invoiceContactAndProject.
  ///
  /// In en, this message translates to:
  /// **'Contact and project'**
  String get invoiceContactAndProject;

  /// No description provided for @invoiceTotalValue.
  ///
  /// In en, this message translates to:
  /// **'Total value'**
  String get invoiceTotalValue;

  /// No description provided for @invoiceStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get invoiceStatus;

  /// No description provided for @invoiceProject.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get invoiceProject;

  /// No description provided for @invoiceNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get invoiceNotes;

  /// No description provided for @invoiceNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Shown at the bottom of the invoice'**
  String get invoiceNotesHint;

  /// No description provided for @invoiceCustomerReference.
  ///
  /// In en, this message translates to:
  /// **'Customer reference'**
  String get invoiceCustomerReference;

  /// No description provided for @invoiceItems.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get invoiceItems;

  /// No description provided for @invoiceAddLine.
  ///
  /// In en, this message translates to:
  /// **'Add line'**
  String get invoiceAddLine;

  /// No description provided for @invoiceLineDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get invoiceLineDescription;

  /// No description provided for @invoiceLineQuantity.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get invoiceLineQuantity;

  /// No description provided for @invoiceLineUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get invoiceLineUnitPrice;

  /// No description provided for @invoiceLineVat.
  ///
  /// In en, this message translates to:
  /// **'VAT %'**
  String get invoiceLineVat;

  /// No description provided for @invoiceLineTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get invoiceLineTotal;

  /// No description provided for @invoiceSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get invoiceSubtotal;

  /// No description provided for @invoiceVat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get invoiceVat;

  /// No description provided for @invoiceTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get invoiceTotal;

  /// No description provided for @invoiceSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save draft'**
  String get invoiceSaveDraft;

  /// No description provided for @invoiceSaveAndIssue.
  ///
  /// In en, this message translates to:
  /// **'Save and issue'**
  String get invoiceSaveAndIssue;

  /// No description provided for @invoiceIssue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get invoiceIssue;

  /// No description provided for @invoiceIssueConfirm.
  ///
  /// In en, this message translates to:
  /// **'Issuing assigns the next invoice number and locks the invoice for editing.'**
  String get invoiceIssueConfirm;

  /// No description provided for @invoiceSend.
  ///
  /// In en, this message translates to:
  /// **'Send by email'**
  String get invoiceSend;

  /// No description provided for @invoiceSendConfirm.
  ///
  /// In en, this message translates to:
  /// **'Email the PDF to {email}?'**
  String invoiceSendConfirm(String email);

  /// No description provided for @invoiceSent.
  ///
  /// In en, this message translates to:
  /// **'Invoice sent'**
  String get invoiceSent;

  /// No description provided for @invoiceSentOn.
  ///
  /// In en, this message translates to:
  /// **'Sent {date}'**
  String invoiceSentOn(String date);

  /// No description provided for @invoiceDownloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get invoiceDownloadPdf;

  /// No description provided for @invoiceMarkPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as paid'**
  String get invoiceMarkPaid;

  /// No description provided for @invoiceMarkPaidTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark invoice as paid'**
  String get invoiceMarkPaidTitle;

  /// No description provided for @invoicePaidDate.
  ///
  /// In en, this message translates to:
  /// **'Paid on'**
  String get invoicePaidDate;

  /// No description provided for @invoiceUnlinkPayment.
  ///
  /// In en, this message translates to:
  /// **'Unmark as paid'**
  String get invoiceUnlinkPayment;

  /// No description provided for @invoiceCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel invoice'**
  String get invoiceCancel;

  /// No description provided for @invoiceCancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel invoice {number}? This cannot be undone.'**
  String invoiceCancelConfirm(String number);

  /// No description provided for @invoiceDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete draft'**
  String get invoiceDelete;

  /// No description provided for @invoiceDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this draft invoice?'**
  String get invoiceDeleteConfirm;

  /// No description provided for @invoiceSaved.
  ///
  /// In en, this message translates to:
  /// **'Invoice saved'**
  String get invoiceSaved;

  /// No description provided for @invoiceIssued.
  ///
  /// In en, this message translates to:
  /// **'Invoice {number} issued'**
  String invoiceIssued(String number);

  /// No description provided for @invoiceMarkedPaid.
  ///
  /// In en, this message translates to:
  /// **'Invoice marked as paid'**
  String get invoiceMarkedPaid;

  /// No description provided for @invoiceReopened.
  ///
  /// In en, this message translates to:
  /// **'Invoice reopened'**
  String get invoiceReopened;

  /// No description provided for @invoiceCancelled.
  ///
  /// In en, this message translates to:
  /// **'Invoice cancelled'**
  String get invoiceCancelled;

  /// No description provided for @invoiceDeleted.
  ///
  /// In en, this message translates to:
  /// **'Draft deleted'**
  String get invoiceDeleted;

  /// No description provided for @invoiceStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get invoiceStatusDraft;

  /// No description provided for @invoiceStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get invoiceStatusOpen;

  /// No description provided for @invoiceStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invoiceStatusPaid;

  /// No description provided for @invoiceStatusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invoiceStatusOverdue;

  /// No description provided for @invoiceStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get invoiceStatusCancelled;

  /// No description provided for @invoiceDueInDays.
  ///
  /// In en, this message translates to:
  /// **'due in {days} days'**
  String invoiceDueInDays(int days);

  /// No description provided for @invoiceDueToday.
  ///
  /// In en, this message translates to:
  /// **'due today'**
  String get invoiceDueToday;

  /// No description provided for @invoiceOverdueByDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days overdue'**
  String invoiceOverdueByDays(int days);

  /// No description provided for @invoicePaidOn.
  ///
  /// In en, this message translates to:
  /// **'Paid on {date}'**
  String invoicePaidOn(String date);

  /// No description provided for @invoiceFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All invoices'**
  String get invoiceFilterAll;

  /// No description provided for @invoiceFilterOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get invoiceFilterOpen;

  /// No description provided for @invoiceFilterOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invoiceFilterOverdue;

  /// No description provided for @invoiceFilterPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invoiceFilterPaid;

  /// No description provided for @invoiceFilterDraft.
  ///
  /// In en, this message translates to:
  /// **'Drafts'**
  String get invoiceFilterDraft;

  /// No description provided for @invoiceFilterCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get invoiceFilterCancelled;

  /// No description provided for @noInvoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'No invoices yet'**
  String get noInvoicesTitle;

  /// No description provided for @noInvoicesBody.
  ///
  /// In en, this message translates to:
  /// **'Create an invoice for one of your projects and track when it gets paid.'**
  String get noInvoicesBody;

  /// No description provided for @invoiceNeedsProject.
  ///
  /// In en, this message translates to:
  /// **'Add a project before creating an invoice.'**
  String get invoiceNeedsProject;

  /// No description provided for @invoicePaidBy.
  ///
  /// In en, this message translates to:
  /// **'Paid by bank transaction'**
  String get invoicePaidBy;

  /// No description provided for @invoiceLinkedTransaction.
  ///
  /// In en, this message translates to:
  /// **'Linked transaction'**
  String get invoiceLinkedTransaction;

  /// No description provided for @invoiceBillTo.
  ///
  /// In en, this message translates to:
  /// **'Bill to'**
  String get invoiceBillTo;

  /// No description provided for @invoiceFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get invoiceFrom;

  /// No description provided for @invoiceOverdueBanner.
  ///
  /// In en, this message translates to:
  /// **'This invoice is overdue.'**
  String get invoiceOverdueBanner;

  /// No description provided for @bankingTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank accounts summary'**
  String get bankingTitle;

  /// No description provided for @addNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Add new account'**
  String get addNewAccount;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get totalBalance;

  /// No description provided for @totalForApproval.
  ///
  /// In en, this message translates to:
  /// **'Total for approval'**
  String get totalForApproval;

  /// No description provided for @totalUnexplained.
  ///
  /// In en, this message translates to:
  /// **'Total unexplained'**
  String get totalUnexplained;

  /// No description provided for @bankAccounts.
  ///
  /// In en, this message translates to:
  /// **'Bank accounts'**
  String get bankAccounts;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account details'**
  String get accountDetails;

  /// No description provided for @bankFeed.
  ///
  /// In en, this message translates to:
  /// **'Bank feed'**
  String get bankFeed;

  /// No description provided for @accountBalance.
  ///
  /// In en, this message translates to:
  /// **'Account balance'**
  String get accountBalance;

  /// No description provided for @balanceOn.
  ///
  /// In en, this message translates to:
  /// **'Balance on {date}'**
  String balanceOn(String date);

  /// No description provided for @approveTransactions.
  ///
  /// In en, this message translates to:
  /// **'Approve transactions'**
  String get approveTransactions;

  /// No description provided for @primaryAccount.
  ///
  /// In en, this message translates to:
  /// **'Primary account'**
  String get primaryAccount;

  /// No description provided for @setAsPrimary.
  ///
  /// In en, this message translates to:
  /// **'Set as primary'**
  String get setAsPrimary;

  /// No description provided for @monthlyBalances.
  ///
  /// In en, this message translates to:
  /// **'Monthly balances'**
  String get monthlyBalances;

  /// No description provided for @feedActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get feedActive;

  /// No description provided for @feedPending.
  ///
  /// In en, this message translates to:
  /// **'Waiting for bank authorisation'**
  String get feedPending;

  /// No description provided for @feedExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get feedExpired;

  /// No description provided for @feedExpiresSoon.
  ///
  /// In en, this message translates to:
  /// **'Expires soon'**
  String get feedExpiresSoon;

  /// No description provided for @feedError.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get feedError;

  /// No description provided for @feedExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Expires {when}'**
  String feedExpiresIn(String when);

  /// No description provided for @feedLastImport.
  ///
  /// In en, this message translates to:
  /// **'Latest import'**
  String get feedLastImport;

  /// No description provided for @feedNeverSynced.
  ///
  /// In en, this message translates to:
  /// **'Not synced yet'**
  String get feedNeverSynced;

  /// No description provided for @updateConnection.
  ///
  /// In en, this message translates to:
  /// **'Update connection'**
  String get updateConnection;

  /// No description provided for @updateConnectionBody.
  ///
  /// In en, this message translates to:
  /// **'Update your bank connection to continue receiving transactions.'**
  String get updateConnectionBody;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get syncNow;

  /// No description provided for @syncDone.
  ///
  /// In en, this message translates to:
  /// **'Synced {connections} connections, {added} new transactions, {matched} invoices matched'**
  String syncDone(int connections, int added, int matched);

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get syncFailed;

  /// No description provided for @bankConnections.
  ///
  /// In en, this message translates to:
  /// **'Bank connections'**
  String get bankConnections;

  /// No description provided for @removeConnection.
  ///
  /// In en, this message translates to:
  /// **'Remove connection'**
  String get removeConnection;

  /// No description provided for @removeConnectionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}? Its accounts and imported transactions will be deleted.'**
  String removeConnectionConfirm(String name);

  /// No description provided for @connectionRemoved.
  ///
  /// In en, this message translates to:
  /// **'Connection removed'**
  String get connectionRemoved;

  /// No description provided for @noBankAccountsTitle.
  ///
  /// In en, this message translates to:
  /// **'No bank accounts yet'**
  String get noBankAccountsTitle;

  /// No description provided for @noBankAccountsBody.
  ///
  /// In en, this message translates to:
  /// **'Connect a bank to import transactions automatically and match them to your invoices.'**
  String get noBankAccountsBody;

  /// No description provided for @connectBankTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect a bank'**
  String get connectBankTitle;

  /// No description provided for @connectBankChooseProvider.
  ///
  /// In en, this message translates to:
  /// **'Choose how to connect'**
  String get connectBankChooseProvider;

  /// No description provided for @connectBankConnectionName.
  ///
  /// In en, this message translates to:
  /// **'Connection name'**
  String get connectBankConnectionName;

  /// No description provided for @connectBankConnectionNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Wise business'**
  String get connectBankConnectionNameHint;

  /// No description provided for @connectBankChooseInstitution.
  ///
  /// In en, this message translates to:
  /// **'Choose your bank'**
  String get connectBankChooseInstitution;

  /// No description provided for @connectBankSearchInstitution.
  ///
  /// In en, this message translates to:
  /// **'Search banks…'**
  String get connectBankSearchInstitution;

  /// No description provided for @connectBankLoadInstitutions.
  ///
  /// In en, this message translates to:
  /// **'Load banks'**
  String get connectBankLoadInstitutions;

  /// No description provided for @connectBankCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get connectBankCountry;

  /// No description provided for @connectBankContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get connectBankContinue;

  /// No description provided for @connectBankConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectBankConnect;

  /// No description provided for @connectBankRedirecting.
  ///
  /// In en, this message translates to:
  /// **'Redirecting you to your bank…'**
  String get connectBankRedirecting;

  /// No description provided for @connectBankRedirectHint.
  ///
  /// In en, this message translates to:
  /// **'You will be sent to your bank to give consent, then brought back here.'**
  String get connectBankRedirectHint;

  /// No description provided for @connectBankConnected.
  ///
  /// In en, this message translates to:
  /// **'Bank connected'**
  String get connectBankConnected;

  /// No description provided for @connectBankFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not connect'**
  String get connectBankFailed;

  /// No description provided for @connectBankCallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Finishing bank connection'**
  String get connectBankCallbackTitle;

  /// No description provided for @connectBankCallbackBody.
  ///
  /// In en, this message translates to:
  /// **'Confirming access with your bank…'**
  String get connectBankCallbackBody;

  /// No description provided for @connectBankCallbackDone.
  ///
  /// In en, this message translates to:
  /// **'Your bank is connected. Transactions are being imported.'**
  String get connectBankCallbackDone;

  /// No description provided for @connectBankCallbackFailed.
  ///
  /// In en, this message translates to:
  /// **'The bank connection could not be completed.'**
  String get connectBankCallbackFailed;

  /// No description provided for @connectBankNoProviders.
  ///
  /// In en, this message translates to:
  /// **'No bank providers are enabled on this server.'**
  String get connectBankNoProviders;

  /// No description provided for @backToBanking.
  ///
  /// In en, this message translates to:
  /// **'Back to banking'**
  String get backToBanking;

  /// No description provided for @transactionsAll.
  ///
  /// In en, this message translates to:
  /// **'All transactions'**
  String get transactionsAll;

  /// No description provided for @transactionsUnexplained.
  ///
  /// In en, this message translates to:
  /// **'Unexplained'**
  String get transactionsUnexplained;

  /// No description provided for @transactionsForApproval.
  ///
  /// In en, this message translates to:
  /// **'For approval'**
  String get transactionsForApproval;

  /// No description provided for @transactionsApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get transactionsApproved;

  /// No description provided for @transactionDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transactionDate;

  /// No description provided for @transactionDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get transactionDescription;

  /// No description provided for @transactionMoneyIn.
  ///
  /// In en, this message translates to:
  /// **'Money in'**
  String get transactionMoneyIn;

  /// No description provided for @transactionMoneyOut.
  ///
  /// In en, this message translates to:
  /// **'Money out'**
  String get transactionMoneyOut;

  /// No description provided for @transactionBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get transactionBalance;

  /// No description provided for @balanceBroughtForward.
  ///
  /// In en, this message translates to:
  /// **'Balance brought forward'**
  String get balanceBroughtForward;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get transactionType;

  /// No description provided for @transactionTypeIn.
  ///
  /// In en, this message translates to:
  /// **'Money in'**
  String get transactionTypeIn;

  /// No description provided for @transactionTypeOut.
  ///
  /// In en, this message translates to:
  /// **'Money out'**
  String get transactionTypeOut;

  /// No description provided for @transactionCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get transactionCategory;

  /// No description provided for @transactionCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get transactionCategoryHint;

  /// No description provided for @transactionNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get transactionNote;

  /// No description provided for @transactionNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Explanation, receipt number, who it was for…'**
  String get transactionNoteHint;

  /// No description provided for @transactionReference.
  ///
  /// In en, this message translates to:
  /// **'Bank reference'**
  String get transactionReference;

  /// No description provided for @transactionCounterparty.
  ///
  /// In en, this message translates to:
  /// **'Counterparty'**
  String get transactionCounterparty;

  /// No description provided for @transactionAttachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get transactionAttachments;

  /// No description provided for @transactionUploadFiles.
  ///
  /// In en, this message translates to:
  /// **'Upload files'**
  String get transactionUploadFiles;

  /// No description provided for @transactionUploadHint.
  ///
  /// In en, this message translates to:
  /// **'PDF, JPEG, PNG or WebP, max 10 MB each'**
  String get transactionUploadHint;

  /// No description provided for @transactionApproveAndSave.
  ///
  /// In en, this message translates to:
  /// **'Approve & save changes'**
  String get transactionApproveAndSave;

  /// No description provided for @transactionSaveExplanation.
  ///
  /// In en, this message translates to:
  /// **'Save explanation'**
  String get transactionSaveExplanation;

  /// No description provided for @transactionExplained.
  ///
  /// In en, this message translates to:
  /// **'Transaction saved'**
  String get transactionExplained;

  /// No description provided for @transactionApproved.
  ///
  /// In en, this message translates to:
  /// **'{count} transactions approved'**
  String transactionApproved(int count);

  /// No description provided for @transactionApproveSelected.
  ///
  /// In en, this message translates to:
  /// **'Approve selected'**
  String get transactionApproveSelected;

  /// No description provided for @transactionLinkInvoice.
  ///
  /// In en, this message translates to:
  /// **'Link to invoice'**
  String get transactionLinkInvoice;

  /// No description provided for @transactionLinkedInvoice.
  ///
  /// In en, this message translates to:
  /// **'Pays invoice {number}'**
  String transactionLinkedInvoice(String number);

  /// No description provided for @transactionUnlinkInvoice.
  ///
  /// In en, this message translates to:
  /// **'Unlink invoice'**
  String get transactionUnlinkInvoice;

  /// No description provided for @transactionChooseInvoice.
  ///
  /// In en, this message translates to:
  /// **'Choose an open invoice'**
  String get transactionChooseInvoice;

  /// No description provided for @transactionNoOpenInvoices.
  ///
  /// In en, this message translates to:
  /// **'There are no open invoices to link.'**
  String get transactionNoOpenInvoices;

  /// No description provided for @transactionLinked.
  ///
  /// In en, this message translates to:
  /// **'Transaction linked to invoice'**
  String get transactionLinked;

  /// No description provided for @transactionUnlinked.
  ///
  /// In en, this message translates to:
  /// **'Invoice unlinked'**
  String get transactionUnlinked;

  /// No description provided for @noTransactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions'**
  String get noTransactionsTitle;

  /// No description provided for @noTransactionsBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing has been imported for this period yet.'**
  String get noTransactionsBody;

  /// No description provided for @attachmentUploaded.
  ///
  /// In en, this message translates to:
  /// **'File attached'**
  String get attachmentUploaded;

  /// No description provided for @attachmentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Attachment removed'**
  String get attachmentDeleted;

  /// No description provided for @attachmentTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File is larger than 10 MB'**
  String get attachmentTooLarge;

  /// No description provided for @allMonths.
  ///
  /// In en, this message translates to:
  /// **'All months'**
  String get allMonths;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank details'**
  String get bankDetails;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @forApprovalByCategory.
  ///
  /// In en, this message translates to:
  /// **'For approval by category'**
  String get forApprovalByCategory;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @categoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Categories are used to explain bank transactions.'**
  String get categoriesSubtitle;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @categoryKind.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get categoryKind;

  /// No description provided for @categoryKindIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get categoryKindIncome;

  /// No description provided for @categoryKindExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get categoryKindExpense;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get editCategory;

  /// No description provided for @categorySaved.
  ///
  /// In en, this message translates to:
  /// **'Category saved'**
  String get categorySaved;

  /// No description provided for @categoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted'**
  String get categoryDeleted;

  /// No description provided for @deleteCategoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}? Transactions using it will become uncategorised.'**
  String deleteCategoryConfirm(String name);

  /// No description provided for @securityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securityTitle;

  /// No description provided for @securityPasswordSection.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get securityPasswordSection;

  /// No description provided for @securityPasswordBody.
  ///
  /// In en, this message translates to:
  /// **'Use a long, unique password. You can also sign in with a passkey instead.'**
  String get securityPasswordBody;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get passwordChanged;

  /// No description provided for @securityPasskeysSection.
  ///
  /// In en, this message translates to:
  /// **'Passkeys'**
  String get securityPasskeysSection;

  /// No description provided for @securityPasskeysBody.
  ///
  /// In en, this message translates to:
  /// **'Passkeys let you sign in with your fingerprint, face or device PIN instead of a password.'**
  String get securityPasskeysBody;

  /// No description provided for @addPasskey.
  ///
  /// In en, this message translates to:
  /// **'Add passkey'**
  String get addPasskey;

  /// No description provided for @passkeyName.
  ///
  /// In en, this message translates to:
  /// **'Passkey name'**
  String get passkeyName;

  /// No description provided for @passkeyNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Laptop, Phone'**
  String get passkeyNameHint;

  /// No description provided for @passkeyAdded.
  ///
  /// In en, this message translates to:
  /// **'Passkey added'**
  String get passkeyAdded;

  /// No description provided for @passkeyRemoved.
  ///
  /// In en, this message translates to:
  /// **'Passkey removed'**
  String get passkeyRemoved;

  /// No description provided for @passkeyCreated.
  ///
  /// In en, this message translates to:
  /// **'Added {date}'**
  String passkeyCreated(String date);

  /// No description provided for @passkeyLastUsed.
  ///
  /// In en, this message translates to:
  /// **'Last used {date}'**
  String passkeyLastUsed(String date);

  /// No description provided for @passkeyNeverUsed.
  ///
  /// In en, this message translates to:
  /// **'Never used'**
  String get passkeyNeverUsed;

  /// No description provided for @noPasskeys.
  ///
  /// In en, this message translates to:
  /// **'No passkeys yet.'**
  String get noPasskeys;

  /// No description provided for @removePasskeyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove passkey {name}?'**
  String removePasskeyConfirm(String name);

  /// No description provided for @signedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String signedInAs(String email);

  /// No description provided for @projectArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get projectArchived;

  /// No description provided for @inAboutHours.
  ///
  /// In en, this message translates to:
  /// **'in about {hours} hours'**
  String inAboutHours(int hours);

  /// No description provided for @inDays.
  ///
  /// In en, this message translates to:
  /// **'in {days} days'**
  String inDays(int days);

  /// No description provided for @editConnection.
  ///
  /// In en, this message translates to:
  /// **'Edit connection'**
  String get editConnection;

  /// No description provided for @connectionSettings.
  ///
  /// In en, this message translates to:
  /// **'Connection settings'**
  String get connectionSettings;

  /// No description provided for @connectionUpdated.
  ///
  /// In en, this message translates to:
  /// **'Connection updated'**
  String get connectionUpdated;

  /// No description provided for @keepCurrentValueHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty to keep the current value'**
  String get keepCurrentValueHint;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file…'**
  String get chooseFile;

  /// No description provided for @noFileChosen.
  ///
  /// In en, this message translates to:
  /// **'No file chosen'**
  String get noFileChosen;

  /// No description provided for @pasteInstead.
  ///
  /// In en, this message translates to:
  /// **'Paste instead'**
  String get pasteInstead;

  /// No description provided for @keepCurrentKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Leave as is to keep the current key'**
  String get keepCurrentKeyHint;

  /// No description provided for @wiseKeyHelp.
  ///
  /// In en, this message translates to:
  /// **'The RSA key only helps business accounts based in the US, Canada, Australia, New Zealand, Singapore or Malaysia — Wise rejects API statements everywhere else, so leave it empty and upload CSV statements. To use it: `openssl genrsa -out wise.pem 2048 && openssl rsa -in wise.pem -pubout -out wise.pub`, register wise.pub in Wise → Settings → API tokens → Manage public keys, then choose wise.pem here.'**
  String get wiseKeyHelp;

  /// No description provided for @uploadStatement.
  ///
  /// In en, this message translates to:
  /// **'Upload statement'**
  String get uploadStatement;

  /// No description provided for @uploadStatementHint.
  ///
  /// In en, this message translates to:
  /// **'CSV exported from your online bank (Wise: Balances → Statement → CSV). Rows already imported are skipped.'**
  String get uploadStatementHint;

  /// No description provided for @statementImported.
  ///
  /// In en, this message translates to:
  /// **'{imported} transactions imported, {duplicates} already present, {skipped} rows skipped'**
  String statementImported(int imported, int duplicates, int skipped);

  /// No description provided for @statementMatched.
  ///
  /// In en, this message translates to:
  /// **'{count} invoices matched'**
  String statementMatched(int count);

  /// No description provided for @statementsOnlyInfo.
  ///
  /// In en, this message translates to:
  /// **'Transactions for this account are imported from uploaded statements.'**
  String get statementsOnlyInfo;

  /// No description provided for @statementsOnlyWise.
  ///
  /// In en, this message translates to:
  /// **'Wise serves API statements only to accounts based in the US, Canada, Australia, New Zealand, Singapore or Malaysia — balances sync automatically, transactions come from uploaded CSV statements (Wise → Balances → Statement → CSV).'**
  String get statementsOnlyWise;

  /// No description provided for @feedStatementsOnly.
  ///
  /// In en, this message translates to:
  /// **'Statement uploads'**
  String get feedStatementsOnly;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
