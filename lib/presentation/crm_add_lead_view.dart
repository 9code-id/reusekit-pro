import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAddLeadView extends StatefulWidget {
  const CrmAddLeadView({super.key});

  @override
  State<CrmAddLeadView> createState() => _CrmAddLeadViewState();
}

class _CrmAddLeadViewState extends State<CrmAddLeadView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";
  String jobTitle = "";
  String leadSource = "";
  String leadStatus = "New";
  String priority = "Medium";
  double estimatedValue = 0.0;
  String description = "";
  String assignedTo = "";
  String industry = "";
  String website = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "";
  String notes = "";
  bool isQualified = false;
  bool followUpRequired = false;

  List<Map<String, dynamic>> leadSourceItems = [
    {"label": "Website", "value": "website"},
    {"label": "Social Media", "value": "social_media"},
    {"label": "Email Campaign", "value": "email_campaign"},
    {"label": "Referral", "value": "referral"},
    {"label": "Cold Call", "value": "cold_call"},
    {"label": "Trade Show", "value": "trade_show"},
    {"label": "Advertisement", "value": "advertisement"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "New", "value": "new"},
    {"label": "Contacted", "value": "contacted"},
    {"label": "Qualified", "value": "qualified"},
    {"label": "Proposal", "value": "proposal"},
    {"label": "Negotiation", "value": "negotiation"},
    {"label": "Closed Won", "value": "closed_won"},
    {"label": "Closed Lost", "value": "closed_lost"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> assignedToItems = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Emily Brown", "value": "emily_brown"},
    {"label": "David Wilson", "value": "david_wilson"},
  ];

  List<Map<String, dynamic>> industryItems = [
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Retail", "value": "retail"},
    {"label": "Education", "value": "education"},
    {"label": "Real Estate", "value": "real_estate"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> countryItems = [
    {"label": "United States", "value": "us"},
    {"label": "Canada", "value": "ca"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
    {"label": "France", "value": "fr"},
    {"label": "Japan", "value": "jp"},
    {"label": "Other", "value": "other"},
  ];

  void _saveLead() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Lead created successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Lead"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: QButton(
              label: "Save",
              size: bs.sm,
              onPressed: _saveLead,
            ),
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
              // Contact Information Section
              Container(
                width: double.infinity,
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
                        SizedBox(width: spSm),
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
                      ],
                    ),
                    Row(
                      children: [
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
                        SizedBox(width: spSm),
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
                      ],
                    ),
                  ],
                ),
              ),

              // Lead Details Section
              Container(
                width: double.infinity,
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
                    Text(
                      "Lead Details",
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
                            label: "Lead Source",
                            items: leadSourceItems,
                            value: leadSource,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              leadSource = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Status",
                            items: statusItems,
                            value: leadStatus,
                            onChanged: (value, label) {
                              leadStatus = value;
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
                            label: "Assigned To",
                            items: assignedToItems,
                            value: assignedTo,
                            onChanged: (value, label) {
                              assignedTo = value;
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
                        estimatedValue = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe the lead opportunity and requirements",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Address Information Section
              Container(
                width: double.infinity,
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
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Country",
                            items: countryItems,
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
              ),

              // Additional Information Section
              Container(
                width: double.infinity,
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
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Notes",
                      value: notes,
                      hint: "Add any additional notes about this lead",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Qualified Lead",
                                "value": true,
                                "checked": isQualified,
                              }
                            ],
                            value: [
                              if (isQualified)
                                {
                                  "label": "Qualified Lead",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                isQualified = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Follow-up Required",
                                "value": true,
                                "checked": followUpRequired,
                              }
                            ],
                            value: [
                              if (followUpRequired)
                                {
                                  "label": "Follow-up Required",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                followUpRequired = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        size: bs.md,
                        color: disabledColor,
                        onPressed: () {
                          back();
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Save Lead",
                        size: bs.md,
                        onPressed: _saveLead,
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
}
