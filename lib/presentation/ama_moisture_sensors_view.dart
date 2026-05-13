import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaMoistureSensorsView extends StatefulWidget {
  const AmaMoistureSensorsView({super.key});

  @override
  State<AmaMoistureSensorsView> createState() => _AmaMoistureSensorsViewState();
}

class _AmaMoistureSensorsViewState extends State<AmaMoistureSensorsView> {
  String selectedZone = "all";
  int selectedStatus = 0;
  bool showAlertsOnly = false;
  
  List<Map<String, dynamic>> moistureSensors = [
    {
      "id": "MS001",
      "name": "North Field Sensor 1",
      "zone": "North Field Zone A",
      "crop": "Tomatoes",
      "currentMoisture": 68,
      "optimalRange": {"min": 60, "max": 80},
      "status": "Normal",
      "statusColor": successColor,
      "batteryLevel": 85,
      "lastReading": "2024-06-15 14:30",
      "depth": "15 cm",
      "soilType": "Loamy",
      "temperature": 22.5,
      "conductivity": 1.2,
      "ph": 6.8,
      "location": {"lat": 40.7128, "lng": -74.0060},
      "isOnline": true,
      "alertThreshold": {"low": 50, "high": 85},
      "calibrationDate": "2024-05-01",
      "readings": [
        {"time": "14:30", "moisture": 68, "temp": 22.5},
        {"time": "14:00", "moisture": 67, "temp": 22.3},
        {"time": "13:30", "moisture": 66, "temp": 22.1},
        {"time": "13:00", "moisture": 65, "temp": 21.9}
      ]
    },
    {
      "id": "MS002",
      "name": "North Field Sensor 2",
      "zone": "North Field Zone B",
      "crop": "Tomatoes",
      "currentMoisture": 42,
      "optimalRange": {"min": 60, "max": 80},
      "status": "Low",
      "statusColor": warningColor,
      "batteryLevel": 72,
      "lastReading": "2024-06-15 14:25",
      "depth": "15 cm",
      "soilType": "Loamy",
      "temperature": 24.1,
      "conductivity": 1.1,
      "ph": 6.9,
      "location": {"lat": 40.7130, "lng": -74.0065},
      "isOnline": true,
      "alertThreshold": {"low": 50, "high": 85},
      "calibrationDate": "2024-05-01",
      "readings": [
        {"time": "14:25", "moisture": 42, "temp": 24.1},
        {"time": "13:55", "moisture": 44, "temp": 23.8},
        {"time": "13:25", "moisture": 46, "temp": 23.5},
        {"time": "12:55", "moisture": 48, "temp": 23.2}
      ]
    },
    {
      "id": "MS003",
      "name": "South Field Sensor 1",
      "zone": "South Field Zone A",
      "crop": "Bell Peppers",
      "currentMoisture": 55,
      "optimalRange": {"min": 50, "max": 70},
      "status": "Normal",
      "statusColor": successColor,
      "batteryLevel": 93,
      "lastReading": "2024-06-15 14:35",
      "depth": "20 cm",
      "soilType": "Sandy Loam",
      "temperature": 26.3,
      "conductivity": 0.9,
      "ph": 7.1,
      "location": {"lat": 40.7125, "lng": -74.0070},
      "isOnline": true,
      "alertThreshold": {"low": 40, "high": 75},
      "calibrationDate": "2024-04-15",
      "readings": [
        {"time": "14:35", "moisture": 55, "temp": 26.3},
        {"time": "14:05", "moisture": 56, "temp": 26.0},
        {"time": "13:35", "moisture": 57, "temp": 25.8},
        {"time": "13:05", "moisture": 58, "temp": 25.5}
      ]
    },
    {
      "id": "MS004",
      "name": "Greenhouse Sensor 1",
      "zone": "Greenhouse A",
      "crop": "Cucumbers",
      "currentMoisture": 88,
      "optimalRange": {"min": 70, "max": 85},
      "status": "High",
      "statusColor": warningColor,
      "batteryLevel": 67,
      "lastReading": "2024-06-15 14:40",
      "depth": "10 cm",
      "soilType": "Potting Mix",
      "temperature": 28.7,
      "conductivity": 1.8,
      "ph": 6.5,
      "location": {"lat": 40.7132, "lng": -74.0055},
      "isOnline": true,
      "alertThreshold": {"low": 65, "high": 90},
      "calibrationDate": "2024-05-20",
      "readings": [
        {"time": "14:40", "moisture": 88, "temp": 28.7},
        {"time": "14:10", "moisture": 89, "temp": 28.5},
        {"time": "13:40", "moisture": 90, "temp": 28.2},
        {"time": "13:10", "moisture": 92, "temp": 28.0}
      ]
    },
    {
      "id": "MS005",
      "name": "East Field Sensor 1",
      "zone": "East Field",
      "crop": "Rice",
      "currentMoisture": 95,
      "optimalRange": {"min": 90, "max": 100},
      "status": "Normal",
      "statusColor": successColor,
      "batteryLevel": 45,
      "lastReading": "2024-06-15 14:20",
      "depth": "5 cm",
      "soilType": "Clay",
      "temperature": 19.8,
      "conductivity": 2.1,
      "ph": 7.3,
      "location": {"lat": 40.7135, "lng": -74.0075},
      "isOnline": true,
      "alertThreshold": {"low": 85, "high": 100},
      "calibrationDate": "2024-03-10",
      "readings": [
        {"time": "14:20", "moisture": 95, "temp": 19.8},
        {"time": "13:50", "moisture": 96, "temp": 19.6},
        {"time": "13:20", "moisture": 97, "temp": 19.4},
        {"time": "12:50", "moisture": 98, "temp": 19.2}
      ]
    },
    {
      "id": "MS006",
      "name": "Herb Garden Sensor 1",
      "zone": "Herb Garden",
      "crop": "Mixed Herbs",
      "currentMoisture": 25,
      "optimalRange": {"min": 40, "max": 60},
      "status": "Critical",
      "statusColor": dangerColor,
      "batteryLevel": 12,
      "lastReading": "2024-06-15 13:45",
      "depth": "12 cm",
      "soilType": "Sandy",
      "temperature": 31.2,
      "conductivity": 0.6,
      "ph": 7.8,
      "location": {"lat": 40.7140, "lng": -74.0050},
      "isOnline": false,
      "alertThreshold": {"low": 35, "high": 65},
      "calibrationDate": "2024-02-20",
      "readings": [
        {"time": "13:45", "moisture": 25, "temp": 31.2},
        {"time": "13:15", "moisture": 27, "temp": 30.8},
        {"time": "12:45", "moisture": 29, "temp": 30.5},
        {"time": "12:15", "moisture": 31, "temp": 30.1}
      ]
    }
  ];

