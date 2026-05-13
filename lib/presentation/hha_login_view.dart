import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaLoginView extends StatefulWidget {
  const HhaLoginView({super.key});

  @override
  State<HhaLoginView> createState() => _HhaLoginViewState();
}

class _HhaLoginViewState extends State<HhaLoginView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  bool rememberMe = false;
  bool obscurePassword = true;
  bool loading = false;
  
  // Demo credentials
  List<Map<String, dynamic>> demoCredentials = [
    {
      "email": "admin@healthhub.com",
      "password": "admin123",
      "role": "System Administrator",
      "department": "IT Department"
    },
    {
      "email": "doctor@healthhub.com", 
      "password": "doctor123",
      "role": "Chief Medical Officer",
      "department": "Medical Department"
    },
    {
      "email": "nurse@healthhub.com",
      "password": "nurse123", 
      "role": "Head Nurse",
      "department": "Nursing Department"
    }
  ];

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    // Check demo credentials
    bool isValidCredential = demoCredentials.any((cred) => 
      cred["email"] == email && cred["password"] == password);
    
    if (isValidCredential) {
      ss("Login successful!");
      //navigateTo(HhaDashboardView());
    } else {
      se("Invalid email or password");
    }
    
    loading = false;
    setState(() {});
  }

  void _fillDemoCredential(int index) {
    final cred = demoCredentials[index];
    email = cred["email"] as String;
    password = cred["password"] as String;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: spXl),
            
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.local_hospital,
                      size: 40,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "HealthHub Analytics",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Healthcare Management System",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            // Login Form
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
                      "Sign In",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "Please enter your credentials to access the system",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    // Email Field
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      hint: "Enter your email address",
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    
                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Password",
                          value: password,
                          obscureText: obscurePassword,
                          validator: Validator.required,
                          hint: "Enter your password",
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spXs),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              obscurePassword = !obscurePassword;
                              setState(() {});
                            },
                            child: Text(
                              obscurePassword ? "Show Password" : "Hide Password",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Remember Me & Forgot Password
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Remember me",
                                "value": true,
                                "checked": rememberMe,
                              }
                            ],
                            value: [
                              if (rememberMe)
                                {
                                  "label": "Remember me",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              rememberMe = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            si("Password reset feature coming soon");
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
                      ],
                    ),
                    
                    // Login Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: loading ? "Signing In..." : "Sign In",
                        size: bs.md,
                        onPressed: loading ? null : _handleLogin,
                      ),
                    ),
                    
                    // Alternative Login
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    
                    // SSO Buttons
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                si("Microsoft SSO integration coming soon");
                              },
                              icon: Icon(
                                Icons.business,
                                size: 18,
                                color: primaryColor,
                              ),
                              label: Text(
                                "Microsoft",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 48,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                si("Google SSO integration coming soon");
                              },
                              icon: Icon(
                                Icons.g_mobiledata,
                                size: 18,
                                color: primaryColor,
                              ),
                              label: Text(
                                "Google",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Demo Credentials Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
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
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Demo Credentials",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "For testing purposes, you can use these demo accounts:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  ...List.generate(demoCredentials.length, (index) {
                    final cred = demoCredentials[index];
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
                                  "${cred["role"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${cred["email"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${cred["department"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Use",
                            size: bs.sm,
                            onPressed: () => _fillDemoCredential(index),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            // Staff Access
            Container(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  //navigateTo(HhaStaffLoginView());
                },
                icon: Icon(
                  Icons.badge,
                  size: 18,
                  color: primaryColor,
                ),
                label: Text(
                  "Staff Access Portal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(spMd),
                  side: BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
            
            // Footer
            Text(
              "© 2024 HealthHub Analytics. All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}
