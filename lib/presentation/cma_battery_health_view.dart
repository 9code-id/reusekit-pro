import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaBatteryHealthView extends StatefulWidget {
  const CmaBatteryHealthView({super.key});

  @override
  State<CmaBatteryHealthView> createState() => _CmaBatteryHealthViewState();
}

class _CmaBatteryHealthViewState extends State<CmaBatteryHealthView> {
  int currentTab = 0;
  
  // Battery health data
  List<Map<String, dynamic>> batteryReadings = [
    {
      "date": "2024-06-15",
      "voltage": 12.6,
      "load_voltage": 12.2,
      "capacity": 85,
      "temperature": 25,
      "status": "Good",
      "notes": "Battery performing well"
    },
    {
      "date": "2024-05-20",
      "voltage": 12.4,
      "load_voltage": 11.9,
      "capacity": 82,
      "temperature": 28,
      "status": "Fair",
      "notes": "Slight voltage drop under load"
    },
    {
      "date": "2024-04-18",
      "voltage": 12.7,
      "load_voltage": 12.3,
      "capacity": 88,
      "temperature": 22,
      "status": "Excellent",
      "notes": "Battery in perfect condition"
    },
    {
      "date": "2024-03-22",
      "voltage": 12.3,
      "load_voltage": 11.8,
      "capacity": 79,
      "temperature": 30,
      "status": "Fair",
      "notes": "Consider battery replacement soon"
    },
    {
      "date": "2024-02-15",
      "voltage": 12.5,
      "load_voltage": 12.0,
      "capacity": 83,
      "temperature": 18,
      "status": "Good",
      "notes": "Cold weather performance good"
    }
  ];

  List<Map<String, dynamic>> batteryTips = [
    {
      "title": "Regular Testing",
      "description": "Test battery voltage monthly",
      "icon": Icons.battery_charging_full,
      "importance": "High"
    },
    {
      "title": "Clean Terminals",
      "description": "Keep terminals clean and corrosion-free",
      "icon": Icons.cleaning_services,
      "importance": "Medium"
    },
    {
      "title": "Avoid Deep Discharge",
      "description": "Don't let battery completely drain",
      "icon": Icons.battery_alert,
      "importance": "High"
    },
    {
      "title": "Temperature Control",
      "description": "Protect from extreme temperatures",
      "icon": Icons.thermostat,
      "importance": "Medium"
    },
    {
      "title": "Load Testing",
      "description": "Test under load conditions",
      "icon": Icons.speed,
      "importance": "High"
    }
  ];

