import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:math' as Math;

class HcaDosageCalculatorView extends StatefulWidget {
  const HcaDosageCalculatorView({super.key});

  @override
  State<HcaDosageCalculatorView> createState() => _HcaDosageCalculatorViewState();
}

class _HcaDosageCalculatorViewState extends State<HcaDosageCalculatorView> {
  String selectedCalculator = "Weight-Based";
  String medication = "";
  String patientWeight = "";
  String patientAge = "";
  String patientHeight = "";
  String concentration = "";
  String desiredDose = "";
  String frequency = "Once Daily";
  String units = "mg";
  String weightUnit = "kg";
  String calculationResult = "";
  String safetyNotes = "";
  
  List<Map<String, dynamic>> calculatorTypes = [
    {"label": "Weight-Based", "value": "Weight-Based"},
    {"label": "Age-Based", "value": "Age-Based"},
    {"label": "BSA-Based", "value": "BSA-Based"},
    {"label": "IV Drip Rate", "value": "IV Drip Rate"},
    {"label": "Pediatric", "value": "Pediatric"},
    {"label": "Insulin", "value": "Insulin"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Once Daily", "value": "Once Daily"},
    {"label": "Twice Daily", "value": "Twice Daily"},
    {"label": "3 Times Daily", "value": "3 Times Daily"},
    {"label": "4 Times Daily", "value": "4 Times Daily"},
    {"label": "Every 4 Hours", "value": "Every 4 Hours"},
    {"label": "Every 6 Hours", "value": "Every 6 Hours"},
    {"label": "Every 8 Hours", "value": "Every 8 Hours"},
    {"label": "Every 12 Hours", "value": "Every 12 Hours"},
  ];

  List<Map<String, dynamic>> unitsOptions = [
    {"label": "mg", "value": "mg"},
    {"label": "mcg", "value": "mcg"},
    {"label": "g", "value": "g"},
    {"label": "mL", "value": "mL"},
    {"label": "units", "value": "units"},
    {"label": "IU", "value": "IU"},
  ];

  List<Map<String, dynamic>> weightUnitsOptions = [
    {"label": "kg", "value": "kg"},
    {"label": "lbs", "value": "lbs"},
  ];

  List<Map<String, dynamic>> commonMedications = [
    {
      "name": "Paracetamol",
      "dosage": "10-15 mg/kg",
      "maxDaily": "60 mg/kg",
      "frequency": "Every 4-6 hours",
      "route": "Oral",
      "category": "Analgesic",
      "color": successColor,
    },
    {
      "name": "Ibuprofen",
      "dosage": "5-10 mg/kg",
      "maxDaily": "40 mg/kg",
      "frequency": "Every 6-8 hours",
      "route": "Oral",
      "category": "NSAID",
      "color": warningColor,
    },
    {
      "name": "Amoxicillin",
      "dosage": "20-40 mg/kg",
      "maxDaily": "90 mg/kg",
      "frequency": "Every 8 hours",
      "route": "Oral",
      "category": "Antibiotic",
      "color": infoColor,
    },
    {
      "name": "Prednisolone",
      "dosage": "1-2 mg/kg",
      "maxDaily": "60 mg",
      "frequency": "Once daily",
      "route": "Oral",
      "category": "Steroid",
      "color": dangerColor,
    },
    {
      "name": "Salbutamol",
      "dosage": "2.5-5 mg",
      "maxDaily": "20 mg",
      "frequency": "Every 4-6 hours",
      "route": "Nebulized",
      "category": "Bronchodilator",
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> calculationHistory = [
    {
      "id": 1,
      "medication": "Paracetamol",
      "weight": "25 kg",
      "calculatedDose": "250 mg",
      "frequency": "Every 6 hours",
      "date": "2024-01-15",
      "type": "Weight-Based",
      "result": "Safe dosage",
      "color": successColor,
    },
    {
      "id": 2,
      "medication": "Ibuprofen",
      "weight": "30 kg",
      "calculatedDose": "150 mg",
      "frequency": "Every 8 hours",
      "date": "2024-01-14",
      "type": "Weight-Based",
      "result": "Within safe range",
      "color": successColor,
    },
    {
      "id": 3,
      "medication": "Amoxicillin",
      "weight": "20 kg",
      "calculatedDose": "400 mg",
      "frequency": "Every 8 hours",
      "date": "2024-01-13",
      "type": "Weight-Based",
      "result": "Consult physician",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dosage Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _showCalculationHistory(),
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => _showDosageGuide(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCalculatorSelector(),
            _buildCalculatorForm(),
            if (calculationResult.isNotEmpty) _buildResultSection(),
            _buildCommonMedications(),
            _buildQuickCalculators(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Calculator Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: calculatorTypes,
            value: selectedCalculator,
            onChanged: (index, label, value, item) {
              selectedCalculator = value;
              _resetForm();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorForm() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$selectedCalculator Dosage Calculator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Medication Name",
            value: medication,
            hint: "Enter medication name",
            onChanged: (value) {
              medication = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          if (selectedCalculator == "Weight-Based" || selectedCalculator == "BSA-Based" || selectedCalculator == "Pediatric") ...[
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Patient Weight",
                    value: patientWeight,
                    onChanged: (value) {
                      patientWeight = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Unit",
                    items: weightUnitsOptions,
                    value: weightUnit,
                    onChanged: (value, label) {
                      weightUnit = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],
          if (selectedCalculator == "Age-Based" || selectedCalculator == "Pediatric") ...[
            QNumberField(
              label: "Patient Age (years)",
              value: patientAge,
              onChanged: (value) {
                patientAge = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
          ],
          if (selectedCalculator == "BSA-Based") ...[
            QNumberField(
              label: "Patient Height (cm)",
              value: patientHeight,
              onChanged: (value) {
                patientHeight = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
          ],
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: selectedCalculator == "IV Drip Rate" ? "Dose Rate" : "Desired Dose",
                  value: desiredDose,
                  onChanged: (value) {
                    desiredDose = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Unit",
                  items: unitsOptions,
                  value: units,
                  onChanged: (value, label) {
                    units = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          if (selectedCalculator != "IV Drip Rate") ...[
            QDropdownField(
              label: "Frequency",
              items: frequencyOptions,
              value: frequency,
              onChanged: (value, label) {
                frequency = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
          ],
          if (selectedCalculator == "IV Drip Rate") ...[
            QNumberField(
              label: "Concentration (mg/mL)",
              value: concentration,
              onChanged: (value) {
                concentration = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Calculate Dosage",
                  size: bs.md,
                  onPressed: () => _calculateDosage(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.md,
                onPressed: () => _resetForm(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor),
              SizedBox(width: spXs),
              Text(
                "Calculation Result",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  calculationResult,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Recommended Dosage",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (safetyNotes.isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning, color: warningColor, size: 20),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Safety Notes",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          safetyNotes,
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Calculation",
                  size: bs.sm,
                  onPressed: () => _saveCalculation(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () => _shareCalculation(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommonMedications() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medication, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Common Medications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...commonMedications.map((med) => _buildMedicationCard(med)),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> med) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (med["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: med["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                med["name"],
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (med["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  med["category"],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: med["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.straighten, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Dosage: ${med["dosage"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Frequency: ${med["frequency"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.warning, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Max daily: ${med["maxDaily"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Use This Medication",
            size: bs.sm,
            onPressed: () => _useMedication(med),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCalculators() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Quick Calculators",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildQuickCalcCard("BMI Calculator", Icons.monitor_weight, infoColor),
              _buildQuickCalcCard("BSA Calculator", Icons.straighten, successColor),
              _buildQuickCalcCard("Creatinine Clearance", Icons.water_drop, warningColor),
              _buildQuickCalcCard("Unit Converter", Icons.transform, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCalcCard(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Calculate",
            size: bs.sm,
            onPressed: () => _openQuickCalculator(title),
          ),
        ],
      ),
    );
  }

  void _calculateDosage() {
    if (medication.isEmpty || desiredDose.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    double dose = double.tryParse(desiredDose) ?? 0;
    double weight = double.tryParse(patientWeight) ?? 0;
    double age = double.tryParse(patientAge) ?? 0;
    double height = double.tryParse(patientHeight) ?? 0;

    String result = "";
    String notes = "";

    switch (selectedCalculator) {
      case "Weight-Based":
        if (weight <= 0) {
          se("Please enter a valid weight");
          return;
        }
        double calculatedDose = dose * weight;
        if (weightUnit == "lbs") {
          calculatedDose = dose * (weight * 0.453592); // Convert lbs to kg
        }
        result = "${calculatedDose.toStringAsFixed(1)} $units";
        notes = "Calculated based on ${weight} ${weightUnit} body weight. Always verify with prescribing guidelines.";
        break;

      case "Age-Based":
        if (age <= 0) {
          se("Please enter a valid age");
          return;
        }
        double calculatedDose = dose * age;
        if (age < 12) {
          calculatedDose = calculatedDose * 0.5; // Pediatric adjustment
        }
        result = "${calculatedDose.toStringAsFixed(1)} $units";
        notes = "Age-based calculation for ${age} years old. Pediatric adjustments applied for children under 12.";
        break;

      case "BSA-Based":
        if (weight <= 0 || height <= 0) {
          se("Please enter valid weight and height");
          return;
        }
        double weightInKg = weightUnit == "lbs" ? weight * 0.453592 : weight;
        double bsa = Math.sqrt((weightInKg * height) / 3600);
        double calculatedDose = dose * bsa;
        result = "${calculatedDose.toStringAsFixed(1)} $units";
        notes = "BSA-based calculation (BSA: ${bsa.toStringAsFixed(2)} m²). More accurate for certain medications.";
        break;

      case "IV Drip Rate":
        double concentrationValue = double.tryParse(concentration) ?? 0;
        if (concentrationValue <= 0) {
          se("Please enter a valid concentration");
          return;
        }
        double flowRate = dose / concentrationValue;
        result = "${flowRate.toStringAsFixed(2)} mL/hr";
        notes = "IV drip rate calculated. Always double-check with infusion pump settings.";
        break;

      case "Pediatric":
        if (weight <= 0 || age <= 0) {
          se("Please enter valid weight and age");
          return;
        }
        double weightInKg = weightUnit == "lbs" ? weight * 0.453592 : weight;
        double calculatedDose = dose * weightInKg;
        if (age < 2) {
          calculatedDose = calculatedDose * 0.5; // Infant adjustment
        } else if (age < 12) {
          calculatedDose = calculatedDose * 0.75; // Child adjustment
        }
        result = "${calculatedDose.toStringAsFixed(1)} $units";
        notes = "Pediatric dosing for ${age} years old, ${weight} ${weightUnit}. Age-appropriate adjustments applied.";
        break;

      case "Insulin":
        if (weight <= 0) {
          se("Please enter a valid weight");
          return;
        }
        double weightInKg = weightUnit == "lbs" ? weight * 0.453592 : weight;
        double calculatedDose = dose * weightInKg;
        result = "${calculatedDose.toStringAsFixed(1)} units";
        notes = "Insulin dosing calculation. Monitor blood glucose levels closely and adjust as needed.";
        break;
    }

    calculationResult = result;
    safetyNotes = notes;
    setState(() {});
    ss("Dosage calculated successfully");
  }

  void _resetForm() {
    medication = "";
    patientWeight = "";
    patientAge = "";
    patientHeight = "";
    concentration = "";
    desiredDose = "";
    frequency = "Once Daily";
    units = "mg";
    weightUnit = "kg";
    calculationResult = "";
    safetyNotes = "";
    setState(() {});
  }

  void _saveCalculation() {
    if (calculationResult.isEmpty) {
      sw("No calculation to save");
      return;
    }

    Map<String, dynamic> newCalculation = {
      "id": calculationHistory.length + 1,
      "medication": medication,
      "weight": "$patientWeight $weightUnit",
      "calculatedDose": calculationResult,
      "frequency": frequency,
      "date": DateTime.now().toString().split(' ')[0],
      "type": selectedCalculator,
      "result": "Calculation saved",
      "color": successColor,
    };

    calculationHistory.insert(0, newCalculation);
    setState(() {});
    ss("Calculation saved to history");
  }

  void _shareCalculation() {
    if (calculationResult.isEmpty) {
      sw("No calculation to share");
      return;
    }
    si("Share functionality would be implemented here");
  }

  void _useMedication(Map<String, dynamic> med) {
    medication = med["name"];
    setState(() {});
    ss("Medication ${med["name"]} selected");
  }

  void _openQuickCalculator(String calculatorType) {
    si("$calculatorType would be implemented here");
  }

  void _showCalculationHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Calculation History",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              if (calculationHistory.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No calculation history",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...calculationHistory.map((calc) => _buildHistoryCard(calc)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> calc) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: calc["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                calc["medication"],
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                calc["date"],
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Weight: ${calc["weight"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            "Calculated Dose: ${calc["calculatedDose"]}",
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Type: ${calc["type"]}",
            style: TextStyle(
              color: disabledColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showDosageGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Dosage Calculation Guide",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              _buildGuideSection("Weight-Based Dosing", "Calculate medication dose based on patient's body weight. Most common method for pediatric and many adult medications."),
              _buildGuideSection("Age-Based Dosing", "Less accurate but useful when weight is unknown. Includes pediatric adjustments for children under 12."),
              _buildGuideSection("BSA-Based Dosing", "Most accurate for chemotherapy and certain cardiac medications. Requires both weight and height."),
              _buildGuideSection("IV Drip Rate", "Calculate infusion rate for continuous IV medications. Always double-check with infusion pump."),
              _buildGuideSection("Pediatric Dosing", "Specialized calculations for children with age-appropriate safety adjustments."),
              _buildGuideSection("Insulin Dosing", "Calculate insulin requirements based on body weight and glucose levels."),
              Container(
                margin: EdgeInsets.only(top: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: dangerColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: dangerColor),
                        SizedBox(width: spXs),
                        Text(
                          "Important Safety Notice",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "This calculator is for educational purposes only. Always verify calculations with prescribing guidelines, pharmacist, or physician before administering medications. Individual patient factors may require dose adjustments.",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideSection(String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
