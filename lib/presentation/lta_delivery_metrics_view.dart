import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDeliveryMetricsView extends StatefulWidget {
  const LtaDeliveryMetricsView({super.key});

  @override
  State<LtaDeliveryMetricsView> createState() => _LtaDeliveryMetricsViewState();
}

class _LtaDeliveryMetricsViewState extends State<LtaDeliveryMetricsView> {
  String selectedTimeframe = "Today";
  String selectedMetricType = "All Metrics";
  bool loading = false;
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"}
  ];

  List<Map<String, dynamic>> metricTypeOptions = [
    {"label": "All Metrics", "value": "All Metrics"},
    {"label": "Delivery Time", "value": "Delivery Time"},
    {"label": "Distance & Routes", "value": "Distance & Routes"},
    {"label": "Driver Performance", "value": "Driver Performance"},
    {"label": "Vehicle Efficiency", "value": "Vehicle Efficiency"},
    {"label": "Customer Satisfaction", "value": "Customer Satisfaction"}
  ];

  // Delivery Metrics Data
  Map<String, dynamic> metricsData = {
    "totalDeliveries": 1247,
    "completedDeliveries": 1098,
    "onTimeDeliveries": 945,
    "lateDeliveries": 153,
    "failedDeliveries": 49,
    "averageDeliveryTime": 42.5,
    "fastestDelivery": 18.0,
    "slowestDelivery": 125.0,
    "totalDistance": 18450.5,
    "averageDistance": 16.8,
    "fuelEfficiency": 85.2,
    "customerRating": 4.3,
    "onTimePercentage": 86.1,
    "successRate": 96.1
  };

  List<Map<String, dynamic>> deliveryTimeData = [
    {"hour": "6AM", "deliveries": 12, "avgTime": 35.5},
    {"hour": "7AM", "deliveries": 25, "avgTime": 38.2},
    {"hour": "8AM", "deliveries": 48, "avgTime": 42.8},
    {"hour": "9AM", "deliveries": 65, "avgTime": 45.1},
    {"hour": "10AM", "deliveries": 78, "avgTime": 41.5},
    {"hour": "11AM", "deliveries": 89, "avgTime": 39.8},
    {"hour": "12PM", "deliveries": 95, "avgTime": 47.2},
    {"hour": "1PM", "deliveries": 88, "avgTime": 44.6},
    {"hour": "2PM", "deliveries": 72, "avgTime": 41.3},
    {"hour": "3PM", "deliveries": 68, "avgTime": 38.9},
    {"hour": "4PM", "deliveries": 85, "avgTime": 43.7},
    {"hour": "5PM", "deliveries": 92, "avgTime": 46.8},
    {"hour": "6PM", "deliveries": 78, "avgTime": 44.2},
    {"hour": "7PM", "deliveries": 45, "avgTime": 41.8},
    {"hour": "8PM", "deliveries": 28, "avgTime": 39.5}
  ];

  List<Map<String, dynamic>> driverMetrics = [
    {
      "driverId": "DRV001",
      "name": "Ahmad Rizki",
      "totalDeliveries": 156,
      "onTimeDeliveries": 142,
      "averageTime": 38.5,
      "rating": 4.6,
      "efficiency": 91.0,
      "distance": 2450.8,
      "status": "Active"
    },
    {
      "driverId": "DRV002", 
      "name": "Budi Santoso",
      "totalDeliveries": 148,
      "onTimeDeliveries": 128,
      "averageTime": 42.1,
      "rating": 4.4,
      "efficiency": 86.5,
      "distance": 2389.2,
      "status": "Active"
    },
    {
      "driverId": "DRV003",
      "name": "Citra Dewi",
      "totalDeliveries": 134,
      "onTimeDeliveries": 119,
      "averageTime": 41.8,
      "rating": 4.5,
      "efficiency": 88.8,
      "distance": 2156.4,
      "status": "Active"
    },
    {
      "driverId": "DRV004",
      "name": "Dedi Kurniawan",
      "totalDeliveries": 125,
      "onTimeDeliveries": 108,
      "averageTime": 45.2,
      "rating": 4.2,
      "efficiency": 86.4,
      "distance": 2024.6,
      "status": "Break"
    },
    {
      "driverId": "DRV005",
      "name": "Eka Putri",
      "totalDeliveries": 142,
      "onTimeDeliveries": 131,
      "averageTime": 39.7,
      "rating": 4.7,
      "efficiency": 92.3,
      "distance": 2298.5,
      "status": "Active"
    }
  ];

  List<Map<String, dynamic>> vehicleEfficiency = [
    {
      "vehicleId": "TRK001",
      "type": "Truck",
      "deliveries": 89,
      "distance": 1456.8,
      "fuelUsed": 245.6,
      "efficiency": 5.9,
      "maintenanceScore": 92,
      "status": "Active"
    },
    {
      "vehicleId": "VAN002",
      "type": "Van", 
      "deliveries": 156,
      "distance": 2134.5,
      "fuelUsed": 289.3,
      "efficiency": 7.4,
      "maintenanceScore": 88,
      "status": "Active"
    },
    {
      "vehicleId": "MTR003",
      "type": "Motorcycle",
      "deliveries": 234,
      "distance": 1876.2,
      "fuelUsed": 156.8,
      "efficiency": 12.0,
      "maintenanceScore": 95,
      "status": "Active"
    },
    {
      "vehicleId": "TRK004",
      "type": "Truck",
      "deliveries": 78,
      "distance": 1289.4,
      "fuelUsed": 234.7,
      "efficiency": 5.5,
      "maintenanceScore": 85,
      "status": "Maintenance"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Metrics"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Section
                  Container(
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
                          "Filter Metrics",
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
                                label: "Timeframe",
                                items: timeframeOptions,
                                value: selectedTimeframe,
                                onChanged: (value, label) {
                                  selectedTimeframe = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Metric Type",
                                items: metricTypeOptions,
                                value: selectedMetricType,
                                onChanged: (value, label) {
                                  selectedMetricType = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Key Metrics Overview
                  Container(
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
                          "Key Delivery Metrics",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: [
                            _buildMetricCard(
                              "Total Deliveries",
                              "${metricsData["totalDeliveries"]}",
                              Icons.local_shipping,
                              primaryColor,
                            ),
                            _buildMetricCard(
                              "On-Time Rate",
                              "${(metricsData["onTimePercentage"] as num).toStringAsFixed(1)}%",
                              Icons.schedule,
                              successColor,
                            ),
                            _buildMetricCard(
                              "Success Rate", 
                              "${(metricsData["successRate"] as num).toStringAsFixed(1)}%",
                              Icons.check_circle,
                              infoColor,
                            ),
                            _buildMetricCard(
                              "Avg Delivery Time",
                              "${(metricsData["averageDeliveryTime"] as num).toStringAsFixed(1)} min",
                              Icons.timer,
                              warningColor,
                            ),
                            _buildMetricCard(
                              "Customer Rating",
                              "${(metricsData["customerRating"] as num).toStringAsFixed(1)}/5.0",
                              Icons.star,
                              warningColor,
                            ),
                            _buildMetricCard(
                              "Fuel Efficiency",
                              "${(metricsData["fuelEfficiency"] as num).toStringAsFixed(1)}%",
                              Icons.local_gas_station,
                              successColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Delivery Time Distribution
                  Container(
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
                        Row(
                          children: [
                            Icon(Icons.access_time, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Delivery Time Distribution",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 300,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: deliveryTimeData.map((data) {
                                double maxDeliveries = deliveryTimeData
                                    .map((d) => d["deliveries"] as int)
                                    .reduce((a, b) => a > b ? a : b)
                                    .toDouble();
                                double height = ((data["deliveries"] as int) / maxDeliveries) * 200;
                                
                                return Container(
                                  width: 60,
                                  margin: EdgeInsets.only(right: spXs),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${data["deliveries"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        width: 40,
                                        height: height,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(150),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${data["hour"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(data["avgTime"] as num).toStringAsFixed(1)}m",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Driver Performance
                  Container(
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
                        Row(
                          children: [
                            Icon(Icons.person, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Driver Performance Metrics",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        ...driverMetrics.map((driver) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${driver["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "ID: ${driver["driverId"]}",
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
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: driver["status"] == "Active"
                                            ? successColor.withAlpha(20)
                                            : warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${driver["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: driver["status"] == "Active"
                                              ? successColor
                                              : warningColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDriverMetricItem(
                                        "Deliveries",
                                        "${driver["totalDeliveries"]}",
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildDriverMetricItem(
                                        "On-Time",
                                        "${driver["onTimeDeliveries"]}",
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildDriverMetricItem(
                                        "Avg Time",
                                        "${(driver["averageTime"] as num).toStringAsFixed(1)}m",
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildDriverMetricItem(
                                        "Rating",
                                        "${(driver["rating"] as num).toStringAsFixed(1)}",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Vehicle Efficiency
                  Container(
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
                        Row(
                          children: [
                            Icon(Icons.directions_car, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Vehicle Efficiency Metrics",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: vehicleEfficiency.map((vehicle) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          vehicle["type"] == "Motorcycle"
                                              ? Icons.motorcycle
                                              : vehicle["type"] == "Van"
                                                  ? Icons.local_shipping
                                                  : Icons.fire_truck,
                                          color: infoColor,
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${vehicle["vehicleId"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${vehicle["type"]}",
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
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: vehicle["status"] == "Active"
                                              ? successColor.withAlpha(20)
                                              : dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${vehicle["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: vehicle["status"] == "Active"
                                                ? successColor
                                                : dangerColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildVehicleMetricItem(
                                          "Deliveries",
                                          "${vehicle["deliveries"]}",
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildVehicleMetricItem(
                                          "Distance",
                                          "${((vehicle["distance"] as num).toDouble()).toStringAsFixed(1)}km",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildVehicleMetricItem(
                                          "Efficiency",
                                          "${(vehicle["efficiency"] as num).toStringAsFixed(1)}km/L",
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildVehicleMetricItem(
                                          "Maintenance",
                                          "${vehicle["maintenanceScore"]}%",
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

                  // Export Actions
                  Container(
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
                          "Export Metrics",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Export PDF",
                                icon: Icons.picture_as_pdf,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Exporting delivery metrics to PDF...");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Export Excel",
                                icon: Icons.table_chart,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Exporting delivery metrics to Excel...");
                                },
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
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
