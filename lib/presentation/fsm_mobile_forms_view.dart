import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobileFormsView extends StatefulWidget {
  const FsmMobileFormsView({super.key});

  @override
  State<FsmMobileFormsView> createState() => _FsmMobileFormsViewState();
}

class _FsmMobileFormsViewState extends State<FsmMobileFormsView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";

  List<Map<String, dynamic>> forms = [
    {
      "id": "FORM-001",
      "title": "Work Order Completion Report",
      "description": "Standard form for documenting work order completion details",
      "category": "Work Orders",
      "status": "Draft",
      "lastModified": "2024-12-20 14:30:00",
      "createdBy": "Alex Johnson",
      "workOrder": "WO-2024-001",
      "customer": "Metro Office Complex",
      "progress": 75,
      "fields": [
        {"name": "customerName", "label": "Customer Name", "type": "text", "required": true, "value": "Metro Office Complex"},
        {"name": "workDescription", "label": "Work Description", "type": "textarea", "required": true, "value": "HVAC system maintenance and filter replacement"},
        {"name": "startTime", "label": "Start Time", "type": "time", "required": true, "value": "08:15"},
        {"name": "endTime", "label": "End Time", "type": "time", "required": true, "value": "12:00"},
        {"name": "materialsUsed", "label": "Materials Used", "type": "multiselect", "required": false, "value": "Air Filter, Coolant"},
        {"name": "customerSignature", "label": "Customer Signature", "type": "signature", "required": true, "value": ""},
      ],
      "icon": Icons.assignment_turned_in,
      "color": primaryColor,
    },
    {
      "id": "FORM-002",
      "title": "Safety Inspection Checklist",
      "description": "Comprehensive safety inspection form for job sites",
      "category": "Safety",
      "status": "Completed",
      "lastModified": "2024-12-20 11:45:00",
      "createdBy": "Maria Rodriguez",
      "workOrder": "",
      "customer": "Construction Site Alpha",
      "progress": 100,
      "fields": [
        {"name": "inspectorName", "label": "Inspector Name", "type": "text", "required": true, "value": "Maria Rodriguez"},
        {"name": "siteLocation", "label": "Site Location", "type": "text", "required": true, "value": "Construction Site Alpha"},
        {"name": "ppeCheck", "label": "PPE Check", "type": "checkbox", "required": true, "value": "true"},
        {"name": "equipmentCheck", "label": "Equipment Safety", "type": "checkbox", "required": true, "value": "true"},
        {"name": "hazardIdentification", "label": "Hazards Identified", "type": "textarea", "required": false, "value": "None observed"},
        {"name": "inspectorSignature", "label": "Inspector Signature", "type": "signature", "required": true, "value": "signed"},
      ],
      "icon": Icons.security,
      "color": successColor,
    },
    {
      "id": "FORM-003",
      "title": "Customer Satisfaction Survey",
      "description": "Post-service customer feedback and satisfaction rating",
      "category": "Customer Service",
      "status": "Pending",
      "lastModified": "2024-12-20 09:20:00",
      "createdBy": "David Kim",
      "workOrder": "WO-2024-003",
      "customer": "Creative Design Studio",
      "progress": 40,
      "fields": [
        {"name": "customerName", "label": "Customer Name", "type": "text", "required": true, "value": "Creative Design Studio"},
        {"name": "serviceDate", "label": "Service Date", "type": "date", "required": true, "value": "2024-12-20"},
        {"name": "overallSatisfaction", "label": "Overall Satisfaction", "type": "rating", "required": true, "value": ""},
        {"name": "technicianProfessionalism", "label": "Technician Professionalism", "type": "rating", "required": true, "value": ""},
        {"name": "workQuality", "label": "Work Quality", "type": "rating", "required": true, "value": ""},
        {"name": "additionalComments", "label": "Additional Comments", "type": "textarea", "required": false, "value": ""},
      ],
      "icon": Icons.rate_review,
      "color": infoColor,
    },
    {
      "id": "FORM-004",
      "title": "Equipment Maintenance Log",
      "description": "Regular maintenance tracking for service equipment",
      "category": "Equipment",
      "status": "In Progress",
      "lastModified": "2024-12-20 13:10:00",
      "createdBy": "Sarah Wilson",
      "workOrder": "",
      "customer": "",
      "progress": 60,
      "fields": [
        {"name": "equipmentId", "label": "Equipment ID", "type": "text", "required": true, "value": "VAN-12-HVAC-001"},
        {"name": "maintenanceType", "label": "Maintenance Type", "type": "select", "required": true, "value": "Routine Inspection"},
        {"name": "maintenanceDate", "label": "Maintenance Date", "type": "date", "required": true, "value": "2024-12-20"},
        {"name": "technician", "label": "Technician", "type": "text", "required": true, "value": "Sarah Wilson"},
        {"name": "conditionBefore", "label": "Condition Before", "type": "textarea", "required": true, "value": "Equipment functioning normally"},
        {"name": "workPerformed", "label": "Work Performed", "type": "textarea", "required": true, "value": ""},
        {"name": "conditionAfter", "label": "Condition After", "type": "textarea", "required": false, "value": ""},
      ],
      "icon": Icons.build,
      "color": warningColor,
    },
    {
      "id": "FORM-005",
      "title": "Incident Report",
      "description": "Documentation form for workplace incidents and accidents",
      "category": "Safety",
      "status": "Submitted",
      "lastModified": "2024-12-19 16:30:00",
      "createdBy": "James Chen",
      "workOrder": "",
      "customer": "",
      "progress": 100,
      "fields": [
        {"name": "incidentDate", "label": "Incident Date", "type": "date", "required": true, "value": "2024-12-19"},
        {"name": "incidentTime", "label": "Incident Time", "type": "time", "required": true, "value": "15:45"},
        {"name": "location", "label": "Location", "type": "text", "required": true, "value": "Warehouse A"},
        {"name": "incidentType", "label": "Incident Type", "type": "select", "required": true, "value": "Minor Injury"},
        {"name": "description", "label": "Description", "type": "textarea", "required": true, "value": "Employee slipped on wet floor"},
        {"name": "witnesses", "label": "Witnesses", "type": "text", "required": false, "value": "John Doe, Jane Smith"},
        {"name": "reporterSignature", "label": "Reporter Signature", "type": "signature", "required": true, "value": "signed"},
      ],
      "icon": Icons.report_problem,
      "color": dangerColor,
    },
    {
      "id": "FORM-006",
      "title": "Material Request Form",
      "description": "Request form for additional materials and supplies",
      "category": "Inventory",
      "status": "Approved",
      "lastModified": "2024-12-20 10:15:00",
      "createdBy": "Alex Johnson",
      "workOrder": "WO-2024-001",
      "customer": "",
      "progress": 100,
      "fields": [
        {"name": "requestedBy", "label": "Requested By", "type": "text", "required": true, "value": "Alex Johnson"},
        {"name": "requestDate", "label": "Request Date", "type": "date", "required": true, "value": "2024-12-20"},
        {"name": "urgency", "label": "Urgency Level", "type": "select", "required": true, "value": "Normal"},
        {"name": "materials", "label": "Materials Needed", "type": "textarea", "required": true, "value": "2x HVAC Filters MERV-13, 1x Coolant R410A"},
        {"name": "justification", "label": "Justification", "type": "textarea", "required": true, "value": "Customer equipment requires immediate maintenance"},
        {"name": "approverSignature", "label": "Approver Signature", "type": "signature", "required": true, "value": "signed"},
      ],
      "icon": Icons.list,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> get filteredForms {
    return forms.where((form) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${form["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${form["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${form["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory.isEmpty || form["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || form["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Pending":
        return infoColor;
      case "Completed":
        return successColor;
      case "Submitted":
        return successColor;
      case "Approved":
        return primaryColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Draft":
        return Icons.edit;
      case "In Progress":
        return Icons.work;
      case "Pending":
        return Icons.schedule;
      case "Completed":
        return Icons.check_circle;
      case "Submitted":
        return Icons.send;
      case "Approved":
        return Icons.verified;
      case "Rejected":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Forms"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // navigateTo('CreateFormView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                  QTextField(
                    label: "Search forms...",
                    value: searchQuery,
                    hint: "Search by title, description, or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": ""},
                            {"label": "Work Orders", "value": "Work Orders"},
                            {"label": "Safety", "value": "Safety"},
                            {"label": "Customer Service", "value": "Customer Service"},
                            {"label": "Equipment", "value": "Equipment"},
                            {"label": "Inventory", "value": "Inventory"},
                          ],
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
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": ""},
                            {"label": "Draft", "value": "Draft"},
                            {"label": "In Progress", "value": "In Progress"},
                            {"label": "Pending", "value": "Pending"},
                            {"label": "Completed", "value": "Completed"},
                            {"label": "Submitted", "value": "Submitted"},
                            {"label": "Approved", "value": "Approved"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Forms Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.description, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${forms.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Forms",
                          style: TextStyle(
                            fontSize: 12,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.work, color: warningColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${forms.where((f) => f["status"] == "In Progress" || f["status"] == "Draft").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${forms.where((f) => f["status"] == "Completed" || f["status"] == "Submitted").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
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
                      Icon(Icons.flash_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
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
                        child: QButton(
                          label: "New Work Order Form",
                          icon: Icons.assignment,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('NewWorkOrderFormView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Safety Checklist",
                          icon: Icons.security,
                          color: successColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('SafetyChecklistView')
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Customer Survey",
                          icon: Icons.rate_review,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('CustomerSurveyView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Incident Report",
                          icon: Icons.report_problem,
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('IncidentReportView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Forms List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.folder_open, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Forms (${filteredForms.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredForms.map((form) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (form["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  form["icon"] as IconData,
                                  color: form["color"] as Color,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${form["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${form["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getStatusColor("${form["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      getStatusIcon("${form["status"]}"),
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${form["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${form["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if ("${form["customer"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.business, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "${form["customer"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          if ("${form["workOrder"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.work, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "Work Order: ${form["workOrder"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "Created by: ${form["createdBy"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse("${form["lastModified"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ("${form["status"]}" == "In Progress" || "${form["status"]}" == "Draft")
                            Column(
                              children: [
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Progress: ${form["progress"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                LinearProgressIndicator(
                                  value: (form["progress"] as num) / 100,
                                  backgroundColor: disabledColor.withAlpha(50),
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              QButton(
                                label: "Open Form",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('FormDetailView')
                                },
                              ),
                              SizedBox(width: spSm),
                              if ("${form["status"]}" == "Draft" || "${form["status"]}" == "In Progress")
                                QButton(
                                  label: "Continue",
                                  size: bs.sm,
                                  color: successColor,
                                  onPressed: () {
                                    // navigateTo('EditFormView')
                                  },
                                ),
                              if ("${form["status"]}" == "Completed")
                                QButton(
                                  label: "Submit",
                                  size: bs.sm,
                                  color: primaryColor,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Submit this form?");
                                    if (isConfirmed) {
                                      ss("Form submitted successfully");
                                    }
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
