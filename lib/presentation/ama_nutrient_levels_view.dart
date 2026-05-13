import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaNutrientLevelsView extends StatefulWidget {
  const AmaNutrientLevelsView({super.key});

  @override
  State<AmaNutrientLevelsView> createState() => _AmaNutrientLevelsViewState();
}

class _AmaNutrientLevelsViewState extends State<AmaNutrientLevelsView> {
  List<Map<String, dynamic>> fieldData = [
    {
      "fieldName": "North Field",
      "area": "25 acres",
      "cropType": "Corn",
      "lastTested": "2024-06-10",
      "nutrients": {
        "nitrogen": {"value": 45, "optimal": 50, "unit": "ppm", "status": "low"},
        "phosphorus": {"value": 32, "optimal": 30, "unit": "ppm", "status": "good"},
        "potassium": {"value": 28, "optimal": 35, "unit": "ppm", "status": "low"},
        "calcium": {"value": 850, "optimal": 800, "unit": "ppm", "status": "good"},
        "magnesium": {"value": 120, "optimal": 100, "unit": "ppm", "status": "high"},
        "sulfur": {"value": 15, "optimal": 20, "unit": "ppm", "status": "low"},
      },
      "deficiencies": ["Nitrogen", "Potassium", "Sulfur"],
      "recommendations": [
        "Apply nitrogen fertilizer at 25 lbs/acre",
        "Increase potassium with 15 lbs/acre of K2O",
        "Add sulfur supplement"
      ]
    },
    {
      "fieldName": "South Field",
      "area": "18 acres",
      "cropType": "Wheat",
      "lastTested": "2024-06-08",
      "nutrients": {
        "nitrogen": {"value": 52, "optimal": 45, "unit": "ppm", "status": "good"},
        "phosphorus": {"value": 25, "optimal": 30, "unit": "ppm", "status": "low"},
        "potassium": {"value": 38, "optimal": 35, "unit": "ppm", "status": "good"},
        "calcium": {"value": 720, "optimal": 800, "unit": "ppm", "status": "low"},
        "magnesium": {"value": 95, "optimal": 100, "unit": "ppm", "status": "good"},
        "sulfur": {"value": 22, "optimal": 20, "unit": "ppm", "status": "good"},
      },
      "deficiencies": ["Phosphorus", "Calcium"],
      "recommendations": [
        "Apply phosphorus fertilizer at 20 lbs/acre",
        "Add lime to increase calcium levels",
        "Maintain current nitrogen levels"
      ]
    },
    {
      "fieldName": "East Field",
      "area": "30 acres",
      "cropType": "Soybeans",
      "lastTested": "2024-06-12",
      "nutrients": {
        "nitrogen": {"value": 38, "optimal": 40, "unit": "ppm", "status": "good"},
        "phosphorus": {"value": 35, "optimal": 30, "unit": "ppm", "status": "good"},
        "potassium": {"value": 42, "optimal": 35, "unit": "ppm", "status": "high"},
        "calcium": {"value": 880, "optimal": 800, "unit": "ppm", "status": "good"},
        "magnesium": {"value": 105, "optimal": 100, "unit": "ppm", "status": "good"},
        "sulfur": {"value": 18, "optimal": 20, "unit": "ppm", "status": "good"},
      },
      "deficiencies": [],
      "recommendations": [
        "Excellent nutrient balance",
        "Continue current management",
        "Monitor potassium levels to prevent excess"
      ]
    },
  ];

  List<Map<String, dynamic>> micronutrients = [
    {"name": "Iron (Fe)", "current": 12.5, "optimal": 15.0, "unit": "ppm", "status": "low"},
    {"name": "Manganese (Mn)", "current": 8.2, "optimal": 10.0, "unit": "ppm", "status": "low"},
    {"name": "Zinc (Zn)", "current": 2.8, "optimal": 3.0, "unit": "ppm", "status": "good"},
    {"name": "Copper (Cu)", "current": 1.5, "optimal": 1.2, "unit": "ppm", "status": "high"},
    {"name": "Boron (B)", "current": 0.8, "optimal": 1.0, "unit": "ppm", "status": "low"},
    {"name": "Molybdenum (Mo)", "current": 0.15, "optimal": 0.20, "unit": "ppm", "status": "low"},
  ];

