import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPhotoEvidenceView extends StatefulWidget {
  const LtaPhotoEvidenceView({super.key});

  @override
  State<LtaPhotoEvidenceView> createState() => _LtaPhotoEvidenceViewState();
}

class _LtaPhotoEvidenceViewState extends State<LtaPhotoEvidenceView> {
  String selectedCategory = "damage";
  String selectedSeverity = "medium";
  String description = "";
  String location = "";
  String reportedBy = "";
  List<String> evidencePhotos = [];
  DateTime incidentDate = DateTime.now();
  String incidentTime = "${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}";
  String witnessName = "";
  String witnessContact = "";
  String actionTaken = "";
  bool immediateAction = false;

  List<Map<String, dynamic>> categoryItems = [
    {
      "label": "Package Damage",
      "value": "damage",
    },
    {
      "label": "Delivery Issue",
      "value": "delivery",
    },
    {
      "label": "Vehicle Incident",
      "value": "vehicle",
    },
    {
      "label": "Safety Concern",
      "value": "safety",
    },
    {
      "label": "Customer Complaint",
      "value": "complaint",
    },
    {
      "label": "Other",
      "value": "other",
    },
  ];

  List<Map<String, dynamic>> severityItems = [
    {
      "label": "Low",
      "value": "low",
    },
    {
      "label": "Medium",
      "value": "medium",
    },
    {
      "label": "High",
      "value": "high",
    },
    {
      "label": "Critical",
      "value": "critical",
    },
  ];

  Color getSeverityColor(String severity) {
    switch (severity) {
      case "low":
        return successColor;
      case "medium":
        return warningColor;
      case "high":
        return dangerColor;
      case "critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _submitPhotoEvidence() async {
    if (evidencePhotos.isEmpty) {
      se("Please add at least one photo evidence");
      return;
    }

    if (description.isEmpty) {
      se("Please provide a description of the incident");
      return;
    }

    if (location.isEmpty) {
      se("Please specify the location");
      return;
    }

    if (reportedBy.isEmpty) {
      se("Please enter who reported this incident");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    ss("Photo evidence report submitted successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Evidence"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Photo evidence reporting guidelines");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Incident Category and Severity
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Incident Classification",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Severity",
                          items: severityItems,
                          value: selectedSeverity,
                          onChanged: (value, label) {
                            selectedSeverity = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: getSeverityColor(selectedSeverity).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: getSeverityColor(selectedSeverity).withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.priority_high,
                          color: getSeverityColor(selectedSeverity),
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Severity Level: ${selectedSeverity.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: getSeverityColor(selectedSeverity),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Photo Evidence
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Photo Evidence",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "*Required",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  QMultiImagePicker(
                    label: "Add Evidence Photos",
                    value: evidencePhotos,
                    maxImages: 10,
                    hint: "Take clear photos showing the incident",
                    validator: (images) {
                      if (images == null || images.isEmpty) {
                        return "At least one photo is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      evidencePhotos = value;
                      setState(() {});
                    },
                  ),
                  if (evidencePhotos.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${evidencePhotos.length} phoss('Next page') added",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Incident Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Incident Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "*Required",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  QMemoField(
                    label: "Description",
                    value: description,
                    hint: "Provide detailed description of what happened",
                    validator: Validator.required,
                    onChanged: (value) {
                      description = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Location",
                    value: location,
                    hint: "Exact location where incident occurred",
                    validator: Validator.required,
                    onChanged: (value) {
                      location = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: 'Incident Date',
                          value: incidentDate,
                          onChanged: (value) {
                            incidentDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: 'Incident Time',
                          value: TimeOfDay.fromDateTime(incidentDate),
                          onChanged: (value) {
                            if (value != null) {
                              incidentTime = value.kkmm;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Reporter Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Reporter Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "*Required",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Reported By",
                    value: reportedBy,
                    hint: "Name of person reporting this incident",
                    validator: Validator.required,
                    onChanged: (value) {
                      reportedBy = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Witness Name (Optional)",
                    value: witnessName,
                    hint: "Name of witness if any",
                    onChanged: (value) {
                      witnessName = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Witness Contact (Optional)",
                    value: witnessContact,
                    hint: "Phone or email of witness",
                    onChanged: (value) {
                      witnessContact = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Actions Taken
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_turned_in,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Actions Taken",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Immediate action was required and taken",
                        "value": true,
                        "checked": immediateAction,
                      }
                    ],
                    value: [if (immediateAction) {"label": "Immediate action was required and taken", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      immediateAction = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Action Taken",
                    value: actionTaken,
                    hint: "Describe any actions taken to address the incident",
                    onChanged: (value) {
                      actionTaken = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Priority Alert
            if (selectedSeverity == "high" || selectedSeverity == "critical")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: dangerColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "High Priority Alert",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "This incident will be escalated immediately to management due to its severity level.",
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

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Photo Evidence Report",
                size: bs.md,
                onPressed: _submitPhotoEvidence,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
