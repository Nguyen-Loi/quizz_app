enum UserRole { 
 admin,
 teacher, 
 student;

  factory UserRole.valueOf(String role) {
     return UserRole.values.firstWhere((e) => e.name == role);
  }
}
