class ValidationUtils {
  static final ValidationUtils instance = ValidationUtils._internal();
  factory ValidationUtils() => instance;
  ValidationUtils._internal();

  String? validateEmail({required String email}) {
    // email is empty
    if (email.isEmpty) {
      return 'Email is empty';
    }
    // email is incorrect
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$").hasMatch(email)) {
      return 'Incorrect email';
    }
    // email is correct
    return null;
  }

  String? validatePassword({required String password, String? confirmationPassword}) {
    // password is empty
    if (password.isEmpty) {
      return 'Password is empty';
    }
    // password is less than 6 chars
    if (password.length < 6) {
      return 'Password is less than 6 characters';
    }
    if (confirmationPassword != null) {
      if (password != confirmationPassword) {
        return 'Passwords do not match';
      }
    }
    // password is correct
    return null;
  }

  String? validateFullName({required String fullName, bool nullable = false}) {
    // the full name is empty
    if (fullName.isEmpty) {
      if (nullable) {
        return null;
      }
      return 'Name is empty';
    }
    if (fullName.length < 6) {
      return 'Full name must not have less than 6 characters';
    }
    return null;
  }

  String? validatePrice({required String price, bool nullable = false}) {
    // the price is empty
    if (price.isEmpty) {
      if (nullable) {
        return null;
      }
      return 'price is empty';
    }
    // price is incorrect
    if (!RegExp(r"^[0-9]+$").hasMatch(price)) {
      return 'Incorrect price';
    }
    return null;
  }

  String? validateAddress({required String address, bool nullable = false}) {
    // the address is empty
    if (address.isEmpty) {
      if (nullable) {
        return null;
      }
      return 'address is empty';
    }
    if (address.length < 6) {
      return 'address must not have less than 6 characters';
    }
    return null;
  }
}
