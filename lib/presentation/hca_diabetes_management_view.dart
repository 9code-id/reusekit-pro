import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDiabetesManagementView extends StatefulWidget {
  const HcaDiabetesManagementView({super.key});

  @override
  State<HcaDiabetesManagementView> createState() => _HcaDiabetesManagementViewState();
}

class _HcaDiabetesManagementViewState extends State<HcaDiabetesManagementView> {
  int currentTab = 0;
  String selectedPeriod = "Today";
  List<String> periods = ["Today", "Week", "Month"];

  List<Map<String, dynamic>> glucoseReadings = [
    {
      "id": 1,
      "value": 120,
      "time": "07:30 AM",
      "date": "2024-06-19",
      "type": "Fasting",
      "status": "Normal",
      "notes": "Before breakfast"
    },
    {
      "id": 2,
      "value": 160,
      "time": "09:45 AM",
      "date": "2024-06-19",
      "type": "Post-meal",
      "status": "High",
      "notes": "2 hours after breakfast"
    },
    {
      "id": 3,
      "value": 95,
      "time": "12:30 PM",
      "date": "2024-06-19",
      "type": "Pre-meal",
      "status": "Normal",
      "notes": "Before lunch"
    },
    {
      "id": 4,
      "value": 140,
      "time": "02:45 PM",
      "date": "2024-06-19",
      "type": "Post-meal",
      "status": "Borderline",
      "notes": "2 hours after lunch"
    },
    {
      "id": 5,
      "value": 110,
      "time": "06:00 PM",
      "date": "2024-06-19",
      "type": "Pre-meal",
      "status": "Normal",
      "notes": "Before dinner"
    }
  ];

  List<Map<String, dynamic>> medications = [
    {
      "id": 1,
      "name": "Metformin",
      "dosage": "500mg",
      "frequency": "Twice daily",
      "time": ["08:00 AM", "08:00 PM"],
      "taken": [true, false],
      "color": primaryColor,
      "notes": "Take with meals"
    },
    {
      "id": 2,
      "name": "Insulin Glargine",
      "dosage": "20 units",
      "frequency": "Once daily",
      "time": ["10:00 PM"],
      "taken": [false],
      "color": successColor,
      "notes": "Long-acting insulin"
    },
    {
      "id": 3,
      "name": "Glipizide",
      "dosage": "5mg",
      "frequency": "Once daily",
      "time": ["07:30 AM"],
      "taken": [true],
      "color": warningColor,
      "notes": "Take 30 minutes before breakfast"
    }
  ];

  List<Map<String, dynamic>> mealPlan = [
    {
      "meal": "Breakfast",
      "time": "07:30 AM",
      "carbs": 45,
      "calories": 350,
      "items": ["Oatmeal with berries", "Greek yogurt", "Green tea"],
      "logged": true
    },
    {
      "meal": "Mid-Morning Snack",
      "time": "10:00 AM",
      "carbs": 15,
      "calories": 120,
      "items": ["Apple slices", "Almonds"],
      "logged": true
    },
    {
      "meal": "Lunch",
      "time": "12:30 PM",
      "carbs": 60,
      "calories": 450,
      "items": ["Grilled chicken salad", "Brown rice", "Vegetables"],
      "logged": true
    },
    {
      "meal": "Afternoon Snack",
      "time": "03:00 PM",
      "carbs": 20,
      "calories": 150,
      "items": ["Whole grain crackers", "Hummus"],
      "logged": false
    },
    {
      "meal": "Dinner",
      "time": "06:30 PM",
      "carbs": 55,
      "calories": 420,
      "items": ["Salmon", "Quinoa", "Steamed broccoli"],
      "logged": false
    }
  ];

  Color _getGlucoseStatusColor(String status) {
    switch (status) {
      case "Normal":
        return successColor;
      case "High":
        return dangerColor;
      case "Low":
        return warningColor;
      case "Borderline":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getGlucoseStatusText(int value) {
    if (value < 70) return "Low";
    if (value <= 140) return "Normal";
    if (value <= 180) return "Borderline";
    return "High";
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Diabetes Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Glucose", icon: Icon(Icons.water_drop)),
        Tab(text: "Medications", icon: Icon(Icons.medication)),
        Tab(text: "Meals", icon: Icon(Icons.restaurant)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Summary
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
                      "Today's Summary",
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
                                "125",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Avg Glucose (mg/dL)",
                                style: TextStyle(
                                  fontSize: 12,
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
                                "195",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Total Carbs (g)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(220),
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
                              Icons.water_drop,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Glucose Readings",
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
                          "${glucoseReadings.length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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

              // Recent Glucose Readings
              Text(
                "Recent Glucose Readings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...glucoseReadings.take(3).map((reading) {
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
                        color: _getGlucoseStatusColor(reading["status"]),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getGlucoseStatusColor(reading["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.water_drop,
                          color: _getGlucoseStatusColor(reading["status"]),
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
                                  "${reading["value"]} mg/dL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getGlucoseStatusColor(reading["status"]).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${reading["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getGlucoseStatusColor(reading["status"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${reading["type"]} • ${reading["time"]}",
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

        // Glucose Tab
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
                    ss("New glucose reading added");
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

              // Glucose Readings List
              Text(
                "Glucose Readings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...glucoseReadings.map((reading) {
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
                        color: _getGlucoseStatusColor(reading["status"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getGlucoseStatusColor(reading["status"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.water_drop,
                              color: _getGlucoseStatusColor(reading["status"]),
                              size: 24,
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
                                      "${reading["value"]} mg/dL",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getGlucoseStatusColor(reading["status"]).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${reading["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getGlucoseStatusColor(reading["status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${reading["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                            color: _getGlucoseStatusColor(reading["status"]).withAlpha(20),
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
                            padding: EdgeInsets.all(spSm),
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
                          SizedBox(width: spSm),
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
                          padding: EdgeInsets.all(spSm),
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
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: 14,
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

        // Meals Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Summary
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
                    Text(
                      "Today's Nutrition",
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${mealPlan.fold(0, (sum, meal) => meal["logged"] as bool ? sum + (meal["carbs"] as int) : sum)}g",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Carbs",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "${mealPlan.fold(0, (sum, meal) => meal["logged"] as bool ? sum + (meal["calories"] as int) : sum)}",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Calories",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "${mealPlan.where((meal) => meal["logged"] as bool).length}/${mealPlan.length}",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Meals Logged",
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
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Meal Plan
              Text(
                "Today's Meal Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...mealPlan.map((meal) {
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
                        color: meal["logged"] as bool ? successColor : warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: meal["logged"] as bool 
                                  ? successColor.withAlpha(30) 
                                  : warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              meal["logged"] as bool ? Icons.check_circle : Icons.restaurant,
                              color: meal["logged"] as bool ? successColor : warningColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${meal["meal"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${meal["time"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                "${meal["carbs"]}g carbs",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${meal["calories"]} cal",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Meal Items
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: meal["logged"] as bool 
                              ? successColor.withAlpha(20) 
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Items:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(meal["items"] as List).map((item) {
                              return Text(
                                "• $item",
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
                          label: meal["logged"] as bool ? "Edit Meal" : "Log Meal",
                          size: bs.sm,
                          onPressed: () {
                            if (!(meal["logged"] as bool)) {
                              meal["logged"] = true;
                              setState(() {});
                              ss("Meal logged successfully!");
                            }
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
