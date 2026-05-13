import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactView extends StatefulWidget {
  const CmaContactView({super.key});

  @override
  State<CmaContactView> createState() => _CmaContactViewState();
}

class _CmaContactViewState extends State<CmaContactView> {
  final formKey = GlobalKey<FormState>();
  
  // Contact Information
  String firstName = "";
  String lastName = "";
  String jobTitle = "";
  String department = "";
  String email = "";
  String phone = "";
  String mobilePhone = "";
  String extension = "";
  
  // Address Information
  String addressLine1 = "";
  String addressLine2 = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  
  // Additional Information
  String birthday = "";
  String anniversary = "";
  String website = "";
  String linkedIn = "";
  String twitter = "";
  String notes = "";
  
  // Settings
  String preferredContactMethod = "Email";
  String timeZone = "UTC-5 (Eastern)";
  bool isActive = true;
  bool emailOptIn = true;
  bool smsOptIn = false;
  bool marketingOptIn = true;
  
  // Relationship
  String relationship = "Primary";
  String contactType = "Business";
  String importance = "Medium";
  
  List<Map<String, dynamic>> contactMethods = [
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Mobile", "value": "Mobile"},
    {"label": "SMS", "value": "SMS"},
  ];
  
  List<Map<String, dynamic>> timeZones = [
    {"label": "UTC-5 (Eastern)", "value": "UTC-5 (Eastern)"},
    {"label": "UTC-6 (Central)", "value": "UTC-6 (Central)"},
    {"label": "UTC-7 (Mountain)", "value": "UTC-7 (Mountain)"},
    {"label": "UTC-8 (Pacific)", "value": "UTC-8 (Pacific)"},
  ];
  
  List<Map<String, dynamic>> relationships = [
    {"label": "Primary Contact", "value": "Primary"},
    {"label": "Secondary Contact", "value": "Secondary"},
    {"label": "Decision Maker", "value": "Decision Maker"},
    {"label": "Influencer", "value": "Influencer"},
    {"label": "Technical Contact", "value": "Technical"},
  ];
  
  List<Map<String, dynamic>> contactTypes = [
    {"label": "Business", "value": "Business"},
    {"label": "Personal", "value": "Personal"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Reference", "value": "Reference"},
  ];
  
  List<Map<String, dynamic>> importanceLevels = [
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];
  
  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Japan", "value": "Japan"},
    {"label": "Other", "value": "Other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: _saveContact,
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
              _buildBasicInfoSection(),
              _buildContactInfoSection(),
              _buildAddressSection(),
              _buildSocialMediaSection(),
              _buildPreferencesSection(),
              _buildRelationshipSection(),
              _buildNotesSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Job Title",
                  value: jobTitle,
                  onChanged: (value) {
                    jobTitle = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Department",
                  value: department,
                  onChanged: (value) {
                    department = value;
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
                child: QDatePicker(
                  label: "Birthday",
                  value: birthday.isNotEmpty ? DateTime.parse(birthday) : DateTime.now(),
                  onChanged: (value) {
                    birthday = value.toString();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDatePicker(
                  label: "Anniversary",
                  value: anniversary.isNotEmpty ? DateTime.parse(anniversary) : DateTime.now(),
                  onChanged: (value) {
                    anniversary = value.toString();
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

  Widget _buildContactInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.contact_phone,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: phone,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Extension",
                  value: extension,
                  onChanged: (value) {
                    extension = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Mobile Phone",
            value: mobilePhone,
            onChanged: (value) {
              mobilePhone = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Preferred Contact Method",
            items: contactMethods,
            value: preferredContactMethod,
            onChanged: (value, label) {
              preferredContactMethod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Address Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Address Line 1",
            value: addressLine1,
            onChanged: (value) {
              addressLine1 = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Address Line 2",
            value: addressLine2,
            onChanged: (value) {
              addressLine2 = value;
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
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "State",
                  value: state,
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
                  label: "ZIP Code",
                  value: zipCode,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Country",
                  items: countries,
                  value: country,
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
    );
  }

  Widget _buildSocialMediaSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.share,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Social Media & Web",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Website",
            value: website,
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "LinkedIn Profile",
            value: linkedIn,
            onChanged: (value) {
              linkedIn = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Twitter Handle",
            value: twitter,
            onChanged: (value) {
              twitter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Preferences & Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Time Zone",
            items: timeZones,
            value: timeZone,
            onChanged: (value, label) {
              timeZone = value;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Contact Status",
            items: [
              {
                "label": "Active Contact",
                "value": true,
                "checked": isActive,
              }
            ],
            value: [
              if (isActive)
                {
                  "label": "Active Contact",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isActive = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Communication Preferences",
            items: [
              {
                "label": "Email Communications",
                "value": "email",
                "checked": emailOptIn,
              },
              {
                "label": "SMS Notifications",
                "value": "sms",
                "checked": smsOptIn,
              },
              {
                "label": "Marketing Materials",
                "value": "marketing",
                "checked": marketingOptIn,
              }
            ],
            value: [
              if (emailOptIn)
                {
                  "label": "Email Communications",
                  "value": "email",
                  "checked": true
                },
              if (smsOptIn)
                {
                  "label": "SMS Notifications",
                  "value": "sms",
                  "checked": true
                },
              if (marketingOptIn)
                {
                  "label": "Marketing Materials",
                  "value": "marketing",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              emailOptIn = values.any((v) => v["value"] == "email");
              smsOptIn = values.any((v) => v["value"] == "sms");
              marketingOptIn = values.any((v) => v["value"] == "marketing");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRelationshipSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.group,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Relationship & Role",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Relationship Type",
                  items: relationships,
                  value: relationship,
                  onChanged: (value, label) {
                    relationship = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Contact Type",
                  items: contactTypes,
                  value: contactType,
                  onChanged: (value, label) {
                    contactType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Importance Level",
            items: importanceLevels,
            value: importance,
            onChanged: (value, label) {
              importance = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Additional Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Add any additional information about this contact...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Cancel",
            onPressed: () => back(),
          ),
        ),
        Expanded(
          child: QButton(
            label: "Save Contact",
            onPressed: _saveContact,
          ),
        ),
      ],
    );
  }

  void _saveContact() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Contact saved successfully");
      back();
    }
  }
}
