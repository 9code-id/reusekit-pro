import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmEmailAutomationView extends StatefulWidget {
  const CrmEmailAutomationView({super.key});

  @override
  State<CrmEmailAutomationView> createState() => _CrmEmailAutomationViewState();
}

class _CrmEmailAutomationViewState extends State<CrmEmailAutomationView> {
  final formKey = GlobalKey<FormState>();
  String automationName = "";
  String selectedTrigger = "Lead Created";
  String emailSubject = "";
  String emailContent = "";
  String delayHours = "0";
  String selectedTemplate = "Welcome Email";
  bool isActive = true;
  List<Map<String, dynamic>> conditions = [];
  String selectedCondition = "Lead Source";
  String conditionValue = "";

  List<Map<String, dynamic>> triggerOptions = [
    {"label": "Lead Created", "value": "lead_created"},
    {"label": "Contact Updated", "value": "contact_updated"},
    {"label": "Deal Won", "value": "deal_won"},
    {"label": "Deal Lost", "value": "deal_lost"},
    {"label": "Email Opened", "value": "email_opened"},
    {"label": "Link Clicked", "value": "link_clicked"},
    {"label": "Form Submitted", "value": "form_submitted"},
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Welcome Email", "value": "welcome"},
    {"label": "Follow-up Email", "value": "followup"},
    {"label": "Thank You Email", "value": "thankyou"},
    {"label": "Promotional Email", "value": "promotional"},
    {"label": "Reminder Email", "value": "reminder"},
  ];

  List<Map<String, dynamic>> conditionOptions = [
    {"label": "Lead Source", "value": "lead_source"},
    {"label": "Company Size", "value": "company_size"},
    {"label": "Industry", "value": "industry"},
    {"label": "Location", "value": "location"},
    {"label": "Deal Value", "value": "deal_value"},
  ];

  List<Map<String, dynamic>> automations = [
    {
      "id": "1",
      "name": "Welcome Series",
      "trigger": "Lead Created",
      "emails": 3,
      "active": true,
      "sent": 245,
      "opened": 189,
      "clicked": 67,
    },
    {
      "id": "2",
      "name": "Follow-up Sequence",
      "trigger": "Deal Won",
      "emails": 2,
      "active": true,
      "sent": 156,
      "opened": 134,
      "clicked": 45,
    },
    {
      "id": "3",
      "name": "Re-engagement Campaign",
      "trigger": "Email Opened",
      "emails": 4,
      "active": false,
      "sent": 98,
      "opened": 42,
      "clicked": 12,
    },
  ];

  int currentTab = 0;

  void _addCondition() {
    if (conditionValue.isNotEmpty) {
      conditions.add({
        "condition": selectedCondition,
        "value": conditionValue,
      });
      conditionValue = "";
      setState(() {});
    }
  }

  void _removeCondition(int index) {
    conditions.removeAt(index);
    setState(() {});
  }

  void _createAutomation() {
    if (formKey.currentState!.validate()) {
      ss("Email automation created successfully");
      back();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Sent",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "1,245",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.mark_email_read, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Open Rate",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "68.5%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.mouse, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Click Rate",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "24.3%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.autorenew, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Active Automations",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email Automations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Create New",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        currentTab = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: automations.map((automation) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${automation["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Trigger: ${automation["trigger"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (automation["active"] as bool)
                                      ? successColor.withAlpha(10)
                                      : dangerColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  (automation["active"] as bool) ? "Active" : "Inactive",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (automation["active"] as bool)
                                        ? successColor
                                        : dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${automation["emails"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Emails",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${automation["sent"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: infoColor,
                                      ),
                                    ),
                                    Text(
                                      "Sent",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${automation["opened"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Opened",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${automation["clicked"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      "Clicked",
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
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "Automation Name",
              value: automationName,
              hint: "Enter automation name",
              validator: Validator.required,
              onChanged: (value) {
                automationName = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Trigger Event",
              items: triggerOptions,
              value: selectedTrigger,
              onChanged: (value, label) {
                selectedTrigger = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Delay (Hours)",
              value: delayHours,
              hint: "0 for immediate sending",
              onChanged: (value) {
                delayHours = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Conditions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Condition",
                          items: conditionOptions,
                          value: selectedCondition,
                          onChanged: (value, label) {
                            selectedCondition = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Value",
                          value: conditionValue,
                          hint: "Enter condition value",
                          onChanged: (value) {
                            conditionValue = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: _addCondition,
                      ),
                    ],
                  ),
                  if (conditions.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Column(
                      spacing: spXs,
                      children: conditions.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map condition = entry.value;
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${condition["condition"]}: ${condition["value"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _removeCondition(index),
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: dangerColor,
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
            ),
            QDropdownField(
              label: "Email Template",
              items: templateOptions,
              value: selectedTemplate,
              onChanged: (value, label) {
                selectedTemplate = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Email Subject",
              value: emailSubject,
              hint: "Enter email subject",
              validator: Validator.required,
              onChanged: (value) {
                emailSubject = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Email Content",
              value: emailContent,
              hint: "Enter email content...",
              validator: Validator.required,
              onChanged: (value) {
                emailContent = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Active",
                        "value": true,
                        "checked": isActive,
                      }
                    ],
                    value: [
                      if (isActive)
                        {
                          "label": "Active",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      isActive = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Automation",
                size: bs.md,
                onPressed: _createAutomation,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Automation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCreateTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
