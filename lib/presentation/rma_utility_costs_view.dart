import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaUtilityCostsView extends StatefulWidget {
  const RmaUtilityCostsView({super.key});

  @override
  State<RmaUtilityCostsView> createState() => _RmaUtilityCostsViewState();
}

class _RmaUtilityCostsViewState extends State<RmaUtilityCostsView> {
  String selectedPeriod = "monthly";
  String selectedUtility = "all";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];
  
  List<Map<String, dynamic>> utilityTypes = [
    {"label": "All Utilities", "value": "all"},
    {"label": "Electricity", "value": "electricity"},
    {"label": "Gas", "value": "gas"},
    {"label": "Water", "value": "water"},
    {"label": "Internet", "value": "internet"},
    {"label": "Trash", "value": "trash"},
  ];
  
  Map<String, dynamic> utilitySummary = {
    "total_monthly": 285.50,
    "average_sqft_cost": 1.42,
    "seasonal_variation": 18.5,
    "efficiency_rating": "B+",
  };
  
  List<Map<String, dynamic>> monthlyUtilities = [
    {
      "type": "Electricity",
      "provider": "Metro Electric",
      "current_bill": 125.50,
      "usage": "850 kWh",
      "rate": "0.147 per kWh",
      "icon": Icons.electrical_services,
      "color": "warning",
      "due_date": "July 15, 2024",
    },
    {
      "type": "Natural Gas",
      "provider": "City Gas Company",
      "current_bill": 45.25,
      "usage": "32 therms",
      "rate": "1.41 per therm",
      "icon": Icons.local_fire_department,
      "color": "info",
      "due_date": "July 20, 2024",
    },
    {
      "type": "Water & Sewer",
      "provider": "Municipal Water",
      "current_bill": 68.75,
      "usage": "4,200 gallons",
      "rate": "0.016 per gallon",
      "icon": Icons.water_drop,
      "color": "primary",
      "due_date": "July 25, 2024",
    },
    {
      "type": "Internet",
      "provider": "FastNet Communications",
      "current_bill": 79.99,
      "usage": "Unlimited",
      "rate": "Fixed rate",
      "icon": Icons.wifi,
      "color": "secondary",
      "due_date": "July 10, 2024",
    },
    {
      "type": "Trash & Recycling",
      "provider": "Green Waste Management",
      "current_bill": 32.00,
      "usage": "Weekly pickup",
      "rate": "Fixed rate",
      "icon": Icons.delete,
      "color": "success",
      "due_date": "July 30, 2024",
    },
  ];
  
  List<Map<String, dynamic>> historicalData = [
    {"month": "June 2024", "electricity": 118.25, "gas": 38.50, "water": 71.20, "internet": 79.99, "trash": 32.00},
    {"month": "May 2024", "electricity": 142.75, "gas": 42.25, "water": 64.85, "internet": 79.99, "trash": 32.00},
    {"month": "April 2024", "electricity": 165.50, "gas": 48.75, "water": 59.40, "internet": 79.99, "trash": 32.00},
    {"month": "March 2024", "electricity": 189.25, "gas": 65.50, "water": 62.30, "internet": 79.99, "trash": 32.00},
    {"month": "February 2024", "electricity": 210.75, "gas": 85.25, "water": 58.45, "internet": 79.99, "trash": 32.00},
    {"month": "January 2024", "electricity": 195.50, "gas": 78.75, "water": 61.20, "internet": 79.99, "trash": 32.00},
  ];
  
  List<Map<String, dynamic>> energySavingTips = [
    {
      "category": "Heating & Cooling",
      "tip": "Set thermostat to 68°F in winter, 78°F in summer",
      "potential_savings": "\$25-40/month",
      "icon": Icons.thermostat,
    },
    {
      "category": "Water Heating",
      "tip": "Lower water heater temperature to 120°F",
      "potential_savings": "\$15-20/month",
      "icon": Icons.hot_tub,
    },
    {
      "category": "Lighting",
      "tip": "Replace incandescent bulbs with LED",
      "potential_savings": "\$8-12/month",
      "icon": Icons.lightbulb,
    },
    {
      "category": "Appliances",
      "tip": "Unplug devices when not in use",
      "potential_savings": "\$5-10/month",
      "icon": Icons.power,
    },
    {
      "category": "Insulation",
      "tip": "Seal air leaks around windows and doors",
      "potential_savings": "\$20-35/month",
      "icon": Icons.window,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utility Costs"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to detailed analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUtilitySummary(),
            _buildFilters(),
            _buildCurrentBills(),
            _buildHistoricalChart(),
            _buildSeasonalAnalysis(),
            _buildEnergySavingTips(),
            _buildProviderComparison(),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilitySummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Utility Costs",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${(utilitySummary["total_monthly"] as double).currency}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "\$${(utilitySummary["average_sqft_cost"] as double).toStringAsFixed(2)} per sq ft",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(Icons.energy_savings_leaf, color: Colors.white, size: 24),
                    SizedBox(height: spXs),
                    Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "${utilitySummary["efficiency_rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
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
                  label: "Utility Type",
                  items: utilityTypes,
                  value: selectedUtility,
                  onChanged: (value, label) {
                    selectedUtility = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBills() {
    List<Map<String, dynamic>> filteredUtilities = selectedUtility == "all" 
        ? monthlyUtilities 
        : monthlyUtilities.where((utility) => 
            utility["type"].toLowerCase().contains(selectedUtility)).toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Bills",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...filteredUtilities.map((utility) => _buildUtilityCard(utility)),
        ],
      ),
    );
  }

  Widget _buildUtilityCard(Map<String, dynamic> utility) {
    Color cardColor = _getUtilityColor(utility["color"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: cardColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: cardColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: cardColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              utility["icon"] as IconData,
              color: cardColor,
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
                        "${utility["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "\$${(utility["current_bill"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: cardColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${utility["provider"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Usage: ${utility["usage"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Rate: ${utility["rate"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Due: ${utility["due_date"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: cardColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoricalChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "6-Month History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...historicalData.map((data) => _buildHistoricalCard(data)),
        ],
      ),
    );
  }

  Widget _buildHistoricalCard(Map<String, dynamic> data) {
    double totalCost = (data["electricity"] as double) + 
                      (data["gas"] as double) + 
                      (data["water"] as double) + 
                      (data["internet"] as double) + 
                      (data["trash"] as double);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${data["month"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${totalCost.currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 80,
            children: [
              _buildCostDetail("Electric", data["electricity"], warningColor),
              _buildCostDetail("Gas", data["gas"], infoColor),
              _buildCostDetail("Water", data["water"], primaryColor),
              _buildCostDetail("Internet", data["internet"], secondaryColor),
              _buildCostDetail("Trash", data["trash"], successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostDetail(String label, double amount, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Seasonal Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Winter Peak Usage",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "+${(utilitySummary["seasonal_variation"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Heating costs typically increase utility bills by 15-25% during winter months (December-February). Consider programmable thermostat and improved insulation.",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_down, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Summer Efficiency",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "-12%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Lower heating costs offset by increased cooling and water usage. Overall utility costs are typically 10-15% lower than winter peaks.",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergySavingTips() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Energy Saving Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...energySavingTips.map((tip) => _buildTipCard(tip)),
        ],
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(tip["icon"] as IconData, color: successColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tip["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Text(
                  "${tip["tip"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${tip["potential_savings"]}",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Provider Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Service Providers",
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
                  "Most utilities are provided by regulated municipal or regional companies. Internet and trash services may have competitive alternatives available in your area.",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Compare Providers",
              size: bs.md,
              onPressed: () {
                // Navigate to provider comparison
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getUtilityColor(String colorName) {
    switch (colorName) {
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "primary":
        return primaryColor;
      case "secondary":
        return secondaryColor;
      case "success":
        return successColor;
      default:
        return primaryColor;
    }
  }
}
