import 'app_strings.dart';

class CustomValidationHandler {
  // phone number
  static String? isValidPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Check if the phone number consists of all numbers and has a length of 11 digits
    if (digitsOnly.length == 11 && int.tryParse(digitsOnly) != null) {
      return null;
    } else {
      return AppStrings.pleaseEnterVaildPhoneNumber;
    }
  }

//name
  static String? isValidName(String name) {
    // Regular expression pattern for validating the name
    final RegExp nameRegex = RegExp(r"^[A-Za-z]+(?:[-' ][A-Za-z]+)*$");

    // Check if the name matches the pattern
    if (nameRegex.hasMatch(name)) {
      return null;
    } else {
      return AppStrings.pleaseEnterVaildName;
    }
  }

//email
  static String? isValidEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    if (regex.hasMatch(email)) {
      return null;
    }
    return AppStrings.pleaseEnterVaildEmail;
  }

//password
  static String? isValidPassword(String password) {
    if (password.isEmpty) {
      return AppStrings.pleaseEnterVaildPassword;
    }
    // Check the length of the password
    if (password.length < 8) {
      return AppStrings.length;
    }

    // Check if the password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.uppercase;
    }

    // Check if the password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return AppStrings.lowercase;
    }

    // Check if the password contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return AppStrings.digit;
    }

    return null;
  }

  static bool isVaildCode(String text) {
    if (text.isNotEmpty && text.length >= 4) {
      return true;
    }
    return false;
  }
}
