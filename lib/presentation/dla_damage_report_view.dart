import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDamageReportView extends StatefulWidget {
  const DlaDamageReportView({super.key});

  @override
  State<DlaDamageReportView> createState() => _DlaDamageReportViewState();
}

class _DlaDamageReportViewState extends State<DlaDamageReportView> {
  String reportId = "";
  String packageId = "PKG-240115-003";
  String deliveryId = "DEL-240115-003";
  String damageType = "physical";
  String damageSeverity = "minor";
  String damageLocation = "package_exterior";
  String damageDescription = "";
  String reportedBy = "driver";
  String customerName = "Alice Johnson";
  String customerPhone = "+62 812-5555-7890";
  bool customerNotified = false;
  bool photosRequired = true;
  bool photosTaken = false;
  String damageNotes = "";
  
  final List<Map<String, dynamic>> damageTypeOptions = [
    {"label": "Physical Damage", "value": "physical"},
    {"label": "Water Damage", "value": "water"},
    {"label": "Crushing/Compression", "value": "crushing"},
    {"label": "Tearing", "value": "tearing"},
    {"label": "Missing Parts", "value": "missing_parts"},
    {"label": "Wrong Item", "value": "wrong_item"},
    {"label": "Contamination", "value": "contamination"},
    {"label": "Temperature Damage", "value": "temperature"},
    {"label": "Electronic Malfunction", "value": "electronic"},
    {"label": "Other", "value": "other"},
  ];

  final List<Map<String, dynamic>> severityOptions = [
    {"label": "Minor", "value": "minor"},
    {"label": "Moderate", "value": "moderate"},
    {"label": "Major", "value": "major"},
    {"label": "Total Loss", "value": "total_loss"},
  ];

  final List<Map<String, dynamic>> locationOptions = [
    {"label": "Package Exterior", "value": "package_exterior"},
    {"label": "Package Contents", "value": "package_contents"},
    {"label": "Both Exterior & Contents", "value": "both"},
    {"label": "Protective Packaging", "value": "protective_packaging"},
    {"label": "Labels/Documentation", "value": "labels"},
  ];

  final List<Map<String, dynamic>> reporterOptions = [
    {"label": "Delivery Driver", "value": "driver"},
    {"label": "Customer", "value": "customer"},
    {"label": "Warehouse Staff", "value": "warehouse"},
    {"label": "Supervisor", "value": "supervisor"},
    {"label": "Third Party", "value": "third_party"},
  ];

  final List<String> damagePhotos = [
    "https://picsum.photos/300/200?random=30",
    "https://picsum.photos/300/200?random=31",
    "https://picsum.photos/300/200?random=32",
    "https://picsum.photos/300/200?random=33",
  ];

  Widget _buildDamageHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.report_problem, color: dangerColor, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Damage Report",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Document package damage incident",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Package ID:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      packageId,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Delivery ID:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      deliveryId,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
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
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Customer Information",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Name",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        customerName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        customerPhone,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: customerNotified ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        customerNotified ? Icons.check_circle : Icons.cancel,
                        color: customerNotified ? successColor : dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        customerNotified ? "Customer Notified" : "Not Notified",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: customerNotified ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Notify",
                icon: Icons.notifications,
                size: bs.sm,
                onPressed: () {
                  customerNotified = true;
                  setState(() {});
                  ss("Customer notified about damage");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDamageDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.assignment, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Damage Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Report ID",
            value: reportId,
            hint: "Enter or generate report ID",
            onChanged: (value) {
              reportId = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Damage Type",
            items: damageTypeOptions,
            value: damageType,
            onChanged: (value, label) {
              damageType = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Severity",
                  items: severityOptions,
                  value: damageSeverity,
                  onChanged: (value, label) {
                    damageSeverity = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locationOptions,
                  value: damageLocation,
                  onChanged: (value, label) {
                    damageLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Reported By",
            items: reporterOptions,
            value: reportedBy,
            onChanged: (value, label) {
              reportedBy = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Damage Description",
            value: damageDescription,
            hint: "Describe the damage in detail...",
            onChanged: (value) {
              damageDescription = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDamagePhotos() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.camera_alt, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Damage Documentation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (photosTaken)
                Icon(Icons.check_circle, color: successColor, size: 24),
            ],
          ),
          if (photosRequired)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Photos are required to document damage evidence",
                      style: TextStyle(
                        fontSize: 13,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (damagePhotos.isNotEmpty) ...[
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: damagePhotos.asMap().entries.map((entry) {
                  int index = entry.key;
                  String photo = entry.value;
                  return Container(
                    width: 160,
                    margin: EdgeInsets.only(right: spSm),
                    child: Stack(
                      children: [
                        Container(
                          width: 160,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage(photo),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spXs,
                          left: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Photo ${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Take Photos",
                  icon: Icons.camera_alt,
                  size: bs.sm,
                  onPressed: () {
                    photosTaken = true;
                    setState(() {});
                    ss("Damage photos captured");
                  },
                ),
              ),
              if (damagePhotos.isNotEmpty)
                QButton(
                  label: "View All",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("View all damage photos");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDamageAssessment() {
    Color severityColor = damageSeverity == "minor" 
        ? successColor 
        : damageSeverity == "moderate" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.assessment, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Damage Assessment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: severityColor),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      damageSeverity == "minor" 
                          ? Icons.info 
                          : damageSeverity == "moderate" 
                              ? Icons.warning 
                              : Icons.error,
                      color: severityColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Severity: ${damageSeverity.toUpperCase()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: severityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  _getSeverityDescription(),
                  style: TextStyle(
                    fontSize: 14,
                    color: severityColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Damage Type",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        damageType.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        damageLocation.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalNotes() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Investigation Notes",
            value: damageNotes,
            hint: "Add investigation findings, potential causes, recommendations...",
            onChanged: (value) {
              damageNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String _getSeverityDescription() {
    switch (damageSeverity) {
      case "minor":
        return "Package can still be delivered with minor cosmetic damage";
      case "moderate":
        return "Package condition affects usability, customer should be contacted";
      case "major":
        return "Significant damage that may affect product function";
      case "total_loss":
        return "Package completely unusable, replacement required";
      default:
        return "Damage assessment required";
    }
  }

  bool get canSubmitReport {
    return reportId.isNotEmpty && 
           damageDescription.isNotEmpty && 
           (photosRequired ? photosTaken : true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Damage Report"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              si("Help with damage reporting");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDamageHeader(),
            _buildCustomerInfo(),
            _buildDamageDetails(),
            _buildDamagePhotos(),
            _buildDamageAssessment(),
            _buildAdditionalNotes(),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel Report",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () {
                      sw("Damage report cancelled");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Submit Report",
                    color: canSubmitReport ? primaryColor : disabledBoldColor,
                    size: bs.md,
                    onPressed: canSubmitReport ? () {
                      ss("Damage report submitted successfully!");
                    } : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
