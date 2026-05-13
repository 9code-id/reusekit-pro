import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMedicalHistoryView extends StatefulWidget {
  const MhaMedicalHistoryView({super.key});

  @override
  State<MhaMedicalHistoryView> createState() => _MhaMedicalHistoryViewState();
}

class _MhaMedicalHistoryViewState extends State<MhaMedicalHistoryView> {
  int selectedTab = 0;
  bool loading = false;

  final List<Map<String, dynamic>> medicalRecords = [
    {
      "id": "1",
      "type": "Consultation",
      "doctor": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "date": "2024-06-10",
      "diagnosis": "Hypertension",
      "prescription": "Amlodipine 5mg daily",
      "notes": "Blood pressure elevated. Recommended lifestyle changes and medication.",
      "status": "Completed",
      "hospital": "City General Hospital",
      "severity": "Medium",
    },
    {
      "id": "2",
      "type": "Lab Test",
      "doctor": "Dr. Michael Chen",
      "specialty": "Internal Medicine",
      "date": "2024-06-08",
      "diagnosis": "Blood Work - Normal",
      "prescription": "",
      "notes": "Complete blood count and lipid panel within normal ranges.",
      "status": "Completed",
      "hospital": "MedLab Diagnostics",
      "severity": "Low",
    },
    {
      "id": "3",
      "type": "Surgery",
      "doctor": "Dr. Emily Rodriguez",
      "specialty": "Orthopedic Surgeon",
      "date": "2024-05-20",
      "diagnosis": "Knee Arthroscopy",
      "prescription": "Pain medication and physical therapy",
      "notes": "Successful arthroscopic procedure. Recovery time 4-6 weeks.",
      "status": "Completed",
      "hospital": "Orthopedic Surgery Center",
      "severity": "High",
    },
    {
      "id": "4",
      "type": "Vaccination",
      "doctor": "Dr. Amanda Wilson",
      "specialty": "Family Medicine",
      "date": "2024-05-15",
      "diagnosis": "Annual Flu Shot",
      "prescription": "",
      "notes": "Seasonal influenza vaccination administered.",
      "status": "Completed",
      "hospital": "Family Health Clinic",
      "severity": "Low",
    },
    {
      "id": "5",
      "type": "Emergency",
      "doctor": "Dr. Robert Taylor",
      "specialty": "Emergency Medicine",
      "date": "2024-04-22",
      "diagnosis": "Food Poisoning",
      "prescription": "Rehydration therapy",
      "notes": "Acute gastroenteritis. Patient recovered fully after treatment.",
      "status": "Completed",
      "hospital": "Emergency Medical Center",
      "severity": "Medium",
    },
  ];

  final List<Map<String, dynamic>> allergies = [
    {
      "allergen": "Penicillin",
      "severity": "Severe",
      "reaction": "Anaphylaxis",
      "dateIdentified": "2020-03-15",
    },
    {
      "allergen": "Shellfish",
      "severity": "Moderate",
      "reaction": "Hives and swelling",
      "dateIdentified": "2018-07-20",
    },
    {
      "allergen": "Pollen",
      "severity": "Mild",
      "reaction": "Seasonal rhinitis",
      "dateIdentified": "2015-04-10",
    },
  ];

  final List<Map<String, dynamic>> chronicConditions = [
    {
      "condition": "Hypertension",
      "diagnosedDate": "2022-08-15",
      "status": "Controlled",
      "treatment": "Medication and lifestyle changes",
      "lastCheckup": "2024-06-10",
    },
    {
      "condition": "Type 2 Diabetes",
      "diagnosedDate": "2021-11-20",
      "status": "Well Controlled",
      "treatment": "Metformin and diet management",
      "lastCheckup": "2024-05-28",
    },
  ];

  final List<Map<String, dynamic>> familyHistory = [
    {
      "condition": "Heart Disease",
      "relation": "Father",
      "ageOfOnset": "55",
      "notes": "Myocardial infarction",
    },
    {
      "condition": "Diabetes",
      "relation": "Mother",
      "ageOfOnset": "48",
      "notes": "Type 2 diabetes",
    },
    {
      "condition": "Cancer",
      "relation": "Grandmother (Maternal)",
      "ageOfOnset": "62",
      "notes": "Breast cancer",
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
      case 'severe':
        return dangerColor;
      case 'medium':
      case 'moderate':
        return warningColor;
      case 'low':
      case 'mild':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildMedicalRecordCard(Map<String, dynamic> record) {
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
            color: _getSeverityColor("${record["severity"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${record["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${record["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${record["diagnosis"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${record["doctor"]} - ${record["specialty"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.local_hospital,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${record["hospital"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ("${record["notes"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "${record["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
          if ("${record["prescription"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.medication,
                    size: 16,
                    color: Colors.blue,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${record["prescription"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
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
  }

  Widget _buildAllergyCard(Map<String, dynamic> allergy) {
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
            color: _getSeverityColor("${allergy["severity"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning,
                color: _getSeverityColor("${allergy["severity"]}"),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${allergy["allergen"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getSeverityColor("${allergy["severity"]}").withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${allergy["severity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getSeverityColor("${allergy["severity"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Reaction: ${allergy["reaction"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Identified: ${allergy["dateIdentified"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionCard(Map<String, dynamic> condition) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Text(
                "${condition["condition"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${condition["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Diagnosed: ${condition["diagnosedDate"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Treatment: ${condition["treatment"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Last Checkup: ${condition["lastCheckup"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyHistoryCard(Map<String, dynamic> history) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Text(
                "${history["condition"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Age: ${history["ageOfOnset"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Relation: ${history["relation"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          if ("${history["notes"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Notes: ${history["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical History"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(MhaAddMedicalRecordView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Records", "value": "records"},
                {"label": "Allergies", "value": "allergies"},
                {"label": "Conditions", "value": "conditions"},
                {"label": "Family", "value": "family"},
              ],
              value: selectedTab == 0 ? "records" : selectedTab == 1 ? "allergies" : selectedTab == 2 ? "conditions" : "family",
              onChanged: (index, label, value, item) {
                selectedTab = index;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedTab == 0) ...[
                    // Medical Records
                    Row(
                      children: [
                        Text(
                          "Medical Records",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${medicalRecords.length} records",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...medicalRecords.map((record) => _buildMedicalRecordCard(record)),
                  ] else if (selectedTab == 1) ...[
                    // Allergies
                    Row(
                      children: [
                        Text(
                          "Known Allergies",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${allergies.length} allergies",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...allergies.map((allergy) => _buildAllergyCard(allergy)),
                  ] else if (selectedTab == 2) ...[
                    // Chronic Conditions
                    Row(
                      children: [
                        Text(
                          "Chronic Conditions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${chronicConditions.length} conditions",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...chronicConditions.map((condition) => _buildConditionCard(condition)),
                  ] else if (selectedTab == 3) ...[
                    // Family History
                    Row(
                      children: [
                        Text(
                          "Family Medical History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${familyHistory.length} conditions",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...familyHistory.map((history) => _buildFamilyHistoryCard(history)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(MhaAddMedicalRecordView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
