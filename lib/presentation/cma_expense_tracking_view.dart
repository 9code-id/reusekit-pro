import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaExpenseTrackingView extends StatefulWidget {
  const CmaExpenseTrackingView({super.key});

  @override
  State<CmaExpenseTrackingView> createState() => _CmaExpenseTrackingViewState();
}

class _CmaExpenseTrackingViewState extends State<CmaExpenseTrackingView> {
  String selectedVehicle = "All Vehicles";
  String categoryFilter = "All Categories";
  String dateFilter = "This Month";

  List<Map<String, dynamic>> expenses = [
    {
      "id": 1,
      "date": "2025-06-19",
      "vehicle": "Honda Civic",
      "category": "Fuel",
      "description": "Gas Station Fill-up",
      "amount": 67.50,
      "location": "Shell Station",
      "odometer": 45678,
      "receipt": true,
      "recurring": false,
      "vendor": "Shell",
      "paymentMethod": "Credit Card",
    },
    {
      "id": 2,
      "date": "2025-06-18",
      "vehicle": "Honda Civic",
      "category": "Maintenance",
      "description": "Oil Change Service",
      "amount": 89.99,
      "location": "Quick Lube",
      "odometer": 45234,
      "receipt": true,
      "recurring": false,
      "vendor": "Quick Lube Express",
      "paymentMethod": "Debit Card",
    },
    {
      "id": 3,
      "date": "2025-06-15",
      "vehicle": "Toyota Camry",
      "category": "Insurance",
      "description": "Monthly Insurance Premium",
      "amount": 156.75,
      "location": "Online",
      "odometer": 67890,
      "receipt": true,
      "recurring": true,
      "vendor": "State Farm",
      "paymentMethod": "Auto Debit",
    },
    {
      "id": 4,
      "date": "2025-06-12",
      "vehicle": "Honda Civic",
      "category": "Parking",
      "description": "Downtown Parking",
      "amount": 15.00,
      "location": "Downtown Mall",
      "odometer": 44891,
      "receipt": false,
      "recurring": false,
      "vendor": "ParkPlus",
      "paymentMethod": "Cash",
    },
    {
      "id": 5,
      "date": "2025-06-10",
      "vehicle": "Toyota Camry",
      "category": "Repairs",
      "description": "Brake Pad Replacement",
      "amount": 245.80,
      "location": "Auto Shop",
      "odometer": 67456,
      "receipt": true,
      "recurring": false,
      "vendor": "City Auto Repair",
      "paymentMethod": "Credit Card",
    },
    {
      "id": 6,
      "date": "2025-06-08",
      "vehicle": "Honda Civic",
      "category": "Tolls",
      "description": "Highway Toll",
      "amount": 8.75,
      "location": "Highway 407",
      "odometer": 44523,
      "receipt": false,
      "recurring": false,
      "vendor": "407 ETR",
      "paymentMethod": "Transponder",
    },
  ];

  List<Map<String, dynamic>> get filteredExpenses {
    return expenses.where((expense) {
      bool vehicleMatch = selectedVehicle == "All Vehicles" || 
        expense["vehicle"] == selectedVehicle;
      bool categoryMatch = categoryFilter == "All Categories" || 
        expense["category"] == categoryFilter;
      return vehicleMatch && categoryMatch;
    }).toList();
  }

  double get totalExpenses {
    return filteredExpenses.fold(0.0, (sum, expense) => 
      sum + (expense["amount"] as double)
    );
  }

  Map<String, double> get expensesByCategory {
    Map<String, double> categoryTotals = {};
    for (var expense in filteredExpenses) {
      String category = expense["category"];
      double amount = expense["amount"] as double;
      categoryTotals[category] = (categoryTotals[category] ?? 0.0) + amount;
    }
    return categoryTotals;
  }

  double get averageExpensePerTrip {
    if (filteredExpenses.isEmpty) return 0.0;
    return totalExpenses / filteredExpenses.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add expense
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export expenses
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
            // Filters Section
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Expenses",
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
                          label: "Vehicle",
                          items: [
                            {"label": "All Vehicles", "value": "All Vehicles"},
                            {"label": "Honda Civic", "value": "Honda Civic"},
                            {"label": "Toyota Camry", "value": "Toyota Camry"},
                          ],
                          value: selectedVehicle,
                          onChanged: (value, label) {
                            selectedVehicle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": "All Categories"},
                            {"label": "Fuel", "value": "Fuel"},
                            {"label": "Maintenance", "value": "Maintenance"},
                            {"label": "Insurance", "value": "Insurance"},
                            {"label": "Repairs", "value": "Repairs"},
                            {"label": "Parking", "value": "Parking"},
                            {"label": "Tolls", "value": "Tolls"},
                          ],
                          value: categoryFilter,
                          onChanged: (value, label) {
                            categoryFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Expenses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalExpenses.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Avg Per Entry",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${averageExpensePerTrip.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.receipt,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Entries",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${filteredExpenses.length} entries",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Category Breakdown
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
                      Icon(Icons.pie_chart, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Expenses by Category",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...expensesByCategory.entries.map((entry) {
                    double percentage = (entry.value / totalExpenses) * 100;
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(entry.key),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${entry.value.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getCategoryColor(entry.key),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor: disabledColor.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getCategoryColor(entry.key),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Expenses List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Expenses",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredExpenses.length} entries",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredExpenses.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final expense = filteredExpenses[index];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            // Category Icon
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(expense["category"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getCategoryIcon(expense["category"]),
                                size: 20,
                                color: _getCategoryColor(expense["category"]),
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Expense Details
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${expense["description"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (expense["recurring"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.refresh,
                                          size: 14,
                                          color: infoColor,
                                        ),
                                      ],
                                      if (expense["receipt"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.receipt,
                                          size: 14,
                                          color: successColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${expense["vehicle"]} • ${expense["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${expense["location"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.payment,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${expense["paymentMethod"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${expense["date"]} • ${(expense["odometer"] as int).toString().replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},'
                                    )} km",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Amount
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(expense["amount"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                                Text(
                                  "${expense["vendor"]}",
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
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add expense
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Fuel":
        return dangerColor;
      case "Maintenance":
        return infoColor;
      case "Insurance":
        return primaryColor;
      case "Repairs":
        return warningColor;
      case "Parking":
        return successColor;
      case "Tolls":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Fuel":
        return Icons.local_gas_station;
      case "Maintenance":
        return Icons.build;
      case "Insurance":
        return Icons.security;
      case "Repairs":
        return Icons.build_circle;
      case "Parking":
        return Icons.local_parking;
      case "Tolls":
        return Icons.toll;
      default:
        return Icons.attach_money;
    }
  }
}
