import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBmiCalculatorView extends StatefulWidget {
  const FwaBmiCalculatorView({Key? key}) : super(key: key);

  @override
  State<FwaBmiCalculatorView> createState() => _FwaBmiCalculatorViewState();
}

class _FwaBmiCalculatorViewState extends State<FwaBmiCalculatorView> {
  String height = "175";
  String weight = "70";
  String age = "25";
  String selectedGender = "Male";
  String selectedUnit = "Metric";
  
  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
  ];

  List<Map<String, dynamic>> unitOptions = [
    {"label": "Metric (cm/kg)", "value": "Metric"},
    {"label": "Imperial (ft/lbs)", "value": "Imperial"},
  ];

  List<Map<String, dynamic>> bmiCategories = [
    {
      "category": "Underweight",
      "range": "< 18.5",
      "color": Colors.blue,
      "description": "Below normal weight",
      "recommendations": [
        "Increase caloric intake",
        "Focus on nutrient-dense foods",
        "Consider consulting a nutritionist"
      ]
    },
    {
      "category": "Normal weight",
      "range": "18.5 - 24.9",
      "color": Colors.green,
      "description": "Healthy weight range",
      "recommendations": [
        "Maintain current lifestyle",
        "Regular exercise",
        "Balanced nutrition"
      ]
    },
    {
      "category": "Overweight",
      "range": "25.0 - 29.9",
      "color": Colors.orange,
      "description": "Above normal weight",
      "recommendations": [
        "Increase physical activity",
        "Monitor portion sizes",
        "Focus on whole foods"
      ]
    },
    {
      "category": "Obese",
      "range": "≥ 30.0",
      "color": Colors.red,
      "description": "High health risk",
      "recommendations": [
        "Consult healthcare provider",
        "Structured weight loss plan",
        "Regular medical monitoring"
      ]
    }
  ];

  List<Map<String, dynamic>> bmiHistory = [
    {
      "date": "2024-12-01",
      "bmi": 23.8,
      "weight": 72.5,
      "height": 175,
    },
    {
      "date": "2024-12-08",
      "bmi": 23.5,
      "weight": 71.8,
      "height": 175,
    },
    {
      "date": "2024-12-15",
      "bmi": 23.2,
      "weight": 71.2,
      "height": 175,
    },
    {
      "date": "2024-12-22",
      "bmi": 22.9,
      "weight": 70.5,
      "height": 175,
    },
    {
      "date": "2024-12-29",
      "bmi": 22.9,
      "weight": 70.0,
      "height": 175,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double bmi = _calculateBMI();
    String bmiCategory = _getBMICategory(bmi);
    Color bmiColor = _getBMIColor(bmi);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to BMI history
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showBMIInfoDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BMI Result Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bmiColor, bmiColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.monitor_weight,
                    color: Colors.white,
                    size: 48,
                  ),
                  Text(
                    "Your BMI",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    bmiCategory,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _getBMIDescription(bmi),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),

            // Input Form
            Text(
              "Enter Your Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QDropdownField(
              label: "Unit System",
              items: unitOptions,
              value: selectedUnit,
              onChanged: (value, label) {
                selectedUnit = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Gender",
                    items: genderOptions,
                    value: selectedGender,
                    onChanged: (value, label) {
                      selectedGender = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: "Age",
                    value: age,
                    onChanged: (value) {
                      age = value;
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
                    label: selectedUnit == "Metric" ? "Height (cm)" : "Height (ft)",
                    value: height,
                    onChanged: (value) {
                      height = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: selectedUnit == "Metric" ? "Weight (kg)" : "Weight (lbs)",
                    value: weight,
                    onChanged: (value) {
                      weight = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Ideal Weight Range
            Container(
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
                    "Ideal Weight Range",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildIdealWeightRange(),
                ],
              ),
            ),

            // BMI Categories
            Text(
              "BMI Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: bmiCategories.map((category) {
                bool isCurrent = category["category"] == bmiCategory;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isCurrent ? (category["color"] as Color).withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isCurrent ? Border.all(color: category["color"] as Color, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: category["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${category["category"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${category["range"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: category["color"] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${category["description"]}",
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
                      if (isCurrent) ...[
                        SizedBox(height: spSm),
                        Text(
                          "Recommendations:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (category["recommendations"] as List<String>).map((rec) {
                            return Padding(
                              padding: EdgeInsets.only(left: spSm, top: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      color: category["color"] as Color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      rec,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // BMI History Chart
            Container(
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
                    "BMI Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBMIPoint("W1", 23.8),
                        _buildBMIPoint("W2", 23.5),
                        _buildBMIPoint("W3", 23.2),
                        _buildBMIPoint("W4", 22.9),
                        _buildBMIPoint("W5", 22.9),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BMI History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BMI History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to full history
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

            Column(
              spacing: spSm,
              children: bmiHistory.reversed.take(3).map((entry) {
                double entryBMI = (entry["bmi"] as num).toDouble();
                String entryCategory = _getBMICategory(entryBMI);
                Color entryColor = _getBMIColor(entryBMI);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: entryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.monitor_weight,
                          color: entryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.parse(entry["date"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(entry["weight"] as num).toDouble().toStringAsFixed(1)} kg • ${(entry["height"] as num)} cm",
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
                            entryBMI.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: entryColor,
                            ),
                          ),
                          Text(
                            entryCategory,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Save BMI Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Current BMI",
                size: bs.md,
                onPressed: () {
                  _saveBMI();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateBMI() {
    double heightValue = double.tryParse(height) ?? 175;
    double weightValue = double.tryParse(weight) ?? 70;
    
    if (selectedUnit == "Imperial") {
      // Convert feet to meters and pounds to kg
      heightValue = heightValue * 0.3048; // feet to meters
      weightValue = weightValue * 0.453592; // pounds to kg
    } else {
      heightValue = heightValue / 100; // cm to meters
    }
    
    if (heightValue <= 0) return 0;
    return weightValue / (heightValue * heightValue);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25.0) return "Normal weight";
    if (bmi < 30.0) return "Overweight";
    return "Obese";
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25.0) return Colors.green;
    if (bmi < 30.0) return Colors.orange;
    return Colors.red;
  }

  String _getBMIDescription(double bmi) {
    if (bmi < 18.5) return "Below normal weight range";
    if (bmi < 25.0) return "Healthy weight range";
    if (bmi < 30.0) return "Above normal weight range";
    return "High health risk range";
  }

  Widget _buildIdealWeightRange() {
    double heightValue = double.tryParse(height) ?? 175;
    if (selectedUnit == "Imperial") {
      heightValue = heightValue * 0.3048; // feet to meters
    } else {
      heightValue = heightValue / 100; // cm to meters
    }
    
    double minWeight = 18.5 * heightValue * heightValue;
    double maxWeight = 24.9 * heightValue * heightValue;
    
    if (selectedUnit == "Imperial") {
      minWeight = minWeight * 2.20462; // kg to pounds
      maxWeight = maxWeight * 2.20462;
    }
    
    String unit = selectedUnit == "Metric" ? "kg" : "lbs";
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Ideal weight range:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} $unit",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBMIPoint(String label, double bmi) {
    double normalizedHeight = ((bmi - 18) / 15 * 120).clamp(20, 120);
    Color pointColor = _getBMIColor(bmi);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: normalizedHeight,
          width: 3,
          decoration: BoxDecoration(
            color: pointColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _saveBMI() {
    double currentBMI = _calculateBMI();
    
    // Add to history
    Map<String, dynamic> newEntry = {
      "date": DateTime.now().toIso8601String(),
      "bmi": currentBMI,
      "weight": double.tryParse(weight) ?? 70,
      "height": double.tryParse(height) ?? 175,
    };
    
    bmiHistory.add(newEntry);
    setState(() {});
    
    ss("BMI saved to history!");
  }

  void _showBMIInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("About BMI"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Body Mass Index (BMI) is a measure of body fat based on height and weight that applies to adult men and women.",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: spSm),
              Text(
                "BMI Formula:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("BMI = weight (kg) / height² (m²)"),
              SizedBox(height: spSm),
              Text(
                "Limitations:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("• Doesn't distinguish between muscle and fat\n• May not be accurate for athletes\n• Doesn't account for age, gender, or ethnicity\n• Should be used with other health indicators"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
