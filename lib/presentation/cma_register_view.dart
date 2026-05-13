import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRegisterView extends StatefulWidget {
  const CmaRegisterView({super.key});

  @override
  State<CmaRegisterView> createState() => _CmaRegisterViewState();
}

class _CmaRegisterViewState extends State<CmaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  String companyName = "";
  String jobTitle = "";
  bool acceptTerms = false;
  bool receiveUpdates = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String selectedAccountType = "Individual";
  List<Map<String, dynamic>> accountTypeItems = [
    {"label": "Individual Contractor", "value": "Individual"},
    {"label": "Construction Company", "value": "Company"},
    {"label": "Project Manager", "value": "Manager"},
    {"label": "Architect/Engineer", "value": "Professional"},
  ];

  void _register() async {
    if (!acceptTerms) {
      se("Please accept the terms and conditions to continue");
      return;
    }

    if (formKey.currentState!.validate()) {
      if (password != confirmPassword) {
        se("Passwords do not match");
        return;
      }

      showLoading();
      
      // Simulate registration process
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      
      ss("Registration successful! Please check your email for verification.");
      // ss('Next page'));
    }
  }

  void _socialRegister(String platform) async {
    showLoading();
    
    // Simulate social registration
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("$platform registration initiated");
  }

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
            spacing: spMd,
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
                    SizedBox(height: spSm),
                    Text(
                      "Join CMA Business",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Create your construction management account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Account Type Selection
              QDropdownField(
                label: "Account Type",
                items: accountTypeItems,
                value: selectedAccountType,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedAccountType = value;
                  setState(() {});
                },
              ),

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
                hint: "Enter phone number",
                validator: Validator.required,
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),

              // Professional Information
              Text(
                "Professional Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              if (selectedAccountType == "Company" || selectedAccountType == "Manager")
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

              QTextField(
                label: "Job Title/Position",
                value: jobTitle,
                hint: "Enter your job title",
                validator: Validator.required,
                onChanged: (value) {
                  jobTitle = value;
                  setState(() {});
                },
              ),

              // Password Section
              Text(
                "Security",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
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

              // Password Requirements
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(30)),
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
                    SizedBox(height: spXs),
                    Text(
                      "• At least 8 characters long\n• Include uppercase and lowercase letters\n• Include at least one number\n• Include at least one special character",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Terms and Preferences
              QSwitch(
                items: [
                  {
                    "label": "I accept the Terms of Service and Privacy Policy",
                    "value": true,
                    "checked": acceptTerms,
                  }
                ],
                value: [
                  if (acceptTerms)
                    {
                      "label": "I accept the Terms of Service and Privacy Policy",
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

              QSwitch(
                items: [
                  {
                    "label": "Send me product updates and construction industry news",
                    "value": true,
                    "checked": receiveUpdates,
                  }
                ],
                value: [
                  if (receiveUpdates)
                    {
                      "label": "Send me product updates and construction industry news",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    receiveUpdates = values.isNotEmpty;
                  });
                },
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
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    child: Text(
                      "Or register with",
                      style: TextStyle(
                        fontSize: 12,
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

              SizedBox(height: spMd),

              // Social Registration
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: InkWell(
                        onTap: () => _socialRegister("Google"),
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.g_mobiledata, size: 24, color: dangerColor),
                            SizedBox(width: spXs),
                            Text(
                              "Google",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: InkWell(
                        onTap: () => _socialRegister("Microsoft"),
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.business, size: 24, color: infoColor),
                            SizedBox(width: spXs),
                            Text(
                              "Microsoft",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),

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
                        "Sign In Here",
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

              SizedBox(height: spMd),
            ],
          ),
        ),
      ),
    );
  }
}
