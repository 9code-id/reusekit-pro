import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCostAnalysisView extends StatefulWidget {
  const FsmCostAnalysisView({super.key});

  @override
  State<FsmCostAnalysisView> createState() => _FsmCostAnalysisViewState();
}

class _FsmCostAnalysisViewState extends State<FsmCostAnalysisView> {
  String selectedPeriod = "This Month";
  String selectedCostType = "All Costs";
  String selectedDepartment = "All Departments";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> costTypeItems = [
    {"label": "All Costs", "value": "All Costs"},
    {"label": "Labor Costs", "value": "Labor Costs"},
    {"label": "Material Costs", "value": "Material Costs"},
    {"label": "Travel Costs", "value": "Travel Costs"},
    {"label": "Equipment Costs", "value": "Equipment Costs"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Repair", "value": "Repair"},
    {"label": "Emergency", "value": "Emergency"},
  ];

  List<Map<String, dynamic>> costMetrics = [
    {
      "metric": "Total Costs",
      "value": 284500,
      "target": 290000,
      "change": -1.9,
      "icon": Icons.monetization_on,
      "color": primaryColor,
      "budget": 300000,
    },
    {
      "metric": "Cost per Job",
      "value": 228.50,
      "target": 250.00,
      "change": -8.6,
      "icon": Icons.work,
      "color": successColor,
      "budget": 260.00,
    },
    {
      "metric": "Labor Costs",
      "value": 156750,
      "target": 160000,
      "change": -2.0,
      "icon": Icons.person,
      "color": infoColor,
      "budget": 165000,
    },
    {
      "metric": "Material Costs",
      "value": 89200,
      "target": 95000,
      "change": -6.1,
      "icon": Icons.inventory,
      "color": warningColor,
      "budget": 100000,
    },
  ];

  List<Map<String, dynamic>> costBreakdown = [
    {"category": "Labor Costs", "amount": 156750, "percentage": 55.1, "color": primaryColor},
    {"category": "Materials", "amount": 89200, "percentage": 31.4, "color": warningColor},
    {"category": "Travel & Transport", "amount": 22650, "percentage": 8.0, "color": infoColor},
    {"category": "Equipment & Tools", "amount": 15900, "percentage": 5.5, "color": successColor},
  ];

  List<Map<String, dynamic>> departmentCosts = [
    {
      "department": "Installation",
      "totalCost": 95500,
      "costPerJob": 275.25,
      "jobCount": 347,
      "budgetUsed": 79.6,
      "trend": 3.2,
    },
    {
      "department": "Maintenance",
      "totalCost": 76800,
      "costPerJob": 184.50,
      "jobCount": 416,
      "budgetUsed": 85.3,
      "trend": -5.1,
    },
    {
      "department": "Repair",
      "totalCost": 68400,
      "costPerJob": 198.25,
      "jobCount": 345,
      "budgetUsed": 91.2,
      "trend": 8.7,
    },
    {
      "department": "Emergency",
      "totalCost": 43800,
      "costPerJob": 365.00,
      "jobCount": 120,
      "budgetUsed": 73.0,
      "trend": -2.4,
    },
  ];

  List<Map<String, dynamic>> topExpenses = [
    {
      "description": "HVAC Parts & Components",
      "amount": 18500,
      "category": "Materials",
      "frequency": "Weekly",
      "vendor": "Climate Solutions Inc.",
      "trend": 12.5,
    },
    {
      "description": "Electrical Supplies",
      "amount": 15200,
      "category": "Materials",
      "frequency": "Bi-weekly",
      "vendor": "ElectroMax Supply",
      "trend": -3.8,
    },
    {
      "description": "Overtime Labor",
      "amount": 14800,
      "category": "Labor",
      "frequency": "Monthly",
      "vendor": "Internal",
      "trend": 8.9,
    },
    {
      "description": "Vehicle Fuel & Maintenance",
      "amount": 12300,
      "category": "Travel",
      "frequency": "Monthly",
      "vendor": "Fleet Services",
      "trend": 15.2,
    },
    {
      "description": "Specialized Tools",
      "amount": 8900,
      "category": "Equipment",
      "frequency": "Quarterly",
      "vendor": "ToolPro Industries",
      "trend": -7.3,
    },
  ];

  List<Map<String, dynamic>> costOptimization = [
    {
      "opportunity": "Bulk Material Purchasing",
      "potentialSaving": 12500,
      "impact": "High",
      "timeframe": "3 months",
      "description": "Negotiate bulk discounts with suppliers for frequently used materials",
    },
    {
      "opportunity": "Route Optimization",
      "potentialSaving": 8200,
      "impact": "Medium",
      "timeframe": "1 month",
      "description": "Implement route planning software to reduce travel costs",
    },
    {
      "opportunity": "Preventive Maintenance",
      "potentialSaving": 15300,
      "impact": "High",
      "timeframe": "6 months",
      "description": "Increase preventive maintenance to reduce emergency repair costs",
    },
    {
      "opportunity": "Inventory Management",
      "potentialSaving": 6800,
      "impact": "Medium",
      "timeframe": "2 months",
      "description": "Optimize inventory levels to reduce carrying costs",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_down),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.filter_list, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Cost Analysis Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periodItems,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Cost Type",
                          items: costTypeItems,
                          value: selectedCostType,
                          onChanged: (value, label) {
                            selectedCostType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Department",
                    items: departmentItems,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Cost Metrics
            Text(
              "Cost Overview",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: costMetrics.map((metric) {
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
                              color: (metric["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) <= 0 ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) <= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((metric["value"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: ((metric["value"] as num).toDouble()) / ((metric["budget"] as num).toDouble()),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: metric["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(((metric["value"] as num).toDouble()) / ((metric["budget"] as num).toDouble()) * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Budget: \$${((metric["budget"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Cost Breakdown
            Container(
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
                      Icon(Icons.pie_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Cost Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: costBreakdown.map((category) {
                      return Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: category["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "\$${((category["amount"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "(${(category["percentage"] as double).toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Department Costs
            Container(
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
                      Icon(Icons.business, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Department Cost Analysis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: departmentCosts.map((dept) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${dept["department"]} Department",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (dept["trend"] as double) <= 0 ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${(dept["trend"] as double) >= 0 ? '+' : ''}${(dept["trend"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: (dept["trend"] as double) <= 0 ? successColor : dangerColor,
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
                                    children: [
                                      Text(
                                        "\$${((dept["totalCost"] as num).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Total Cost",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\$${((dept["costPerJob"] as num).toDouble()).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Cost per Job",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${dept["jobCount"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Jobs",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${dept["budgetUsed"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: (dept["budgetUsed"] as double) > 90 ? dangerColor : 
                                                 (dept["budgetUsed"] as double) > 80 ? warningColor : successColor,
                                        ),
                                      ),
                                      Text(
                                        "Budget Used",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Top Expenses
            Container(
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
                      Icon(Icons.trending_up, color: dangerColor),
                      SizedBox(width: spSm),
                      Text(
                        "Top Expenses",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: topExpenses.map((expense) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${expense["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${((expense["amount"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${expense["category"]} • ${expense["frequency"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(expense["trend"] as double) >= 0 ? '+' : ''}${(expense["trend"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (expense["trend"] as double) >= 0 ? dangerColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Vendor: ${expense["vendor"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
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

            // Cost Optimization
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.savings, color: successColor),
                      SizedBox(width: spSm),
                      Text(
                        "Cost Optimization Opportunities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: costOptimization.map((opportunity) {
                      Color impactColor = opportunity["impact"] == "High" ? successColor : warningColor;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${opportunity["opportunity"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: impactColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${opportunity["impact"]} Impact",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: impactColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${opportunity["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Potential Saving: \$${((opportunity["potentialSaving"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Timeframe: ${opportunity["timeframe"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.trending_down, color: successColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Total potential annual savings: \$${((costOptimization.fold(0.0, (sum, item) => sum + (item["potentialSaving"] as num).toDouble())) * 12).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Budget Plan",
                    icon: Icons.account_balance_wallet,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
