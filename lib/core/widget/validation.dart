class Validation {
  /// دا عشان يعرفني اني كاتب باسورد اقل من 6 ارقام مثلا ومكتبتش ال repassword وال الايميل نفس الكلام  طب بتستخدم فين مع ال textFromField طب والحاجات الي المكتوبه هنا دية ممكن تعمل سيرش عليها تجيبها او تسختخدم chatgpt
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Use at least 1 uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Use at least 1 lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateRePassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // يقبل أرقام فقط أو يبدأ بـ +
    if (!RegExp(r'^\+?[0-9]+$').hasMatch(value)) {
      return 'Invalid phone format';
    }

    // لازم يكون على الأقل 11 رقم (باستثناء +)
    final digitsOnly = value.startsWith('+') ? value.substring(1) : value;
    if (digitsOnly.length < 11) {
      return 'Phone must be at least 11 digits';
    }

    return null;
  }
}
