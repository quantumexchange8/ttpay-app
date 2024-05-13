String? idValidator(String? idNumber) {
  if (idNumber == null || idNumber.isEmpty) {
    return 'Id number is required';
  } else {
    return null;
  }
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  } else {
    return null;
  }
}

String? newPasswordValidator(String newPassword) {
  if (newPassword.isEmpty) {
    return 'Password is required';
  } else if (!newPassword.contains(RegExp(r'[A-Z]'))) {
    return 'Character must containing one uppercase letter';
  } else if (!newPassword.contains(RegExp(r'[a-z]'))) {
    return 'Character must containing one lowercase letter';
  } else if (!newPassword.contains(RegExp(r'[0-9]'))) {
    return 'Character must containing one number';
  } else if (!newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Character must containing one special character';
  } else if (newPassword.length < 8) {
    return 'Character must be at least 8 characters';
  } else {
    return null;
  }
}

String? comfirmPasswordValidator({
  required String comfirmPassword,
  required String newPasword,
}) {
  if (comfirmPassword.isEmpty || comfirmPassword != newPasword) {
    return 'Password is not match';
  } else {
    return null;
  }
}
