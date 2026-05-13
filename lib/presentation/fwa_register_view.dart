import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaRegisterView extends StatefulWidget {
  const FwaRegisterView({super.key});

  @override
  State<FwaRegisterView> createState() => _FwaRegisterViewState();
}

class _FwaRegisterViewState extends State<FwaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool receiveUpdates = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  Future<void> _handleRegister() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!agreeToTerms) {
      se("Please agree to the Terms of Service and Privacy Policy");
      return;
    }

    if (password != confirmPassword) {
      se("Passwords do not match");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Account created successfully! Please verify your email.");
    // navigateTo(FwaOtpVerificationView());
  }

  Future<void> _handleSocialRegister(String provider) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("$provider registration successful!");
    // navigateTo(FwaProfileSetupView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // navigateTo(FwaLoginView());
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Header Section
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App Logo
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),

                      SizedBox(height: spMd),

                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      SizedBox(height: spSm),

                      Text(
                        "Join the fitness community and start your journey",
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

                // Registration Form
                Column(
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

                    // Email Field
                    QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "Enter your email",
                      validator: Validator.email,
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
                          hint: "Create a strong password",
                          obscureText: obscurePassword,
                          validator: Validator.required,
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Must be at least 8 characters with numbers and symbols",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            GestureDetector(
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
                          ],
                        ),
                      ],
                    ),

                    // Confirm Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "Confirm Password",
                          value: confirmPassword,
                          hint: "Re-enter your password",
                          obscureText: obscureConfirmPassword,
                          validator: Validator.required,
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

                    // Agreements
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
                            agreeToTerms = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                        QSwitch(
                          items: [
                            {
                              "label": "Send me fitness tips and app updates",
                              "value": true,
                              "checked": receiveUpdates,
                            }
                          ],
                          value: [
                            if (receiveUpdates)
                              {
                                "label": "Send me fitness tips and app updates",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            receiveUpdates = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    // Register Button
                    Container(
                      width: double.infinity,
                      child: loading
                          ? Container(
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : QButton(
                              label: "Create Account",
                              size: bs.md,
                              onPressed: _handleRegister,
                            ),
                    ),
                  ],
                ),

                SizedBox(height: spLg),

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
                        "or sign up with",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
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

                SizedBox(height: spLg),

                // Social Registration Buttons
                Column(
                  spacing: spSm,
                  children: [
                    // Google Registration
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _handleSocialRegister("Google"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.g_mobiledata,
                                color: dangerColor,
                                size: 24,
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
                      ),
                    ),

                    // Apple Registration
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _handleSocialRegister("Apple"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apple,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Sign up with Apple",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spXl),

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
                        // navigateTo(FwaLoginView());
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
        ),
      ),
    );
  }
}
