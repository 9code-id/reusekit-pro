import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHypertensionView extends StatefulWidget {
  const HcaHypertensionView({super.key});

  @override
  State<HcaHypertensionView> createState() => _HcaHypertensionViewState();
}

class _HcaHypertensionViewState extends State<HcaHypertensionView> {
  int currentTab = 0;
  String selectedPeriod = "Today";
  List<String> periods = ["Today", "Week", "Month"];

  List<Map<String, dynamic>> bpReadings = [
    {
      "id": 1,
      "systolic": 128,
      "diastolic": 85,
      "pulse": 72,
      "time": "07:30 AM",
      "date": "2024-06-19",
      "category": "High Normal",
      "notes": "After morning walk",
      "position": "Sitting"
    },
    {
      "id": 2,
      "systolic": 142,
      "diastolic": 92,
      "pulse": 78,
      "time": "02:15 PM",
      "date": "2024-06-19",
      "category": "Stage 1 High",
      "notes": "After lunch, feeling stressed",
      "position": "Sitting"
    },
    {
      "id": 3,
      "systolic": 135,
      "diastolic": 88,
      "pulse": 75,
      "time": "08:00 PM",
      "date": "2024-06-19",
      "category": "High Normal",
      "notes": "Before dinner",
      "position": "Lying"
    },
    {
      "id": 4,
      "systolic": 118,
      "diastolic": 76,
      "pulse": 68,
      "time": "06:45 AM",
      "date": "2024-06-18",
      "category": "Normal",
      "notes": "Morning reading, well rested",
      "position": "Sitting"
    },
    {
      "id": 5,
      "systolic": 125,
      "diastolic": 82,
      "pulse": 70,
      "time": "09:30 PM",
      "date": "2024-06-18",
      "category": "Normal",
      "notes": "Before bed",
      "position": "Sitting"
    }
  ];

  List<Map<String, dynamic>> medications = [
    {
      "id": 1,
      "name": "Lisinopril",
      "dosage": "10mg",
      "frequency": "Once daily",
      "time": ["08:00 AM"],
      "taken": [true],
      "type": "ACE Inhibitor",
      "color": primaryColor,
      "notes": "Take on empty stomach"
    },
    {
      "id": 2,
      "name": "Amlodipine",
      "dosage": "5mg",
      "frequency": "Once daily",
      "time": ["08:00 PM"],
      "taken": [false],
      "type": "Calcium Channel Blocker",
      "color": successColor,
      "notes": "Take with food"
    },
    {
      "id": 3,
      "name": "Hydrochlorothiazide",
      "dosage": "25mg",
      "frequency": "Once daily",
      "time": ["07:00 AM"],
      "taken": [true],
      "type": "Diuretic",
      "color": warningColor,
      "notes": "Take in morning to avoid nighttime urination"
    }
  ];

  List<Map<String, dynamic>> lifestyle = [
    {
      "category": "Exercise",
      "target": "30 min daily",
      "completed": ["Mon", "Tue", "Wed", "Thu"],
      "total": 7,
      "icon": Icons.directions_run,
      "color": successColor,
      "tips": ["Brisk walking", "Swimming", "Cycling"]
    },
    {
      "category": "Sodium Intake",
      "target": "< 2300mg daily",
      "current": "1850mg",
      "status": "Good",
      "icon": Icons.restaurant,
      "color": primaryColor,
      "tips": ["Avoid processed foods", "Read food labels", "Cook at home"]
    },
    {
      "category": "Weight Management",
      "target": "Maintain BMI 18.5-24.9",
      "current": "BMI 26.2",
      "status": "Overweight",
      "icon": Icons.monitor_weight,
      "color": warningColor,
      "tips": ["Portion control", "Regular exercise", "Balanced diet"]
    },
    {
      "category": "Stress Management",
      "target": "10 min meditation daily",
      "completed": ["Mon", "Wed", "Fri"],
      "total": 7,
      "icon": Icons.self_improvement,
      "color": infoColor,
      "tips": ["Deep breathing", "Meditation", "Yoga"]
    }
  ];

