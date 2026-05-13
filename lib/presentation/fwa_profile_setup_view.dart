import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaProfileSetupView extends StatefulWidget {
  const FwaProfileSetupView({super.key});

  @override
  State<FwaProfileSetupView> createState() => _FwaProfileSetupViewState();
}

class _FwaProfileSetupViewState extends State<FwaProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  String profileImage = "";
  String displayName = "";
  String bio = "";
  String dateOfBirth = "";
  String gender = "";
  String location = "";
  String phoneNumber = "";
  bool isPublicProfile = true;
  bool enableNotifications = true;
  bool loading = false;

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];

  Future<void> _handleSaveProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Profile setup completed successfully!");
    // navigateTo(FwaFitnessGoalsView());
  }

  Future<void> _handleSkip() async {
    bool isConfirmed = await confirm("Skip profile setup? You can complete it later in settings.");
    if (isConfirmed) {
      // navigateTo(FwaFitnessGoalsView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: _handleSkip,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Title Section
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Complete Your Profile",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Help others get to know you better",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spXl),

                // Profile Image Section
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      QImagePicker(
                        label: "Profile Picture",
                        value: profileImage,
                        hint: "Upload your profile photo",
                        onChanged: (value) {
                          profileImage = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Form Fields
                Column(
                  spacing: spMd,
                  children: [
                    // Display Name
                    QTextField(
                      label: "Display Name",
                      value: displayName,
                      hint: "How should others see your name?",
                      validator: Validator.required,
                      onChanged: (value) {
                        displayName = value;
                        setState(() {});
                      },
                    ),

                    // Bio
                    QMemoField(
                      label: "Bio",
                      value: bio,
                      hint: "Tell us about yourself and your fitness journey",
                      onChanged: (value) {
                        bio = value;
                        setState(() {});
                      },
                    ),

                    // Date of Birth
                    QDatePicker(
                      label: "Date of Birth",
                      value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                      onChanged: (value) {
                        dateOfBirth = value.toIso8601String();
                        setState(() {});
                      },
                    ),

                    // Gender
                    QDropdownField(
                      label: "Gender",
                      items: genderOptions,
                      value: gender,
                      onChanged: (value, label) {
                        gender = value;
                        setState(() {});
                      },
                    ),

                    // Location
                    QTextField(
                      label: "Location",
                      value: location,
                      hint: "City, Country",
                      onChanged: (value) {
                        location = value;
                        setState(() {});
                      },
                    ),

                    // Phone Number
                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      hint: "Your contact number",
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                SizedBox(height: spLg),

                // Privacy Settings
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy & Notifications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Public Profile Toggle
                      QSwitch(
                        items: [
                          {
                            "label": "Make my profile public",
                            "value": true,
                            "checked": isPublicProfile,
                          }
                        ],
                        value: [
                          if (isPublicProfile)
                            {
                              "label": "Make my profile public",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isPublicProfile = values.isNotEmpty;
                          setState(() {});
                        },
                      ),

                      SizedBox(height: spSm),

                      // Notifications Toggle
                      QSwitch(
                        items: [
                          {
                            "label": "Enable push notifications",
                            "value": true,
                            "checked": enableNotifications,
                          }
                        ],
                        value: [
                          if (enableNotifications)
                            {
                              "label": "Enable push notifications",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          enableNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                // Profile Preview Section
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Preview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      SizedBox(height: spMd),

                      Row(
                        children: [
                          // Profile Image Preview
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(color: primaryColor, width: 2),
                            ),
                            child: profileImage.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    child: Image.network(
                                      profileImage,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    color: primaryColor,
                                    size: 30,
                                  ),
                          ),

                          SizedBox(width: spMd),

                          // Profile Info Preview
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName.isNotEmpty ? displayName : "Your Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (location.isNotEmpty) ...[
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        location,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (bio.isNotEmpty) ...[
                                  SizedBox(height: spXs),
                                  Text(
                                    bio,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spXl),

                // Action Buttons
                Column(
                  spacing: spSm,
                  children: [
                    // Complete Setup Button
                    Container(
                      width: double.infinity,
                      child: loading
                          ? Container(
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : QButton(
                              label: "Complete Setup",
                              size: bs.md,
                              onPressed: _handleSaveProfile,
                            ),
                    ),

                    // Skip Button
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: _handleSkip,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Text(
                            "Skip for Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
