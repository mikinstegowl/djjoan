///Validations For Authentication
extension DocumentIdValidators on String {
  bool isValidEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@('
        r'(\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(this);
  }

  bool isValidPhoneNumber() {
    // return RegExp(r"^(?:[+0]9)?[0-9]{13}$").hasMatch(this);
    return RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(this);
  }
}

String? isRequiredField({required String? value}) {
  if (value!.isNotEmpty) {
    return null;
  } else {
    return "Field Cannot be empty";
  }
}

String? validateEmail({required String? value}) {
  if (value == null || value.isEmpty || !value.isValidEmail()) {
    return "please enter a valid email address";
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a valid password';
  }
  return null;
}

String? validateConfirmPassword(String? value, String? password) {
  if (value!.isEmpty) {
    return 'Please enter a valid password';
  } else if (value.toString() != password.toString()) {
    return "Password does not match!";
  }
  return null;
}

String? mobileNoValidation(String? value) {
  if (value == null || !value.isValidPhoneNumber()) {
    return 'Please enter valid mobile number';
  }
  return null;
}
