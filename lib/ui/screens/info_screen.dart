import 'package:cloud_api/admin_api.dart';
import 'package:flutter/material.dart';
import 'package:tenant_ui/ui/screens.dart';

class InfoScreen extends StatefulWidget {
  final OrganizationResponseModel organization;
  const InfoScreen({super.key, required this.organization});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final sidebarColor = const Color(0xFFF8F9FB);
  final primaryColor = const Color(0xFF006CC0);
  final borderColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    bool isRegistered = widget.organization.serialNo != null && widget.organization.serialKey != null;

    return Scaffold(
      backgroundColor: sidebarColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(color: sidebarColor, border: Border(bottom: BorderSide(color: borderColor))),
            child: Center(child: Text('Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(color: sidebarColor, border: Border.all(color: borderColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Container(
                    color: sidebarColor,
                    child: Text('Organization Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),

                  Text('Name: ${widget.organization.name}', style: TextStyle(fontSize: 16)),
                  Text('Full Name: ${widget.organization.fullName}', style: TextStyle(fontSize: 16)),
                  Text('Country: ${widget.organization.country}', style: TextStyle(fontSize: 16)),
                  Text('Book Begin: ${widget.organization.bookBegin}', style: TextStyle(fontSize: 16)),
                  Text('Gst No: ${widget.organization.gstNo}', style: TextStyle(fontSize: 16)),
                  Text('FP - Code: ${widget.organization.fpCode}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // context.go('/register');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterScreen(organization: widget.organization);
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      padding: const EdgeInsets.all(18),
                    ),
                    child: const Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          if (isRegistered) licenseDetails(),
        ],
      ),
    );
  }

  Widget licenseDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: sidebarColor,
              child: Text('Licence Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Text('Serial No: ${widget.organization.serialNo}', style: TextStyle(fontSize: 16)),
            Text('Serial Key: ${widget.organization.serialKey}', style: TextStyle(fontSize: 16)),
            GestureDetector(
              onTap: () {
                print('Revolk Licence');
              },
              child: Text(
                'Revolk Licence',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