  String selectedField = "All Fields";
  String selectedNutrient = "All Nutrients";
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrient Levels"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo('nutrient-analytics')
            },
          ),
          IconButton(
            icon: Icon(Icons.recommend),
            onPressed: () {
              // navigateTo('fertilizer-recommendations')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nutrient Level Analysis",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Monitor macro and micronutrient levels across fields",
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
            ),

            SizedBox(height: spLg),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Field Selection",
                    items: [
                      {"label": "All Fields", "value": "All Fields"},
                      {"label": "North Field", "value": "North Field"},
                      {"label": "South Field", "value": "South Field"},
                      {"label": "East Field", "value": "East Field"},
                    ],
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
                    label: "Nutrient Type",
                    items: [
                      {"label": "All Nutrients", "value": "All Nutrients"},
                      {"label": "Macronutrients", "value": "Macronutrients"},
                      {"label": "Micronutrients", "value": "Micronutrients"},
                      {"label": "NPK Only", "value": "NPK Only"},
                    ],
                    value: selectedNutrient,
                    onChanged: (value, label) {
                      selectedNutrient = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Overall Nutrient Status
            Text(
              "Overall Nutrient Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildNutrientStatusCard(
                  "Nitrogen (N)",
                  "45.0 ppm",
                  "Low",
                  Icons.local_florist,
                  warningColor,
                ),
                _buildNutrientStatusCard(
                  "Phosphorus (P)",
                  "30.7 ppm",
                  "Good",
                  Icons.eco,
                  successColor,
                ),
                _buildNutrientStatusCard(
                  "Potassium (K)",
                  "36.0 ppm",
                  "Good",
                  Icons.grass,
                  successColor,
                ),
                _buildNutrientStatusCard(
                  "pH Balance",
                  "6.5",
                  "Optimal",
                  Icons.balance,
                  primaryColor,
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Field-wise Analysis
            Text(
              "Field-wise Nutrient Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: fieldData.length,
              itemBuilder: (context, index) {
                final field = fieldData[index];
                final nutrients = field["nutrients"] as Map<String, dynamic>;

                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${field["fieldName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${field["area"]} • ${field["cropType"]}",
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (field["deficiencies"] as List).isEmpty
                                  ? successColor.withAlpha(20)
                                  : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              (field["deficiencies"] as List).isEmpty
                                  ? "Balanced"
                                  : "${(field["deficiencies"] as List).length} Deficient",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (field["deficiencies"] as List).isEmpty
                                    ? successColor
                                    : warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Nutrient Levels Grid
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: nutrients.entries.map((entry) {
                          final nutrient = entry.value as Map<String, dynamic>;
                          Color statusColor = successColor;
                          if ("${nutrient["status"]}" == "low") statusColor = warningColor;
                          if ("${nutrient["status"]}" == "high") statusColor = dangerColor;

                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: statusColor.withAlpha(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${nutrient["value"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${nutrient["unit"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Target: ${nutrient["optimal"]} ${nutrient["unit"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      if ((field["deficiencies"] as List).isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Deficiencies Detected",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                (field["deficiencies"] as List).join(", "),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      SizedBox(height: spMd),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Recommendations",
                              size: bs.sm,
                              onPressed: () {
                                _showRecommendations(field);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Retest",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('schedule-test')
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: spLg),

            // Micronutrients Section
            Text(
              "Micronutrient Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                children: micronutrients.map((nutrient) {
                  Color statusColor = successColor;
                  if ("${nutrient["status"]}" == "low") statusColor = warningColor;
                  if ("${nutrient["status"]}" == "high") statusColor = dangerColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${nutrient["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${nutrient["current"]} ${nutrient["unit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${nutrient["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientStatusCard(String title, String value, String status, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showRecommendations(Map<String, dynamic> field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Fertilizer Recommendations"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${field["fieldName"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...(field["recommendations"] as List<String>).map((rec) => 
              Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        rec,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              back();
              // navigateTo('fertilizer-plan')
            },
            child: Text("Create Plan"),
          ),
        ],
      ),
    );
  }
}
