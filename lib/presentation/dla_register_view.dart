import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaRegisterView extends StatefulWidget {
  const DlaRegisterView({super.key});

  @override
  State<DlaRegisterView> createState() => _DlaRegisterViewState();
}

class _DlaRegisterViewState extends State<DlaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  bool agreeTerms = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: sp2xl),
            
            // Header Section
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.local_shipping,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  "Join our delivery network and start earning",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            // Registration Form
            Form(
              key: formKey,
              child: Column(
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
                  
                  QTextField(
                    label: "Phone Number",
                    value: phoneNumber,
                    hint: "Enter your phone number",
                    validator: Validator.required,
                    onChanged: (value) {
                      phoneNumber = value;
                      setState(() {});
                    },
                  ),
                  
                  QTextField(
                    label: "Password",
                    value: password,
                    hint: "Create a strong password",
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
                    hint: "Confirm your password",
                    obscureText: true,
                    validator: Validator.required,
                    onChanged: (value) {
                      confirmPassword = value;
                      setState(() {});
                    },
                  ),
                  
                  // Terms and Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        onChanged: (value) {
                          agreeTerms = value ?? false;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: Text(
                          "I agree to the Terms & Conditions and Privacy Policy",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Register Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Create Account",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate() && agreeTerms) {
                          // Handle registration
                          ss("Account created successfully!");
                        } else if (!agreeTerms) {
                          se("Please accept the terms and conditions");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Social Login Options
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Handle Google registration
                    },
                    icon: Icon(Icons.g_mobiledata, color: dangerColor),
                    label: Text(
                      "Continue with Google",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      side: BorderSide(color: disabledOutlineBorderColor),
                    ),
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Handle Facebook registration
                    },
                    icon: Icon(Icons.facebook, color: infoColor),
                    label: Text(
                      "Continue with Facebook",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      side: BorderSide(color: disabledOutlineBorderColor),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to login
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 14,
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
    );
  }
}
