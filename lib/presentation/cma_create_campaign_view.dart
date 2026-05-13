import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCreateCampaignView extends StatefulWidget {
  const CmaCreateCampaignView({super.key});

  @override
  State<CmaCreateCampaignView> createState() => _CmaCreateCampaignViewState();
}

class _CmaCreateCampaignViewState extends State<CmaCreateCampaignView> {
  final formKey = GlobalKey<FormState>();
  String campaignName = "";
  String description = "";
  String selectedAudience = "";
  String selectedTemplate = "";
  String subject = "";
  String content = "";
  DateTime scheduledDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay scheduledTime = TimeOfDay(hour: 9, minute: 0);
  bool isScheduled = false;
  bool enableTracking = true;
  String selectedBudget = "";
  List<String> selectedTags = [];
  List<String> attachments = [];

  List<Map<String, dynamic>> audienceOptions = [
    {"label": "All Subscribers", "value": "all"},
    {"label": "Active Customers", "value": "active"},
    {"label": "VIP Customers", "value": "vip"},
    {"label": "New Leads", "value": "leads"},
    {"label": "Inactive Users", "value": "inactive"},
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Newsletter Template", "value": "newsletter"},
    {"label": "Product Launch", "value": "product_launch"},
    {"label": "Promotional Campaign", "value": "promotional"},
    {"label": "Event Invitation", "value": "event"},
    {"label": "Welcome Series", "value": "welcome"},
    {"label": "Custom Template", "value": "custom"},
  ];

  List<Map<String, dynamic>> budgetOptions = [
    {"label": "\$100 - \$500", "value": "small"},
    {"label": "\$500 - \$1,000", "value": "medium"},
    {"label": "\$1,000 - \$5,000", "value": "large"},
    {"label": "\$5,000+", "value": "enterprise"},
  ];

  List<Map<String, dynamic>> tagOptions = [
    {"label": "Email Marketing", "value": "email", "checked": false},
    {"label": "Social Media", "value": "social", "checked": false},
    {"label": "Product Launch", "value": "product", "checked": false},
    {"label": "Holiday Campaign", "value": "holiday", "checked": false},
    {"label": "Retention", "value": "retention", "checked": false},
  ];

  void _createCampaign() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Campaign created successfully!");
        back();
      });
    }
  }

  void _saveDraft() {
    showLoading();
    
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      si("Campaign saved as draft");
    });
  }

  void _previewCampaign() {
    si("Opening campaign preview...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Campaign"),
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Text(
              "Save Draft",
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
            spacing: spMd,
            children: [
              _buildBasicInfoSection(),
              _buildAudienceSection(),
              _buildContentSection(),
              _buildSchedulingSection(),
              _buildBudgetSection(),
              _buildTagsSection(),
              _buildAttachmentsSection(),
              _buildSettingsSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
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
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Campaign Name",
            value: campaignName,
            hint: "Enter campaign name",
            validator: Validator.required,
            onChanged: (value) {
              campaignName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe your campaign objectives and target goals",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceSection() {
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
              Icon(Icons.people, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Target Audience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Audience",
            items: audienceOptions,
            value: selectedAudience,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedAudience = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(13),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.blue.withAlpha(51)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Estimated reach: 15,420 contacts",
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

  Widget _buildContentSection() {
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
              Icon(Icons.edit, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Campaign Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Email Template",
            items: templateOptions,
            value: selectedTemplate,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedTemplate = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Subject",
            value: subject,
            hint: "Enter compelling subject line",
            validator: Validator.required,
            onChanged: (value) {
              subject = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Email Content",
            value: content,
            hint: "Write your email content here...",
            validator: Validator.required,
            onChanged: (value) {
              content = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Preview Email",
              icon: Icons.preview,
              size: bs.sm,
              onPressed: _previewCampaign,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulingSection() {
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
              Icon(Icons.schedule, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Scheduling",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Schedule for later",
                "value": true,
                "checked": isScheduled,
              }
            ],
            value: [
              if (isScheduled)
                {
                  "label": "Schedule for later",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isScheduled = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (isScheduled) ...[
            QDatePicker(
              label: "Schedule Date",
              value: scheduledDate,
              validator: Validator.required,
              onChanged: (value) {
                scheduledDate = value;
                setState(() {});
              },
            ),
            QTimePicker(
              label: "Schedule Time",
              value: scheduledTime,
              validator: Validator.required,
              onChanged: (value) {
                scheduledTime = value!;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBudgetSection() {
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
              Icon(Icons.monetization_on, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Budget Planning",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Campaign Budget",
            items: budgetOptions,
            value: selectedBudget,
            onChanged: (value, label) {
              selectedBudget = value;
              setState(() {});
            },
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
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.label, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Campaign Tags",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: tagOptions,
            value: selectedTags.map((tag) {
              return tagOptions.firstWhere((item) => item["value"] == tag);
            }).toList(),
            onChanged: (values, ids) {
              selectedTags = values.map((item) => item["value"].toString()).toList();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection() {
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
              Icon(Icons.attachment, color: primaryColor, size: 20),
              SizedBox(width: spXs),
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
            label: "Campaign Files",
            value: attachments,
            hint: "Add images, documents, or other files",
            maxAttachments: 5,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
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
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Advanced Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable click tracking",
                "value": true,
                "checked": enableTracking,
              }
            ],
            value: [
              if (enableTracking)
                {
                  "label": "Enable click tracking",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              enableTracking = values.isNotEmpty;
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
            label: isScheduled ? "Schedule Campaign" : "Send Now",
            icon: isScheduled ? Icons.schedule_send : Icons.send,
            size: bs.md,
            onPressed: _createCampaign,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save Draft",
                icon: Icons.save,
                size: bs.sm,
                onPressed: _saveDraft,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Preview",
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: _previewCampaign,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
