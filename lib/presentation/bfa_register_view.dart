import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaRegisterView extends StatefulWidget {
  const BfaRegisterView({super.key});

  @override
  State<BfaRegisterView> createState() => _BfaRegisterViewState();
}

class _BfaRegisterViewState extends State<BfaRegisterView> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String mobileNumber = "";
  String dateOfBirth = "";
  String panNumber = "";
  String aadharNumber = "";
  String password = "";
  String confirmPassword = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool agreeToPrivacy = false;
  bool subscribeNewsletter = false;
  bool loading = false;
  int currentStep = 0;

  List<Map<String, dynamic>> accountTypes = [
    {
      "title": "Savings Account",
      "description": "For personal banking and savings",
      "icon": Icons.savings,
      "color": primaryColor,
      "value": "savings",
    },
    {
      "title": "Current Account", 
      "description": "For business and frequent transactions",
      "icon": Icons.business,
      "color": successColor,
      "value": "current",
    },
    {
      "title": "Salary Account",
      "description": "For salaried professionals",
      "icon": Icons.work,
      "color": infoColor,
      "value": "salary",
    },
  ];

  String selectedAccountType = "savings";

  void _nextStep() {
    if (currentStep == 0) {
      if (fullName.isEmpty || email.isEmpty || mobileNumber.isEmpty) {
        se("Please fill all required fields");
        return;
      }
    } else if (currentStep == 1) {
      if (dateOfBirth.isEmpty || panNumber.isEmpty || aadharNumber.isEmpty) {
        se("Please complete your identity verification");
        return;
      }
    } else if (currentStep == 2) {
      if (password.isEmpty || confirmPassword.isEmpty) {
        se("Please set your password");
        return;
      }
      if (password != confirmPassword) {
        se("Passwords do not match");
        return;
      }
      if (!agreeToTerms || !agreeToPrivacy) {
        se("Please agree to Terms & Conditions and Privacy Policy");
        return;
      }
    }

    if (currentStep < 2) {
      currentStep++;
      setState(() {});
    } else {
      _submitRegistration();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  Future<void> _submitRegistration() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    setState(() {});

    ss("Registration successful! Please verify your email and mobile number");
    // navigateTo(BfaKycVerificationView());
  }

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(3, (index) {
        bool isActive = index <= currentStep;
        bool isCurrent = index == currentStep;
        
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: spXs),
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : disabledColor,
                    shape: BoxShape.circle,
                    border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  index == 0 ? "Personal" : index == 1 ? "Identity" : "Security",
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? primaryColor : disabledBoldColor,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Enter your basic details to create your account",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        QTextField(
          label: "Full Name",
          value: fullName,
          validator: Validator.required,
          hint: "Enter your full name as per ID",
          onChanged: (value) {
            fullName = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Email Address",
          value: email,
          validator: Validator.email,
          hint: "Enter your email address",
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Mobile Number",
          value: mobileNumber,
          validator: Validator.required,
          hint: "Enter 10-digit mobile number",
          onChanged: (value) {
            mobileNumber = value;
            setState(() {});
          },
        ),

        SizedBox(height: spXl),

        Text(
          "Account Type",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),

        SizedBox(height: spMd),

        ...accountTypes.map((type) {
          bool isSelected = selectedAccountType == type["value"];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: GestureDetector(
              onTap: () {
                selectedAccountType = type["value"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? (type["color"] as Color).withAlpha(10) : Colors.white,
                  border: Border.all(
                    color: isSelected ? (type["color"] as Color) : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: type["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        type["icon"] as IconData,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${type["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${type["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: type["color"] as Color,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildIdentityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Identity Verification",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Provide your identity details for KYC verification",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        QDatePicker(
          label: "Date of Birth",
          value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
          onChanged: (value) {
            dateOfBirth = value.toString();
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "PAN Number",
          value: panNumber,
          validator: Validator.required,
          hint: "Enter 10-digit PAN number",
          onChanged: (value) {
            panNumber = value.toUpperCase();
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Aadhar Number",
          value: aadharNumber,
          validator: Validator.required,
          hint: "Enter 12-digit Aadhar number",
          onChanged: (value) {
            aadharNumber = value;
            setState(() {});
          },
        ),

        SizedBox(height: spXl),

        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Secure & Confidential",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Your documents are encrypted and stored securely as per banking regulations.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecuritySetup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Security Setup",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "Create a strong password to secure your account",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXl),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QTextField(
              label: "Password",
              value: password,
              validator: Validator.required,
              hint: "Create a strong password",
              obscureText: obscurePassword,
              onChanged: (value) {
                password = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
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
                    fontSize: 14,
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
              validator: Validator.required,
              hint: "Re-enter your password",
              obscureText: obscureConfirmPassword,
              onChanged: (value) {
                confirmPassword = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: spXl),

        // Terms & Conditions
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              child: Checkbox(
                value: agreeToTerms,
                onChanged: (value) {
                  agreeToTerms = value ?? false;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  agreeToTerms = !agreeToTerms;
                  setState(() {});
                },
                child: Text.rich(
                  TextSpan(
                    text: "I agree to the ",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                    children: [
                      TextSpan(
                        text: "Terms & Conditions",
                        style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              child: Checkbox(
                value: agreeToPrivacy,
                onChanged: (value) {
                  agreeToPrivacy = value ?? false;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  agreeToPrivacy = !agreeToPrivacy;
                  setState(() {});
                },
                child: Text.rich(
                  TextSpan(
                    text: "I agree to the ",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                    children: [
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              child: Checkbox(
                value: subscribeNewsletter,
                onChanged: (value) {
                  subscribeNewsletter = value ?? false;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "Subscribe to newsletters and promotional offers",
                style: TextStyle(fontSize: 14, color: primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (currentStep > 0) {
              _previousStep();
            } else {
              back();
            }
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Step Indicator
            Container(
              padding: EdgeInsets.all(spLg),
              child: _buildStepIndicator(),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    if (currentStep == 0) _buildPersonalInfo(),
                    if (currentStep == 1) _buildIdentityInfo(),
                    if (currentStep == 2) _buildSecuritySetup(),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(spLg),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        color: disabledColor,
                        onPressed: _previousStep,
                      ),
                    ),

                  if (currentStep > 0)
                    SizedBox(width: spMd),

                  Expanded(
                    child: QButton(
                      label: loading 
                          ? "Creating Account..." 
                          : currentStep == 2 
                              ? "Create Account" 
                              : "Next",
                      size: bs.md,
                      onPressed: loading ? null : _nextStep,
                    ),
                  ),
                ],
              ),
            ),

            // Login Link
            Container(
              padding: EdgeInsets.only(bottom: spLg),
              child: Row(
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
                      // navigateTo(BfaLoginView());
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
            ),
          ],
        ),
      ),
    );
  }
}
