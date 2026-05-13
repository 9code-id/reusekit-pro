import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsWasteTrackingView extends StatefulWidget {
  const RfsWasteTrackingView({super.key});

  @override
  State<RfsWasteTrackingView> createState() => _RfsWasteTrackingViewState();
}

class _RfsWasteTrackingViewState extends State<RfsWasteTrackingView> {
  String searchQuery = "";
  String selectedPeriod = "today";
  String selectedCategory = "all";
  String selectedReason = "all";

  List<Map<String, dynamic>> wasteRecords = [
    {
      "id": "W001",
      "item": "Grilled Chicken Breast",
      "category": "Protein",
      "quantity": 2.5,
      "unit": "kg",
      "reason": "Expired",
      "cost": 45.00,
      "timestamp": "2024-01-15 14:30",
      "location": "Kitchen Station 1",
      "reportedBy": "Chef Sarah",
      "image": "https://picsum.photos/300/200?random=101&keyword=chicken",
      "severity": "high"
    },
    {
      "id": "W002",
      "item": "Caesar Salad Mix",
      "category": "Vegetable",
      "quantity": 1.2,
      "unit": "kg",
      "reason": "Overproduction",
      "cost": 18.50,
      "timestamp": "2024-01-15 13:45",
      "location": "Prep Station",
      "reportedBy": "Prep Cook Mike",
      "image": "https://picsum.photos/300/200?random=102&keyword=salad",
      "severity": "medium"
    },
    {
      "id": "W003",
      "item": "Salmon Fillet",
      "category": "Seafood",
      "quantity": 0.8,
      "unit": "kg",
      "reason": "Quality Issue",
      "cost": 32.00,
      "timestamp": "2024-01-15 12:20",
      "location": "Cold Storage",
      "reportedBy": "Manager John",
      "image": "https://picsum.photos/300/200?random=103&keyword=salmon",
      "severity": "high"
    },
    {
      "id": "W004",
      "item": "Bread Rolls",
      "category": "Bakery",
      "quantity": 15,
      "unit": "pieces",
      "reason": "Day Old",
      "cost": 12.75,
      "timestamp": "2024-01-15 11:15",
      "location": "Bakery Section",
      "reportedBy": "Baker Lisa",
      "image": "https://picsum.photos/300/200?random=104&keyword=bread",
      "severity": "low"
    },
    {
      "id": "W005",
      "item": "Tomato Soup",
      "category": "Prepared Food",
      "quantity": 3.0,
      "unit": "liters",
      "reason": "Leftover",
      "cost": 22.40,
      "timestamp": "2024-01-15 10:30",
      "location": "Soup Station",
      "reportedBy": "Cook Emma",
      "image": "https://picsum.photos/300/200?random=105&keyword=soup",
      "severity": "medium"
    },
    {
      "id": "W006",
      "item": "Mixed Vegetables",
      "category": "Vegetable",
      "quantity": 2.1,
      "unit": "kg",
      "reason": "Spoiled",
      "cost": 15.80,
      "timestamp": "2024-01-15 09:45",
      "location": "Vegetable Prep",
      "reportedBy": "Prep Cook Anna",
      "image": "https://picsum.photos/300/200?random=106&keyword=vegetables",
      "severity": "medium"
    },
    {
      "id": "W007",
      "item": "Chocolate Cake",
      "category": "Dessert",
      "quantity": 1,
      "unit": "whole",
      "reason": "Damaged",
      "cost": 28.00,
      "timestamp": "2024-01-15 16:20",
      "location": "Dessert Station",
      "reportedBy": "Pastry Chef Tom",
      "image": "https://picsum.photos/300/200?random=107&keyword=cake",
      "severity": "medium"
    },
    {
      "id": "W008",
      "item": "French Fries",
      "category": "Side Dish",
      "quantity": 1.5,
      "unit": "kg",
      "reason": "Overcooked",
      "cost": 8.50,
      "timestamp": "2024-01-15 18:10",
      "location": "Fryer Station",
      "reportedBy": "Cook David",
      "image": "https://picsum.photos/300/200?random=108&keyword=fries",
      "severity": "low"
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Protein", "value": "Protein"},
    {"label": "Vegetable", "value": "Vegetable"},
    {"label": "Seafood", "value": "Seafood"},
    {"label": "Bakery", "value": "Bakery"},
    {"label": "Prepared Food", "value": "Prepared Food"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Side Dish", "value": "Side Dish"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "All Reasons", "value": "all"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Overproduction", "value": "Overproduction"},
    {"label": "Quality Issue", "value": "Quality Issue"},
    {"label": "Day Old", "value": "Day Old"},
    {"label": "Leftover", "value": "Leftover"},
    {"label": "Spoiled", "value": "Spoiled"},
    {"label": "Damaged", "value": "Damaged"},
    {"label": "Overcooked", "value": "Overcooked"},
  ];

  List<Map<String, dynamic>> get filteredWasteRecords {
    return wasteRecords.where((record) {
      bool matchesSearch = record["item"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          record["category"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          record["reason"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || record["category"] == selectedCategory;
      bool matchesReason = selectedReason == "all" || record["reason"] == selectedReason;
      
      return matchesSearch && matchesCategory && matchesReason;
    }).toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getSeverityLabel(String severity) {
    switch (severity) {
      case "high":
        return "High Impact";
      case "medium":
        return "Medium Impact";
      case "low":
        return "Low Impact";
      default:
        return "Unknown";
    }
  }

  double get totalWasteCost {
    return filteredWasteRecords.fold(0.0, (sum, record) => sum + (record["cost"] as double));
  }

  int get totalWasteItems {
    return filteredWasteRecords.length;
  }

  double get averageWasteCost {
    if (filteredWasteRecords.isEmpty) return 0.0;
    return totalWasteCost / filteredWasteRecords.length;
  }

  Map<String, int> get wasteByReason {
    Map<String, int> reasonCounts = {};
    for (var record in filteredWasteRecords) {
      String reason = record["reason"];
      reasonCounts[reason] = (reasonCounts[reason] ?? 0) + 1;
    }
    return reasonCounts;
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
              // Navigate to analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                  QTextField(
                    label: "Search waste records...",
                    value: searchQuery,
                    hint: "Search by item, category, or reason",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
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
                    ],
                  ),
                  QDropdownField(
                    label: "Waste Reason",
                    items: reasonOptions,
                    value: selectedReason,
                    onChanged: (value, label) {
                      selectedReason = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Dashboard
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.assessment, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Waste Summary",
                        style: TextStyle(
                          fontSize: fsH6,
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${totalWasteCost.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Total Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: warningColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "$totalWasteItems",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Items Wasted",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${averageWasteCost.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Avg Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
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

            // Waste by Reason Chart
            if (wasteByReason.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(Icons.pie_chart, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Waste by Reason",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...wasteByReason.entries.map((entry) {
                      double percentage = (entry.value / totalWasteItems) * 100;
                      return Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: disabledColor,
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
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${entry.value}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Waste Records List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.delete_outline, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Waste Records (${filteredWasteRecords.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (filteredWasteRecords.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.recycling,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No waste records found",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredWasteRecords.map((record) {
                      Color severityColor = _getSeverityColor(record["severity"]);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
                                spacing: spSm,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${record["image"]}",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${record["item"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: severityColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                _getSeverityLabel("${record["severity"]}"),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: severityColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${record["category"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: warningColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${record["reason"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: warningColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.scale, size: 14, color: disabledBoldColor),
                                            SizedBox(width: 4),
                                            Text(
                                              "${record["quantity"]} ${record["unit"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Icon(Icons.attach_money, size: 14, color: dangerColor),
                                            Text(
                                              "\$${(record["cost"] as double).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                            SizedBox(width: 4),
                                            Text(
                                              "${record["location"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.person, size: 14, color: disabledBoldColor),
                                            SizedBox(width: 4),
                                            Text(
                                              "Reported by ${record["reportedBy"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(radiusSm),
                                  bottomRight: Radius.circular(radiusSm),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${record["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "ID: ${record["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add waste record
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
