import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseManagementView extends StatefulWidget {
  const LcaCaseManagementView({super.key});

  @override
  State<LcaCaseManagementView> createState() => _LcaCaseManagementViewState();
}

class _LcaCaseManagementViewState extends State<LcaCaseManagementView> {
  String caseTitle = "";
  String caseType = "Civil Litigation";
  String caseStatus = "Active";
  String priority = "High";
  String clientName = "";
  String clientEmail = "";
  String clientPhone = "";
  String description = "";
  String assignedLawyer = "";
  String courtName = "";
  String judeName = "";
  String caseNumber = "";
  DateTime filingDate = DateTime.now();
  DateTime hearingDate = DateTime.now().add(Duration(days: 30));
  String caseValue = "";
  String legalFees = "";
  String retainerAmount = "";
  
  List<Map<String, dynamic>> caseTypes = [
    {"label": "Civil Litigation", "value": "Civil Litigation"},
    {"label": "Criminal Defense", "value": "Criminal Defense"},
    {"label": "Corporate Law", "value": "Corporate Law"},
    {"label": "Family Law", "value": "Family Law"},
    {"label": "Real Estate", "value": "Real Estate"},
    {"label": "Immigration", "value": "Immigration"},
    {"label": "Personal Injury", "value": "Personal Injury"},
    {"label": "Employment Law", "value": "Employment Law"},
    {"label": "Intellectual Property", "value": "Intellectual Property"},
    {"label": "Tax Law", "value": "Tax Law"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Closed", "value": "Closed"},
    {"label": "Settled", "value": "Settled"},
    {"label": "Dismissed", "value": "Dismissed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> lawyers = [
    {"label": "Sarah Johnson - Senior Partner", "value": "sarah_johnson"},
    {"label": "Michael Chen - Associate", "value": "michael_chen"},
    {"label": "Emily Rodriguez - Partner", "value": "emily_rodriguez"},
    {"label": "David Thompson - Senior Associate", "value": "david_thompson"},
    {"label": "Lisa Anderson - Junior Associate", "value": "lisa_anderson"},
  ];

  List<String> documents = [];
  List<String> attachments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Management"),
        actions: [
          QButton(
            label: "Save Case",
            size: bs.sm,
            onPressed: () => _saveCase(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCaseBasicInfo(),
            _buildClientInformation(),
            _buildCaseDetails(),
            _buildLegalTeam(),
            _buildFinancialInfo(),
            _buildDocumentsSection(),
            _buildTimelineSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseBasicInfo() {
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
            children: [
              Icon(
                Icons.gavel,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
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
          Divider(),
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
          QTextField(
            label: "Case Number",
            value: caseNumber,
            hint: "Enter court case number",
            validator: Validator.required,
            onChanged: (value) {
              caseNumber = value;
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: caseStatus,
                  onChanged: (value, label) {
                    caseStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Priority Level",
            items: priorityOptions,
            value: priority,
            onChanged: (value, label) {
              priority = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Case Description",
            value: description,
            hint: "Provide detailed case description and background",
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

  Widget _buildClientInformation() {
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
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
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
          Divider(),
          QTextField(
            label: "Client Name",
            value: clientName,
            hint: "Enter full client name",
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
                  label: "Email Address",
                  value: clientEmail,
                  hint: "client@example.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    clientEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: clientPhone,
                  hint: "+1 (555) 123-4567",
                  validator: Validator.required,
                  onChanged: (value) {
                    clientPhone = value;
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

  Widget _buildCaseDetails() {
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
            children: [
              Icon(
                Icons.info,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Court & Case Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QTextField(
            label: "Court Name",
            value: courtName,
            hint: "Enter court name and jurisdiction",
            onChanged: (value) {
              courtName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Judge Name",
            value: judeName,
            hint: "Enter presiding judge name",
            onChanged: (value) {
              judeName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Filing Date",
                  value: filingDate,
                  onChanged: (value) {
                    filingDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Next Hearing Date",
                  value: hearingDate,
                  onChanged: (value) {
                    hearingDate = value;
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

  Widget _buildLegalTeam() {
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
            children: [
              Icon(
                Icons.groups,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Legal Team Assignment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QDropdownField(
            label: "Assigned Lawyer",
            items: lawyers,
            value: assignedLawyer,
            onChanged: (value, label) {
              assignedLawyer = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.blue.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Team Collaboration",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Additional team members can be assigned from the case overview page. You can also set specific roles and permissions for each team member.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialInfo() {
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
            children: [
              Icon(
                Icons.attach_money,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Financial Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Case Value (\$)",
                  value: caseValue,
                  hint: "Estimated case value",
                  onChanged: (value) {
                    caseValue = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Legal Fees (\$)",
                  value: legalFees,
                  hint: "Expected legal fees",
                  onChanged: (value) {
                    legalFees = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Retainer Amount (\$)",
            value: retainerAmount,
            hint: "Client retainer amount",
            onChanged: (value) {
              retainerAmount = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection() {
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
            children: [
              Icon(
                Icons.folder,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Documents & Attachments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QMultiImagePicker(
            label: "Case Documents",
            value: documents,
            hint: "Upload legal documents, evidence, and case files",
            onChanged: (value) {
              documents = value;
              setState(() {});
            },
          ),
          QAttachmentPicker(
            label: "Additional Attachments",
            value: attachments,
            hint: "Upload additional files (contracts, correspondence, etc.)",
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
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
            children: [
              Icon(
                Icons.timeline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Case Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Timeline management available after case creation",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "You'll be able to add milestones, deadlines, and track case progress from the case overview page.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Save as Draft",
            size: bs.md,
            onPressed: () => _saveDraft(),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Create Case",
            size: bs.md,
            onPressed: () => _createCase(),
          ),
        ),
      ],
    );
  }

  void _saveCase() {
    ss("Case information saved successfully");
  }

  void _saveDraft() {
    ss("Case saved as draft");
  }

  void _createCase() async {
    if (caseTitle.isEmpty || clientName.isEmpty || description.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Case created successfully");
    
    // Navigate back or to case overview
    back();
  }
}
