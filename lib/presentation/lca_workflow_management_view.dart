import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaWorkflowManagementView extends StatefulWidget {
  const LcaWorkflowManagementView({super.key});

  @override
  State<LcaWorkflowManagementView> createState() => _LcaWorkflowManagementViewState();
}

class _LcaWorkflowManagementViewState extends State<LcaWorkflowManagementView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> workflows = [
    {
      "id": "WF001",
      "name": "Personal Injury Case Workflow",
      "description": "Standard workflow for personal injury cases from intake to settlement",
      "type": "case_type",
      "status": "active",
      "created_date": "2024-01-15",
      "last_modified": "2024-06-10",
      "total_steps": 12,
      "active_cases": 8,
      "completion_rate": 85.5,
      "avg_duration": 180, // days
      "category": "litigation",
      "trigger": "case_type_assignment",
      "automated": true,
      "steps": [
        {"id": 1, "name": "Initial Client Consultation", "type": "meeting", "estimated_days": 1},
        {"id": 2, "name": "Medical Records Request", "type": "document", "estimated_days": 7},
        {"id": 3, "name": "Accident Report Review", "type": "analysis", "estimated_days": 3},
        {"id": 4, "name": "Insurance Demand Letter", "type": "document", "estimated_days": 5},
        {"id": 5, "name": "Discovery Phase", "type": "legal_process", "estimated_days": 90},
      ],
    },
    {
      "id": "WF002",
      "name": "Contract Review Workflow",
      "description": "Workflow for reviewing and negotiating business contracts",
      "type": "document_type",
      "status": "active",
      "created_date": "2024-02-20",
      "last_modified": "2024-06-15",
      "total_steps": 8,
      "active_cases": 15,
      "completion_rate": 92.3,
      "avg_duration": 21, // days
      "category": "corporate",
      "trigger": "document_upload",
      "automated": true,
      "steps": [
        {"id": 1, "name": "Initial Contract Review", "type": "analysis", "estimated_days": 2},
        {"id": 2, "name": "Risk Assessment", "type": "analysis", "estimated_days": 1},
        {"id": 3, "name": "Client Consultation", "type": "meeting", "estimated_days": 1},
        {"id": 4, "name": "Contract Revision", "type": "document", "estimated_days": 3},
        {"id": 5, "name": "Final Review", "type": "approval", "estimated_days": 1},
      ],
    },
    {
      "id": "WF003",
      "name": "Court Filing Workflow",
      "description": "Automated workflow for court document filing and case management",
      "type": "legal_process",
      "status": "active",
      "created_date": "2024-03-10",
      "last_modified": "2024-06-12",
      "total_steps": 6,
      "active_cases": 22,
      "completion_rate": 78.9,
      "avg_duration": 14, // days
      "category": "litigation",
      "trigger": "motion_creation",
      "automated": false,
      "steps": [
        {"id": 1, "name": "Document Preparation", "type": "document", "estimated_days": 3},
        {"id": 2, "name": "Internal Review", "type": "approval", "estimated_days": 1},
        {"id": 3, "name": "Client Approval", "type": "approval", "estimated_days": 2},
        {"id": 4, "name": "Court Filing", "type": "legal_process", "estimated_days": 1},
        {"id": 5, "name": "Service of Process", "type": "legal_process", "estimated_days": 5},
      ],
    },
    {
      "id": "WF004",
      "name": "Client Onboarding Workflow",
      "description": "Comprehensive workflow for new client intake and setup",
      "type": "administrative",
      "status": "draft",
      "created_date": "2024-05-01",
      "last_modified": "2024-06-18",
      "total_steps": 10,
      "active_cases": 0,
      "completion_rate": 0.0,
      "avg_duration": 7, // days
      "category": "administrative",
      "trigger": "new_client_registration",
      "automated": true,
      "steps": [
        {"id": 1, "name": "Conflict Check", "type": "analysis", "estimated_days": 1},
        {"id": 2, "name": "Engagement Letter", "type": "document", "estimated_days": 1},
        {"id": 3, "name": "Retainer Agreement", "type": "document", "estimated_days": 1},
        {"id": 4, "name": "Client Portal Setup", "type": "administrative", "estimated_days": 1},
        {"id": 5, "name": "Case File Creation", "type": "administrative", "estimated_days": 1},
      ],
    },
    {
      "id": "WF005",
      "name": "Discovery Management Workflow",
      "description": "Workflow for managing discovery requests and responses",
      "type": "legal_process",
      "status": "inactive",
      "created_date": "2024-01-30",
      "last_modified": "2024-05-20",
      "total_steps": 15,
      "active_cases": 0,
      "completion_rate": 65.2,
      "avg_duration": 60, // days
      "category": "litigation",
      "trigger": "discovery_request_received",
      "automated": false,
      "steps": [
        {"id": 1, "name": "Request Analysis", "type": "analysis", "estimated_days": 2},
        {"id": 2, "name": "Document Collection", "type": "document", "estimated_days": 14},
        {"id": 3, "name": "Privilege Review", "type": "analysis", "estimated_days": 7},
        {"id": 4, "name": "Response Preparation", "type": "document", "estimated_days": 10},
        {"id": 5, "name": "Client Review", "type": "approval", "estimated_days": 3},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredWorkflows {
    return workflows.where((workflow) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${workflow["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${workflow["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${workflow["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "all" || workflow["type"] == selectedType;
      bool matchesStatus = selectedStatus == "all" || workflow["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "draft":
        return warningColor;
      case "inactive":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "case_type":
        return primaryColor;
      case "document_type":
        return infoColor;
      case "legal_process":
        return dangerColor;
      case "administrative":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildWorkflowMetrics(Map<String, dynamic> workflow) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(
          color: disabledColor.withAlpha(20),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Cases",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${workflow["active_cases"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
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
                  "Completion Rate",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(workflow["completion_rate"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
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
                  "Avg Duration",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${workflow["avg_duration"]} days",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
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
                  "Steps",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${workflow["total_steps"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowSteps(List steps) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(
          color: primaryColor.withAlpha(20),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workflow Steps",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...steps.take(3).map((step) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Center(
                    child: Text(
                      "${step["id"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${step["name"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  "${step["estimated_days"]}d",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          )).toList(),
          if (steps.length > 3) ...[
            Text(
              "... and ${steps.length - 3} more steps",
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeWorkflows = workflows.where((w) => w["status"] == "active").length;
    final draftWorkflows = workflows.where((w) => w["status"] == "draft").length;
    final totalActiveCases = workflows.fold(0, (sum, w) => sum + (w["active_cases"] as int));
    final avgCompletionRate = workflows.where((w) => w["status"] == "active").fold(0.0, (sum, w) => sum + (w["completion_rate"] as double)) / activeWorkflows;

    return Scaffold(
      appBar: AppBar(
        title: Text("Workflow Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create workflow
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to workflow analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active Workflows",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$activeWorkflows",
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
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.edit,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Draft Workflows",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$draftWorkflows",
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
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.cases,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active Cases",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$totalActiveCases",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Avg Completion",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${avgCompletionRate.toStringAsFixed(1)}%",
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
              ],
            ),
            SizedBox(height: spLg),

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Workflows",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search workflows...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Workflow Type",
                          items: [
                            {"label": "All Types", "value": "all"},
                            {"label": "Case Type", "value": "case_type"},
                            {"label": "Document Type", "value": "document_type"},
                            {"label": "Legal Process", "value": "legal_process"},
                            {"label": "Administrative", "value": "administrative"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            {"label": "Active", "value": "active"},
                            {"label": "Draft", "value": "draft"},
                            {"label": "Inactive", "value": "inactive"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Workflows List
            Container(
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
                        Text(
                          "Workflows (${filteredWorkflows.length})",
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
                          onPressed: () {
                            // Navigate to create workflow
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredWorkflows.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final workflow = filteredWorkflows[index];
                      final steps = workflow["steps"] as List;
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 4,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: _getTypeColor("${workflow["type"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${workflow["name"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor("${workflow["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${workflow["status"]}".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${workflow["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spSm),
                                      Text(
                                        "${workflow["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: spMd),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getTypeColor("${workflow["type"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${workflow["type"]}".replaceAll("_", " ").toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getTypeColor("${workflow["type"]}"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(10),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${workflow["category"]}".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          if (workflow["automated"] == true)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: spXs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: successColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.auto_awesome,
                                                    size: 10,
                                                    color: successColor,
                                                  ),
                                                  SizedBox(width: spXs),
                                                  Text(
                                                    "AUTOMATED",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      color: successColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: spMd),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Modified: ${DateTime.parse("${workflow["last_modified"]}").dMMMy}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Trigger: ${workflow["trigger"]}".replaceAll("_", " "),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spMd),
                                      _buildWorkflowMetrics(workflow),
                                      SizedBox(height: spMd),
                                      _buildWorkflowSteps(steps),
                                      SizedBox(height: spMd),
                                      Row(
                                        children: [
                                          QButton(
                                            label: "Edit Workflow",
                                            size: bs.sm,
                                            onPressed: () {
                                              // Navigate to edit workflow
                                            },
                                          ),
                                          SizedBox(width: spSm),
                                          if (workflow["status"] == "active")
                                            QButton(
                                              label: "View Analytics",
                                              size: bs.sm,
                                              onPressed: () {
                                                // Navigate to workflow analytics
                                              },
                                            ),
                                          if (workflow["status"] == "draft")
                                            QButton(
                                              label: "Activate",
                                              size: bs.sm,
                                              onPressed: () {
                                                ss("Workflow activated successfully");
                                              },
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
