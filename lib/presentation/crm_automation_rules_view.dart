import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAutomationRulesView extends StatefulWidget {
  const CrmAutomationRulesView({super.key});

  @override
  State<CrmAutomationRulesView> createState() => _CrmAutomationRulesViewState();
}

class _CrmAutomationRulesViewState extends State<CrmAutomationRulesView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Lead Management", "value": "lead"},
    {"label": "Customer Support", "value": "support"},
    {"label": "Sales Process", "value": "sales"},
    {"label": "Email Marketing", "value": "email"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> automationMetrics = [
    {
      "title": "Total Rules",
      "value": 36,
      "change": 28.6,
      "icon": Icons.rule,
      "color": Colors.blue,
    },
    {
      "title": "Active Rules",
      "value": 28,
      "change": 16.7,
      "icon": Icons.play_circle,
      "color": Colors.green,
    },
    {
      "title": "Tasks Automated",
      "value": 1542,
      "change": 45.2,
      "icon": Icons.auto_awesome,
      "color": Colors.orange,
    },
    {
      "title": "Time Saved (Hours)",
      "value": 324,
      "change": 38.1,
      "icon": Icons.schedule,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> automationRules = [
    {
      "name": "New Lead Auto-Assignment",
      "description": "Automatically assign new leads to available sales reps based on territory",
      "category": "Lead Management",
      "trigger": "New lead created",
      "actions": ["Assign to sales rep", "Send welcome email", "Create follow-up task"],
      "status": "active",
      "executions": 245,
      "successRate": 98.4,
      "lastTriggered": "2 hours ago",
    },
    {
      "name": "Customer Onboarding Sequence",
      "description": "Send welcome series and setup tasks for new customers",
      "category": "Email Marketing",
      "trigger": "Customer status changed to 'Active'",
      "actions": ["Send welcome email series", "Create onboarding tasks", "Schedule check-in call"],
      "status": "active",
      "executions": 156,
      "successRate": 95.8,
      "lastTriggered": "5 hours ago",
    },
    {
      "name": "High-Priority Ticket Escalation",
      "description": "Escalate critical support tickets to managers automatically",
      "category": "Customer Support",
      "trigger": "Ticket priority = Critical",
      "actions": ["Notify manager", "Update ticket status", "Send SMS alert"],
      "status": "active",
      "executions": 89,
      "successRate": 100.0,
      "lastTriggered": "1 day ago",
    },
    {
      "name": "Deal Stage Progression",
      "description": "Automatically move deals through pipeline stages based on activities",
      "category": "Sales Process",
      "trigger": "Proposal sent",
      "actions": ["Move to 'Negotiation' stage", "Set follow-up reminder", "Update probability"],
      "status": "active",
      "executions": 78,
      "successRate": 92.3,
      "lastTriggered": "3 hours ago",
    },
    {
      "name": "Inactive Lead Re-engagement",
      "description": "Re-engage leads that haven't been contacted in 30 days",
      "category": "Lead Management",
      "trigger": "Lead inactive for 30 days",
      "actions": ["Send re-engagement email", "Create follow-up task", "Update lead score"],
      "status": "inactive",
      "executions": 45,
      "successRate": 67.8,
      "lastTriggered": "1 week ago",
    },
  ];

  List<Map<String, dynamic>> ruleTemplates = [
    {
      "name": "Lead Scoring Automation",
      "description": "Automatically score leads based on behavior and demographics",
      "category": "Lead Management",
      "popularity": 92,
      "uses": 1240,
      "complexity": "Medium",
    },
    {
      "name": "Follow-up Reminder System",
      "description": "Create automatic follow-up reminders for sales activities",
      "category": "Sales Process",
      "popularity": 88,
      "uses": 1150,
      "complexity": "Simple",
    },
    {
      "name": "Customer Satisfaction Survey",
      "description": "Send satisfaction surveys after support ticket resolution",
      "category": "Customer Support",
      "popularity": 76,
      "uses": 980,
      "complexity": "Simple",
    },
    {
      "name": "Abandoned Cart Recovery",
      "description": "Send email series to recover abandoned shopping carts",
      "category": "Email Marketing",
      "popularity": 84,
      "uses": 856,
      "complexity": "Medium",
    },
  ];

  List<Map<String, dynamic>> recentExecutions = [
    {
      "rule": "New Lead Auto-Assignment",
      "trigger": "New lead created: John Smith",
      "status": "success",
      "executedAt": "2 hours ago",
      "duration": "0.3s",
      "actions": 3,
    },
    {
      "rule": "Deal Stage Progression",
      "trigger": "Proposal sent to TechCorp",
      "status": "success",
      "executedAt": "3 hours ago",
      "duration": "0.5s",
      "actions": 3,
    },
    {
      "rule": "Customer Onboarding Sequence",
      "trigger": "Customer activated: ABC Company",
      "status": "success",
      "executedAt": "5 hours ago",
      "duration": "1.2s",
      "actions": 4,
    },
    {
      "rule": "High-Priority Ticket Escalation",
      "trigger": "Critical ticket created",
      "status": "failed",
      "executedAt": "6 hours ago",
      "duration": "2.1s",
      "actions": 1,
      "error": "Manager notification failed",
    },
    {
      "rule": "New Lead Auto-Assignment",
      "trigger": "New lead created: Sarah Johnson",
      "status": "success",
      "executedAt": "8 hours ago",
      "duration": "0.2s",
      "actions": 3,
    },
  ];

  List<Map<String, dynamic>> performanceStats = [
    {"metric": "Total Executions", "value": "15,240", "period": "This Month"},
    {"metric": "Success Rate", "value": "94.2%", "period": "Average"},
    {"metric": "Average Response Time", "value": "0.8s", "period": "Per Execution"},
    {"metric": "Time Saved", "value": "324h", "period": "This Month"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return Colors.green;
      case "inactive":
        return Colors.orange;
      case "draft":
        return Colors.grey;
      case "success":
        return Colors.green;
      case "failed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getComplexityColor(String complexity) {
    switch (complexity.toLowerCase()) {
      case "simple":
        return Colors.green;
      case "medium":
        return Colors.orange;
      case "complex":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automation Rules"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Create new automation rule feature coming soon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
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
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Automation Metrics
            Text(
              "Automation Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: automationMetrics.map((metric) {
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
                              color: (metric["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) > 0
                                  ? Colors.green.withAlpha(51)
                                  : Colors.red.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(metric["value"] as num).toString()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Rule",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Create new automation rule feature coming soon");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Use Template",
                          icon: Icons.copy,
                          size: bs.sm,
                          onPressed: () {
                            ss("Template selection feature coming soon");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Active Automation Rules
            Text(
              "Automation Rules",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: automationRules.map((rule) {
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${rule["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${rule["description"]}",
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
                              color: _getStatusColor("${rule["status"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${rule["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${rule["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${rule["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${rule["trigger"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Actions:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (rule["actions"] as List<String>).map((action) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              action,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${(rule["executions"] as int)} executions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "• ${(rule["successRate"] as double).toStringAsFixed(1)}% success",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Last: ${rule["lastTriggered"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Rule Templates
            Text(
              "Popular Rule Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: ruleTemplates.map((template) {
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
                          Expanded(
                            child: Text(
                              "${template["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getComplexityColor("${template["complexity"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${template["complexity"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getComplexityColor("${template["complexity"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${template["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${template["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${(template["popularity"] as int)}% popularity",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(template["uses"] as int)} uses",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
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
                            ss("Template selected: ${template["name"]}");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Recent Executions
            Text(
              "Recent Executions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: recentExecutions.map((execution) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _getStatusColor("${execution["status"]}"),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${execution["rule"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${execution["trigger"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (execution["error"] != null)
                              Text(
                                "Error: ${execution["error"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${execution["status"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${execution["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${execution["status"]}"),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${execution["executedAt"]} • ${execution["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(execution["actions"] as int)} actions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Performance Statistics
            Text(
              "Performance Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: performanceStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${stat["metric"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["period"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
