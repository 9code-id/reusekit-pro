import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaDiscoveryDocumentsView extends StatefulWidget {
  const LcaDiscoveryDocumentsView({super.key});

  @override
  State<LcaDiscoveryDocumentsView> createState() => _LcaDiscoveryDocumentsViewState();
}

class _LcaDiscoveryDocumentsViewState extends State<LcaDiscoveryDocumentsView> {
  String searchQuery = "";
  String selectedDocumentType = "";
  String selectedStatus = "";
  String selectedParty = "";
  List<Map<String, dynamic>> filteredDocuments = [];

  List<Map<String, dynamic>> discoveryDocuments = [
    {
      "id": "DD001",
      "title": "Interrogatories - Set One",
      "type": "Interrogatories",
      "caseNumber": "CV-2024-001234",
      "party": "Plaintiff",
      "status": "Served",
      "dateSent": DateTime(2024, 12, 1),
      "dueDate": DateTime(2024, 12, 31),
      "responseDate": null,
      "attorney": "Jennifer Rodriguez",
      "recipientParty": "Defendant",
      "recipientAttorney": "Michael Thompson",
      "questionsCount": 25,
      "description": "Initial set of interrogatories seeking information about defendant's business operations and contract performance.",
      "priority": "High",
      "category": "Initial Discovery",
      "confidential": false,
      "electronicService": true,
      "followUpRequired": true,
      "attachments": 2,
      "tags": ["Contract", "Business Operations", "Performance"]
    },
    {
      "id": "DD002",
      "title": "Request for Production - Documents",
      "type": "Request for Production",
      "caseNumber": "CV-2024-002468",
      "party": "Defendant",
      "status": "Responded",
      "dateSent": DateTime(2024, 11, 15),
      "dueDate": DateTime(2024, 12, 15),
      "responseDate": DateTime(2024, 12, 10),
      "attorney": "David Wilson",
      "recipientParty": "Plaintiff",
      "recipientAttorney": "Lisa Chang",
      "questionsCount": 35,
      "description": "Comprehensive document production request for all communications, contracts, and financial records related to the dispute.",
      "priority": "Critical",
      "category": "Document Production",
      "confidential": true,
      "electronicService": true,
      "followUpRequired": false,
      "attachments": 8,
      "tags": ["Financial Records", "Communications", "Contracts"]
    },
    {
      "id": "DD003",
      "title": "Deposition Notice - CEO",
      "type": "Deposition Notice",
      "caseNumber": "CV-2024-003691",
      "party": "Plaintiff",
      "status": "Scheduled",
      "dateSent": DateTime(2024, 12, 5),
      "dueDate": DateTime(2024, 12, 26),
      "responseDate": null,
      "attorney": "Robert Lee",
      "recipientParty": "Defendant",
      "recipientAttorney": "Thomas Anderson",
      "questionsCount": 0,
      "description": "Notice of deposition for defendant's Chief Executive Officer regarding contract negotiations and performance issues.",
      "priority": "High",
      "category": "Depositions",
      "confidential": false,
      "electronicService": false,
      "followUpRequired": true,
      "attachments": 3,
      "tags": ["Executive", "Contract Negotiations", "Leadership"]
    },
    {
      "id": "DD004",
      "title": "Request for Admissions",
      "type": "Request for Admissions",
      "caseNumber": "CV-2024-004815",
      "party": "Defendant",
      "status": "Draft",
      "dateSent": null,
      "dueDate": DateTime(2025, 1, 15),
      "responseDate": null,
      "attorney": "Amanda Foster",
      "recipientParty": "Plaintiff",
      "recipientAttorney": "Mark Johnson",
      "questionsCount": 20,
      "description": "Requests for admissions regarding key facts and the authenticity of documents to streamline trial preparation.",
      "priority": "Medium",
      "category": "Admissions",
      "confidential": false,
      "electronicService": true,
      "followUpRequired": false,
      "attachments": 1,
      "tags": ["Facts", "Authentication", "Trial Prep"]
    },
    {
      "id": "DD005",
      "title": "Subpoena - Third Party Records",
      "type": "Subpoena",
      "caseNumber": "CV-2024-005937",
      "party": "Plaintiff",
      "status": "Issued",
      "dateSent": DateTime(2024, 12, 8),
      "dueDate": DateTime(2024, 12, 22),
      "responseDate": null,
      "attorney": "Patricia Davis",
      "recipientParty": "Non-Party",
      "recipientAttorney": "External Counsel",
      "questionsCount": 0,
      "description": "Subpoena to third-party financial institution for banking records and transaction history related to the disputed contract.",
      "priority": "Critical",
      "category": "Third Party Discovery",
      "confidential": true,
      "electronicService": false,
      "followUpRequired": true,
      "attachments": 5,
      "tags": ["Banking Records", "Third Party", "Financial"]
    },
    {
      "id": "DD006",
      "title": "Supplemental Interrogatories",
      "type": "Interrogatories",
      "caseNumber": "CV-2024-006159",
      "party": "Plaintiff",
      "status": "Overdue",
      "dateSent": DateTime(2024, 11, 10),
      "dueDate": DateTime(2024, 12, 10),
      "responseDate": null,
      "attorney": "Susan Williams",
      "recipientParty": "Defendant",
      "recipientAttorney": "Kevin Brown",
      "questionsCount": 15,
      "description": "Follow-up interrogatories based on initial responses and newly discovered information from document production.",
      "priority": "High",
      "category": "Supplemental Discovery",
      "confidential": false,
      "electronicService": true,
      "followUpRequired": true,
      "attachments": 4,
      "tags": ["Follow-up", "Supplemental", "Additional Info"]
    }
  ];

