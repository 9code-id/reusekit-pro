import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForm1View extends StatefulWidget {
  const GrlForm1View({Key? key}) : super(key: key);

  @override
  State<GrlForm1View> createState() => _GrlForm1ViewState();
}

class _GrlForm1ViewState extends State<GrlForm1View> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String birthDate = "";
  String gender = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "";
  String profileImage = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  String profession = "";
  String company = "";
  List<String> interests = [];
  String bio = "";
  bool agreeTerms = false;
  bool marketingConsent = false;
  bool loading = false;

  List<Map<String, dynamic>> genderItems = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "prefer_not_to_say"},
  ];

  List<Map<String, dynamic>> countryItems = [
    {"label": "United States", "value": "us"},
    {"label": "Canada", "value": "ca"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
    {"label": "France", "value": "fr"},
    {"label": "Japan", "value": "jp"},
    {"label": "Indonesia", "value": "id"},
  ];

  List<Map<String, dynamic>> interestItems = [
    {"label": "Technology", "value": "technology", "checked": false},
    {"label": "Sports", "value": "sports", "checked": false},
    {"label": "Music", "value": "music", "checked": false},
    {"label": "Travel", "value": "travel", "checked": false},
    {"label": "Cooking", "value": "cooking", "checked": false},
    {"label": "Reading", "value": "reading", "checked": false},
    {"label": "Photography", "value": "photography", "checked": false},
    {"label": "Art", "value": "art", "checked": false},
  ];

  void _submitForm() async {
    if (!formKey.currentState!.validate()) return;
    if (!agreeTerms) {
      se("Please agree to the terms and conditions");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Profile created successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Profile Image Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Profile Photo",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
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

              // Personal Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor.withAlpha(20), successColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.badge, color: successColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "First Name",
                            value: firstName,
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
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Birth Date",
                            value: birthDate.isNotEmpty ? DateTime.parse(birthDate) : DateTime.now().subtract(Duration(days: 365 * 25)),
                            onChanged: (value) {
                              birthDate = "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Gender",
                            items: genderItems,
                            value: gender,
                            onChanged: (value, label) {
                              gender = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Address Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [infoColor.withAlpha(20), infoColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: infoColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Address Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Street Address",
                      value: address,
                      validator: Validator.required,
                      onChanged: (value) {
                        address = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: city,
                            validator: Validator.required,
                            onChanged: (value) {
                              city = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "State/Province",
                            value: state,
                            validator: Validator.required,
                            onChanged: (value) {
                              state = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "ZIP/Postal Code",
                            value: zipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              zipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Country",
                            items: countryItems,
                            value: country,
                            validator: Validator.required, 
                            onChanged: (value, label) {
                              country = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Emergency Contact Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [warningColor.withAlpha(20), warningColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emergency, color: warningColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Emergency Contact",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Emergency Contact Name",
                      value: emergencyContact,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContact = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Emergency Contact Phone",
                      value: emergencyPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyPhone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Professional Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [secondaryColor.withAlpha(20), secondaryColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: secondaryColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work, color: secondaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Professional Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Profession/Job Title",
                      value: profession,
                      onChanged: (value) {
                        profession = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Company/Organization",
                      value: company,
                      onChanged: (value) {
                        company = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Interests & Preferences Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [dangerColor.withAlpha(20), dangerColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: dangerColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.interests, color: dangerColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Interests & Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      label: "Select Your Interests",
                      items: interestItems,
                      value: interestItems.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        for (var item in interestItems) {
                          item["checked"] = values.any((v) => v["value"] == item["value"]);
                        }
                        interests = values.map((v) => v["value"] as String).toList();
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Bio/About Me",
                      value: bio,
                      hint: "Tell us about yourself...",
                      onChanged: (value) {
                        bio = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Terms & Consent Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gavel, color: disabledBoldColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Terms & Consent",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "I agree to the Terms and Conditions",
                          "value": "terms",
                          "checked": agreeTerms,
                        }
                      ],
                      value: agreeTerms ? [{"label": "I agree to the Terms and Conditions", "value": "terms", "checked": true}] : [],
                      onChanged: (values, ids) {
                        agreeTerms = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "I consent to receive marketing communications",
                          "value": "marketing",
                          "checked": marketingConsent,
                        }
                      ],
                      value: marketingConsent ? [{"label": "I consent to receive marketing communications", "value": "marketing", "checked": true}] : [],
                      onChanged: (values, ids) {
                        marketingConsent = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : QButton(
                        label: "Create Profile",
                        size: bs.md,
                        onPressed: _submitForm,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
