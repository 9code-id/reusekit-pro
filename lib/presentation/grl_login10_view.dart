import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin10View extends StatefulWidget {
  const GrlLogin10View({super.key});

  @override
  State<GrlLogin10View> createState() => _GrlLogin10ViewState();
}

class _GrlLogin10ViewState extends State<GrlLogin10View> {
  String email = "";
  String password = "";
  String selectedRole = "employee";
  
  final List<Map<String, dynamic>> userRoles = [
    {
      "label": "Employee",
      "value": "employee",
      "icon": Icons.person,
      "description": "Standard user access",
    },
    {
      "label": "Manager",
      "value": "manager", 
      "icon": Icons.supervisor_account,
      "description": "Team management access",
    },
    {
      "label": "Administrator",
      "value": "admin",
      "icon": Icons.admin_panel_settings,
      "description": "Full system access",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withAlpha(100),
              Colors.white,
              secondaryColor.withAlpha(80),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spMd),
                
                // Corporate Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(radius2xl),
                    boxShadow: [shadowLg],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryColor, secondaryColor],
                              ),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.business,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CorpPortal",
                                style: TextStyle(
                                  fontSize: fsH2,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Enterprise Solutions",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Text(
                        "Secure access to your corporate dashboard",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Role Selection
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXl),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Your Role",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "Choose your access level",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Column(
                        spacing: spSm,
                        children: List.generate(userRoles.length, (index) {
                          final role = userRoles[index];
                          final isSelected = selectedRole == role["value"];
                          
                          return GestureDetector(
                            onTap: () {
                              selectedRole = role["value"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor.withAlpha(50) : Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: isSelected ? primaryColor : disabledColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      role["icon"],
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${role["label"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected ? primaryColor : disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${role["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Login Form
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXl),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spMd,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Credentials",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      QTextField(
                        label: "Corporate Email",
                        value: email,
                        hint: "name@company.com",
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      
                      QTextField(
                        label: "Password",
                        value: password,
                        obscureText: true,
                        hint: "Enter your secure password",
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                      ),
                      
                      // Security Features
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: successColor.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.verified_user, color: successColor, size: 20),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enterprise Security",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "SSO, MFA, and encryption enabled",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Access Dashboard",
                          size: bs.md,
                          onPressed: () {
                            // Handle corporate login
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Quick Access Options
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Quick Access",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.qr_code_scanner, size: 24, color: secondaryColor),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "QR Login",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.badge, size: 24, color: secondaryColor),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "ID Badge",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.fingerprint, size: 24, color: secondaryColor),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "Biometric",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Footer Links
                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to forgot password
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          " • ",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Contact IT support
                          },
                          child: Text(
                            "IT Support",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "© 2024 CorpPortal. Confidential and Proprietary.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
