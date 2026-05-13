import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaExtremeWeatherView extends StatefulWidget {
  const WcaExtremeWeatherView({super.key});

  @override
  State<WcaExtremeWeatherView> createState() => _WcaExtremeWeatherViewState();
}

class _WcaExtremeWeatherViewState extends State<WcaExtremeWeatherView> {
  String selectedCategory = "All Events";
  String selectedSeverity = "All Levels";
  String selectedTimeRange = "Last 30 Days";

  List<String> categories = ["All Events", "Hurricanes", "Tornadoes", "Floods", "Droughts", "Heatwaves", "Blizzards", "Wildfires"];
  List<String> severityLevels = ["All Levels", "Extreme", "Severe", "Moderate", "Minor"];
  List<String> timeRanges = ["Last 7 Days", "Last 30 Days", "Last 3 Months", "This Year", "Custom Range"];

  List<Map<String, dynamic>> extremeEvents = [
    {
      "id": "hurricane_ida_2021",
      "title": "Hurricane Ida",
      "type": "Hurricane",
      "severity": "Extreme",
      "location": "Louisiana, USA",
      "date": "August 29, 2021",
      "duration": "5 days",
      "windSpeed": 250,
      "pressure": 929,
      "category": "Category 4",
      "casualties": 95,
      "damage": 75000000000,
      "affected": 2500000,
      "description": "One of the most destructive hurricanes to hit Louisiana, causing widespread power outages and flooding.",
      "icon": Icons.cyclone,
      "color": dangerColor,
      "coordinates": "29.2°N, 89.4°W",
      "status": "Historical",
    },
    {
      "id": "texas_freeze_2021",
      "title": "Texas Winter Storm Uri",
      "type": "Blizzard",
      "severity": "Extreme",
      "location": "Texas, USA",
      "date": "February 13, 2021",
      "duration": "7 days",
      "temperature": -19,
      "snowfall": 38,
      "casualties": 246,
      "damage": 195000000000,
      "affected": 4500000,
      "description": "Historic winter storm that caused widespread power grid failures and water shortages across Texas.",
      "icon": Icons.ac_unit,
      "color": infoColor,
      "coordinates": "31.9°N, 99.9°W",
      "status": "Historical",
    },
    {
      "id": "australia_bushfires_2020",
      "title": "Australian Bushfires",
      "type": "Wildfires",
      "severity": "Extreme",
      "location": "Australia",
      "date": "September 2019",
      "duration": "210 days",
      "area": 186000,
      "casualties": 34,
      "damage": 103000000000,
      "affected": 3000000000,
      "description": "Unprecedented bushfire season that burned massive areas and killed billions of animals.",
      "icon": Icons.local_fire_department,
      "color": warningColor,
      "coordinates": "25.0°S, 133.0°E",
      "status": "Historical",
    },
    {
      "id": "europe_heatwave_2023",
      "title": "European Heatwave",
      "type": "Heatwave",
      "severity": "Severe",
      "location": "Southern Europe",
      "date": "July 18, 2023",
      "duration": "14 days",
      "temperature": 48.8,
      "casualties": 62000,
      "affected": 300000000,
      "description": "Record-breaking temperatures across Southern Europe with significant health impacts.",
      "icon": Icons.whatshot,
      "color": dangerColor,
      "coordinates": "42.0°N, 12.5°E",
      "status": "Recent",
    },
    {
      "id": "pakistan_floods_2022",
      "title": "Pakistan Monsoon Floods",
      "type": "Floods",
      "severity": "Extreme",
      "location": "Pakistan",
      "date": "June 14, 2022",
      "duration": "120 days",
      "rainfall": 1739,
      "casualties": 1739,
      "damage": 30000000000,
      "affected": 33000000,
      "description": "Catastrophic flooding affecting one-third of the country due to unprecedented monsoon rains.",
      "icon": Icons.water,
      "color": primaryColor,
      "coordinates": "30.0°N, 70.0°E",
      "status": "Historical",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extreme Weather Events"),
        actions: [
          QButton(
            icon: Icons.warning,
            size: bs.sm,
            onPressed: () {
              _showActiveAlerts();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildAlertBanner(),
            _buildStatsSummary(),
            _buildFilterSection(),
            _buildEventsList(),
            _buildImpactAnalysis(),
            _buildPreparednessGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertBanner() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dangerColor.withAlpha(20), warningColor.withAlpha(20)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.warning_amber,
              color: dangerColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Active Weather Alerts",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "2 severe weather warnings in your area. Tap to view details.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "View",
            size: bs.sm,
            onPressed: () {
              _showActiveAlerts();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Global Extreme Weather Statistics",
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
            minItemWidth: 120,
            children: [
              _buildStatCard("Events This Year", "147", Icons.event, dangerColor),
              _buildStatCard("Lives Affected", "2.1B", Icons.people, warningColor),
              _buildStatCard("Economic Loss", "\$280B", Icons.attach_money, primaryColor),
              _buildStatCard("Countries Impacted", "89", Icons.public, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
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
            "Filter Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Event Category",
            items: categories.map((category) => {
              "label": category,
              "value": category,
            }).toList(),
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Severity Level",
                  items: severityLevels.map((level) => {
                    "label": level,
                    "value": level,
                  }).toList(),
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRanges.map((range) => {
                    "label": range,
                    "value": range,
                  }).toList(),
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    List<Map<String, dynamic>> filteredEvents = _getFilteredEvents();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Recent Extreme Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredEvents.length} events",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...filteredEvents.map((event) => _buildEventItem(event)),
      ],
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    Color eventColor = event["color"] as Color;
    String severity = event["severity"] as String;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: eventColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: eventColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    event["icon"] as IconData,
                    color: eventColor,
                    size: 28,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getSeverityColor(severity).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              severity.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getSeverityColor(severity),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: eventColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${event["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: eventColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${event["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: eventColor.withAlpha(10),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 100,
                  children: [
                    _buildEventStat("Date", "${event["date"]}", Icons.calendar_today),
                    _buildEventStat("Duration", "${event["duration"]}", Icons.timer),
                    _buildEventStat("Casualties", "${event["casualties"]}", Icons.healing),
                    _buildEventStat("Affected", "${_formatNumber(event["affected"] as int)}", Icons.people),
                  ],
                ),
                Row(
                  children: [
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        _showEventDetails(event);
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        _shareEvent(event);
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.map,
                      size: bs.sm,
                      onPressed: () {
                        _showOnMap(event);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
        ),
      ],
    );
  }

  Widget _buildImpactAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Global Impact Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildImpactRow("Economic Losses", "+35%", "Compared to last year"),
                _buildImpactRow("Frequency of Events", "+12%", "Extreme events increasing"),
                _buildImpactRow("Population at Risk", "3.9B", "Living in high-risk areas"),
                _buildImpactRow("Recovery Time", "18 months", "Average for severe events"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactRow(String metric, String value, String description) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                metric,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: spSm,
            vertical: spXs,
          ),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreparednessGuide() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Emergency Preparedness",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Text(
            "Stay prepared for extreme weather events with these essential resources and emergency planning guides.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Emergency Kit",
                  size: bs.sm,
                  onPressed: () {
                    _showEmergencyKit();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Safety Guide",
                  size: bs.sm,
                  onPressed: () {
                    _showSafetyGuide();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredEvents() {
    List<Map<String, dynamic>> filtered = List.from(extremeEvents);

    if (selectedCategory != "All Events") {
      filtered = filtered.where((e) => e["type"] == selectedCategory).toList();
    }

    if (selectedSeverity != "All Levels") {
      filtered = filtered.where((e) => e["severity"] == selectedSeverity).toList();
    }

    return filtered;
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Extreme":
        return dangerColor;
      case "Severe":
        return warningColor;
      case "Moderate":
        return primaryColor;
      case "Minor":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000000) {
      return "${(number / 1000000000).toStringAsFixed(1)}B";
    } else if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return "$number";
  }

  void _showActiveAlerts() {
    ss("Showing active weather alerts");
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${event["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text("Type: ${event["type"]}"),
            Text("Severity: ${event["severity"]}"),
            Text("Location: ${event["location"]}"),
            Text("Date: ${event["date"]}"),
            Text("Duration: ${event["duration"]}"),
            Text("Casualties: ${event["casualties"]}"),
            Text("People Affected: ${_formatNumber(event["affected"] as int)}"),
            SizedBox(height: spSm),
            Text("${event["description"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _shareEvent(Map<String, dynamic> event) {
    ss("Sharing ${event["title"]} event details");
  }

  void _showOnMap(Map<String, dynamic> event) {
    ss("Showing ${event["location"]} on map");
  }

  void _showEmergencyKit() {
    ss("Opening emergency preparedness kit guide");
  }

  void _showSafetyGuide() {
    ss("Opening extreme weather safety guide");
  }
}
