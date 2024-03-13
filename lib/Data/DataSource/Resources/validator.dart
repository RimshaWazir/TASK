class Validate {
  ///Password Validation
  static String? password(String? val) {
    if (val == null || val.trim().isEmpty) {
      return "Please provide a password";
    } else if (val.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!_containsUpperCase(val)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!_containsNumber(val)) {
      return 'Password must contain at least one number';
    } else if (!_containsSpecialCharacter(val)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static bool _containsUpperCase(String val) {
    return val.contains(RegExp(r'[A-Z]'));
  }

  static bool _containsNumber(String val) {
    return val.contains(RegExp(r'[0-9]'));
  }

  static bool _containsSpecialCharacter(String val) {
    return val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  ///Confirm Password Validation
  static String? confirmPassword(val, String? pass) {
    if (val!.trim().isEmpty) {
      return "Please provide Password";
    } else if (val.length != pass?.length) {
      return 'Password length does not match';
    } else if (val != pass) {
      return 'Password does not match';
    }
    return null;
  }

  ///Email Validation
  static String? email(val) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val);
    if (val.isEmpty) {
      return "Please provide email";
    } else if (!emailValid) {
      return 'Invalid Email (i.e): abcd123@domain.com';
    }
    if (val.isEmpty) {
      return "Please provide Email";
    }
    return null;
  }

  ///Name validation
  static String? name(String? val) {
    // bool isValidName =
    //     RegExp(r"^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z]$").hasMatch(val!);
    if (val!.isEmpty) {
      return 'Please add a name';
    }
    return null;
  }

  ///Phone Number Validation
  static String? phone(String? val) {
    if (val!.isEmpty) {
      return 'Provide a phone number';
    }
    return null;
  }
}
