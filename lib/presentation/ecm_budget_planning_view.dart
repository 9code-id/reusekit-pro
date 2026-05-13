import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmBudgetPlanningView extends StatefulWidget {
  const EcmBudgetPlanningView({super.key});

  @override
  State<EcmBudgetPlanningView> createState() => _EcmBudgetPlanningViewState();
}

class _EcmBudgetPlanningViewState extends State<EcmBudgetPlanningView> {
  int currentTab = 0;
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  
  List<Map<String, dynamic>> budgetCategories = [
    {
      "category": "Marketing",
      "budgeted": 15000.0,
      "spent": 12500.0,
      "remaining": 2500.0,
      "percentage": 83.3,
      "status": "On Track",
      "color": primaryColor,
      "icon": Icons.campaign,
      "trend": "up",
      "variance": 500.0,
    },
    {
      "category": "Inventory",
      "budgeted": 25000.0,
      "spent": 28000.0,
      "remaining": -3000.0,
      "percentage": 112.0,
      "status": "Over Budget",
      "color": dangerColor,
      "icon": Icons.inventory,
      "trend": "up",
      "variance": 3000.0,
    },
    {
      "category": "Operations",
      "budgeted": 12000.0,
      "spent": 8500.0,
      "remaining": 3500.0,
      "percentage": 70.8,
      "status": "Under Budget",
      "color": successColor,
      "icon": Icons.settings,
      "trend": "down",
      "variance": -1500.0,
    },
    {
      "category": "Staff & Salaries",
      "budgeted": 35000.0,
      "spent": 35000.0,
      "remaining": 0.0,
      "percentage": 100.0,
      "status": "On Budget",
      "color": infoColor,
      "icon": Icons.people,
      "trend": "stable",
      "variance": 0.0,
    },
    {
      "category": "Shipping & Logistics",
      "budgeted": 8000.0,
      "spent": 9200.0,
      "remaining": -1200.0,
      "percentage": 115.0,
      "status": "Over Budget",
      "color": warningColor,
      "icon": Icons.local_shipping,
      "trend": "up",
      "variance": 1200.0,
    },
    {
      "category": "Technology",
      "budgeted": 6000.0,
      "spent": 4200.0,
      "remaining": 1800.0,
      "percentage": 70.0,
      "status": "Under Budget",
      "color": successColor,
      "icon": Icons.computer,
      "trend": "down",
      "variance": -800.0,
    },
  ];

