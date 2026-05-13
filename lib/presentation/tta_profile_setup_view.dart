import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaProfileSetupView extends StatefulWidget {
  const TtaProfileSetupView({super.key});

  @override
  State<TtaProfileSetupView> createState() => _TtaProfileSetupViewState();
}

class _TtaProfileSetupViewState extends State<TtaProfileSetupView> {
  String firstName = "";
  String lastName = "";
  String bio = "";
  String dateOfBirth = "";
  String selectedGender = "";
  String selectedCountry = "";
  String selectedCity = "";
  String profileImage = "";
  String phoneNumber = "";
  String website = "";
  
  bool loading = false;
  int currentStep = 0;

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "us"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Canada", "value": "ca"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
    {"label": "France", "value": "fr"},
    {"label": "Japan", "value": "jp"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Your Profile"),
        actions: [
          if (currentStep > 0)
            TextButton(
              onPressed: () {
                // Skip profile setup
                ss("Profile setup skipped");
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
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Step ${currentStep + 1} of 3",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${((currentStep + 1) / 3 * 100).round()}%",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: (currentStep + 1) / 3,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                  ],
                ),
              ),
              
              // Step Content
              if (currentStep == 0) _buildBasicInfoStep(),
              if (currentStep == 1) _buildPersonalDetailsStep(),
              if (currentStep == 2) _buildContactInfoStep(),
              
              SizedBox(height: spXl),
              
              // Navigation Buttons
              Row(
                spacing: spSm,
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        onPressed: () {
                          currentStep--;
                          setState(() {});
                        },
                      ),
                    ),
                  Expanded(
                    child: QButton(
                      label: currentStep == 2 
                        ? (loading ? "Saving..." : "Complete Setup")
                        : "Next",
                      size: bs.md,
                      onPressed: loading ? null : () async {
                        if (currentStep == 2) {
                          // Complete setup
                          if (formKey.currentState!.validate()) {
                            loading = true;
                            setState(() {});
                            
                            await Future.delayed(Duration(seconds: 2));
                            
                            loading = false;
                            setState(() {});
                            
                            ss("Profile setup completed!");
                            // Navigate to home
                          }
                        } else {
                          // Next step
                          if (_validateCurrentStep()) {
                            currentStep++;
                            setState(() {});
                          }
                        }
                      },
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

  Widget _buildBasicInfoStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Let's start with some basic information about you",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Profile Image
        Center(
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withAlpha(20),
                  border: Border.all(color: primaryColor, width: 2),
                ),
                child: profileImage.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 60,
                      color: primaryColor,
                    )
                  : ClipOval(
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
              SizedBox(height: spSm),
              GestureDetector(
                onTap: () {
                  // Pick profile image
                  profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
                  setState(() {});
                },
                child: Text(
                  profileImage.isEmpty ? "Add Photo" : "Change Photo",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
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
        
        QMemoField(
          label: "Bio (Optional)",
          value: bio,
          hint: "Tell us about yourself and your travel interests",
          onChanged: (value) {
            bio = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Details",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Help us personalize your travel experience",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
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
          value: selectedGender,
          onChanged: (value, label) {
            selectedGender = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Country",
          items: countryOptions,
          value: selectedCountry,
          onChanged: (value, label) {
            selectedCountry = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "City",
          value: selectedCity,
          hint: "Enter your city",
          onChanged: (value) {
            selectedCity = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildContactInfoStep() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Information",
          style: TextStyle(
            fontSize: fsH3,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Almost done! Add your contact details",
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
        
        QTextField(
          label: "Website (Optional)",
          value: website,
          hint: "Your personal website or blog",
          onChanged: (value) {
            website = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Privacy Protection",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "Your personal information is encrypted and secure. You can control what information is visible to other users in your privacy settings.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return firstName.isNotEmpty && lastName.isNotEmpty;
      case 1:
        return true; // Personal details are optional
      case 2:
        return phoneNumber.isNotEmpty;
      default:
        return true;
    }
  }
}
