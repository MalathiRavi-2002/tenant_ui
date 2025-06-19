import 'package:tenant_api/admin_api.dart';
import 'package:flutter/material.dart';
// import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tenant_ui/providers/auth_provider.dart';
// import 'package:tenant_ui/ui/screens/info_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final borderColor = Colors.grey.shade300;
  final sidebarColor = const Color(0xFFF8F9FB);
  final contentColor = Colors.white;
  final primaryColor = const Color(0xFF006CC0);
  final headertextColor = const Color(0xFF5C5C5C);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  final _countryController = TextEditingController();
  final _bookController = TextEditingController();
  final _gstController = TextEditingController();
  final _fpController = TextEditingController();

  final SearchController _searchController = SearchController();
  bool _obscure = true;

  // List<OrganizationResponseModel> organizationList = [];
  // List<OrganizationResponseModel> filteredOrganizations = [];
  List<String> organizationList = [];
  List<String> filteredOrganizations = [];

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

  String selectedMenu = '';
  bool isLicensed = false;

  Widget _mobileView(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _filterOrganizations() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredOrganizations =
          organizationList.where((org) {
            return org.toLowerCase().contains(query);
          }).toList();
    });
  }

  void _addOrganization() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Add Organization', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Input Fields
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration('Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter Name' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: _inputDecoration('Full Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter Full Name' : null,
                  ),
                  const SizedBox(height: 10),

                  StatefulBuilder(
                    builder: (context, setLocalState) {
                      return TextFormField(
                        controller: _adminPasswordController,
                        obscureText: _obscure,
                        obscuringCharacter: '*',
                        decoration: _inputDecoration('Admin Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setLocalState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Enter Admin Password' : null,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _countryController,
                    decoration: _inputDecoration('Country'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter Country' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _bookController,
                    decoration: InputDecoration(
                      hintText: 'Book Begin',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        _bookController.text = formattedDate;
                      }
                    },
                    validator: (value) => value == null || value.isEmpty ? 'Enter Book Begin' : null,
                  ),

                  const SizedBox(height: 10),
                  TextFormField(controller: _gstController, decoration: _inputDecoration('Gst No')),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _fpController,
                    decoration: _inputDecoration('Financial Period Code'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter FP Code' : null,
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final api = context.read<Api>();
                          api
                              .createOrganization(
                                OrganizationCreateRequest(
                                  name: _nameController.text,
                                  fullName: _fullNameController.text,
                                  adminPassword: _adminPasswordController.text,
                                  country: _countryController.text,
                                  bookBegin: _bookController.text,
                                  gstNo: _gstController.text.isNotEmpty ? _gstController.text.trim() : null,
                                  fpCode: int.parse(_fpController.text),
                                ),
                              )
                              .onSuccess((out) {
                                Navigator.pop(context);
                                _fetchOrganization();
                              })
                              .onFailure((e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.toString()}'),
                                    backgroundColor: const Color.fromARGB(255, 228, 111, 102),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              });
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        padding: const EdgeInsets.all(18),
                      ),
                      child: const Text('Submit', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _fetchOrganization() {
    final api = context.read<Api>();
    api
        .organizationList()
        .onSuccess((response) {
          setState(() {
            organizationList = response;
            filteredOrganizations = response;
          });
        })
        .onFailure((e) {
          if ((e.toString()).contains('Unauthorized')) {
            context.read<AuthProvider>().logout();
          }
          // print('error: ${e.toString()}');
        });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _fullNameController.dispose();
    _adminPasswordController.dispose();
    _countryController.dispose();
    _bookController.dispose();
    _gstController.dispose();
    _fpController.dispose();
    super.dispose();
  }

  void _pageInit() async {
    await context.read<Api>().loadToken();
    _searchController.addListener(_filterOrganizations);
    _fetchOrganization();
  }

  @override
  void initState() {
    _pageInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(color: sidebarColor, border: Border(bottom: BorderSide(color: borderColor))),
            child: Center(
              child: Text('Organizations List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              color: sidebarColor,
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                          child: _buildOrganizationTable(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationTable() {
    return LayoutBuilder(
      builder: (context, raints) {
        final isMobile = raints.maxWidth < 500;

        return Center(
          child: SizedBox(
            width: 1500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMobile
                    ? _mobileView('Organizations')
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Organizations', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                        Row(
                          spacing: 10,
                          children: [
                            SizedBox(
                              width: 230,
                              height: 40,
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  suffixIcon: const Icon(Icons.search),
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: primaryColor, width: 1),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _addOrganization();
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text('New', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                padding: const EdgeInsets.all(18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                const SizedBox(height: 20),

                // Organization Table
                Container(
                  width: 1500,
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: const Color(0xFFF7F7F7),
                        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold, color: headertextColor),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Table Row
                      for (final org in filteredOrganizations)
                        InkWell(
                          // onTap: () {
                          //   Navigator.push(context, MaterialPageRoute(builder: (_) => InfoScreen(organization: org)));
                          // },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                            decoration: BoxDecoration(border: Border(top: BorderSide(color: borderColor))),
                            child: Row(children: [Expanded(flex: 2, child: Text(org))]),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
