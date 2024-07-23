class InputValidator {
  String? emptyValidator(value) {
    return value.toString().trim().isEmpty ? 'Field cannot be empty' : null;
  }

  String? emailValidator(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? 'Invalid email' : null;
  }

  String? passwordValidator(value) {
    return value.toString().length < 6
        ? 'Password cannot be less than 6 characters'
        : null;
  }

  String? retypePasswordValidator(value, password) {
    return value != password
        ? 'Password must be the same as the new password'
        : null;
  }
}
