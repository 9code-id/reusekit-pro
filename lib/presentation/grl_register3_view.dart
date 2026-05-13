import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister3View extends StatefulWidget {
  @override
  State<GrlRegister3View> createState() => _GrlRegister3ViewState();
}

class _GrlRegister3ViewState extends State<GrlRegister3View> {
  final formKey = GlobalKey<FormState>();
  
  String selectedCountry = "";
  String selectedState = "";
  String selectedCity = "";
  String streetAddress = "";
  String postalCode = "";
  String profession = "";
  String company = "";
  String experience = "";
  List<String> interests = [];
  bool isLoading = false;

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "us"},
    {"label": "Canada", "value": "ca"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
    {"label": "France", "value": "fr"},
    {"label": "Japan", "value": "jp"},
    {"label": "South Korea", "value": "kr"},
    {"label": "Singapore", "value": "sg"},
    {"label": "Indonesia", "value": "id"},
  ];

  List<Map<String, dynamic>> states = [
    {"label": "California", "value": "ca"},
    {"label": "New York", "value": "ny"},
    {"label": "Texas", "value": "tx"},
    {"label": "Florida", "value": "fl"},
    {"label": "Washington", "value": "wa"},
    {"label": "Illinois", "value": "il"},
  ];

  List<Map<String, dynamic>> cities = [
    {"label": "Los Angeles", "value": "la"},
    {"label": "New York City", "value": "nyc"},
    {"label": "Chicago", "value": "chi"},
    {"label": "Houston", "value": "hou"},
    {"label": "Phoenix", "value": "phx"},
    {"label": "Philadelphia", "value": "phi"},
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Student", "value": "student"},
    {"label": "Entry Level (0-2 years)", "value": "entry"},
    {"label": "Mid Level (3-5 years)", "value": "mid"},
    {"label": "Senior Level (6-10 years)", "value": "senior"},
    {"label": "Expert Level (10+ years)", "value": "expert"},
    {"label": "Retired", "value": "retired"},
  ];

  List<Map<String, dynamic>> interestCategories = [
    {"label": "Technology", "value": "technology", "checked": false},
    {"label": "Sports", "value": "sports", "checked": false},
    {"label": "Music", "value": "music", "checked": false},
    {"label": "Travel", "value": "travel", "checked": false},
    {"label": "Cooking", "value": "cooking", "checked": false},
    {"label": "Reading", "value": "reading", "checked": false},
    {"label": "Photography", "value": "photography", "checked": false},
    {"label": "Gaming", "value": "gaming", "checked": false},
    {"label": "Art", "value": "art", "checked": false},
    {"label": "Fitness", "value": "fitness", "checked": false},
    {"label": "Fashion", "value": "fashion", "checked": false},
    {"label": "Business", "value": "business", "checked": false},
  ];

  Future<void> _completeRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isLoading = false;
    setState(() {});
    
    ss("Registration completed successfully! Welcome to our community!");
    //navigateTo('GrlDashboardView')
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Completing your registration...",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Setting up your profile and preferences",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Final Step"),
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
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check, color: Colors.white, size: 16),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check, color: Colors.white, size: 16),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Step 3 of 3: Location & Interests",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Location Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Location Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Country",
                      items: countries,
                      value: selectedCountry,
                      onChanged: (value, label) {
                        selectedCountry = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "State/Province",
                            items: states,
                            value: selectedState,
                            onChanged: (value, label) {
                              selectedState = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "City",
                            items: cities,
                            value: selectedCity,
                            onChanged: (value, label) {
                              selectedCity = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Street Address",
                      value: streetAddress,
                      hint: "Enter your street address",
                      onChanged: (value) {
                        streetAddress = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Postal Code",
                      value: postalCode,
                      hint: "Enter your postal code",
                      onChanged: (value) {
                        postalCode = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Professional Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Professional Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Profession/Job Title",
                      value: profession,
                      hint: "e.g., Software Engineer, Teacher, Doctor",
                      onChanged: (value) {
                        profession = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Company/Organization",
                      value: company,
                      hint: "Enter your company or organization",
                      onChanged: (value) {
                        company = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Experience Level",
                      items: experienceLevels,
                      value: experience,
                      onChanged: (value, label) {
                        experience = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Interests Section
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Your Interests",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "Select your interests to help us connect you with like-minded people",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: interestCategories,
                      value: interestCategories.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        interests = values.map((item) => item["value"].toString()).toList();
                        for (var category in interestCategories) {
                          category["checked"] = values.any((v) => v["value"] == category["value"]);
                        }
                        setState(() {});
                      },
                    ),

                    if (interests.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(40)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Great! You've selected ${interests.length} interest${interests.length > 1 ? 's' : ''}. This will help us personalize your experience.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Terms and Privacy Reminder
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Review Our Policies",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "By completing registration, you agree to our Terms of Service and Privacy Policy. You can review these documents anytime in your account settings.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Complete Registration",
                      size: bs.md,
                      onPressed: _completeRegistration,
                    ),
                  ),
                ],
              ),

              // Completion Message
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(40)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.celebration, color: successColor, size: 48),
                    SizedBox(height: spSm),
                    Text(
                      "You're Almost Done!",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Complete your registration to join our amazing community and start connecting with people who share your interests.",
                      textAlign: TextAlign.center,
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
      ),
    );
  }
}
