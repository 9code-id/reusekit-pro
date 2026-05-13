import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCostAnalysisView extends StatefulWidget {
  const LtaCostAnalysisView({super.key});

  @override
  State<LtaCostAnalysisView> createState() => _LtaCostAnalysisViewState();
}

class _LtaCostAnalysisViewState extends State<LtaCostAnalysisView> {
  bool loading = true;
  String selectedPeriod = "This Month";
  String selectedCostType = "All Costs";
  String selectedDepartment = "All Departments";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> costTypeOptions = [
    {"label": "All Costs", "value": "All Costs"},
    {"label": "Fuel Costs", "value": "Fuel Costs"},
    {"label": "Vehicle Maintenance", "value": "Vehicle Maintenance"},
    {"label": "Labor Costs", "value": "Labor Costs"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Equipment", "value": "Equipment"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Fleet Management", "value": "Fleet Management"},
    {"label": "Human Resources", "value": "Human Resources"},
    {"label": "Administration", "value": "Administration"},
  ];

  List<Map<String, dynamic>> costOverview = [
    {
      "title": "Total Costs",
      "value": 1850000,
      "unit": "\$",
      "change": -5.2,
      "trend": "down",
      "icon": Icons.money_off,
      "color": dangerColor,
    },
    {
      "title": "Cost per Delivery",
      "value": 140.15,
      "unit": "\$",
      "change": -2.8,
      "trend": "down",
      "icon": Icons.local_shipping,
      "color": successColor,
    },
    {
      "title": "Monthly Savings",
      "value": 95000,
      "unit": "\$",
      "change": 18.5,
      "trend": "up",
      "icon": Icons.savings,
      "color": primaryColor,
    },
    {
      "title": "Cost Efficiency",
      "value": 76.8,
      "unit": "%",
      "change": 3.2,
      "trend": "up",
      "icon": Icons.speed,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Fuel Costs",
      "amount": 740000,
      "percentage": 40.0,
      "budget": 800000,
      "variance": -60000,
      "change": -7.5,
      "color": dangerColor,
      "icon": Icons.local_gas_station,
    },
    {
      "category": "Labor Costs",
      "amount": 555000,
      "percentage": 30.0,
      "budget": 580000,
      "variance": -25000,
      "change": -4.3,
      "color": warningColor,
      "icon": Icons.people,
    },
    {
      "category": "Vehicle Maintenance",
      "amount": 277500,
      "percentage": 15.0,
      "budget": 300000,
      "variance": -22500,
      "change": -7.5,
      "color": primaryColor,
      "icon": Icons.build,
    },
    {
      "category": "Insurance",
      "amount": 185000,
      "percentage": 10.0,
      "budget": 200000,
      "variance": -15000,
      "change": -7.5,
      "color": infoColor,
      "icon": Icons.security,
    },
    {
      "category": "Equipment",
      "amount": 92500,
      "percentage": 5.0,
      "budget": 100000,
      "variance": -7500,
      "change": -7.5,
      "color": successColor,
      "icon": Icons.precision_manufacturing,
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "costs": 1950000, "budget": 2000000, "variance": -50000},
    {"month": "Feb", "costs": 1920000, "budget": 2000000, "variance": -80000},
    {"month": "Mar", "costs": 1890000, "budget": 1980000, "variance": -90000},
    {"month": "Apr", "costs": 1870000, "budget": 1980000, "variance": -110000},
    {"month": "May", "costs": 1860000, "budget": 1950000, "variance": -90000},
    {"month": "Jun", "costs": 1850000, "budget": 1950000, "variance": -100000},
  ];

  List<Map<String, dynamic>> costCenters = [
    {
      "center": "Fleet Operations",
      "centerId": "FC001",
      "totalCost": 925000,
      "budgetAllocation": 1000000,
      "utilization": 92.5,
      "variance": -75000,
      "efficiency": 88.2,
      "keyDrivers": ["Fuel", "Maintenance", "Driver Wages"],
    },
    {
      "center": "Warehouse Operations",
      "centerId": "WC002",
      "totalCost": 462500,
      "budgetAllocation": 500000,
      "utilization": 92.5,
      "variance": -37500,
      "efficiency": 91.3,
      "keyDrivers": ["Labor", "Equipment", "Utilities"],
    },
    {
      "center": "Administration",
      "centerId": "AC003",
      "totalCost": 277500,
      "budgetAllocation": 300000,
      "utilization": 92.5,
      "variance": -22500,
      "efficiency": 85.7,
      "keyDrivers": ["Salaries", "Technology", "Office"],
    },
    {
      "center": "Customer Service",
      "centerId": "CS004",
      "totalCost": 185000,
      "budgetAllocation": 200000,
      "utilization": 92.5,
      "variance": -15000,
      "efficiency": 89.4,
      "keyDrivers": ["Staff", "Technology", "Training"],
    },
  ];

