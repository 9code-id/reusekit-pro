import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaProfileSetupView extends StatefulWidget {
  const ImaProfileSetupView({super.key});

  @override
  State<ImaProfileSetupView> createState() => _ImaProfileSetupViewState();
}

class _ImaProfileSetupViewState extends State<ImaProfileSetupView> {
  final formKey = GlobalKey<FormState>();
  
  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "john.doe@company.com";
  String phoneNumber = "";
  String profileImage = "";
  String jobTitle = "";
  String department = "";
  
  // Location Information
  String country = "";
  String state = "";
  String city = "";
  String timezone = "";
  
  // Preferences
  String language = "English";
  String dateFormat = "MM/DD/YYYY";
  String timeFormat = "12 Hour";
  String currency = "USD";
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  
  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "US"},
    {"label": "Canada", "value": "CA"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Australia", "value": "AU"},
    {"label": "Germany", "value": "DE"},
    {"label": "France", "value": "FR"},
    {"label": "Japan", "value": "JP"},
    {"label": "India", "value": "IN"},
  ];

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];

  List<Map<String, dynamic>> currencies = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "CAD - Canadian Dollar", "value": "CAD"},
    {"label": "AUD - Australian Dollar", "value": "AUD"},
    {"label": "JPY - Japanese Yen", "value": "JPY"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Your Profile"),
        actions: [
          GestureDetector(
            onTap: () {
              // navigateTo('CompanySetupView')
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              alignment: Alignment.center,
              child: Text(
                "Skip",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(
                          Icons.person_add,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Step 2 of 3: Personal Profile",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 2 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Picture Section
              Container(
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
                    Text(
                      "Profile Picture",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radius2xl),
                            border: Border.all(color: primaryColor.withAlpha(50)),
                          ),
                          child: profileImage.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                  color: primaryColor,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(radius2xl),
                                  child: Image.network(
                                    profileImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QButton(
                                label: "Upload Photo",
                                size: bs.sm,
                                onPressed: () {
                                  // Simulate image selection
                                  profileImage = "https://picsum.photos/200/200?random=1&keyword=person";
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Recommended: 200x200px, PNG or JPG",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
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
                      value: phoneNumber,
                      hint: "+1 (555) 123-4567",
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Job Title",
                            value: jobTitle,
                            hint: "e.g. Marketing Manager",
                            onChanged: (value) {
                              jobTitle = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Department",
                            value: department,
                            hint: "e.g. Marketing",
                            onChanged: (value) {
                              department = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Location Information
              Container(
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
                    Text(
                      "Location Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Country",
                      items: countries,
                      value: country,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        country = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "State/Province",
                            value: state,
                            hint: "e.g. California",
                            onChanged: (value) {
                              state = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: city,
                            hint: "e.g. San Francisco",
                            onChanged: (value) {
                              city = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Timezone",
                      value: timezone,
                      hint: "e.g. PST (UTC-8)",
                      onChanged: (value) {
                        timezone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Preferences
              Container(
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
                    Text(
                      "Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Language",
                            items: languages,
                            value: language,
                            onChanged: (value, label) {
                              language = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Currency",
                            items: currencies,
                            value: currency,
                            onChanged: (value, label) {
                              currency = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Date Format",
                            items: [
                              {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
                              {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
                              {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
                            ],
                            value: dateFormat,
                            onChanged: (value, label) {
                              dateFormat = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Time Format",
                            items: [
                              {"label": "12 Hour", "value": "12 Hour"},
                              {"label": "24 Hour", "value": "24 Hour"},
                            ],
                            value: timeFormat,
                            onChanged: (value, label) {
                              timeFormat = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Notification Preferences
              Container(
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
                    Text(
                      "Notification Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Email Notifications",
                          "value": "email",
                          "checked": emailNotifications,
                        }
                      ],
                      value: emailNotifications ? [{"label": "Email Notifications", "value": "email", "checked": true}] : [],
                      onChanged: (values, ids) {
                        emailNotifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Push Notifications",
                          "value": "push",
                          "checked": pushNotifications,
                        }
                      ],
                      value: pushNotifications ? [{"label": "Push Notifications", "value": "push", "checked": true}] : [],
                      onChanged: (values, ids) {
                        pushNotifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "SMS Notifications",
                          "value": "sms",
                          "checked": smsNotifications,
                        }
                      ],
                      value: smsNotifications ? [{"label": "SMS Notifications", "value": "sms", "checked": true}] : [],
                      onChanged: (values, ids) {
                        smsNotifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Security Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Privacy & Security",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your personal information is encrypted and stored securely. You can update or delete your profile at any time from account settings.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save & Continue",
                      size: bs.md,
                      onPressed: () {
                        _saveProfile();
                      },
                    ),
                  ),
                ],
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Skip for Now",
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo('CompanySetupView')
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (formKey.currentState!.validate()) {
      if (firstName.isEmpty || lastName.isEmpty) {
        se("Please fill in all required fields");
        return;
      }

      // Save profile data
      ss("Profile saved successfully!");
      // navigateTo('CompanySetupView')
    }
  }
}
