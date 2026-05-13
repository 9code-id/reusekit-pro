import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPrivacy4View extends StatefulWidget {
  @override
  State<GrlPrivacy4View> createState() => _GrlPrivacy4ViewState();
}

class _GrlPrivacy4ViewState extends State<GrlPrivacy4View> {
  String selectedRequestType = "";
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String requestDetails = "";
  String accountId = "";
  List<String> attachments = [];

  List<Map<String, dynamic>> requestTypes = [
    {
      "label": "Data Access Request",
      "value": "data_access",
      "icon": Icons.visibility,
      "description": "Request a copy of all personal data we have about you",
      "processingTime": "Up to 30 days",
      "color": infoColor,
    },
    {
      "label": "Data Deletion Request",
      "value": "data_deletion",
      "icon": Icons.delete_forever,
      "description": "Request permanent deletion of your personal data",
      "processingTime": "Up to 30 days",
      "color": dangerColor,
    },
    {
      "label": "Data Correction Request",
      "value": "data_correction",
      "icon": Icons.edit,
      "description": "Request correction of inaccurate personal information",
      "processingTime": "Up to 15 days",
      "color": warningColor,
    },
    {
      "label": "Consent Withdrawal",
      "value": "consent_withdrawal",
      "icon": Icons.block,
      "description": "Withdraw consent for specific data processing activities",
      "processingTime": "Immediate",
      "color": primaryColor,
    },
    {
      "label": "Data Portability Request",
      "value": "data_portability",
      "icon": Icons.import_export,
      "description": "Receive your data in a structured, machine-readable format",
      "processingTime": "Up to 30 days",
      "color": successColor,
    },
    {
      "label": "Privacy Concern Report",
      "value": "privacy_concern",
      "icon": Icons.report_problem,
      "description": "Report a privacy concern or potential data breach",
      "processingTime": "Up to 72 hours",
      "color": warningColor,
    },
  ];

  final formKey = GlobalKey<FormState>();

  void _submitRequest() async {
    if (formKey.currentState!.validate()) {
      if (selectedRequestType.isEmpty) {
        se("Please select a request type");
        return;
      }

      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      ss("Privacy request submitted successfully");
      // Reset form or navigate
    }
  }

  Color _getRequestTypeColor(String type) {
    final requestType = requestTypes.firstWhere(
      (r) => r["value"] == type,
      orElse: () => {"color": primaryColor},
    );
    return requestType["color"] as Color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Request"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withAlpha(30),
                      infoColor.withAlpha(20),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.gavel,
                      size: 48,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Exercise Your Privacy Rights",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Submit a request regarding your personal data and privacy rights under applicable regulations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Request Type Selection
              Text(
                "Select Request Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...requestTypes.map((request) {
                final isSelected = selectedRequestType == request["value"];
                final color = request["color"] as Color;
                
                return GestureDetector(
                  onTap: () {
                    selectedRequestType = request["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? color : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: color.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            request["icon"] as IconData,
                            color: color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${request["label"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? color : primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${request["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXl),
                                ),
                                child: Text(
                                  "Processing time: ${request["processingTime"]}",
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: color,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              }),

              // Personal Information Section
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
                      label: "Full Name",
                      value: fullName,
                      validator: Validator.required,
                      onChanged: (value) {
                        fullName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Account ID (Optional)",
                      value: accountId,
                      hint: "e.g., USER123456",
                      onChanged: (value) {
                        accountId = value;
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
                validator: Validator.required,
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),

              // Request Details
              Text(
                "Request Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QMemoField(
                label: "Describe Your Request",
                value: requestDetails,
                hint: "Please provide specific details about your privacy request...",
                validator: Validator.required,
                onChanged: (value) {
                  requestDetails = value;
                  setState(() {});
                },
              ),

              // Attachments
              QAttachmentPicker(
                label: "Supporting Documents (Optional)",
                value: attachments,
                hint: "Attach any relevant documents or evidence",
                maxAttachments: 5,
                allowedTypes: ['image', 'document'],
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),

              // Important Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Important Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• We may require additional verification to process your request\n• Some requests may affect your ability to use our services\n• Processing times may vary based on request complexity\n• You will receive email updates about your request status",
                      style: TextStyle(
                        color: warningColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Legal Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Your Rights Under GDPR & CCPA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "You have the right to access, correct, delete, or port your personal data. You may also withdraw consent or object to processing. These rights are subject to certain legal limitations and exceptions.",
                      style: TextStyle(
                        color: infoColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Privacy Request",
                  size: bs.md,
                  icon: Icons.send,
                  onPressed: _submitRequest,
                ),
              ),

              // Contact Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.contact_support,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Need help? Contact our Privacy Team at privacy@company.com or call +1-800-PRIVACY",
                        style: TextStyle(
                          color: successColor,
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
      ),
    );
  }
}
