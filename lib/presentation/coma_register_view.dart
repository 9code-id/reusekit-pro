import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaRegisterView extends StatefulWidget {
  const ComaRegisterView({super.key});

  @override
  State<ComaRegisterView> createState() => _ComaRegisterViewState();
}

class _ComaRegisterViewState extends State<ComaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String fullName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  String companyName = "";
  String position = "";
  String selectedRole = "contractor";
  bool agreeToTerms = false;
  bool loading = false;

  List<Map<String, dynamic>> roleOptions = [
    {"label": "Contractor", "value": "contractor"},
    {"label": "Project Manager", "value": "project_manager"},
    {"label": "Site Supervisor", "value": "site_supervisor"},
    {"label": "Company Owner", "value": "company_owner"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: sp2xl),
                    
                    // Header
                    Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: fsH1,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Join our construction management platform",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Personal Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QTextField(
                            label: "Full Name",
                            value: fullName,
                            validator: Validator.required,
                            onChanged: (value) {
                              fullName = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Email Address",
                            value: email,
                            validator: Validator.email,
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Phone Number",
                            value: phone,
                            validator: Validator.required,
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Company Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Professional Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QTextField(
                            label: "Company Name",
                            value: companyName,
                            validator: Validator.required,
                            onChanged: (value) {
                              companyName = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Position/Title",
                            value: position,
                            validator: Validator.required,
                            onChanged: (value) {
                              position = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Role",
                            items: roleOptions,
                            value: selectedRole,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedRole = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Security
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          QTextField(
                            label: "Password",
                            value: password,
                            obscureText: true,
                            validator: Validator.required,
                            onChanged: (value) {
                              password = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Confirm Password",
                            value: confirmPassword,
                            obscureText: true,
                            validator: Validator.required,
                            onChanged: (value) {
                              confirmPassword = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Terms and Conditions
                    QSwitch(
                      items: [
                        {
                          "label": "I agree to the Terms of Service and Privacy Policy",
                          "value": true,
                          "checked": agreeToTerms,
                        }
                      ],
                      value: agreeToTerms
                          ? [
                              {
                                "label": "I agree to the Terms of Service and Privacy Policy",
                                "value": true,
                                "checked": true
                              }
                            ]
                          : [],
                      onChanged: (values, ids) {
                        agreeToTerms = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    // Register Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Account",
                        size: bs.md,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (password != confirmPassword) {
                              se("Passwords do not match");
                              return;
                            }
                            if (!agreeToTerms) {
                              se("Please agree to the terms and conditions");
                              return;
                            }
                            
                            loading = true;
                            setState(() {});
                            
                            await Future.delayed(Duration(seconds: 2));
                            
                            loading = false;
                            setState(() {});
                            
                            ss("Account created successfully");
                            // ss('Next page'));
                          }
                        },
                      ),
                    ),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            back();
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
