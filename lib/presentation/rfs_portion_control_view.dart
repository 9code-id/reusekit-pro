import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPortionControlView extends StatefulWidget {
  const RfsPortionControlView({super.key});

  @override
  State<RfsPortionControlView> createState() => _RfsPortionControlViewState();
}

class _RfsPortionControlViewState extends State<RfsPortionControlView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Appetizers", "value": "Appetizers"},
    {"label": "Main Courses", "value": "Main Courses"},
    {"label": "Desserts", "value": "Desserts"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Sides", "value": "Sides"},
  ];

  List<Map<String, dynamic>> portionStandards = [
    {
      "id": "PS001",
      "itemName": "Grilled Salmon",
      "category": "Main Courses",
      "standardPortion": "6 oz",
      "standardCost": 9.40,
      "currentPortionAvg": "6.2 oz",
      "currentCostAvg": 9.72,
      "variance": 0.32,
      "variancePercentage": 3.4,
      "compliance": 92,
      "portions": [
        {"date": "2024-12-18", "weight": "6.1 oz", "cost": 9.55, "staff": "Chef Martinez"},
        {"date": "2024-12-18", "weight": "6.3 oz", "cost": 9.87, "staff": "Cook Johnson"},
        {"date": "2024-12-17", "weight": "5.9 oz", "cost": 9.25, "staff": "Chef Martinez"},
        {"date": "2024-12-17", "weight": "6.4 oz", "cost": 10.03, "staff": "Cook Smith"},
      ],
      "instructions": "Cut salmon fillet to exactly 6 oz using kitchen scale",
      "status": "Good",
    },
    {
      "id": "PS002",
      "itemName": "Caesar Salad",
      "category": "Appetizers", 
      "standardPortion": "4 oz lettuce",
      "standardCost": 3.80,
      "currentPortionAvg": "4.5 oz",
      "currentCostAvg": 4.28,
      "variance": 0.48,
      "variancePercentage": 12.6,
      "compliance": 78,
      "portions": [
        {"date": "2024-12-18", "weight": "4.8 oz", "cost": 4.56, "staff": "Prep Cook Lee"},
        {"date": "2024-12-18", "weight": "4.2 oz", "cost": 3.99, "staff": "Prep Cook Adams"},
        {"date": "2024-12-17", "weight": "4.6 oz", "cost": 4.37, "staff": "Prep Cook Lee"},
        {"date": "2024-12-17", "weight": "4.4 oz", "cost": 4.18, "staff": "Prep Cook Adams"},
      ],
      "instructions": "Use portion cup for exactly 4 oz of lettuce per salad",
      "status": "Attention Needed",
    },
    {
      "id": "PS003",
      "itemName": "Beef Wellington",
      "category": "Main Courses",
      "standardPortion": "8 oz beef",
      "standardCost": 18.20,
      "currentPortionAvg": "8.8 oz",
      "currentCostAvg": 20.02,
      "variance": 1.82,
      "variancePercentage": 10.0,
      "compliance": 65,
      "portions": [
        {"date": "2024-12-18", "weight": "9.2 oz", "cost": 20.93, "staff": "Chef Martinez"},
        {"date": "2024-12-17", "weight": "8.4 oz", "cost": 19.11, "staff": "Chef Martinez"},
        {"date": "2024-12-16", "weight": "8.9 oz", "cost": 20.25, "staff": "Sous Chef Brown"},
        {"date": "2024-12-16", "weight": "8.7 oz", "cost": 19.79, "staff": "Chef Martinez"},
      ],
      "instructions": "Weigh beef tenderloin to exactly 8 oz before wrapping",
      "status": "Critical",
    },
    {
      "id": "PS004",
      "itemName": "Chocolate Cake",
      "category": "Desserts",
      "standardPortion": "4 oz slice",
      "standardCost": 2.40,
      "currentPortionAvg": "3.8 oz",
      "currentCostAvg": 2.28,
      "variance": -0.12,
      "variancePercentage": -5.0,
      "compliance": 88,
      "portions": [
        {"date": "2024-12-18", "weight": "3.9 oz", "cost": 2.34, "staff": "Pastry Chef Wilson"},
        {"date": "2024-12-18", "weight": "3.7 oz", "cost": 2.22, "staff": "Pastry Chef Wilson"},
        {"date": "2024-12-17", "weight": "3.8 oz", "cost": 2.28, "staff": "Pastry Chef Wilson"},
        {"date": "2024-12-17", "weight": "3.8 oz", "cost": 2.28, "staff": "Prep Cook Davis"},
      ],
      "instructions": "Cut cake into uniform 4 oz slices using portion guide",
      "status": "Good",
    },
    {
      "id": "PS005",
      "itemName": "French Fries",
      "category": "Sides",
      "standardPortion": "5 oz",
      "standardCost": 1.25,
      "currentPortionAvg": "5.7 oz",
      "currentCostAvg": 1.43,
      "variance": 0.18,
      "variancePercentage": 14.4,
      "compliance": 72,
      "portions": [
        {"date": "2024-12-18", "weight": "6.1 oz", "cost": 1.53, "staff": "Fry Cook Thompson"},
        {"date": "2024-12-18", "weight": "5.3 oz", "cost": 1.33, "staff": "Fry Cook Miller"},
        {"date": "2024-12-17", "weight": "5.8 oz", "cost": 1.45, "staff": "Fry Cook Thompson"},
        {"date": "2024-12-17", "weight": "5.6 oz", "cost": 1.40, "staff": "Fry Cook Miller"},
      ],
      "instructions": "Use 5 oz portion basket for consistent fry portions",
      "status": "Attention Needed",
    },
  ];

  List<Map<String, dynamic>> staffPerformance = [
    {
      "name": "Chef Martinez",
      "position": "Head Chef",
      "compliance": 94,
      "avgVariance": 0.2,
      "itemsTracked": 45,
      "status": "Excellent",
    },
    {
      "name": "Pastry Chef Wilson",
      "position": "Pastry Chef",
      "compliance": 91,
      "avgVariance": 0.15,
      "itemsTracked": 28,
      "status": "Excellent",
    },
    {
      "name": "Sous Chef Brown",
      "position": "Sous Chef",
      "compliance": 87,
      "avgVariance": 0.35,
      "itemsTracked": 38,
      "status": "Good",
    },
    {
      "name": "Prep Cook Lee",
      "position": "Prep Cook",
      "compliance": 78,
      "avgVariance": 0.48,
      "itemsTracked": 32,
      "status": "Needs Training",
    },
    {
      "name": "Fry Cook Thompson",
      "position": "Fry Cook", 
      "compliance": 72,
      "avgVariance": 0.52,
      "itemsTracked": 25,
      "status": "Needs Training",
    },
  ];

  List<Map<String, dynamic>> get filteredStandards {
    return portionStandards.where((standard) {
      bool matchesSearch = "${standard["itemName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${standard["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || standard["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Good":
      case "Excellent":
        return successColor;
      case "Attention Needed":
      case "Needs Training":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  double get avgCompliance {
    if (portionStandards.isEmpty) return 0;
    return portionStandards.fold(0.0, (sum, item) => sum + (item["compliance"] as int)) / portionStandards.length;
  }

  double get totalVarianceCost {
    return portionStandards.fold(0.0, (sum, item) => sum + (item["variance"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Portion Control",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Standards", icon: Icon(Icons.straighten)),
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Staff Performance", icon: Icon(Icons.people)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildStandardsTab(),
        _buildTrackingTab(),
        _buildStaffPerformanceTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildStandardsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search items...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new portion standard
                },
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

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Standards", "${portionStandards.length}", Icons.straighten, primaryColor),
              _buildMetricCard("Avg Compliance", "${avgCompliance.toStringAsFixed(1)}%", Icons.check_circle, successColor),
              _buildMetricCard("Critical Items", "${portionStandards.where((s) => s["status"] == "Critical").length}", Icons.warning, dangerColor),
              _buildMetricCard("Cost Variance", totalVarianceCost > 0 ? "+\$${totalVarianceCost.currency}" : "\$${totalVarianceCost.abs().currency}", Icons.attach_money, totalVarianceCost > 0 ? dangerColor : successColor),
            ],
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredStandards.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final standard = filteredStandards[index];
              return _buildPortionStandardCard(standard);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recent Portion Measurements",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new measurement
                },
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(102)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Track portion weights to maintain consistency and control costs",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ...portionStandards.map((standard) => _buildTrackingCard(standard)),
        ],
      ),
    );
  }

  Widget _buildStaffPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStaffMetricCard("Total Staff", "${staffPerformance.length}", Icons.people, primaryColor),
              _buildStaffMetricCard("Excellent", "${staffPerformance.where((s) => s["status"] == "Excellent").length}", Icons.star, successColor),
              _buildStaffMetricCard("Need Training", "${staffPerformance.where((s) => s["status"] == "Needs Training").length}", Icons.school, warningColor),
              _buildStaffMetricCard("Avg Compliance", "${staffPerformance.fold(0, (sum, staff) => sum + (staff["compliance"] as int)) / staffPerformance.length}%", Icons.check_circle, infoColor),
            ],
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: staffPerformance.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final staff = staffPerformance[index];
              return _buildStaffPerformanceCard(staff);
            },
          ),

          Container(
            width: double.infinity,
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
                Text(
                  "Training Recommendations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...staffPerformance
                    .where((staff) => staff["status"] == "Needs Training")
                    .map((staff) => _buildTrainingRecommendation(staff)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Cost Savings Potential", "\$${(totalVarianceCost.abs() * 30).currency}/month", Icons.savings, successColor),
              _buildAnalyticsCard("Waste Reduction", "15%", Icons.eco, infoColor),
              _buildAnalyticsCard("Customer Satisfaction", "94%", Icons.sentiment_satisfied, warningColor),
              _buildAnalyticsCard("Profit Margin Impact", "+2.3%", Icons.trending_up, primaryColor),
            ],
          ),

          Container(
            width: double.infinity,
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
                Text(
                  "Compliance Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...portionStandards.map((standard) => _buildComplianceTrendItem(standard)),
              ],
            ),
          ),

          Container(
            width: double.infinity,
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
                Text(
                  "Cost Impact Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...portionStandards
                    .where((standard) => (standard["variance"] as double).abs() > 0.1)
                    .map((standard) => _buildCostImpactItem(standard)),
              ],
            ),
          ),

          Container(
            width: double.infinity,
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
                Text(
                  "Improvement Opportunities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildImprovementOpportunity(
                  "Beef Wellington Portion Control",
                  "10% variance causing \$54.60/month extra cost",
                  Icons.warning,
                  dangerColor,
                ),
                _buildImprovementOpportunity(
                  "French Fries Training",
                  "Staff training could reduce variance by 8%",
                  Icons.school,
                  warningColor,
                ),
                _buildImprovementOpportunity(
                  "Caesar Salad Standardization",
                  "Portion cups can improve consistency by 15%",
                  Icons.straighten,
                  infoColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortionStandardCard(Map<String, dynamic> standard) {
    Color statusColor = _getStatusColor("${standard["status"]}");
    bool isOverPortion = (standard["variance"] as double) > 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: standard["status"] == "Critical" 
            ? Border.all(color: dangerColor.withAlpha(102))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${standard["itemName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${standard["category"]} • ${standard["id"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${standard["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Standard Portion",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${standard["standardPortion"]}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Average",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${standard["currentPortionAvg"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isOverPortion ? dangerColor : successColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Standard Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(standard["standardCost"] as double).currency}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(standard["currentCostAvg"] as double).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isOverPortion ? dangerColor : successColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Compliance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: (standard["compliance"] as int) / 100,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${standard["compliance"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cost Variance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${isOverPortion ? '+' : ''}\$${(standard["variance"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isOverPortion ? dangerColor : successColor,
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
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, size: 16, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${standard["instructions"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View History",
                  size: bs.sm,
                  onPressed: () {
                    // View portion history
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit standard
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(Map<String, dynamic> standard) {
    return Container(
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
          Text(
            "${standard["itemName"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Text(
            "Recent Measurements:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),

          ...(standard["portions"] as List).take(3).map((portion) => Container(
            padding: EdgeInsets.symmetric(vertical: spXs),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${DateTime.parse("${portion["date"]}").dMMMy}",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${portion["weight"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$${(portion["cost"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${portion["staff"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          )),

          QButton(
            label: "Add Measurement",
            size: bs.sm,
            onPressed: () {
              // Add new measurement
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStaffPerformanceCard(Map<String, dynamic> staff) {
    Color statusColor = _getStatusColor("${staff["status"]}");

    return Container(
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${staff["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${staff["position"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${staff["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Compliance Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${staff["compliance"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
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
                      "Avg Variance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(staff["avgVariance"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
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
                      "Items Tracked",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${staff["itemsTracked"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (staff["status"] == "Needs Training")
            QButton(
              label: "Schedule Training",
              size: bs.sm,
              onPressed: () {
                // Schedule training
              },
            )
          else
            QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {
                // View staff details
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffMetricCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingRecommendation(Map<String, dynamic> staff) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Icon(Icons.school, color: warningColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${staff["name"]}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Compliance: ${staff["compliance"]}% - Focus on portion accuracy",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Schedule",
            size: bs.sm,
            onPressed: () {
              // Schedule training
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceTrendItem(Map<String, dynamic> standard) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${standard["itemName"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              widthFactor: (standard["compliance"] as int) / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: _getStatusColor("${standard["status"]}"),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${standard["compliance"]}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getStatusColor("${standard["status"]}"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostImpactItem(Map<String, dynamic> standard) {
    bool isOverCost = (standard["variance"] as double) > 0;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Icon(
            isOverCost ? Icons.trending_up : Icons.trending_down,
            color: isOverCost ? dangerColor : successColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${standard["itemName"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "${isOverCost ? '+' : ''}\$${(standard["variance"] as double).currency}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isOverCost ? dangerColor : successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementOpportunity(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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
    );
  }
}
