import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCostAnalysisView extends StatefulWidget {
  const CmaCostAnalysisView({super.key});

  @override
  State<CmaCostAnalysisView> createState() => _CmaCostAnalysisViewState();
}

class _CmaCostAnalysisViewState extends State<CmaCostAnalysisView> {
  String selectedVehicle = "Honda Civic";
  String analysisType = "Monthly";
  String comparisonType = "Year over Year";

  List<Map<String, dynamic>> vehicles = [
    {
      "name": "Honda Civic",
      "year": 2020,
      "totalCosts": 3456.78,
      "monthlyCosts": 288.07,
      "costPerKm": 0.15,
      "totalDistance": 23045,
      "fuelCosts": 1234.56,
      "maintenanceCosts": 789.23,
      "insuranceCosts": 1200.00,
      "repairCosts": 232.99,
    },
    {
      "name": "Toyota Camry",
      "year": 2019,
      "totalCosts": 4123.45,
      "monthlyCosts": 343.62,
      "costPerKm": 0.18,
      "totalDistance": 22910,
      "fuelCosts": 1456.78,
      "maintenanceCosts": 1023.45,
      "insuranceCosts": 1320.00,
      "repairCosts": 323.22,
    },
  ];

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "fuel": 120.50, "maintenance": 89.99, "insurance": 100.00, "repairs": 0.00},
    {"month": "Feb", "fuel": 135.75, "maintenance": 0.00, "insurance": 100.00, "repairs": 150.00},
    {"month": "Mar", "fuel": 142.30, "maintenance": 299.50, "insurance": 100.00, "repairs": 0.00},
    {"month": "Apr", "fuel": 128.90, "maintenance": 45.00, "insurance": 100.00, "repairs": 0.00},
    {"month": "May", "fuel": 155.60, "maintenance": 0.00, "insurance": 100.00, "repairs": 78.99},
    {"month": "Jun", "fuel": 144.20, "maintenance": 189.99, "insurance": 100.00, "repairs": 0.00},
  ];

  Map<String, dynamic> get currentVehicle {
    return vehicles.firstWhere((v) => v["name"] == selectedVehicle);
  }

  double get totalMonthlyExpenses {
    return monthlyData.fold(0.0, (sum, month) => 
      sum + (month["fuel"] as double) + (month["maintenance"] as double) + 
      (month["insurance"] as double) + (month["repairs"] as double)
    );
  }

  double get avgMonthlyExpense {
    return totalMonthlyExpenses / monthlyData.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              // View detailed charts
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export analysis
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
            // Vehicle Selection & Analysis Controls
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
                      Icon(Icons.analytics, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Analysis Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Select Vehicle",
                    items: vehicles.map((v) => {
                      "label": "${v["name"]} (${v["year"]})",
                      "value": v["name"],
                    }).toList(),
                    value: selectedVehicle,
                    onChanged: (value, label) {
                      selectedVehicle = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Analysis Period",
                          items: [
                            {"label": "Monthly", "value": "Monthly"},
                            {"label": "Quarterly", "value": "Quarterly"},
                            {"label": "Yearly", "value": "Yearly"},
                          ],
                          value: analysisType,
                          onChanged: (value, label) {
                            analysisType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Comparison",
                          items: [
                            {"label": "Year over Year", "value": "Year over Year"},
                            {"label": "Month over Month", "value": "Month over Month"},
                            {"label": "Vehicle Comparison", "value": "Vehicle Comparison"},
                          ],
                          value: comparisonType,
                          onChanged: (value, label) {
                            comparisonType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Key Metrics Summary
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
                            "Total Annual Cost",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(currentVehicle["totalCosts"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "12 months",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                            Icons.calendar_month,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Monthly Average",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(currentVehicle["monthlyCosts"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "per month",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                            Icons.straighten,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Cost per KM",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(currentVehicle["costPerKm"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "per kilometer",
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
                      Icon(Icons.pie_chart, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Annual Cost Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildCostBreakdownItem(
                    "Fuel Costs",
                    currentVehicle["fuelCosts"] as double,
                    currentVehicle["totalCosts"] as double,
                    Icons.local_gas_station,
                    dangerColor,
                  ),
                  _buildCostBreakdownItem(
                    "Insurance",
                    currentVehicle["insuranceCosts"] as double,
                    currentVehicle["totalCosts"] as double,
                    Icons.security,
                    primaryColor,
                  ),
                  _buildCostBreakdownItem(
                    "Maintenance",
                    currentVehicle["maintenanceCosts"] as double,
                    currentVehicle["totalCosts"] as double,
                    Icons.build,
                    infoColor,
                  ),
                  _buildCostBreakdownItem(
                    "Repairs",
                    currentVehicle["repairCosts"] as double,
                    currentVehicle["totalCosts"] as double,
                    Icons.build_circle,
                    warningColor,
                  ),
                ],
              ),
            ),

            // Monthly Trend Chart
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
                      Icon(Icons.trending_up, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Monthly Expense Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: monthlyData.length,
                      itemBuilder: (context, index) {
                        final month = monthlyData[index];
                        final total = (month["fuel"] as double) + 
                                     (month["maintenance"] as double) + 
                                     (month["insurance"] as double) + 
                                     (month["repairs"] as double);
                        final maxAmount = 600.0; // Scale for chart
                        
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (month["repairs"] as double > 0)
                                        Container(
                                          height: ((month["repairs"] as double) / maxAmount) * 140,
                                          decoration: BoxDecoration(
                                            color: warningColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(radiusXs),
                                              topRight: Radius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      if (month["maintenance"] as double > 0)
                                        Container(
                                          height: ((month["maintenance"] as double) / maxAmount) * 140,
                                          color: infoColor,
                                        ),
                                      Container(
                                        height: ((month["insurance"] as double) / maxAmount) * 140,
                                        color: primaryColor,
                                      ),
                                      Container(
                                        height: ((month["fuel"] as double) / maxAmount) * 140,
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(radiusXs),
                                            bottomRight: Radius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${month["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${total.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendItem("Fuel", dangerColor),
                      _buildLegendItem("Insurance", primaryColor),
                      _buildLegendItem("Maintenance", infoColor),
                      _buildLegendItem("Repairs", warningColor),
                    ],
                  ),
                ],
              ),
            ),

            // Cost Comparison with Other Vehicles
            if (vehicles.length > 1)
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
                        Icon(Icons.compare, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Vehicle Comparison",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...vehicles.map((vehicle) {
                      bool isSelected = vehicle["name"] == selectedVehicle;
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${vehicle["name"]} (${vehicle["year"]})",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Monthly: \$${(vehicle["monthlyCosts"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Per km: \$${(vehicle["costPerKm"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(vehicle["totalCosts"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : dangerColor,
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
    );
  }

  Widget _buildCostBreakdownItem(
    String label,
    double amount,
    double total,
    IconData icon,
    Color color,
  ) {
    double percentage = (amount / total) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  label,
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
                "\$${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: disabledColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
