import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  bool get isFaculty => _currentUser?.isFaculty ?? false;
  bool get isStudent => _currentUser?.isStudent ?? true;

  // Initialize and check for existing session
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');
      
      if (userJson != null) {
        _currentUser = User.fromJsonString(userJson);
      }
    } catch (e) {
      debugPrint('Error loading user session: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Auto-detect role based on email pattern
  UserRole _detectRoleFromEmail(String email) {
    final emailLower = email.toLowerCase();
    
    // Faculty patterns
    if (emailLower.contains('@faculty') || 
        emailLower.contains('prof.') ||
        emailLower.contains('dr.') ||
        emailLower.contains('teacher')) {
      return UserRole.faculty;
    }
    
    // Default to student
    return UserRole.student;
  }

  // Sign up new user
  Future<bool> signUp({
    required String fullName,
    required String email,
    required String rollNumber,
    required String branch,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Detect role from email
      final role = _detectRoleFromEmail(email);

      // Create new user
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: fullName,
        email: email,
        rollNumber: rollNumber,
        branch: branch,
        role: role,
      );

      // Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', user.toJsonString());

      // For demo: save credentials for login
      await prefs.setString('user_${email}_password', password);

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error signing up: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Login existing user
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final prefs = await SharedPreferences.getInstance();
      
      // Check for demo credentials
      if (email == 'prof.sharma@faculty.college.edu' && password == 'admin123') {
        final user = User(
          id: '1',
          fullName: 'Prof. Sharma',
          email: email,
          rollNumber: '',
          branch: 'Computer Science',
          role: UserRole.faculty,
        );
        
        await prefs.setString('current_user', user.toJsonString());
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      }

      if (email == 'student@college.edu' && password == 'password123') {
        final user = User(
          id: '2',
          fullName: 'Rahul Verma',
          email: email,
          rollNumber: '2021CS001',
          branch: 'Computer Science',
          role: UserRole.student,
        );
        
        await prefs.setString('current_user', user.toJsonString());
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      }

      // Check stored credentials
      final storedPassword = prefs.getString('user_${email}_password');
      
      if (storedPassword != null && storedPassword == password) {
        // Find user by email (in real app, fetch from backend)
        final userJson = prefs.getString('current_user');
        if (userJson != null) {
          final user = User.fromJsonString(userJson);
          if (user.email == email) {
            _currentUser = user;
            _isLoading = false;
            notifyListeners();
            return true;
          }
        }
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('Error logging in: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user');
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error logging out: $e');
    }
  }

  // Update user profile
  Future<bool> updateProfile(User updatedUser) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', updatedUser.toJsonString());
      _currentUser = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return false;
    }
  }
}
