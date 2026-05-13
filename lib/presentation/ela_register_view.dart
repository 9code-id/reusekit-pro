import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaRegisterView extends StatefulWidget {
  const ElaRegisterView({super.key});

  @override
  State<ElaRegisterView> createState() => _ElaRegisterViewState();
}

class _ElaRegisterViewState extends State<ElaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;

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
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_add,
                        size: 40,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Join EduLearn",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create your account to start learning",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spXl),

              // Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QTextField(
                      label: "First Name",
                      value: firstName,
                      hint: "Enter your first name",
                      validator: Validator.required,
                      onChanged: (value) {
                        firstName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QTextField(
                      label: "Last Name",
                      value: lastName,
                      hint: "Enter your last name",
                      validator: Validator.required,
                      onChanged: (value) {
                        lastName = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
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
              SizedBox(height: spMd),
              
              QTextField(
                label: "Phone Number",
                value: phone,
                hint: "Enter your phone number",
                validator: Validator.required,
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Security
              Text(
                "Security",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QTextField(
                    label: "Password",
                    value: password,
                    hint: "Create a strong password",
                    obscureText: obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
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
              SizedBox(height: spMd),
              
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
              SizedBox(height: spMd),

              // Password Strength Indicator
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password Requirements:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    _buildPasswordRequirement("At least 6 characters", password.length >= 6),
                    _buildPasswordRequirement("Contains uppercase letter", password.contains(RegExp(r'[A-Z]'))),
                    _buildPasswordRequirement("Contains lowercase letter", password.contains(RegExp(r'[a-z]'))),
                    _buildPasswordRequirement("Contains number", password.contains(RegExp(r'[0-9]'))),
                  ],
                ),
              ),
              SizedBox(height: spLg),

              // Terms and Conditions
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
              SizedBox(height: spMd),

              QSwitch(
                items: [
                  {
                    "label": "Subscribe to newsletters and updates",
                    "value": true,
                    "checked": subscribeNewsletter,
                  }
                ],
                value: [
                  if (subscribeNewsletter)
                    {
                      "label": "Subscribe to newsletters and updates",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  subscribeNewsletter = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Register Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Account",
                  size: bs.md,
                  onPressed: agreeToTerms ? () {
                    _handleRegister();
                  } : null,
                ),
              ),
              SizedBox(height: spLg),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Social Registration
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Sign up with Google",
                  icon: Icons.g_mobiledata,
                  color: dangerColor,
                  size: bs.md,
                  onPressed: () {
                    _handleGoogleRegister();
                  },
                ),
              ),
              SizedBox(height: spXl),

              // Login Link
              Center(
                child: Column(
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
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
              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String requirement, bool isMet) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? successColor : disabledBoldColor,
          ),
          SizedBox(width: spXs),
          Text(
            requirement,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? successColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _handleRegister() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      // navigateTo(ElaOtpVerificationView())
      ss("Registration successful! Please verify your email.");
    }
  }

  void _handleGoogleRegister() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // navigateTo(ElaRoleSelectionView())
    ss("Google registration successful");
  }
}
