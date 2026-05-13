import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaMedicalRecordsView extends StatefulWidget {
  const HcaMedicalRecordsView({super.key});

  @override
  State<HcaMedicalRecordsView> createState() => _HcaMedicalRecordsViewState();
}

class _HcaMedicalRecordsViewState extends State<HcaMedicalRecordsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  bool showSecure = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Records", "value": ""},
    {"label": "Diagnosis", "value": "diagnosis"},
    {"label": "Treatment", "value": "treatment"},
    {"label": "Lab Results", "value": "lab"},
    {"label": "Imaging", "value": "imaging"},
    {"label": "Prescriptions", "value": "prescription"},
    {"label": "Vaccines", "value": "vaccine"},
  ];

  List<Map<String, dynamic>> medicalRecords = [
    {
      "id": "1",
      "title": "Annual Physical Examination",
      "category": "diagnosis",
      "date": "2024-01-15",
      "doctor": "Dr. Sarah Johnson",
      "hospital": "Metropolitan Medical Center",
      "status": "Completed",
      "priority": "Normal",
      "diagnosis": "Routine physical examination - All normal",
      "treatment": "Continue current exercise routine and diet",
      "notes": "Patient is in excellent health. Blood pressure and heart rate normal. Recommended annual follow-up.",
      "attachments": [
        {"name": "Physical_Exam_Report.pdf", "size": "1.2 MB", "type": "pdf"},
        {"name": "Vital_Signs_Chart.pdf", "size": "0.8 MB", "type": "pdf"}
      ],
      "vitals": {
        "height": "175 cm",
        "weight": "72 kg",
        "bmi": "23.5",
        "bloodPressure": "120/80",
        "heartRate": "68 bpm",
        "temperature": "36.5°C"
      }
    },
    {
      "id": "2",
      "title": "Cardiac Stress Test Results",
      "category": "lab",
      "date": "2024-01-10",
      "doctor": "Dr. Michael Chen",
      "hospital": "Heart & Vascular Institute",
      "status": "Completed",
      "priority": "High",
      "diagnosis": "Cardiac function within normal limits",
      "treatment": "Continue cardiac medication as prescribed",
      "notes": "Stress test completed successfully. No signs of coronary artery disease. Exercise tolerance excellent.",
      "attachments": [
        {"name": "Stress_Test_Report.pdf", "size": "2.1 MB", "type": "pdf"},
        {"name": "ECG_Results.pdf", "size": "1.5 MB", "type": "pdf"},
        {"name": "Echo_Images.jpg", "size": "3.2 MB", "type": "image"}
      ],
      "results": {
        "ejectionFraction": "65%",
        "maxHeartRate": "165 bpm",
        "exerciseCapacity": "12 METs",
        "bloodPressureResponse": "Normal"
      }
    },
    {
      "id": "3",
      "title": "MRI Brain Scan",
      "category": "imaging",
      "date": "2024-01-05",
      "doctor": "Dr. Emily Rodriguez",
      "hospital": "Neurological Institute",
      "status": "Completed",
      "priority": "High",
      "diagnosis": "No abnormalities detected",
      "treatment": "No immediate treatment required",
      "notes": "MRI scan of brain shows no structural abnormalities. Follow-up in 6 months recommended.",
      "attachments": [
        {"name": "MRI_Brain_Report.pdf", "size": "1.8 MB", "type": "pdf"},
        {"name": "MRI_Images.dicom", "size": "45.2 MB", "type": "dicom"},
        {"name": "Radiologist_Notes.pdf", "size": "0.9 MB", "type": "pdf"}
      ],
      "findings": {
        "structuralAbnormalities": "None",
        "contrastEnhancement": "None",
        "ventricularSize": "Normal",
        "whiteMatter": "Normal"
      }
    },
    {
      "id": "4",
      "title": "Blood Work - Comprehensive Panel",
      "category": "lab",
      "date": "2024-01-03",
      "doctor": "Dr. Sarah Johnson",
      "hospital": "Metropolitan Medical Center",
      "status": "Completed",
      "priority": "Normal",
      "diagnosis": "All values within normal range",
      "treatment": "Continue current medications",
      "notes": "Comprehensive metabolic panel shows all values within normal limits. Lipid profile excellent.",
      "attachments": [
        {"name": "Blood_Work_Report.pdf", "size": "1.1 MB", "type": "pdf"},
        {"name": "Lab_Values_Chart.pdf", "size": "0.7 MB", "type": "pdf"}
      ],
      "labValues": {
        "glucose": "92 mg/dL",
        "cholesterol": "165 mg/dL",
        "hdl": "58 mg/dL",
        "ldl": "95 mg/dL",
        "triglycerides": "115 mg/dL",
        "creatinine": "1.0 mg/dL"
      }
    },
    {
      "id": "5",
      "title": "COVID-19 Vaccination Record",
      "category": "vaccine",
      "date": "2023-12-15",
      "doctor": "Dr. Jennifer Kim",
      "hospital": "Community Health Center",
      "status": "Completed",
      "priority": "Normal",
      "diagnosis": "Vaccination administered successfully",
      "treatment": "No adverse reactions reported",
      "notes": "COVID-19 booster vaccination administered. Patient advised to monitor for any side effects.",
      "attachments": [
        {"name": "Vaccination_Card.pdf", "size": "0.5 MB", "type": "pdf"},
        {"name": "Vaccine_Info_Sheet.pdf", "size": "0.8 MB", "type": "pdf"}
      ],
      "vaccineInfo": {
        "vaccineName": "Pfizer-BioNTech COVID-19",
        "doseNumber": "Booster",
        "lotNumber": "EK5730",
        "manufacturer": "Pfizer",
        "nextDue": "2024-12-15"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredRecords {
    return medicalRecords.where((record) {
      bool matchesSearch = searchQuery.isEmpty || 
          record["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["doctor"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["diagnosis"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || 
          record["category"].toString().toLowerCase() == selectedCategory.toLowerCase();
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Records"),
        actions: [
          IconButton(
            icon: Icon(showSecure ? Icons.lock : Icons.lock_open),
            onPressed: () {
              showSecure = !showSecure;
              setState(() {});
              ss(showSecure ? "Secure mode enabled" : "Secure mode disabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: () {
              ss("Syncing medical records");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildTabSection(),
          _buildContent(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRecordDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search records, doctors, diagnosis...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: disabledColor,
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildTab("All Records", 0),
          _buildTab("Recent", 1),
          _buildTab("Starred", 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    List<Map<String, dynamic>> displayRecords = filteredRecords;
    
    if (selectedTab == 1) {
      displayRecords = filteredRecords.take(3).toList();
    } else if (selectedTab == 2) {
      displayRecords = []; // Starred records would be stored locally
    }

    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(spMd),
        children: [
          if (showSecure)
            Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Secure Mode: Sensitive information is encrypted",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder_open,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Found ${displayRecords.length} medical records",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ...displayRecords.map((record) => _buildRecordCard(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    Color priorityColor = record["priority"] == "High" ? dangerColor : 
                         record["priority"] == "Medium" ? warningColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: priorityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getCategoryIcon(record["category"]),
                    color: priorityColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${record["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${record["doctor"]} • ${record["hospital"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${record["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(record["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: primaryColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Diagnosis:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${record["diagnosis"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (record["treatment"] != null && record["treatment"].toString().isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.healing,
                          color: successColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Treatment:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${record["treatment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (record["attachments"] != null && (record["attachments"] as List).isNotEmpty) ...[
              SizedBox(height: spMd),
              Text(
                "Attachments (${(record["attachments"] as List).length})",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (record["attachments"] as List).map((attachment) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(40)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getFileIcon(attachment["type"]),
                          color: infoColor,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${attachment["name"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _showRecordDetails(record);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    ss("Sharing medical record");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Downloading record");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.star_border,
                  size: bs.sm,
                  onPressed: () {
                    ss("Added to starred records");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'diagnosis':
        return Icons.medical_services;
      case 'lab':
        return Icons.science;
      case 'imaging':
        return Icons.image;
      case 'prescription':
        return Icons.medication;
      case 'vaccine':
        return Icons.vaccines;
      case 'treatment':
        return Icons.healing;
      default:
        return Icons.folder;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'image':
      case 'jpg':
      case 'png':
        return Icons.image;
      case 'dicom':
        return Icons.medical_services;
      default:
        return Icons.attachment;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Filter Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Priority Level",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              CheckboxListTile(
                title: Text("High Priority", style: TextStyle(fontSize: 14)),
                value: true,
                onChanged: (value) {},
                dense: true,
              ),
              CheckboxListTile(
                title: Text("Normal Priority", style: TextStyle(fontSize: 14)),
                value: false,
                onChanged: (value) {},
                dense: true,
              ),
              SizedBox(height: spSm),
              Text(
                "Date Range",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Last 30 days",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ss("Filters applied");
              },
              child: Text(
                "Apply",
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddRecordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add Medical Record",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Upload Document",
                      icon: Icons.upload_file,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Uploading document");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Scan Document",
                      icon: Icons.camera_alt,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Opening camera to scan document");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Manual Entry",
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Opening manual entry form");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRecordDetails(Map<String, dynamic> record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${record["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Record Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Date: ${DateTime.parse(record["date"]).dMMMy}",
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
                                  Icons.person,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Doctor: ${record["doctor"]}",
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
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Hospital: ${record["hospital"]}",
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
                      SizedBox(height: spMd),
                      Text(
                        "Diagnosis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${record["diagnosis"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (record["treatment"] != null) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Treatment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${record["treatment"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                      if (record["notes"] != null) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${record["notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                      // Display specific data based on record type
                      if (record["vitals"] != null) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Vital Signs",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 120,
                          children: (record["vitals"] as Map<String, dynamic>).entries.map((entry) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    entry.key.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${entry.value}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      if (record["attachments"] != null) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Attachments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...((record["attachments"] as List).map((attachment) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getFileIcon(attachment["type"]),
                                  color: infoColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${attachment["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${attachment["size"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.download,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Downloading ${attachment["name"]}");
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList()),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
