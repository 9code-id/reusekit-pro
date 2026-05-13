import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaRegisterView extends StatefulWidget {
  const RhaRegisterView({super.key});

  @override
  State<RhaRegisterView> createState() => _RhaRegisterViewState();
}

class _RhaRegisterViewState extends State<RhaRegisterView> {
  final formKey = GlobalKey<FormState>();
  
  String fullName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String phoneNumber = "";
  String dateOfBirth = "";
  String gender = "";
  String bloodType = "";
  String address = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  String medicalConditions = "";
  String allergies = "";
  String currentMedications = "";
  String occupation = "";
  String workplace = "";
  String insuranceProvider = "";
  String insuranceNumber = "";
  bool agreeToTerms = false;
  bool subscribeToNewsletter = false;
  String profileImage = "";

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> bloodTypeOptions = [
    {"label": "A+", "value": "A+"},
    {"label": "A-", "value": "A-"},
    {"label": "B+", "value": "B+"},
    {"label": "B-", "value": "B-"},
    {"label": "AB+", "value": "AB+"},
    {"label": "AB-", "value": "AB-"},
    {"label": "O+", "value": "O+"},
    {"label": "O-", "value": "O-"},
  ];

  int currentStep = 0;
  List<String> stepTitles = [
    "Personal Information",
    "Contact Details",
    "Health Information",
    "Professional Details",
    "Insurance Information",
    "Review & Confirm"
  ];

  void _nextStep() {
    if (currentStep < stepTitles.length - 1) {
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _handleRegister() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the terms and conditions");
        return;
      }
      
      bool isConfirmed = await confirm("Are you sure you want to create this account?");
      if (isConfirmed) {
        showLoading();
        
        await Future.delayed(Duration(seconds: 2));
        
        hideLoading();
        ss("Account created successfully! Please check your email for verification.");
        
        // Navigate to login or dashboard
        // ss('Next page'));
      }
    }
  }

  Widget _buildPersonalInformation() {
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
        SizedBox(height: spSm),
        Text(
          "Please provide your basic personal details",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QImagePicker(
          label: "Profile Photo",
          value: profileImage,
          hint: "Upload your profile picture",
          onChanged: (value) {
            profileImage = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
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
        SizedBox(height: spSm),
        
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
        SizedBox(height: spSm),
        
        QDatePicker(
          label: "Date of Birth",
          value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now().subtract(Duration(days: 18 * 365)),
          onChanged: (value) {
            dateOfBirth = value.toIso8601String();
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QDropdownField(
          label: "Gender",
          items: genderOptions,
          value: gender,
          onChanged: (value, label) {
            gender = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildContactDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Provide your contact information and emergency contact",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
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
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Address",
          value: address,
          hint: "Enter your complete address",
          validator: Validator.required,
          onChanged: (value) {
            address = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        Text(
          "Emergency Contact",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Emergency Contact Name",
          value: emergencyContact,
          hint: "Enter emergency contact name",
          validator: Validator.required,
          onChanged: (value) {
            emergencyContact = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Emergency Contact Phone",
          value: emergencyPhone,
          hint: "Enter emergency contact phone number",
          validator: Validator.required,
          onChanged: (value) {
            emergencyPhone = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildHealthInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Health Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Provide your health-related information for better care",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QDropdownField(
          label: "Blood Type",
          items: bloodTypeOptions,
          value: bloodType,
          onChanged: (value, label) {
            bloodType = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Medical Conditions",
          value: medicalConditions,
          hint: "List any existing medical conditions (optional)",
          onChanged: (value) {
            medicalConditions = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Allergies",
          value: allergies,
          hint: "List any known allergies (optional)",
          onChanged: (value) {
            allergies = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Current Medications",
          value: currentMedications,
          hint: "List all medications you are currently taking (optional)",
          onChanged: (value) {
            currentMedications = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildProfessionalDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Professional Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Provide your professional information",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Occupation",
          value: occupation,
          hint: "Enter your occupation",
          onChanged: (value) {
            occupation = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Workplace",
          value: workplace,
          hint: "Enter your workplace or company name",
          onChanged: (value) {
            workplace = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildInsuranceInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Insurance Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Add your insurance details for easier billing",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Insurance Provider",
          value: insuranceProvider,
          hint: "Enter your insurance provider name",
          onChanged: (value) {
            insuranceProvider = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Insurance Number",
          value: insuranceNumber,
          hint: "Enter your insurance policy number",
          onChanged: (value) {
            insuranceNumber = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSecuritySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Security Settings",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Create a secure password for your account",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Password",
          value: password,
          hint: "Create a strong password",
          obscureText: true,
          validator: Validator.required,
          onChanged: (value) {
            password = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Confirm Password",
          value: confirmPassword,
          hint: "Re-enter your password",
          obscureText: true,
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
      ],
    );
  }

  Widget _buildReviewConfirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review & Confirm",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Please review your information before creating your account",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReviewItem("Full Name", fullName),
              _buildReviewItem("Email", email),
              _buildReviewItem("Phone", phoneNumber),
              _buildReviewItem("Gender", gender),
              _buildReviewItem("Blood Type", bloodType),
              _buildReviewItem("Emergency Contact", "$emergencyContact ($emergencyPhone)"),
              if (occupation.isNotEmpty) _buildReviewItem("Occupation", occupation),
              if (workplace.isNotEmpty) _buildReviewItem("Workplace", workplace),
              if (insuranceProvider.isNotEmpty) _buildReviewItem("Insurance", insuranceProvider),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        _buildSecuritySettings(),
        SizedBox(height: spMd),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the Terms of Service and Privacy Policy",
              "value": true,
              "checked": agreeToTerms,
            }
          ],
          value: [if (agreeToTerms) {"label": "I agree to the Terms of Service and Privacy Policy", "value": true, "checked": true}],
          onChanged: (values, ids) {
            agreeToTerms = values.isNotEmpty;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        
        QSwitch(
          items: [
            {
              "label": "Subscribe to newsletter and health tips",
              "value": true,
              "checked": subscribeToNewsletter,
            }
          ],
          value: [if (subscribeToNewsletter) {"label": "Subscribe to newsletter and health tips", "value": true, "checked": true}],
          onChanged: (values, ids) {
            subscribeToNewsletter = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value) {
    if (value.isEmpty) return SizedBox.shrink();
    
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInformation();
      case 1:
        return _buildContactDetails();
      case 2:
        return _buildHealthInformation();
      case 3:
        return _buildProfessionalDetails();
      case 4:
        return _buildInsuranceInformation();
      case 5:
        return _buildReviewConfirm();
      default:
        return _buildPersonalInformation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Step ${currentStep + 1} of ${stepTitles.length}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${(((currentStep + 1) / stepTitles.length) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (currentStep + 1) / stepTitles.length,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      stepTitles[currentStep],
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              
              // Step Content
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: _buildStepContent(),
              ),
              SizedBox(height: spMd),
              
              // Navigation Buttons
              Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        color: disabledBoldColor,
                        size: bs.md,
                        onPressed: _previousStep,
                      ),
                    ),
                  if (currentStep > 0) SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: currentStep == stepTitles.length - 1 ? "Create Account" : "Next",
                      size: bs.md,
                      onPressed: currentStep == stepTitles.length - 1 ? _handleRegister : _nextStep,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              // Login Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to login
                    // ss('Next page'));
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
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
            ],
          ),
        ),
      ),
    );
  }
}
