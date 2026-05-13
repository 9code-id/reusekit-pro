import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthRecordsView extends StatefulWidget {
  const MhaHealthRecordsView({super.key});

  @override
  State<MhaHealthRecordsView> createState() => _MhaHealthRecordsViewState();
}

class _MhaHealthRecordsViewState extends State<MhaHealthRecordsView> {
  String selectedCategory = "All Records";
  String searchQuery = "";
  
  final categories = [
    {"label": "All Records", "value": "All Records"},
    {"label": "Medical Reports", "value": "Medical Reports"},
    {"label": "Lab Results", "value": "Lab Results"},
    {"label": "Prescriptions", "value": "Prescriptions"},
    {"label": "Vaccinations", "value": "Vaccinations"},
    {"label": "Imaging", "value": "Imaging"},
    {"label": "Allergies", "value": "Allergies"},
  ];

  final healthRecords = [
    {
      "id": "HR001",
      "title": "Annual Health Checkup",
      "category": "Medical Reports",
      "doctor": "Dr. Sarah Johnson",
      "hospital": "City General Hospital",
      "date": "2024-01-15",
      "type": "Comprehensive",
      "status": "Completed",
      "summary": "Overall health condition is excellent. All vital signs normal.",
      "files": ["Annual_Checkup_2024.pdf", "Blood_Work_Results.pdf"],
      "tags": ["Annual", "Checkup", "Preventive"],
      "priority": "Normal",
      "next_action": "Schedule next annual checkup in 12 months"
    },
    {
      "id": "HR002",
      "title": "Blood Test - Complete Blood Count",
      "category": "Lab Results",
      "doctor": "Dr. Michael Chen",
      "hospital": "MedLab Center",
      "date": "2024-01-10",
      "type": "Laboratory",
      "status": "Reviewed",
      "summary": "All blood parameters within normal range. Vitamin D slightly low.",
      "files": ["CBC_Report_Jan2024.pdf"],
      "tags": ["Blood", "CBC", "Routine"],
      "priority": "Normal",
      "next_action": "Consider Vitamin D supplementation"
    },
    {
      "id": "HR003",
      "title": "Prescription - Lisinopril",
      "category": "Prescriptions",
      "doctor": "Dr. Emily Davis",
      "hospital": "Heart Care Clinic",
      "date": "2024-01-08",
      "type": "Medication",
      "status": "Active",
      "summary": "Prescribed for blood pressure management. 10mg daily.",
      "files": ["Prescription_Lisinopril.pdf"],
      "tags": ["Blood Pressure", "Cardiovascular", "Chronic"],
      "priority": "High",
      "next_action": "Refill in 25 days"
    },
    {
      "id": "HR004",
      "title": "COVID-19 Vaccination",
      "category": "Vaccinations",
      "doctor": "Nurse Practitioner Jane Smith",
      "hospital": "City Vaccination Center",
      "date": "2023-12-20",
      "type": "Immunization",
      "status": "Completed",
      "summary": "Second booster dose administered. No adverse reactions.",
      "files": ["Vaccination_Record.pdf"],
      "tags": ["COVID-19", "Booster", "Immunization"],
      "priority": "Normal",
      "next_action": "Monitor for any side effects"
    },
    {
      "id": "HR005",
      "title": "Chest X-Ray",
      "category": "Imaging",
      "doctor": "Dr. Robert Wilson",
      "hospital": "Radiology Associates",
      "date": "2023-12-15",
      "type": "Diagnostic",
      "status": "Normal",
      "summary": "Clear chest X-ray. No abnormalities detected.",
      "files": ["Chest_XRay_Dec2023.pdf", "Radiologist_Report.pdf"],
      "tags": ["Chest", "X-Ray", "Diagnostic"],
      "priority": "Normal",
      "next_action": "No follow-up required"
    },
    {
      "id": "HR006",
      "title": "Allergy Test Results",
      "category": "Allergies",
      "doctor": "Dr. Lisa Thompson",
      "hospital": "Allergy & Asthma Center",
      "date": "2023-11-28",
      "type": "Allergy Panel",
      "status": "Positive",
      "summary": "Mild allergies to pollen and dust mites detected.",
      "files": ["Allergy_Panel_Results.pdf"],
      "tags": ["Allergy", "Pollen", "Dust Mites"],
      "priority": "Medium",
      "next_action": "Avoid allergens, consider medication if symptoms worsen"
    },
  ];

  List<Map<String, dynamic>> get filteredRecords {
    var filtered = healthRecords;
    
    if (selectedCategory != "All Records") {
      filtered = filtered.where((record) => 
        record["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((record) =>
        (record["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (record["doctor"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (record["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      default:
        return successColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Completed":
        return primaryColor;
      case "Reviewed":
        return infoColor;
      case "Positive":
        return warningColor;
      case "Normal":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Records"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search records...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QDropdownField(
                    label: "Filter by Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Records Summary
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.folder_open, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Health Records Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredRecords.length} records found",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Export All",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Records List
          Expanded(
            child: filteredRecords.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No records found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search or filter criteria",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredRecords.length,
                    itemBuilder: (context, index) {
                      final record = filteredRecords[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: _getPriorityColor(record["priority"] as String).withAlpha(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(record["priority"] as String).withAlpha(10),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusSm),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(record["priority"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      _getCategoryIcon(record["category"] as String),
                                      size: 20,
                                      color: _getPriorityColor(record["priority"] as String),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${record["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${record["category"]} • ${record["date"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
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
                                      color: _getStatusColor(record["status"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${record["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(record["status"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Content
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Doctor & Hospital Info
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${record["doctor"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.local_hospital, size: 16, color: disabledBoldColor),
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
                                  SizedBox(height: spSm),

                                  // Summary
                                  Text(
                                    "${record["summary"]}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: spSm),

                                  // Tags
                                  if ((record["tags"] as List).isNotEmpty)
                                    Wrap(
                                      spacing: spXs,
                                      runSpacing: spXs,
                                      children: (record["tags"] as List).map((tag) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "$tag",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: infoColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                  SizedBox(height: spSm),

                                  // Files
                                  if ((record["files"] as List).isNotEmpty) ...[
                                    Text(
                                      "Attached Files (${(record["files"] as List).length})",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    ...(record["files"] as List).map((file) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: spXs),
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: disabledColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.attach_file,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Expanded(
                                              child: Text(
                                                "$file",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.download,
                                                size: 16,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],

                                  // Next Action
                                  if (record["next_action"] != null && (record["next_action"] as String).isNotEmpty) ...[
                                    SizedBox(height: spSm),
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        border: Border.all(
                                          color: warningColor.withAlpha(30),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb_outline,
                                            size: 16,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Expanded(
                                            child: Text(
                                              "${record["next_action"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: warningColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],

                                  SizedBox(height: spSm),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Share",
                                          size: bs.sm,
                                          onPressed: () {},
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
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Medical Reports":
        return Icons.assignment;
      case "Lab Results":
        return Icons.science;
      case "Prescriptions":
        return Icons.medication;
      case "Vaccinations":
        return Icons.vaccines;
      case "Imaging":
        return Icons.medical_services;
      case "Allergies":
        return Icons.warning;
      default:
        return Icons.folder;
    }
  }
}
