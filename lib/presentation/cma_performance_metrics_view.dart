import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaPerformanceMetricsView extends StatefulWidget {
  const CmaPerformanceMetricsView({super.key});

  @override
  State<CmaPerformanceMetricsView> createState() => _CmaPerformanceMetricsViewState();
}

class _CmaPerformanceMetricsViewState extends State<CmaPerformanceMetricsView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String selectedDriver = "";
  String selectedPeriod = "this_month";
  
  List<Map<String, dynamic>> performanceData = [
    {
      "vehicle": "TRK-001",
      "driver": "John Smith",
      "totalDistance": 2450.5,
      "totalTrips": 87,
      "avgSpeed": 42.8,
      "fuelEfficiency": 8.2,
      "onTimeDeliveries": 82,
      "lateDeliveries": 5,
      "safetyScore": 95,
      "customerRating": 4.8,
      "maintenanceCosts": 450.75,
      "fuelCosts": 1250.50,
      "totalRevenue": 8500.00,
      "profitMargin": 78.5,
      "breakdowns": 0,
      "accidents": 0,
      "violations": 1,
      "idleTime": 45.2,
      "overtimeHours": 12.5
    },
    {
      "vehicle": "VAN-002",
      "driver": "Maria Garcia",
      "totalDistance": 1850.2,
      "totalTrips": 64,
      "avgSpeed": 38.5,
      "fuelEfficiency": 7.8,
      "onTimeDeliveries": 59,
      "lateDeliveries": 5,
      "safetyScore": 98,
      "customerRating": 4.9,
      "maintenanceCosts": 320.25,
      "fuelCosts": 980.75,
      "totalRevenue": 6200.00,
      "profitMargin": 82.1,
      "breakdowns": 0,
      "accidents": 0,
      "violations": 0,
      "idleTime": 32.8,
      "overtimeHours": 8.0
    },
    {
      "vehicle": "TRK-003",
      "driver": "David Chen",
      "totalDistance": 3250.8,
      "totalTrips": 92,
      "avgSpeed": 45.2,
      "fuelEfficiency": 8.5,
      "onTimeDeliveries": 88,
      "lateDeliveries": 4,
      "safetyScore": 92,
      "customerRating": 4.7,
      "maintenanceCosts": 580.50,
      "fuelCosts": 1850.25,
      "totalRevenue": 11200.00,
      "profitMargin": 75.8,
      "breakdowns": 1,
      "accidents": 0,
      "violations": 2,
      "idleTime": 58.5,
      "overtimeHours": 18.5
    }
  ];

  List<Map<String, dynamic>> vehicles = [
    {"label": "TRK-001 - Delivery Truck", "value": "TRK-001"},
    {"label": "VAN-002 - Cargo Van", "value": "VAN-002"},
    {"label": "TRK-003 - Heavy Truck", "value": "TRK-003"},
    {"label": "CAR-004 - Service Car", "value": "CAR-004"}
  ];

  List<Map<String, dynamic>> drivers = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Chen", "value": "david_chen"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"}
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Quarter", "value": "quarter"},
    {"label": "Year", "value": "year"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Metrics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Driver Performance", icon: Icon(Icons.person)),
        Tab(text: "Vehicle Metrics", icon: Icon(Icons.local_shipping)),
        Tab(text: "Financial KPIs", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDriverPerformanceTab(),
        _buildVehicleMetricsTab(),
        _buildFinancialKPIsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildOverviewCards(),
          _buildPerformanceFilters(),
          _buildPerformanceSummary(),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    double totalDistance = performanceData.fold(0.0, (sum, data) => sum + (data["totalDistance"] as double));
    int totalTrips = performanceData.fold(0, (sum, data) => sum + (data["totalTrips"] as int));
    double avgSafetyScore = performanceData.fold(0.0, (sum, data) => sum + (data["safetyScore"] as int)) / performanceData.length;
    double totalRevenue = performanceData.fold(0.0, (sum, data) => sum + (data["totalRevenue"] as double));
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Distance", "${totalDistance.toStringAsFixed(1)} km", Icons.straighten, primaryColor, "+15.2%"),
        _buildOverviewCard("Total Trips", "${totalTrips}", Icons.local_shipping, infoColor, "+8.7%"),
        _buildOverviewCard("Avg Safety Score", "${avgSafetyScore.toStringAsFixed(1)}%", Icons.security, successColor, "+2.1%"),
        _buildOverviewCard("Total Revenue", "\$${totalRevenue.toStringAsFixed(0)}", Icons.attach_money, warningColor, "+12.4%"),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String change) {
    bool isPositive = change.startsWith('+');
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: changeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Filters",
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
                  label: "Vehicle",
                  items: vehicles,
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
                  label: "Driver",
                  items: drivers,
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Time Period",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildSummaryMetric("Avg Speed", "42.2 km/h", Icons.speed, infoColor),
              _buildSummaryMetric("Fuel Efficiency", "8.2 L/100km", Icons.eco, successColor),
              _buildSummaryMetric("On-Time Rate", "92.5%", Icons.schedule, primaryColor),
              _buildSummaryMetric("Safety Rating", "95.0%", Icons.security, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(String title, String value, IconData icon, Color color) {
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
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDriverRankings(),
          _buildDriverMetricsComparison(),
        ],
      ),
    );
  }

  Widget _buildDriverRankings() {
    List<Map<String, dynamic>> sortedDrivers = [...performanceData]
      ..sort((a, b) => (b["safetyScore"] as int).compareTo(a["safetyScore"] as int));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Driver Performance Rankings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...sortedDrivers.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> driver = entry.value;
            Color rankColor = index == 0 ? warningColor : index == 1 ? disabledBoldColor : primaryColor.withAlpha(150);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: rankColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Center(
                      child: Text(
                        "#${index + 1}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: rankColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${driver["driver"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${driver["vehicle"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(" • ", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${driver["totalTrips"]} trips",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${driver["safetyScore"]}%",
                          style: TextStyle(
                            color: successColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.star, color: warningColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${(driver["customerRating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDriverMetricsComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Driver Metrics Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...performanceData.map((driver) => _buildDriverMetricCard(driver)).toList(),
        ],
      ),
    );
  }

  Widget _buildDriverMetricCard(Map<String, dynamic> driver) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.person, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${driver["driver"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${driver["vehicle"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildDriverMetric("Distance", "${(driver["totalDistance"] as double).toStringAsFixed(0)} km", Icons.straighten),
              _buildDriverMetric("Trips", "${driver["totalTrips"]}", Icons.local_shipping),
              _buildDriverMetric("Safety", "${driver["safetyScore"]}%", Icons.security),
              _buildDriverMetric("Rating", "${(driver["customerRating"] as double).toStringAsFixed(1)}", Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriverMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 14),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 10,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildVehicleEfficiencyMetrics(),
          _buildVehicleMaintenanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildVehicleEfficiencyMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Vehicle Efficiency Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...performanceData.map((vehicle) => _buildVehicleEfficiencyCard(vehicle)).toList(),
        ],
      ),
    );
  }

  Widget _buildVehicleEfficiencyCard(Map<String, dynamic> vehicle) {
    double efficiencyScore = (vehicle["fuelEfficiency"] as double);
    Color efficiencyColor = efficiencyScore <= 8.0 ? successColor : 
                           efficiencyScore <= 9.0 ? warningColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.local_shipping, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle["vehicle"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${vehicle["driver"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: efficiencyColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${efficiencyScore.toStringAsFixed(1)} L/100km",
                  style: TextStyle(
                    color: efficiencyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildVehicleMetric("Avg Speed", "${(vehicle["avgSpeed"] as double).toStringAsFixed(1)} km/h", Icons.speed),
              _buildVehicleMetric("Distance", "${(vehicle["totalDistance"] as double).toStringAsFixed(0)} km", Icons.straighten),
              _buildVehicleMetric("Idle Time", "${(vehicle["idleTime"] as double).toStringAsFixed(1)} hrs", Icons.access_time),
              _buildVehicleMetric("Breakdowns", "${vehicle["breakdowns"]}", Icons.build),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 14),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 10,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleMaintenanceMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Maintenance & Cost Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: performanceData.map((vehicle) => _buildMaintenanceCard(vehicle)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceCard(Map<String, dynamic> vehicle) {
    double maintenanceCost = vehicle["maintenanceCosts"] as double;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "${vehicle["vehicle"]}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.build, color: warningColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${maintenanceCost.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Maintenance Cost",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${vehicle["breakdowns"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Breakdowns",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${vehicle["accidents"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Accidents",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 8,
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
    );
  }

  Widget _buildFinancialKPIsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFinancialOverview(),
          _buildProfitabilityAnalysis(),
          _buildCostBreakdown(),
        ],
      ),
    );
  }

  Widget _buildFinancialOverview() {
    double totalRevenue = performanceData.fold(0.0, (sum, data) => sum + (data["totalRevenue"] as double));
    double totalFuelCosts = performanceData.fold(0.0, (sum, data) => sum + (data["fuelCosts"] as double));
    double totalMaintenanceCosts = performanceData.fold(0.0, (sum, data) => sum + (data["maintenanceCosts"] as double));
    double avgProfitMargin = performanceData.fold(0.0, (sum, data) => sum + (data["profitMargin"] as double)) / performanceData.length;
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildFinancialCard("Total Revenue", "\$${totalRevenue.toStringAsFixed(0)}", Icons.trending_up, successColor, "+18.5%"),
        _buildFinancialCard("Fuel Costs", "\$${totalFuelCosts.toStringAsFixed(0)}", Icons.local_gas_station, dangerColor, "+5.2%"),
        _buildFinancialCard("Maintenance", "\$${totalMaintenanceCosts.toStringAsFixed(0)}", Icons.build, warningColor, "-3.1%"),
        _buildFinancialCard("Avg Profit Margin", "${avgProfitMargin.toStringAsFixed(1)}%", Icons.account_balance_wallet, primaryColor, "+2.8%"),
      ],
    );
  }

  Widget _buildFinancialCard(String title, String value, IconData icon, Color color, String change) {
    bool isPositive = change.startsWith('+');
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: changeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfitabilityAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Profitability Analysis by Vehicle",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...performanceData.map((vehicle) => _buildProfitabilityCard(vehicle)).toList(),
        ],
      ),
    );
  }

  Widget _buildProfitabilityCard(Map<String, dynamic> vehicle) {
    double profitMargin = vehicle["profitMargin"] as double;
    Color profitColor = profitMargin >= 80 ? successColor : 
                       profitMargin >= 70 ? warningColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.local_shipping, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle["vehicle"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${vehicle["driver"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: profitColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${profitMargin.toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: profitColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildFinancialMetric("Revenue", "\$${(vehicle["totalRevenue"] as double).toStringAsFixed(0)}", Icons.trending_up),
              _buildFinancialMetric("Fuel Cost", "\$${(vehicle["fuelCosts"] as double).toStringAsFixed(0)}", Icons.local_gas_station),
              _buildFinancialMetric("Maintenance", "\$${(vehicle["maintenanceCosts"] as double).toStringAsFixed(0)}", Icons.build),
              _buildFinancialMetric("Profit", "\$${((vehicle["totalRevenue"] as double) - (vehicle["fuelCosts"] as double) - (vehicle["maintenanceCosts"] as double)).toStringAsFixed(0)}", Icons.attach_money),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 14),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 10,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
    double totalCosts = performanceData.fold(0.0, (sum, data) => 
      sum + (data["fuelCosts"] as double) + (data["maintenanceCosts"] as double));
    double fuelPercentage = (performanceData.fold(0.0, (sum, data) => sum + (data["fuelCosts"] as double)) / totalCosts) * 100;
    double maintenancePercentage = (performanceData.fold(0.0, (sum, data) => sum + (data["maintenanceCosts"] as double)) / totalCosts) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Cost Breakdown Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildCostBreakdownCard("Fuel Costs", "${fuelPercentage.toStringAsFixed(1)}%", dangerColor),
              _buildCostBreakdownCard("Maintenance", "${maintenancePercentage.toStringAsFixed(1)}%", warningColor),
              _buildCostBreakdownCard("Total Costs", "\$${totalCosts.toStringAsFixed(0)}", primaryColor),
              _buildCostBreakdownCard("Cost per KM", "\$${(totalCosts / performanceData.fold(0.0, (sum, data) => sum + (data["totalDistance"] as double))).toStringAsFixed(2)}", infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdownCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
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
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
