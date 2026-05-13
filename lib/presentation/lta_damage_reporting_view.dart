import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDamageReportingView extends StatefulWidget {
  const LtaDamageReportingView({super.key});

  @override
  State<LtaDamageReportingView> createState() => _LtaDamageReportingViewState();
}

class _LtaDamageReportingViewState extends State<LtaDamageReportingView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedSeverity = "All Severity";
  String selectedType = "All Types";

  // Form variables for new damage report
  String reportId = "";
  String shipmentId = "";
  String damageType = "";
  String severityLevel = "";
  String description = "";
  String reporterName = "";
  String reporterRole = "";
  List<String> damagePhotos = [];
  String location = "";
  String estimatedCost = "";
  bool customerNotified = false;
  bool insuranceClaim = false;
  String immediateAction = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Reported", "value": "reported"},
    {"label": "Under Investigation", "value": "investigating"},
    {"label": "Assessment Complete", "value": "assessed"},
    {"label": "Claim Filed", "value": "claim_filed"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
  ];

  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severity", "value": "All Severity"},
    {"label": "Minor", "value": "minor"},
    {"label": "Moderate", "value": "moderate"},
    {"label": "Major", "value": "major"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Package Damage", "value": "package"},
    {"label": "Vehicle Damage", "value": "vehicle"},
    {"label": "Property Damage", "value": "property"},
    {"label": "Personnel Injury", "value": "injury"},
  ];

  List<Map<String, dynamic>> damageTypeItems = [
    {"label": "Select Damage Type", "value": ""},
    {"label": "Crushed/Broken", "value": "crushed"},
    {"label": "Water Damage", "value": "water"},
    {"label": "Torn/Ripped", "value": "torn"},
    {"label": "Scratched", "value": "scratched"},
    {"label": "Missing Items", "value": "missing"},
    {"label": "Contamination", "value": "contamination"},
    {"label": "Temperature Damage", "value": "temperature"},
    {"label": "Shock/Impact", "value": "impact"},
  ];

  List<Map<String, dynamic>> severityItems = [
    {"label": "Select Severity", "value": ""},
    {"label": "Minor - Cosmetic only", "value": "minor"},
    {"label": "Moderate - Functional impact", "value": "moderate"},
    {"label": "Major - Significant damage", "value": "major"},
    {"label": "Critical - Total loss", "value": "critical"},
  ];

  List<Map<String, dynamic>> roleItems = [
    {"label": "Select Role", "value": ""},
    {"label": "Driver", "value": "driver"},
    {"label": "Warehouse Staff", "value": "warehouse"},
    {"label": "Customer", "value": "customer"},
    {"label": "Supervisor", "value": "supervisor"},
    {"label": "Inspector", "value": "inspector"},
  ];

  List<Map<String, dynamic>> damageReports = [
    {
      "id": "DMG-2024-001",
      "reportNumber": "RPT001",
      "shipmentId": "SHP-2024-001",
      "orderId": "ORD-2024-001",
      "damageType": "package",
      "severity": "major",
      "status": "investigating",
      "reportDate": "2024-03-15T09:30:00Z",
      "description": "Package severely crushed during transport. Contents partially damaged.",
      "reporter": {
        "name": "John Smith",
        "role": "driver",
        "contact": "+1-555-0123"
      },
      "shipment": {
        "customer": "TechCorp Solutions",
        "destination": "123 Main St, Los Angeles, CA",
        "value": 2500.00,
        "items": "Electronics - Laptop Computer"
      },
      "damage": {
        "estimatedCost": 800.00,
        "affectedItems": "Laptop screen cracked, case damaged",
        "location": "Loading dock",
        "timeOccurred": "2024-03-15T08:45:00Z"
      },
      "photos": [
        "https://picsum.photos/400/300?random=1&keyword=damage",
        "https://picsum.photos/400/300?random=2&keyword=broken",
        "https://picsum.photos/400/300?random=3&keyword=crushed"
      ],
      "actions": {
        "customerNotified": true,
        "insuranceClaim": true,
        "immediateAction": "Package quarantined, customer contacted",
        "nextSteps": "Insurance assessment scheduled"
      },
      "resolution": {
        "approved": false,
        "claimAmount": 0.00,
        "resolvedDate": null,
        "notes": ""
      }
    },
    {
      "id": "DMG-2024-002",
      "reportNumber": "RPT002",
      "shipmentId": "SHP-2024-002",
      "orderId": "ORD-2024-002",
      "damageType": "water",
      "severity": "moderate",
      "status": "assessed",
      "reportDate": "2024-03-14T16:20:00Z",
      "description": "Water damage to packaging during transport in rain. Contents appear intact.",
      "reporter": {
        "name": "Sarah Johnson",
        "role": "driver",
        "contact": "+1-555-0124"
      },
      "shipment": {
        "customer": "Fashion Boutique Inc",
        "destination": "456 Oak Ave, San Francisco, CA",
        "value": 1200.00,
        "items": "Clothing - Seasonal Collection"
      },
      "damage": {
        "estimatedCost": 150.00,
        "affectedItems": "Outer packaging only, contents dry",
        "location": "Delivery route",
        "timeOccurred": "2024-03-14T15:30:00Z"
      },
      "photos": [
        "https://picsum.photos/400/300?random=4&keyword=water",
        "https://picsum.photos/400/300?random=5&keyword=wet"
      ],
      "actions": {
        "customerNotified": true,
        "insuranceClaim": false,
        "immediateAction": "Package delivered with damage noted",
        "nextSteps": "Customer accepted delivery"
      },
      "resolution": {
        "approved": true,
        "claimAmount": 150.00,
        "resolvedDate": "2024-03-15T10:00:00Z",
        "notes": "Customer satisfied with resolution"
      }
    },
    {
      "id": "DMG-2024-003",
      "reportNumber": "RPT003",
      "shipmentId": "SHP-2024-003",
      "orderId": "ORD-2024-003",
      "damageType": "vehicle",
      "severity": "minor",
      "status": "resolved",
      "reportDate": "2024-03-13T11:15:00Z",
      "description": "Minor scratch on vehicle door from loading dock contact.",
      "reporter": {
        "name": "Mike Wilson",
        "role": "warehouse",
        "contact": "+1-555-0125"
      },
      "shipment": {
        "customer": "Home Goods Ltd",
        "destination": "789 Pine St, Seattle, WA",
        "value": 800.00,
        "items": "Furniture - Dining Set"
      },
      "damage": {
        "estimatedCost": 200.00,
        "affectedItems": "Delivery truck door panel",
        "location": "Warehouse loading dock",
        "timeOccurred": "2024-03-13T10:30:00Z"
      },
      "photos": [
        "https://picsum.photos/400/300?random=6&keyword=scratch",
        "https://picsum.photos/400/300?random=7&keyword=vehicle"
      ],
      "actions": {
        "customerNotified": false,
        "insuranceClaim": false,
        "immediateAction": "Vehicle inspection completed",
        "nextSteps": "Schedule repair appointment"
      },
      "resolution": {
        "approved": true,
        "claimAmount": 200.00,
        "resolvedDate": "2024-03-14T14:00:00Z",
        "notes": "Repair completed successfully"
      }
    },
    {
      "id": "DMG-2024-004",
      "reportNumber": "RPT004",
      "shipmentId": "SHP-2024-004",
      "orderId": "ORD-2024-004",
      "damageType": "missing",
      "severity": "critical",
      "status": "claim_filed",
      "reportDate": "2024-03-12T14:45:00Z",
      "description": "Entire shipment reported missing during transit. Investigation ongoing.",
      "reporter": {
        "name": "Lisa Anderson",
        "role": "supervisor",
        "contact": "+1-555-0126"
      },
      "shipment": {
        "customer": "Medical Supplies Co",
        "destination": "321 Medical Center Dr, Miami, FL",
        "value": 5000.00,
        "items": "Medical Equipment - Diagnostic Tools"
      },
      "damage": {
        "estimatedCost": 5000.00,
        "affectedItems": "Complete shipment contents",
        "location": "Transit route - unknown",
        "timeOccurred": "2024-03-12T12:00:00Z"
      },
      "photos": [
        "https://picsum.photos/400/300?random=8&keyword=empty",
        "https://picsum.photos/400/300?random=9&keyword=missing"
      ],
      "actions": {
        "customerNotified": true,
        "insuranceClaim": true,
        "immediateAction": "Security investigation initiated",
        "nextSteps": "Police report filed, insurance contacted"
      },
      "resolution": {
        "approved": false,
        "claimAmount": 0.00,
        "resolvedDate": null,
        "notes": "Investigation in progress"
      }
    },
  ];

  List<Map<String, dynamic>> get filteredReports {
    return damageReports.where((report) {
      bool matchesSearch = searchQuery.isEmpty ||
          report["reportNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          report["shipmentId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          report["shipment"]["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "All Status" || report["status"] == selectedStatus;
      bool matchesSeverity = selectedSeverity == "All Severity" || report["severity"] == selectedSeverity;
      bool matchesType = selectedType == "All Types" || report["damageType"] == selectedType;

      return matchesSearch && matchesStatus && matchesSeverity && matchesType;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  void _showCreateReportDialog() {
    // Reset form
    reportId = "DMG-${DateTime.now().year}-${(damageReports.length + 1).toString().padLeft(3, '0')}";
    shipmentId = "";
    damageType = "";
    severityLevel = "";
    description = "";
    reporterName = "";
    reporterRole = "";
    damagePhotos = [];
    location = "";
    estimatedCost = "";
    customerNotified = false;
    insuranceClaim = false;
    immediateAction = "";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          width: 600,
          height: 700,
          child: StatefulBuilder(
            builder: (context, setDialogState) => SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.report, color: dangerColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Create Damage Report",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Report ID (Auto-generated)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.tag, color: disabledBoldColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Report ID: $reportId",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Shipment ID
                  QTextField(
                    label: "Shipment ID",
                    value: shipmentId,
                    hint: "Enter shipment ID",
                    onChanged: (value) {
                      shipmentId = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Damage Type
                  QDropdownField(
                    label: "Damage Type",
                    items: damageTypeItems,
                    value: damageType,
                    onChanged: (value, label) {
                      damageType = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Severity Level
                  QDropdownField(
                    label: "Severity Level",
                    items: severityItems,
                    value: severityLevel,
                    onChanged: (value, label) {
                      severityLevel = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Description
                  QMemoField(
                    label: "Damage Description",
                    value: description,
                    hint: "Provide detailed description of the damage",
                    onChanged: (value) {
                      description = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Reporter Name",
                          value: reporterName,
                          hint: "Enter your name",
                          onChanged: (value) {
                            reporterName = value;
                            setDialogState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Role",
                          items: roleItems,
                          value: reporterRole,
                          onChanged: (value, label) {
                            reporterRole = value;
                            setDialogState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Location of Damage",
                          value: location,
                          hint: "Where did the damage occur?",
                          onChanged: (value) {
                            location = value;
                            setDialogState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Estimated Cost (\$)",
                          value: estimatedCost,
                          onChanged: (value) {
                            estimatedCost = value;
                            setDialogState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Photo Upload
                  QMultiImagePicker(
                    label: "Damage Photos",
                    value: damagePhotos,
                    hint: "Take photos of the damage",
                    maxImages: 5,
                    onChanged: (value) {
                      damagePhotos = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Immediate Action
                  QMemoField(
                    label: "Immediate Action Taken",
                    value: immediateAction,
                    hint: "What immediate steps were taken?",
                    onChanged: (value) {
                      immediateAction = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Checkboxes
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Customer Notified",
                              "value": true,
                              "checked": customerNotified,
                            }
                          ],
                          value: [if (customerNotified) {"label": "Customer Notified", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            customerNotified = values.isNotEmpty;
                            setDialogState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Insurance Claim",
                              "value": true,
                              "checked": insuranceClaim,
                            }
                          ],
                          value: [if (insuranceClaim) {"label": "Insurance Claim", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            insuranceClaim = values.isNotEmpty;
                            setDialogState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Submit Report",
                          onPressed: () async {
                            if (shipmentId.isNotEmpty && damageType.isNotEmpty && description.isNotEmpty) {
                              Navigator.pop(context);
                              await Future.delayed(Duration(milliseconds: 500));
                              ss("Damage report submitted successfully");
                            } else {
                              se("Please fill in all required fields");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showReportDetail(Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 700,
          height: 600,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.report_outlined, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Report ${report["reportNumber"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Shipment: ${report["shipmentId"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(report["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: _getStatusColor(report["status"])),
                      ),
                      child: Text(
                        _getStatusLabel(report["status"]),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(report["status"]),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Report Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoItem("Report Date", DateTime.parse(report["reportDate"]).dMMMy),
                          ),
                          Expanded(
                            child: _buildInfoItem("Damage Type", _getDamageTypeLabel(report["damageType"])),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoItem("Severity", _getSeverityLabel(report["severity"])),
                          ),
                          Expanded(
                            child: _buildInfoItem("Estimated Cost", "\$${(report["damage"]["estimatedCost"] as num).currency}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Shipment Info
                Text(
                  "Shipment Information",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoItem("Customer", report["shipment"]["customer"]),
                          ),
                          Expanded(
                            child: _buildInfoItem("Value", "\$${(report["shipment"]["value"] as num).currency}"),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      _buildInfoItem("Items", report["shipment"]["items"]),
                      SizedBox(height: spSm),
                      _buildInfoItem("Destination", report["shipment"]["destination"]),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Damage Details
                Text(
                  "Damage Details",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoItem("Description", report["description"]),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoItem("Location", report["damage"]["location"]),
                          ),
                          Expanded(
                            child: _buildInfoItem("Time Occurred", DateTime.parse(report["damage"]["timeOccurred"]).dMMMy),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      _buildInfoItem("Affected Items", report["damage"]["affectedItems"]),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Reporter Info
                Text(
                  "Reporter Information",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem("Name", report["reporter"]["name"]),
                      ),
                      Expanded(
                        child: _buildInfoItem("Role", _getRoleLabel(report["reporter"]["role"])),
                      ),
                      Expanded(
                        child: _buildInfoItem("Contact", report["reporter"]["contact"]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Actions Taken
                Text(
                  "Actions & Resolution",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  report["actions"]["customerNotified"] ? Icons.check_circle : Icons.cancel,
                                  color: report["actions"]["customerNotified"] ? successColor : dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Customer Notified",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  report["actions"]["insuranceClaim"] ? Icons.check_circle : Icons.cancel,
                                  color: report["actions"]["insuranceClaim"] ? successColor : dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Insurance Claim",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      _buildInfoItem("Immediate Action", report["actions"]["immediateAction"]),
                      SizedBox(height: spSm),
                      _buildInfoItem("Next Steps", report["actions"]["nextSteps"]),
                      if (report["resolution"]["resolvedDate"] != null) ...[
                        SizedBox(height: spSm),
                        Divider(),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoItem("Resolution Date", DateTime.parse(report["resolution"]["resolvedDate"]).dMMMy),
                            ),
                            Expanded(
                              child: _buildInfoItem("Claim Amount", "\$${(report["resolution"]["claimAmount"] as num).currency}"),
                            ),
                          ],
                        ),
                        if (report["resolution"]["notes"].isNotEmpty) ...[
                          SizedBox(height: spSm),
                          _buildInfoItem("Resolution Notes", report["resolution"]["notes"]),
                        ],
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Photos
                if ((report["photos"] as List).isNotEmpty) ...[
                  Text(
                    "Damage Photos",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: (report["photos"] as List).map<Widget>((photo) {
                      return Container(
                        width: 150,
                        height: 100,
                        margin: EdgeInsets.only(right: spSm),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),
                ],

                // Action Buttons
                Row(
                  children: [
                    if (report["status"] == "reported") ...[
                      Expanded(
                        child: QButton(
                          label: "Start Investigation",
                          onPressed: () {
                            Navigator.pop(context);
                            ss("Investigation started");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    if (report["status"] == "investigating") ...[
                      Expanded(
                        child: QButton(
                          label: "Complete Assessment",
                          onPressed: () {
                            Navigator.pop(context);
                            ss("Assessment completed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    if (report["status"] == "assessed" && report["actions"]["insuranceClaim"]) ...[
                      Expanded(
                        child: QButton(
                          label: "File Insurance Claim",
                          onPressed: () {
                            Navigator.pop(context);
                            ss("Insurance claim filed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    Expanded(
                      child: QButton(
                        label: "Update Report",
                        onPressed: () {
                          Navigator.pop(context);
                          // Open update dialog
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Close",
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "reported": return "Reported";
      case "investigating": return "Under Investigation";
      case "assessed": return "Assessment Complete";
      case "claim_filed": return "Claim Filed";
      case "resolved": return "Resolved";
      case "closed": return "Closed";
      default: return status.toUpperCase();
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "reported": return warningColor;
      case "investigating": return infoColor;
      case "assessed": return primaryColor;
      case "claim_filed": return secondaryColor;
      case "resolved": return successColor;
      case "closed": return disabledBoldColor;
      default: return disabledBoldColor;
    }
  }

  String _getDamageTypeLabel(String type) {
    switch (type) {
      case "package": return "Package Damage";
      case "vehicle": return "Vehicle Damage";
      case "property": return "Property Damage";
      case "injury": return "Personnel Injury";
      case "water": return "Water Damage";
      case "missing": return "Missing Items";
      default: return type.toUpperCase();
    }
  }

  String _getSeverityLabel(String severity) {
    switch (severity) {
      case "minor": return "Minor";
      case "moderate": return "Moderate";
      case "major": return "Major";
      case "critical": return "Critical";
      default: return severity.toUpperCase();
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "minor": return successColor;
      case "moderate": return warningColor;
      case "major": return secondaryColor;
      case "critical": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case "driver": return "Driver";
      case "warehouse": return "Warehouse Staff";
      case "customer": return "Customer";
      case "supervisor": return "Supervisor";
      case "inspector": return "Inspector";
      default: return role.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Damage Reporting"),
        actions: [
          IconButton(
            onPressed: _showCreateReportDialog,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Stats
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.report, color: dangerColor, size: 32),
                              SizedBox(height: spSm),
                              Text(
                                "${damageReports.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Reports",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.pending, color: warningColor, size: 32),
                              SizedBox(height: spSm),
                              Text(
                                "${damageReports.where((r) => r["status"] == "investigating" || r["status"] == "reported").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Active Cases",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.attach_money, color: successColor, size: 32),
                              SizedBox(height: spSm),
                              Text(
                                "\$${((damageReports.map((r) => r["damage"]["estimatedCost"] as num).reduce((a, b) => a + b))).currency}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Damage Cost",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Filters Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Filter Reports",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Search Reports",
                                value: searchQuery,
                                hint: "Search by report number, shipment ID, or customer",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.add,
                              size: bs.sm,
                              onPressed: _showCreateReportDialog,
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Status",
                                items: statusOptions,
                                value: selectedStatus,
                                onChanged: (value, label) {
                                  selectedStatus = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Severity",
                                items: severityOptions,
                                value: selectedSeverity,
                                onChanged: (value, label) {
                                  selectedSeverity = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Type",
                                items: typeOptions,
                                value: selectedType,
                                onChanged: (value, label) {
                                  selectedType = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Reports List
                  Text(
                    "Damage Reports (${filteredReports.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),

                  if (filteredReports.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.report_off, size: 64, color: disabledColor),
                          SizedBox(height: spMd),
                          Text(
                            "No damage reports found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try adjusting your filters or create a new report",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredReports.map((report) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: _getSeverityColor(report["severity"]),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.report_outlined,
                                    color: _getSeverityColor(report["severity"]),
                                    size: 24,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Report ${report["reportNumber"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Shipment: ${report["shipmentId"]} • Customer: ${report["shipment"]["customer"]}",
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
                                      color: _getStatusColor(report["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(color: _getStatusColor(report["status"])),
                                    ),
                                    child: Text(
                                      _getStatusLabel(report["status"]),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(report["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),
                              Text(
                                report["description"],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Damage Type",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          _getDamageTypeLabel(report["damageType"]),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Severity",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: _getSeverityColor(report["severity"]),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              _getSeverityLabel(report["severity"]),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: _getSeverityColor(report["severity"]),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Estimated Cost",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(report["damage"]["estimatedCost"] as num).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: dangerColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Report Date",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          DateTime.parse(report["reportDate"]).dMMMy,
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
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Reported by ${report["reporter"]["name"]} (${_getRoleLabel(report["reporter"]["role"])})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if ((report["photos"] as List).isNotEmpty) ...[
                                    Icon(
                                      Icons.photo_library,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(report["photos"] as List).length} photos",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                  ],
                                  QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () => _showReportDetail(report),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
    );
  }
}
