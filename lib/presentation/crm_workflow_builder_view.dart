import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmWorkflowBuilderView extends StatefulWidget {
  const CrmWorkflowBuilderView({super.key});

  @override
  State<CrmWorkflowBuilderView> createState() => _CrmWorkflowBuilderViewState();
}

class _CrmWorkflowBuilderViewState extends State<CrmWorkflowBuilderView> {
  String selectedWorkflowType = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  String workflowName = "";
  String workflowDescription = "";
  String triggerType = "Contact Created";
  String actionType = "Send Email";
  bool isActive = true;

  List<Map<String, dynamic>> workflowTypes = [
    {"label": "All", "value": "All"},
    {"label": "Lead Nurturing", "value": "Lead Nurturing"},
    {"label": "Customer Onboarding", "value": "Customer Onboarding"},
    {"label": "Follow-up", "value": "Follow-up"},
    {"label": "Re-engagement", "value": "Re-engagement"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Draft", "value": "Draft"},
  ];

  List<Map<String, dynamic>> triggerOptions = [
    {"label": "Contact Created", "value": "Contact Created"},
    {"label": "Deal Updated", "value": "Deal Updated"},
    {"label": "Email Opened", "value": "Email Opened"},
    {"label": "Form Submitted", "value": "Form Submitted"},
    {"label": "Date/Time", "value": "Date/Time"},
  ];

  List<Map<String, dynamic>> actionOptions = [
    {"label": "Send Email", "value": "Send Email"},
    {"label": "Create Task", "value": "Create Task"},
    {"label": "Update Contact", "value": "Update Contact"},
    {"label": "Add to List", "value": "Add to List"},
    {"label": "Send SMS", "value": "Send SMS"},
  ];

  List<Map<String, dynamic>> workflows = [
    {
      "id": "WF001",
      "name": "Welcome Email Series",
      "type": "Customer Onboarding",
      "status": "Active",
      "triggers": 3,
      "actions": 5,
      "contacts": 1250,
      "conversion_rate": 23.5,
      "created_date": "2024-01-15",
      "last_run": "2024-06-18",
    },
    {
      "id": "WF002",
      "name": "Lead Scoring",
      "type": "Lead Nurturing",
      "status": "Active",
      "triggers": 2,
      "actions": 3,
      "contacts": 850,
      "conversion_rate": 31.2,
      "created_date": "2024-02-10",
      "last_run": "2024-06-18",
    },
    {
      "id": "WF003",
      "name": "Abandoned Cart Recovery",
      "type": "Re-engagement",
      "status": "Active",
      "triggers": 1,
      "actions": 4,
      "contacts": 420,
      "conversion_rate": 18.7,
      "created_date": "2024-03-05",
      "last_run": "2024-06-17",
    },
    {
      "id": "WF004",
      "name": "Follow-up Sequence",
      "type": "Follow-up",
      "status": "Draft",
      "triggers": 2,
      "actions": 6,
      "contacts": 0,
      "conversion_rate": 0.0,
      "created_date": "2024-06-15",
      "last_run": "Never",
    },
  ];

  List<Map<String, dynamic>> workflowSteps = [
    {
      "id": "step1",
      "type": "trigger",
      "title": "Contact Created",
      "description": "When a new contact is added to the system",
      "icon": Icons.person_add,
      "color": primaryColor,
    },
    {
      "id": "step2",
      "type": "condition",
      "title": "Check Lead Source",
      "description": "If lead source is 'Website'",
      "icon": Icons.rule,
      "color": warningColor,
    },
    {
      "id": "step3",
      "type": "action",
      "title": "Send Welcome Email",
      "description": "Send personalized welcome email template",
      "icon": Icons.email,
      "color": successColor,
    },
    {
      "id": "step4",
      "type": "delay",
      "title": "Wait 3 Days",
      "description": "Delay before next action",
      "icon": Icons.schedule,
      "color": infoColor,
    },
    {
      "id": "step5",
      "type": "action",
      "title": "Create Follow-up Task",
      "description": "Assign task to sales representative",
      "icon": Icons.task,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workflow Builder"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _showCreateWorkflowDialog(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search workflows...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: workflowTypes,
                    value: selectedWorkflowType,
                    onChanged: (value, label) {
                      selectedWorkflowType = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Workflow Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard("Total Workflows", "12", Icons.account_tree, primaryColor),
                _buildMetricCard("Active Workflows", "8", Icons.play_circle, successColor),
                _buildMetricCard("Total Contacts", "2,520", Icons.people, infoColor),
                _buildMetricCard("Avg Conversion", "24.3%", Icons.trending_up, warningColor),
              ],
            ),

            // Workflow List
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.account_tree, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Workflows",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Create Workflow",
                          size: bs.sm,
                          onPressed: () => _showCreateWorkflowDialog(),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ...workflows.map((workflow) => _buildWorkflowItem(workflow)),
                ],
              ),
            ),

            // Workflow Builder Canvas
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.build, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Workflow Canvas",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Save Workflow",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spSm,
                      children: workflowSteps.map((step) => _buildWorkflowStep(step)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowItem(Map<String, dynamic> workflow) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${workflow["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${workflow["type"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: workflow["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${workflow["status"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: workflow["status"] == "Active" ? successColor : warningColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${workflow["triggers"]}T / ${workflow["actions"]}A",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${(workflow["conversion_rate"] as num).toStringAsFixed(1)}%",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowStep(Map<String, dynamic> step) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: (step["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: (step["color"] as Color).withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: step["color"] as Color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              step["icon"] as IconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${step["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void _showCreateWorkflowDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Workflow"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Workflow Name",
                value: workflowName,
                onChanged: (value) {
                  workflowName = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: workflowDescription,
                onChanged: (value) {
                  workflowDescription = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Trigger Type",
                items: triggerOptions,
                value: triggerType,
                onChanged: (value, label) {
                  triggerType = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "First Action",
                items: actionOptions,
                value: actionType,
                onChanged: (value, label) {
                  actionType = value;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Active",
                    "value": true,
                    "checked": isActive,
                  }
                ],
                value: [if (isActive) {"label": "Active", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setState(() {
                    isActive = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Workflow created successfully");
            },
          ),
        ],
      ),
    );
  }
}
