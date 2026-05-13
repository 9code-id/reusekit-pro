import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaProfileSetupView extends StatefulWidget {
  const DlaProfileSetupView({super.key});

  @override
  State<DlaProfileSetupView> createState() => _DlaProfileSetupViewState();
}

class _DlaProfileSetupViewState extends State<DlaProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  
  String profileImage = "";
  String firstName = "";
  String lastName = "";
  String dateOfBirth = "";
  String gender = "";
  String address = "";
  String city = "";
  String postalCode = "";
  String emergencyContactName = "";
  String emergencyContactPhone = "";
  
  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile"),
        actions: [
          TextButton(
            onPressed: () {
              // Skip profile setup
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_add,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Step 1 of 2",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Profile Image Section
              Text(
                "Profile Photo",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QImagePicker(
                label: "Profile Photo",
                value: profileImage,
                hint: "Upload your profile picture",
                validator: Validator.required,
                onChanged: (value) {
                  profileImage = value;
                  setState(() {});
                },
              ),
              
              // Personal Information Section
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
              
              QDatePicker(
                label: "Date of Birth",
                value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                onChanged: (value) {
                  dateOfBirth = value.toString();
                  setState(() {});
                },
              ),
              
              QDropdownField(
                label: "Gender",
                items: genderOptions,
                value: gender,
                onChanged: (value, label) {
                  gender = value;
                  setState(() {});
                },
              ),
              
              // Address Section
              Text(
                "Address Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Street Address",
                value: address,
                hint: "Enter your street address",
                validator: Validator.required,
                onChanged: (value) {
                  address = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "City",
                      value: city,
                      hint: "Enter city",
                      validator: Validator.required,
                      onChanged: (value) {
                        city = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Postal Code",
                      value: postalCode,
                      hint: "12345",
                      validator: Validator.required,
                      onChanged: (value) {
                        postalCode = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              // Emergency Contact Section
              Text(
                "Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Emergency Contact Name",
                value: emergencyContactName,
                hint: "Full name of emergency contact",
                validator: Validator.required,
                onChanged: (value) {
                  emergencyContactName = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Emergency Contact Phone",
                value: emergencyContactPhone,
                hint: "Phone number of emergency contact",
                validator: Validator.required,
                onChanged: (value) {
                  emergencyContactPhone = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              // Information Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "This information helps us provide better service and ensures your safety during deliveries.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Continue Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue to Vehicle Setup",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Handle profile completion
                      ss("Profile information saved!");
                      // Navigate to vehicle setup
                    }
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Save as Draft
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Save as draft
                    ss("Profile saved as draft");
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    side: BorderSide(color: primaryColor),
                  ),
                  child: Text(
                    "Save as Draft",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
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
