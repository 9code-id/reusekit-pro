import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaRegisterView extends StatefulWidget {
  const SmaRegisterView({super.key});

  @override
  State<SmaRegisterView> createState() => _SmaRegisterViewState();
}

class _SmaRegisterViewState extends State<SmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
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
          spacing: spMd,
          children: [
            // Header
            Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Icon(
                    Icons.person_add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Join SocieLink",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Create your account to start connecting",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

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
                    label: "Email",
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
                        hint: "Confirm your password",
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Password Requirements
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: infoColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password Requirements:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• At least 8 characters\n• Include uppercase and lowercase letters\n• Include at least one number\n• Include special characters",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Terms and Newsletter
                  Column(
                    spacing: spSm,
                    children: [
                      QSwitch(
                        items: [
                          {
                            "label": "I agree to the Terms of Service and Privacy Policy",
                            "value": true,
                            "checked": agreeToTerms,
                          }
                        ],
                        value: [
                          if (agreeToTerms)
                            {
                              "label": "I agree to the Terms of Service and Privacy Policy",
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

                      QSwitch(
                        items: [
                          {
                            "label": "Subscribe to newsletter and updates",
                            "value": true,
                            "checked": subscribeNewsletter,
                          }
                        ],
                        value: [
                          if (subscribeNewsletter)
                            {
                              "label": "Subscribe to newsletter and updates",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          setState(() {
                            subscribeNewsletter = values.isNotEmpty;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Register Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Create Account",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate() && agreeToTerms) {
                          // Handle registration
                          // ss('Next page'));
                        } else if (!agreeToTerms) {
                          se("Please agree to the Terms of Service and Privacy Policy");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Divider
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: disabledColor,
                  ),
                ),
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
                Expanded(
                  child: Container(
                    height: 1,
                    color: disabledColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Social Registration
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Sign up with Google",
                    icon: Icons.g_mobiledata,
                    size: bs.md,
                    onPressed: () {
                      // Handle Google registration
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Sign up with Facebook",
                    icon: Icons.facebook,
                    size: bs.md,
                    onPressed: () {
                      // Handle Facebook registration
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Sign In Link
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
