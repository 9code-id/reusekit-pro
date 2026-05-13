import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAddLeadView extends StatefulWidget {
  const CmaAddLeadView({super.key});

  @override
  State<CmaAddLeadView> createState() => _CmaAddLeadViewState();
}

class _CmaAddLeadViewState extends State<CmaAddLeadView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";
  String jobTitle = "";
  String leadSource = "";
  String priority = "Medium";
  String status = "New";
  String notes = "";
  double estimatedValue = 0.0;
  String industry = "";
  String website = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "";
  
  List<Map<String, dynamic>> sourceItems = [
    {"label": "Website", "value": "website"},
    {"label": "Social Media", "value": "social_media"},
    {"label": "Referral", "value": "referral"},
    {"label": "Cold Call", "value": "cold_call"},
    {"label": "Email Campaign", "value": "email_campaign"},
    {"label": "Trade Show", "value": "trade_show"},
    {"label": "Advertisement", "value": "advertisement"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "New", "value": "New"},
    {"label": "Contacted", "value": "Contacted"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
  ];
  
  List<Map<String, dynamic>> industryItems = [
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Retail", "value": "retail"},
    {"label": "Construction", "value": "construction"},
    {"label": "Other", "value": "other"},
  ];

  void _saveLead() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Lead added successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Lead"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveLead,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactInformation(),
              _buildCompanyInformation(),
              _buildLeadDetails(),
              _buildAddressInformation(),
              _buildNotesSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
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
            label: "Email",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone",
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
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Company",
            value: company,
            validator: Validator.required,
            onChanged: (value) {
              company = value;
              setState(() {});
            },
          ),
          Row(
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Industry",
                  items: industryItems,
                  value: industry,
                  onChanged: (value, label) {
                    industry = value;
                    setState(() {});
                  },
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
        ],
      ),
    );
  }

  Widget _buildLeadDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lead Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Lead Source",
            items: sourceItems,
            value: leadSource,
            validator: Validator.required,
            onChanged: (value, label) {
              leadSource = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityItems,
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: status,
                  onChanged: (value, label) {
                    status = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Estimated Value (\$)",
            value: estimatedValue.toString(),
            onChanged: (value) {
              estimatedValue = double.tryParse("$value") ?? 0.0;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Address",
            value: address,
            onChanged: (value) {
              address = value;
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
              SizedBox(width: spSm),
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
              SizedBox(width: spSm),
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

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Add any additional information about this lead...",
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
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Lead",
            onPressed: _saveLead,
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save & Add Another",
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                showLoading();
                await Future.delayed(Duration(seconds: 1));
                hideLoading();
                ss("Lead saved successfully");
                
                // Reset form
                firstName = "";
                lastName = "";
                email = "";
                phone = "";
                company = "";
                jobTitle = "";
                leadSource = "";
                priority = "Medium";
                status = "New";
                notes = "";
                estimatedValue = 0.0;
                industry = "";
                website = "";
                address = "";
                city = "";
                state = "";
                zipCode = "";
                country = "";
                setState(() {});
              }
            },
          ),
        ),
      ],
    );
  }
}
