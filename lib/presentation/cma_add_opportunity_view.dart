import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAddOpportunityView extends StatefulWidget {
  const CmaAddOpportunityView({super.key});

  @override
  State<CmaAddOpportunityView> createState() => _CmaAddOpportunityViewState();
}

class _CmaAddOpportunityViewState extends State<CmaAddOpportunityView> {
  final formKey = GlobalKey<FormState>();
  
  String opportunityName = "";
  String accountName = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String selectedStage = "Prospecting";
  String selectedType = "New Business";
  String selectedSource = "Website";
  String selectedPriority = "Medium";
  double dealValue = 0.0;
  String probability = "25";
  String expectedCloseDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  String description = "";
  String nextStep = "";
  
  List<Map<String, dynamic>> stageItems = [
    {"label": "Prospecting", "value": "Prospecting"},
    {"label": "Qualification", "value": "Qualification"},
    {"label": "Needs Analysis", "value": "Needs Analysis"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
    {"label": "Closed Won", "value": "Closed Won"},
    {"label": "Closed Lost", "value": "Closed Lost"},
  ];
  
  List<Map<String, dynamic>> typeItems = [
    {"label": "New Business", "value": "New Business"},
    {"label": "Existing Customer", "value": "Existing Customer"},
    {"label": "Upsell", "value": "Upsell"},
    {"label": "Cross-sell", "value": "Cross-sell"},
    {"label": "Renewal", "value": "Renewal"},
  ];
  
  List<Map<String, dynamic>> sourceItems = [
    {"label": "Website", "value": "Website"},
    {"label": "Referral", "value": "Referral"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Trade Show", "value": "Trade Show"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Email Campaign", "value": "Email Campaign"},
    {"label": "Partner", "value": "Partner"},
  ];
  
  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Opportunity"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => _saveOpportunity(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Opportunity Information Section
              Container(
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
                      "Opportunity Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Opportunity Name",
                      value: opportunityName,
                      validator: Validator.required,
                      hint: "Enter opportunity name",
                      onChanged: (value) {
                        opportunityName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Account Name",
                      value: accountName,
                      validator: Validator.required,
                      hint: "Enter company/account name",
                      onChanged: (value) {
                        accountName = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Opportunity Stage",
                      items: stageItems,
                      value: selectedStage,
                      onChanged: (value, label) {
                        selectedStage = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Opportunity Type",
                      items: typeItems,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Contact Information Section
              Container(
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
                    QTextField(
                      label: "Contact Person",
                      value: contactPerson,
                      validator: Validator.required,
                      hint: "Enter primary contact name",
                      onChanged: (value) {
                        contactPerson = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      hint: "Enter contact email",
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      hint: "Enter contact phone number",
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Deal Information Section
              Container(
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
                      "Deal Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Deal Value (\$)",
                      value: dealValue.toString(),
                      validator: Validator.required,
                      onChanged: (value) {
                        dealValue = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Probability (%)",
                      items: [
                        {"label": "10%", "value": "10"},
                        {"label": "25%", "value": "25"},
                        {"label": "50%", "value": "50"},
                        {"label": "75%", "value": "75"},
                        {"label": "90%", "value": "90"},
                        {"label": "100%", "value": "100"},
                      ],
                      value: probability,
                      onChanged: (value, label) {
                        probability = value;
                        setState(() {});
                      },
                    ),
                    QDatePicker(
                      label: "Expected Close Date",
                      value: DateTime.parse(expectedCloseDate),
                      onChanged: (value) {
                        expectedCloseDate = value.toString().split(' ')[0];
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Lead Source",
                      items: sourceItems,
                      value: selectedSource,
                      onChanged: (value, label) {
                        selectedSource = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Priority",
                      items: priorityItems,
                      value: selectedPriority,
                      onChanged: (value, label) {
                        selectedPriority = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Additional Details Section
              Container(
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
                      "Additional Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Enter opportunity description and notes",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Next Step",
                      value: nextStep,
                      hint: "Enter next action required",
                      onChanged: (value) {
                        nextStep = value;
                        setState(() {});
                      },
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
  
  void _saveOpportunity() {
    if (formKey.currentState!.validate()) {
      // Simulate save operation
      ss("Opportunity created successfully!");
      back();
    }
  }
}
