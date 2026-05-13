import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaUtilitiesView extends StatefulWidget {
  const ReaUtilitiesView({super.key});

  @override
  State<ReaUtilitiesView> createState() => _ReaUtilitiesViewState();
}

class _ReaUtilitiesViewState extends State<ReaUtilitiesView> {
  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "address": "123 Oak Street",
      "type": "Single Family",
      "sqft": 2400,
      "utilities": {
        "electricity": {"current": 180.50, "average": 165.00, "lastMonth": 155.20, "provider": "Metro Electric", "dueDate": "2024-12-15"},
        "gas": {"current": 85.30, "average": 92.00, "lastMonth": 98.50, "provider": "City Gas Co.", "dueDate": "2024-12-18"},
        "water": {"current": 65.80, "average": 70.00, "lastMonth": 72.30, "provider": "Municipal Water", "dueDate": "2024-12-20"},
        "internet": {"current": 79.99, "average": 79.99, "lastMonth": 79.99, "provider": "FastNet ISP", "dueDate": "2024-12-10"},
        "trash": {"current": 35.00, "average": 35.00, "lastMonth": 35.00, "provider": "Waste Management", "dueDate": "2024-12-25"},
        "sewer": {"current": 45.60, "average": 42.00, "lastMonth": 38.90, "provider": "City Sewer Dept", "dueDate": "2024-12-20"},
      }
    },
    {
      "id": 2,
      "address": "456 Pine Avenue", 
      "type": "Condo",
      "sqft": 1200,
      "utilities": {
        "electricity": {"current": 95.20, "average": 88.00, "lastMonth": 82.40, "provider": "Metro Electric", "dueDate": "2024-12-15"},
        "gas": {"current": 45.80, "average": 52.00, "lastMonth": 58.20, "provider": "City Gas Co.", "dueDate": "2024-12-18"},
        "water": {"current": 42.50, "average": 38.00, "lastMonth": 35.60, "provider": "Municipal Water", "dueDate": "2024-12-20"},
        "internet": {"current": 69.99, "average": 69.99, "lastMonth": 69.99, "provider": "Cable Plus", "dueDate": "2024-12-12"},
        "trash": {"current": 0.00, "average": 0.00, "lastMonth": 0.00, "provider": "Included in HOA", "dueDate": "N/A"},
        "sewer": {"current": 0.00, "average": 0.00, "lastMonth": 0.00, "provider": "Included in HOA", "dueDate": "N/A"},
      }
    },
  ];

  String selectedPropertyId = "1";
  String selectedPeriod = "Current Month";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "Current Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Average", "value": "Average"},
    {"label": "Year to Date", "value": "Year to Date"},
  ];

  Map<String, dynamic> getSelectedProperty() {
    return properties.firstWhere((p) => p["id"].toString() == selectedPropertyId);
  }

  List<Map<String, dynamic>> getPropertyOptions() {
    return properties.map((p) => {
      "label": "${p["address"]}",
      "value": p["id"].toString(),
    }).toList();
  }

  Map<String, dynamic> getUtilityData(String utilityType, Map<String, dynamic> property) {
    Map<String, dynamic> utilities = property["utilities"];
    return utilities[utilityType] ?? {};
  }

  double getTotalUtilityCost(Map<String, dynamic> property) {
    Map<String, dynamic> utilities = property["utilities"];
    double total = 0;
    
    utilities.forEach((key, value) {
      if (value is Map<String, dynamic> && value.containsKey("current")) {
        total += value["current"] as double;
      }
    });
    
    return total;
  }

  Color getUtilityColor(String utilityType) {
    switch (utilityType) {
      case "electricity":
        return warningColor;
      case "gas":
        return dangerColor;
      case "water":
        return infoColor;
      case "internet":
        return primaryColor;
      case "trash":
        return successColor;
      case "sewer":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getUtilityIcon(String utilityType) {
    switch (utilityType) {
      case "electricity":
        return Icons.electrical_services;
      case "gas":
        return Icons.local_fire_department;
      case "water":
        return Icons.water_drop;
      case "internet":
        return Icons.wifi;
      case "trash":
        return Icons.delete;
      case "sewer":
        return Icons.water;
      default:
        return Icons.home;
    }
  }

  String getUtilityTitle(String utilityType) {
    switch (utilityType) {
      case "electricity":
        return "Electricity";
      case "gas":
        return "Natural Gas";
      case "water":
        return "Water";
      case "internet":
        return "Internet";
      case "trash":
        return "Trash/Recycling";
      case "sewer":
        return "Sewer";
      default:
        return utilityType;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedProperty = getSelectedProperty();
    double totalCost = getTotalUtilityCost(selectedProperty);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Utilities"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add utility payment");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Property Selector
          Container(
            padding: EdgeInsets.all(spMd),
            child: QDropdownField(
              label: "Select Property",
              items: getPropertyOptions(),
              value: selectedPropertyId,
              onChanged: (value, label) {
                selectedPropertyId = value;
                setState(() {});
              },
            ),
          ),
          
          // Property Summary
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${selectedProperty["address"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${selectedProperty["type"]} • ${selectedProperty["sqft"]} sqft",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Row(
                  spacing: spMd,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${totalCost.currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Monthly",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${(totalCost / (selectedProperty["sqft"] as int)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Per sqft",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Period Selector
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: QDropdownField(
              label: "View Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Utilities List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              children: [
                // Electricity
                _buildUtilityCard("electricity", selectedProperty),
                
                // Gas
                _buildUtilityCard("gas", selectedProperty),
                
                // Water
                _buildUtilityCard("water", selectedProperty),
                
                // Internet
                _buildUtilityCard("internet", selectedProperty),
                
                // Trash
                _buildUtilityCard("trash", selectedProperty),
                
                // Sewer
                _buildUtilityCard("sewer", selectedProperty),
                
                // Summary Card
                Container(
                  margin: EdgeInsets.only(top: spMd, bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calculate,
                            color: primaryColor,
                            size: 28,
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Monthly Utility Summary",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Total utility costs for ${selectedProperty["address"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${totalCost.currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Export Report",
                              size: bs.sm,
                              onPressed: () {
                                ss("Utility report exported");
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.notifications,
                            size: bs.sm,
                            onPressed: () {
                              ss("Payment reminders set");
                            },
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              _showUtilityOptions();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilityCard(String utilityType, Map<String, dynamic> property) {
    Map<String, dynamic> utilityData = getUtilityData(utilityType, property);
    
    if (utilityData.isEmpty) return SizedBox.shrink();
    
    double currentCost = utilityData["current"] ?? 0.0;
    double lastMonth = utilityData["lastMonth"] ?? 0.0;
    double average = utilityData["average"] ?? 0.0;
    String provider = utilityData["provider"] ?? "";
    String dueDate = utilityData["dueDate"] ?? "";
    
    // Skip if cost is 0 (included in HOA)
    if (currentCost == 0 && provider.contains("HOA")) {
      return Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: disabledColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: disabledColor.withAlpha(50)),
        ),
        child: Row(
          children: [
            Icon(
              getUtilityIcon(utilityType),
              color: disabledBoldColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getUtilityTitle(utilityType),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    provider,
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
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Included",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    bool isIncreased = currentCost > lastMonth;
    double changeAmount = (currentCost - lastMonth).abs();
    double changePercentage = lastMonth > 0 ? (changeAmount / lastMonth) * 100 : 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: getUtilityColor(utilityType).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  getUtilityIcon(utilityType),
                  color: getUtilityColor(utilityType),
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getUtilityTitle(utilityType),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      provider,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${currentCost.currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: getUtilityColor(utilityType),
                    ),
                  ),
                  if (dueDate != "N/A")
                    Text(
                      "Due: ${DateTime.parse(dueDate).dMMMy}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ],
          ),
          
          // Statistics
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (isIncreased ? dangerColor : successColor).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isIncreased ? Icons.trending_up : Icons.trending_down,
                            color: isIncreased ? dangerColor : successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${isIncreased ? '+' : '-'}\$${changeAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isIncreased ? dangerColor : successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "vs Last Month",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${average.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Average",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${changePercentage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Change",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: dueDate != "N/A" ? "Pay Bill" : "View Details",
                  size: bs.sm,
                  onPressed: () {
                    if (dueDate != "N/A") {
                      ss("Redirecting to bill payment");
                    } else {
                      si("View utility details");
                    }
                  },
                ),
              ),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  _showUtilityHistory(utilityType, utilityData);
                },
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showUtilityOptions();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showUtilityHistory(String utilityType, Map<String, dynamic> utilityData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${getUtilityTitle(utilityType)} History"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHistoryItem("Current Month", utilityData["current"], true),
              _buildHistoryItem("Last Month", utilityData["lastMonth"], false),
              _buildHistoryItem("Average", utilityData["average"], false),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String period, double amount, bool isCurrent) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isCurrent ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              period,
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCurrent ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showUtilityOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Utility Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Utility Reading"),
              onTap: () {
                Navigator.pop(context);
                ss("Add utility reading");
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Set Payment Reminders"),
              onTap: () {
                Navigator.pop(context);
                ss("Payment reminders configured");
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Usage Analytics"),
              onTap: () {
                Navigator.pop(context);
                si("Usage analytics");
              },
            ),
            ListTile(
              leading: Icon(Icons.compare),
              title: Text("Compare Providers"),
              onTap: () {
                Navigator.pop(context);
                si("Compare utility providers");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
