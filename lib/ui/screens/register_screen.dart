import 'package:tenant_api/admin_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tenant_ui/ui/screens/info_screen.dart';

class RegisterScreen extends StatefulWidget {
  final OrganizationResponseModel organization;

  const RegisterScreen({super.key, required this.organization});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final borderColor = const Color.fromARGB(255, 29, 28, 28);
  final primaryColor = Color(0xFF006CC0);
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _keyController = TextEditingController();
  final _noController = TextEditingController();
  final FocusNode _noFocus = FocusNode();

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

  void _register() {
    if (_formKey.currentState!.validate()) {
      final api = context.read<Api>();
      api
          .register(
            RegisterRequest(
              id: _idController.text,
              serialNo: int.parse(_noController.text),
              serialKey: _keyController.text,
            ),
          )
          .onSuccess((response) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => InfoScreen(organization: widget.organization)));
          })
          .onFailure((e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // content: Text('Error: ${e.toString()}'),
                content: Text('Register Failed....Please Enter Valid Serial No and Serial Key'),
                backgroundColor: const Color.fromARGB(255, 228, 111, 102),
                duration: Duration(seconds: 3),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _noFocus.requestFocus();
      _idController.text = widget.organization.id;
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
                  Text('License Registration', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 24),
                  TextFormField(controller: _idController, readOnly: true, decoration: _inputDecoration('Org id')),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _noController,
                    focusNode: _noFocus,
                    validator: (value) => value == null || value.isEmpty ? 'Enter Serial No' : null,
                    decoration: _inputDecoration('Serial No'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _keyController,
                    validator: (value) => value == null || value.isEmpty ? 'Enter Serial Key' : null,
                    decoration: _inputDecoration('Serial Key'),
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
                      onPressed: _register,
                      child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 17)),
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
