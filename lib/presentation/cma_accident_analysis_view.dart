import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAccidentAnalysisView extends StatefulWidget {
  const CmaAccidentAnalysisView({super.key});

  @override
  State<CmaAccidentAnalysisView> createState() => _CmaAccidentAnalysisViewState();
}

class _CmaAccidentAnalysisViewState extends State<CmaAccidentAnalysisView> {
  int currentTab = 0;
  String selectedTimeframe = "Last 6 Months";
  String selectedSeverity = "All";
  String selectedVehicleType = "All";
  String selectedCause = "All";

  List<Map<String, dynamic>> accidentData = [
    {
      "id": "ACC-2024-001",
      "vehicleId": "CFL-001",
      "driverName": "Michael Johnson",
      "date": "2024-06-15",
      "time": "14:30",
      "location": "Interstate 95, Mile 45",
      "severity": "Minor",
      "injuries": 0,
      "fatalities": 0,
      "vehicleDamage": 2500.0,
      "propertyCost": 800.0,
      "totalCost": 3300.0,
      "cause": "Rear-end collision",
      "weatherCondition": "Clear",
      "roadCondition": "Dry",
      "status": "Under Review",
      "insuranceClaim": "CLAIM-001",
      "description": "Vehicle was rear-ended while stopped at traffic light",
      "vehicleType": "Delivery Van"
    },
    {
      "id": "ACC-2024-002", 
      "vehicleId": "CFL-015",
      "driverName": "Sarah Williams",
      "date": "2024-06-10",
      "time": "09:15",
      "location": "Downtown Business District",
      "severity": "Major",
      "injuries": 2,
      "fatalities": 0,
      "vehicleDamage": 15000.0,
      "propertyCost": 3200.0,
      "totalCost": 18200.0,
      "cause": "Side impact",
      "weatherCondition": "Rain",
      "roadCondition": "Wet",
      "status": "Closed",
      "insuranceClaim": "CLAIM-002",
      "description": "T-bone collision at intersection during rush hour",
      "vehicleType": "Box Truck"
    },
    {
      "id": "ACC-2024-003",
      "vehicleId": "CFL-008",
      "driverName": "David Chen",
      "date": "2024-06-05",
      "time": "22:45",
      "location": "Highway 101, Exit 23",
      "severity": "Critical",
      "injuries": 1,
      "fatalities": 0,
      "vehicleDamage": 25000.0,
      "propertyCost": 5000.0,
      "totalCost": 30000.0,
      "cause": "Rollover",
      "weatherCondition": "Fog",
      "roadCondition": "Wet",
      "status": "Investigation",
      "insuranceClaim": "CLAIM-003",
      "description": "Vehicle rolled over after losing control on wet road",
      "vehicleType": "Semi-truck"
    },
    {
      "id": "ACC-2024-004",
      "vehicleId": "CFL-022",
      "driverName": "Lisa Rodriguez",
      "date": "2024-05-28",
      "time": "16:20",
      "location": "City Center Parking Lot",
      "severity": "Minor",
      "injuries": 0,
      "fatalities": 0,
      "vehicleDamage": 1200.0,
      "propertyCost": 400.0,
      "totalCost": 1600.0,
      "cause": "Backing accident",
      "weatherCondition": "Clear",
      "roadCondition": "Dry",
      "status": "Closed",
      "insuranceClaim": "CLAIM-004",
      "description": "Minor collision while backing out of parking space",
      "vehicleType": "Delivery Van"
    },
    {
      "id": "ACC-2024-005",
      "vehicleId": "CFL-031",
      "driverName": "Robert Taylor",
      "date": "2024-05-20",
      "time": "11:30",
      "location": "Industrial Zone Road 5",
      "severity": "Major",
      "injuries": 0,
      "fatalities": 0,
      "vehicleDamage": 12000.0,
      "propertyCost": 2800.0,
      "totalCost": 14800.0,
      "cause": "Head-on collision",
      "weatherCondition": "Clear",
      "roadCondition": "Dry",
      "status": "Settled",
      "insuranceClaim": "CLAIM-005",
      "description": "Head-on collision with oncoming vehicle",
      "vehicleType": "Box Truck"
    }
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last Year", "value": "Last Year"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> severityItems = [
    {"label": "All", "value": "All"},
    {"label": "Minor", "value": "Minor"},
    {"label": "Major", "value": "Major"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> vehicleTypeItems = [
    {"label": "All", "value": "All"},
    {"label": "Delivery Van", "value": "Delivery Van"},
    {"label": "Box Truck", "value": "Box Truck"},
    {"label": "Semi-truck", "value": "Semi-truck"},
    {"label": "Pickup Truck", "value": "Pickup Truck"},
  ];

  List<Map<String, dynamic>> causeItems = [
    {"label": "All", "value": "All"},
    {"label": "Rear-end collision", "value": "Rear-end collision"},
    {"label": "Side impact", "value": "Side impact"},
    {"label": "Rollover", "value": "Rollover"},
    {"label": "Backing accident", "value": "Backing accident"},
    {"label": "Head-on collision", "value": "Head-on collision"},
  ];

  List<Map<String, dynamic>> get filteredAccidents {
    return accidentData.where((accident) {
      if (selectedSeverity != "All" && accident["severity"] != selectedSeverity) return false;
      if (selectedVehicleType != "All" && accident["vehicleType"] != selectedVehicleType) return false;
      if (selectedCause != "All" && accident["cause"] != selectedCause) return false;
      return true;
    }).toList();
  }

  Widget _buildOverviewTab() {
    final totalAccidents = filteredAccidents.length;
    final totalCost = filteredAccidents.fold(0.0, (sum, accident) => sum + (accident["totalCost"] as double));
    final totalInjuries = filteredAccidents.fold(0, (sum, accident) => sum + (accident["injuries"] as int));
    final criticalAccidents = filteredAccidents.where((a) => a["severity"] == "Critical").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeItems,
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
                  label: "Severity",
                  items: severityItems,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Total Accidents", "$totalAccidents", Icons.warning, dangerColor),
              _buildStatCard("Total Cost", "\$${totalCost.currency}", Icons.attach_money, warningColor),
              _buildStatCard("Total Injuries", "$totalInjuries", Icons.local_hospital, infoColor),
              _buildStatCard("Critical Cases", "$criticalAccidents", Icons.priority_high, dangerColor),
            ],
          ),

          // Accident Severity Chart
          Container(
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
                  "Accidents by Severity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSeverityChart(),
              ],
            ),
          ),

          // Recent Accidents
          Container(
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
                  "Recent Accidents",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...filteredAccidents.take(3).map((accident) => _buildAccidentItem(accident)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle Type",
                  items: vehicleTypeItems,
                  value: selectedVehicleType,
                  onChanged: (value, label) {
                    selectedVehicleType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Cause",
                  items: causeItems,
                  value: selectedCause,
                  onChanged: (value, label) {
                    selectedCause = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Analysis Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalysisCard("Most Common Cause", "Rear-end collision", "35%", dangerColor),
              _buildAnalysisCard("Peak Accident Time", "14:00 - 18:00", "40%", warningColor),
              _buildAnalysisCard("Weather Factor", "Clear conditions", "60%", successColor),
              _buildAnalysisCard("Cost per Accident", "\$9,580", "avg", infoColor),
            ],
          ),

          // Trends Analysis
          Container(
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
                  "Monthly Accident Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildTrendChart(),
              ],
            ),
          ),

          // Risk Factors
          Container(
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
                  "Risk Factors Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildRiskFactorsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // All Accidents List
          Container(
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
                    Text(
                      "Accident Reports",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Export",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Accident reports exported successfully");
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...filteredAccidents.map((accident) => _buildDetailedAccidentItem(accident)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Prevention Recommendations
          Container(
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
                  "Prevention Recommendations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildPreventionItem("Driver Training", "Implement defensive driving courses", Icons.school, warningColor),
                _buildPreventionItem("Vehicle Maintenance", "Regular safety inspections", Icons.build, infoColor),
                _buildPreventionItem("Technology Upgrade", "Install collision avoidance systems", Icons.sensors, successColor),
                _buildPreventionItem("Policy Review", "Update safety protocols", Icons.policy, primaryColor),
              ],
            ),
          ),

          // Safety Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSafetyMetric("Days Since Last Accident", "15", successColor),
              _buildSafetyMetric("Target: Zero Accidents", "30 days", warningColor),
              _buildSafetyMetric("Safety Score", "78%", infoColor),
              _buildSafetyMetric("Training Completion", "85%", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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

  Widget _buildAnalysisCard(String title, String value, String metric, Color color) {
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
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            metric,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityChart() {
    final minor = filteredAccidents.where((a) => a["severity"] == "Minor").length;
    final major = filteredAccidents.where((a) => a["severity"] == "Major").length;
    final critical = filteredAccidents.where((a) => a["severity"] == "Critical").length;
    
    return Column(
      children: [
        _buildChartBar("Minor", minor, successColor),
        _buildChartBar("Major", major, warningColor),
        _buildChartBar("Critical", critical, dangerColor),
      ],
    );
  }

  Widget _buildChartBar(String label, int value, Color color) {
    final maxValue = filteredAccidents.length;
    final percentage = maxValue > 0 ? (value / maxValue) : 0.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Text("$value", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      height: 200,
      child: Center(
        child: Text(
          "Monthly trend visualization would be displayed here",
          style: TextStyle(color: disabledBoldColor),
        ),
      ),
    );
  }

  Widget _buildRiskFactorsList() {
    final riskFactors = [
      {"factor": "Weather Conditions", "impact": "High", "percentage": "30%"},
      {"factor": "Time of Day", "impact": "Medium", "percentage": "25%"},
      {"factor": "Driver Experience", "impact": "High", "percentage": "35%"},
      {"factor": "Vehicle Age", "impact": "Low", "percentage": "10%"},
    ];

    return Column(
      children: riskFactors.map((factor) {
        Color impactColor = factor["impact"] == "High" ? dangerColor : 
                          factor["impact"] == "Medium" ? warningColor : successColor;
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: impactColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: impactColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${factor["factor"]}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: impactColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${factor["impact"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${factor["percentage"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: impactColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAccidentItem(Map<String, dynamic> accident) {
    Color severityColor = accident["severity"] == "Critical" ? dangerColor :
                         accident["severity"] == "Major" ? warningColor : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(width: 4, color: severityColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${accident["id"]} - ${accident["vehicleId"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${accident["driverName"]} • ${accident["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${accident["location"]}",
                  style: TextStyle(fontSize: 12),
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
                  color: severityColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${accident["severity"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${(accident["totalCost"] as double).currency}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedAccidentItem(Map<String, dynamic> accident) {
    Color severityColor = accident["severity"] == "Critical" ? dangerColor :
                         accident["severity"] == "Major" ? warningColor : successColor;
    Color statusColor = accident["status"] == "Closed" ? successColor :
                       accident["status"] == "Settled" ? infoColor : warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(width: 4, color: severityColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${accident["id"]} - ${accident["vehicleId"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: severityColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${accident["severity"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Driver: ${accident["driverName"]}", style: TextStyle(fontSize: 14)),
                    Text("Date: ${accident["date"]} at ${accident["time"]}", style: TextStyle(fontSize: 14)),
                    Text("Location: ${accident["location"]}", style: TextStyle(fontSize: 14)),
                    Text("Cause: ${accident["cause"]}", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Total Cost: \$${(accident["totalCost"] as double).currency}", 
                       style: TextStyle(fontWeight: FontWeight.bold, color: dangerColor)),
                  Text("Injuries: ${accident["injuries"]}", style: TextStyle(fontSize: 14)),
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${accident["status"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${accident["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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
    );
  }

  Widget _buildSafetyMetric(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Accident Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analysis", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.assignment)),
        Tab(text: "Prevention", icon: Icon(Icons.security)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalysisTab(),
        _buildReportsTab(),
        _buildPreventionTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
