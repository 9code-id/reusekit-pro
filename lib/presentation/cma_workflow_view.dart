import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaWorkflowView extends StatefulWidget {
  const CmaWorkflowView({super.key});

  @override
  State<CmaWorkflowView> createState() => _CmaWorkflowViewState();
}

class _CmaWorkflowViewState extends State<CmaWorkflowView> {
  String selectedWorkflow = "";
  String searchQuery = "";
  int selectedTab = 0;

  List<Map<String, dynamic>> workflows = [
    {
      "id": "1",
      "name": "Lead Qualification Process",
      "description": "Automated lead scoring and qualification workflow",
      "status": "active",
      "triggers": ["Form Submission", "Email Engagement"],
      "steps": 8,
      "activeRuns": 245,
      "completedRuns": 1847,
      "successRate": 78.5,
      "averageTime": "2.5 hours",
      "createdDate": "2024-11-15",
      "lastModified": "2024-12-10",
      "category": "Lead Management",
      "priority": "high",
      "owner": "Marketing Team"
    },
    {
      "id": "2",
      "name": "Customer Onboarding Journey",
      "description": "Complete onboarding experience for new customers",
      "status": "active",
      "triggers": ["Account Creation", "First Purchase"],
      "steps": 12,
      "activeRuns": 156,
      "completedRuns": 987,
      "successRate": 85.2,
      "averageTime": "5 days",
      "createdDate": "2024-10-20",
      "lastModified": "2024-12-08",
      "category": "Onboarding",
      "priority": "high",
      "owner": "Customer Success"
    },
    {
      "id": "3",
      "name": "Content Approval Process",
      "description": "Multi-stage content review and approval workflow",
      "status": "active",
      "triggers": ["Content Submission"],
      "steps": 6,
      "activeRuns": 89,
      "completedRuns": 456,
      "successRate": 92.1,
      "averageTime": "1.5 days",
      "createdDate": "2024-09-10",
      "lastModified": "2024-12-05",
      "category": "Content Management",
      "priority": "medium",
      "owner": "Content Team"
    },
    {
      "id": "4",
      "name": "Support Ticket Routing",
      "description": "Intelligent ticket routing based on urgency and category",
      "status": "paused",
      "triggers": ["Ticket Creation", "Escalation"],
      "steps": 4,
      "activeRuns": 0,
      "completedRuns": 2345,
      "successRate": 89.7,
      "averageTime": "15 minutes",
      "createdDate": "2024-08-01",
      "lastModified": "2024-11-28",
      "category": "Support",
      "priority": "high",
      "owner": "Support Team"
    },
    {
      "id": "5",
      "name": "Sales Pipeline Management",
      "description": "Automated lead progression through sales stages",
      "status": "draft",
      "triggers": ["Lead Assignment", "Stage Change"],
      "steps": 10,
      "activeRuns": 0,
      "completedRuns": 0,
      "successRate": 0.0,
      "averageTime": "0",
      "createdDate": "2024-12-01",
      "lastModified": "2024-12-14",
      "category": "Sales",
      "priority": "high",
      "owner": "Sales Team"
    },
  ];