  Color _getBPCategoryColor(String category) {
    switch (category) {
      case "Normal":
        return successColor;
      case "High Normal":
        return warningColor;
      case "Stage 1 High":
        return dangerColor;
      case "Stage 2 High":
        return dangerColor;
      case "Hypertensive Crisis":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getBPCategory(int systolic, int diastolic) {
    if (systolic < 120 && diastolic < 80) return "Normal";
    if (systolic < 130 && diastolic < 85) return "High Normal";
    if (systolic < 140 || diastolic < 90) return "Stage 1 High";
    if (systolic < 160 || diastolic < 100) return "Stage 2 High";
    return "Hypertensive Crisis";
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Hypertension Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "BP Readings", icon: Icon(Icons.favorite)),
        Tab(text: "Medications", icon: Icon(Icons.medication)),
        Tab(text: "Lifestyle", icon: Icon(Icons.fitness_center)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Latest Reading Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latest Reading",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${bpReadings[0]["systolic"]}/${bpReadings[0]["diastolic"]}",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "mmHg",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(220),
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
                                "${bpReadings[0]["pulse"]}",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "BPM",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${bpReadings[0]["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Quick Stats
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  Container(
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
                            Icon(
                              Icons.favorite,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "BP Readings",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${bpReadings.where((reading) => DateTime.parse(reading["date"]).day == DateTime.now().day).length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            Icon(
                              Icons.medication,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Medications",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${medications.fold(0, (sum, med) => sum + (med["taken"] as List).where((taken) => taken as bool).length)}/${medications.fold(0, (sum, med) => sum + (med["taken"] as List).length)}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Taken Today",
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

              SizedBox(height: spLg),

              // Recent Readings
              Text(
                "Recent Blood Pressure",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...bpReadings.take(3).map((reading) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getBPCategoryColor(reading["category"]),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getBPCategoryColor(reading["category"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: _getBPCategoryColor(reading["category"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${reading["systolic"]}/${reading["diastolic"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${reading["pulse"]} BPM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getBPCategoryColor(reading["category"]).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${reading["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getBPCategoryColor(reading["category"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
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
                      ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spSm),

              // View All Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View All Readings",
                  size: bs.sm,
                  onPressed: () {
                    currentTab = 1;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),

        // BP Readings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Reading Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add New Reading",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    ss("New BP reading added");
                  },
                ),
              ),

              SizedBox(height: spLg),

              // Period Filter
              QCategoryPicker(
                items: periods.map((period) => {
                  "label": period,
                  "value": period,
                }).toList(),
                value: selectedPeriod,
                onChanged: (index, label, value, item) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // BP Readings List
              Text(
                "Blood Pressure Readings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...bpReadings.map((reading) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getBPCategoryColor(reading["category"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: _getBPCategoryColor(reading["category"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: _getBPCategoryColor(reading["category"]),
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${reading["pulse"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _getBPCategoryColor(reading["category"]),
                                  ),
                                ),
                                Text(
                                  "BPM",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getBPCategoryColor(reading["category"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${reading["systolic"]}/${reading["diastolic"]} mmHg",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getBPCategoryColor(reading["category"]).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${reading["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getBPCategoryColor(reading["category"]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${reading["position"]} position",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${reading["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(reading["date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (reading["notes"] != null && reading["notes"].toString().isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getBPCategoryColor(reading["category"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${reading["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Medications Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Schedule
              Text(
                "Today's Medication Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...medications.map((medication) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: medication["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: (medication["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.medication,
                              color: medication["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${medication["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${medication["dosage"]} • ${medication["frequency"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (medication["color"] as Color).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${medication["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: medication["color"] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Scheduled Times
                      ...(medication["time"] as List).asMap().entries.map((entry) {
                        int index = entry.key;
                        String time = entry.value;
                        bool taken = (medication["taken"] as List)[index] as bool;

                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: taken 
                                ? successColor.withAlpha(20)
                                : (medication["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                taken ? Icons.check_circle : Icons.schedule,
                                color: taken ? successColor : medication["color"] as Color,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: taken ? successColor : primaryColor,
                                  ),
                                ),
                              ),
                              QButton(
                                label: taken ? "Taken" : "Mark Taken",
                                size: bs.sm,
                                onPressed: () {
                                  if (!taken) {
                                    (medication["taken"] as List)[index] = true;
                                    setState(() {});
                                    ss("Medication marked as taken");
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      if (medication["notes"] != null && medication["notes"].toString().isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (medication["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${medication["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Add Medication Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add New Medication",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    ss("New medication added");
                  },
                ),
              ),
            ],
          ),
        ),

        // Lifestyle Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lifestyle Factors
              Text(
                "Lifestyle Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...lifestyle.map((factor) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: factor["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: (factor["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              factor["icon"] as IconData,
                              color: factor["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${factor["category"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Target: ${factor["target"]}",
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

                      SizedBox(height: spMd),

                      // Progress or Status
                      if (factor["completed"] != null) ...[
                        // Exercise and Stress Management
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "This Week",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${(factor["completed"] as List).length}/${factor["total"]} days",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: factor["color"] as Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: (factor["completed"] as List).length / (factor["total"] as int),
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(factor["color"] as Color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        // Week Days
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map((day) {
                            bool completed = (factor["completed"] as List).contains(day);
                            return Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: completed 
                                    ? factor["color"] as Color
                                    : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  day.substring(0, 1),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ] else ...[
                        // Sodium and Weight
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Status",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${factor["current"]}",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: factor["color"] as Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (factor["status"] != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spMd,
                                  vertical: spSm,
                                ),
                                decoration: BoxDecoration(
                                  color: (factor["color"] as Color).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${factor["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: factor["color"] as Color,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],

                      SizedBox(height: spMd),

                      // Tips
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (factor["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tips:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(factor["tips"] as List).map((tip) {
                              return Text(
                                "• $tip",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: factor["completed"] != null ? "Log Activity" : "Update Status",
                          size: bs.sm,
                          onPressed: () {
                            ss("${factor["category"]} updated!");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
