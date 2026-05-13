import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRegisterView extends StatefulWidget {
  const FdaRegisterView({super.key});

  @override
  State<FdaRegisterView> createState() => _FdaRegisterViewState();
}

class _FdaRegisterViewState extends State<FdaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.person_add,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Join FoodExpress",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create your account to start ordering delicious food",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Form Fields
              Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Full Name",
                    value: fullName,
                    hint: "Enter your full name",
                    validator: Validator.required,
                    onChanged: (value) {
                      fullName = value;
                      setState(() {});
                    },
                  ),
                  
                  QTextField(
                    label: "Email Address",
                    value: email,
                    hint: "Enter your email address",
                    validator: Validator.email,
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                  
                  QNumberField(
                    label: "Phone Number",
                    value: phone,
                    hint: "Enter your phone number",
                    validator: Validator.required,
                    onChanged: (value) {
                      phone = value;
                      setState(() {});
                    },
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QTextField(
                        label: "Password",
                        value: password,
                        hint: "Create a strong password",
                        obscureText: obscurePassword,
                        validator: Validator.required,
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
                            obscurePassword ? "Show" : "Hide",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QTextField(
                        label: "Confirm Password",
                        value: confirmPassword,
                        hint: "Re-enter your password",
                        obscureText: obscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (value != password) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          confirmPassword = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spXs),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            obscureConfirmPassword = !obscureConfirmPassword;
                            setState(() {});
                          },
                          child: Text(
                            obscureConfirmPassword ? "Show" : "Hide",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Terms Agreement
              QSwitch(
                items: [
                  {
                    "label": "I agree to Terms & Conditions and Privacy Policy",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [
                  if (agreeToTerms)
                    {
                      "label": "I agree to Terms & Conditions and Privacy Policy",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    agreeToTerms = values.isNotEmpty;
                  });
                },
              ),
              
              SizedBox(height: spXl),
              
              // Register Button
              QButton(
                label: "Create Account",
                size: bs.md,
                onPressed: agreeToTerms ? () {
                  if (formKey.currentState!.validate()) {
                    _register();
                  }
                } : null,
              ),
              
              SizedBox(height: spMd),
              
              // Social Registration Section
              Column(
                children: [
                  Text(
                    "Or sign up with",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledColor),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.g_mobiledata, color: dangerColor, size: 24),
                              SizedBox(width: spSm),
                              Text(
                                "Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledColor),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook, color: infoColor, size: 24),
                              SizedBox(width: spSm),
                              Text(
                                "Facebook",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
              
              SizedBox(height: spXl),
              
              // Sign In Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
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
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Account created successfully");
    
  }
}

