import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaNutrientCalculatorView extends StatefulWidget {
  const AmaNutrientCalculatorView({super.key});

  @override
  State<AmaNutrientCalculatorView> createState() => _AmaNutrientCalculatorViewState();
}

class _AmaNutrientCalculatorViewState extends State<AmaNutrientCalculatorView> {
  String cropType = "";
  String growthStage = "";
  String fieldArea = "";
  String soilType = "";
  String targetYield = "";
  String currentPH = "";
  String previousFertilizer = "";
  
  List<Map<String, dynamic>> calculations = [];
  bool isCalculated = false;

  List<Map<String, dynamic>> cropTypes = [
    {"label": "Rice", "value": "rice"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Corn", "value": "corn"},
    {"label": "Tomatoes", "value": "tomatoes"},
    {"label": "Potatoes", "value": "potatoes"},
    {"label": "Soybeans", "value": "soybeans"},
    {"label": "Cotton", "value": "cotton"},
    {"label": "Sugarcane", "value": "sugarcane"},
  ];

  List<Map<String, dynamic>> growthStages = [
    {"label": "Seedling", "value": "seedling"},
    {"label": "Vegetative", "value": "vegetative"},
    {"label": "Flowering", "value": "flowering"},
    {"label": "Fruiting", "value": "fruiting"},
    {"label": "Maturation", "value": "maturation"},
  ];

  List<Map<String, dynamic>> soilTypes = [
    {"label": "Loamy Soil", "value": "loamy"},
    {"label": "Clay Soil", "value": "clay"},
    {"label": "Sandy Soil", "value": "sandy"},
    {"label": "Silt Soil", "value": "silt"},
    {"label": "Peaty Soil", "value": "peaty"},
    {"label": "Chalky Soil", "value": "chalky"},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrient Calculator"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _resetCalculator();
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
            _buildHeaderSection(),
            _buildCalculatorForm(),
            if (isCalculated) _buildResultsSection(),
            _buildNutrientGuideSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(80)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calculate,
            size: 48,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "Nutrient Calculator",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Calculate optimal nutrient requirements for your crops based on soil conditions and growth stage",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Crop Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Crop Type",
            items: cropTypes,
            value: cropType,
            validator: Validator.required,
            onChanged: (value, label) {
              cropType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Growth Stage",
            items: growthStages,
            value: growthStage,
            validator: Validator.required,
            onChanged: (value, label) {
              growthStage = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Field Area (hectares)",
            value: fieldArea,
            validator: Validator.required,
            onChanged: (value) {
              fieldArea = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Text(
            "Soil Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Soil Type",
            items: soilTypes,
            value: soilType,
            onChanged: (value, label) {
              soilType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Current Soil pH",
            value: currentPH,
            onChanged: (value) {
              currentPH = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Target Yield (tons/ha)",
            value: targetYield,
            onChanged: (value) {
              targetYield = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Previous Fertilizer Application",
            value: previousFertilizer,
            hint: "Details of last fertilizer used",
            onChanged: (value) {
              previousFertilizer = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Calculate Nutrients",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _calculateNutrients();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.green.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Nutrient Requirements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...calculations.map((calc) => _buildNutrientCard(calc)),
          SizedBox(height: spMd),
          _buildApplicationInstructions(),
        ],
      ),
    );
  }

  Widget _buildNutrientCard(Map<String, dynamic> nutrient) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (nutrient["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              nutrient["icon"] as IconData,
              color: nutrient["color"] as Color,
              size: 30,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${nutrient["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Required: ${nutrient["amount"]} kg/ha",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${nutrient["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: (nutrient["status"] == "optimal") ? successColor : warningColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${nutrient["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationInstructions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Application Instructions",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "• Apply fertilizers in split doses for better absorption\n"
            "• Water the field immediately after application\n"
            "• Monitor soil moisture levels regularly\n"
            "• Retest soil after 2-3 weeks for effectiveness",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientGuideSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nutrient Guide",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        _buildNutrientGuideCard("Nitrogen (N)", "Essential for leaf growth and chlorophyll production", Icons.grass, successColor),
        _buildNutrientGuideCard("Phosphorus (P)", "Important for root development and flowering", Icons.eco, warningColor),
        _buildNutrientGuideCard("Potassium (K)", "Helps with disease resistance and fruit quality", Icons.shield, infoColor),
        _buildNutrientGuideCard("Calcium (Ca)", "Strengthens cell walls and improves fruit quality", Icons.security, dangerColor),
      ],
    );
  }

  Widget _buildNutrientGuideCard(String name, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  void _calculateNutrients() {
    calculations = [
      {
        "name": "Nitrogen (N)",
        "amount": "120-150",
        "description": "Essential for vegetative growth",
        "icon": Icons.grass,
        "color": successColor,
        "status": "optimal",
      },
      {
        "name": "Phosphorus (P)",
        "amount": "60-80",
        "description": "Important for root development",
        "icon": Icons.eco,
        "color": warningColor,
        "status": "moderate",
      },
      {
        "name": "Potassium (K)",
        "amount": "100-120",
        "description": "Enhances disease resistance",
        "icon": Icons.shield,
        "color": infoColor,
        "status": "optimal",
      },
      {
        "name": "Calcium (Ca)",
        "amount": "40-60",
        "description": "Strengthens plant structure",
        "icon": Icons.security,
        "color": dangerColor,
        "status": "low",
      },
    ];
    
    isCalculated = true;
    setState(() {});
    ss("Nutrient requirements calculated successfully!");
  }

  void _resetCalculator() {
    cropType = "";
    growthStage = "";
    fieldArea = "";
    soilType = "";
    targetYield = "";
    currentPH = "";
    previousFertilizer = "";
    calculations = [];
    isCalculated = false;
    setState(() {});
    si("Calculator reset successfully");
  }
}
