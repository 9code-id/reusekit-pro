import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaEditCaseView extends StatefulWidget {
  const LcaEditCaseView({Key? key}) : super(key: key);

  @override
  State<LcaEditCaseView> createState() => _LcaEditCaseViewState();
}

class _LcaEditCaseViewState extends State<LcaEditCaseView> {
  final formKey = GlobalKey<FormState>();
  
  String caseId = "LCA-2024-001";
  String caseTitle = "Smith vs. Johnson Construction";
  String caseType = "civil";
  String priority = "high";
  String clientName = "John Smith";
  String clientEmail = "john.smith@email.com";
  String clientPhone = "(555) 123-4567";
  String opposingParty = "Johnson Construction LLC";
  String court = "Superior Court of California";
  String judge = "Hon. Sarah Martinez";
  String caseValue = "250000";
  String filingDate = "2024-01-15";
  String nextHearing = "2024-07-25";
  String description = "Personal injury case involving construction site accident. Client suffered multiple injuries due to unsafe working conditions and equipment failure.";
  List<String> attachments = [];
  String category = "Personal Injury";
  String subcategory = "Construction Accident";
  bool isUrgent = true;
  String assignedLawyer = "sarah_johnson";
  String caseStatus = "active";
  String lastModified = "2024-06-15";
  bool hasUnsavedChanges = false;

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

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Closed", "value": "closed"},
    {"label": "Draft", "value": "draft"},
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
        title: Text("Edit Case"),
        actions: [
          if (hasUnsavedChanges)
            Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(Icons.circle, color: warningColor, size: 8),
            ),
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () => _saveChanges(),
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
              _buildCaseHeader(),
              _buildCaseBasicInfo(),
              _buildClientInformation(),
              _buildCaseDetails(),
              _buildCourtInformation(),
              _buildCaseClassification(),
              _buildCaseStatus(),
              _buildAttachments(),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaseHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.edit, color: infoColor, size: 20),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Editing Case: $caseId",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Legal Case Assistant",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Last modified: $lastModified",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          if (hasUnsavedChanges)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "You have unsaved changes",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
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
              hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Filing Date",
                  value: DateTime.parse(filingDate),
                  onChanged: (value) {
                    filingDate = value.toString().substring(0, 10);
                    hasUnsavedChanges = true;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDatePicker(
                  label: "Next Hearing",
                  value: DateTime.parse(nextHearing),
                  onChanged: (value) {
                    nextHearing = value.toString().substring(0, 10);
                    hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
          QTextField(
            label: "Presiding Judge",
            value: judge,
            hint: "Enter judge name",
            onChanged: (value) {
              judge = value;
              hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCaseStatus() {
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
                  color: _getStatusColor(caseStatus).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.flag, color: _getStatusColor(caseStatus), size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Case Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Current Status",
            items: statusOptions,
            value: caseStatus,
            onChanged: (value, label) {
              caseStatus = value;
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getStatusColor(caseStatus).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: _getStatusColor(caseStatus).withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: _getStatusColor(caseStatus), size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    _getStatusDescription(caseStatus),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor(caseStatus),
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
              hasUnsavedChanges = true;
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
        if (hasUnsavedChanges)
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Changes",
              size: bs.md,
              onPressed: () => _saveChanges(),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "View Case",
                size: bs.md,
                onPressed: () => _viewCase(),
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: "Duplicate",
                size: bs.md,
                onPressed: () => _duplicateCase(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Archive",
                size: bs.md,
                onPressed: () => _archiveCase(),
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: "Delete",
                size: bs.md,
                onPressed: () => _deleteCase(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'pending':
        return warningColor;
      case 'closed':
        return disabledBoldColor;
      case 'on_hold':
        return infoColor;
      case 'draft':
        return primaryColor;
      default:
        return primaryColor;
    }
  }

  String _getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Case is currently being worked on';
      case 'pending':
        return 'Waiting for action or response';
      case 'closed':
        return 'Case has been completed or resolved';
      case 'on_hold':
        return 'Case is temporarily paused';
      case 'draft':
        return 'Case is in preparation phase';
      default:
        return 'Case status unknown';
    }
  }

  void _saveChanges() {
    if (formKey.currentState!.validate()) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        hasUnsavedChanges = false;
        lastModified = DateTime.now().toString().substring(0, 10);
        setState(() {});
        ss("Changes saved successfully");
      });
    }
  }

  void _viewCase() {
    // Navigate to case detail view
    back();
  }

  void _duplicateCase() {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Case duplicated successfully");
    });
  }

  void _archiveCase() async {
    bool isConfirmed = await confirm("Are you sure you want to archive this case?");
    if (isConfirmed) {
      showLoading();
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        ss("Case archived successfully");
        back();
      });
    }
  }

  void _deleteCase() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this case? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        ss("Case deleted successfully");
        back();
      });
    }
  }
}
