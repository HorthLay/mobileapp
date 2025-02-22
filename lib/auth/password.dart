import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  PasswordField({required this.passwordController});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      obscureText: _isObscured,
      style: TextStyle(
        fontFamily: 'Poppins', // Ensure this font is added in pubspec.yaml
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: "Enter your password",
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
    );
  }
}
