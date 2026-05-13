import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaBloodPressureView extends StatefulWidget {
  const MhaBloodPressureView({super.key});

  @override
  State<MhaBloodPressureView> createState() => _MhaBloodPressureViewState();
}

class _MhaBloodPressureViewState extends State<MhaBloodPressureView> {
  List<Map<String, dynamic>> bloodPressureReadings = [
    {
      "id": 1,
      "systolic": 120,
      "diastolic": 80,
      "pulse": 72,
      "date": "2024-12-15",
      "time": "08:30",
      "category": "Normal",
      "color": "green",
      "notes": "Feeling good, morning reading",
    },
    {
      "id": 2,
      "systolic": 135,
      "diastolic": 85,
      "pulse": 78,
      "date": "2024-12-14",
      "time": "19:45",
      "category": "Stage 1 High",
      "color": "orange",
      "notes": "After work stress",
    },
    {
      "id": 3,
      "systolic": 118,
      "diastolic": 78,
      "pulse": 68,
      "date": "2024-12-13",
      "time": "07:15",
      "category": "Normal",
      "color": "green",
      "notes": "Relaxed morning reading",
    },
    {
      "id": 4,
      "systolic": 142,
      "diastolic": 92,
      "pulse": 85,
      "date": "2024-12-12",
      "time": "21:30",
      "category": "Stage 1 High",
      "color": "orange",
      "notes": "Late night, had coffee",
    },
    {
      "id": 5,
      "systolic": 115,
      "diastolic": 75,
      "pulse": 65,
      "date": "2024-12-11",
      "time": "06:45",
      "category": "Normal",
      "color": "green",
      "notes": "Perfect morning reading",
    },
  ];

  String systolic = "";
  String diastolic = "";
  String pulse = "";
  String notes = "";
  String selectedTimeframe = "7 days";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Pressure"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuickStats(),
            _buildAddReading(),
            _buildTimeframeFilter(),
            _buildTrendChart(),
            _buildReadingsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReadingModal();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuickStats() {
    var avgSystolic = (bloodPressureReadings.map((r) => r["systolic"] as int).reduce((a, b) => a + b) / bloodPressureReadings.length).round();
    var avgDiastolic = (bloodPressureReadings.map((r) => r["diastolic"] as int).reduce((a, b) => a + b) / bloodPressureReadings.length).round();
    var avgPulse = (bloodPressureReadings.map((r) => r["pulse"] as int).reduce((a, b) => a + b) / bloodPressureReadings.length).round();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Average Readings (7 Days)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Systolic",
                  "$avgSystolic",
                  "mmHg",
                  primaryColor,
                  Icons.arrow_upward,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Diastolic",
                  "$avgDiastolic",
                  "mmHg",
                  infoColor,
                  Icons.arrow_downward,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Pulse",
                  "$avgPulse",
                  "bpm",
                  successColor,
                  Icons.favorite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
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

  Widget _buildAddReading() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Add Reading",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Systolic",
                  value: systolic,
                  onChanged: (value) {
                    systolic = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "/",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Diastolic",
                  value: diastolic,
                  onChanged: (value) {
                    diastolic = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Pulse",
                  value: pulse,
                  onChanged: (value) {
                    pulse = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Notes (Optional)",
            value: notes,
            hint: "Add any relevant notes...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Reading",
              size: bs.md,
              onPressed: () {
                _addReading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeFilter() {
    return QDropdownField(
      label: "View Period",
      items: [
        {"label": "7 days", "value": "7 days"},
        {"label": "30 days", "value": "30 days"},
        {"label": "90 days", "value": "90 days"},
        {"label": "1 year", "value": "1 year"},
      ],
      value: selectedTimeframe,
      onChanged: (value, label) {
        selectedTimeframe = value;
        setState(() {});
      },
    );
  }

  Widget _buildTrendChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Blood Pressure Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Stack(
              children: [
                // Chart visualization placeholder
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart,
                        size: 48,
                        color: primaryColor.withAlpha(100),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Blood Pressure Chart",
                        style: TextStyle(
                          color: primaryColor.withAlpha(150),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Systolic/Diastolic Trends",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Chart data points
                ...List.generate(5, (index) {
                  return Positioned(
                    left: 40 + (index * 50.0),
                    bottom: 30 + (index * 20.0),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Systolic",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: infoColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Diastolic",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReadingsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Recent Readings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...bloodPressureReadings.map((reading) => _buildReadingItem(reading)).toList(),
      ],
    );
  }

  Widget _buildReadingItem(Map<String, dynamic> reading) {
    Color categoryColor = reading["color"] == "green" 
        ? successColor 
        : reading["color"] == "orange" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${reading["systolic"]}/${reading["diastolic"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "mmHg",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${reading["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite, size: 16, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "${reading["pulse"]} bpm",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${reading["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${reading["time"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (reading["notes"].toString().isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${reading["notes"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Delete",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Are you sure you want to delete this reading?");
                    if (isConfirmed) {
                      bloodPressureReadings.removeWhere((r) => r["id"] == reading["id"]);
                      setState(() {});
                      ss("Reading deleted successfully");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddReadingModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                "Add Blood Pressure Reading",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Systolic",
                      value: systolic,
                      onChanged: (value) {
                        systolic = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Diastolic",
                      value: diastolic,
                      onChanged: (value) {
                        diastolic = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QNumberField(
                label: "Pulse (BPM)",
                value: pulse,
                onChanged: (value) {
                  pulse = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Notes",
                value: notes,
                hint: "Any relevant notes about this reading...",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Reading",
                  size: bs.md,
                  onPressed: () {
                    _addReading();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addReading() {
    if (systolic.isNotEmpty && diastolic.isNotEmpty && pulse.isNotEmpty) {
      int systolicValue = int.tryParse(systolic) ?? 0;
      int diastolicValue = int.tryParse(diastolic) ?? 0;
      
      String category = "Normal";
      String color = "green";
      
      if (systolicValue >= 140 || diastolicValue >= 90) {
        category = "Stage 1 High";
        color = "orange";
      } else if (systolicValue >= 160 || diastolicValue >= 100) {
        category = "Stage 2 High";
        color = "red";
      } else if (systolicValue < 90 || diastolicValue < 60) {
        category = "Low";
        color = "orange";
      }

      bloodPressureReadings.insert(0, {
        "id": DateTime.now().millisecondsSinceEpoch,
        "systolic": systolicValue,
        "diastolic": diastolicValue,
        "pulse": int.tryParse(pulse) ?? 0,
        "date": DateTime.now().toString().substring(0, 10),
        "time": TimeOfDay.now().format(context),
        "category": category,
        "color": color,
        "notes": notes,
      });

      systolic = "";
      diastolic = "";
      pulse = "";
      notes = "";
      setState(() {});
      ss("Blood pressure reading added successfully");
    } else {
      se("Please fill in all required fields");
    }
  }
}
