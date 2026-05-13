import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmRegisterView extends StatefulWidget {
  const IwmRegisterView({super.key});

  @override
  State<IwmRegisterView> createState() => _IwmRegisterViewState();
}

class _IwmRegisterViewState extends State<IwmRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  
  // Company Information
  String companyName = "";
  String companySize = "";
  String industry = "";
  String jobTitle = "";
  
  // Account Security
  String password = "";
  String confirmPassword = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  
  // Agreements
  bool agreeTerms = false;
  bool agreePrivacy = false;
  bool agreeMarketing = false;

  List<Map<String, dynamic>> companySizeOptions = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "201-500 employees", "value": "201-500"},
    {"label": "500+ employees", "value": "500+"},
  ];

  List<Map<String, dynamic>> industryOptions = [
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Retail", "value": "retail"},
    {"label": "E-commerce", "value": "ecommerce"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Technology", "value": "technology"},
    {"label": "Logistics", "value": "logistics"},
    {"label": "Other", "value": "other"},
  ];

  void _register() async {
    if (formKey.currentState!.validate()) {
      if (!agreeTerms) {
        se("Please agree to the Terms of Service");
        return;
      }
      if (!agreePrivacy) {
        se("Please agree to the Privacy Policy");
        return;
      }
      
      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();
      
      // Simulate registration success
      ss("Account created successfully");
      //navigateTo('login')
    }
  }

  void _goToLogin() {
    // Navigate to login
    //navigateTo('login')
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _goToLogin,
        ),
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.inventory_2,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Join Inventory Pro",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create your account to get started with smart inventory management",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: sp2xl),

              // Personal Information
              _buildSectionCard(
                "Personal Information",
                [
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
                  SizedBox(height: spSm),
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
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Phone Number",
                    value: phoneNumber,
                    hint: "Enter phone number",
                    validator: Validator.required,
                    onChanged: (value) {
                      phoneNumber = value;
                      setState(() {});
                    },
                  ),
                ],
              ),

              // Company Information
              _buildSectionCard(
                "Company Information",
                [
                  QTextField(
                    label: "Company Name",
                    value: companyName,
                    hint: "Enter company name",
                    validator: Validator.required,
                    onChanged: (value) {
                      companyName = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Job Title",
                    value: jobTitle,
                    hint: "Enter your job title",
                    validator: Validator.required,
                    onChanged: (value) {
                      jobTitle = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Company Size",
                    items: companySizeOptions,
                    value: companySize,
                    onChanged: (value, label) {
                      companySize = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Industry",
                    items: industryOptions,
                    value: industry,
                    onChanged: (value, label) {
                      industry = value;
                      setState(() {});
                    },
                  ),
                ],
              ),

              // Account Security
              _buildSectionCard(
                "Account Security",
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QTextField(
                        label: "Password",
                        value: password,
                        hint: "Create a strong password",
                        obscureText: obscurePassword,
                        validator: _validatePassword,
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
                              "Must contain: 8+ characters, uppercase, number",
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
                  SizedBox(height: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QTextField(
                        label: "Confirm Password",
                        value: confirmPassword,
                        hint: "Confirm your password",
                        obscureText: obscureConfirmPassword,
                        validator: _validateConfirmPassword,
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

              // Terms and Agreements
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terms & Agreements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Terms of Service
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: agreeTerms,
                          onChanged: (value) => setState(() => agreeTerms = value ?? false),
                          activeColor: primaryColor,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                              children: [
                                TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: " and understand my rights and obligations."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Privacy Policy
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: agreePrivacy,
                          onChanged: (value) => setState(() => agreePrivacy = value ?? false),
                          activeColor: primaryColor,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                              children: [
                                TextSpan(text: "I acknowledge the "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: " and consent to data processing."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Marketing Communications
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: agreeMarketing,
                          onChanged: (value) => setState(() => agreeMarketing = value ?? false),
                          activeColor: primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            "I would like to receive product updates, marketing communications, and newsletters (optional).",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Register Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Account",
                  size: bs.md,
                  onPressed: _register,
                ),
              ),

              SizedBox(height: spMd),

              // Login Link
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: _goToLogin,
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
              ),

              SizedBox(height: spMd),

              // Security Note
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: successColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your data is secure",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "We use enterprise-grade encryption and never share your personal information with third parties.",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),
            ],
          ),
        ),
      ),
    );
  }
}
