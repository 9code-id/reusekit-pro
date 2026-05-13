import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPerformanceReportsView extends StatefulWidget {
  const LtaPerformanceReportsView({super.key});

  @override
  State<LtaPerformanceReportsView> createState() => _LtaPerformanceReportsViewState();
}

class _LtaPerformanceReportsViewState extends State<LtaPerformanceReportsView> {
  String selectedPeriod = "This Month";
  String selectedMetric = "Overall Performance";
  String selectedDriver = "All Drivers";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Quarter", "value": "Last Quarter"},
    {"label": "This Year", "value": "This Year"}
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Overall Performance", "value": "Overall Performance"},
    {"label": "Delivery Speed", "value": "Delivery Speed"},
    {"label": "Customer Rating", "value": "Customer Rating"},
    {"label": "Fuel Efficiency", "value": "Fuel Efficiency"},
    {"label": "Safety Record", "value": "Safety Record"},
    {"label": "Revenue Generated", "value": "Revenue Generated"}
  ];

  List<Map<String, dynamic>> driverOptions = [
    {"label": "All Drivers", "value": "All Drivers"},
    {"label": "Ahmad Suryanto", "value": "Ahmad Suryanto"},
    {"label": "Budi Santoso", "value": "Budi Santoso"},
    {"label": "Sari Wulandari", "value": "Sari Wulandari"},
    {"label": "Eko Prasetyo", "value": "Eko Prasetyo"},
    {"label": "Indra Kusuma", "value": "Indra Kusuma"}
  ];

  List<Map<String, dynamic>> performanceData = [
    {
      "driverId": "DRV001",
      "driverName": "Ahmad Suryanto",
      "vehicleNumber": "B 1234 XYZ",
      "totalOrders": 156,
      "completedOrders": 152,
      "cancelledOrders": 4,
      "completionRate": 97.4,
      "averageRating": 4.8,
      "totalRevenue": 3200000.0,
      "totalDistance": 2840.5,
      "fuelConsumption": 341.2,
      "fuelEfficiency": 8.3,
      "onTimeDeliveries": 148,
      "lateDeliveries": 4,
      "onTimeRate": 97.4,
      "averageDeliveryTime": 45.2,
      "safetyScore": 98.5,
      "customerComplaints": 1,
      "performanceScore": 94.8,
      "rank": 1,
      "improvement": "+2.3%"
    },
    {
      "driverId": "DRV002",
      "driverName": "Budi Santoso",
      "vehicleNumber": "B 5678 ABC",
      "totalOrders": 142,
      "completedOrders": 135,
      "cancelledOrders": 7,
      "completionRate": 95.1,
      "averageRating": 4.7,
      "totalRevenue": 2950000.0,
      "totalDistance": 2650.8,
      "fuelConsumption": 338.5,
      "fuelEfficiency": 7.8,
      "onTimeDeliveries": 128,
      "lateDeliveries": 7,
      "onTimeRate": 94.8,
      "averageDeliveryTime": 48.7,
      "safetyScore": 96.2,
      "customerComplaints": 2,
      "performanceScore": 91.5,
      "rank": 2,
      "improvement": "+1.8%"
    },
    {
      "driverId": "DRV003",
      "driverName": "Sari Wulandari",
      "vehicleNumber": "B 9012 DEF",
      "totalOrders": 138,
      "completedOrders": 130,
      "cancelledOrders": 8,
      "completionRate": 94.2,
      "averageRating": 4.6,
      "totalRevenue": 2800000.0,
      "totalDistance": 2580.3,
      "fuelConsumption": 329.1,
      "fuelEfficiency": 7.8,
      "onTimeDeliveries": 122,
      "lateDeliveries": 8,
      "onTimeRate": 93.8,
      "averageDeliveryTime": 52.1,
      "safetyScore": 95.8,
      "customerComplaints": 3,
      "performanceScore": 89.2,
      "rank": 3,
      "improvement": "+0.5%"
    },
    {
      "driverId": "DRV004",
      "driverName": "Eko Prasetyo",
      "vehicleNumber": "B 3456 GHI",
      "totalOrders": 125,
      "completedOrders": 115,
      "cancelledOrders": 10,
      "completionRate": 92.0,
      "averageRating": 4.5,
      "totalRevenue": 2600000.0,
      "totalDistance": 2420.7,
      "fuelConsumption": 318.4,
      "fuelEfficiency": 7.6,
      "onTimeDeliveries": 105,
      "lateDeliveries": 10,
      "onTimeRate": 91.3,
      "averageDeliveryTime": 55.3,
      "safetyScore": 94.1,
      "customerComplaints": 4,
      "performanceScore": 86.8,
      "rank": 4,
      "improvement": "-1.2%"
    },
    {
      "driverId": "DRV005",
      "driverName": "Indra Kusuma",
      "vehicleNumber": "B 7890 JKL",
      "totalOrders": 118,
      "completedOrders": 108,
      "cancelledOrders": 10,
      "completionRate": 91.5,
      "averageRating": 4.4,
      "totalRevenue": 2450000.0,
      "totalDistance": 2380.2,
      "fuelConsumption": 325.6,
      "fuelEfficiency": 7.3,
      "onTimeDeliveries": 96,
      "lateDeliveries": 12,
      "onTimeRate": 88.9,
      "averageDeliveryTime": 58.7,
      "safetyScore": 92.5,
      "customerComplaints": 6,
      "performanceScore": 84.2,
      "rank": 5,
      "improvement": "-2.1%"
    }
  ];

  Map<String, dynamic> teamMetrics = {
    "averagePerformanceScore": 89.3,
    "totalOrdersCompleted": 740,
    "totalRevenue": 14000000.0,
    "averageCustomerRating": 4.6,
    "averageCompletionRate": 94.0,
    "averageOnTimeRate": 93.2,
    "totalDistanceCovered": 12862.5,
    "averageFuelEfficiency": 7.8,
    "totalComplaints": 16,
    "averageSafetyScore": 95.4
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Performance report exported successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Options
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
                    label: "Metric",
                    items: metricOptions,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Driver Filter
            QDropdownField(
              label: "Driver",
              items: driverOptions,
              value: selectedDriver,
              onChanged: (value, label) {
                selectedDriver = value;
                setState(() {});
              },
            ),

            // Team Performance Overview
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
                  Text(
                    "Team Performance Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewCard(
                          "Performance Score",
                          "${teamMetrics["averagePerformanceScore"]}%",
                          Icons.trending_up,
                          primaryColor
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "Completion Rate",
                          "${teamMetrics["averageCompletionRate"]}%",
                          Icons.check_circle,
                          successColor
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewCard(
                          "Customer Rating",
                          "${teamMetrics["averageCustomerRating"]}★",
                          Icons.star,
                          warningColor
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "On-Time Rate",
                          "${teamMetrics["averageOnTimeRate"]}%",
                          Icons.schedule,
                          infoColor
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Performance Ranking
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
                      Text(
                        "Driver Performance Ranking",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Current Period",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: performanceData.length,
                    separatorBuilder: (context, index) => SizedBox(height: spSm),
                    itemBuilder: (context, index) {
                      final driver = performanceData[index];
                      Color rankColor = driver["rank"] == 1 
                          ? Colors.amber
                          : driver["rank"] == 2 
                              ? Colors.grey
                              : driver["rank"] == 3 
                                  ? Colors.brown
                                  : disabledBoldColor;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: driver["rank"] <= 3 ? rankColor.withAlpha(10) : Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: driver["rank"] <= 3 ? rankColor.withAlpha(30) : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: rankColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "#${driver["rank"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${driver["driverName"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: (driver["improvement"] as String).startsWith('+') ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${driver["improvement"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: (driver["improvement"] as String).startsWith('+') ? successColor : dangerColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${driver["vehicleNumber"]}",
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
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildMetricItem(
                                    "Performance",
                                    "${driver["performanceScore"]}%",
                                    Icons.trending_up
                                  ),
                                ),
                                Expanded(
                                  child: _buildMetricItem(
                                    "Completion",
                                    "${(driver["completionRate"] as double).toStringAsFixed(1)}%",
                                    Icons.check_circle
                                  ),
                                ),
                                Expanded(
                                  child: _buildMetricItem(
                                    "Rating",
                                    "${driver["averageRating"]}★",
                                    Icons.star
                                  ),
                                ),
                                Expanded(
                                  child: _buildMetricItem(
                                    "Revenue",
                                    "Rp ${((driver["totalRevenue"] as double) / 1000000).toStringAsFixed(1)}M",
                                    Icons.monetization_on
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem("Orders", "${driver["completedOrders"]}/${driver["totalOrders"]}"),
                                ),
                                Expanded(
                                  child: _buildDetailItem("On-Time", "${(driver["onTimeRate"] as double).toStringAsFixed(1)}%"),
                                ),
                                Expanded(
                                  child: _buildDetailItem("Safety", "${(driver["safetyScore"] as double).toStringAsFixed(1)}%"),
                                ),
                                Expanded(
                                  child: _buildDetailItem("Fuel Eff.", "${(driver["fuelEfficiency"] as double).toStringAsFixed(1)} km/L"),
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

            // Detailed Performance Metrics
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
                  Text(
                    "Detailed Performance Metrics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildDetailedMetric("Total Orders Completed", "${teamMetrics["totalOrdersCompleted"]}", Icons.assignment),
                  _buildDetailedMetric("Total Revenue Generated", "Rp ${((teamMetrics["totalRevenue"] as double) / 1000000).toStringAsFixed(1)}M", Icons.monetization_on),
                  _buildDetailedMetric("Total Distance Covered", "${(teamMetrics["totalDistanceCovered"] as double).toStringAsFixed(1)} km", Icons.route),
                  _buildDetailedMetric("Average Fuel Efficiency", "${teamMetrics["averageFuelEfficiency"]} km/L", Icons.local_gas_station),
                  _buildDetailedMetric("Total Customer Complaints", "${teamMetrics["totalComplaints"]}", Icons.report_problem),
                  _buildDetailedMetric("Average Safety Score", "${teamMetrics["averageSafetyScore"]}%", Icons.security),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    size: bs.md,
                    onPressed: () {
                      ss("Performance report exported successfully");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send to Management",
                    size: bs.md,
                    onPressed: () {
                      ss("Report sent to management");
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

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
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

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: primaryColor),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
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

  Widget _buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
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

  Widget _buildDetailedMetric(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryColor),
          SizedBox(width: spSm),
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
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
