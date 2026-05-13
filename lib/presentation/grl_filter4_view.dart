import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter4View extends StatefulWidget {
  @override
  State<GrlFilter4View> createState() => _GrlFilter4ViewState();
}

class _GrlFilter4ViewState extends State<GrlFilter4View> {
  String selectedSpecialty = "";
  String selectedInsurance = "";
  String selectedLanguage = "";
  String selectedGender = "";
  String selectedExperience = "";
  List<String> selectedConditions = [];
  DateTime? preferredDate;
  TimeOfDay? preferredTime;
  String selectedAppointmentType = "all";
  bool acceptingNewPatients = false;
  bool telehealth = false;
  double maxDistance = 10;

  List<Map<String, dynamic>> specialtyItems = [
    {"label": "All Specialties", "value": ""},
    {"label": "Family Medicine", "value": "family_medicine"},
    {"label": "Internal Medicine", "value": "internal_medicine"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "Orthopedics", "value": "orthopedics"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Gynecology", "value": "gynecology"},
    {"label": "Psychiatry", "value": "psychiatry"},
  ];

  List<Map<String, dynamic>> insuranceItems = [
    {"label": "Any Insurance", "value": ""},
    {"label": "Blue Cross Blue Shield", "value": "bcbs"},
    {"label": "Aetna", "value": "aetna"},
    {"label": "Cigna", "value": "cigna"},
    {"label": "UnitedHealth", "value": "united"},
    {"label": "Kaiser Permanente", "value": "kaiser"},
    {"label": "Humana", "value": "humana"},
    {"label": "Medicare", "value": "medicare"},
    {"label": "Medicaid", "value": "medicaid"},
  ];

  List<Map<String, dynamic>> languageItems = [
    {"label": "Any Language", "value": ""},
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Chinese", "value": "chinese"},
    {"label": "Arabic", "value": "arabic"},
    {"label": "Hindi", "value": "hindi"},
  ];

  List<Map<String, dynamic>> genderItems = [
    {"label": "Any Gender", "value": ""},
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Non-binary", "value": "non_binary"},
  ];

  List<Map<String, dynamic>> experienceItems = [
    {"label": "Any Experience", "value": ""},
    {"label": "5+ Years", "value": "5"},
    {"label": "10+ Years", "value": "10"},
    {"label": "15+ Years", "value": "15"},
    {"label": "20+ Years", "value": "20"},
  ];

  List<String> conditionsList = [
    "Diabetes",
    "Hypertension",
    "Asthma",
    "Arthritis",
    "Depression",
    "Anxiety",
    "Heart Disease",
    "Obesity",
    "Allergies",
    "Chronic Pain",
    "Migraine",
    "Sleep Disorders",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Filters"),
        actions: [
          GestureDetector(
            onTap: () {
              _resetFilters();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Specialty
            Text(
              "Specialty",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Specialty",
              items: specialtyItems,
              value: selectedSpecialty,
              onChanged: (value, label) {
                selectedSpecialty = value;
                setState(() {});
              },
            ),

            // Insurance and Language
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Insurance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Insurance",
                        items: insuranceItems,
                        value: selectedInsurance,
                        onChanged: (value, label) {
                          selectedInsurance = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Language",
                        items: languageItems,
                        value: selectedLanguage,
                        onChanged: (value, label) {
                          selectedLanguage = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Gender and Experience
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Gender",
                        items: genderItems,
                        value: selectedGender,
                        onChanged: (value, label) {
                          selectedGender = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Experience",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Experience",
                        items: experienceItems,
                        value: selectedExperience,
                        onChanged: (value, label) {
                          selectedExperience = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Preferred Appointment
            Text(
              "Preferred Appointment",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
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
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Preferred Date",
                          value: preferredDate ?? DateTime.now(),
                          onChanged: (value) {
                            preferredDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Preferred Time",
                          value: preferredTime ?? TimeOfDay(hour: 9, minute: 0),
                          onChanged: (value) {
                            preferredTime = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Appointment Type
            Text(
              "Appointment Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: [
                {"label": "All", "value": "all"},
                {"label": "In-Person", "value": "in_person"},
                {"label": "Telehealth", "value": "telehealth"},
                {"label": "Urgent Care", "value": "urgent"},
              ],
              value: selectedAppointmentType,
              onChanged: (index, label, value, item) {
                selectedAppointmentType = value;
                setState(() {});
              },
            ),

            // Availability Options
            Text(
              "Availability",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
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
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Accepting New Patients",
                        "value": true,
                        "checked": acceptingNewPatients,
                      }
                    ],
                    value: [
                      if (acceptingNewPatients)
                        {"label": "Accepting New Patients", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      acceptingNewPatients = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Telehealth Available",
                        "value": true,
                        "checked": telehealth,
                      }
                    ],
                    value: [
                      if (telehealth)
                        {"label": "Telehealth Available", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      telehealth = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Distance
            Text(
              "Distance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
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
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Within ${maxDistance.toInt()} miles",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${maxDistance.toInt()} mi",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: maxDistance,
                    min: 1,
                    max: 50,
                    divisions: 49,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      maxDistance = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Medical Conditions
            Text(
              "Medical Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
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
                  Text(
                    "Select conditions you need treatment for:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: conditionsList.map((condition) {
                      bool isSelected = selectedConditions.contains(condition);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedConditions.remove(condition);
                          } else {
                            selectedConditions.add(condition);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            condition,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Apply Filter Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  _applyFilters();
                },
              ),
            ),

            SizedBox(height: spSm),

            // Clear Filters Button
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _resetFilters();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "Clear All Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {
      'specialty': selectedSpecialty,
      'insurance': selectedInsurance,
      'language': selectedLanguage,
      'gender': selectedGender,
      'experience': selectedExperience,
      'conditions': selectedConditions,
      'preferredDate': preferredDate?.toIso8601String(),
      'preferredTime': preferredTime?.kkmm,
      'appointmentType': selectedAppointmentType,
      'acceptingNewPatients': acceptingNewPatients,
      'telehealth': telehealth,
      'maxDistance': maxDistance,
    };

    ss("Doctor filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedSpecialty = "";
    selectedInsurance = "";
    selectedLanguage = "";
    selectedGender = "";
    selectedExperience = "";
    selectedConditions.clear();
    preferredDate = null;
    preferredTime = null;
    selectedAppointmentType = "all";
    acceptingNewPatients = false;
    telehealth = false;
    maxDistance = 10;
    setState(() {});
  }
}
