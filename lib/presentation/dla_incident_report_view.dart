import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaIncidentReportView extends StatefulWidget {
  const DlaIncidentReportView({super.key});

  @override
  State<DlaIncidentReportView> createState() => _DlaIncidentReportViewState();
}

class _DlaIncidentReportViewState extends State<DlaIncidentReportView> {
  String incidentId = "";
  String incidentType = "vehicle";
  String incidentSeverity = "minor";
  String incidentLocation = "";
  String incidentTime = "";
  String incidentDate = "";
  String incidentDescription = "";
  String reportedBy = "driver";
  String reporterName = "Driver Name";
  String reporterPhone = "+62 812-1234-5678";
  bool emergencyServices = false;
  bool policeInvolved = false;
  bool injuriesReported = false;
  bool photosTaken = false;
  String actionsTaken = "";
  String followUpRequired = "";
  
  final List<Map<String, dynamic>> incidentTypeOptions = [
    {"label": "Vehicle Accident", "value": "vehicle"},
    {"label": "Traffic Violation", "value": "traffic"},
    {"label": "Vehicle Breakdown", "value": "breakdown"},
    {"label": "Theft/Security", "value": "theft"},
    {"label": "Personal Injury", "value": "injury"},
    {"label": "Weather Related", "value": "weather"},
    {"label": "Road Conditions", "value": "road"},
    {"label": "Customer Incident", "value": "customer"},
    {"label": "Package Related", "value": "package"},
    {"label": "Equipment Malfunction", "value": "equipment"},
    {"label": "Other", "value": "other"},
  ];

  final List<Map<String, dynamic>> severityOptions = [
    {"label": "Minor", "value": "minor"},
    {"label": "Moderate", "value": "moderate"},
    {"label": "Major", "value": "major"},
    {"label": "Critical", "value": "critical"},
  ];

  final List<Map<String, dynamic>> reporterOptions = [
    {"label": "Delivery Driver", "value": "driver"},
    {"label": "Customer", "value": "customer"},
    {"label": "Witness", "value": "witness"},
    {"label": "Police Officer", "value": "police"},
    {"label": "Supervisor", "value": "supervisor"},
    {"label": "Third Party", "value": "third_party"},
  ];

  final List<String> incidentPhotos = [
    "https://picsum.photos/300/200?random=40",
    "https://picsum.photos/300/200?random=41",
    "https://picsum.photos/300/200?random=42",
  ];

  Widget _buildIncidentHeader() {
    Color severityColor = incidentSeverity == "minor" 
        ? successColor 
        : incidentSeverity == "moderate" 
            ? warningColor 
            : incidentSeverity == "major"
                ? dangerColor
                : Colors.red.shade900;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: severityColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: severityColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: severityColor, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Incident Report",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: severityColor,
                      ),
                    ),
                    Text(
                      "Document delivery incident details",
                      style: TextStyle(
                        fontSize: 14,
                        color: severityColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  incidentSeverity.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: severityColor,
                  ),
                ),
              ),
            ],
          ),
          if (incidentId.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "Incident ID:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    incidentId,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIncidentDetails() {
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
                "Incident Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Incident ID",
            value: incidentId,
            hint: "Enter or generate incident ID",
            onChanged: (value) {
              incidentId = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Incident Type",
                  items: incidentTypeOptions,
                  value: incidentType,
                  onChanged: (value, label) {
                    incidentType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Severity",
                  items: severityOptions,
                  value: incidentSeverity,
                  onChanged: (value, label) {
                    incidentSeverity = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Incident Location",
            value: incidentLocation,
            hint: "Street address or landmark where incident occurred",
            onChanged: (value) {
              incidentLocation = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Incident Date",
                  value: incidentDate.isNotEmpty ? DateTime.parse(incidentDate) : DateTime.now(),
                  onChanged: (value) {
                    incidentDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTimePicker(
                  label: "Incident Time",
                  value: incidentTime.isNotEmpty ? incidentTime.timeOfDay : TimeOfDay.now(),
                  onChanged: (value) {
                    incidentTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Incident Description",
            value: incidentDescription,
            hint: "Provide detailed description of what happened...",
            onChanged: (value) {
              incidentDescription = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReporterInfo() {
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
                "Reporter Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Reporter Name",
                  value: reporterName,
                  hint: "Full name of person reporting",
                  onChanged: (value) {
                    reporterName = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: reporterPhone,
                  hint: "+62 XXX-XXXX-XXXX",
                  onChanged: (value) {
                    reporterPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentFlags() {
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
              Icon(Icons.flag, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Incident Flags",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    emergencyServices = !emergencyServices;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: emergencyServices ? dangerColor.withAlpha(20) : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: emergencyServices ? dangerColor : disabledBoldColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          emergencyServices ? Icons.check_box : Icons.check_box_outline_blank,
                          color: emergencyServices ? dangerColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Emergency Services Called",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: emergencyServices ? dangerColor : disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    policeInvolved = !policeInvolved;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: policeInvolved ? warningColor.withAlpha(20) : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: policeInvolved ? warningColor : disabledBoldColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          policeInvolved ? Icons.check_box : Icons.check_box_outline_blank,
                          color: policeInvolved ? warningColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Police Involved",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: policeInvolved ? warningColor : disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              injuriesReported = !injuriesReported;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: injuriesReported ? dangerColor.withAlpha(20) : disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: injuriesReported ? dangerColor : disabledBoldColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    injuriesReported ? Icons.check_box : Icons.check_box_outline_blank,
                    color: injuriesReported ? dangerColor : disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Injuries Reported",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: injuriesReported ? dangerColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentPhotos() {
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
                "Incident Documentation",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Take photos of the incident scene, vehicles, and any damage",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (incidentPhotos.isNotEmpty) ...[
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: incidentPhotos.asMap().entries.map((entry) {
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
                    ss("Incident photos captured");
                  },
                ),
              ),
              if (incidentPhotos.isNotEmpty)
                QButton(
                  label: "View All",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("View all incident photos");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionsAndFollowup() {
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
            "Actions & Follow-up",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Actions Taken",
            value: actionsTaken,
            hint: "Describe immediate actions taken during/after the incident...",
            onChanged: (value) {
              actionsTaken = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Follow-up Required",
            value: followUpRequired,
            hint: "List any follow-up actions, investigations, or reports needed...",
            onChanged: (value) {
              followUpRequired = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  bool get canSubmitReport {
    return incidentId.isNotEmpty && 
           incidentDescription.isNotEmpty && 
           incidentLocation.isNotEmpty &&
           reporterName.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Incident Report"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              si("Help with incident reporting");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildIncidentHeader(),
            _buildIncidentDetails(),
            _buildReporterInfo(),
            _buildIncidentFlags(),
            _buildIncidentPhotos(),
            _buildActionsAndFollowup(),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Draft",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {
                      si("Incident report saved as draft");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Submit Report",
                    color: canSubmitReport ? primaryColor : disabledBoldColor,
                    size: bs.md,
                    onPressed: canSubmitReport ? () {
                      ss("Incident report submitted successfully!");
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
