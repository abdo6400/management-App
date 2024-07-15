import 'app_strings.dart';

class CustomValidationHandler {
  // phone number
  static String? isValidPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) {
      return AppStrings.pleaseEnterVaildPhoneNumber;
    } else {
      // Remove any non-digit characters from the phone number
      String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

      // Check if the phone number consists of all numbers and has a length of 11 digits
      if (digitsOnly.length == 11 && int.tryParse(digitsOnly) != null) {
        return null;
      } else {
        return AppStrings.pleaseEnterVaildPhoneNumber;
      }
    }
  }

//name
  static String? isValidName(String? name) {
    if (name == null || name.isEmpty) {
      return AppStrings.pleaseEnterVaildName;
    } else {
      return null;
      // Regular expression pattern for validating the name
      final RegExp nameRegex = RegExp(r"^[A-Za-z]+(?:[-' ][A-Za-z]+)*$");

      // Check if the name matches the pattern
      if (nameRegex.hasMatch(name)) {
        return null;
      } else {
        return AppStrings.pleaseEnterVaildName;
      }
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
  static String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
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

  static String? isVaildCode(String? text) {
    if (text == null || text.isEmpty || double.tryParse(text) == null) {
      return AppStrings.pleaseEnterVaildValue;
    }

    return null;
  }
}
