class Validations {
  static String? name(String value) {
    final regex = RegExp(r'^[a-zA-Z\s]+$');
    if (regex.hasMatch(value) || value.isEmpty) {
      // Valid email address
      return null;
    } else {
      // Invalid email address
      return 'This Field Cannot be Empty';
    }
  }

  static String? email(String value) {
    final regex = RegExp(r"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}");
    if (regex.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid email address';
    }
  }

  static String? phoneNumber(String value) {
    final regex = RegExp(r'^[0-9]{10}$');

    if (regex.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid phone number';
    }
  }

  static String? password(String value) {
    final regex = RegExp(r'^.{8,}$');

    if (regex.hasMatch(value)) {
      return null;
    } else {
      return 'Must be at least 8 characters';
    }
  }

  static String? none(String value) => null;
}