  List<Map<String, dynamic>> budgetPlans = [
    {
      "id": "BP001",
      "name": "Q1 2024 Budget Plan",
      "period": "Jan - Mar 2024",
      "totalBudget": 125000.0,
      "status": "Active",
      "categories": 8,
      "createdDate": "2024-01-01",
      "approvedBy": "Sarah Johnson",
      "variance": 2500.0,
    },
    {
      "id": "BP002", 
      "name": "Q2 2024 Budget Plan",
      "period": "Apr - Jun 2024",
      "totalBudget": 135000.0,
      "status": "Draft",
      "categories": 8,
      "createdDate": "2024-03-15",
      "approvedBy": "",
      "variance": 0.0,
    },
    {
      "id": "BP003",
      "name": "Annual Marketing Budget",
      "period": "2024",
      "totalBudget": 60000.0,
      "status": "Active",
      "categories": 4,
      "createdDate": "2023-12-15",
      "approvedBy": "Mike Chen",
      "variance": -5000.0,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "action": "Budget Exceeded",
      "category": "Inventory",
      "amount": 3000.0,
      "user": "System Alert",
      "timestamp": "2024-03-20T10:30:00",
      "type": "alert",
    },
    {
      "action": "Budget Updated",
      "category": "Marketing",
      "amount": 15000.0,
      "user": "Sarah Johnson",
      "timestamp": "2024-03-19T14:15:00",
      "type": "update",
    },
    {
      "action": "New Budget Plan Created",
      "category": "Q2 2024",
      "amount": 135000.0,
      "user": "Mike Chen",
      "timestamp": "2024-03-15T09:00:00",
      "type": "create",
    },
    {
      "action": "Budget Approved",
      "category": "Technology",
      "amount": 6000.0,
      "user": "Admin",
      "timestamp": "2024-03-14T16:45:00",
      "type": "approve",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Inventory", "value": "Inventory"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Staff & Salaries", "value": "Staff & Salaries"},
    {"label": "Shipping & Logistics", "value": "Shipping & Logistics"},
    {"label": "Technology", "value": "Technology"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Budget Planning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Plans", icon: Icon(Icons.timeline)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCategoriesTab(),
        _buildPlansTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double totalBudgeted = budgetCategories.fold(0.0, (sum, item) => sum + (item["budgeted"] as double));
    double totalSpent = budgetCategories.fold(0.0, (sum, item) => sum + (item["spent"] as double));
    double totalRemaining = totalBudgeted - totalSpent;
    double overallPercentage = (totalSpent / totalBudgeted) * 100;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Period Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Budgeted",
                "\$${totalBudgeted.currency}",
                Icons.account_balance_wallet,
                primaryColor,
              ),
              _buildSummaryCard(
                "Total Spent",
                "\$${totalSpent.currency}",
                Icons.money_off,
                dangerColor,
              ),
              _buildSummaryCard(
                "Remaining Budget",
                "\$${totalRemaining.currency}",
                Icons.savings,
                totalRemaining >= 0 ? successColor : dangerColor,
              ),
              _buildSummaryCard(
                "Budget Utilization",
                "${overallPercentage.toStringAsFixed(1)}%",
                Icons.pie_chart,
                overallPercentage <= 100 ? infoColor : warningColor,
              ),
            ],
          ),

          // Budget Status Chart
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Budget Allocation by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...budgetCategories.take(4).map((category) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              category["icon"] as IconData,
                              color: category["color"] as Color,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${category["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "\$${(category["budgeted"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (category["percentage"] as double) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            category["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Quick Actions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
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
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: [
                    _buildActionCard(
                      "Create New Budget",
                      "Set up budget for new period",
                      Icons.add_circle,
                      primaryColor,
                    ),
                    _buildActionCard(
                      "Adjust Categories",
                      "Modify existing budget allocations",
                      Icons.edit,
                      infoColor,
                    ),
                    _buildActionCard(
                      "Generate Report",
                      "Export budget performance report",
                      Icons.file_download,
                      successColor,
                    ),
                    _buildActionCard(
                      "Set Alerts",
                      "Configure budget threshold alerts",
                      Icons.notifications,
                      warningColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Category",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Categories List
          ...budgetCategories.map((category) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: category["color"] as Color,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: category["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${category["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: category["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(category["budgeted"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(category["percentage"] as double).toStringAsFixed(1)}% used",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  LinearProgressIndicator(
                    value: (category["percentage"] as double) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      category["color"] as Color,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(category["spent"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Remaining",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(category["remaining"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (category["remaining"] as double) >= 0 
                                    ? successColor 
                                    : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Variance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  category["trend"] == "up"
                                      ? Icons.trending_up
                                      : category["trend"] == "down"
                                          ? Icons.trending_down
                                          : Icons.trending_flat,
                                  size: 16,
                                  color: category["trend"] == "up"
                                      ? dangerColor
                                      : category["trend"] == "down"
                                          ? successColor
                                          : infoColor,
                                ),
                                SizedBox(width: spXxs),
                                Text(
                                  "${(category["variance"] as double) >= 0 ? '+' : ''}\$${(category["variance"] as double).abs().currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: category["trend"] == "up"
                                        ? dangerColor
                                        : category["trend"] == "down"
                                            ? successColor
                                            : infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit Budget",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
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

  Widget _buildPlansTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header Actions
          Row(
            children: [
              Expanded(
                child: Text(
                  "Budget Plans",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Create Plan",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Plans List
          ...budgetPlans.map((plan) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
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
                              "${plan["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Period: ${plan["period"]}",
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
                          color: plan["status"] == "Active"
                              ? successColor.withAlpha(20)
                              : plan["status"] == "Draft"
                                  ? warningColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${plan["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: plan["status"] == "Active"
                                ? successColor
                                : plan["status"] == "Draft"
                                    ? warningColor
                                    : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Total Budget",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(plan["totalBudget"] as double).currency}",
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
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${plan["categories"]}",
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
                          children: [
                            Text(
                              "Variance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(plan["variance"] as double) >= 0 ? '+' : ''}\$${(plan["variance"] as double).abs().currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (plan["variance"] as double) >= 0 
                                    ? successColor 
                                    : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (plan["approvedBy"] != "")
                    Padding(
                      padding: EdgeInsets.only(top: spSm),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Approved by ${plan["approvedBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: plan["status"] == "Draft" ? "Approve" : "Edit",
                          size: bs.sm,
                          onPressed: () {},
                        ),
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

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Row(
            children: [
              Text(
                "Recent Activities",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Activities List
          ...recentActivities.map((activity) {
            IconData actionIcon;
            Color actionColor;
            
            switch (activity["type"]) {
              case "alert":
                actionIcon = Icons.warning;
                actionColor = dangerColor;
                break;
              case "update":
                actionIcon = Icons.edit;
                actionColor = infoColor;
                break;
              case "create":
                actionIcon = Icons.add_circle;
                actionColor = successColor;
                break;
              case "approve":
                actionIcon = Icons.check_circle;
                actionColor = primaryColor;
                break;
              default:
                actionIcon = Icons.info;
                actionColor = disabledBoldColor;
            }

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: actionColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      actionIcon,
                      color: actionColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["action"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Category: ${activity["category"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "By: ${activity["user"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${(activity["amount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: actionColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        DateTime.parse(activity["timestamp"]).dMMMy,
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
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
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
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Access",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