  List<Map<String, dynamic>> workflowSteps = [
    {
      "id": "1",
      "name": "Initial Trigger",
      "type": "trigger",
      "description": "Form submission detected",
      "status": "completed",
      "duration": "0s",
      "nextSteps": ["2", "3"]
    },
    {
      "id": "2",
      "name": "Lead Scoring",
      "type": "action",
      "description": "Calculate lead score based on form data",
      "status": "in_progress",
      "duration": "5m",
      "nextSteps": ["4"]
    },
    {
      "id": "3",
      "name": "Data Enrichment",
      "type": "action",
      "description": "Enrich lead data with external sources",
      "status": "pending",
      "duration": "10m",
      "nextSteps": ["4"]
    },
    {
      "id": "4",
      "name": "Qualification Check",
      "type": "condition",
      "description": "Check if lead meets qualification criteria",
      "status": "pending",
      "duration": "2m",
      "nextSteps": ["5", "6"]
    },
    {
      "id": "5",
      "name": "Assign to Sales",
      "type": "action",
      "description": "Assign qualified lead to sales rep",
      "status": "pending",
      "duration": "1m",
      "nextSteps": ["7"]
    },
    {
      "id": "6",
      "name": "Nurture Campaign",
      "type": "action",
      "description": "Add to nurture email sequence",
      "status": "pending",
      "duration": "3m",
      "nextSteps": ["8"]
    },
    {
      "id": "7",
      "name": "Sales Notification",
      "type": "notification",
      "description": "Send notification to assigned sales rep",
      "status": "pending",
      "duration": "1m",
      "nextSteps": []
    },
    {
      "id": "8",
      "name": "Follow-up Reminder",
      "type": "delay",
      "description": "Set reminder for follow-up in 3 days",
      "status": "pending",
      "duration": "3 days",
      "nextSteps": []
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "name": "Lead Management Flow",
      "description": "Complete lead capture to conversion workflow",
      "category": "Sales",
      "steps": 12,
      "estimatedTime": "2-4 hours",
      "complexity": "Advanced",
      "popularity": 95,
      "thumbnail": "https://picsum.photos/300/200?random=30&keyword=workflow"
    },
    {
      "id": "2",
      "name": "Customer Support Flow",
      "description": "Ticket routing and resolution workflow",
      "category": "Support",
      "steps": 8,
      "estimatedTime": "30 minutes",
      "complexity": "Intermediate",
      "popularity": 89,
      "thumbnail": "https://picsum.photos/300/200?random=31&keyword=support"
    },
    {
      "id": "3",
      "name": "Content Publishing Flow",
      "description": "Review, approve, and publish content",
      "category": "Content",
      "steps": 6,
      "estimatedTime": "1-2 days",
      "complexity": "Beginner",
      "popularity": 87,
      "thumbnail": "https://picsum.photos/300/200?random=32&keyword=content"
    },
    {
      "id": "4",
      "name": "Employee Onboarding",
      "description": "Complete employee onboarding process",
      "category": "HR",
      "steps": 15,
      "estimatedTime": "1 week",
      "complexity": "Advanced",
      "popularity": 82,
      "thumbnail": "https://picsum.photos/300/200?random=33&keyword=onboarding"
    },
  ];

  void _createWorkflow() {
    si("Opening workflow builder...");
  }

  void _editWorkflow(Map<String, dynamic> workflow) {
    si("Editing ${workflow["name"]}...");
  }

  void _duplicateWorkflow(Map<String, dynamic> workflow) {
    si("Workflow duplicated successfully");
  }

