import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaLegalBriefsView extends StatefulWidget {
  const LcaLegalBriefsView({super.key});

  @override
  State<LcaLegalBriefsView> createState() => _LcaLegalBriefsViewState();
}

class _LcaLegalBriefsViewState extends State<LcaLegalBriefsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedPriority = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "draft"},
    {"label": "In Review", "value": "in_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "Filed", "value": "filed"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Motion", "value": "motion"},
    {"label": "Memorandum", "value": "memorandum"},
    {"label": "Brief", "value": "brief"},
    {"label": "Opinion", "value": "opinion"},
    {"label": "Research", "value": "research"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Urgent", "value": "urgent"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> legalBriefs = [
    {
      "id": 1,
      "title": "Motion to Dismiss - Lack of Jurisdiction",
      "briefNumber": "MB-2024-001",
      "caseNumber": "CV-2024-001",
      "caseName": "Johnson vs. Acme Corporation",
      "category": "motion",
      "status": "filed",
      "priority": "high",
      "author": "Michael Rodriguez",
      "reviewer": "Sarah Mitchell",
      "wordCount": 3450,
      "pageCount": 12,
      "dateCreated": "2024-01-10",
      "dateModified": "2024-01-15",
      "fileDueDate": "2024-01-18",
      "courtDate": "2024-01-25",
      "jurisdiction": "Superior Court of California",
      "practiceArea": "Civil Litigation",
      "tags": ["jurisdiction", "motion to dismiss", "civil procedure"],
      "citations": 15,
      "attachments": 3,
      "confidentialityLevel": "Attorney-Client Privileged",
      "description": "Motion arguing lack of personal jurisdiction over defendant based on insufficient minimum contacts with the forum state",
      "keyArguments": [
        "Defendant lacks sufficient minimum contacts with California",
        "Exercise of jurisdiction would violate due process",
        "Forum selection clause requires litigation in Delaware"
      ],
    },
    {
      "id": 2,
      "title": "Legal Memorandum - Contract Interpretation",
      "briefNumber": "LM-2024-002",
      "caseNumber": "CO-2024-005",
      "caseName": "TechStart Inc. Incorporation",
      "category": "memorandum",
      "status": "approved",
      "priority": "medium",
      "author": "Lisa Chen",
      "reviewer": "David Thompson",
      "wordCount": 2890,
      "pageCount": 8,
      "dateCreated": "2024-01-08",
      "dateModified": "2024-01-14",
      "fileDueDate": null,
      "courtDate": null,
      "jurisdiction": "Delaware Chancery Court",
      "practiceArea": "Corporate Law",
      "tags": ["contract interpretation", "corporate law", "Delaware law"],
      "citations": 22,
      "attachments": 1,
      "confidentialityLevel": "Work Product",
      "description": "Analysis of contract interpretation principles under Delaware law for technology licensing agreement",
      "keyArguments": [
        "Plain meaning rule applies to unambiguous contract terms",
        "Course of dealing supports client's interpretation",
        "Industry custom supports broad licensing rights"
      ],
    },
    {
      "id": 3,
      "title": "Appellate Brief - Employment Discrimination",
      "briefNumber": "AB-2024-003",
      "caseNumber": "EM-2024-007",
      "caseName": "Rodriguez vs. Global Industries",
      "category": "brief",
      "status": "in_review",
      "priority": "urgent",
      "author": "Jennifer Adams",
      "reviewer": "Mark Johnson",
      "wordCount": 8750,
      "pageCount": 28,
      "dateCreated": "2024-01-05",
      "dateModified": "2024-01-13",
      "fileDueDate": "2024-01-20",
      "courtDate": "2024-02-15",
      "jurisdiction": "9th Circuit Court of Appeals",
      "practiceArea": "Employment Law",
      "tags": ["employment discrimination", "Title VII", "appellate practice"],
      "citations": 47,
      "attachments": 8,
      "confidentialityLevel": "Public Record",
      "description": "Appellate brief challenging district court's grant of summary judgment in employment discrimination case",
      "keyArguments": [
        "Genuine issues of material fact preclude summary judgment",
        "District court applied incorrect legal standard",
        "Evidence supports inference of discriminatory intent"
      ],
    },
    {
      "id": 4,
      "title": "Research Memo - Intellectual Property Trends",
      "briefNumber": "RM-2024-004",
      "caseNumber": null,
      "caseName": "General Research",
      "category": "research",
      "status": "draft",
      "priority": "low",
      "author": "David Park",
      "reviewer": null,
      "wordCount": 5200,
      "pageCount": 18,
      "dateCreated": "2024-01-12",
      "dateModified": "2024-01-12",
      "fileDueDate": "2024-01-30",
      "courtDate": null,
      "jurisdiction": "Federal Courts",
      "practiceArea": "Intellectual Property",
      "tags": ["IP trends", "patent law", "trademark", "research"],
      "citations": 35,
      "attachments": 2,
      "confidentialityLevel": "Internal Use",
      "description": "Comprehensive research on recent developments in intellectual property law affecting technology companies",
      "keyArguments": [
        "Recent Supreme Court decisions limit patent eligibility",
        "USPTO guidance creates new prosecution strategies",
        "Circuit split developing on software patents"
      ],
    },
    {
      "id": 5,
      "title": "Opinion Letter - Securities Compliance",
      "briefNumber": "OL-2024-005",
      "caseNumber": "SE-2024-003",
      "caseName": "InvestCorp Private Placement",
      "category": "opinion",
      "status": "draft",
      "priority": "high",
      "author": "Anna Wilson",
      "reviewer": "Michael Rodriguez",
      "wordCount": 4100,
      "pageCount": 14,
      "dateCreated": "2024-01-09",
      "dateModified": "2024-01-11",
      "fileDueDate": "2024-01-22",
      "courtDate": null,
      "jurisdiction": "SEC",
      "practiceArea": "Securities Law",
      "tags": ["securities", "private placement", "compliance", "regulation D"],
      "citations": 18,
      "attachments": 5,
      "confidentialityLevel": "Attorney-Client Privileged",
      "description": "Legal opinion on compliance with federal securities laws for private placement offering",
      "keyArguments": [
        "Offering qualifies for Rule 506(b) exemption",
        "All disclosure requirements have been satisfied",
        "Investor accreditation properly verified"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredBriefs {
    return legalBriefs.where((brief) {
      bool matchesSearch = brief["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          brief["briefNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (brief["caseNumber"] != null && brief["caseNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesStatus = selectedStatus == "All" || brief["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || brief["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || brief["priority"] == selectedPriority;
      
      if (currentTab == 1) { // My Briefs
        return matchesSearch && matchesStatus && matchesCategory && matchesPriority && brief["author"] == "Michael Rodriguez";
      } else if (currentTab == 2) { // Urgent
        return matchesSearch && matchesStatus && matchesCategory && brief["priority"] == "urgent";
      }
      
      return matchesSearch && matchesStatus && matchesCategory && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "draft":
        return warningColor;
      case "in_review":
        return infoColor;
      case "approved":
        return successColor;
      case "filed":
        return primaryColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "motion":
        return "Motion";
      case "memorandum":
        return "Memorandum";
      case "brief":
        return "Brief";
      case "opinion":
        return "Opinion";
      case "research":
        return "Research";
      default:
        return category.toUpperCase();
    }
  }

  bool _isOverdue(String? dueDate) {
    if (dueDate == null) return false;
    return DateTime.parse(dueDate).isBefore(DateTime.now());
  }

  Widget _buildBriefCard(Map<String, dynamic> brief) {
    bool isOverdue = _isOverdue(brief["fileDueDate"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isOverdue
            ? Border.all(color: dangerColor, width: 2)
            : Border(
                left: BorderSide(
                  width: 4,
                  color: _getPriorityColor("${brief["priority"]}"),
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${brief["briefNumber"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getCategoryLabel("${brief["category"]}"),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${brief["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${brief["status"]}".toUpperCase().replaceAll("_", " "),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${brief["status"]}"),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${brief["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${brief["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getPriorityColor("${brief["priority"]}"),
                  ),
                ),
              ),
            ],
          ),
          if (isOverdue) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: dangerColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "OVERDUE: Due ${brief["fileDueDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Text(
            "${brief["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          if (brief["caseNumber"] != null)
            Text(
              "Case: ${brief["caseNumber"]} - ${brief["caseName"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: infoColor,
              ),
            ),
          SizedBox(height: spXs),
          Text(
            "${brief["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Author: ${brief["author"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (brief["reviewer"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.rate_review, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Reviewer: ${brief["reviewer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.description, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${brief["pageCount"]} pages, ${brief["wordCount"]} words",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.format_quote, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${brief["citations"]} citations",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.business, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${brief["jurisdiction"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${brief["practiceArea"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (brief["fileDueDate"] != null && !isOverdue) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "Due: ${brief["fileDueDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ],
          if (brief["courtDate"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.gavel, size: 16, color: dangerColor),
                SizedBox(width: spXs),
                Text(
                  "Court Date: ${brief["courtDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          ExpansionTile(
            title: Row(
              children: [
                Text(
                  "Key Arguments & Details",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${brief["confidentialityLevel"]}",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Key Arguments:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(brief["keyArguments"] as List).map(
                      (argument) => Padding(
                        padding: EdgeInsets.only(left: spSm, bottom: 4),
                        child: Text(
                          "• $argument",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Tags:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (brief["tags"] as List).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Brief",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int urgentCount = legalBriefs.where((b) => b["priority"] == "urgent").length;
    int overdueCount = legalBriefs.where((b) => _isOverdue(b["fileDueDate"])).length;
    
    return QTabBar(
      title: "Legal Briefs",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Briefs", icon: Icon(Icons.description)),
        Tab(text: "My Briefs", icon: Icon(Icons.person)),
        Tab(text: "Urgent", icon: Icon(Icons.priority_high)),
      ],
      tabChildren: [
        // All Briefs Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alert for overdue briefs
              if (overdueCount > 0)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: dangerColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: dangerColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "$overdueCount brief${overdueCount > 1 ? 's are' : ' is'} overdue",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Filter to show overdue
                        },
                        child: Text(
                          "View",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Search and Filters
              QTextField(
                label: "Search briefs",
                value: searchQuery,
                hint: "Search by title, number, or case",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
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
                      label: "Category",
                      items: categoryOptions,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              QDropdownField(
                label: "Priority",
                items: priorityOptions,
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Stats Cards
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
                          Icon(Icons.description, color: primaryColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "${legalBriefs.length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Briefs",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
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
                          Icon(Icons.priority_high, color: dangerColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "$urgentCount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "Urgent",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
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
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "${legalBriefs.where((b) => b["status"] == "approved" || b["status"] == "filed").length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
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
                          Icon(Icons.error, color: warningColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "$overdueCount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Briefs List
              Text(
                "Legal Briefs (${filteredBriefs.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              if (filteredBriefs.isEmpty)
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
                      Icon(Icons.description_outlined, size: 64, color: disabledColor),
                      SizedBox(height: spSm),
                      Text(
                        "No briefs found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Try adjusting your search or filter criteria",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: filteredBriefs.map((brief) => _buildBriefCard(brief)).toList(),
                ),
            ],
          ),
        ),
        
        // My Briefs Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: filteredBriefs.map((brief) => _buildBriefCard(brief)).toList(),
          ),
        ),
        
        // Urgent Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: filteredBriefs.map((brief) => _buildBriefCard(brief)).toList(),
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional tab controller access
      },
    );
  }
}
