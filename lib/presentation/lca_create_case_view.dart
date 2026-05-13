import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCreateCaseView extends StatefulWidget {
  const LcaCreateCaseView({Key? key}) : super(key: key);

  @override
  State<LcaCreateCaseView> createState() => _LcaCreateCaseViewState();
}

class _LcaCreateCaseViewState extends State<LcaCreateCaseView> {
  final formKey = GlobalKey<FormState>();
  
  String caseTitle = "";
  String caseType = "";
  String priority = "";
  String clientName = "";
  String clientEmail = "";
  String clientPhone = "";
  String opposingParty = "";
  String court = "";
  String judge = "";
  String caseValue = "";
  String filingDate = "";
  String nextHearing = "";
  String description = "";
  List<String> attachments = [];
  String category = "";
  String subcategory = "";
  bool isUrgent = false;
  String assignedLawyer = "";
  String caseStatus = "Draft";

  List<Map<String, dynamic>> caseTypes = [
    {"label": "Civil Litigation", "value": "civil"},
    {"label": "Criminal Defense", "value": "criminal"},
    {"label": "Corporate Law", "value": "corporate"},
    {"label": "Family Law", "value": "family"},
    {"label": "Personal Injury", "value": "personal_injury"},
    {"label": "Employment Law", "value": "employment"},
    {"label": "Real Estate", "value": "real_estate"},
    {"label": "Intellectual Property", "value": "intellectual_property"},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> lawyers = [
    {"label": "Sarah Johnson, Esq.", "value": "sarah_johnson"},
    {"label": "Michael Chen, Esq.", "value": "michael_chen"},
    {"label": "Emily Rodriguez, Esq.", "value": "emily_rodriguez"},
    {"label": "David Wilson, Esq.", "value": "david_wilson"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Case"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () => _saveCase(),
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
              _buildCaseBasicInfo(),
              _buildClientInformation(),
              _buildCaseDetails(),
              _buildCourtInformation(),
              _buildCaseClassification(),
              _buildAdditionalDetails(),
              _buildAttachments(),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaseBasicInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.gavel, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Basic Case Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Case Title",
            value: caseTitle,
            hint: "Enter descriptive case title",
            validator: Validator.required,
            onChanged: (value) {
              caseTitle = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Case Type",
                  items: caseTypes,
                  value: caseType,
                  onChanged: (value, label) {
                    caseType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Priority Level",
                  items: priorityLevels,
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Mark as Urgent",
                "value": true,
                "checked": isUrgent,
              }
            ],
            value: [
              if (isUrgent)
                {
                  "label": "Mark as Urgent",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isUrgent = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClientInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.person, color: successColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Client Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Client Name",
            value: clientName,
            hint: "Enter client full name",
            validator: Validator.required,
            onChanged: (value) {
              clientName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Client Email",
                  value: clientEmail,
                  hint: "client@email.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    clientEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Client Phone",
                  value: clientPhone,
                  hint: "(555) 123-4567",
                  onChanged: (value) {
                    clientPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Opposing Party",
            value: opposingParty,
            hint: "Enter opposing party name/organization",
            onChanged: (value) {
              opposingParty = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCaseDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.info, color: infoColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Case Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Case Value (\$)",
            value: caseValue,
            validator: Validator.required,
            onChanged: (value) {
              caseValue = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Filing Date",
                  value: filingDate.isNotEmpty ? DateTime.parse(filingDate) : null,
                  onChanged: (value) {
                    filingDate = value.toString().substring(0, 10);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDatePicker(
                  label: "Next Hearing",
                  value: nextHearing.isNotEmpty ? DateTime.parse(nextHearing) : null,
                  onChanged: (value) {
                    nextHearing = value.toString().substring(0, 10);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Case Description",
            value: description,
            hint: "Provide detailed description of the case",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCourtInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.account_balance, color: warningColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Court Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Court Name",
            value: court,
            hint: "Enter court name and jurisdiction",
            onChanged: (value) {
              court = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Presiding Judge",
            value: judge,
            hint: "Enter judge name",
            onChanged: (value) {
              judge = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCaseClassification() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.category, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Case Classification",
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
                  label: "Category",
                  value: category,
                  hint: "Enter case category",
                  onChanged: (value) {
                    category = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Subcategory",
                  value: subcategory,
                  hint: "Enter subcategory",
                  onChanged: (value) {
                    subcategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Assigned Lawyer",
            items: lawyers,
            value: assignedLawyer,
            onChanged: (value, label) {
              assignedLawyer = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.more_horiz, color: successColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Additional Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Case Status: $caseStatus",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
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

  Widget _buildAttachments() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.attach_file, color: warningColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Case Documents",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QAttachmentPicker(
            label: "Upload Documents",
            value: attachments,
            hint: "Attach relevant case documents",
            maxAttachments: 10,
            allowedTypes: ['image', 'document'],
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Create Case",
            size: bs.md,
            onPressed: () => _createCase(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save Draft",
                size: bs.md,
                onPressed: () => _saveDraft(),
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: "Cancel",
                size: bs.md,
                onPressed: () => _cancel(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveCase() {
    if (formKey.currentState!.validate()) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Case saved successfully");
      });
    }
  }

  void _createCase() {
    if (formKey.currentState!.validate()) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Case created successfully");
        back();
      });
    }
  }

  void _saveDraft() {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Draft saved");
    });
  }

  void _cancel() {
    back();
  }
}
