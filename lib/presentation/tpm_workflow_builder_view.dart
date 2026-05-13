import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmWorkflowBuilderView extends StatefulWidget {
  const TpmWorkflowBuilderView({super.key});

  @override
  State<TpmWorkflowBuilderView> createState() => _TpmWorkflowBuilderViewState();
}

class _TpmWorkflowBuilderViewState extends State<TpmWorkflowBuilderView> {
  List<Map<String, dynamic>> workflows = [
    {
      "id": 1,
      "name": "Bug Fix Workflow",
      "description": "Standard process for handling bug reports and fixes",
      "status": "Active",
      "steps": 6,
      "completedRuns": 45,
      "averageTime": "2.5 hours",
      "lastModified": "2024-06-19 10:30:00",
      "color": Colors.red,
      "category": "Development"
    },
    {
      "id": 2,
      "name": "Feature Request Process",
      "description": "Complete workflow for new feature development",
      "status": "Active",
      "steps": 8,
      "completedRuns": 23,
      "averageTime": "5.2 days",
      "lastModified": "2024-06-18 14:20:00",
      "color": Colors.blue,
      "category": "Development"
    },
    {
      "id": 3,
      "name": "Client Onboarding",
      "description": "Step-by-step process for new client setup",
      "status": "Draft",
      "steps": 12,
      "completedRuns": 8,
      "averageTime": "3.1 days",
      "lastModified": "2024-06-17 09:15:00",
      "color": Colors.green,
      "category": "Client Management"
    },
    {
      "id": 4,
      "name": "Code Review Process",
      "description": "Standardized code review and approval workflow",
      "status": "Active",
      "steps": 5,
      "completedRuns": 127,
      "averageTime": "4.2 hours",
      "lastModified": "2024-06-19 08:45:00",
      "color": Colors.purple,
      "category": "Development"
    },
    {
      "id": 5,
      "name": "Project Handoff",
      "description": "Complete project delivery and client handoff process",
      "status": "Inactive",
      "steps": 10,
      "completedRuns": 12,
      "averageTime": "2.8 days",
      "lastModified": "2024-06-15 16:30:00",
      "color": Colors.orange,
      "category": "Project Management"
    }
  ];

  List<Map<String, dynamic>> workflowSteps = [
    {
      "id": 1,
      "title": "Initial Assessment",
      "description": "Review and categorize the incoming request",
      "type": "task",
      "assignee": "Auto-assign",
      "estimatedTime": "30 minutes",
      "isCompleted": true
    },
    {
      "id": 2,
      "title": "Technical Analysis",
      "description": "Analyze technical requirements and feasibility",
      "type": "task",
      "assignee": "Lead Developer",
      "estimatedTime": "2 hours",
      "isCompleted": true
    },
    {
      "id": 3,
      "title": "Approval Gate",
      "description": "Get approval from project manager",
      "type": "approval",
      "assignee": "Project Manager",
      "estimatedTime": "1 day",
      "isCompleted": false
    },
    {
      "id": 4,
      "title": "Implementation",
      "description": "Develop and implement the solution",
      "type": "task",
      "assignee": "Developer Team",
      "estimatedTime": "3-5 days",
      "isCompleted": false
    },
    {
      "id": 5,
      "title": "Testing",
      "description": "Comprehensive testing and quality assurance",
      "type": "task",
      "assignee": "QA Team",
      "estimatedTime": "1-2 days",
      "isCompleted": false
    },
    {
      "id": 6,
      "title": "Deployment",
      "description": "Deploy to production and monitor",
      "type": "task",
      "assignee": "DevOps Team",
      "estimatedTime": "2 hours",
      "isCompleted": false
    }
  ];

  List<Map<String, dynamic>> workflowTemplates = [
    {
      "id": 10,
      "name": "Agile Sprint Planning",
      "description": "Complete sprint planning and execution workflow",
      "category": "Agile",
      "steps": 8,
      "icon": Icons.directions_run,
      "difficulty": "Medium"
    },
    {
      "id": 11,
      "name": "Employee Onboarding",
      "description": "HR workflow for new employee integration",
      "category": "HR",
      "steps": 15,
      "icon": Icons.person_add,
      "difficulty": "Easy"
    },
    {
      "id": 12,
      "name": "Budget Approval Process",
      "description": "Multi-level budget request and approval workflow",
      "category": "Finance",
      "steps": 6,
      "icon": Icons.attach_money,
      "difficulty": "Advanced"
    },
    {
      "id": 13,
      "name": "Incident Response",
      "description": "Emergency incident handling and resolution",
      "category": "Operations",
      "steps": 9,
      "icon": Icons.warning,
      "difficulty": "Advanced"
    }
  ];