  void _deleteWorkflow(Map<String, dynamic> workflow) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this workflow?");
    if (isConfirmed) {
      ss("Workflow deleted successfully");
    }
  }

  void _pauseWorkflow(Map<String, dynamic> workflow) {
    si("Workflow paused");
    workflow["status"] = "paused";
    setState(() {});
  }

  void _resumeWorkflow(Map<String, dynamic> workflow) {
    si("Workflow resumed");
    workflow["status"] = "active";
    setState(() {});
  }

  void _viewAnalytics(Map<String, dynamic> workflow) {
    selectedWorkflow = workflow["id"];
    selectedTab = 2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workflow Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createWorkflow,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchSection(),
            _buildStatsSection(),
            _buildTabSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createWorkflow,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QTextField(
              label: "Search workflows...",
              value: searchQuery,
              hint: "Search by name or description",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    int activeCount = workflows.where((w) => w["status"] == "active").length;
    int totalSteps = workflows.map((w) => w["steps"] as int).reduce((a, b) => a + b);
    int totalRuns = workflows.map((w) => w["activeRuns"] as int).reduce((a, b) => a + b);
    double avgSuccess = workflows.isNotEmpty 
        ? workflows.map((w) => w["successRate"] as double).reduce((a, b) => a + b) / workflows.length
        : 0.0;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildStatCard("Active Workflows", activeCount, Icons.play_circle, Colors.green),
        _buildStatCard("Total Steps", totalSteps, Icons.list, Colors.blue),
        _buildStatCard("Running Instances", totalRuns, Icons.schedule, Colors.orange),
        _buildStatCard("Avg. Success Rate", "${avgSuccess.toStringAsFixed(1)}%", Icons.check_circle, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(String title, dynamic value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: spSm),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildTabButton("Workflows", 0),
                _buildTabButton("Builder", 1),
                _buildTabButton("Analytics", 2),
                _buildTabButton("Templates", 3),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: selectedTab == 0
                ? _buildWorkflowsTab()
                : selectedTab == 1
                    ? _buildBuilderTab()
                    : selectedTab == 2
                        ? _buildAnalyticsTab()
                        : _buildTemplatesTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? primaryColor : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkflowsTab() {
    return Column(
      spacing: spSm,
      children: workflows.map((workflow) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                          "${workflow["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(workflow["status"]),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildWorkflowInfo("Steps", "${workflow["steps"]}", Icons.list),
                  ),
                  Expanded(
                    child: _buildWorkflowInfo("Active", "${workflow["activeRuns"]}", Icons.play_circle),
                  ),
                  Expanded(
                    child: _buildWorkflowInfo("Success", "${(workflow["successRate"] as num).toStringAsFixed(1)}%", Icons.check_circle),
                  ),
                  Expanded(
                    child: _buildWorkflowInfo("Avg. Time", "${workflow["averageTime"]}", Icons.timer),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${workflow["category"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Owner: ${workflow["owner"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _viewAnalytics(workflow),
                    child: Icon(Icons.analytics, color: infoColor, size: 18),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _editWorkflow(workflow),
                    child: Icon(Icons.edit, color: warningColor, size: 18),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => workflow["status"] == "active" 
                        ? _pauseWorkflow(workflow)
                        : _resumeWorkflow(workflow),
                    child: Icon(
                      workflow["status"] == "active" ? Icons.pause : Icons.play_arrow,
                      color: workflow["status"] == "active" ? warningColor : successColor,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _duplicateWorkflow(workflow),
                    child: Icon(Icons.copy, color: primaryColor, size: 18),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _deleteWorkflow(workflow),
                    child: Icon(Icons.delete, color: dangerColor, size: 18),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case "active":
        color = successColor;
        break;
      case "paused":
        color = warningColor;
        break;
      case "draft":
        color = infoColor;
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildWorkflowInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 14),
        SizedBox(height: spXxs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBuilderTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(13),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: Colors.blue.withAlpha(51)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Workflow Builder",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Visual workflow builder with drag-and-drop interface",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(26),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lead Qualification Process",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            si("Saving workflow...");
                          },
                          child: Icon(Icons.save, color: successColor, size: 18),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            si("Testing workflow...");
                          },
                          child: Icon(Icons.play_arrow, color: infoColor, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spSm,
                    children: workflowSteps.map((step) {
                      return _buildWorkflowStep(step);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save Workflow",
                icon: Icons.save,
                size: bs.sm,
                onPressed: () {
                  ss("Workflow saved successfully");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Test Run",
                icon: Icons.play_arrow,
                size: bs.sm,
                onPressed: () {
                  si("Running workflow test...");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkflowStep(Map<String, dynamic> step) {
    Color statusColor;
    IconData stepIcon;
    
    switch (step["status"]) {
      case "completed":
        statusColor = successColor;
        break;
      case "in_progress":
        statusColor = warningColor;
        break;
      case "pending":
        statusColor = disabledColor;
        break;
      default:
        statusColor = disabledColor;
    }

    switch (step["type"]) {
      case "trigger":
        stepIcon = Icons.flash_on;
        break;
      case "action":
        stepIcon = Icons.settings;
        break;
      case "condition":
        stepIcon = Icons.help;
        break;
      case "notification":
        stepIcon = Icons.notifications;
        break;
      case "delay":
        stepIcon = Icons.timer;
        break;
      default:
        stepIcon = Icons.circle;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: statusColor.withAlpha(51)),
        borderRadius: BorderRadius.circular(radiusXs),
        color: statusColor.withAlpha(13),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(stepIcon, color: statusColor, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${step["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${step["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${step["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (step["duration"] != "0s")
                  Text(
                    "Duration: ${step["duration"]}",
                    style: TextStyle(
                      fontSize: 10,
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

  Widget _buildAnalyticsTab() {
    if (selectedWorkflow.isEmpty) {
      return Container(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.analytics, size: 48, color: disabledColor),
              SizedBox(height: spSm),
              Text(
                "Select a workflow to view analytics",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Map<String, dynamic> workflow = workflows.firstWhere((w) => w["id"] == selectedWorkflow);
    
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(13),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(51)),
          ),
          child: Row(
            children: [
              Icon(Icons.analytics, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "${workflow["name"]} Analytics",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        ResponsiveGridView(
          minItemWidth: 200,
          children: [
            _buildAnalyticsCard("Active Runs", "${workflow["activeRuns"]}", Icons.play_circle, Colors.green),
            _buildAnalyticsCard("Completed", "${workflow["completedRuns"]}", Icons.check_circle, Colors.blue),
            _buildAnalyticsCard("Success Rate", "${(workflow["successRate"] as num).toStringAsFixed(1)}%", Icons.trending_up, Colors.orange),
            _buildAnalyticsCard("Avg. Time", "${workflow["averageTime"]}", Icons.timer, Colors.purple),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Performance Over Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.show_chart, size: 48, color: disabledColor),
                      SizedBox(height: spSm),
                      Text(
                        "Workflow Performance Chart",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Track workflow execution metrics",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: templates.map((template) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                child: Image.network(
                  "${template["thumbnail"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${template["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "${template["steps"]} steps",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${template["complexity"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite, size: 12, color: dangerColor),
                            SizedBox(width: spXxs),
                            Text(
                              "${template["popularity"]}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Est. time: ${template["estimatedTime"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Use Template",
                        size: bs.sm,
                        onPressed: () {
                          si("Using ${template["name"]} template...");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
