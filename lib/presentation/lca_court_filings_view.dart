import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCourtFilingsView extends StatefulWidget {
  const LcaCourtFilingsView({super.key});

  @override
  State<LcaCourtFilingsView> createState() => _LcaCourtFilingsViewState();
}

class _LcaCourtFilingsViewState extends State<LcaCourtFilingsView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedCourt = "";
  String selectedFilingType = "";
  List<Map<String, dynamic>> filteredFilings = [];

  List<Map<String, dynamic>> courtFilings = [
    {
      "id": "CF001",
      "title": "Motion to Dismiss",
      "caseNumber": "CV-2024-001234",
      "court": "Superior Court of California",
      "judge": "Hon. Sarah Martinez",
      "filingType": "Motion",
      "status": "Filed",
      "filingDate": DateTime(2024, 12, 15),
      "dueDate": DateTime(2024, 12, 29),
      "docketNumber": "DOC-2024-5678",
      "priority": "High",
      "attorney": "Michael Thompson",
      "party": "Defendant",
      "amount": 0.0,
      "pages": 25,
      "attachments": 3,
      "description": "Motion to dismiss all claims for failure to state a cause of action and lack of subject matter jurisdiction.",
      "serviceCompleted": true,
      "electronicFiling": true,
      "feesPaid": true,
      "tags": ["Motion", "Dismissal", "Civil"]
    },
    {
      "id": "CF002",
      "title": "Complaint for Breach of Contract",
      "caseNumber": "CV-2024-002468",
      "court": "Los Angeles County Superior Court",
      "judge": "Hon. Robert Chen",
      "filingType": "Complaint",
      "status": "Pending Review",
      "filingDate": DateTime(2024, 12, 10),
      "dueDate": DateTime(2024, 12, 24),
      "docketNumber": "DOC-2024-9012",
      "priority": "Critical",
      "attorney": "Jennifer Rodriguez",
      "party": "Plaintiff",
      "amount": 250000.0,
      "pages": 42,
      "attachments": 8,
      "description": "Initial complaint alleging breach of software licensing agreement and seeking monetary damages.",
      "serviceCompleted": false,
      "electronicFiling": true,
      "feesPaid": true,
      "tags": ["Complaint", "Contract", "Commercial"]
    },
    {
      "id": "CF003",
      "title": "Answer to Complaint",
      "caseNumber": "CV-2024-003691",
      "court": "Orange County Superior Court",
      "judge": "Hon. Amanda Foster",
      "filingType": "Answer",
      "status": "Draft",
      "filingDate": DateTime(2024, 12, 20),
      "dueDate": DateTime(2024, 12, 31),
      "docketNumber": "DOC-2024-3456",
      "priority": "Medium",
      "attorney": "David Wilson",
      "party": "Defendant",
      "amount": 0.0,
      "pages": 18,
      "attachments": 2,
      "description": "Formal response to plaintiff's complaint with affirmative defenses and counterclaims.",
      "serviceCompleted": false,
      "electronicFiling": false,
      "feesPaid": false,
      "tags": ["Answer", "Defense", "Civil"]
    },
    {
      "id": "CF004",
      "title": "Summary Judgment Motion",
      "caseNumber": "CV-2024-004815",
      "court": "San Diego County Superior Court",
      "judge": "Hon. Mark Johnson",
      "filingType": "Motion",
      "status": "Scheduled",
      "filingDate": DateTime(2024, 12, 5),
      "dueDate": DateTime(2025, 1, 15),
      "docketNumber": "DOC-2024-7890",
      "priority": "High",
      "attorney": "Lisa Chang",
      "party": "Plaintiff",
      "amount": 500000.0,
      "pages": 67,
      "attachments": 15,
      "description": "Motion for summary judgment on all claims with supporting declarations and evidence.",
      "serviceCompleted": true,
      "electronicFiling": true,
      "feesPaid": true,
      "tags": ["Motion", "Summary Judgment", "Civil"]
    },
    {
      "id": "CF005",
      "title": "Discovery Motion to Compel",
      "caseNumber": "CV-2024-005937",
      "court": "Riverside County Superior Court",
      "judge": "Hon. Patricia Davis",
      "filingType": "Discovery Motion",
      "status": "Hearing Set",
      "filingDate": DateTime(2024, 11, 28),
      "dueDate": DateTime(2024, 12, 22),
      "docketNumber": "DOC-2024-2345",
      "priority": "Medium",
      "attorney": "Robert Lee",
      "party": "Plaintiff",
      "amount": 0.0,
      "pages": 31,
      "attachments": 6,
      "description": "Motion to compel defendant's responses to interrogatories and document production requests.",
      "serviceCompleted": true,
      "electronicFiling": false,
      "feesPaid": true,
      "tags": ["Discovery", "Motion to Compel", "Civil"]
    },
    {
      "id": "CF006",
      "title": "Appeal Brief",
      "caseNumber": "B324567",
      "court": "California Court of Appeal",
      "judge": "Hon. Susan Williams",
      "filingType": "Appeal",
      "status": "Under Review",
      "filingDate": DateTime(2024, 11, 20),
      "dueDate": DateTime(2025, 1, 30),
      "docketNumber": "DOC-2024-6789",
      "priority": "Critical",
      "attorney": "Thomas Anderson",
      "party": "Appellant",
      "amount": 1000000.0,
      "pages": 89,
      "attachments": 25,
      "description": "Opening brief challenging trial court's summary judgment ruling and requesting reversal.",
      "serviceCompleted": true,
      "electronicFiling": true,
      "feesPaid": true,
      "tags": ["Appeal", "Brief", "Appellate"]
    }
  ];

  List<Map<String, dynamic>> filingStatusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending Review", "value": "Pending Review"},
    {"label": "Filed", "value": "Filed"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Hearing Set", "value": "Hearing Set"},
    {"label": "Under Review", "value": "Under Review"},
  ];

  List<Map<String, dynamic>> courtOptions = [
    {"label": "All Courts", "value": ""},
    {"label": "Superior Court of California", "value": "Superior Court of California"},
    {"label": "Los Angeles County Superior Court", "value": "Los Angeles County Superior Court"},
    {"label": "Orange County Superior Court", "value": "Orange County Superior Court"},
    {"label": "San Diego County Superior Court", "value": "San Diego County Superior Court"},
    {"label": "Riverside County Superior Court", "value": "Riverside County Superior Court"},
    {"label": "California Court of Appeal", "value": "California Court of Appeal"},
  ];

  List<Map<String, dynamic>> filingTypeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Motion", "value": "Motion"},
    {"label": "Complaint", "value": "Complaint"},
    {"label": "Answer", "value": "Answer"},
    {"label": "Discovery Motion", "value": "Discovery Motion"},
    {"label": "Appeal", "value": "Appeal"},
  ];

  @override
  void initState() {
    super.initState();
    _filterFilings();
  }

  void _filterFilings() {
    filteredFilings = courtFilings.where((filing) {
      bool matchesSearch = searchQuery.isEmpty ||
          filing["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          filing["caseNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          filing["court"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus.isEmpty || filing["status"] == selectedStatus;
      bool matchesCourt = selectedCourt.isEmpty || filing["court"] == selectedCourt;
      bool matchesType = selectedFilingType.isEmpty || filing["filingType"] == selectedFilingType;

      return matchesSearch && matchesStatus && matchesCourt && matchesType;
    }).toList();

    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Filed":
        return successColor;
      case "Under Review":
        return infoColor;
      case "Pending Review":
        return warningColor;
      case "Draft":
        return disabledBoldColor;
      case "Scheduled":
        return primaryColor;
      case "Hearing Set":
        return secondaryColor;
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
        title: Text("Court Filings"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add filing
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
                    label: "Search Filings",
                    value: searchQuery,
                    hint: "Search by title, case number, or court...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterFilings();
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: filingStatusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            _filterFilings();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Court",
                          items: courtOptions,
                          value: selectedCourt,
                          onChanged: (value, label) {
                            selectedCourt = value;
                            _filterFilings();
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Filing Type",
                    items: filingTypeOptions,
                    value: selectedFilingType,
                    onChanged: (value, label) {
                      selectedFilingType = value;
                      _filterFilings();
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
                          "${courtFilings.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total Filings",
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
                          "${courtFilings.where((f) => f["status"] == "Draft").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Drafts",
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
                          "${courtFilings.where((f) => (f["dueDate"] as DateTime).difference(DateTime.now()).inDays <= 7).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Due Soon",
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

            // Filings List
            Text(
              "Court Filings (${filteredFilings.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredFilings.map((filing) {
              bool isDueSoon = (filing["dueDate"] as DateTime).difference(DateTime.now()).inDays <= 7;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isDueSoon ? Border(
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
                              "${filing["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Case: ${filing["caseNumber"]}",
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
                          color: _getStatusColor(filing["status"]).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filing["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(filing["status"]),
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
                          Icons.account_balance,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${filing["court"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(filing["priority"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${filing["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(filing["priority"]),
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
                            "${filing["description"]}",
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
                                      "Filing Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(filing["filingDate"] as DateTime).dMMMy}",
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
                                      "${(filing["dueDate"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDueSoon ? dangerColor : primaryColor,
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
                                      "Judge",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${filing["judge"]}",
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
                                      "Attorney",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${filing["attorney"]}",
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
                                      "Docket Number",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${filing["docketNumber"]}",
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
                                      "Pages",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${filing["pages"]} pages",
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

                          if ((filing["amount"] as double) > 0) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount in Dispute",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((filing["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
                                "Service Completed",
                                filing["serviceCompleted"] as bool,
                              ),
                              _buildStatusIndicator(
                                "E-Filing",
                                filing["electronicFiling"] as bool,
                              ),
                              _buildStatusIndicator(
                                "Fees Paid",
                                filing["feesPaid"] as bool,
                              ),
                            ],
                          ),

                          // Tags
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (filing["tags"] as List).map((tag) {
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
                                    // Navigate to edit filing
                                  },
                                ),
                              ),
                              Expanded(
                                child: QButton(
                                  label: "View",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to view filing details
                                  },
                                ),
                              ),
                              if (filing["status"] == "Draft") ...[
                                Expanded(
                                  child: QButton(
                                    label: "File",
                                    size: bs.sm,
                                    onPressed: () {
                                      // File the document
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
