import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAddContactView extends StatefulWidget {
  const CrmAddContactView({super.key});

  @override
  State<CrmAddContactView> createState() => _CrmAddContactViewState();
}

class _CrmAddContactViewState extends State<CrmAddContactView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String jobTitle = "";
  String company = "";
  String department = "";
  
  // Address Information
  String street = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "";
  
  // Social & Communication
  String linkedin = "";
  String twitter = "";
  String website = "";
  String skype = "";
  
  // Contact Preferences
  String preferredContactMethod = "Email";
  bool emailOptIn = true;
  bool smsOptIn = false;
  bool marketingOptIn = true;
  
  // Lead Information
  String leadSource = "Website";
  String leadStatus = "New";
  String assignedTo = "John Smith";
  
  // Additional Information
  String notes = "";
  String tags = "";
  List<String> selectedTags = [];
  
  List<Map<String, dynamic>> contactMethods = [
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "SMS", "value": "SMS"},
    {"label": "LinkedIn", "value": "LinkedIn"},
  ];
  
  List<Map<String, dynamic>> leadSources = [
    {"label": "Website", "value": "Website"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Referral", "value": "Referral"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Trade Show", "value": "Trade Show"},
    {"label": "Advertisement", "value": "Advertisement"},
  ];
  
  List<Map<String, dynamic>> leadStatuses = [
    {"label": "New", "value": "New"},
    {"label": "Contacted", "value": "Contacted"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Unqualified", "value": "Unqualified"},
  ];
  
  List<Map<String, dynamic>> assignedUsers = [
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Emily Davis", "value": "Emily Davis"},
  ];
  
  List<String> availableTags = [
    "VIP", "Hot Lead", "Decision Maker", "Influencer", 
    "Budget Holder", "Technical Contact", "Champion", 
    "Cold Lead", "Warm Lead", "Prospect"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Contact"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => _saveContact(),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBasicInformation(),
              _buildCompanyInformation(),
              _buildAddressInformation(),
              _buildSocialCommunication(),
              _buildContactPreferences(),
              _buildLeadInformation(),
              _buildAdditionalInformation(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
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
        ],
      ),
    );
  }

  Widget _buildCompanyInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Company Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Job Title",
            value: jobTitle,
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Company",
                  value: company,
                  validator: Validator.required,
                  onChanged: (value) {
                    company = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
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
        ],
      ),
    );
  }

  Widget _buildAddressInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
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
            label: "Street Address",
            value: street,
            onChanged: (value) {
              street = value;
              setState(() {});
            },
          ),
          Row(
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
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "State/Province",
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
            children: [
              Expanded(
                child: QTextField(
                  label: "ZIP/Postal Code",
                  value: zipCode,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Country",
                  value: country,
                  onChanged: (value) {
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

  Widget _buildSocialCommunication() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.link,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Social & Communication",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "LinkedIn Profile",
                  value: linkedin,
                  onChanged: (value) {
                    linkedin = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Twitter Handle",
                  value: twitter,
                  onChanged: (value) {
                    twitter = value;
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
                  label: "Website",
                  value: website,
                  onChanged: (value) {
                    website = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Skype ID",
                  value: skype,
                  onChanged: (value) {
                    skype = value;
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

  Widget _buildContactPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Contact Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
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
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Email Notifications",
                      "value": true,
                      "checked": emailOptIn,
                    }
                  ],
                  value: [if (emailOptIn) {"label": "Email Notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    emailOptIn = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "SMS Notifications",
                      "value": true,
                      "checked": smsOptIn,
                    }
                  ],
                  value: [if (smsOptIn) {"label": "SMS Notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    smsOptIn = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Marketing Communications",
                "value": true,
                "checked": marketingOptIn,
              }
            ],
            value: [if (marketingOptIn) {"label": "Marketing Communications", "value": true, "checked": true}],
            onChanged: (values, ids) {
              marketingOptIn = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeadInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Lead Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Lead Source",
                  items: leadSources,
                  value: leadSource,
                  onChanged: (value, label) {
                    leadSource = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Lead Status",
                  items: leadStatuses,
                  value: leadStatus,
                  onChanged: (value, label) {
                    leadStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Assigned To",
            items: assignedUsers,
            value: assignedTo,
            onChanged: (value, label) {
              assignedTo = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Additional Information",
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
            hint: "Add any additional notes about this contact...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
          Text(
            "Tags",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: availableTags.map((tag) {
              bool isSelected = selectedTags.contains(tag);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedTags.remove(tag);
                  } else {
                    selectedTags.add(tag);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Save as Draft",
              size: bs.md,
              onPressed: () => _saveDraft(),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: QButton(
              label: "Save & Add Another",
              size: bs.md,
              onPressed: () => _saveAndAddAnother(),
            ),
          ),
        ],
      ),
    );
  }

  void _saveContact() {
    if (formKey.currentState!.validate()) {
      // Implement save contact logic
      ss("Contact saved successfully!");
      back();
    }
  }

  void _saveDraft() {
    // Implement save draft logic
    si("Contact saved as draft");
    back();
  }

  void _saveAndAddAnother() {
    if (formKey.currentState!.validate()) {
      // Implement save and reset form logic
      _resetForm();
      ss("Contact saved! Ready to add another contact.");
    }
  }

  void _resetForm() {
    firstName = "";
    lastName = "";
    email = "";
    phone = "";
    jobTitle = "";
    company = "";
    department = "";
    street = "";
    city = "";
    state = "";
    zipCode = "";
    country = "";
    linkedin = "";
    twitter = "";
    website = "";
    skype = "";
    preferredContactMethod = "Email";
    emailOptIn = true;
    smsOptIn = false;
    marketingOptIn = true;
    leadSource = "Website";
    leadStatus = "New";
    assignedTo = "John Smith";
    notes = "";
    selectedTags.clear();
    setState(() {});
  }
}
