import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSeedManagementView extends StatefulWidget {
  const AmaSeedManagementView({super.key});

  @override
  State<AmaSeedManagementView> createState() => _AmaSeedManagementViewState();
}

class _AmaSeedManagementViewState extends State<AmaSeedManagementView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Seed Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Varieties", icon: Icon(Icons.grain)),
        Tab(text: "Planning", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildInventoryTab(),
        _buildVarietiesTab(),
        _buildPlanningTab(),
      ],
      onInit: (tabController) {
        // Tab controller initialized
      },
    );
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> seedStats = [
      {
        "title": "Total Varieties",
        "value": "24",
        "icon": Icons.grain,
        "color": primaryColor,
        "change": "+3",
      },
      {
        "title": "Total Stock",
        "value": "850 kg",
        "icon": Icons.inventory,
        "color": successColor,
        "change": "+125 kg",
      },
      {
        "title": "Low Stock Items",
        "value": "5",
        "icon": Icons.warning,
        "color": warningColor,
        "change": "-2",
      },
      {
        "title": "Planting Schedule",
        "value": "8 crops",
        "icon": Icons.schedule,
        "color": infoColor,
        "change": "+2",
      },
    ];

    List<Map<String, dynamic>> recentActivity = [
      {
        "action": "Added new variety",
        "details": "Golden Rice - 50kg received",
        "time": "2 hours ago",
        "icon": Icons.add_circle,
        "color": successColor,
      },
      {
        "action": "Planted seeds",
        "details": "Wheat variety A - 25kg used",
        "time": "5 hours ago",
        "icon": Icons.agriculture,
        "color": primaryColor,
      },
      {
        "action": "Low stock alert",
        "details": "Corn hybrid - Only 10kg remaining",
        "time": "1 day ago",
        "icon": Icons.warning,
        "color": warningColor,
      },
      {
        "action": "Quality test",
        "details": "Tomato seeds - 95% germination rate",
        "time": "2 days ago",
        "icon": Icons.science,
        "color": infoColor,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          _buildStatsGrid(seedStats),
          _buildQuickActions(),
          _buildRecentActivity(recentActivity),
          _buildUpcomingReminders(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(80)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.grain,
            size: 48,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "Seed Management Dashboard",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Manage your seed inventory, varieties, and planting schedules efficiently",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(List<Map<String, dynamic>> stats) {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 24,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${stat["change"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${stat["value"]}",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${stat["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {
        "title": "Add New Variety",
        "icon": Icons.add_circle,
        "color": successColor,
        "action": () => _addNewVariety(),
      },
      {
        "title": "Update Inventory",
        "icon": Icons.inventory,
        "color": primaryColor,
        "action": () => _updateInventory(),
      },
      {
        "title": "Plan Planting",
        "icon": Icons.schedule,
        "color": infoColor,
        "action": () => _planPlanting(),
      },
      {
        "title": "Generate Report",
        "icon": Icons.assessment,
        "color": warningColor,
        "action": () => _generateReport(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
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
          children: actions.map((action) {
            return GestureDetector(
              onTap: action["action"],
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (action["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: (action["color"] as Color).withAlpha(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      action["icon"] as IconData,
                      color: action["color"] as Color,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${action["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: action["color"] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(List<Map<String, dynamic>> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...activities.map((activity) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (activity["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    activity["icon"] as IconData,
                    color: activity["color"] as Color,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${activity["action"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${activity["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${activity["time"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUpcomingReminders() {
    List<Map<String, dynamic>> reminders = [
      {
        "title": "Germination Test",
        "details": "Test wheat seeds batch #WH-2024-03",
        "date": "Tomorrow",
        "priority": "high",
      },
      {
        "title": "Seed Order",
        "details": "Order tomato seeds for next season",
        "date": "In 3 days",
        "priority": "medium",
      },
      {
        "title": "Quality Check",
        "details": "Inspect corn seed storage conditions",
        "date": "Next week",
        "priority": "low",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Reminders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...reminders.map((reminder) {
          Color priorityColor = reminder["priority"] == "high"
              ? dangerColor
              : reminder["priority"] == "medium"
                  ? warningColor
                  : infoColor;

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
                  color: priorityColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${reminder["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${reminder["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: priorityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${reminder["date"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildInventoryTab() {
    return Center(
      child: Text(
        "Inventory Management Tab\n(Placeholder for detailed inventory view)",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildVarietiesTab() {
    return Center(
      child: Text(
        "Seed Varieties Tab\n(Placeholder for varieties catalog)",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildPlanningTab() {
    return Center(
      child: Text(
        "Planting Planning Tab\n(Placeholder for planting schedule)",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  void _addNewVariety() {
    ss("Add new variety functionality");
  }

  void _updateInventory() {
    ss("Update inventory functionality");
  }

  void _planPlanting() {
    ss("Plan planting functionality");
  }

  void _generateReport() {
    ss("Generate report functionality");
  }
}
