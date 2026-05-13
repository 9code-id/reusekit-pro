import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCreateTicketView extends StatefulWidget {
  const CrmCreateTicketView({super.key});

  @override
  State<CrmCreateTicketView> createState() => _CrmCreateTicketViewState();
}

class _CrmCreateTicketViewState extends State<CrmCreateTicketView> {
  final formKey = GlobalKey<FormState>();
  
  String subject = "";
  String description = "";
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String selectedPriority = "medium";
  String selectedCategory = "general";
  String selectedAssignee = "";
  String dueDate = "";
  String estimatedTime = "";
  List<String> tags = [];
  String newTag = "";
  List<String> attachments = [];
  bool sendNotification = true;
  bool addToKnowledgeBase = false;

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "General Inquiry", "value": "general"},
    {"label": "Technical Support", "value": "technical"},
    {"label": "Billing", "value": "billing"},
    {"label": "Bug Report", "value": "bug"},
    {"label": "Feature Request", "value": "feature"},
    {"label": "Account Issues", "value": "account"},
  ];

  List<Map<String, dynamic>> assigneeOptions = [
    {"label": "Auto Assign", "value": ""},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Wilson", "value": "mike_wilson"},
    {"label": "Lisa Chen", "value": "lisa_chen"},
    {"label": "David Park", "value": "david_park"},
    {"label": "Anna Lee", "value": "anna_lee"},
  ];

  List<Map<String, dynamic>> quickTemplates = [
    {
      "name": "Login Issue",
      "subject": "Unable to login to account",
      "description": "Customer is experiencing login difficulties. Please investigate authentication logs and check for any recent system changes.",
      "category": "technical",
      "priority": "high",
      "tags": ["login", "authentication", "urgent"]
    },
    {
      "name": "Billing Inquiry",
      "subject": "Question about billing charges",
      "description": "Customer has questions about their recent bill. Please review the account and provide detailed explanation of charges.",
      "category": "billing",
      "priority": "medium",
      "tags": ["billing", "charges", "inquiry"]
    },
    {
      "name": "Bug Report",
      "subject": "Application bug report",
      "description": "Customer has encountered a bug in the application. Please reproduce the issue and escalate to development team if necessary.",
      "category": "bug",
      "priority": "high",
      "tags": ["bug", "technical", "development"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Ticket"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              _showHelp();
            },
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
            children: [
              _buildQuickTemplates(),
              _buildCustomerInfo(),
              _buildTicketDetails(),
              _buildPriorityAndCategory(),
              _buildAssignmentInfo(),
              _buildTagsSection(),
              _buildAttachments(),
              _buildAdditionalOptions(),
              _buildSubmitButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTemplates() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Quick Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Use these templates to quickly create common ticket types",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          QHorizontalScroll(
            children: quickTemplates.map((template) => _buildTemplateCard(template)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    Color priorityColor = _getPriorityColor(template["priority"]);

    return Container(
      width: 200,
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: priorityColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "${template["name"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${template["description"]}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${template["priority"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: priorityColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Use Template",
              size: bs.sm,
              onPressed: () {
                _applyTemplate(template);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Search Customer",
                size: bs.sm,
                icon: Icons.search,
                onPressed: () {
                  _showCustomerSearch();
                },
              ),
            ],
          ),
          QTextField(
            label: "Customer Name",
            value: customerName,
            validator: Validator.required,
            onChanged: (value) {
              customerName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Email Address",
                  value: customerEmail,
                  validator: Validator.email,
                  onChanged: (value) {
                    customerEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: customerPhone,
                  onChanged: (value) {
                    customerPhone = value;
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

  Widget _buildTicketDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Ticket Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Subject",
            value: subject,
            hint: "Brief description of the issue",
            validator: Validator.required,
            onChanged: (value) {
              subject = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Detailed description of the issue, steps to reproduce, expected behavior, etc.",
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

  Widget _buildPriorityAndCategory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.priority_high, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Priority & Category",
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
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Priority determines how quickly the ticket should be resolved. Category helps route to the right team.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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

  Widget _buildAssignmentInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_ind, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Assignment & Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Assign to",
            items: assigneeOptions,
            value: selectedAssignee,
            onChanged: (value, label) {
              selectedAssignee = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Due Date",
                  value: dueDate.isNotEmpty ? DateTime.parse(dueDate) : DateTime.now().add(Duration(days: 3)),
                  onChanged: (value) {
                    dueDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Estimated Hours",
                  value: estimatedTime,
                  hint: "e.g., 2.5",
                  onChanged: (value) {
                    estimatedTime = value;
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

  Widget _buildTagsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.label, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Tags",
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
                  label: "Add tag",
                  value: newTag,
                  hint: "Type tag and press Enter",
                  onChanged: (value) {
                    newTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: () {
                  if (newTag.isNotEmpty && !tags.contains(newTag)) {
                    tags.add(newTag);
                    newTag = "";
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          if (tags.isNotEmpty) ...[
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: tags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          tags.remove(tag);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          size: 14,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttachments() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.attach_file, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Attachments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QAttachmentPicker(
            label: "Upload files",
            value: attachments,
            hint: "Screenshots, logs, documents, etc.",
            maxAttachments: 10,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Additional Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Send notification to customer",
            items: [
              {
                "label": "Send notification email",
                "value": true,
                "checked": sendNotification,
              }
            ],
            value: [
              if (sendNotification)
                {
                  "label": "Send notification email",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                sendNotification = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            label: "Knowledge base",
            items: [
              {
                "label": "Add solution to knowledge base when resolved",
                "value": true,
                "checked": addToKnowledgeBase,
              }
            ],
            value: [
              if (addToKnowledgeBase)
                {
                  "label": "Add solution to knowledge base when resolved",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                addToKnowledgeBase = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  icon: Icons.save,
                  onPressed: () {
                    _saveDraft();
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Create Ticket",
                  size: bs.md,
                  icon: Icons.check,
                  color: successColor,
                  onPressed: () {
                    _createTicket();
                  },
                ),
              ),
            ],
          ),
          QButton(
            label: "Create & Add Another",
            size: bs.md,
            icon: Icons.add,
            onPressed: () {
              _createAndAddAnother();
            },
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _applyTemplate(Map<String, dynamic> template) {
    subject = template["subject"];
    description = template["description"];
    selectedCategory = template["category"];
    selectedPriority = template["priority"];
    tags = List<String>.from(template["tags"]);
    setState(() {});
    ss("Template applied successfully");
  }

  void _showCustomerSearch() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Customer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Search",
              value: "",
              hint: "Name, email, or phone",
              onChanged: (value) {},
            ),
            Container(
              height: 200,
              child: Center(
                child: Text(
                  "Customer search results will appear here",
                  style: TextStyle(color: disabledBoldColor),
                ),
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Select",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Help & Tips"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Creating an Effective Ticket:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("• Use clear, descriptive subjects"),
            Text("• Provide detailed descriptions"),
            Text("• Set appropriate priority levels"),
            Text("• Add relevant tags for easy searching"),
            Text("• Include screenshots or logs when helpful"),
            SizedBox(height: spSm),
            Text(
              "Priority Guidelines:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("• Critical: System down, security issues"),
            Text("• High: Major functionality broken"),
            Text("• Medium: Minor bugs, general questions"),
            Text("• Low: Enhancement requests, documentation"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _saveDraft() {
    if (subject.isNotEmpty || description.isNotEmpty) {
      ss("Ticket saved as draft");
    } else {
      se("Please enter at least a subject or description");
    }
  }

  void _createTicket() {
    if (formKey.currentState!.validate()) {
      ss("Ticket created successfully!");
      back();
    }
  }

  void _createAndAddAnother() {
    if (formKey.currentState!.validate()) {
      ss("Ticket created! Ready for next ticket.");
      // Reset form fields
      subject = "";
      description = "";
      customerName = "";
      customerEmail = "";
      customerPhone = "";
      selectedPriority = "medium";
      selectedCategory = "general";
      selectedAssignee = "";
      dueDate = "";
      estimatedTime = "";
      tags.clear();
      newTag = "";
      attachments.clear();
      setState(() {});
    }
  }
}
