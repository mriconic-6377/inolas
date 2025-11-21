import 'dart:convert';

enum UserRole {
  student,
  faculty,
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String rollNumber;
  final String branch;
  final UserRole role;
  final String? avatarUrl;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.rollNumber,
    required this.branch,
    required this.role,
    this.avatarUrl,
  });

  // Check if user is faculty
  bool get isFaculty => role == UserRole.faculty;

  // Check if user is student
  bool get isStudent => role == UserRole.student;

  // Get initials for avatar
  String get initials {
    final names = fullName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return fullName.substring(0, 2).toUpperCase();
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'rollNumber': rollNumber,
      'branch': branch,
      'role': role.toString(),
      'avatarUrl': avatarUrl,
    };
  }

  // Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      rollNumber: json['rollNumber'] as String,
      branch: json['branch'] as String,
      role: json['role'] == 'UserRole.faculty' 
          ? UserRole.faculty 
          : UserRole.student,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  // Convert to JSON string
  String toJsonString() => json.encode(toJson());

  // Create from JSON string
  factory User.fromJsonString(String jsonString) {
    return User.fromJson(json.decode(jsonString) as Map<String, dynamic>);
  }

  // Copy with method for updates
  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? rollNumber,
    String? branch,
    UserRole? role,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      rollNumber: rollNumber ?? this.rollNumber,
      branch: branch ?? this.branch,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
