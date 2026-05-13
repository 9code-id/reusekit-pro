import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaEmailTemplatesView extends StatefulWidget {
  const CmaEmailTemplatesView({super.key});

  @override
  State<CmaEmailTemplatesView> createState() => _CmaEmailTemplatesViewState();
}

class _CmaEmailTemplatesViewState extends State<CmaEmailTemplatesView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedUsage = "";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Sales", "value": "sales"},
    {"label": "Support", "value": "support"},
    {"label": "Follow-up", "value": "follow_up"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "Proposal", "value": "proposal"},
    {"label": "Welcome", "value": "welcome"},
    {"label": "Thank You", "value": "thank_you"},
  ];
  
  List<Map<String, dynamic>> usageOptions = [
    {"label": "All Usage", "value": ""},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
    {"label": "New", "value": "new"},
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": "1",
      "name": "Initial Client Follow-up",
      "category": "follow_up",
      "subject": "Thank you for your interest - Next Steps",
      "description": "Standard follow-up template for new client inquiries",
      "content": "Dear [CLIENT_NAME],\n\nThank you for your interest in our services. I wanted to follow up on our recent conversation and provide you with the next steps.\n\nBased on our discussion, I understand that you're looking for [SERVICE_TYPE] to help with [CLIENT_NEEDS]. I'm confident that our team can provide exactly what you're looking for.\n\nNext steps:\n1. Review the attached proposal\n2. Schedule a detailed consultation\n3. Discuss timeline and implementation\n\nI've attached our service overview and some case studies that demonstrate our success with similar projects.\n\nPlease let me know if you have any questions or would like to schedule a call to discuss further.\n\nBest regards,\n[SENDER_NAME]\n[SENDER_TITLE]\n[COMPANY_NAME]",
      "variables": ["CLIENT_NAME", "SERVICE_TYPE", "CLIENT_NEEDS", "SENDER_NAME", "SENDER_TITLE", "COMPANY_NAME"],
      "usage": "high",
      "lastUsed": "2024-12-20",
      "timesUsed": 47,
      "createdBy": "John Smith",
      "createdDate": "2024-10-15",
      "tags": ["follow-up", "new-client", "consultation"],
      "isActive": true,
    },
    {
      "id": "2",
      "name": "Project Proposal Submission",
      "category": "proposal",
      "subject": "Project Proposal - [PROJECT_NAME]",
      "description": "Template for submitting project proposals to clients",
      "content": "Dear [CLIENT_NAME],\n\nI'm pleased to submit our proposal for [PROJECT_NAME]. After careful consideration of your requirements, we've developed a comprehensive solution that addresses all your key objectives.\n\nProject Overview:\n- Scope: [PROJECT_SCOPE]\n- Timeline: [PROJECT_TIMELINE]\n- Investment: [PROJECT_COST]\n- Key Benefits: [PROJECT_BENEFITS]\n\nOur team has extensive experience in similar projects and we're confident in delivering exceptional results. The attached proposal includes:\n\n✓ Detailed project plan\n✓ Timeline and milestones\n✓ Resource allocation\n✓ Investment breakdown\n✓ Terms and conditions\n\nI would welcome the opportunity to present this proposal in person and answer any questions you may have.\n\nPlease review the attached documents and let me know your thoughts.\n\nBest regards,\n[SENDER_NAME]\n[SENDER_TITLE]",
      "variables": ["CLIENT_NAME", "PROJECT_NAME", "PROJECT_SCOPE", "PROJECT_TIMELINE", "PROJECT_COST", "PROJECT_BENEFITS", "SENDER_NAME", "SENDER_TITLE"],
      "usage": "high",
      "lastUsed": "2024-12-19",
      "timesUsed": 32,
      "createdBy": "Emily Davis",
      "createdDate": "2024-09-22",
      "tags": ["proposal", "project", "submission"],
      "isActive": true,
    },
    {
      "id": "3",
      "name": "Meeting Confirmation",
      "category": "meeting",
      "subject": "Meeting Confirmation - [MEETING_DATE]",
      "description": "Template to confirm scheduled meetings with clients",
      "content": "Dear [CLIENT_NAME],\n\nI hope this email finds you well. I'm writing to confirm our upcoming meeting scheduled for:\n\nDate: [MEETING_DATE]\nTime: [MEETING_TIME]\nLocation: [MEETING_LOCATION]\nDuration: [MEETING_DURATION]\n\nMeeting Agenda:\n[MEETING_AGENDA]\n\nTo ensure we make the most of our time together, please:\n- Review the attached materials\n- Prepare any questions you may have\n- Confirm your attendance\n\nIf you need to reschedule or have any questions, please don't hesitate to reach out.\n\nI look forward to our productive discussion.\n\nBest regards,\n[SENDER_NAME]\n[SENDER_TITLE]\n[CONTACT_INFO]",
      "variables": ["CLIENT_NAME", "MEETING_DATE", "MEETING_TIME", "MEETING_LOCATION", "MEETING_DURATION", "MEETING_AGENDA", "SENDER_NAME", "SENDER_TITLE", "CONTACT_INFO"],
      "usage": "medium",
      "lastUsed": "2024-12-18",
      "timesUsed": 28,
      "createdBy": "Michael Johnson",
      "createdDate": "2024-11-05",
      "tags": ["meeting", "confirmation", "agenda"],
      "isActive": true,
    },
    {
      "id": "4",
      "name": "Support Ticket Response",
      "category": "support",
      "subject": "Re: Support Ticket #[TICKET_NUMBER]",
      "description": "Standard response template for customer support inquiries",
      "content": "Dear [CLIENT_NAME],\n\nThank you for contacting our support team. We have received your inquiry regarding [ISSUE_DESCRIPTION] and have assigned ticket number #[TICKET_NUMBER] for your reference.\n\nI understand that you're experiencing [ISSUE_DETAILS]. Our team is currently investigating this matter and we expect to have a resolution within [RESOLUTION_TIME].\n\nIn the meantime, here are some steps you can try:\n[TROUBLESHOOTING_STEPS]\n\nWe will keep you updated on our progress and notify you as soon as we have a solution.\n\nIf you have any additional information that might help us resolve this issue faster, please reply to this email.\n\nThank you for your patience.\n\nBest regards,\n[SUPPORT_AGENT_NAME]\nCustomer Support Team\n[COMPANY_NAME]",
      "variables": ["CLIENT_NAME", "TICKET_NUMBER", "ISSUE_DESCRIPTION", "ISSUE_DETAILS", "RESOLUTION_TIME", "TROUBLESHOOTING_STEPS", "SUPPORT_AGENT_NAME", "COMPANY_NAME"],
      "usage": "medium",
      "lastUsed": "2024-12-17",
      "timesUsed": 56,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-08-10",
      "tags": ["support", "ticket", "response"],
      "isActive": true,
    },
    {
      "id": "5",
      "name": "Welcome New Client",
      "category": "welcome",
      "subject": "Welcome to [COMPANY_NAME] - Getting Started",
      "description": "Welcome template for newly onboarded clients",
      "content": "Dear [CLIENT_NAME],\n\nWelcome to [COMPANY_NAME]! We're thrilled to have you as our new client and look forward to a successful partnership.\n\nYour account has been set up and you can now access our services. Here's what you need to get started:\n\n🎯 Your Account Details:\n- Account ID: [ACCOUNT_ID]\n- Primary Contact: [PRIMARY_CONTACT]\n- Account Manager: [ACCOUNT_MANAGER]\n\n📋 Next Steps:\n1. Complete your profile setup\n2. Schedule your onboarding call\n3. Review our getting started guide\n4. Access your dashboard\n\n📞 Support Information:\n- Phone: [SUPPORT_PHONE]\n- Email: [SUPPORT_EMAIL]\n- Hours: [SUPPORT_HOURS]\n\nWe've attached a comprehensive getting started guide and our contact directory for your reference.\n\nIf you have any questions or need assistance, don't hesitate to reach out. We're here to ensure your success.\n\nWelcome aboard!\n\nBest regards,\n[SENDER_NAME]\nClient Success Manager",
      "variables": ["CLIENT_NAME", "COMPANY_NAME", "ACCOUNT_ID", "PRIMARY_CONTACT", "ACCOUNT_MANAGER", "SUPPORT_PHONE", "SUPPORT_EMAIL", "SUPPORT_HOURS", "SENDER_NAME"],
      "usage": "low",
      "lastUsed": "2024-12-15",
      "timesUsed": 15,
      "createdBy": "David Brown",
      "createdDate": "2024-11-20",
      "tags": ["welcome", "onboarding", "new-client"],
      "isActive": true,
    },
    {
      "id": "6",
      "name": "Thank You After Meeting",
      "category": "thank_you",
      "subject": "Thank you for your time - [MEETING_TOPIC]",
      "description": "Thank you template to send after client meetings",
      "content": "Dear [CLIENT_NAME],\n\nThank you for taking the time to meet with me today to discuss [MEETING_TOPIC]. I found our conversation very insightful and I'm excited about the opportunities ahead.\n\nKey points from our discussion:\n[MEETING_SUMMARY]\n\nAction items moving forward:\n[ACTION_ITEMS]\n\nNext steps:\n[NEXT_STEPS]\n\nI've attached [ATTACHMENTS] as discussed during our meeting.\n\nPlease feel free to reach out if you have any questions or if there's anything else I can help clarify.\n\nI look forward to continuing our partnership and achieving great results together.\n\nBest regards,\n[SENDER_NAME]\n[SENDER_TITLE]\n[CONTACT_INFO]",
      "variables": ["CLIENT_NAME", "MEETING_TOPIC", "MEETING_SUMMARY", "ACTION_ITEMS", "NEXT_STEPS", "ATTACHMENTS", "SENDER_NAME", "SENDER_TITLE", "CONTACT_INFO"],
      "usage": "high",
      "lastUsed": "2024-12-16",
      "timesUsed": 41,
      "createdBy": "Emily Davis",
      "createdDate": "2024-10-30",
      "tags": ["thank-you", "meeting", "follow-up"],
      "isActive": true,
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return emailTemplates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          (template["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["subject"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || template["category"] == selectedCategory;
      bool matchesUsage = selectedUsage.isEmpty || template["usage"] == selectedUsage;
      bool isActive = template["isActive"] as bool;
      
      return matchesSearch && matchesCategory && matchesUsage && isActive;
    }).toList()
      ..sort((a, b) => (b["timesUsed"] as int).compareTo(a["timesUsed"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Templates"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create template
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: _buildTemplatesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    int totalTemplates = emailTemplates.where((t) => t["isActive"] == true).length;
    int salesTemplates = emailTemplates.where((t) => t["category"] == "sales" && t["isActive"] == true).length;
    int supportTemplates = emailTemplates.where((t) => t["category"] == "support" && t["isActive"] == true).length;
    int highUsageTemplates = emailTemplates.where((t) => t["usage"] == "high" && t["isActive"] == true).length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Template Library",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", totalTemplates, Colors.white),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Sales", salesTemplates, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Support", supportTemplates, infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Popular", highUsageTemplates, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Templates",
            value: searchQuery,
            hint: "Search by name, description, or subject",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Usage",
                  items: usageOptions,
                  value: selectedUsage,
                  onChanged: (value, label) {
                    selectedUsage = value;
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

  Widget _buildTemplatesList() {
    if (filteredTemplates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.email,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No templates found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters or create a new template",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredTemplates.length,
      itemBuilder: (context, index) {
        final template = filteredTemplates[index];
        return _buildTemplateCard(template, index);
      },
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template, int index) {
    Color categoryColor = _getCategoryColor(template["category"]);
    Color usageColor = _getUsageColor(template["usage"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["category"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: categoryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Subject: ${template["subject"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${template["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.trending_up,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Used ${(template["timesUsed"] as int)} times",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Last used: ${template["lastUsed"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Created by: ${template["createdBy"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: usageColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["usage"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: usageColor,
                  ),
                ),
              ),
            ],
          ),
          if ((template["variables"] as List).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Variables:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (template["variables"] as List).map((variable) => Text(
                      "[$variable]",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontFamily: 'monospace',
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          if ((template["tags"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              children: (template["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$tag",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                  ),
                ),
              )).toList(),
            ),
          Row(
            children: [
              QButton(
                icon: Icons.send,
                size: bs.sm,
                onPressed: () {
                  _useTemplate(template);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Navigate to edit template
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {
                  _duplicateTemplate(template);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  _previewTemplate(template);
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showTemplateActions(template);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "sales":
        return primaryColor;
      case "support":
        return infoColor;
      case "follow_up":
        return warningColor;
      case "meeting":
        return successColor;
      case "proposal":
        return dangerColor;
      case "welcome":
        return successColor;
      case "thank_you":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUsageColor(String usage) {
    switch (usage) {
      case "high":
        return successColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      case "new":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    // Increment usage count
    setState(() {
      int index = emailTemplates.indexWhere((t) => t["id"] == template["id"]);
      if (index != -1) {
        emailTemplates[index]["timesUsed"] = (emailTemplates[index]["timesUsed"] as int) + 1;
        emailTemplates[index]["lastUsed"] = DateTime.now().toString().split(' ')[0];
      }
    });
    
    ss("Template '${template["name"]}' opened in email composer");
  }

  void _duplicateTemplate(Map<String, dynamic> template) {
    Map<String, dynamic> newTemplate = Map.from(template);
    newTemplate["id"] = DateTime.now().millisecondsSinceEpoch.toString();
    newTemplate["name"] = "Copy of ${template["name"]}";
    newTemplate["timesUsed"] = 0;
    newTemplate["usage"] = "new";
    newTemplate["createdDate"] = DateTime.now().toString().split(' ')[0];
    
    setState(() {
      emailTemplates.add(newTemplate);
    });
    
    ss("Template duplicated successfully");
  }

  void _previewTemplate(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Template Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => back(),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Template: ${template["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Subject: ${template["subject"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                  Text(
                    "Category: ${template["category"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Text(
              "Content:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: disabledColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    "${template["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Use Template",
                    size: bs.md,
                    onPressed: () {
                      back();
                      _useTemplate(template);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Edit Template",
                    size: bs.md,
                    onPressed: () {
                      back();
                      // Navigate to edit
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTemplateActions(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Template Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Export Template",
                size: bs.md,
                onPressed: () {
                  back();
                  _exportTemplate(template);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Share Template",
                size: bs.md,
                onPressed: () {
                  back();
                  _shareTemplate(template);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Usage Statistics",
                size: bs.md,
                onPressed: () {
                  back();
                  _viewTemplateStats(template);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Deactivate Template",
                size: bs.md,
                onPressed: () {
                  back();
                  _deactivateTemplate(template);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _exportTemplate(Map<String, dynamic> template) {
    ss("Template '${template["name"]}' exported successfully");
  }

  void _shareTemplate(Map<String, dynamic> template) {
    ss("Template '${template["name"]}' shared with team");
  }

  void _viewTemplateStats(Map<String, dynamic> template) {
    ss("Viewing usage statistics for '${template["name"]}'");
  }

  void _deactivateTemplate(Map<String, dynamic> template) async {
    bool isConfirmed = await confirm("Are you sure you want to deactivate this template?");
    if (isConfirmed) {
      setState(() {
        int index = emailTemplates.indexWhere((t) => t["id"] == template["id"]);
        if (index != -1) {
          emailTemplates[index]["isActive"] = false;
        }
      });
      ss("Template deactivated successfully");
    }
  }
}