  List<Map<String, dynamic>> zoneFilters = [
    {"label": "All Zones", "value": "all"},
    {"label": "North Field Zone A", "value": "North Field Zone A"},
    {"label": "North Field Zone B", "value": "North Field Zone B"},
    {"label": "South Field Zone A", "value": "South Field Zone A"},
    {"label": "Greenhouse A", "value": "Greenhouse A"},
    {"label": "East Field", "value": "East Field"},
    {"label": "Herb Garden", "value": "Herb Garden"}
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Low", "value": "Low"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"}
  ];

  List<Map<String, dynamic>> getFilteredSensors() {
    List<Map<String, dynamic>> filtered = moistureSensors;
    
    if (selectedZone != "all") {
      filtered = filtered.where((sensor) => sensor["zone"] == selectedZone).toList();
    }
    
    if (selectedStatus > 0) {
      String statusFilter = statusFilters[selectedStatus]["value"];
      filtered = filtered.where((sensor) => sensor["status"] == statusFilter).toList();
    }
    
    if (showAlertsOnly) {
      filtered = filtered.where((sensor) => sensor["status"] != "Normal").toList();
    }
    
    return filtered;
  }

  Color getMoistureColor(int moisture, Map<String, dynamic> optimalRange) {
    int min = optimalRange["min"];
    int max = optimalRange["max"];
    
    if (moisture < min - 10) return dangerColor;
    if (moisture < min) return warningColor;
    if (moisture > max + 10) return dangerColor;
    if (moisture > max) return warningColor;
    return successColor;
  }

  Color getBatteryColor(int batteryLevel) {
    if (batteryLevel > 60) return successColor;
    if (batteryLevel > 30) return warningColor;
    return dangerColor;
  }

  IconData getBatteryIcon(int batteryLevel) {
    if (batteryLevel > 80) return Icons.battery_full;
    if (batteryLevel > 60) return Icons.battery_5_bar;
    if (batteryLevel > 40) return Icons.battery_3_bar;
    if (batteryLevel > 20) return Icons.battery_2_bar;
    return Icons.battery_1_bar;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSensors = getFilteredSensors();
    int onlineSensors = moistureSensors.where((s) => s["isOnline"] as bool).length;
    int alertSensors = moistureSensors.where((s) => s["status"] != "Normal").length;
    double avgMoisture = moistureSensors.map((s) => s["currentMoisture"] as int).reduce((a, b) => a + b) / moistureSensors.length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Moisture Sensors"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Show sensor map
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Sensor analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sensor Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.sensors,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$onlineSensors/${moistureSensors.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$alertSensors",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Alerts",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${avgMoisture.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Avg Moisture",
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
            
            SizedBox(height: spLg),
            
            // Filters Section
            Text(
              "Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Zone",
                    items: zoneFilters,
                    value: selectedZone,
                    onChanged: (value, label) {
                      selectedZone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusFilters,
                    value: statusFilters[selectedStatus]["value"],
                    onChanged: (value, label) {
                      selectedStatus = statusFilters.indexWhere((item) => item["value"] == value);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            QSwitch(
              items: [
                {
                  "label": "Show Alerts Only",
                  "value": true,
                  "checked": showAlertsOnly,
                }
              ],
              value: [
                if (showAlertsOnly)
                  {
                    "label": "Show Alerts Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showAlertsOnly = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Sensors List
            Text(
              "Soil Moisture Sensors (${filteredSensors.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredSensors.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      color: disabledBoldColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No sensors found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "No moisture sensors match your current filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredSensors.map((sensor) {
                Color moistureColor = getMoistureColor(sensor["currentMoisture"] as int, sensor["optimalRange"]);
                Color batteryColor = getBatteryColor(sensor["batteryLevel"] as int);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: sensor["statusColor"] as Color,
                      ),
                    ),
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (sensor["statusColor"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.sensors,
                        color: sensor["statusColor"] as Color,
                        size: 24,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${sensor["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${sensor["zone"]} • ${sensor["crop"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (sensor["statusColor"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${sensor["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: sensor["statusColor"] as Color,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  getBatteryIcon(sensor["batteryLevel"] as int),
                                  size: 12,
                                  color: batteryColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${sensor["batteryLevel"]}%",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: batteryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            // Moisture Level Display
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Moisture: ${sensor["currentMoisture"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: moistureColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Optimal: ${sensor["optimalRange"]["min"]}-${sensor["optimalRange"]["max"]}%",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (sensor["currentMoisture"] as int) / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: moistureColor,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              (sensor["isOnline"] as bool) ? Icons.wifi : Icons.wifi_off,
                              size: 14,
                              color: (sensor["isOnline"] as bool) ? successColor : dangerColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              (sensor["isOnline"] as bool) ? "Online" : "Offline",
                              style: TextStyle(
                                fontSize: 12,
                                color: (sensor["isOnline"] as bool) ? successColor : dangerColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Last: ${sensor["lastReading"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sensor Metrics
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.thermostat,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${sensor["temperature"]}°C",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Temperature",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
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
                                      color: Colors.blue.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.science,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${sensor["ph"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "pH Level",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
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
                                      color: Colors.green.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.electrical_services,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${sensor["conductivity"]} mS/cm",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "EC",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Sensor Details
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sensor Information",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Depth",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${sensor["depth"]}",
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              "Soil Type",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${sensor["soilType"]}",
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              "Calibration",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${sensor["calibrationDate"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Alert Thresholds
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: warningColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Alert Thresholds",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Low: ${sensor["alertThreshold"]["low"]}% • High: ${sensor["alertThreshold"]["high"]}%",
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
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Recent Readings
                            Text(
                              "Recent Readings:",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(sensor["readings"] as List).take(3).map((reading) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(5),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "${reading["time"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${reading["moisture"]}%",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${reading["temp"]}°C",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Calibrate",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Calibrate sensor
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: QButton(
                                    label: "History",
                                    size: bs.sm,
                                    onPressed: () {
                                      // View full history
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: QButton(
                                    label: "Settings",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Sensor settings
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
                );
              }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new moisture sensor
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
