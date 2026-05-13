import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmAutomationRulesView extends StatefulWidget {
  const TpmAutomationRulesView({super.key});

  @override
  State<TpmAutomationRulesView> createState() => _TpmAutomationRulesViewState();
}

class _TpmAutomationRulesViewState extends State<TpmAutomationRulesView> {
  List<Map<String, dynamic>> automationRules = [
    {
      "id": 1,
      "name": "Auto-assign Tasks",
      "description": "Automatically assign new tasks to team members based on workload",
      "trigger": "When task is created",
      "action": "Assign to team member with lowest workload",
      "isActive": true,
      "category": "Task Management",
      "executionCount": 127,
      "lastExecuted": "2024-06-19 10:30:00",
      "color": Colors.blue
    },
    {
      "id": 2,
      "name": "Deadline Reminders",
      "description": "Send notifications 24 hours before task deadlines",
      "trigger": "24 hours before deadline",
      "action": "Send notification to assignee",
      "isActive": true,
      "category": "Notifications",
      "executionCount": 89,
      "lastExecuted": "2024-06-19 09:15:00",
      "color": Colors.orange
    },
    {
      "id": 3,
      "name": "Status Updates",
      "description": "Update project status when all tasks are completed",
      "trigger": "When all tasks in project are complete",
      "action": "Change project status to 'Completed'",
      "isActive": false,
      "category": "Project Management",
      "executionCount": 23,
      "lastExecuted": "2024-06-18 16:45:00",
      "color": Colors.green
    },
    {
      "id": 4,
      "name": "Team Notifications",
      "description": "Notify team when high-priority tasks are created",
      "trigger": "When high-priority task is created",
      "action": "Send notification to all team members",
      "isActive": true,
      "category": "Notifications",
      "executionCount": 45,
      "lastExecuted": "2024-06-19 08:20:00",
      "color": Colors.red
    },
    {
      "id": 5,
      "name": "Time Tracking",
      "description": "Automatically start time tracking when task status changes to 'In Progress'",
      "trigger": "When task status changes to 'In Progress'",
      "action": "Start time tracking",
      "isActive": true,
      "category": "Time Management",
      "executionCount": 156,
      "lastExecuted": "2024-06-19 11:00:00",
      "color": Colors.purple
    }
  ];

  List<Map<String, dynamic>> ruleTemplates = [
    {
      "id": 10,
      "name": "Daily Standup Reminder",
      "description": "Send daily standup meeting reminders to team",
      "category": "Meetings",
      "icon": Icons.schedule,
      "difficulty": "Easy"
    },
    {
      "id": 11,
      "name": "Budget Alert",
      "description": "Alert when project budget exceeds threshold",
      "category": "Finance",
      "icon": Icons.attach_money,
      "difficulty": "Medium"
    },
    {
      "id": 12,
      "name": "Client Report Generator",
      "description": "Generate weekly progress reports for clients",
      "category": "Reporting",
      "icon": Icons.assessment,
      "difficulty": "Advanced"
    },
    {
      "id": 13,
      "name": "Resource Optimization",
      "description": "Automatically redistribute tasks when team member is overloaded",
      "category": "Resource Management",
      "icon": Icons.balance,
      "difficulty": "Advanced"
    }
  ];

  String selectedCategory = "All";
  List<String> categories = ["All", "Task Management", "Notifications", "Project Management", "Time Management", "Meetings", "Finance", "Reporting", "Resource Management"];
  int selectedTab = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automation Rules"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewRule,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "Active Rules", icon: Icon(Icons.play_arrow)),
                Tab(text: "Templates", icon: Icon(Icons.library_books)),
              ],
              tabChildren: [
                _buildActiveRulesTab(),
                _buildTemplatesTab(),
              ],
            ),
    );
  }

  Widget _buildActiveRulesTab() {
    List<Map<String, dynamic>> filteredRules = selectedCategory == "All"
        ? automationRules
        : automationRules.where((rule) => rule["category"] == selectedCategory).toList();

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
            "Automation Rules",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (filteredRules.isEmpty)
            _buildEmptyState()
          else
            ...filteredRules.map((rule) => _buildRuleCard(rule)).toList(),
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
            "Rule Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Get started quickly with pre-built automation rules",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...ruleTemplates.map((template) => _buildTemplateCard(template)).toList(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    int activeRules = automationRules.where((rule) => rule["isActive"] == true).length;
    int totalExecutions = automationRules.fold(0, (sum, rule) => sum + (rule["executionCount"] as int));

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Active Rules",
            value: "$activeRules",
            icon: Icons.play_arrow,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Total Executions",
            value: "$totalExecutions",
            icon: Icons.refresh,
            color: infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Time Saved",
            value: "24h",
            icon: Icons.schedule,
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

  Widget _buildRuleCard(Map<String, dynamic> rule) {
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
            color: rule["color"] as Color,
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
                            "${rule["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Switch(
                          value: rule["isActive"] as bool,
                          onChanged: (value) => _toggleRule(rule, value),
                          activeColor: successColor,
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${rule["description"]}",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.flash_on, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Trigger: ${rule["trigger"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.play_arrow, size: 16, color: successColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Action: ${rule["action"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (rule["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${rule["category"]}",
                  style: TextStyle(
                    color: rule["color"] as Color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Executed ${rule["executionCount"]} times",
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
                  onPressed: () => _editRule(rule),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Delete",
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () => _deleteRule(rule),
                ),
              ),
            ],
          ),
        ],
      ),
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
                    Text(
                      "${template["category"]}",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.rule,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Automation Rules",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Create your first automation rule to streamline your workflow",
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

  void _toggleRule(Map<String, dynamic> rule, bool value) {
    int index = automationRules.indexWhere((item) => item["id"] == rule["id"]);
    if (index != -1) {
      automationRules[index]["isActive"] = value;
      setState(() {});
      ss(value ? "Rule activated" : "Rule deactivated");
    }
  }

  void _editRule(Map<String, dynamic> rule) {
    ss("Edit rule functionality - coming soon");
  }

  void _deleteRule(Map<String, dynamic> rule) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this automation rule?");
    if (isConfirmed) {
      automationRules.removeWhere((item) => item["id"] == rule["id"]);
      setState(() {});
      ss("Automation rule deleted successfully");
    }
  }

  void _createNewRule() {
    ss("Create new rule functionality - coming soon");
  }

  void _useTemplate(Map<String, dynamic> template) {
    ss("Using template: ${template["name"]} - coming soon");
  }
}
