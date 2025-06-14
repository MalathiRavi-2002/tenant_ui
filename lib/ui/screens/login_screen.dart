import 'package:tenant_api/admin_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final primaryColor = Color(0xFF006CC0);
  final borderColor = const Color.fromARGB(255, 29, 28, 28);
  final FocusNode _idFocus = FocusNode();

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: borderColor)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final api = context.read<Api>();
      api
          .adminLogin(_idController.text, _passwordController.text)
          .onSuccess((out) {
            context.read<AuthProvider>().login(out.token);
            api.setToken(out.token);
            context.go('/');
          })
          .onFailure((e) {
            print('error:${e.toString()}');
          });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _idFocus.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Scaffold(
        backgroundColor: Color(0xFF2E3345),
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Login Page', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _idController,
                    focusNode: _idFocus,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) => value == null || value.isEmpty ? 'Enter user Id' : null,
                    decoration: _inputDecoration('User'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) => value == null || value.isEmpty ? 'Enter Password' : null,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration('Password'),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      onPressed: _submit,
                      child: Text('LogIn', style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
