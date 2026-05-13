import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaAddMedicalRecordView extends StatefulWidget {
  const MhaAddMedicalRecordView({super.key});

  @override
  State<MhaAddMedicalRecordView> createState() => _MhaAddMedicalRecordViewState();
}

class _MhaAddMedicalRecordViewState extends State<MhaAddMedicalRecordView> {
  final formKey = GlobalKey<FormState>();
  
  String recordType = "";
  String title = "";
  String description = "";
  String doctorName = "";
  String hospital = "";
  String recordDate = "";
  String followUpDate = "";
  List<String> attachments = [];
  String severity = "";
  String status = "";
  String notes = "";
  
  List<Map<String, dynamic>> recordTypeOptions = [
    {"label": "Prescription", "value": "prescription", "icon": Icons.medication},
    {"label": "Lab Result", "value": "lab_result", "icon": Icons.biotech},
    {"label": "Diagnosis", "value": "diagnosis", "icon": Icons.health_and_safety},
    {"label": "Surgery", "value": "surgery", "icon": Icons.medical_services},
    {"label": "Allergy", "value": "allergy", "icon": Icons.warning},
    {"label": "Vaccination", "value": "vaccination", "icon": Icons.vaccines},
    {"label": "X-Ray/Imaging", "value": "imaging", "icon": Icons.camera_alt},
    {"label": "Consultation", "value": "consultation", "icon": Icons.person},
  ];
  
  List<Map<String, dynamic>> severityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Completed", "value": "completed"},
    {"label": "Ongoing", "value": "ongoing"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medical Record"),
        actions: [
          GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                if (recordType.isEmpty) {
                  se("Please select a record type");
                  return;
                }
                ss("Medical record added successfully");
                back();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Add a new medical record to your health profile for better care management",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Text(
                "Record Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 160,
                children: recordTypeOptions.map((type) {
                  bool isSelected = recordType == type["value"];
                  return GestureDetector(
                    onTap: () {
                      recordType = type["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            type["icon"] as IconData,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${type["label"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              Text(
                "Record Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Record Title",
                value: title,
                validator: Validator.required,
                hint: "e.g., Blood Pressure Medication",
                onChanged: (value) {
                  title = value;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Description",
                value: description,
                hint: "Detailed description of the medical record",
                onChanged: (value) {
                  description = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Doctor/Provider",
                      value: doctorName,
                      validator: Validator.required,
                      hint: "Dr. John Smith",
                      onChanged: (value) {
                        doctorName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QTextField(
                      label: "Hospital/Clinic",
                      value: hospital,
                      hint: "City General Hospital",
                      onChanged: (value) {
                        hospital = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Record Date",
                      value: recordDate.isNotEmpty ? DateTime.parse(recordDate) : null,
                      onChanged: (value) {
                        recordDate = value.toString().split(' ')[0];
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QDatePicker(
                      label: "Follow-up Date (Optional)",
                      value: followUpDate.isNotEmpty ? DateTime.parse(followUpDate) : null,
                      onChanged: (value) {
                        followUpDate = value.toString().split(' ')[0];
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Severity",
                      items: severityOptions,
                      value: severity,
                      onChanged: (value, label) {
                        severity = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions,
                      value: status,
                      onChanged: (value, label) {
                        status = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QMemoField(
                label: "Additional Notes",
                value: notes,
                hint: "Any additional notes or observations",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),
              
              QMultiImagePicker(
                label: "Attachments",
                value: attachments,
                hint: "Add photos, documents, or reports",
                helper: "Upload medical reports, test results, or prescription images",
                maxImages: 10,
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Medical Record",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (recordType.isEmpty) {
                        se("Please select a record type");
                        return;
                      }
                      ss("Medical record added successfully");
                      back();
                    }
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
