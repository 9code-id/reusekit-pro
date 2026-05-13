import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaRecordTemperaturesView extends StatefulWidget {
  const WcaRecordTemperaturesView({super.key});

  @override
  State<WcaRecordTemperaturesView> createState() => _WcaRecordTemperaturesViewState();
}

class _WcaRecordTemperaturesViewState extends State<WcaRecordTemperaturesView> {
  String selectedTimeframe = "All Time";
  String selectedLocation = "Global";
  String selectedRecordType = "All Records";

  List<String> timeframes = ["All Time", "This Year", "Last Decade", "Since 1900", "Custom Period"];
  List<String> locations = ["Global", "North America", "Europe", "Asia", "Australia", "South America", "Africa"];
  List<String> recordTypes = ["All Records", "Highest Temperatures", "Lowest Temperatures", "Daily Records", "Monthly Records"];

  List<Map<String, dynamic>> recordTemperatures = [
    {
      "location": "Death Valley, USA",
      "temperature": 54.4,
      "type": "Highest",
      "date": "July 10, 1913",
      "verified": true,
      "description": "Hottest temperature ever reliably recorded on Earth",
      "coordinates": "36.5°N, 116.9°W",
      "elevation": "-86m",
      "weather_station": "Furnace Creek",
      "icon": Icons.whatshot,
      "severity": "extreme",
    },
    {
      "location": "Antarctica",
      "temperature": -89.2,
      "type": "Lowest",
      "date": "July 21, 1983",
      "verified": true,
      "description": "Coldest temperature ever recorded on Earth",
      "coordinates": "78.5°S, 106.8°E",
      "elevation": "3488m",
      "weather_station": "Vostok Station",
      "icon": Icons.ac_unit,
      "severity": "extreme",
    },
    {
      "location": "Phoenix, USA",
      "temperature": 50.0,
      "type": "Highest",
      "date": "June 26, 1990",
      "verified": true,
      "description": "Highest temperature recorded in Phoenix",
      "coordinates": "33.4°N, 112.1°W",
      "elevation": "331m",
      "weather_station": "Sky Harbor Airport",
      "icon": Icons.whatshot,
      "severity": "severe",
    },
    {
      "location": "Fairbanks, Alaska",
      "temperature": -62.2,
      "type": "Lowest",
      "date": "January 9, 1934",
      "verified": true,
      "description": "Coldest temperature recorded in Alaska",
      "coordinates": "64.8°N, 147.9°W",
      "elevation": "134m",
      "weather_station": "Fairbanks International",
      "icon": Icons.ac_unit,
      "severity": "severe",
    },
    {
      "location": "Al Aziziyah, Libya",
      "temperature": 58.0,
      "type": "Highest",
      "date": "September 13, 1922",
      "verified": false,
      "description": "Previously considered highest, now disputed",
      "coordinates": "32.5°N, 13.0°E",
      "elevation": "111m",
      "weather_station": "Al Aziziyah Station",
      "icon": Icons.whatshot,
      "severity": "extreme",
    },
    {
      "location": "Verkhoyansk, Russia",
      "temperature": -67.8,
      "type": "Lowest",
      "date": "February 5, 1892",
      "verified": true,
      "description": "One of the coldest permanently inhabited places",
      "coordinates": "67.6°N, 133.4°E",
      "elevation": "137m",
      "weather_station": "Verkhoyansk Station",
      "icon": Icons.ac_unit,
      "severity": "extreme",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record Temperatures"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              _shareRecords();
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
            _buildRecordSummary(),
            _buildFilterSection(),
            _buildRecordsList(),
            _buildRecordComparison(),
            _buildClimateImpact(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordSummary() {
    double highestTemp = recordTemperatures
        .where((r) => r["type"] == "Highest")
        .map((r) => r["temperature"] as double)
        .reduce((a, b) => a > b ? a : b);
    
    double lowestTemp = recordTemperatures
        .where((r) => r["type"] == "Lowest")
        .map((r) => r["temperature"] as double)
        .reduce((a, b) => a < b ? a : b);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            dangerColor.withAlpha(20),
            primaryColor.withAlpha(20),
            infoColor.withAlpha(20),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.thermostat,
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Global Temperature Records",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(50)),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.whatshot,
                        color: dangerColor,
                        size: 32,
                      ),
                      Text(
                        "${highestTemp.toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Highest Recorded",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Death Valley, 1913",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.ac_unit,
                        color: infoColor,
                        size: 32,
                      ),
                      Text(
                        "${lowestTemp.toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Lowest Recorded",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Antarctica, 1983",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
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
            "Filter Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Time Period",
            items: timeframes.map((time) => {
              "label": time,
              "value": time,
            }).toList(),
            value: selectedTimeframe,
            onChanged: (value, label) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Region",
                  items: locations.map((location) => {
                    "label": location,
                    "value": location,
                  }).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Record Type",
                  items: recordTypes.map((type) => {
                    "label": type,
                    "value": type,
                  }).toList(),
                  value: selectedRecordType,
                  onChanged: (value, label) {
                    selectedRecordType = value;
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

  Widget _buildRecordsList() {
    List<Map<String, dynamic>> filteredRecords = _getFilteredRecords();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Temperature Records",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredRecords.length} records",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...filteredRecords.map((record) => _buildRecordItem(record)),
      ],
    );
  }

  Widget _buildRecordItem(Map<String, dynamic> record) {
    bool isHot = record["type"] == "Highest";
    Color recordColor = isHot ? dangerColor : infoColor;
    bool isVerified = record["verified"] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: recordColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: recordColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    record["icon"] as IconData,
                    color: recordColor,
                    size: 32,
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
                              "${record["location"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (isVerified)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 12,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "VERIFIED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${(record["temperature"] as double).toStringAsFixed(1)}°C",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: recordColor,
                        ),
                      ),
                      Text(
                        "${record["description"]}",
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
              color: recordColor.withAlpha(10),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Date: ${record["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${record["coordinates"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.terrain,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Elevation: ${record["elevation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.device_hub,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${record["weather_station"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        _showRecordDetails(record);
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.map,
                      size: bs.sm,
                      onPressed: () {
                        _showOnMap(record);
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

  Widget _buildRecordComparison() {
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
                Icons.compare,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Record Comparison",
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
                _buildComparisonRow("Temperature Range", "143.6°C", "From Antarctica to Death Valley"),
                _buildComparisonRow("Hottest Continent", "Africa/Australia", "Average peak temperatures"),
                _buildComparisonRow("Coldest Continent", "Antarctica", "Permanent ice coverage"),
                _buildComparisonRow("Most Records", "USA", "27 extreme temperature records"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String metric, String value, String description) {
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

  Widget _buildClimateImpact() {
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
          Row(
            children: [
              Icon(
                Icons.eco,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Climate Impact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Text(
            "Understanding extreme temperature records helps us monitor climate change patterns and prepare for future weather events. These records serve as important benchmarks for scientific research.",
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
                  label: "Climate Trends",
                  size: bs.sm,
                  onPressed: () {
                    _showClimateTrends();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Research Data",
                  size: bs.sm,
                  onPressed: () {
                    _showResearchData();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredRecords() {
    List<Map<String, dynamic>> filtered = List.from(recordTemperatures);

    if (selectedRecordType == "Highest Temperatures") {
      filtered = filtered.where((r) => r["type"] == "Highest").toList();
    } else if (selectedRecordType == "Lowest Temperatures") {
      filtered = filtered.where((r) => r["type"] == "Lowest").toList();
    }

    return filtered;
  }

  void _shareRecords() {
    ss("Temperature records shared successfully");
  }

  void _showRecordDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${record["location"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Temperature: ${(record["temperature"] as double).toStringAsFixed(1)}°C",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Date: ${record["date"]}"),
            Text("Coordinates: ${record["coordinates"]}"),
            Text("Elevation: ${record["elevation"]}"),
            Text("Weather Station: ${record["weather_station"]}"),
            Text("Verification: ${record["verified"] ? "Verified" : "Disputed"}"),
            SizedBox(height: spSm),
            Text("${record["description"]}"),
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

  void _showOnMap(Map<String, dynamic> record) {
    ss("Showing ${record["location"]} on map");
  }

  void _showClimateTrends() {
    ss("Opening climate trends analysis");
  }

  void _showResearchData() {
    ss("Opening research data portal");
  }
}
