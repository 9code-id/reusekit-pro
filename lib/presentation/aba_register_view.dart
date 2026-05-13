import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaRegisterView extends StatefulWidget {
  const AbaRegisterView({super.key});

  @override
  State<AbaRegisterView> createState() => _AbaRegisterViewState();
}

class _AbaRegisterViewState extends State<AbaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool acceptTerms = false;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.person_add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Join ABA Business",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Create your account to get started",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Registration Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  // Name Fields
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "First Name",
                          value: firstName,
                          hint: "Enter first name",
                          validator: Validator.required,
                          onChanged: (value) {
                            firstName = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Last Name",
                          value: lastName,
                          hint: "Enter last name",
                          validator: Validator.required,
                          onChanged: (value) {
                            lastName = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QTextField(
                        label: "Confirm Password",
                        value: confirmPassword,
                        hint: "Re-enter your password",
                        obscureText: obscureConfirmPassword,
                        validator: (value) {
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
                            obscureConfirmPassword ? "Show Password" : "Hide Password",
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
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Password Requirements
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password requirements:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "At least 8 characters",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Contains uppercase and lowercase letters",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Contains at least one number",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Terms and Conditions
            QSwitch(
              items: [
                {
                  "label": "I agree to the Terms of Service and Privacy Policy",
                  "value": true,
                  "checked": acceptTerms,
                }
              ],
              value: [
                if (acceptTerms)
                  {
                    "label": "I agree to the Terms of Service and Privacy Policy",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  acceptTerms = values.isNotEmpty;
                });
              },
            ),
            
            SizedBox(height: spLg),
            
            // Create Account Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Account",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate() && acceptTerms) {
                    //navigateTo('AbaOtpVerificationView')
                  }
                },
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: disabledColor)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: disabledColor)),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Social Registration Options
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        size: 24,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Sign up with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple,
                        size: 24,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Sign up with Apple",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Sign In Link
            Center(
              child: GestureDetector(
                onTap: () {
                  //navigateTo('AbaLoginView')
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                    children: [
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
