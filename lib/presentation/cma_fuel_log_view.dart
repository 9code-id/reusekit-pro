import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaFuelLogView extends StatefulWidget {
  const CmaFuelLogView({super.key});

  @override
  State<CmaFuelLogView> createState() => _CmaFuelLogViewState();
}

class _CmaFuelLogViewState extends State<CmaFuelLogView> {
  String vehicleFilter = "";
  String dateRange = "This Month";
  List<Map<String, dynamic>> fuelLogs = [
    {
      "id": 1,
      "date": "2025-06-18",
      "vehicle": "Honda Civic",
      "odometer": 45678,
      "liters": 42.5,
      "pricePerLiter": 1.45,
      "totalCost": 61.63,
      "fuelType": "Regular",
      "location": "Shell Station",
      "efficiency": 12.5,
      "fullTank": true,
    },
    {
      "id": 2,
      "date": "2025-06-15",
      "vehicle": "Honda Civic",
      "odometer": 45234,
      "liters": 38.2,
      "pricePerLiter": 1.42,
      "totalCost": 54.24,
      "fuelType": "Regular",
      "location": "Petro Canada",
      "efficiency": 11.8,
      "fullTank": true,
    },
    {
      "id": 3,
      "date": "2025-06-12",
      "vehicle": "Toyota Camry",
      "odometer": 67890,
      "liters": 45.8,
      "pricePerLiter": 1.48,
      "totalCost": 67.78,
      "fuelType": "Premium",
      "location": "Esso",
      "efficiency": 10.2,
      "fullTank": false,
    },
  ];

  List<Map<String, dynamic>> get filteredLogs {
    if (vehicleFilter.isEmpty) return fuelLogs;
    return fuelLogs.where((log) => 
      "${log["vehicle"]}".toLowerCase().contains(vehicleFilter.toLowerCase())
    ).toList();
  }

  double get totalSpent {
    return filteredLogs.fold(0.0, (sum, log) => 
      sum + (log["totalCost"] as double)
    );
  }

  double get averageEfficiency {
    if (filteredLogs.isEmpty) return 0.0;
    return filteredLogs.fold(0.0, (sum, log) => 
      sum + (log["efficiency"] as double)
    ) / filteredLogs.length;
  }

  double get totalLiters {
    return filteredLogs.fold(0.0, (sum, log) => 
      sum + (log["liters"] as double)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel Log"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add fuel log
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
                      Icon(Icons.tune, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filters",
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
                        child: QTextField(
                          label: "Search Vehicle",
                          value: vehicleFilter,
                          hint: "Enter vehicle name",
                          onChanged: (value) {
                            vehicleFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: [
                            {"label": "This Week", "value": "This Week"},
                            {"label": "This Month", "value": "This Month"},
                            {"label": "Last 3 Months", "value": "Last 3 Months"},
                            {"label": "This Year", "value": "This Year"},
                          ],
                          value: dateRange,
                          onChanged: (value, label) {
                            dateRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
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
                            "Total Spent",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalSpent.toStringAsFixed(2)}",
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
                            Icons.speed,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Avg Efficiency",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${averageEfficiency.toStringAsFixed(1)} L/100km",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                            Icons.local_gas_station,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Fuel",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${totalLiters.toStringAsFixed(1)} L",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Fuel Logs List
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
                        Icon(Icons.list, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Fuel Logs",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredLogs.length} entries",
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
                    itemCount: filteredLogs.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final log = filteredLogs[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (log["fullTank"] as bool) 
                                      ? successColor.withAlpha(20)
                                      : warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    (log["fullTank"] as bool) ? "Full Tank" : "Partial",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: (log["fullTank"] as bool) 
                                        ? successColor 
                                        : warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${log["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${log["vehicle"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                                  "${log["location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: spMd,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Odometer",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(log["odometer"] as int).toString().replaceAllMapped(
                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'
                                        )} km",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Fuel",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(log["liters"] as double).toStringAsFixed(1)} L",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Cost",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(log["totalCost"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
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
                                        "Efficiency",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(log["efficiency"] as double).toStringAsFixed(1)} L/100km",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: (log["efficiency"] as double) < 8.0 
                                            ? successColor 
                                            : (log["efficiency"] as double) < 12.0 
                                              ? warningColor 
                                              : dangerColor,
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
          // Navigate to add fuel log
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
