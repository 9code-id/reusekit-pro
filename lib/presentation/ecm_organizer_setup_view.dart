import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmOrganizerSetupView extends StatefulWidget {
  const EcmOrganizerSetupView({super.key});

  @override
  State<EcmOrganizerSetupView> createState() => _EcmOrganizerSetupViewState();
}

class _EcmOrganizerSetupViewState extends State<EcmOrganizerSetupView> {
  final formKey = GlobalKey<FormState>();
  String organizationType = "";
  String businessDescription = "";
  String website = "";
  String socialMediaHandle = "";
  String address = "";
  String city = "";
  String country = "";
  String postalCode = "";
  List<String> eventTypes = [];
  String experience = "";
  String teamSize = "";
  String profileImage = "";
  
  List<Map<String, dynamic>> organizationTypes = [
    {"label": "Corporate Events", "value": "corporate"},
    {"label": "Wedding Planning", "value": "wedding"},
    {"label": "Conference & Seminars", "value": "conference"},
    {"label": "Entertainment & Shows", "value": "entertainment"},
    {"label": "Sports Events", "value": "sports"},
    {"label": "Non-Profit Events", "value": "nonprofit"},
    {"label": "Educational Events", "value": "education"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Just Starting (0-1 years)", "value": "beginner"},
    {"label": "Some Experience (2-3 years)", "value": "intermediate"},
    {"label": "Experienced (4-6 years)", "value": "experienced"},
    {"label": "Expert (7+ years)", "value": "expert"},
  ];
  
  List<Map<String, dynamic>> teamSizes = [
    {"label": "Solo (Just me)", "value": "solo"},
    {"label": "Small Team (2-5 people)", "value": "small"},
    {"label": "Medium Team (6-15 people)", "value": "medium"},
    {"label": "Large Team (16+ people)", "value": "large"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup Your Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(60),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(60),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.business,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Step 2 of 3: Organization Setup",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            
            Text(
              "Organization Profile",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Tell us more about your organization and event management experience",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spLg),
            
            // Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  QImagePicker(
                    label: "Organization Logo",
                    value: profileImage,
                    hint: "Upload your organization logo",
                    onChanged: (value) {
                      profileImage = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Primary Organization Type",
                    items: organizationTypes,
                    value: organizationType,
                    onChanged: (value, label) {
                      organizationType = value;
                      setState(() {});
                    },
                  ),
                  
                  QMemoField(
                    label: "Business Description",
                    value: businessDescription,
                    hint: "Describe your organization and the types of events you specialize in",
                    validator: Validator.required,
                    onChanged: (value) {
                      businessDescription = value;
                      setState(() {});
                    },
                  ),
                  
                  QTextField(
                    label: "Website URL",
                    value: website,
                    hint: "https://yourwebsite.com",
                    onChanged: (value) {
                      website = value;
                      setState(() {});
                    },
                  ),
                  
                  QTextField(
                    label: "Social Media Handle",
                    value: socialMediaHandle,
                    hint: "@yourbusiness",
                    onChanged: (value) {
                      socialMediaHandle = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Years of Experience",
                    items: experienceLevels,
                    value: experience,
                    onChanged: (value, label) {
                      experience = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Team Size",
                    items: teamSizes,
                    value: teamSize,
                    onChanged: (value, label) {
                      teamSize = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            
            Text(
              "Business Address",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Column(
              spacing: spMd,
              children: [
                QTextField(
                  label: "Street Address",
                  value: address,
                  hint: "Enter your business address",
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
                        hint: "City",
                        validator: Validator.required,
                        onChanged: (value) {
                          city = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTextField(
                        label: "Postal Code",
                        value: postalCode,
                        hint: "Postal Code",
                        onChanged: (value) {
                          postalCode = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                QTextField(
                  label: "Country",
                  value: country,
                  hint: "Enter your country",
                  validator: Validator.required,
                  onChanged: (value) {
                    country = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: sp2xl),
            
            // Action buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    child: QButton(
                      label: "Skip for Now",
                      size: bs.md,
                      onPressed: () {
                        // ss('Next page'));
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: QButton(
                      label: "Continue",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Profile setup completed!");
                          // ss('Next page'));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