  int selectedTab = 0;
  String selectedCategory = "All";
  List<String> categories = ["All", "Development", "Client Management", "Project Management", "Agile", "HR", "Finance", "Operations"];
  bool loading = false;
  int? selectedWorkflowId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workflow Builder"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewWorkflow,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : selectedWorkflowId != null
              ? _buildWorkflowEditor()
              : QTabBar(
                  withoutAppBar: true,
                  selectedIndex: selectedTab,
                  tabs: [
                    Tab(text: "My Workflows", icon: Icon(Icons.account_tree)),
                    Tab(text: "Templates", icon: Icon(Icons.library_books)),
                  ],
                  tabChildren: [
                    _buildWorkflowsTab(),
                    _buildTemplatesTab(),
                  ],
                ),
    );
  }

  Widget _buildWorkflowsTab() {
    List<Map<String, dynamic>> filteredWorkflows = selectedCategory == "All"
        ? workflows
        : workflows.where((workflow) => workflow["category"] == selectedCategory).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsRow(),
          SizedBox(height: spMd),
          _buildCategoryFilter(),
          SizedBox(height: spMd),
          Text(
            "Workflows",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (filteredWorkflows.isEmpty)
            _buildEmptyState()
          else
            ...filteredWorkflows.map((workflow) => _buildWorkflowCard(workflow)).toList(),
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
          Text(
            "Start with proven workflow templates",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...workflowTemplates.map((template) => _buildTemplateCard(template)).toList(),
        ],
      ),
    );
  }

  Widget _buildWorkflowEditor() {
    Map<String, dynamic>? workflow = workflows.firstWhere(
      (w) => w["id"] == selectedWorkflowId,
      orElse: () => {},
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${workflow["name"] ?? "Workflow Editor"}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            selectedWorkflowId = null;
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveWorkflow,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWorkflowInfo(workflow),
            SizedBox(height: spMd),
            Text(
              "Workflow Steps",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...workflowSteps.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> step = entry.value;
              return _buildStepCard(step, index);
            }).toList(),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Step",
                size: bs.md,
                onPressed: _addNewStep,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    int activeWorkflows = workflows.where((w) => w["status"] == "Active").length;
    int totalRuns = workflows.fold(0, (sum, w) => sum + (w["completedRuns"] as int));

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Active Workflows",
            value: "$activeWorkflows",
            icon: Icons.play_arrow,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Total Runs",
            value: "$totalRuns",
            icon: Icons.refresh,
            color: infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Templates",
            value: "${workflowTemplates.length}",
            icon: Icons.library_books,
            color: warningColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
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

  Widget _buildCategoryFilter() {
    return QHorizontalScroll(
      children: categories.map((category) => 
        Container(
          margin: EdgeInsets.only(right: spXs),
          child: GestureDetector(
            onTap: () {
              selectedCategory = category;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: selectedCategory == category ? primaryColor : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: selectedCategory == category ? Colors.white : disabledBoldColor,
                  fontWeight: selectedCategory == category ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildWorkflowCard(Map<String, dynamic> workflow) {
    Color statusColor = workflow["status"] == "Active" 
        ? successColor 
        : workflow["status"] == "Draft" 
            ? warningColor 
            : disabledColor;

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
            color: workflow["color"] as Color,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${workflow["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${workflow["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${workflow["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
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
              _buildWorkflowStat(
                icon: Icons.list,
                label: "Steps",
                value: "${workflow["steps"]}",
              ),
              SizedBox(width: spMd),
              _buildWorkflowStat(
                icon: Icons.play_arrow,
                label: "Runs",
                value: "${workflow["completedRuns"]}",
              ),
              SizedBox(width: spMd),
              _buildWorkflowStat(
                icon: Icons.schedule,
                label: "Avg Time",
                value: "${workflow["averageTime"]}",
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (workflow["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${workflow["category"]}",
                  style: TextStyle(
                    color: workflow["color"] as Color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Modified ${DateTime.parse(workflow["lastModified"]).dMMMy}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editWorkflow(workflow),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Duplicate",
                  size: bs.sm,
                  onPressed: () => _duplicateWorkflow(workflow),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showWorkflowOptions(workflow),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: spXs),
        Text(
          "$value $label",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    Color difficultyColor = template["difficulty"] == "Easy" 
        ? successColor 
        : template["difficulty"] == "Medium" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${template["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: difficultyColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${template["difficulty"]}",
                            style: TextStyle(
                              color: difficultyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${template["category"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.list, size: 12, color: disabledColor),
                        SizedBox(width: spXs),
                        Text(
                          "${template["steps"]} steps",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
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
              onPressed: () => _useTemplate(template),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowInfo(Map<String, dynamic> workflow) {
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
          Text(
            "${workflow["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${workflow["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildWorkflowStat(
                icon: Icons.list,
                label: "Steps",
                value: "${workflowSteps.length}",
              ),
              SizedBox(width: spMd),
              _buildWorkflowStat(
                icon: Icons.schedule,
                label: "Est. Time",
                value: "${workflow["averageTime"]}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(Map<String, dynamic> step, int index) {
    IconData stepIcon = step["type"] == "approval" 
        ? Icons.approval 
        : step["type"] == "decision" 
            ? Icons.help 
            : Icons.task;
    
    Color stepColor = step["isCompleted"] as bool 
        ? successColor 
        : primaryColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: stepColor.withAlpha(20),
                    shape: BoxShape.circle,
                    border: Border.all(color: stepColor, width: 2),
                  ),
                  child: Center(
                    child: step["isCompleted"] as bool
                        ? Icon(Icons.check, color: stepColor, size: 16)
                        : Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: stepColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                  ),
                ),
                if (index < workflowSteps.length - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: disabledColor,
                    margin: EdgeInsets.symmetric(vertical: spXs),
                  ),
              ],
            ),
          ),
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
                  Row(
                    children: [
                      Icon(stepIcon, size: 16, color: stepColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${step["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (step["isCompleted"] as bool)
                        Icon(Icons.check_circle, color: successColor, size: 20),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${step["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: disabledColor),
                      SizedBox(width: spXs),
                      Text(
                        "${step["assignee"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.schedule, size: 14, color: disabledColor),
                      SizedBox(width: spXs),
                      Text(
                        "${step["estimatedTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.account_tree,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Workflows",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Create your first workflow to automate your processes",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editWorkflow(Map<String, dynamic> workflow) {
    selectedWorkflowId = workflow["id"];
    setState(() {});
  }

  void _duplicateWorkflow(Map<String, dynamic> workflow) {
    Map<String, dynamic> duplicatedWorkflow = {
      ...workflow,
      "id": workflows.length + 1,
      "name": "${workflow["name"]} (Copy)",
      "status": "Draft",
      "completedRuns": 0,
      "lastModified": DateTime.now().toString(),
    };

    workflows.add(duplicatedWorkflow);
    setState(() {});
    ss("Workflow duplicated successfully");
  }

  void _showWorkflowOptions(Map<String, dynamic> workflow) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Workflow Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Workflow"),
              onTap: () {
                back();
                _deleteWorkflow(workflow);
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: primaryColor),
              title: Text("Export Workflow"),
              onTap: () {
                back();
                ss("Export functionality - coming soon");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteWorkflow(Map<String, dynamic> workflow) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this workflow?");
    if (isConfirmed) {
      workflows.removeWhere((item) => item["id"] == workflow["id"]);
      setState(() {});
      ss("Workflow deleted successfully");
    }
  }

  void _createNewWorkflow() {
    ss("Create new workflow functionality - coming soon");
  }

  void _useTemplate(Map<String, dynamic> template) {
    ss("Using template: ${template["name"]} - coming soon");
  }

  void _saveWorkflow() {
    ss("Workflow saved successfully");
  }

  void _addNewStep() {
    ss("Add new step functionality - coming soon");
  }
}
