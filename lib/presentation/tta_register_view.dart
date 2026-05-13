import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRegisterView extends StatefulWidget {
  const TtaRegisterView({super.key});

  @override
  State<TtaRegisterView> createState() => _TtaRegisterViewState();
}

class _TtaRegisterViewState extends State<TtaRegisterView> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  final formKey = GlobalKey<FormState>();

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
            spacing: spMd,
            children: [
              // Header
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Icon(
                  Icons.person_add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              
              Text(
                "Join TravelTour",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Text(
                "Create your account to start exploring amazing destinations",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Row(
                spacing: spSm,
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
                hint: "Enter your email",
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
              
              // Security
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
                hint: "Create a strong password",
                obscureText: obscurePassword,
                validator: Validator.required,
                onChanged: (value) {
                  password = value;
                  setState(() {});
                },
              ),
              
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
              
              // Password Requirements
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(30),
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
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "• At least 8 characters\n• Contains uppercase and lowercase letters\n• Contains at least one number\n• Contains special character",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
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
                    "label": "Subscribe to newsletter for travel tips and offers",
                    "value": true,
                    "checked": subscribeNewsletter,
                  }
                ],
                value: [
                  if (subscribeNewsletter)
                    {
                      "label": "Subscribe to newsletter for travel tips and offers",
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
              
              SizedBox(height: spLg),
              
              // Create Account Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Creating Account..." : "Create Account",
                  size: bs.md,
                  onPressed: loading || !agreeToTerms ? null : () async {
                    if (formKey.currentState!.validate()) {
                      loading = true;
                      setState(() {});
                      
                      // Simulate registration process
                      await Future.delayed(Duration(seconds: 2));
                      
                      loading = false;
                      setState(() {});
                      
                      ss("Account created successfully!");
                      // Navigate to OTP verification
                    }
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Social Registration
              Text(
                "Or sign up with",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spXs,
                        children: [
                          Icon(
                            Icons.g_mobiledata,
                            color: dangerColor,
                            size: 20,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spXs,
                        children: [
                          Icon(
                            Icons.facebook,
                            color: infoColor,
                            size: 20,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(
                              fontSize: 14,
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
              
              SizedBox(height: spXl),
              
              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
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
