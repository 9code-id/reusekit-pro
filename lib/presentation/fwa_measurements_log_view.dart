import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMeasurementsLogView extends StatefulWidget {
  const FwaMeasurementsLogView({super.key});

  @override
  State<FwaMeasurementsLogView> createState() => _FwaMeasurementsLogViewState();
}

class _FwaMeasurementsLogViewState extends State<FwaMeasurementsLogView> {
  List<Map<String, dynamic>> measurements = [
    {
      "date": "2024-03-15",
      "weight": 72.5,
      "bodyFat": 18.5,
      "muscleMass": 65.2,
      "waist": 82.0,
      "chest": 98.0,
      "bicep": 35.0,
      "thigh": 58.0,
      "notes": "Feeling stronger after last week's training",
    },
    {
      "date": "2024-03-08",
      "weight": 73.1,
      "bodyFat": 18.8,
      "muscleMass": 64.8,
      "waist": 83.0,
      "chest": 97.5,
      "bicep": 34.5,
      "thigh": 57.5,
      "notes": "Increased cardio this week",
    },
    {
      "date": "2024-03-01",
      "weight": 73.8,
      "bodyFat": 19.2,
      "muscleMass": 64.1,
      "waist": 84.0,
      "chest": 97.0,
      "bicep": 34.0,
      "thigh": 57.0,
      "notes": "Starting new nutrition plan",
    },
    {
      "date": "2024-02-22",
      "weight": 74.2,
      "bodyFat": 19.8,
      "muscleMass": 63.5,
      "waist": 85.0,
      "chest": 96.5,
      "bicep": 33.5,
      "thigh": 56.5,
      "notes": "Need to focus more on diet",
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "This Week", "This Month", "Last 3 Months"];

  bool showBodyComposition = true;
  bool showBodyMeasurements = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measurements Log"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showAnalytics();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressSummary(),
            SizedBox(height: spMd),
            _buildFilterTabs(),
            SizedBox(height: spMd),
            _buildMeasurementsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewMeasurement();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildProgressSummary() {
    Map<String, dynamic> latestMeasurement = measurements.first;
    Map<String, dynamic> previousMeasurement = measurements[1];

    double weightChange = (latestMeasurement["weight"] as double) - (previousMeasurement["weight"] as double);
    double bodyFatChange = (latestMeasurement["bodyFat"] as double) - (previousMeasurement["bodyFat"] as double);
    double muscleChange = (latestMeasurement["muscleMass"] as double) - (previousMeasurement["muscleMass"] as double);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress Summary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Last 7 days comparison",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildProgressStat(
                  "Weight", 
                  "${weightChange >= 0 ? '+' : ''}${weightChange.toStringAsFixed(1)}kg",
                  weightChange < 0 ? successColor : warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildProgressStat(
                  "Body Fat", 
                  "${bodyFatChange >= 0 ? '+' : ''}${bodyFatChange.toStringAsFixed(1)}%",
                  bodyFatChange < 0 ? successColor : dangerColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildProgressStat(
                  "Muscle", 
                  "${muscleChange >= 0 ? '+' : ''}${muscleChange.toStringAsFixed(1)}kg",
                  muscleChange > 0 ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
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
            "Display Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: showBodyComposition,
                      onChanged: (value) {
                        setState(() {
                          showBodyComposition = value ?? true;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Body Composition",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: showBodyMeasurements,
                      onChanged: (value) {
                        setState(() {
                          showBodyMeasurements = value ?? true;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Body Measurements",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: filterOptions.map((filter) {
              bool isSelected = selectedFilter == filter;
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Measurement History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: measurements.map((measurement) {
            return _buildMeasurementCard(measurement);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMeasurementCard(Map<String, dynamic> measurement) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.straighten,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateTime.parse("${measurement["date"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (measurement["notes"] != null && (measurement["notes"] as String).isNotEmpty)
                      Text(
                        "${measurement["notes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: disabledBoldColor),
                onPressed: () {
                  _editMeasurement(measurement);
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (showBodyComposition) ...[
            _buildMeasurementSection("Body Composition", [
              {"label": "Weight", "value": "${measurement["weight"]}kg"},
              {"label": "Body Fat", "value": "${measurement["bodyFat"]}%"},
              {"label": "Muscle Mass", "value": "${measurement["muscleMass"]}kg"},
            ]),
            SizedBox(height: spMd),
          ],
          if (showBodyMeasurements) ...[
            _buildMeasurementSection("Body Measurements", [
              {"label": "Waist", "value": "${measurement["waist"]}cm"},
              {"label": "Chest", "value": "${measurement["chest"]}cm"},
              {"label": "Bicep", "value": "${measurement["bicep"]}cm"},
              {"label": "Thigh", "value": "${measurement["thigh"]}cm"},
            ]),
          ],
        ],
      ),
    );
  }

  Widget _buildMeasurementSection(String title, List<Map<String, String>> values) {
    return Column(
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
        Wrap(
          spacing: spMd,
          runSpacing: spSm,
          children: values.map((item) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${item["label"]}:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${item["value"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _addNewMeasurement() {
    // Add new measurement logic
  }

  void _editMeasurement(Map<String, dynamic> measurement) {
    // Edit measurement logic
  }

  void _showFilterOptions() {
    // Show filter options
  }

  void _showAnalytics() {
    // Show analytics view
  }
}