  List<Map<String, dynamic>> documentTypeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Interrogatories", "value": "Interrogatories"},
    {"label": "Request for Production", "value": "Request for Production"},
    {"label": "Deposition Notice", "value": "Deposition Notice"},
    {"label": "Request for Admissions", "value": "Request for Admissions"},
    {"label": "Subpoena", "value": "Subpoena"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Draft", "value": "Draft"},
    {"label": "Served", "value": "Served"},
    {"label": "Responded", "value": "Responded"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Issued", "value": "Issued"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  List<Map<String, dynamic>> partyOptions = [
    {"label": "All Parties", "value": ""},
    {"label": "Plaintiff", "value": "Plaintiff"},
    {"label": "Defendant", "value": "Defendant"},
    {"label": "Non-Party", "value": "Non-Party"},
  ];

  @override
  void initState() {
    super.initState();
    _filterDocuments();
  }

  void _filterDocuments() {
    filteredDocuments = discoveryDocuments.where((doc) {
      bool matchesSearch = searchQuery.isEmpty ||
          doc["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          doc["caseNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          doc["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesType = selectedDocumentType.isEmpty || doc["type"] == selectedDocumentType;
      bool matchesStatus = selectedStatus.isEmpty || doc["status"] == selectedStatus;
      bool matchesParty = selectedParty.isEmpty || doc["party"] == selectedParty;

      return matchesSearch && matchesType && matchesStatus && matchesParty;
    }).toList();

    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Responded":
        return successColor;
      case "Served":
        return infoColor;
      case "Issued":
        return primaryColor;
      case "Scheduled":
        return secondaryColor;
      case "Draft":
        return disabledBoldColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discovery Documents"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create discovery document
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    label: "Search Discovery Documents",
                    value: searchQuery,
                    hint: "Search by title, case number, or description...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterDocuments();
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Document Type",
                          items: documentTypeOptions,
                          value: selectedDocumentType,
                          onChanged: (value, label) {
                            selectedDocumentType = value;
                            _filterDocuments();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            _filterDocuments();
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Requesting Party",
                    items: partyOptions,
                    value: selectedParty,
                    onChanged: (value, label) {
                      selectedParty = value;
                      _filterDocuments();
                    },
                  ),
                ],
              ),
            ),

            // Stats Cards
            Row(
              spacing: spSm,
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
                        Text(
                          "${discoveryDocuments.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total Requests",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${discoveryDocuments.where((d) => d["status"] == "Overdue").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Overdue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${discoveryDocuments.where((d) => d["status"] == "Responded").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
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

            // Documents List
            Text(
              "Discovery Documents (${filteredDocuments.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredDocuments.map((document) {
              bool isOverdue = document["status"] == "Overdue" ||
                  (document["dueDate"] != null && 
                   (document["dueDate"] as DateTime).isBefore(DateTime.now()) &&
                   document["responseDate"] == null);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isOverdue ? Border(
                    left: BorderSide(
                      width: 4,
                      color: dangerColor,
                    ),
                  ) : null,
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(spSm),
                  childrenPadding: EdgeInsets.all(spSm),
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${document["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${document["type"]} • Case: ${document["caseNumber"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(document["status"]).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${document["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(document["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: spXs),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${document["party"]} → ${document["recipientParty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(document["priority"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${document["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(document["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${document["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          Row(
                            spacing: spMd,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Attorney",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${document["attorney"]}",
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
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${document["category"]}",
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

                          Row(
                            spacing: spMd,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document["dateSent"] != null ? "Date Sent" : "Scheduled Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      document["dateSent"] != null 
                                          ? "${(document["dateSent"] as DateTime).dMMMy}"
                                          : "Not yet sent",
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
                                      "Due Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(document["dueDate"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isOverdue ? dangerColor : primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          if (document["responseDate"] != null) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Response Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(document["responseDate"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          if ((document["questionsCount"] as int) > 0) ...[
                            Row(
                              spacing: spMd,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document["type"] == "Interrogatories" 
                                            ? "Questions" 
                                            : document["type"] == "Request for Production" 
                                                ? "Requests" 
                                                : "Items",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${document["questionsCount"]}",
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
                                        "Attachments",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${document["attachments"]}",
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
                          ],

                          // Status Indicators
                          Row(
                            spacing: spSm,
                            children: [
                              _buildStatusIndicator(
                                "Confidential",
                                document["confidential"] as bool,
                              ),
                              _buildStatusIndicator(
                                "E-Service",
                                document["electronicService"] as bool,
                              ),
                              _buildStatusIndicator(
                                "Follow-up",
                                document["followUpRequired"] as bool,
                              ),
                            ],
                          ),

                          // Tags
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (document["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          Row(
                            spacing: spSm,
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Edit",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to edit document
                                  },
                                ),
                              ),
                              Expanded(
                                child: QButton(
                                  label: "View",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to view document details
                                  },
                                ),
                              ),
                              if (document["followUpRequired"] as bool) ...[
                                Expanded(
                                  child: QButton(
                                    label: "Follow-up",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Create follow-up request
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? successColor.withAlpha(51) : disabledColor.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 12,
            color: isActive ? successColor : disabledBoldColor,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isActive ? successColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
