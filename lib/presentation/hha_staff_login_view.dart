import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaStaffLoginView extends StatefulWidget {
  const HhaStaffLoginView({super.key});

  @override
  State<HhaStaffLoginView> createState() => _HhaStaffLoginViewState();
}

class _HhaStaffLoginViewState extends State<HhaStaffLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String staffId = "";
  String pin = "";
  String selectedDepartment = "";
  bool loading = false;
  bool biometricEnabled = false;
  
  List<Map<String, dynamic>> departments = [
    {"label": "Emergency Department", "value": "emergency"},
    {"label": "Intensive Care Unit", "value": "icu"},
    {"label": "Surgery Department", "value": "surgery"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Radiology", "value": "radiology"},
    {"label": "Laboratory", "value": "laboratory"},
    {"label": "Pharmacy", "value": "pharmacy"},
    {"label": "Administration", "value": "admin"},
  ];
  
  // Demo staff credentials
  List<Map<String, dynamic>> demoStaff = [
    {
      "staffId": "ST001",
      "pin": "1234",
      "name": "Dr. Sarah Wilson",
      "role": "Attending Physician",
      "department": "emergency",
      "shift": "Day Shift",
    },
    {
      "staffId": "ST002", 
      "pin": "5678",
      "name": "Nurse John Davis",
      "role": "Registered Nurse",
      "department": "icu",
      "shift": "Night Shift",
    },
    {
      "staffId": "ST003",
      "pin": "9999",
      "name": "Dr. Maria Garcia",
      "role": "Surgeon",
      "department": "surgery",
      "shift": "On Call",
    },
    {
      "staffId": "ST004",
      "pin": "7777",
      "name": "Tech Mike Johnson",
      "role": "Lab Technician",
      "department": "laboratory",
      "shift": "Day Shift",
    },
  ];

  Future<void> _handleStaffLogin() async {
    if (!formKey.currentState!.validate()) return;
    
    if (selectedDepartment.isEmpty) {
      se("Please select your department");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    // Check demo credentials
    bool isValidStaff = demoStaff.any((staff) => 
      staff["staffId"] == staffId && 
      staff["pin"] == pin && 
      staff["department"] == selectedDepartment);
    
    if (isValidStaff) {
      final staff = demoStaff.firstWhere((s) => 
        s["staffId"] == staffId && s["pin"] == pin);
      ss("Welcome ${staff["name"]}!");
      //navigateTo(HhaStaffDashboardView());
    } else {
      se("Invalid credentials or department mismatch");
    }
    
    loading = false;
    setState(() {});
  }

  void _fillDemoStaff(int index) {
    final staff = demoStaff[index];
    staffId = staff["staffId"] as String;
    pin = staff["pin"] as String;
    selectedDepartment = staff["department"] as String;
    setState(() {});
  }

  Future<void> _handleBiometricLogin() async {
    si("Biometric authentication would be implemented here");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Access Portal"),
        leading: QButton(
          icon: Icons.arrow_back,
          size: bs.sm,
          onPressed: () => back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [secondaryColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.badge,
                      size: 35,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Staff Login",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Quick access for healthcare professionals",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            // Quick Access Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: OutlinedButton.icon(
                      onPressed: _handleBiometricLogin,
                      icon: Icon(
                        Icons.fingerprint,
                        size: 24,
                        color: successColor,
                      ),
                      label: Text(
                        "Biometric\nLogin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: successColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        si("Badge scan feature coming soon");
                      },
                      icon: Icon(
                        Icons.qr_code_scanner,
                        size: 24,
                        color: infoColor,
                      ),
                      label: Text(
                        "Scan\nBadge",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: infoColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Manual Login Form
            Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Manual Login",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Staff ID
                    QTextField(
                      label: "Staff ID",
                      value: staffId,
                      validator: Validator.required,
                      hint: "Enter your staff identification number",
                      onChanged: (value) {
                        staffId = value;
                        setState(() {});
                      },
                    ),
                    
                    // Department Selection
                    QDropdownField(
                      label: "Department",
                      items: departments,
                      value: selectedDepartment,
                      onChanged: (value, label) {
                        selectedDepartment = value;
                        setState(() {});
                      },
                    ),
                    
                    // PIN Field
                    QTextField(
                      label: "PIN",
                      value: pin,
                      obscureText: true,
                      validator: Validator.required,
                      hint: "Enter your 4-digit PIN",
                      onChanged: (value) {
                        pin = value;
                        setState(() {});
                      },
                    ),
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: loading ? "Signing In..." : "Sign In",
                        size: bs.md,
                        onPressed: loading ? null : _handleStaffLogin,
                      ),
                    ),
                    
                    // Emergency Access
                    Container(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          si("Emergency access protocol initiated");
                        },
                        icon: Icon(
                          Icons.emergency,
                          size: 18,
                          color: dangerColor,
                        ),
                        label: Text(
                          "Emergency Access",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(spMd),
                          side: BorderSide(color: dangerColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Demo Staff Credentials
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 20,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Demo Staff Accounts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "For testing purposes, use these demo staff accounts:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  ...List.generate(demoStaff.length, (index) {
                    final staff = demoStaff[index];
                    return Container(
                      margin: EdgeInsets.only(top: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${staff["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${staff["role"]} • ID: ${staff["staffId"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${staff["shift"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Use",
                            size: bs.sm,
                            onPressed: () => _fillDemoStaff(index),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            // Current Shift Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 24,
                        color: successColor,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Shift: Day Shift",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "7:00 AM - 7:00 PM",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "156",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Staff On Duty",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "23",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Emergency Cases",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "8",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Critical Patients",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Support Links
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      si("Technical support contact: ext. 2200");
                    },
                    child: Text(
                      "Technical Support",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text("•", style: TextStyle(color: disabledBoldColor)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      si("Help desk: ext. 1100");
                    },
                    child: Text(
                      "Help Desk",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text("•", style: TextStyle(color: disabledBoldColor)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      si("Security: ext. 9911");
                    },
                    child: Text(
                      "Security",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}
