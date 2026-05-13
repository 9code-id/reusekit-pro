import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaContactInfoView extends StatefulWidget {
  const BfaContactInfoView({super.key});

  @override
  State<BfaContactInfoView> createState() => _BfaContactInfoViewState();
}

class _BfaContactInfoViewState extends State<BfaContactInfoView> {
  final formKey = GlobalKey<FormState>();
  
  String primaryEmail = "john.doe@email.com";
  String secondaryEmail = "";
  String homePhone = "+1 (555) 123-4567";
  String mobilePhone = "+1 (555) 987-6543";
  String workPhone = "";
  
  String homeAddress = "123 Main Street";
  String homeCity = "New York";
  String homeState = "New York";
  String homeZipCode = "10001";
  String homeCountry = "United States";
  
  String mailingAddress = "";
  String mailingCity = "";
  String mailingState = "";
  String mailingZipCode = "";
  String mailingCountry = "United States";
  bool sameAsHome = true;
  
  String emergencyContactName = "Jane Doe";
  String emergencyContactRelationship = "Spouse";
  String emergencyContactPhone = "+1 (555) 111-2222";
  String emergencyContactEmail = "jane.doe@email.com";
  
  String preferredContactMethod = "Email";
  String preferredContactTime = "Business Hours";
  String language = "English";
  String timezone = "EST";

  List<Map<String, dynamic>> stateOptions = [
    {"label": "New York", "value": "New York"},
    {"label": "California", "value": "California"},
    {"label": "Texas", "value": "Texas"},
    {"label": "Florida", "value": "Florida"},
    {"label": "Illinois", "value": "Illinois"},
  ];

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
  ];

  List<Map<String, dynamic>> relationshipOptions = [
    {"label": "Spouse", "value": "Spouse"},
    {"label": "Parent", "value": "Parent"},
    {"label": "Sibling", "value": "Sibling"},
    {"label": "Child", "value": "Child"},
    {"label": "Friend", "value": "Friend"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> contactMethodOptions = [
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Text Message", "value": "Text Message"},
    {"label": "Mail", "value": "Mail"},
  ];

  List<Map<String, dynamic>> contactTimeOptions = [
    {"label": "Business Hours (9 AM - 5 PM)", "value": "Business Hours"},
    {"label": "Evening (5 PM - 9 PM)", "value": "Evening"},
    {"label": "Weekend", "value": "Weekend"},
    {"label": "Anytime", "value": "Anytime"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Chinese", "value": "Chinese"},
  ];

  List<Map<String, dynamic>> timezoneOptions = [
    {"label": "EST (Eastern)", "value": "EST"},
    {"label": "CST (Central)", "value": "CST"},
    {"label": "MST (Mountain)", "value": "MST"},
    {"label": "PST (Pacific)", "value": "PST"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Information"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.contact_phone,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Manage your contact details and preferences",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Email & Phone",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Primary Email",
                      value: primaryEmail,
                      validator: Validator.email,
                      onChanged: (value) {
                        primaryEmail = value;
                        setState(() {});
                      },
                    ),

                    QTextField(
                      label: "Secondary Email",
                      value: secondaryEmail,
                      hint: "Optional backup email",
                      onChanged: (value) {
                        secondaryEmail = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Home Phone",
                            value: homePhone,
                            onChanged: (value) {
                              homePhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Mobile Phone",
                            value: mobilePhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              mobilePhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QTextField(
                      label: "Work Phone",
                      value: workPhone,
                      hint: "Optional work number",
                      onChanged: (value) {
                        workPhone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Text(
                "Home Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Street Address",
                      value: homeAddress,
                      validator: Validator.required,
                      onChanged: (value) {
                        homeAddress = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: homeCity,
                            validator: Validator.required,
                            onChanged: (value) {
                              homeCity = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "State",
                            items: stateOptions,
                            value: homeState,
                            onChanged: (value, label) {
                              homeState = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "ZIP Code",
                            value: homeZipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              homeZipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Country",
                            items: countryOptions,
                            value: homeCountry,
                            onChanged: (value, label) {
                              homeCountry = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Text(
                "Mailing Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QSwitch(
                      items: [
                        {
                          "label": "Same as home address",
                          "value": true,
                          "checked": sameAsHome,
                        }
                      ],
                      value: sameAsHome ? [{"label": "Same as home address", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        sameAsHome = values.isNotEmpty;
                        if (sameAsHome) {
                          mailingAddress = "";
                          mailingCity = "";
                          mailingState = "";
                          mailingZipCode = "";
                          mailingCountry = homeCountry;
                        }
                        setState(() {});
                      },
                    ),

                    if (!sameAsHome) ...[
                      QTextField(
                        label: "Mailing Street Address",
                        value: mailingAddress,
                        onChanged: (value) {
                          mailingAddress = value;
                          setState(() {});
                        },
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "City",
                              value: mailingCity,
                              onChanged: (value) {
                                mailingCity = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "State",
                              items: stateOptions,
                              value: mailingState,
                              onChanged: (value, label) {
                                mailingState = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "ZIP Code",
                              value: mailingZipCode,
                              onChanged: (value) {
                                mailingZipCode = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Country",
                              items: countryOptions,
                              value: mailingCountry,
                              onChanged: (value, label) {
                                mailingCountry = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              Text(
                "Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Contact Name",
                            value: emergencyContactName,
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyContactName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Relationship",
                            items: relationshipOptions,
                            value: emergencyContactRelationship,
                            onChanged: (value, label) {
                              emergencyContactRelationship = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: emergencyContactPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              emergencyContactPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: emergencyContactEmail,
                            onChanged: (value) {
                              emergencyContactEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Emergency contact will be notified in case of account security issues or suspicious activities.",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Communication Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Preferred Contact Method",
                            items: contactMethodOptions,
                            value: preferredContactMethod,
                            onChanged: (value, label) {
                              preferredContactMethod = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Best Time to Contact",
                            items: contactTimeOptions,
                            value: preferredContactTime,
                            onChanged: (value, label) {
                              preferredContactTime = value;
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
                            label: "Preferred Language",
                            items: languageOptions,
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
                            label: "Timezone",
                            items: timezoneOptions,
                            value: timezone,
                            onChanged: (value, label) {
                              timezone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(60)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.verified,
                      color: infoColor,
                      size: 24,
                    ),
                    Text(
                      "Verification Status",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Column(
                      spacing: spXs,
                      children: [
                        _buildVerificationRow("Primary Email", true),
                        _buildVerificationRow("Mobile Phone", true),
                        _buildVerificationRow("Home Address", false),
                        _buildVerificationRow("Emergency Contact", false),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Contact Information",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      ss("Contact information updated successfully!");
                    }
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Verify Address",
                      icon: Icons.location_on,
                      size: bs.sm,
                      onPressed: () {
                        si("Address verification process initiated. You'll receive a verification code by mail within 3-5 business days.");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Test Contact",
                      icon: Icons.send,
                      size: bs.sm,
                      onPressed: () {
                        si("Test message sent to your preferred contact method.");
                      },
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Data Protection",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your contact information is securely stored and encrypted. We use this information solely for account management and security purposes. Your data will never be sold or shared with unauthorized parties.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 10,
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

  Widget _buildVerificationRow(String label, bool isVerified) {
    return Row(
      children: [
        Icon(
          isVerified ? Icons.check_circle : Icons.pending,
          color: isVerified ? successColor : warningColor,
          size: 16,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          isVerified ? "Verified" : "Pending",
          style: TextStyle(
            color: isVerified ? successColor : warningColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