  // Form fields for new reading
  String testDate = DateTime.now().toString().split(' ')[0];
  double voltage = 12.6;
  double loadVoltage = 12.2;
  int capacity = 85;
  int temperature = 25;
  String notes = "";

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Battery Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.battery_full)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Test", icon: Icon(Icons.science)),
        Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildHistoryTab(),
        _buildTestTab(),
        _buildTipsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    var latestReading = batteryReadings.first;
    double avgVoltage = batteryReadings
        .map((r) => r["voltage"] as double)
        .reduce((a, b) => a + b) / batteryReadings.length;
    double avgCapacity = batteryReadings
        .map((r) => r["capacity"] as int)
        .reduce((a, b) => a + b) / batteryReadings.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Status Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getStatusColor("${latestReading["status"]}").withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: _getStatusColor("${latestReading["status"]}"),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.battery_full,
                      size: 32,
                      color: _getStatusColor("${latestReading["status"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Battery Status",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${latestReading["status"]} - ${latestReading["capacity"]}% Capacity",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${latestReading["status"]}"),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${latestReading["status"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Voltage", "${latestReading["voltage"]}V", Icons.flash_on),
                    ),
                    Expanded(
                      child: _buildStatCard("Load Voltage", "${latestReading["load_voltage"]}V", Icons.speed),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Performance Metrics
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.analytics, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Average Voltage",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${avgVoltage.toStringAsFixed(1)}V",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Last 5 readings",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.battery_charging_full, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Average Capacity",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${avgCapacity.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Last 5 readings",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Reading Details
          Container(
            width: double.infinity,
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
                  "Latest Test Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailRow("Date", "${DateTime.parse("${latestReading["date"]}").dMMMy}"),
                    ),
                    Expanded(
                      child: _buildDetailRow("Temperature", "${latestReading["temperature"]}°C"),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Notes", "${latestReading["notes"]}"),
              ],
            ),
          ),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Test Battery",
                  icon: Icons.science,
                  size: bs.md,
                  onPressed: () {
                    setState(() {
                      currentTab = 2;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View History",
                  icon: Icons.history,
                  size: bs.md,
                  color: secondaryColor,
                  onPressed: () {
                    setState(() {
                      currentTab = 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // History Header
          Row(
            children: [
              Icon(Icons.history, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Battery Test History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${batteryReadings.length} test records",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                color: secondaryColor,
                onPressed: () {
                  ss("Battery history exported");
                },
              ),
            ],
          ),

          // History List
          ...batteryReadings.map((reading) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor("${reading["status"]}"),
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
                            "${DateTime.parse("${reading["date"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${reading["notes"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${reading["status"]}"),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${reading["status"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(child: _buildReadingDetail("Voltage", "${reading["voltage"]}V")),
                    Expanded(child: _buildReadingDetail("Load V", "${reading["load_voltage"]}V")),
                    Expanded(child: _buildReadingDetail("Capacity", "${reading["capacity"]}%")),
                    Expanded(child: _buildReadingDetail("Temp", "${reading["temperature"]}°C")),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTestTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Test Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Battery Test Instructions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Use a multimeter to measure voltage and perform load test",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Test Form
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Record New Test",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QDatePicker(
                  label: "Test Date",
                  value: DateTime.parse(testDate),
                  onChanged: (value) {
                    testDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Voltage (V)",
                        value: voltage.toString(),
                        onChanged: (value) {
                          voltage = double.tryParse(value) ?? 12.6;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Load Voltage (V)",
                        value: loadVoltage.toString(),
                        onChanged: (value) {
                          loadVoltage = double.tryParse(value) ?? 12.2;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Capacity (%)",
                        value: capacity.toString(),
                        onChanged: (value) {
                          capacity = int.tryParse(value) ?? 85;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Temperature (°C)",
                        value: temperature.toString(),
                        onChanged: (value) {
                          temperature = int.tryParse(value) ?? 25;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Test Notes",
                  value: notes,
                  hint: "Enter observations about battery condition",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Test Results",
                    icon: Icons.save,
                    size: bs.md,
                    onPressed: () {
                      String status = "Good";
                      if (voltage < 12.0 || capacity < 70) {
                        status = "Poor";
                      } else if (voltage < 12.4 || capacity < 80) {
                        status = "Fair";
                      } else if (voltage >= 12.6 && capacity >= 90) {
                        status = "Excellent";
                      }

                      batteryReadings.insert(0, {
                        "date": testDate,
                        "voltage": voltage,
                        "load_voltage": loadVoltage,
                        "capacity": capacity,
                        "temperature": temperature,
                        "status": status,
                        "notes": notes.isEmpty ? "No additional notes" : notes
                      });

                      setState(() {
                        currentTab = 0;
                        notes = "";
                      });
                      ss("Battery test results saved successfully");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Test Guidelines
          Container(
            width: double.infinity,
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
                  "Test Guidelines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                _buildGuidelineItem("Voltage", "12.6V+ = Excellent, 12.4-12.6V = Good, 12.0-12.4V = Fair, <12.0V = Poor"),
                _buildGuidelineItem("Load Test", "Apply 50% of CCA rating for 15 seconds"),
                _buildGuidelineItem("Capacity", "90%+ = Excellent, 80-90% = Good, 70-80% = Fair, <70% = Replace"),
                _buildGuidelineItem("Temperature", "Test at room temperature for accurate results"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Tips Header
          Row(
            children: [
              Icon(Icons.lightbulb, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Battery Maintenance Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Keep your car battery healthy",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Tips List
          ...batteryTips.map((tip) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getImportanceColor("${tip["importance"]}"),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getImportanceColor("${tip["importance"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    tip["icon"] as IconData,
                    color: _getImportanceColor("${tip["importance"]}"),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${tip["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getImportanceColor("${tip["importance"]}"),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${tip["importance"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${tip["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),

          // Additional Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Battery Replacement Signs",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "• Slow engine cranking\n• Dashboard warning light\n• Old battery (3+ years)\n• Corrosion on terminals\n• Swollen battery case\n• Low fluid level",
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowXs],
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildReadingDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildGuidelineItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return infoColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getImportanceColor(String importance) {
    switch (importance.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledColor;
    }
  }
}
