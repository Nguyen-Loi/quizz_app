enum UserRole { admin, teacher, student }

extension UserRoleExtension on UserRole {
  static UserRole fromString(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'teacher':
        return UserRole.teacher;
      case 'student':
        return UserRole.student;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }
}