  List<Map<String, dynamic>> costOptimizations = [
    {
      "initiative": "Route Optimization Software",
      "category": "Technology",
      "investment": 50000,
      "expectedSavings": 180000,
      "roi": 260.0,
      "timeline": "6 months",
      "status": "active",
      "progress": 75,
    },
    {
      "initiative": "Fuel Efficiency Training",
      "category": "Training",
      "investment": 25000,
      "expectedSavings": 120000,
      "roi": 380.0,
      "timeline": "3 months",
      "status": "active",
      "progress": 90,
    },
    {
      "initiative": "Preventive Maintenance Program",
      "category": "Maintenance",
      "investment": 75000,
      "expectedSavings": 200000,
      "roi": 166.7,
      "timeline": "12 months",
      "status": "planning",
      "progress": 25,
    },
    {
      "initiative": "Fleet Electrification",
      "category": "Vehicles",
      "investment": 500000,
      "expectedSavings": 850000,
      "roi": 70.0,
      "timeline": "24 months",
      "status": "proposal",
      "progress": 10,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "planning":
        return warningColor;
      case "proposal":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOverviewCard(Map<String, dynamic> metric) {
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
                  color: (metric["color"] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                (metric["trend"] as String) == "up" 
                    ? Icons.trending_up 
                    : Icons.trending_down,
                color: (metric["trend"] as String) == "up" 
                    ? successColor 
                    : dangerColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (metric["unit"] == "\$")
                Text(
                  "\$${((metric["value"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${(metric["value"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: (metric["trend"] as String) == "up" 
                      ? successColor.withValues(alpha: 0.1)
                      : dangerColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${(metric["trend"] as String) == "up" ? '+' : ''}${(metric["change"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 11,
                    color: (metric["trend"] as String) == "up" 
                        ? successColor 
                        : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdownCard(Map<String, dynamic> cost) {
    double variancePercentage = ((cost["variance"] as num) / (cost["budget"] as num)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                  color: (cost["color"] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  cost["icon"] as IconData,
                  color: cost["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${cost["category"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(cost["percentage"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.bold,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Actual Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((cost["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH5,
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
                      "Budget",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((cost["budget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
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
                    "Variance",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "\$${((cost["variance"] as num).abs().toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostCenterCard(Map<String, dynamic> center) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${center["center"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "ID: ${center["centerId"]}",
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
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(center["efficiency"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.bold,
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
                      "\$${((center["totalCost"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
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
                      "\$${((center["budgetAllocation"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Budget",
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
                      "\$${((center["variance"] as num).abs().toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Savings",
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
          SizedBox(height: spSm),
          
          Text(
            "Key Cost Drivers:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            runSpacing: 4,
            children: (center["keyDrivers"] as List).map((driver) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$driver",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationCard(Map<String, dynamic> optimization) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Expanded(
                child: Text(
                  "${optimization["initiative"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor("${optimization["status"]}").withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${optimization["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor("${optimization["status"]}"),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Category: ${optimization["category"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((optimization["investment"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Investment",
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
                      "\$${((optimization["expectedSavings"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Savings",
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
                      "${(optimization["roi"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "ROI",
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
                      "${optimization["timeline"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Timeline",
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
          SizedBox(height: spSm),
          
          Row(
            children: [
              Text(
                "Progress: ${optimization["progress"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (optimization["progress"] as num) / 100,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              _getStatusColor("${optimization["status"]}"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Cost Analysis"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export report
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Cost Type",
                    items: costTypeOptions,
                    value: selectedCostType,
                    onChanged: (value, label) {
                      selectedCostType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Cost Overview
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
              children: costOverview.map((metric) {
                return _buildOverviewCard(metric);
              }).toList(),
            ),

            // Cost Breakdown
            Text(
              "Cost Breakdown by Category",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: costBreakdown.map((cost) {
                return _buildCostBreakdownCard(cost);
              }).toList(),
            ),

            // Cost Centers
            Text(
              "Cost Centers Analysis",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: costCenters.map((center) {
                return _buildCostCenterCard(center);
              }).toList(),
            ),

            // Cost Optimization Initiatives
            Text(
              "Cost Optimization Initiatives",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: costOptimizations.map((optimization) {
                return _buildOptimizationCard(optimization);
              }).toList(),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Cost Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      // Generate detailed cost report
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Budget Planning",
                    icon: Icons.calculate,
                    size: bs.md,
                    onPressed: () {
                      // Navigate to budget planning
                    },
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
