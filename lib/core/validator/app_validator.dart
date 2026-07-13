class AppValidator {
  /// Basic required field check
  static String? required(
      String? value, {
        String message = 'required_field',
      }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// City Selection Validator
  static String? city(String? value, {String message = 'must select city'}) {
    return required(value, message: message);
  }

  /// Bank Selection Validator
  static String? bank(String? value, {String message = 'must select bank'}) {
    return required(value, message: message);
  }

  /// Saudi Arabian IBAN Validator
  /// Format: Starts with SA followed by 22 digits (Total 24 characters)
  static String? iban(String? value, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'required_field');
    if (requiredError != null) return requiredError;

    // Cleans up any unintended spaces or lowercases from user input
    final cleanIban = value!.trim().replaceAll(' ', '').toUpperCase();

    // Regex for Saudi Arabia IBAN: SA followed by exactly 22 numbers
    final ibanRegex = RegExp(r'^SA[0-9]{22}$');

    return ibanRegex.hasMatch(cleanIban)
        ? null
        : (invalidMsg ?? 'invalid iban');
  }

  /// Egyptian Phone Number Validation
  /// Accepts formats: +201xxxxxxxx, 201xxxxxxxx, 01xxxxxxxx, or 1xxxxxxxx
  static String? egyptPhone(String? value, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'Enter phone Number Please');
    if (requiredError != null) return requiredError;

    // Matches standard Egyptian mobile prefixes starting with 1 (10 digits total without the country code/leading 0)
    // The core number must start with 0, 1, 2, or 5 right after the '1'
    final phoneRegex = RegExp(r'^(?:\+20|20|0)?1[0125][0-9]{8}$');

    return phoneRegex.hasMatch(value!.trim())
        ? null
        : (invalidMsg ?? 'invalid_egyptian_phone_number');
  }

  /// Full name validation with min character check
  static String? name(String? value, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'Enter Name Please');
    if (requiredError != null) return requiredError;

    if (value!.trim().length < 3) {
      return invalidMsg ?? 'name_too_short';
    }

    return null;
  }

  /// Email validation
  static String? email(String? value, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'Enter Email Please');
    if (requiredError != null) return requiredError;

    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

    return emailRegex.hasMatch(value!.trim())
        ? null
        : (invalidMsg ?? 'invalid_email');
  }

  /// Password verification
  static String? password(String? value, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'Enter Password');
    if (requiredError != null) return requiredError;

    if (value!.length < 8) {
      return invalidMsg ?? 'password_too_short';
    }

    return null;
  }

  /// Confirm Password checker
  static String? confirmPassword(
      String? value,
      String password, {
        String? requiredMsg,
        String? invalidMsg,
      }) {
    final requiredError = required(value, message: requiredMsg ?? "password doesn't match");
    if (requiredError != null) return requiredError;

    if (value != password) {
      return invalidMsg ?? 'passwords_do_not_match';
    }

    return null;
  }

  /// Username checker (Letters, numbers, underscores, and hyphens)
  static String? username(String? value, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'Enter Name Please');
    if (requiredError != null) return requiredError;

    final regex = RegExp(r'^[a-zA-Z0-9_-]+$');

    return regex.hasMatch(value!)
        ? null
        : (invalidMsg ?? 'invalid_username_format');
  }

  /// Custom minimum length validator helper
  static String? minLength(String? value, int min, {String? requiredMsg, String? invalidMsg}) {
    final requiredError = required(value, message: requiredMsg ?? 'required_field');
    if (requiredError != null) return requiredError;

    if (value!.length < min) {
      return invalidMsg ?? 'must_be_at_least_$min\_characters';
    }

    return null;
  }
}