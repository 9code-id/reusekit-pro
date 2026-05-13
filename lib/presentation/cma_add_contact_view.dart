import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAddContactView extends StatefulWidget {
  const CmaAddContactView({super.key});

  @override
  State<CmaAddContactView> createState() => _CmaAddContactViewState();
}

class _CmaAddContactViewState extends State<CmaAddContactView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";
  String position = "";
  String address = "";
  String website = "";
  String linkedIn = "";
  String twitter = "";
  String notes = "";
  String source = "Website";
  List<String> selectedTags = [];
  Map<String, String> customFields = {};
  
  List<Map<String, dynamic>> sourceOptions = [
    {"label": "Website", "value": "Website"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Referral", "value": "Referral"},
    {"label": "Email Campaign", "value": "Email Campaign"},
    {"label": "Trade Show", "value": "Trade Show"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> availableTags = [
    {"label": "VIP", "value": "VIP"},
    {"label": "Premium", "value": "Premium"},
    {"label": "Developer", "value": "Developer"},
    {"label": "Manager", "value": "Manager"},
    {"label": "Decision Maker", "value": "Decision Maker"},
    {"label": "Influencer", "value": "Influencer"},
    {"label": "Hot Lead", "value": "Hot Lead"},
    {"label": "Cold Lead", "value": "Cold Lead"},
  ];

  List<Map<String, String>> customFieldTemplates = [
    {"name": "Budget", "type": "text"},
    {"name": "Decision Timeline", "type": "text"},
    {"name": "Pain Points", "type": "text"},
    {"name": "Industry", "type": "text"},
    {"name": "Company Size", "type": "text"},
    {"name": "Annual Revenue", "type": "text"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        actions: [
          TextButton(
            onPressed: () {
              _saveContact();
            },
            child: Text(
              "Save",
              style: TextStyle(color: primaryColor),
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
              _buildBasicInfo(),
              _buildContactInfo(),
              _buildCompanyInfo(),
              _buildSocialMedia(),
              _buildSourceAndTags(),
              _buildCustomFields(),
              _buildNotes(),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
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
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
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
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Address",
            value: address,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Company Name",
            value: company,
            onChanged: (value) {
              company = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Position/Title",
            value: position,
            onChanged: (value) {
              position = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website",
            value: website,
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMedia() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Social Media",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
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

  Widget _buildSourceAndTags() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Source & Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QDropdownField(
            label: "Lead Source",
            items: sourceOptions,
            value: source,
            onChanged: (value, label) {
              source = value;
              setState(() {});
            },
          ),
          Text(
            "Tags",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: availableTags.map((tag) {
              bool isSelected = selectedTags.contains(tag["value"]);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedTags.remove(tag["value"]);
                  } else {
                    selectedTags.add(tag["value"]);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${tag["label"]}",
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

  Widget _buildCustomFields() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Custom Fields",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showAddCustomFieldDialog();
                },
              ),
            ],
          ),
          if (customFields.isNotEmpty)
            ...customFields.entries.map((entry) {
              return Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: entry.key,
                      value: entry.value,
                      onChanged: (value) {
                        customFields[entry.key] = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  IconButton(
                    icon: Icon(Icons.delete, color: dangerColor),
                    onPressed: () {
                      customFields.remove(entry.key);
                      setState(() {});
                    },
                  ),
                ],
              );
            }).toList()
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: disabledBoldColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "No custom fields added. Tap + to add custom fields.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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

  Widget _buildNotes() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QMemoField(
            label: "Additional Notes",
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

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Save Contact",
        size: bs.md,
        onPressed: () {
          _saveContact();
        },
      ),
    );
  }

  void _showAddCustomFieldDialog() {
    String fieldName = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Custom Field"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose a field template or create custom:",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              SizedBox(height: spSm),
              ...customFieldTemplates.map((template) {
                return ListTile(
                  title: Text("${template["name"]}"),
                  onTap: () {
                    customFields[template["name"]!] = "";
                    setState(() {});
                    back();
                  },
                );
              }).toList(),
              Divider(),
              TextField(
                decoration: InputDecoration(
                  labelText: "Custom Field Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  fieldName = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                back();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (fieldName.isNotEmpty) {
                  customFields[fieldName] = "";
                  setState(() {});
                }
                back();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _saveContact() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Contact saved successfully");
      back();
    }
  }
}
