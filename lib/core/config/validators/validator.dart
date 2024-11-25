class AppValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');

    if (!emailRexExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }

    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }

    if(value.length < 6){
      return 'Password must me atleast 6 character long';
    }

    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain atleast one uppercase letter';
    }

    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain atleast one number';
    }

    if(!value.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))){
      return 'Password must contain atleast one special character';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'Phone number is required';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if(!phoneRegExp.hasMatch(value)){
      return 'Invalid phone number';
    }
    return null;
  }

  
}