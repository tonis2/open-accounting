// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Open Accounting';

  @override
  String get navOverview => 'Overview';

  @override
  String get navProjects => 'Projects';

  @override
  String get navInvoices => 'Invoices';

  @override
  String get navBanking => 'Banking';

  @override
  String get navSettings => 'Settings';

  @override
  String get navCompanySettings => 'Company settings';

  @override
  String get navCompanies => 'Companies';

  @override
  String get navCategories => 'Categories';

  @override
  String get navSecurity => 'Security';

  @override
  String get navSignOut => 'Sign out';

  @override
  String get switchCompany => 'Switch company';

  @override
  String get createCompany => 'Create company';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get create => 'Create';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search…';

  @override
  String get actions => 'Actions';

  @override
  String get view => 'View';

  @override
  String get download => 'Download';

  @override
  String get refresh => 'Refresh';

  @override
  String get loading => 'Loading…';

  @override
  String get noResults => 'Nothing to show yet.';

  @override
  String get all => 'All';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get optional => 'optional';

  @override
  String get confirm => 'Confirm';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get perPage => 'per page';

  @override
  String pageOf(int page, int total) {
    return 'Page $page of $total';
  }

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get last12Months => 'Last 12 months';

  @override
  String get last6Months => 'Last 6 months';

  @override
  String get last3Months => 'Last 3 months';

  @override
  String lastNMonths(int n) {
    return 'Last $n months';
  }

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get yourName => 'Your name';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInTitle => 'Sign in to Open Accounting';

  @override
  String get signInWithPassword => 'Sign in with password';

  @override
  String get signInWithPasskey => 'Sign in with a passkey';

  @override
  String get orDivider => 'or';

  @override
  String get noAccountYet => 'Don\'t have an account?';

  @override
  String get createAccount => 'Create account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get registerTitle => 'Create your account';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get recoveryTitle => 'Reset your password';

  @override
  String get recoverySubtitle => 'Enter your email and we will send you a link to set a new password.';

  @override
  String get sendRecoveryLink => 'Send recovery link';

  @override
  String get recoveryLinkSent => 'If an account exists for that email, a recovery link has been sent.';

  @override
  String get recoveryInvalidLink => 'This recovery link is invalid or has expired.';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get setNewPassword => 'Set new password';

  @override
  String signedInWelcome(String name) {
    return 'Welcome back, $name';
  }

  @override
  String get signInFailed => 'Sign in failed';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get passkeyNotSupported => 'Passkeys are not supported in this browser.';

  @override
  String get passkeyFailed => 'Passkey sign-in failed';

  @override
  String get companyWizardTitle => 'Set up your first company';

  @override
  String get companyWizardSubtitle => 'Invoices, bank accounts and transactions are kept separate for each company you add.';

  @override
  String get companyName => 'Company name';

  @override
  String get companyRegNumber => 'Registration number';

  @override
  String get companyVatNumber => 'VAT number';

  @override
  String get companyAddress => 'Address';

  @override
  String get companyEmail => 'Email';

  @override
  String get companyPhone => 'Phone';

  @override
  String get companyIban => 'IBAN';

  @override
  String get companyBankName => 'Bank name';

  @override
  String get companyCurrency => 'Base currency';

  @override
  String get companyInvoicePrefix => 'Invoice number prefix';

  @override
  String get companyNextInvoiceNumber => 'Next invoice number';

  @override
  String get companyDefaultVat => 'Default VAT rate (%)';

  @override
  String get companyDefaultDueDays => 'Default payment terms (days)';

  @override
  String get companySaved => 'Company settings saved';

  @override
  String get companyCreated => 'Company created';

  @override
  String get companiesTitle => 'Companies';

  @override
  String get companiesSubtitle => 'You are a member of these companies. Pick one to work in.';

  @override
  String get companyActive => 'Active';

  @override
  String get companyRoleOwner => 'Owner';

  @override
  String get companyRoleMember => 'Member';

  @override
  String get companySectionDetails => 'Company details';

  @override
  String get companySectionInvoicing => 'Invoicing';

  @override
  String get companySectionPayment => 'Payment details shown on invoices';

  @override
  String get overviewTitle => 'Overview';

  @override
  String get addNew => 'Add new';

  @override
  String get cashflow => 'Cashflow';

  @override
  String get incoming => 'Incoming';

  @override
  String get outgoing => 'Outgoing';

  @override
  String get balance => 'Balance';

  @override
  String get invoiceTimeline => 'Invoice timeline';

  @override
  String get outstanding => 'Outstanding';

  @override
  String get overdue => 'Overdue';

  @override
  String get due => 'Due';

  @override
  String get paid => 'Paid';

  @override
  String get newInvoice => 'New invoice';

  @override
  String get viewAllInvoices => 'View all invoices';

  @override
  String get banking => 'Banking';

  @override
  String get allAccounts => 'All accounts';

  @override
  String get viewAllBankAccounts => 'View all bank accounts';

  @override
  String get connectBank => 'Connect a bank';

  @override
  String get noBankAccountsYet => 'No bank accounts connected yet.';

  @override
  String get profitAndLoss => 'Profit and loss';

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get operatingProfit => 'Operating profit';

  @override
  String get forApproval => 'For approval';

  @override
  String get unexplained => 'Unexplained';

  @override
  String get noRecentActivity => 'No recent activity to show.';

  @override
  String get bankConnectionNeedsAttention => 'Update your bank connection';

  @override
  String get bankConnectionNeedsAttentionBody => 'You have bank connections that need your attention.';

  @override
  String get manageBankConnections => 'Manage bank connections';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get addNewProject => 'Add new project';

  @override
  String get editProject => 'Edit project';

  @override
  String get activeProjects => 'Active projects';

  @override
  String get allProjects => 'All projects';

  @override
  String get projectName => 'Project name';

  @override
  String get projectEmail => 'Invoice email';

  @override
  String get projectDescription => 'Description';

  @override
  String get projectContactName => 'Contact name';

  @override
  String get projectAddress => 'Address';

  @override
  String get projectRegNumber => 'Registration number';

  @override
  String get projectVatNumber => 'VAT number';

  @override
  String get projectIsActive => 'Active';

  @override
  String get projectInvoiced => 'Invoiced';

  @override
  String get projectOutstanding => 'Outstanding';

  @override
  String get projectInvoiceCount => 'Invoices';

  @override
  String get projectContact => 'Contact';

  @override
  String get projectSaved => 'Project saved';

  @override
  String get projectDeleted => 'Project removed';

  @override
  String deleteProjectConfirm(String name) {
    return 'Remove $name? Projects with invoices are archived instead of deleted.';
  }

  @override
  String get noProjectsTitle => 'No projects yet';

  @override
  String get noProjectsBody => 'A project is a client you invoice. Add one to start creating invoices.';

  @override
  String get projectInvoices => 'Invoices for this project';

  @override
  String get invoicesTitle => 'Invoices';

  @override
  String invoiceTitle(String number) {
    return 'Invoice $number';
  }

  @override
  String get draftInvoice => 'Draft invoice';

  @override
  String get editInvoice => 'Edit invoice';

  @override
  String get invoiceDate => 'Date';

  @override
  String get invoiceDueDate => 'Due date';

  @override
  String get invoiceReference => 'Reference';

  @override
  String get invoiceContactAndProject => 'Contact and project';

  @override
  String get invoiceTotalValue => 'Total value';

  @override
  String get invoiceStatus => 'Status';

  @override
  String get invoiceProject => 'Project';

  @override
  String get invoiceNotes => 'Notes';

  @override
  String get invoiceNotesHint => 'Shown at the bottom of the invoice';

  @override
  String get invoiceCustomerReference => 'Customer reference';

  @override
  String get invoiceItems => 'Items';

  @override
  String get invoiceAddLine => 'Add line';

  @override
  String get invoiceLineDescription => 'Description';

  @override
  String get invoiceLineQuantity => 'Qty';

  @override
  String get invoiceLineUnitPrice => 'Unit price';

  @override
  String get invoiceLineVat => 'VAT %';

  @override
  String get invoiceLineTotal => 'Total';

  @override
  String get invoiceSubtotal => 'Subtotal';

  @override
  String get invoiceVat => 'VAT';

  @override
  String get invoiceTotal => 'Total';

  @override
  String get invoiceSaveDraft => 'Save draft';

  @override
  String get invoiceSaveAndIssue => 'Save and issue';

  @override
  String get invoiceIssue => 'Issue';

  @override
  String get invoiceIssueConfirm => 'Issuing assigns the next invoice number and locks the invoice for editing.';

  @override
  String get invoiceSend => 'Send by email';

  @override
  String invoiceSendConfirm(String email) {
    return 'Email the PDF to $email?';
  }

  @override
  String get invoiceSent => 'Invoice sent';

  @override
  String invoiceSentOn(String date) {
    return 'Sent $date';
  }

  @override
  String get invoiceDownloadPdf => 'Download PDF';

  @override
  String get invoiceMarkPaid => 'Mark as paid';

  @override
  String get invoiceMarkPaidTitle => 'Mark invoice as paid';

  @override
  String get invoicePaidDate => 'Paid on';

  @override
  String get invoiceUnlinkPayment => 'Unmark as paid';

  @override
  String get invoiceCancel => 'Cancel invoice';

  @override
  String invoiceCancelConfirm(String number) {
    return 'Cancel invoice $number? This cannot be undone.';
  }

  @override
  String get invoiceDelete => 'Delete draft';

  @override
  String get invoiceDeleteConfirm => 'Delete this draft invoice?';

  @override
  String get invoiceSaved => 'Invoice saved';

  @override
  String invoiceIssued(String number) {
    return 'Invoice $number issued';
  }

  @override
  String get invoiceMarkedPaid => 'Invoice marked as paid';

  @override
  String get invoiceReopened => 'Invoice reopened';

  @override
  String get invoiceCancelled => 'Invoice cancelled';

  @override
  String get invoiceDeleted => 'Draft deleted';

  @override
  String get invoiceStatusDraft => 'Draft';

  @override
  String get invoiceStatusOpen => 'Open';

  @override
  String get invoiceStatusPaid => 'Paid';

  @override
  String get invoiceStatusOverdue => 'Overdue';

  @override
  String get invoiceStatusCancelled => 'Cancelled';

  @override
  String invoiceDueInDays(int days) {
    return 'due in $days days';
  }

  @override
  String get invoiceDueToday => 'due today';

  @override
  String invoiceOverdueByDays(int days) {
    return '$days days overdue';
  }

  @override
  String invoicePaidOn(String date) {
    return 'Paid on $date';
  }

  @override
  String get invoiceFilterAll => 'All invoices';

  @override
  String get invoiceFilterOpen => 'Open';

  @override
  String get invoiceFilterOverdue => 'Overdue';

  @override
  String get invoiceFilterPaid => 'Paid';

  @override
  String get invoiceFilterDraft => 'Drafts';

  @override
  String get invoiceFilterCancelled => 'Cancelled';

  @override
  String get noInvoicesTitle => 'No invoices yet';

  @override
  String get noInvoicesBody => 'Create an invoice for one of your projects and track when it gets paid.';

  @override
  String get invoiceNeedsProject => 'Add a project before creating an invoice.';

  @override
  String get invoicePaidBy => 'Paid by bank transaction';

  @override
  String get invoiceLinkedTransaction => 'Linked transaction';

  @override
  String get invoiceBillTo => 'Bill to';

  @override
  String get invoiceFrom => 'From';

  @override
  String get invoiceOverdueBanner => 'This invoice is overdue.';

  @override
  String get bankingTitle => 'Bank accounts summary';

  @override
  String get addNewAccount => 'Add new account';

  @override
  String get totalBalance => 'Total balance';

  @override
  String get totalForApproval => 'Total for approval';

  @override
  String get totalUnexplained => 'Total unexplained';

  @override
  String get bankAccounts => 'Bank accounts';

  @override
  String get accountDetails => 'Account details';

  @override
  String get bankFeed => 'Bank feed';

  @override
  String get accountBalance => 'Account balance';

  @override
  String balanceOn(String date) {
    return 'Balance on $date';
  }

  @override
  String get approveTransactions => 'Approve transactions';

  @override
  String get primaryAccount => 'Primary account';

  @override
  String get setAsPrimary => 'Set as primary';

  @override
  String get monthlyBalances => 'Monthly balances';

  @override
  String get feedActive => 'Active';

  @override
  String get feedPending => 'Waiting for bank authorisation';

  @override
  String get feedExpired => 'Expired';

  @override
  String get feedExpiresSoon => 'Expires soon';

  @override
  String get feedError => 'Needs attention';

  @override
  String feedExpiresIn(String when) {
    return 'Expires $when';
  }

  @override
  String get feedLastImport => 'Latest import';

  @override
  String get feedNeverSynced => 'Not synced yet';

  @override
  String get updateConnection => 'Update connection';

  @override
  String get updateConnectionBody => 'Update your bank connection to continue receiving transactions.';

  @override
  String get syncNow => 'Sync now';

  @override
  String syncDone(int connections, int added, int matched) {
    return 'Synced $connections connections, $added new transactions, $matched invoices matched';
  }

  @override
  String get syncFailed => 'Sync failed';

  @override
  String get bankConnections => 'Bank connections';

  @override
  String get removeConnection => 'Remove connection';

  @override
  String removeConnectionConfirm(String name) {
    return 'Remove $name? Its accounts and imported transactions will be deleted.';
  }

  @override
  String get connectionRemoved => 'Connection removed';

  @override
  String get noBankAccountsTitle => 'No bank accounts yet';

  @override
  String get noBankAccountsBody => 'Connect a bank to import transactions automatically and match them to your invoices.';

  @override
  String get connectBankTitle => 'Connect a bank';

  @override
  String get connectBankChooseProvider => 'Choose how to connect';

  @override
  String get connectBankConnectionName => 'Connection name';

  @override
  String get connectBankConnectionNameHint => 'e.g. Wise business';

  @override
  String get connectBankChooseInstitution => 'Choose your bank';

  @override
  String get connectBankSearchInstitution => 'Search banks…';

  @override
  String get connectBankLoadInstitutions => 'Load banks';

  @override
  String get connectBankCountry => 'Country';

  @override
  String get connectBankContinue => 'Continue';

  @override
  String get connectBankConnect => 'Connect';

  @override
  String get connectBankRedirecting => 'Redirecting you to your bank…';

  @override
  String get connectBankRedirectHint => 'You will be sent to your bank to give consent, then brought back here.';

  @override
  String get connectBankConnected => 'Bank connected';

  @override
  String get connectBankFailed => 'Could not connect';

  @override
  String get connectBankCallbackTitle => 'Finishing bank connection';

  @override
  String get connectBankCallbackBody => 'Confirming access with your bank…';

  @override
  String get connectBankCallbackDone => 'Your bank is connected. Transactions are being imported.';

  @override
  String get connectBankCallbackFailed => 'The bank connection could not be completed.';

  @override
  String get connectBankNoProviders => 'No bank providers are enabled on this server.';

  @override
  String get backToBanking => 'Back to banking';

  @override
  String get transactionsAll => 'All transactions';

  @override
  String get transactionsUnexplained => 'Unexplained';

  @override
  String get transactionsForApproval => 'For approval';

  @override
  String get transactionsApproved => 'Approved';

  @override
  String get transactionDate => 'Date';

  @override
  String get transactionDescription => 'Description';

  @override
  String get transactionMoneyIn => 'Money in';

  @override
  String get transactionMoneyOut => 'Money out';

  @override
  String get transactionBalance => 'Balance';

  @override
  String get balanceBroughtForward => 'Balance brought forward';

  @override
  String get transactionType => 'Type';

  @override
  String get transactionTypeIn => 'Money in';

  @override
  String get transactionTypeOut => 'Money out';

  @override
  String get transactionCategory => 'Category';

  @override
  String get transactionCategoryHint => 'Choose a category';

  @override
  String get transactionNote => 'Note';

  @override
  String get transactionNoteHint => 'Explanation, receipt number, who it was for…';

  @override
  String get transactionReference => 'Bank reference';

  @override
  String get transactionCounterparty => 'Counterparty';

  @override
  String get transactionAttachments => 'Attachments';

  @override
  String get transactionUploadFiles => 'Upload files';

  @override
  String get transactionUploadHint => 'PDF, JPEG, PNG or WebP, max 10 MB each';

  @override
  String get transactionApproveAndSave => 'Approve & save changes';

  @override
  String get transactionSaveExplanation => 'Save explanation';

  @override
  String get transactionExplained => 'Transaction saved';

  @override
  String transactionApproved(int count) {
    return '$count transactions approved';
  }

  @override
  String get transactionApproveSelected => 'Approve selected';

  @override
  String get transactionLinkInvoice => 'Link to invoice';

  @override
  String transactionLinkedInvoice(String number) {
    return 'Pays invoice $number';
  }

  @override
  String get transactionUnlinkInvoice => 'Unlink invoice';

  @override
  String get transactionChooseInvoice => 'Choose an open invoice';

  @override
  String get transactionNoOpenInvoices => 'There are no open invoices to link.';

  @override
  String get transactionLinked => 'Transaction linked to invoice';

  @override
  String get transactionUnlinked => 'Invoice unlinked';

  @override
  String get noTransactionsTitle => 'No transactions';

  @override
  String get noTransactionsBody => 'Nothing has been imported for this period yet.';

  @override
  String get attachmentUploaded => 'File attached';

  @override
  String get attachmentDeleted => 'Attachment removed';

  @override
  String get attachmentTooLarge => 'File is larger than 10 MB';

  @override
  String get allMonths => 'All months';

  @override
  String get bankDetails => 'Bank details';

  @override
  String get bank => 'Bank';

  @override
  String get iban => 'IBAN';

  @override
  String get currency => 'Currency';

  @override
  String get forApprovalByCategory => 'For approval by category';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get categoriesSubtitle => 'Categories are used to explain bank transactions.';

  @override
  String get categoryName => 'Category name';

  @override
  String get categoryKind => 'Type';

  @override
  String get categoryKindIncome => 'Income';

  @override
  String get categoryKindExpense => 'Expense';

  @override
  String get addCategory => 'Add category';

  @override
  String get editCategory => 'Edit category';

  @override
  String get categorySaved => 'Category saved';

  @override
  String get categoryDeleted => 'Category deleted';

  @override
  String deleteCategoryConfirm(String name) {
    return 'Delete $name? Transactions using it will become uncategorised.';
  }

  @override
  String get securityTitle => 'Security';

  @override
  String get securityPasswordSection => 'Password';

  @override
  String get securityPasswordBody => 'Use a long, unique password. You can also sign in with a passkey instead.';

  @override
  String get currentPassword => 'Current password';

  @override
  String get changePassword => 'Change password';

  @override
  String get passwordChanged => 'Password changed';

  @override
  String get securityPasskeysSection => 'Passkeys';

  @override
  String get securityPasskeysBody => 'Passkeys let you sign in with your fingerprint, face or device PIN instead of a password.';

  @override
  String get addPasskey => 'Add passkey';

  @override
  String get passkeyName => 'Passkey name';

  @override
  String get passkeyNameHint => 'e.g. Laptop, Phone';

  @override
  String get passkeyAdded => 'Passkey added';

  @override
  String get passkeyRemoved => 'Passkey removed';

  @override
  String passkeyCreated(String date) {
    return 'Added $date';
  }

  @override
  String passkeyLastUsed(String date) {
    return 'Last used $date';
  }

  @override
  String get passkeyNeverUsed => 'Never used';

  @override
  String get noPasskeys => 'No passkeys yet.';

  @override
  String removePasskeyConfirm(String name) {
    return 'Remove passkey $name?';
  }

  @override
  String signedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get projectArchived => 'Archived';

  @override
  String inAboutHours(int hours) {
    return 'in about $hours hours';
  }

  @override
  String inDays(int days) {
    return 'in $days days';
  }

  @override
  String get editConnection => 'Edit connection';

  @override
  String get connectionSettings => 'Connection settings';

  @override
  String get connectionUpdated => 'Connection updated';

  @override
  String get keepCurrentValueHint => 'Leave empty to keep the current value';

  @override
  String get chooseFile => 'Choose file…';

  @override
  String get noFileChosen => 'No file chosen';

  @override
  String get pasteInstead => 'Paste instead';

  @override
  String get keepCurrentKeyHint => 'Leave as is to keep the current key';

  @override
  String get wiseKeyHelp =>
      'The RSA key only helps business accounts based in the US, Canada, Australia, New Zealand, Singapore or Malaysia — Wise rejects API statements everywhere else, so leave it empty and upload CSV statements. To use it: `openssl genrsa -out wise.pem 2048 && openssl rsa -in wise.pem -pubout -out wise.pub`, register wise.pub in Wise → Settings → API tokens → Manage public keys, then choose wise.pem here.';

  @override
  String get uploadStatement => 'Upload statement';

  @override
  String get uploadStatementHint => 'CSV exported from your online bank (Wise: Balances → Statement → CSV). Rows already imported are skipped.';

  @override
  String statementImported(int imported, int duplicates, int skipped) {
    return '$imported transactions imported, $duplicates already present, $skipped rows skipped';
  }

  @override
  String statementMatched(int count) {
    return '$count invoices matched';
  }

  @override
  String get statementsOnlyInfo => 'Transactions for this account are imported from uploaded statements.';

  @override
  String get statementsOnlyWise =>
      'Wise serves API statements only to accounts based in the US, Canada, Australia, New Zealand, Singapore or Malaysia — balances sync automatically, transactions come from uploaded CSV statements (Wise → Balances → Statement → CSV).';

  @override
  String get feedStatementsOnly => 'Statement uploads';
}
