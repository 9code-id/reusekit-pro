import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBodyMeasurementsView extends StatefulWidget {
  const FwaBodyMeasurementsView({super.key});

  @override
  State<FwaBodyMeasurementsView> createState() => _FwaBodyMeasurementsViewState();
}

class _FwaBodyMeasurementsViewState extends State<FwaBodyMeasurementsView> {
  String weight = "";
  String height = "";
  String bodyFat = "";
  String muscleMass = "";
  String visceralFat = "";
  String waterPercentage = "";
  String boneMass = "";
  String bmr = "";
  String chest = "";
  String waist = "";
  String hips = "";
  String biceps = "";
  String thighs = "";
  String neck = "";
  String forearms = "";
  String calves = "";

  final List<Map<String, dynamic>> measurementHistory = [
    {
      "date": "2024-06-15",
      "weight": 75.5,
      "bodyFat": 15.2,
      "muscleMass": 42.8,
      "change": 2.1,
    },
    {
      "date": "2024-06-08",
      "weight": 73.4,
      "bodyFat": 16.1,
      "muscleMass": 41.2,
      "change": -1.3,
    },
    {
      "date": "2024-06-01",
      "weight": 74.7,
      "bodyFat": 16.8,
      "muscleMass": 40.5,
      "change": 0.8,
    },
    {
      "date": "2024-05-25",
      "weight": 73.9,
      "bodyFat": 17.2,
      "muscleMass": 39.9,
      "change": -2.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Measurements"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo('measurement_history')
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              // navigateTo('progress_photos')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuickStats(),
            _buildBasicMeasurements(),
            _buildBodyComposition(),
            _buildBodyDimensions(),
            _buildMeasurementHistory(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Current Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatItem("BMI", "23.4", "Normal", Colors.green),
              _buildStatItem("Body Fat", "15.2%", "-0.9%", Colors.blue),
              _buildStatItem("Muscle", "42.8kg", "+1.6kg", Colors.orange),
              _buildStatItem("Water", "61.5%", "+0.3%", Colors.cyan),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, String change, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                change.startsWith('+') ? Icons.trending_up : Icons.trending_down,
                size: 12,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                change,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicMeasurements() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Measurements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Weight (kg)",
                  value: weight,
                  onChanged: (value) {
                    weight = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Height (cm)",
                  value: height,
                  onChanged: (value) {
                    height = value;
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

  Widget _buildBodyComposition() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.donut_small, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Body Composition",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Body Fat (%)",
                  value: bodyFat,
                  onChanged: (value) {
                    bodyFat = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Muscle Mass (kg)",
                  value: muscleMass,
                  onChanged: (value) {
                    muscleMass = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Visceral Fat",
                  value: visceralFat,
                  onChanged: (value) {
                    visceralFat = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Water (%)",
                  value: waterPercentage,
                  onChanged: (value) {
                    waterPercentage = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Bone Mass (kg)",
                  value: boneMass,
                  onChanged: (value) {
                    boneMass = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "BMR (kcal)",
                  value: bmr,
                  onChanged: (value) {
                    bmr = value;
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

  Widget _buildBodyDimensions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.straighten, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Body Dimensions (cm)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Chest",
                  value: chest,
                  onChanged: (value) {
                    chest = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Waist",
                  value: waist,
                  onChanged: (value) {
                    waist = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Hips",
                  value: hips,
                  onChanged: (value) {
                    hips = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Biceps",
                  value: biceps,
                  onChanged: (value) {
                    biceps = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Thighs",
                  value: thighs,
                  onChanged: (value) {
                    thighs = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Neck",
                  value: neck,
                  onChanged: (value) {
                    neck = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Forearms",
                  value: forearms,
                  onChanged: (value) {
                    forearms = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Calves",
                  value: calves,
                  onChanged: (value) {
                    calves = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementHistory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Recent Measurements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // navigateTo('measurement_history')
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...measurementHistory.take(3).map((measurement) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 3,
                    color: (measurement["change"] as double) > 0 
                        ? successColor 
                        : dangerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${DateTime.parse(measurement["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${(measurement["weight"] as double).toStringAsFixed(1)}kg",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "BF: ${(measurement["bodyFat"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
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
                      color: (measurement["change"] as double) > 0 
                          ? successColor.withAlpha(20)
                          : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          (measurement["change"] as double) > 0 
                              ? Icons.trending_up 
                              : Icons.trending_down,
                          size: 16,
                          color: (measurement["change"] as double) > 0 
                              ? successColor 
                              : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(measurement["change"] as double) > 0 ? '+' : ''}${(measurement["change"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (measurement["change"] as double) > 0 
                                ? successColor 
                                : dangerColor,
                          ),
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
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        QButton(
          label: "Save Measurements",
          icon: Icons.save,
          size: bs.md,
          onPressed: () {
            // Save measurements logic
            ss("Measurements saved successfully");
          },
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Take Progress Photo",
                icon: Icons.camera_alt,
                size: bs.sm,
                onPressed: () {
                  // navigateTo('progress_photos')
                },
              ),
            ),
            Expanded(
              child: QButton(
                label: "View Trends",
                icon: Icons.trending_up,
                size: bs.sm,
                onPressed: () {
                  // navigateTo('measurement_trends')
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
