import 'package:flutter/material.dart';

class AppValidator {
  static String? validatePromoCode(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a promo code";
    }

    if (value.length < 4 || value.length > 20) {
      return "Promo code must be between 4 and 20 characters";
    }

    bool isValid = RegExp(r'^[A-Za-z0-9-]+$').hasMatch(value);
    if (!isValid) {
      return "Promo code should contain only letters, numbers and '-' ";
    }

    return null;
  }

  // ================== Auth Validate ==================
  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    if (value.length < 3) {
      return "";
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    RegExp regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (value == null || value.isEmpty) {
      return "";
    }
    if (!regExp.hasMatch(value)) {
      return "";
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    RegExp regex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    );
    if (value == null || value.isEmpty) {
      return "";
    }
    if (!regex.hasMatch(value)) {
      return "";
    }

    if (value.length < 8) {
      return "";
    }
    return null;
  }

  static String? validateFirstName(BuildContext context, String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'FirstName is not Valid please enter firstName valid';
    }
    bool hasInvalidChars = RegExp(r'[^a-zA-Z\s]').hasMatch(firstName);
    if (hasInvalidChars) {
      return 'Name should only contain alphabetic characters';
    }
    return null;
  }

  static String? validateEmailAuth(BuildContext context, String? emailLogin) {
    if (emailLogin == null || emailLogin.isEmpty) {
      return 'Please enter an email';
    }
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(emailLogin)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePasswordAuth(
    BuildContext context,
    String? passwordLogin,
  ) {
    if (passwordLogin == null || passwordLogin.isEmpty) {
      return 'Please enter a password';
    }
    bool hasUppercase = RegExp(r'[A-Z]').hasMatch(passwordLogin);
    bool hasLowercase = RegExp(r'[a-z]').hasMatch(passwordLogin);
    bool hasSymbols = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(passwordLogin);
    if (!hasUppercase) {
      return 'Password should contain at least one uppercase letter';
    }
    if (!hasLowercase) {
      return 'Password should contain at least one lowercase letter';
    }
    if (!hasSymbols) {
      return 'Password should contain at least one symbol';
    }

    if (passwordLogin.length < 8 || passwordLogin.length > 20) {
      return 'Password should be at least 8 characters';
    }

    return null;
  }

  static String? validateUserName(BuildContext context, String? userName) {
    bool isValidUsername = RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(userName!);
    if (!isValidUsername) {
      return 'Username should only contain letters, numbers, and underscores';
    }
    if (userName.length < 4 || userName.length > 20) {
      return 'Username should be between 4 and 20 characters';
    }
    return null;
  }

  static String? validatePhoneNumber(
    BuildContext context,
    String? phoneNumber,
  ) {
    bool isValidPhone = RegExp(
      r'^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d$',
    ).hasMatch(phoneNumber!);
    if (!isValidPhone) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateStrongOtp(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the OTP';
    } else if (value.length < 8) {
      return 'OTP must be at least 8 characters long';
    } else if (!RegExp(
      r'^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]+$',
    ).hasMatch(value)) {
      return 'OTP must contain at least one letter and one digit';
    }

    return null;
  }

  static String? validateConfirmPass(
    BuildContext context,
    String? confirmPass,
    TextEditingController password,
  ) {
    if (confirmPass == null || confirmPass.isEmpty) {
      return "";
    } else if (confirmPass != password.text) {
      return "";
    }
    return null;
  }

  static String? validatorConfirmPassword(BuildContext context, String? val) {
    final newConfirmPassword = TextEditingController();
    if (val!.isEmpty) {
      return 'Please confirm your password';
    }
    if (val.isEmpty) {
      return 'Please enter a password';
    } else if (val.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(val)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(val)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(val)) {
      return 'Password must contain at least one symbol';
    } else if (val != newConfirmPassword.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateLastName(BuildContext context, String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return 'LastName is not Valid please enter LastName valid';
    }
    bool hasInvalidChars = RegExp(r'[^a-zA-Z\s]').hasMatch(lastName);
    if (hasInvalidChars) {
      return 'Name should only contain alphabetic characters';
    }
    return null;
  }
}
