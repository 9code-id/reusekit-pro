import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaAgeVerificationView extends StatefulWidget {
  const GeaAgeVerificationView({super.key});

  @override
  State<GeaAgeVerificationView> createState() => _GeaAgeVerificationViewState();
}

class _GeaAgeVerificationViewState extends State<GeaAgeVerificationView> {
  final formKey = GlobalKey<FormState>();
  String birthDate = "";
  String parentEmail = "";
  String parentName = "";
  bool isUnder13 = false;
  bool parentConsent = false;

  List<Map<String, dynamic>> ageCategories = [
    {
      "range": "Under 13",
      "description": "Requires parental consent and supervision",
      "features": ["Limited content access", "Parental controls active", "Safe communication only"],
      "color": Colors.orange,
    },
    {
      "range": "13-17",
      "description": "Teen gaming with safety features",
      "features": ["Moderated content", "Limited social features", "Time restrictions available"],
      "color": Colors.blue,
    },
    {
      "range": "18+",
      "description": "Full access to all content and features",
      "features": ["Unrestricted content", "All social features", "No time limits"],
      "color": Colors.green,
    },
  ];

  void _calculateAge() {
    if (birthDate.isNotEmpty) {
      final birth = DateTime.parse(birthDate);
      final today = DateTime.now();
      final age = today.year - birth.year;
      
      if (age < 13) {
        isUnder13 = true;
      } else {
        isUnder13 = false;
        parentConsent = false;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Age Verification Required",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "To ensure a safe gaming environment, we need to verify your age. This helps us provide age-appropriate content and features.",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Date of Birth
              Text(
                "Enter Your Date of Birth",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDatePicker(
                label: "Date of Birth",
                value: birthDate.isNotEmpty ? DateTime.parse(birthDate) : DateTime.now(),
                onChanged: (value) {
                  birthDate = value.toString().split(' ')[0];
                  _calculateAge();
                },
              ),

              // Age Categories Information
              Text(
                "Age Categories & Features",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...ageCategories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: category["color"].withAlpha(100)),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: category["color"],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${category["range"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${category["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Column(
                        children: (category["features"] as List<String>).map((feature) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: category["color"],
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }),

              // Parental Consent Section (if under 13)
              if (isUnder13) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Parental Consent Required",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Since you are under 13, we need your parent or guardian's permission to create your account.",
                        style: TextStyle(
                          fontSize: 14,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  "Parent/Guardian Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QTextField(
                  label: "Parent/Guardian Full Name",
                  value: parentName,
                  validator: isUnder13 ? Validator.required : null,
                  onChanged: (value) {
                    parentName = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Parent/Guardian Email",
                  value: parentEmail,
                  validator: isUnder13 ? Validator.email : null,
                  onChanged: (value) {
                    parentEmail = value;
                    setState(() {});
                  },
                ),

                QSwitch(
                  items: [
                    {
                      "label": "I confirm that I am the parent/guardian and give permission for this account",
                      "value": true,
                      "checked": parentConsent,
                    }
                  ],
                  value: [
                    if (parentConsent)
                      {
                        "label": "I confirm that I am the parent/guardian and give permission for this account",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      parentConsent = values.isNotEmpty;
                    });
                  },
                ),
              ],

              // Privacy & Safety Notice
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Privacy & Safety",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: [
                        _buildSafetyItem("Your age information is used only for content filtering"),
                        _buildSafetyItem("We comply with COPPA regulations for child safety"),
                        _buildSafetyItem("Parental controls can be managed at any time"),
                        _buildSafetyItem("All data is encrypted and stored securely"),
                      ],
                    ),
                  ],
                ),
              ),

              // Terms Notice
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Text(
                  "By proceeding, you acknowledge that the age information provided is accurate and agree to our Terms of Service and Privacy Policy.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),

              // Continue Button
              QButton(
                label: "Verify Age & Continue",
                size: bs.md,
                onPressed: (birthDate.isNotEmpty && (!isUnder13 || (parentConsent && parentEmail.isNotEmpty && parentName.isNotEmpty))) ? () {
                  if (formKey.currentState!.validate()) {
                    //proceedWithAgeVerification()
                  }
                } : null,
              ),

              // Help Section
              Center(
                child: Column(
                  children: [
                    Text(
                      "Need help with age verification?",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    GestureDetector(
                      onTap: () {
                        //navigateTo('HelpView', arguments: 'age-verification')
                      },
                      child: Text(
                        "Contact Support",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildSafetyItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.security,
            color: infoColor,
            size: 14,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
