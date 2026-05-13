import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaRegisterView extends StatefulWidget {
  const AmaRegisterView({super.key});

  @override
  State<AmaRegisterView> createState() => _AmaRegisterViewState();
}

class _AmaRegisterViewState extends State<AmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  String farmName = "";
  String farmLocation = "";
  String farmSize = "";
  String farmType = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  List<Map<String, dynamic>> farmTypes = [
    {"label": "Crop Farming", "value": "crop"},
    {"label": "Livestock", "value": "livestock"},
    {"label": "Mixed Farming", "value": "mixed"},
    {"label": "Poultry", "value": "poultry"},
    {"label": "Dairy", "value": "dairy"},
    {"label": "Organic Farming", "value": "organic"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.agriculture,
                    size: 48,
                    color: successColor,
                  ),
                ),

                SizedBox(height: spLg),

                Text(
                  "Join AgriManage",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spSm),

                Text(
                  "Start managing your farm efficiently with our smart agriculture platform",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                SizedBox(height: spXl),

                // Registration Form
                Form(
                  key: formKey,
                  child: Column(
                    spacing: spMd,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Information Section
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      // Full Name
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

                      // Email and Phone
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Email Address",
                              value: email,
                              hint: "Enter your email",
                              validator: Validator.email,
                              onChanged: (value) {
                                email = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QTextField(
                              label: "Phone Number",
                              value: phoneNumber,
                              hint: "Enter phone number",
                              validator: Validator.required,
                              onChanged: (value) {
                                phoneNumber = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      // Password Fields
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

                      // Farm Information Section
                      Text(
                        "Farm Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      // Farm Name
                      QTextField(
                        label: "Farm Name",
                        value: farmName,
                        hint: "Enter your farm name",
                        validator: Validator.required,
                        onChanged: (value) {
                          farmName = value;
                          setState(() {});
                        },
                      ),

                      // Farm Location and Size
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Farm Location",
                              value: farmLocation,
                              hint: "City, State",
                              validator: Validator.required,
                              onChanged: (value) {
                                farmLocation = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QTextField(
                              label: "Farm Size (acres)",
                              value: farmSize,
                              hint: "e.g., 50",
                              validator: Validator.required,
                              onChanged: (value) {
                                farmSize = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      // Farm Type
                      QDropdownField(
                        label: "Farm Type",
                        items: farmTypes,
                        value: farmType,
                        onChanged: (value, label) {
                          farmType = value;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spMd),

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

                      // Newsletter Subscription
                      QSwitch(
                        items: [
                          {
                            "label": "Subscribe to farming tips and updates",
                            "value": true,
                            "checked": subscribeNewsletter,
                          }
                        ],
                        value: [
                          if (subscribeNewsletter)
                            {
                              "label": "Subscribe to farming tips and updates",
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

                      SizedBox(height: spMd),

                      // Already have account
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
                              _navigateToLogin();
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

                      SizedBox(height: spMd),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _handleRegister() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the Terms of Service");
        return;
      }

      loading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 3));

      loading = false;
      setState(() {});

      // Simulate successful registration
      ss("Account created successfully! Welcome to AgriManage");
      
      // Navigate to verification or dashboard
      _navigateToVerification();
    }
  }

  void _navigateToLogin() {
    // Navigate to login page
    back();
  }

  void _navigateToVerification() {
    // Navigate to email verification
    si("Email verification sent to $email");
  }
}
