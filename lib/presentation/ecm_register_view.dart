import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmRegisterView extends StatefulWidget {
  const EcmRegisterView({super.key});

  @override
  State<EcmRegisterView> createState() => _EcmRegisterViewState();
}

class _EcmRegisterViewState extends State<EcmRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String companyName = "";
  String phoneNumber = "";
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_add,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Join EventPro",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Start managing your events professionally",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            
            // Registration form
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
                    label: "Company/Organization Name",
                    value: companyName,
                    hint: "Enter your company name",
                    validator: Validator.required,
                    onChanged: (value) {
                      companyName = value;
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
                            obscureConfirmPassword ? "Show" : "Hide",
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
            SizedBox(height: spLg),
            
            // Terms and conditions
            QSwitch(
              items: [
                {
                  "label": "I agree to the Terms & Conditions and Privacy Policy",
                  "value": true,
                  "checked": acceptTerms,
                }
              ],
              value: [
                if (acceptTerms)
                  {
                    "label": "I agree to the Terms & Conditions and Privacy Policy",
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
            SizedBox(height: spXl),
            
            // Register button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Account",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (!acceptTerms) {
                      se("Please accept the terms and conditions");
                      return;
                    }
                    ss("Account created successfully!");
                    // ss('Next page'));
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
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: disabledColor)),
              ],
            ),
            SizedBox(height: spLg),
            
            // Social registration
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Google",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.facebook, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Facebook",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
            
            // Login link
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
                    back();
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
