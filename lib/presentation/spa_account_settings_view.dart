import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaAccountSettingsView extends StatefulWidget {
  const SpaAccountSettingsView({super.key});

  @override
  State<SpaAccountSettingsView> createState() => _SpaAccountSettingsViewState();
}

class _SpaAccountSettingsViewState extends State<SpaAccountSettingsView> {
  String firstName = "Isabella";
  String lastName = "Rodriguez";
  String email = "isabella.rodriguez@email.com";
  String phone = "+1 (555) 123-4567";
  String dateOfBirth = "1990-03-15";
  String gender = "female";
  String profileImage = "https://picsum.photos/200/200?random=1&keyword=woman";
  
  String emergencyContactName = "Maria Rodriguez";
  String emergencyContactPhone = "+1 (555) 987-6543";
  String emergencyContactRelation = "mother";
  
  bool receiveNewsletters = true;
  bool shareDataForPersonalization = false;
  bool allowThirdPartyPromotions = false;
  
  String preferredLanguage = "english";
  String timezone = "est";
  String currency = "usd";
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Female", "value": "female"},
    {"label": "Male", "value": "male"},
    {"label": "Non-binary", "value": "non_binary"},
    {"label": "Prefer not to say", "value": "prefer_not_to_say"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "Eastern Standard Time (EST)", "value": "est"},
    {"label": "Central Standard Time (CST)", "value": "cst"},
    {"label": "Mountain Standard Time (MST)", "value": "mst"},
    {"label": "Pacific Standard Time (PST)", "value": "pst"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "usd"},
    {"label": "Euro (EUR)", "value": "eur"},
    {"label": "British Pound (GBP)", "value": "gbp"},
    {"label": "Canadian Dollar (CAD)", "value": "cad"},
  ];

  List<Map<String, dynamic>> relationOptions = [
    {"label": "Mother", "value": "mother"},
    {"label": "Father", "value": "father"},
    {"label": "Spouse", "value": "spouse"},
    {"label": "Partner", "value": "partner"},
    {"label": "Sibling", "value": "sibling"},
    {"label": "Friend", "value": "friend"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              _saveAccountSettings();
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
              _buildProfileHeader(),
              _buildPersonalInformation(),
              _buildContactInformation(),
              _buildEmergencyContact(),
              _buildPreferences(),
              _buildRegionalSettings(),
              _buildPrivacySettings(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ClipOval(
                  child: Image.network(
                    profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _changeProfileImage();
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: primaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "$firstName $lastName",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat("Member Since", "2022", Icons.calendar_today),
              _buildProfileStat("Visits", "24", Icons.spa),
              _buildProfileStat("Points", "1,250", Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withAlpha(180),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Row(
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
              SizedBox(width: spMd),
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
          
          QDatePicker(
            label: "Date of Birth",
            value: DateTime.parse(dateOfBirth),
            onChanged: (value) {
              dateOfBirth = value.toString().split(' ')[0];
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
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.contact_mail, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
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
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 18),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "We'll use this information to send appointment confirmations and important updates.",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.emergency, color: dangerColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Emergency Contact Name",
            value: emergencyContactName,
            validator: Validator.required,
            onChanged: (value) {
              emergencyContactName = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Emergency Contact Phone",
                  value: emergencyContactPhone,
                  validator: Validator.required,
                  onChanged: (value) {
                    emergencyContactPhone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Relationship",
                  items: relationOptions,
                  value: emergencyContactRelation,
                  onChanged: (value, label) {
                    emergencyContactRelation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Communication Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          QSwitch(
            items: [
              {
                "label": "Receive newsletters and spa updates",
                "value": true,
                "checked": receiveNewsletters,
              }
            ],
            value: [if (receiveNewsletters) {"label": "Receive newsletters and spa updates", "value": true, "checked": true}],
            onChanged: (values, ids) {
              receiveNewsletters = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Share data for personalized recommendations",
                "value": true,
                "checked": shareDataForPersonalization,
              }
            ],
            value: [if (shareDataForPersonalization) {"label": "Share data for personalized recommendations", "value": true, "checked": true}],
            onChanged: (values, ids) {
              shareDataForPersonalization = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Allow third-party promotional offers",
                "value": true,
                "checked": allowThirdPartyPromotions,
              }
            ],
            value: [if (allowThirdPartyPromotions) {"label": "Allow third-party promotional offers", "value": true, "checked": true}],
            onChanged: (values, ids) {
              allowThirdPartyPromotions = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Regional Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Preferred Language",
            items: languageOptions,
            value: preferredLanguage,
            onChanged: (value, label) {
              preferredLanguage = value;
              setState(() {});
            },
          ),
          
          QDropdownField(
            label: "Timezone",
            items: timezoneOptions,
            value: timezone,
            onChanged: (value, label) {
              timezone = value;
              setState(() {});
            },
          ),
          
          QDropdownField(
            label: "Currency",
            items: currencyOptions,
            value: currency,
            onChanged: (value, label) {
              currency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.privacy_tip, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Privacy & Data",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor, width: 1),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.security, color: warningColor, size: 18),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Data Protection & Privacy",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Your personal information is protected with industry-standard encryption. We never share your data without your explicit consent.",
                  style: TextStyle(
                    fontSize: 13,
                    color: warningColor,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Privacy Policy",
                        size: bs.sm,
                        onPressed: () {
                          _viewPrivacyPolicy();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Data Export",
                        size: bs.sm,
                        onPressed: () {
                          _exportUserData();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Account Settings",
            size: bs.md,
            onPressed: () {
              _saveAccountSettings();
            },
          ),
        ),
        
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reset to Default",
                size: bs.sm,
                onPressed: () {
                  _resetToDefaults();
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: "Deactivate Account",
                size: bs.sm,
                onPressed: () {
                  _showDeactivateDialog();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _changeProfileImage() {
    ss("Profile image change functionality");
    //navigateTo ( ProfileImagePickerView )
  }

  void _saveAccountSettings() {
    if (formKey.currentState!.validate()) {
      ss("Account settings saved successfully");
      //navigateTo ( previous view )
    }
  }

  void _resetToDefaults() {
    setState(() {
      receiveNewsletters = true;
      shareDataForPersonalization = false;
      allowThirdPartyPromotions = false;
      preferredLanguage = "english";
      timezone = "est";
      currency = "usd";
    });
    ss("Settings reset to defaults");
  }

  void _viewPrivacyPolicy() {
    ss("Opening privacy policy");
    //navigateTo ( PrivacyPolicyView )
  }

  void _exportUserData() {
    ss("Exporting user data");
    //navigateTo ( DataExportView )
  }

  void _showDeactivateDialog() {
    ss("Deactivate account dialog shown");
    //navigateTo ( AccountDeactivationView )
  }
}
