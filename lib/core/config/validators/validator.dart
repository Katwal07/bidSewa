class AppValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ' Email is required';
    }

    RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');

    if (!emailRexExp.hasMatch(value)) {
      return ' Invalid Email Address';
    }

    return null;
  }

  static String? checkEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required';
    }
    return null;
  }

  static String? checkPassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ' Password is required';
    }

    if (value.length < 6) {
      return ' Password must me atleast 6 character long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return ' Password must contain atleast one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return ' Password must contain atleast one number';
    }

    if (!value
        .contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
      return ' Password must contain atleast one special character';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ' Phone number is required';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return ' Invalid phone number';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ' Name is required';
    }
    if (value.length < 3) {
      return ' Name must be at least 3 characters long';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return ' Name can only contain letters and spaces';
    }
    return null;
  }

  static String? validateBankName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' Bank name is required';
  }
  if (value.length < 2) {
    return ' Bank name must be at least 2 characters long';
  }
  if (!RegExp(r'^[a-zA-Z0-9\s&]+$').hasMatch(value)) {
    return ' Bank name can only contain letters, numbers, spaces, and "&"';
  }
  return null;
}

static String? validateBankAccountNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' Bank account number is required';
  }
  if (!RegExp(r'^\d{6,18}$').hasMatch(value)) {
    return ' Account number must be between 6 and 18 digits';
  }
  return null;
}

static String? validateAccountHolderName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' Account holder name is required';
  }
  if (value.length < 3) {
    return ' Name must be at least 3 characters long';
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return ' Name can only contain letters and spaces';
  }
  return null;
}

static String? validateBankIdentifierCode(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' Bank Identifier Code (BIC) is required';
  }
  if (!RegExp(r'^[A-Z0-9]{8,11}$').hasMatch(value)) {
    return ' BIC must be 8 or 11 characters, containing only uppercase letters and digits';
  }
  return null;
}


static String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' Address is required';
  }
  if (value.length < 5) {
    return ' Address must be at least 5 characters long';
  }
  return null;
}

static String? validatePayPalEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' PayPal email is required';
  }
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
    return ' Enter a valid email address';
  }
  return null;
}

static String? validateIMEpayNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' IMEpay number is required';
  }
  if (!RegExp(r'^9[678]\d{8}$').hasMatch(value)) {
    return ' Enter a valid IMEpay number';
  }
  return null;
}


static String? validateKhaltiNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' Khalti number is required';
  }
  if (!RegExp(r'^9[678]\d{8}$').hasMatch(value)) {
    return ' Enter a valid Khalti number';
  }
  return null;
}

static String? validateEsewaNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return ' eSewa number is required';
  }
  if (!RegExp(r'^9[678]\d{8}$').hasMatch(value)) {
    return ' Enter a valid eSewa number';
  }
  return null;
}


}
