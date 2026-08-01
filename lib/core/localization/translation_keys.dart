class TranslationKeys {
  TranslationKeys._();
  static const SignUp signUp = SignUp();
  static const Login login = Login();
  static const ForgotPassword forgotPassword = ForgotPassword();
  static const ResetPassword resetPassword = ResetPassword();
  static const VerifyCode verifyCode = VerifyCode();
  static const Settings settings = Settings();
  static const Address address = Address();
}

class SignUp {
  const SignUp();
  final String fullName = "sign_up.full_name";
  final String mobileNumber = "sign_up.mobile_number";
  final String emailAddress = "sign_up.email_address";
  final String password = "sign_up.password";
  final String confirmPassword = "sign_up.confirm_password";
  final String fullNameHint = "sign_up.full_name_hint";
  final String mobileNumberHint = "sign_up.mobile_number_hint";
  final String emailHint = "sign_up.email_hint";
  final String passwordHint = "sign_up.password_hint";
  final String confirmPasswordHint = "sign_up.confirm_password_hint";
  final String signUpButton = "sign_up.sign_up_button";
  final String alreadyHaveAccount = "sign_up.already_have_account";
  final String login = "sign_up.login";
}

class Login {
  const Login();
  final String welcomeBack = "login.welcome_back";
  final String pleaseSignIn = "login.please_sign_in";
  final String email = "login.email";
  final String password = "login.password";
  final String emailHint = "login.email_hint";
  final String passwordHint = "login.password_hint";
  final String forgotPassword = "login.forgot_password";
  final String loginButton = "login.login_button";
  final String dontHaveAccount = "login.dont_have_account";
  final String createAccount = "login.create_account";
}

class ForgotPassword {
  const ForgotPassword();
  final String title = "forgot_password.title";
  final String subtitle = "forgot_password.subtitle";
  final String email = "forgot_password.email";
  final String emailHint = "forgot_password.email_hint";
  final String sendResetCode = "forgot_password.send_reset_code";
}

class ResetPassword {
  const ResetPassword();
  final String resetPasswordLabel = "reset_password.reset_password_label";
  final String subtitlePrefix = "reset_password.subtitle_prefix";
  final String newPasswordHint = "reset_password.new_password_hint";
  final String passwordEmptyValidation = "reset_password.password_empty_validation";
  final String passwordLengthValidation = "reset_password.password_length_validation";
  final String resetButton = "reset_password.reset_button";
  final String resetSuccessMessage = "reset_password.reset_success_message";
}

class VerifyCode {
  const VerifyCode();
  final String title = "verify_code.title";
  final String subtitlePrefix = "verify_code.subtitle_prefix";
  final String incompleteCodeValidation = "verify_code.incomplete_code_validation";
  final String codeVerifiedSuccess = "verify_code.code_verified_success";
  final String resendCode = "verify_code.resend_code";
  final String verifyButton = "verify_code.verify_button";
}

class Settings {
  const Settings();
  final String title = "settings.title";
  final String myProfile = "settings.my_profile";
  final String language = "settings.language";
  final String english = "settings.english";
  final String arabic = "settings.arabic";
  final String notifications = "settings.notifications";
}

class Address {
  const Address();
  final String addNewAddress = "address.add_new_address";
  final String addressDetails = "address.address_details";
  final String fillInformationSubtitle = "address.fill_information_subtitle";
  final String savedAddresses = "address.saved_addresses";
  final String addressLabel = "address.address_label";
  final String city = "address.city";
  final String phoneNumber = "address.phone_number";
  final String detailedAddress = "address.detailed_address";
  final String labelHint = "address.label_hint";
  final String cityHint = "address.city_hint";
  final String phoneHint = "address.phone_hint";
  final String detailsHint = "address.details_hint";
  final String labelValidation = "address.label_validation";
  final String cityValidation = "address.city_validation";
  final String phoneValidation = "address.phone_validation";
  final String detailsValidation = "address.details_validation";
  final String saveAddress = "address.save_address";
  final String addressAddedSuccess = "address.address_added_success";
  final String deleteAddress = "address.delete_address";
  final String deleteConfirmMessage = "address.delete_confirm_message";
  final String cancel = "address.cancel";
  final String delete = "address.delete";
  final String failedToDelete = "address.failed_to_delete";
  final String addressDeletedSuccess = "address.address_deleted_success";
  final String noAddressesFound = "address.no_addresses_found";
  final String tryAgain = "address.try_again";
}