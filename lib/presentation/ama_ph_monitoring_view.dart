import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaPhMonitoringView extends StatefulWidget {
  const AmaPhMonitoringView({super.key});

  @override
  State<AmaPhMonitoringView> createState() => _AmaPhMonitoringViewState();
}

class _AmaPhMonitoringViewState extends State<AmaPhMonitoringView> {
  String selectedField = "field_1";
  String selectedTimeRange = "7_days";
  
  List<Map<String, dynamic>> fields = [
    {
      "label": "Rice Field A",
      "value": "field_1",
    },
    {
      "label": "Rice Field B",
      "value": "field_2",
    },
    {
      "label": "Corn Field A",
      "value": "field_3",
    },
    {
      "label": "Vegetable Garden",
      "value": "field_4",
    },
  ];

  List<Map<String, dynamic>> timeRanges = [
    {
      "label": "Last 7 Days",
      "value": "7_days",
    },
    {
      "label": "Last 30 Days",
      "value": "30_days",
    },
    {
      "label": "Last 3 Months",
      "value": "3_months",
    },
    {
      "label": "Last Year",
      "value": "1_year",
    },
  ];

  Map<String, dynamic> currentPh = {
    "value": 6.2,
    "status": "Optimal",
    "trend": "stable",
    "lastUpdated": "2024-06-15 14:30",
  };

  List<Map<String, dynamic>> phReadings = [
    {
      "date": "2024-06-15",
      "time": "14:30",
      "ph": 6.2,
      "zone": "Zone A",
      "sensor": "Sensor 1",
    },
    {
      "date": "2024-06-15",
      "time": "12:00",
      "ph": 6.1,
      "zone": "Zone B",
      "sensor": "Sensor 2",
    },
    {
      "date": "2024-06-15",
      "time": "09:30",
      "ph": 6.3,
      "zone": "Zone C",
      "sensor": "Sensor 3",
    },
    {
      "date": "2024-06-14",
      "time": "16:45",
      "ph": 6.0,
      "zone": "Zone A",
      "sensor": "Sensor 1",
    },
    {
      "date": "2024-06-14",
      "time": "14:15",
      "ph": 6.4,
      "zone": "Zone B",
      "sensor": "Sensor 2",
    },
  ];

  List<Map<String, dynamic>> phTrends = [
    {
      "day": "Mon",
      "ph": 6.1,
      "status": "optimal",
    },
    {
      "day": "Tue",
      "ph": 6.2,
      "status": "optimal",
    },
    {
      "day": "Wed",
      "ph": 5.8,
      "status": "low",
    },
    {
      "day": "Thu",
      "ph": 6.0,
      "status": "optimal",
    },
    {
      "day": "Fri",
      "ph": 6.2,
      "status": "optimal",
    },
    {
      "day": "Sat",
      "ph": 6.3,
      "status": "optimal",
    },
    {
      "day": "Sun",
      "ph": 6.2,
      "status": "optimal",
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "type": "Lime Application",
      "description": "Apply lime to increase pH in Zone C",
      "priority": "medium",
      "estimatedCost": 250.0,
      "timeframe": "Within 3 days",
      "icon": Icons.science,
    },
    {
      "type": "Organic Matter",
      "description": "Add compost to improve soil buffer capacity",
      "priority": "low",
      "estimatedCost": 180.0,
      "timeframe": "Within 1 week",
      "icon": Icons.eco,
    },
    {
      "type": "Sulfur Treatment",
      "description": "Apply sulfur to reduce pH in Zone B",
      "priority": "low",
      "estimatedCost": 120.0,
      "timeframe": "Within 2 weeks",
      "icon": Icons.opacity,
    },
  ];

