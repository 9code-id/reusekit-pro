import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaWasteTrackingView extends StatefulWidget {
  const RmaWasteTrackingView({super.key});

  @override
  State<RmaWasteTrackingView> createState() => _RmaWasteTrackingViewState();
}

class _RmaWasteTrackingViewState extends State<RmaWasteTrackingView> {
  String selectedPeriod = "today";
  String selectedCategory = "all";
  String selectedReason = "all";

  List<Map<String, dynamic>> wasteEntries = [
    {
      "id": "WST-001",
      "itemName": "Salmon Fillet",
      "category": "seafood",
      "quantity": 2.5,
      "unit": "kg",
      "reason": "expired",
      "cost": 112.50,
      "timestamp": "2024-03-15 14:30",
      "staff": "John Chef",
      "location": "Walk-in Cooler",
      "notes": "Past expiry date by 2 days",
      "prevention": "Check rotation schedule",
    },
    {
      "id": "WST-002",
      "itemName": "Bread Rolls",
      "category": "bakery",
      "quantity": 24,
      "unit": "pieces",
      "reason": "spoiled",
      "cost": 18.00,
      "timestamp": "2024-03-15 16:45",
      "staff": "Sarah Baker",
      "location": "Bakery Section",
      "notes": "Moldy due to humidity",
      "prevention": "Improve storage conditions",
    },
    {
      "id": "WST-003",
      "itemName": "Mixed Greens",
      "category": "vegetables",
      "quantity": 3.0,
      "unit": "kg",
      "reason": "overproduction",
      "cost": 24.00,
      "timestamp": "2024-03-15 20:00",
      "staff": "Mike Kitchen",
      "location": "Prep Area",
      "notes": "Prepared too much for slow evening",
      "prevention": "Better demand forecasting",
    },
    {
      "id": "WST-004",
      "itemName": "Chicken Breast",
      "category": "meat",
      "quantity": 1.8,
      "unit": "kg",
      "reason": "quality_issue",
      "cost": 33.30,
      "timestamp": "2024-03-14 12:15",
      "staff": "Lisa Prep",
      "location": "Meat Prep",
      "notes": "Discoloration noticed during prep",
      "prevention": "Better supplier quality control",
    },
    {
      "id": "WST-005",
      "itemName": "Cream Sauce",
      "category": "prepared",
      "quantity": 2.0,
      "unit": "liters",
      "reason": "accident",
      "cost": 45.00,
      "timestamp": "2024-03-14 18:30",
      "staff": "David Cook",
      "location": "Hot Line",
      "notes": "Spilled during busy service",
      "prevention": "Staff training on safe handling",
    },
    {
      "id": "WST-006",
      "itemName": "Wine",
      "category": "beverages",
      "quantity": 3,
      "unit": "bottles",
      "reason": "damaged",
      "cost": 75.00,
      "timestamp": "2024-03-13 10:00",
      "staff": "Emma Server",
      "location": "Wine Storage",
      "notes": "Broken during inventory",
      "prevention": "Careful handling protocols",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Seafood", "value": "seafood"},
    {"label": "Meat", "value": "meat"},
    {"label": "Vegetables", "value": "vegetables"},
    {"label": "Bakery", "value": "bakery"},
    {"label": "Beverages", "value": "beverages"},
    {"label": "Prepared Foods", "value": "prepared"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "All Reasons", "value": "all"},
    {"label": "Expired", "value": "expired"},
    {"label": "Spoiled", "value": "spoiled"},
    {"label": "Overproduction", "value": "overproduction"},
    {"label": "Quality Issue", "value": "quality_issue"},
    {"label": "Accident", "value": "accident"},
    {"label": "Damaged", "value": "damaged"},
  ];

  List<Map<String, dynamic>> get filteredWaste {
    return wasteEntries.where((entry) {
      final matchesCategory = selectedCategory == "all" || entry["category"] == selectedCategory;
      final matchesReason = selectedReason == "all" || entry["reason"] == selectedReason;
      
      return matchesCategory && matchesReason;
    }).toList();
  }

  Widget _buildHeader() {
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
              Icon(
                Icons.delete_outline,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Waste Tracking",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Waste",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('AddWasteEntry')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
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
                child: QDropdownField(
                  label: "Reason",
                  items: reasonOptions,
                  value: selectedReason,
                  onChanged: (value, label) {
                    selectedReason = value;
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

  Widget _buildWasteSummary() {
    final totalWaste = filteredWaste.length;
    final totalCost = filteredWaste.fold(0.0, (sum, entry) => sum + (entry["cost"] as double));
    final avgWastePerDay = totalWaste / 7; // Assuming weekly data
    final mostCommonReason = _getMostCommonReason();

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
          Text(
            "Waste Summary",
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
              _buildSummaryCard(
                "Total Entries",
                "$totalWaste",
                Icons.format_list_numbered,
                primaryColor,
              ),
              _buildSummaryCard(
                "Total Cost",
                "\$${totalCost.currency}",
                Icons.attach_money,
                dangerColor,
              ),
              _buildSummaryCard(
                "Daily Average",
                "${avgWastePerDay.toStringAsFixed(1)}",
                Icons.trending_up,
                warningColor,
              ),
              _buildSummaryCard(
                "Top Reason",
                mostCommonReason,
                Icons.error_outline,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteAnalytics() {
    final reasonBreakdown = _getReasonBreakdown();
    final categoryBreakdown = _getCategoryBreakdown();

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
          Text(
            "Waste Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
                      "By Reason",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...reasonBreakdown.entries.map((entry) => _buildAnalyticsBar(
                      entry.key,
                      entry.value["count"],
                      entry.value["percentage"],
                      _getReasonColor(entry.key),
                    )),
                  ],
                ),
              ),
              SizedBox(width: spLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By Category",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...categoryBreakdown.entries.map((entry) => _buildAnalyticsBar(
                      entry.key,
                      entry.value["count"],
                      entry.value["percentage"],
                      _getCategoryColor(entry.key),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsBar(String label, int count, double percentage, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label.replaceAll('_', ' ').toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "$count (${percentage.toStringAsFixed(1)}%)",
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteEntries() {
    final sortedEntries = List<Map<String, dynamic>>.from(filteredWaste);
    sortedEntries.sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));

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
          Text(
            "Recent Waste Entries (${sortedEntries.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (sortedEntries.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.eco,
                    size: 64,
                    color: successColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No waste entries found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Great job reducing waste!",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...sortedEntries.map((entry) => _buildWasteCard(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildWasteCard(Map<String, dynamic> entry) {
    final reasonColor = _getReasonColor(entry["reason"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: reasonColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: reasonColor,
          ),
        ),
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
                      "${entry["itemName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: reasonColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${entry["reason"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: reasonColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${entry["category"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(entry["cost"] as double).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "${entry["quantity"]} ${entry["unit"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Staff: ${entry["staff"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${entry["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${entry["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (entry["notes"] != null && entry["notes"].toString().isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.note,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${entry["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (entry["prevention"] != null && entry["prevention"].toString().isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Prevention: ${entry["prevention"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Entry",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EditWasteEntry')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Delete",
                size: bs.sm,
                onPressed: () {
                  //deleteEntry()
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMostCommonReason() {
    final reasonCounts = <String, int>{};
    for (final entry in filteredWaste) {
      final reason = entry["reason"] as String;
      reasonCounts[reason] = (reasonCounts[reason] ?? 0) + 1;
    }
    
    if (reasonCounts.isEmpty) return "None";
    
    final topReason = reasonCounts.entries.reduce((a, b) => a.value > b.value ? a : b);
    return topReason.key.replaceAll('_', ' ').toUpperCase();
  }

  Map<String, Map<String, dynamic>> _getReasonBreakdown() {
    final breakdown = <String, Map<String, dynamic>>{};
    final total = filteredWaste.length;
    
    for (final entry in filteredWaste) {
      final reason = entry["reason"] as String;
      breakdown[reason] = breakdown[reason] ?? {"count": 0, "percentage": 0.0};
      breakdown[reason]!["count"]++;
    }
    
    for (final key in breakdown.keys) {
      breakdown[key]!["percentage"] = (breakdown[key]!["count"] / total * 100);
    }
    
    return breakdown;
  }

  Map<String, Map<String, dynamic>> _getCategoryBreakdown() {
    final breakdown = <String, Map<String, dynamic>>{};
    final total = filteredWaste.length;
    
    for (final entry in filteredWaste) {
      final category = entry["category"] as String;
      breakdown[category] = breakdown[category] ?? {"count": 0, "percentage": 0.0};
      breakdown[category]!["count"]++;
    }
    
    for (final key in breakdown.keys) {
      breakdown[key]!["percentage"] = (breakdown[key]!["count"] / total * 100);
    }
    
    return breakdown;
  }

  Color _getReasonColor(String reason) {
    switch (reason) {
      case "expired":
        return dangerColor;
      case "spoiled":
        return Colors.orange;
      case "overproduction":
        return warningColor;
      case "quality_issue":
        return Colors.purple;
      case "accident":
        return infoColor;
      case "damaged":
        return Colors.brown;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "seafood":
        return Colors.blue;
      case "meat":
        return dangerColor;
      case "vegetables":
        return successColor;
      case "bakery":
        return Colors.orange;
      case "beverages":
        return Colors.purple;
      case "prepared":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waste Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('WasteAnalytics')
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              //exportWasteReport()
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildWasteSummary(),
            _buildWasteAnalytics(),
            _buildWasteEntries(),
          ],
        ),
      ),
    );
  }
}
