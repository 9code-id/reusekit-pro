import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaActionView extends StatefulWidget {
  const CmaActionView({super.key});

  @override
  State<CmaActionView> createState() => _CmaActionViewState();
}

class _CmaActionViewState extends State<CmaActionView> {
  String selectedCategory = "all";
  String searchQuery = "";
  int selectedTab = 0;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Communication", "value": "communication"},
    {"label": "Data Management", "value": "data_management"},
    {"label": "Integration", "value": "integration"},
    {"label": "Automation", "value": "automation"},
    {"label": "Analytics", "value": "analytics"},
  ];

  List<Map<String, dynamic>> actions = [
    {
      "id": "1",
      "name": "Send Email",
      "description": "Send personalized email to user",
      "category": "communication",
      "type": "email",
      "status": "active",
      "usageCount": 1247,
      "lastUsed": "2024-12-15 16:45",
      "configuration": {
        "template": "Welcome Email",
        "delay": "Immediate",
        "personalization": true
      },
      "workflows": ["Welcome Series", "Cart Recovery", "Newsletter"],
      "priority": "high",
      "icon": Icons.mail,
      "success_rate": 95.2
    },
    {
      "id": "2",
      "name": "Send SMS",
      "description": "Send SMS notification to user's phone",
      "category": "communication",
      "type": "sms",
      "status": "active",
      "usageCount": 856,
      "lastUsed": "2024-12-15 15:30",
      "configuration": {
        "template": "Order Update",
        "delay": "5 minutes",
        "country_code": "+1"
      },
      "workflows": ["Order Confirmation", "Delivery Updates"],
      "priority": "high",
      "icon": Icons.sms,
      "success_rate": 98.7
    },
    {
      "id": "3",
      "name": "Update User Data",
      "description": "Update user profile information",
      "category": "data_management",
      "type": "data_update",
      "status": "active",
      "usageCount": 432,
      "lastUsed": "2024-12-15 14:20",
      "configuration": {
        "fields": ["status", "last_login", "preferences"],
        "validation": true,
        "backup": true
      },
      "workflows": ["User Onboarding", "Profile Management"],
      "priority": "medium",
      "icon": Icons.person,
      "success_rate": 99.1
    },
    {
      "id": "4",
      "name": "Create Task",
      "description": "Create task for team member",
      "category": "automation",
      "type": "task_creation",
      "status": "active",
      "usageCount": 234,
      "lastUsed": "2024-12-15 13:10",
      "configuration": {
        "assignee": "Auto-assign",
        "priority": "Medium",
        "due_date": "3 days"
      },
      "workflows": ["Lead Follow-up", "Customer Support"],
      "priority": "medium",
      "icon": Icons.task,
      "success_rate": 87.5
    },
    {
      "id": "5",
      "name": "API Call",
      "description": "Make external API call",
      "category": "integration",
      "type": "api_call",
      "status": "paused",
      "usageCount": 156,
      "lastUsed": "2024-12-10 09:45",
      "configuration": {
        "endpoint": "https://api.crm.com/contacts",
        "method": "POST",
        "retry_count": 3
      },
      "workflows": ["CRM Sync", "Data Export"],
      "priority": "low",
      "icon": Icons.api,
      "success_rate": 92.3
    },
    {
      "id": "6",
      "name": "Wait/Delay",
      "description": "Add delay before next action",
      "category": "automation",
      "type": "delay",
      "status": "active",
      "usageCount": 678,
      "lastUsed": "2024-12-15 12:00",
      "configuration": {
        "duration": "1 hour",
        "type": "relative",
        "skip_weekends": false
      },
      "workflows": ["Nurture Campaign", "Follow-up Sequence"],
      "priority": "medium",
      "icon": Icons.timer,
      "success_rate": 100.0
    },
  ];

  List<Map<String, dynamic>> actionTemplates = [
    {
      "id": "1",
      "name": "Email Campaign",
      "description": "Complete email campaign setup",
      "category": "Communication",
      "actions": ["Send Email", "Track Opens", "Handle Replies"],
      "estimated_time": "15 minutes",
      "complexity": "Beginner",
      "popularity": 95,
      "icon": Icons.campaign,
      "thumbnail": "https://picsum.photos/300/200?random=40&keyword=email"
    },
    {
      "id": "2",
      "name": "Lead Processing",
      "description": "Automated lead qualification and routing",
      "category": "Automation",
      "actions": ["Score Lead", "Update CRM", "Assign Rep", "Send Notification"],
      "estimated_time": "30 minutes",
      "complexity": "Intermediate",
      "popularity": 89,
      "icon": Icons.people,
      "thumbnail": "https://picsum.photos/300/200?random=41&keyword=leads"
    },
    {
      "id": "3",
      "name": "Order Processing",
      "description": "Complete order fulfillment workflow",
      "category": "E-commerce",
      "actions": ["Validate Order", "Process Payment", "Update Inventory", "Send Confirmation"],
      "estimated_time": "45 minutes",
      "complexity": "Advanced",
      "popularity": 87,
      "icon": Icons.shopping_cart,
      "thumbnail": "https://picsum.photos/300/200?random=42&keyword=order"
    },
    {
      "id": "4",
      "name": "Support Ticket",
      "description": "Customer support ticket handling",
      "category": "Support",
      "actions": ["Route Ticket", "Assign Agent", "Set Priority", "Send Update"],
      "estimated_time": "20 minutes",
      "complexity": "Intermediate",
      "popularity": 82,
      "icon": Icons.support,
      "thumbnail": "https://picsum.photos/300/200?random=43&keyword=support"
    },
  ];

  List<Map<String, dynamic>> get filteredActions {
    List<Map<String, dynamic>> filtered = actions;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((action) => action["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((action) => 
        (action["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (action["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  void _createAction() {
    si("Opening action builder...");
  }

  void _editAction(Map<String, dynamic> action) {
    si("Editing ${action["name"]}...");
  }

  void _duplicateAction(Map<String, dynamic> action) {
    si("Action duplicated successfully");
  }

  void _deleteAction(Map<String, dynamic> action) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this action?");
    if (isConfirmed) {
      ss("Action deleted successfully");
    }
  }

  void _toggleAction(Map<String, dynamic> action) {
    action["status"] = action["status"] == "active" ? "paused" : "active";
    si("Action ${action["status"]}");
    setState(() {});
  }

  void _testAction(Map<String, dynamic> action) {
    si("Testing action: ${action["name"]}");
  }

  void _viewLogs(Map<String, dynamic> action) {
    si("Opening execution logs for ${action["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Action Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createAction,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildStatsSection(),
            _buildTabSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createAction,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search actions...",
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
          QDropdownField(
            label: "Filter by Category",
            items: categoryOptions,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    int activeCount = actions.where((a) => a["status"] == "active").length;
    int totalUsage = actions.map((a) => a["usageCount"] as int).reduce((a, b) => a + b);
    int pausedCount = actions.where((a) => a["status"] == "paused").length;
    double avgSuccessRate = actions.isNotEmpty 
        ? actions.map((a) => a["success_rate"] as double).reduce((a, b) => a + b) / actions.length
        : 0.0;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildStatCard("Active Actions", activeCount, Icons.play_circle, Colors.green),
        _buildStatCard("Total Executions", totalUsage, Icons.bar_chart, Colors.blue),
        _buildStatCard("Paused", pausedCount, Icons.pause_circle, Colors.orange),
        _buildStatCard("Avg. Success Rate", "${avgSuccessRate.toStringAsFixed(1)}%", Icons.check_circle, Colors.purple),
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
                _buildTabButton("Actions", 0),
                _buildTabButton("Templates", 1),
                _buildTabButton("Analytics", 2),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: selectedTab == 0
                ? _buildActionsTab()
                : selectedTab == 1
                    ? _buildTemplatesTab()
                    : _buildAnalyticsTab(),
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

  Widget _buildActionsTab() {
    return Column(
      spacing: spSm,
      children: filteredActions.map((action) {
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
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      action["icon"],
                      color: primaryColor,
                      size: 20,
                    ),
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
                              "${action["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            _buildStatusBadge(action["status"]),
                          ],
                        ),
                        Text(
                          "${action["description"]}",
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
              Row(
                children: [
                  Expanded(
                    child: _buildActionInfo("Type", "${action["type"]}", Icons.category),
                  ),
                  Expanded(
                    child: _buildActionInfo("Usage", "${action["usageCount"]}", Icons.bar_chart),
                  ),
                  Expanded(
                    child: _buildActionInfo("Success", "${(action["success_rate"] as num).toStringAsFixed(1)}%", Icons.check_circle),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Configuration:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    ...(action["configuration"] as Map<String, dynamic>).entries.map((entry) {
                      return Row(
                        children: [
                          Icon(Icons.settings, size: 12, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${entry.key}: ${entry.value}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              if (action["workflows"] != null) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(13),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Used in Workflows:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      QHorizontalScroll(
                        children: (action["workflows"] as List).map((workflow) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$workflow",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last used: ${action["lastUsed"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _viewLogs(action),
                        child: Icon(Icons.history, color: infoColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _testAction(action),
                        child: Icon(Icons.play_arrow, color: successColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _editAction(action),
                        child: Icon(Icons.edit, color: warningColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _toggleAction(action),
                        child: Icon(
                          action["status"] == "active" ? Icons.pause : Icons.play_circle,
                          color: action["status"] == "active" ? warningColor : successColor,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _duplicateAction(action),
                        child: Icon(Icons.copy, color: primaryColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _deleteAction(action),
                        child: Icon(Icons.delete, color: dangerColor, size: 18),
                      ),
                    ],
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
    Color color = status == "active" ? successColor : warningColor;
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

  Widget _buildActionInfo(String label, String value, IconData icon) {
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

  Widget _buildTemplatesTab() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: actionTemplates.map((template) {
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
                    Row(
                      children: [
                        Icon(
                          template["icon"],
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${template["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
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
                      "Actions: ${(template["actions"] as List).length}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
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
                      "Est. time: ${template["estimated_time"]}",
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

  Widget _buildAnalyticsTab() {
    Map<String, int> categoryCount = {};
    Map<String, int> typeCount = {};
    
    for (var action in actions) {
      String category = action["category"];
      String type = action["type"];
      
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      typeCount[type] = (typeCount[type] ?? 0) + 1;
    }

    return Column(
      spacing: spMd,
      children: [
        ResponsiveGridView(
          minItemWidth: 200,
          children: [
            _buildAnalyticsCard("Total Actions", "${actions.length}", Icons.settings, Colors.blue),
            _buildAnalyticsCard("Active", "${actions.where((a) => a["status"] == "active").length}", Icons.play_circle, Colors.green),
            _buildAnalyticsCard("Total Executions", "${actions.map((a) => a["usageCount"] as int).reduce((a, b) => a + b)}", Icons.bar_chart, Colors.orange),
            _buildAnalyticsCard("Avg. Success", "${(actions.map((a) => a["success_rate"] as double).reduce((a, b) => a + b) / actions.length).toStringAsFixed(1)}%", Icons.check_circle, Colors.purple),
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
                "Most Used Actions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              ...actions.where((a) => a["status"] == "active").take(5).map((action) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        action["icon"],
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${action["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${action["usageCount"]} uses",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
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
                "Actions by Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              ...categoryCount.entries.map((entry) {
                double percentage = (entry.value / actions.length) * 100;
                return _buildCategoryBar(entry.key, entry.value, percentage);
              }).toList(),
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

  Widget _buildCategoryBar(String category, int count, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category.replaceAll("_", " ").toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "$count (${percentage.toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(51),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
