import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsWorkflowAutomationView extends StatefulWidget {
  const DmsWorkflowAutomationView({super.key});

  @override
  State<DmsWorkflowAutomationView> createState() => _DmsWorkflowAutomationViewState();
}

class _DmsWorkflowAutomationViewState extends State<DmsWorkflowAutomationView> {
  int currentTab = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> workflows = [
    {
      "id": "invoice_approval",
      "name": "Invoice Approval Workflow",
      "description": "Multi-step approval process for invoices",
      "status": "Active",
      "steps": 4,
      "avgProcessTime": "2.5 hours",
      "successRate": 94.2,
      "totalRuns": 156,
      "lastRun": "2024-06-19 10:15",
      "priority": "High",
      "department": "Finance",
      "assignees": ["John Smith", "Sarah Wilson"],
    },
    {
      "id": "document_review",
      "name": "Document Review Process",
      "description": "Automated routing for document reviews",
      "status": "Active",
      "steps": 3,
      "avgProcessTime": "1.8 hours",
      "successRate": 98.7,
      "totalRuns": 243,
      "lastRun": "2024-06-19 11:30",
      "priority": "Medium",
      "department": "Legal",
      "assignees": ["Mike Johnson", "Lisa Brown"],
    },
    {
      "id": "contract_signing",
      "name": "Contract Signing Workflow",
      "description": "Digital signature workflow for contracts",
      "status": "Active",
      "steps": 5,
      "avgProcessTime": "4.2 hours",
      "successRate": 91.5,
      "totalRuns": 87,
      "lastRun": "2024-06-19 09:45",
      "priority": "High",
      "department": "Legal",
      "assignees": ["David Lee", "Emma Davis"],
    },
    {
      "id": "expense_approval",
      "name": "Expense Report Approval",
      "description": "Automated expense report processing",
      "status": "Paused",
      "steps": 3,
      "avgProcessTime": "1.2 hours",
      "successRate": 96.8,
      "totalRuns": 298,
      "lastRun": "2024-06-18 16:20",
      "priority": "Low",
      "department": "HR",
      "assignees": ["Tom Wilson", "Amy Clark"],
    },
    {
      "id": "policy_update",
      "name": "Policy Update Distribution",
      "description": "Workflow for distributing policy updates",
      "status": "Active",
      "steps": 6,
      "avgProcessTime": "6.5 hours",
      "successRate": 89.3,
      "totalRuns": 45,
      "lastRun": "2024-06-19 08:30",
      "priority": "Medium",
      "department": "HR",
      "assignees": ["Rachel Green", "Kevin White"],
    },
  ];

  final List<Map<String, dynamic>> workflowTemplates = [
    {
      "id": "approval_template",
      "name": "Approval Process Template",
      "description": "Standard multi-step approval workflow",
      "category": "Approval",
      "steps": 3,
      "icon": Icons.approval,
      "usageCount": 45,
    },
    {
      "id": "review_template",
      "name": "Review Process Template",
      "description": "Document review and feedback workflow",
      "category": "Review",
      "steps": 4,
      "icon": Icons.rate_review,
      "usageCount": 32,
    },
    {
      "id": "notification_template",
      "name": "Notification Workflow",
      "description": "Automated notification and reminder system",
      "category": "Communication",
      "steps": 2,
      "icon": Icons.notifications,
      "usageCount": 67,
    },
    {
      "id": "escalation_template",
      "name": "Escalation Process",
      "description": "Automated escalation for overdue tasks",
      "category": "Management",
      "steps": 5,
      "icon": Icons.trending_up,
      "usageCount": 23,
    },
  ];

  List<Map<String, dynamic>> get filteredWorkflows {
    return workflows.where((workflow) {
      return (workflow["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (workflow["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Workflow Automation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Workflows", icon: Icon(Icons.play_circle)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildActiveWorkflowsTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildActiveWorkflowsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
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
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // navigateTo('CreateWorkflowView')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${workflows.where((w) => w["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Runs",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${workflows.fold(0, (sum, w) => sum + (w["totalRuns"] as int))}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Workflows List
          Text(
            "Workflows (${filteredWorkflows.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...filteredWorkflows.map((workflow) {
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
                    color: workflow["status"] == "Active" ? successColor : warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${workflow["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${workflow["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: workflow["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${workflow["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: workflow["status"] == "Active" ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Steps: ${workflow["steps"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Avg Time: ${workflow["avgProcessTime"]}",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Success: ${(workflow["successRate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Runs: ${workflow["totalRuns"]}",
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
                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('WorkflowDetailView', arguments: workflow)
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('EditWorkflowView', arguments: workflow)
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: workflow["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                        size: bs.sm,
                        onPressed: () {
                          _toggleWorkflowStatus(workflow["id"] as String);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workflow Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: workflowTemplates.map((template) {
              return Container(
                padding: EdgeInsets.all(spSm),
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
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            template["icon"] as IconData,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${template["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "Steps: ${template["steps"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Used: ${template["usageCount"]}×",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Use Template",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('CreateWorkflowView', arguments: template)
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workflow Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Performance Metrics
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg Success Rate",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(workflows.fold(0.0, (sum, w) => sum + (w["successRate"] as double)) / workflows.length).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Processing Time",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "847.2h",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Department Performance
          Text(
            "Performance by Department",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                _buildDepartmentRow("Finance", 95.2, successColor),
                _buildDepartmentRow("Legal", 93.8, successColor),
                _buildDepartmentRow("HR", 91.5, primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentRow(String department, double percentage, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              department,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleWorkflowStatus(String workflowId) {
    final workflowIndex = workflows.indexWhere((workflow) => workflow["id"] == workflowId);
    if (workflowIndex != -1) {
      final currentStatus = workflows[workflowIndex]["status"];
      workflows[workflowIndex]["status"] = currentStatus == "Active" ? "Paused" : "Active";
      setState(() {});
      ss("Workflow status updated successfully");
    }
  }
}
