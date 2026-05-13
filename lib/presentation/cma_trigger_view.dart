import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTriggerView extends StatefulWidget {
  const CmaTriggerView({super.key});

  @override
  State<CmaTriggerView> createState() => _CmaTriggerViewState();
}

class _CmaTriggerViewState extends State<CmaTriggerView> {
  String selectedCategory = "all";
  String searchQuery = "";
  int selectedTab = 0;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "User Actions", "value": "user_actions"},
    {"label": "Time-Based", "value": "time_based"},
    {"label": "Data Changes", "value": "data_changes"},
    {"label": "External Events", "value": "external_events"},
    {"label": "System Events", "value": "system_events"},
  ];

  List<Map<String, dynamic>> triggers = [
    {
      "id": "1",
      "name": "User Registration",
      "description": "Triggered when a new user registers",
      "category": "user_actions",
      "type": "event",
      "status": "active",
      "usageCount": 156,
      "lastTriggered": "2024-12-15 14:30",
      "conditions": ["Email verified", "Profile completed"],
      "workflows": ["Welcome Series", "Onboarding Flow"],
      "priority": "high",
      "icon": Icons.person_add
    },
    {
      "id": "2",
      "name": "Cart Abandonment",
      "description": "Triggered when cart is abandoned for 1 hour",
      "category": "time_based",
      "type": "time_delay",
      "status": "active",
      "usageCount": 89,
      "lastTriggered": "2024-12-15 13:45",
      "conditions": ["Cart value > \$50", "User logged in"],
      "workflows": ["Cart Recovery", "Discount Offer"],
      "priority": "high",
      "icon": Icons.shopping_cart
    },
    {
      "id": "3",
      "name": "Order Completed",
      "description": "Triggered when customer completes purchase",
      "category": "user_actions",
      "type": "event",
      "status": "active",
      "usageCount": 234,
      "lastTriggered": "2024-12-15 15:20",
      "conditions": ["Payment confirmed", "Order processed"],
      "workflows": ["Order Confirmation", "Delivery Updates"],
      "priority": "high",
      "icon": Icons.check_circle
    },
    {
      "id": "4",
      "name": "Subscription Expires",
      "description": "Triggered 7 days before subscription expires",
      "category": "time_based",
      "type": "scheduled",
      "status": "active",
      "usageCount": 67,
      "lastTriggered": "2024-12-15 09:00",
      "conditions": ["Active subscription", "Auto-renewal disabled"],
      "workflows": ["Renewal Reminder", "Upgrade Offer"],
      "priority": "medium",
      "icon": Icons.schedule
    },
    {
      "id": "5",
      "name": "Data Update",
      "description": "Triggered when customer data changes",
      "category": "data_changes",
      "type": "webhook",
      "status": "paused",
      "usageCount": 45,
      "lastTriggered": "2024-12-10 11:15",
      "conditions": ["Field changed", "Validation passed"],
      "workflows": ["Data Sync", "Profile Update"],
      "priority": "low",
      "icon": Icons.update
    },
    {
      "id": "6",
      "name": "API Integration",
      "description": "Triggered by external API calls",
      "category": "external_events",
      "type": "api",
      "status": "active",
      "usageCount": 123,
      "lastTriggered": "2024-12-15 16:10",
      "conditions": ["Valid API key", "Rate limit not exceeded"],
      "workflows": ["Data Processing", "Notification Send"],
      "priority": "medium",
      "icon": Icons.api
    },
  ];

  List<Map<String, dynamic>> triggerTypes = [
    {
      "type": "event",
      "name": "Event Trigger",
      "description": "Triggered by user or system events",
      "icon": Icons.flash_on,
      "color": Colors.orange,
      "examples": ["User registration", "Order placement", "Login"]
    },
    {
      "type": "time_delay",
      "name": "Time Delay",
      "description": "Triggered after specified time period",
      "icon": Icons.timer,
      "color": Colors.blue,
      "examples": ["1 hour after cart abandon", "3 days after signup"]
    },
    {
      "type": "scheduled",
      "name": "Scheduled",
      "description": "Triggered at specific date/time",
      "icon": Icons.schedule,
      "color": Colors.green,
      "examples": ["Daily at 9 AM", "Weekly on Monday", "Monthly report"]
    },
    {
      "type": "webhook",
      "name": "Webhook",
      "description": "Triggered by external webhook calls",
      "icon": Icons.webhook,
      "color": Colors.purple,
      "examples": ["Payment received", "Form submitted", "Status changed"]
    },
    {
      "type": "api",
      "name": "API Call",
      "description": "Triggered by API integrations",
      "icon": Icons.api,
      "color": Colors.teal,
      "examples": ["CRM update", "Third-party sync", "Data import"]
    },
    {
      "type": "condition",
      "name": "Conditional",
      "description": "Triggered when conditions are met",
      "icon": Icons.rule,
      "color": Colors.indigo,
      "examples": ["Score threshold", "Behavior pattern", "Data criteria"]
    },
  ];

  List<Map<String, dynamic>> get filteredTriggers {
    List<Map<String, dynamic>> filtered = triggers;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((trigger) => trigger["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((trigger) => 
        (trigger["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (trigger["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  void _createTrigger() {
    si("Opening trigger builder...");
  }

  void _editTrigger(Map<String, dynamic> trigger) {
    si("Editing ${trigger["name"]}...");
  }

  void _duplicateTrigger(Map<String, dynamic> trigger) {
    si("Trigger duplicated successfully");
  }

  void _deleteTrigger(Map<String, dynamic> trigger) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this trigger?");
    if (isConfirmed) {
      ss("Trigger deleted successfully");
    }
  }

  void _toggleTrigger(Map<String, dynamic> trigger) {
    trigger["status"] = trigger["status"] == "active" ? "paused" : "active";
    si("Trigger ${trigger["status"]}");
    setState(() {});
  }

  void _testTrigger(Map<String, dynamic> trigger) {
    si("Testing trigger: ${trigger["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trigger Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createTrigger,
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
        onPressed: _createTrigger,
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
                  label: "Search triggers...",
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
    int activeCount = triggers.where((t) => t["status"] == "active").length;
    int totalUsage = triggers.map((t) => t["usageCount"] as int).reduce((a, b) => a + b);
    int pausedCount = triggers.where((t) => t["status"] == "paused").length;
    int highPriorityCount = triggers.where((t) => t["priority"] == "high").length;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildStatCard("Active Triggers", activeCount, Icons.play_circle, Colors.green),
        _buildStatCard("Total Usage", totalUsage, Icons.bar_chart, Colors.blue),
        _buildStatCard("Paused", pausedCount, Icons.pause_circle, Colors.orange),
        _buildStatCard("High Priority", highPriorityCount, Icons.priority_high, Colors.red),
      ],
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
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
                _buildTabButton("Triggers", 0),
                _buildTabButton("Types", 1),
                _buildTabButton("Analytics", 2),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            child: selectedTab == 0
                ? _buildTriggersTab()
                : selectedTab == 1
                    ? _buildTypesTab()
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

  Widget _buildTriggersTab() {
    return Column(
      spacing: spSm,
      children: filteredTriggers.map((trigger) {
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
                      trigger["icon"],
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
                              "${trigger["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            _buildStatusBadge(trigger["status"]),
                          ],
                        ),
                        Text(
                          "${trigger["description"]}",
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
                    child: _buildTriggerInfo("Type", "${trigger["type"]}", Icons.category),
                  ),
                  Expanded(
                    child: _buildTriggerInfo("Usage", "${trigger["usageCount"]}", Icons.bar_chart),
                  ),
                  Expanded(
                    child: _buildTriggerInfo("Priority", "${trigger["priority"]}", Icons.priority_high),
                  ),
                ],
              ),
              if (trigger["conditions"] != null) ...[
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
                        "Conditions:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      ...(trigger["conditions"] as List).map((condition) {
                        return Row(
                          children: [
                            Icon(Icons.check_circle, size: 12, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "$condition",
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
              ],
              if (trigger["workflows"] != null) ...[
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
                        "Connected Workflows:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      QHorizontalScroll(
                        children: (trigger["workflows"] as List).map((workflow) {
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
                    "Last triggered: ${trigger["lastTriggered"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _testTrigger(trigger),
                        child: Icon(Icons.play_arrow, color: infoColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _editTrigger(trigger),
                        child: Icon(Icons.edit, color: warningColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _toggleTrigger(trigger),
                        child: Icon(
                          trigger["status"] == "active" ? Icons.pause : Icons.play_circle,
                          color: trigger["status"] == "active" ? warningColor : successColor,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _duplicateTrigger(trigger),
                        child: Icon(Icons.copy, color: primaryColor, size: 18),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _deleteTrigger(trigger),
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

  Widget _buildTriggerInfo(String label, String value, IconData icon) {
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

  Widget _buildTypesTab() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Available Trigger Types",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...triggerTypes.map((type) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (type["color"] as Color).withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        type["icon"],
                        color: type["color"],
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${type["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${type["description"]}",
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
                        "Examples:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      ...(type["examples"] as List).map((example) {
                        return Row(
                          children: [
                            Icon(Icons.arrow_right, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "$example",
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
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create ${type["name"]}",
                    size: bs.sm,
                    onPressed: () {
                      si("Creating ${type["name"]}...");
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    Map<String, int> categoryCount = {};
    Map<String, int> typeCount = {};
    
    for (var trigger in triggers) {
      String category = trigger["category"];
      String type = trigger["type"];
      
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      typeCount[type] = (typeCount[type] ?? 0) + 1;
    }

    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnalyticsCard("Total Triggers", "${triggers.length}", Icons.flash_on, Colors.blue),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildAnalyticsCard("Active", "${triggers.where((t) => t["status"] == "active").length}", Icons.play_circle, Colors.green),
            ),
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
                "Triggers by Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              ...categoryCount.entries.map((entry) {
                double percentage = (entry.value / triggers.length) * 100;
                return _buildCategoryBar(entry.key, entry.value, percentage);
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
                "Triggers by Type",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              ...typeCount.entries.map((entry) {
                double percentage = (entry.value / triggers.length) * 100;
                return _buildTypeBar(entry.key, entry.value, percentage);
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

  Widget _buildTypeBar(String type, int count, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              type.replaceAll("_", " ").toUpperCase(),
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
                color: successColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
