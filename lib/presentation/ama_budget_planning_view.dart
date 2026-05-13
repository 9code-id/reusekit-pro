import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaBudgetPlanningView extends StatefulWidget {
  const AmaBudgetPlanningView({super.key});

  @override
  State<AmaBudgetPlanningView> createState() => _AmaBudgetPlanningViewState();
}

class _AmaBudgetPlanningViewState extends State<AmaBudgetPlanningView> {
  String selectedYear = "2024";
  String selectedCrop = "All Crops";
  String budgetName = "";
  String budgetDescription = "";
  String selectedCategory = "Seeds";
  String plannedAmount = "";
  String notes = "";
  
  bool showAddBudget = false;

  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2025", "value": "2025"},
    {"label": "2026", "value": "2026"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "All Crops"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Soybeans", "value": "Soybeans"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Seeds", "value": "Seeds"},
    {"label": "Fertilizer", "value": "Fertilizer"},
    {"label": "Pesticides", "value": "Pesticides"},
    {"label": "Labor", "value": "Labor"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Fuel", "value": "Fuel"},
    {"label": "Irrigation", "value": "Irrigation"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> budgetCategories = [
    {
      "category": "Seeds",
      "planned": 18000.0,
      "actual": 15000.0,
      "remaining": 3000.0,
      "percentage": 83.3,
      "color": Colors.green,
      "icon": Icons.eco,
      "status": "on_track",
    },
    {
      "category": "Fertilizer",
      "planned": 25000.0,
      "actual": 21200.0,
      "remaining": 3800.0,
      "percentage": 84.8,
      "color": Colors.brown,
      "icon": Icons.grass,
      "status": "on_track",
    },
    {
      "category": "Pesticides",
      "planned": 12000.0,
      "actual": 9800.0,
      "remaining": 2200.0,
      "percentage": 81.7,
      "color": Colors.red,
      "icon": Icons.bug_report,
      "status": "on_track",
    },
    {
      "category": "Labor",
      "planned": 20000.0,
      "actual": 16500.0,
      "remaining": 3500.0,
      "percentage": 82.5,
      "color": Colors.blue,
      "icon": Icons.people,
      "status": "on_track",
    },
    {
      "category": "Equipment",
      "planned": 15000.0,
      "actual": 8900.0,
      "remaining": 6100.0,
      "percentage": 59.3,
      "color": Colors.purple,
      "icon": Icons.build,
      "status": "under_budget",
    },
    {
      "category": "Fuel",
      "planned": 8000.0,
      "actual": 5200.0,
      "remaining": 2800.0,
      "percentage": 65.0,
      "color": Colors.orange,
      "icon": Icons.local_gas_station,
      "status": "under_budget",
    },
    {
      "category": "Marketing",
      "planned": 10000.0,
      "actual": 12500.0,
      "remaining": -2500.0,
      "percentage": 125.0,
      "color": Colors.indigo,
      "icon": Icons.campaign,
      "status": "over_budget",
    },
    {
      "category": "Insurance",
      "planned": 7000.0,
      "actual": 7000.0,
      "remaining": 0.0,
      "percentage": 100.0,
      "color": Colors.teal,
      "icon": Icons.security,
      "status": "on_track",
    },
  ];

  List<Map<String, dynamic>> monthlyBudget = [
    {"month": "Jan", "planned": 8500.0, "actual": 8200.0, "variance": -300.0},
    {"month": "Feb", "planned": 7200.0, "actual": 7800.0, "variance": 600.0},
    {"month": "Mar", "planned": 12000.0, "actual": 12500.0, "variance": 500.0},
    {"month": "Apr", "planned": 15000.0, "actual": 15800.0, "variance": 800.0},
    {"month": "May", "planned": 11500.0, "actual": 11200.0, "variance": -300.0},
    {"month": "Jun", "planned": 10000.0, "actual": 9800.0, "variance": -200.0},
    {"month": "Jul", "planned": 9500.0, "actual": 0.0, "variance": 0.0},
    {"month": "Aug", "planned": 8800.0, "actual": 0.0, "variance": 0.0},
    {"month": "Sep", "planned": 11200.0, "actual": 0.0, "variance": 0.0},
    {"month": "Oct", "planned": 13500.0, "actual": 0.0, "variance": 0.0},
    {"month": "Nov", "planned": 12800.0, "actual": 0.0, "variance": 0.0},
    {"month": "Dec", "planned": 9000.0, "actual": 0.0, "variance": 0.0},
  ];

  List<Map<String, dynamic>> scenarios = [
    {
      "name": "Conservative",
      "description": "Low-risk, minimal investment scenario",
      "totalBudget": 95000.0,
      "expectedProfit": 28500.0,
      "riskLevel": "Low",
      "color": Colors.green,
    },
    {
      "name": "Moderate",
      "description": "Balanced investment with moderate risk",
      "totalBudget": 128000.0,
      "expectedProfit": 44800.0,
      "riskLevel": "Medium",
      "color": Colors.orange,
    },
    {
      "name": "Aggressive",
      "description": "High investment, high potential returns",
      "totalBudget": 165000.0,
      "expectedProfit": 66000.0,
      "riskLevel": "High",
      "color": Colors.red,
    },
  ];

  double get totalPlanned => budgetCategories.fold(0.0, (sum, item) => sum + (item["planned"] as double));
  double get totalActual => budgetCategories.fold(0.0, (sum, item) => sum + (item["actual"] as double));
  double get totalRemaining => totalPlanned - totalActual;
  double get overallProgress => totalPlanned > 0 ? (totalActual / totalPlanned) * 100 : 0;

  void _addBudgetItem() {
    if (budgetName.isNotEmpty && plannedAmount.isNotEmpty) {
      // Add logic to create new budget item
      budgetName = "";
      budgetDescription = "";
      plannedAmount = "";
      notes = "";
      showAddBudget = false;
      
      setState(() {});
      ss("Budget item added successfully");
    } else {
      se("Please fill in required fields");
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "on_track":
        return successColor;
      case "under_budget":
        return infoColor;
      case "over_budget":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "on_track":
        return "On Track";
      case "under_budget":
        return "Under Budget";
      case "over_budget":
        return "Over Budget";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Planning"),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {
              //navigateTo('AmaBudgetTimelineView')
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Budget plan exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Budget Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(128)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Annual Budget ${selectedYear}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Plan and track your farm budget efficiently",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Planned",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalPlanned.currency}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                              "Spent",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalActual.currency}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                      Text(
                        "Progress: ${overallProgress.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(204),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Remaining: \$${totalRemaining.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(102),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (overallProgress / 100).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: overallProgress > 90 ? dangerColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Year",
                    items: yearOptions,
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Crop",
                    items: cropOptions,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Budget Item",
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {
                      showAddBudget = true;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Scenarios",
                    icon: Icons.compare,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('AmaBudgetScenariosView')
                    },
                  ),
                ),
              ],
            ),

            // Add Budget Form
            if (showAddBudget) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Budget Item",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAddBudget = false;
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Budget Name",
                      value: budgetName,
                      hint: "e.g. Spring Corn Seeds",
                      onChanged: (value) {
                        budgetName = value;
                        setState(() {});
                      },
                    ),
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
                        Expanded(
                          child: QNumberField(
                            label: "Planned Amount (\$)",
                            value: plannedAmount,
                            onChanged: (value) {
                              plannedAmount = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Description",
                      value: budgetDescription,
                      hint: "Budget item description",
                      onChanged: (value) {
                        budgetDescription = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Notes",
                      value: notes,
                      hint: "Additional notes or considerations",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            onPressed: () {
                              showAddBudget = false;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Add Budget",
                            onPressed: _addBudgetItem,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Budget Categories
            Text(
              "Budget Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: budgetCategories.map((category) {
                  Color statusColor = _getStatusColor(category["status"] as String);
                  String statusText = _getStatusText(category["status"] as String);
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (category["color"] as Color).withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 16,
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
                                        "${category["category"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          statusText,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: ((category["percentage"] as double) / 100).clamp(0.0, 1.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: statusColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Planned: \$${((category["planned"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Actual: \$${((category["actual"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${(category["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                                Text(
                                  "Remaining: \$${((category["remaining"] as double)).abs().currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (category["remaining"] as double) >= 0 ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Monthly Budget Tracking
            Text(
              "Monthly Budget Tracking",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
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
                      Container(
                        width: 50,
                        child: Text(
                          "Month",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Planned vs Actual",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        child: Text(
                          "Variance",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ...monthlyBudget.map((month) {
                    double planned = month["planned"] as double;
                    double actual = month["actual"] as double;
                    double variance = month["variance"] as double;
                    bool hasData = actual > 0;
                    
                    return Row(
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            "${month["month"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        // Planned Bar
                                        Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(51),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: (planned / 20000).clamp(0.0, 1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        // Actual Bar
                                        if (hasData)
                                          Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: disabledColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: FractionallySizedBox(
                                              alignment: Alignment.centerLeft,
                                              widthFactor: (actual / 20000).clamp(0.0, 1.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: variance >= 0 ? dangerColor : successColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$${(planned / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (hasData)
                                        Text(
                                          "\$${(actual / 1000).toStringAsFixed(1)}K",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: variance >= 0 ? dangerColor : successColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          width: 80,
                          child: hasData
                              ? Text(
                                  "${variance >= 0 ? '+' : ''}\$${(variance / 1000).toStringAsFixed(1)}K",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: variance >= 0 ? dangerColor : successColor,
                                  ),
                                )
                              : Text(
                                  "-",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            // Budget Scenarios
            Text(
              "Budget Scenarios",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: scenarios.map((scenario) {
                  double roi = ((scenario["expectedProfit"] as double) / (scenario["totalBudget"] as double)) * 100;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (scenario["color"] as Color).withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.trending_up,
                                color: scenario["color"] as Color,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${scenario["name"]} Scenario",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${scenario["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: (scenario["color"] as Color).withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${scenario["riskLevel"]} Risk",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: scenario["color"] as Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Budget",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((scenario["totalBudget"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expected Profit",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((scenario["expectedProfit"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "ROI",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${roi.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: scenario["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