  List<Map<String, dynamic>> sensors = [
    {
      "id": "PH-001",
      "zone": "Zone A",
      "status": "active",
      "battery": 85,
      "lastReading": "6.2",
      "lastUpdate": "2 min ago",
    },
    {
      "id": "PH-002",
      "zone": "Zone B",
      "status": "active",
      "battery": 72,
      "lastReading": "6.1",
      "lastUpdate": "5 min ago",
    },
    {
      "id": "PH-003",
      "zone": "Zone C",
      "status": "warning",
      "battery": 45,
      "lastReading": "6.3",
      "lastUpdate": "1 hour ago",
    },
    {
      "id": "PH-004",
      "zone": "Zone D",
      "status": "offline",
      "battery": 0,
      "lastReading": "N/A",
      "lastUpdate": "2 days ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pH Monitoring"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(),
            _buildCurrentStatus(),
            _buildPhTrends(),
            _buildRecentReadings(),
            _buildRecommendations(),
            _buildSensorStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Select Field",
                  items: fields,
                  value: selectedField,
                  onChanged: (value, label) {
                    selectedField = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRanges,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Apply Filter",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.md,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStatus() {
    Color statusColor = _getPhStatusColor(currentPh["value"] as double);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Current pH Level",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${currentPh["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${(currentPh["value"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            "pH",
                            style: TextStyle(
                              fontSize: 16,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Last updated: ${currentPh["lastUpdated"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  spacing: spSm,
                  children: [
                    _buildPhRange("Acidic", "< 5.5", dangerColor, (currentPh["value"] as double) < 5.5),
                    _buildPhRange("Slightly Acidic", "5.5 - 6.0", warningColor, 
                        (currentPh["value"] as double) >= 5.5 && (currentPh["value"] as double) < 6.0),
                    _buildPhRange("Optimal", "6.0 - 7.0", successColor, 
                        (currentPh["value"] as double) >= 6.0 && (currentPh["value"] as double) <= 7.0),
                    _buildPhRange("Slightly Alkaline", "7.0 - 8.0", warningColor, 
                        (currentPh["value"] as double) > 7.0 && (currentPh["value"] as double) <= 8.0),
                    _buildPhRange("Alkaline", "> 8.0", dangerColor, (currentPh["value"] as double) > 8.0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhRange(String label, String range, Color color, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: isActive ? color.withAlpha(30) : Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isActive ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? color : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? color : disabledBoldColor,
              ),
            ),
          ),
          Text(
            range,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? color : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhTrends() {
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
          Text(
            "pH Trends (Last 7 Days)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: phTrends.map((trend) {
                double phValue = trend["ph"] as double;
                double height = (phValue / 8.0) * 150; // Normalize to 150px max height
                Color barColor = _getPhStatusColor(phValue);
                
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          phValue.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: barColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          width: double.infinity,
                          height: height,
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trend["day"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildLegend("Optimal", successColor),
              SizedBox(width: spSm),
              _buildLegend("Low", warningColor),
              SizedBox(width: spSm),
              _buildLegend("Critical", dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
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

  Widget _buildRecentReadings() {
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
              Text(
                "Recent Readings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: phReadings.take(3).map((reading) {
              Color statusColor = _getPhStatusColor(reading["ph"] as double);
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: statusColor.withAlpha(100),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${(reading["ph"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${reading["zone"]} - ${reading["sensor"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${reading["date"]} ${reading["time"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.trending_up,
                      color: statusColor,
                      size: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
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
          Text(
            "pH Management Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: recommendations.map((rec) {
              Color priorityColor = rec["priority"] == "high" 
                  ? dangerColor 
                  : rec["priority"] == "medium" 
                      ? warningColor 
                      : infoColor;
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: priorityColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          rec["icon"] as IconData,
                          color: priorityColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${rec["type"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${rec["priority"]}".toUpperCase(),
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${rec["description"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Cost: \$${((rec["estimatedCost"] as double).toDouble()).currency}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "${rec["timeframe"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
    );
  }

  Widget _buildSensorStatus() {
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
              Text(
                "Sensor Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Calibrate",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: sensors.map((sensor) {
              Color statusColor = sensor["status"] == "active" 
                  ? successColor 
                  : sensor["status"] == "warning" 
                      ? warningColor 
                      : dangerColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: statusColor.withAlpha(100),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sensors,
                          color: statusColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${sensor["id"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${sensor["zone"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "pH: ${sensor["lastReading"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.battery_std,
                          color: statusColor,
                          size: 16,
                        ),
                        Text(
                          "${sensor["battery"]}%",
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Updated: ${sensor["lastUpdate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getPhStatusColor(double ph) {
    if (ph < 5.5 || ph > 8.0) {
      return dangerColor;
    } else if (ph < 6.0 || ph > 7.0) {
      return warningColor;
    } else {
      return successColor;
    }
  }
}
