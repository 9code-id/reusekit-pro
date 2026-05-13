import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister2View extends StatefulWidget {
  @override
  State<GrlRegister2View> createState() => _GrlRegister2ViewState();
}

class _GrlRegister2ViewState extends State<GrlRegister2View> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String dateOfBirth = "";
  String selectedGender = "";
  String bio = "";
  String profileImage = "";
  bool isLoading = false;

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "not_specified"},
  ];

  Future<void> _continueRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    setState(() {});
    
    ss("Profile information saved successfully!");
    //navigateTo('GrlRegister3View')
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Your Profile"),
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
                            "2",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: disabledColor,
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
                      "Step 2 of 3: Personal Information",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Picture Section
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Profile Picture",
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
                      onChanged: (value) {
                        profileImage = value;
                        setState(() {});
                      },
                    ),

                    Text(
                      "Upload a clear photo of yourself. This helps others recognize you and builds trust in our community.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
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
                    
                    QDatePicker(
                      label: "Date of Birth",
                      value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now().subtract(Duration(days: 6570)),
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
                  ],
                ),
              ),

              // Bio Section
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
                    Text(
                      "About You",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QMemoField(
                      label: "Bio",
                      value: bio,
                      hint: "Tell us a little about yourself, your interests, and what you're looking for...",
                      onChanged: (value) {
                        bio = value;
                        setState(() {});
                      },
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(40)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "A good bio helps others connect with you. Share your hobbies, profession, or what makes you unique!",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
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
                      label: "Continue",
                      size: bs.md,
                      onPressed: _continueRegistration,
                    ),
                  ),
                ],
              ),

              // Privacy Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Privacy Protected",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Your personal information is encrypted and secure. We never share your data with third parties without your consent.",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                            ),
                          ),
                        ],
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
