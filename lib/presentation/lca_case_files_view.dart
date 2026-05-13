import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseFilesView extends StatefulWidget {
  const LcaCaseFilesView({super.key});

  @override
  State<LcaCaseFilesView> createState() => _LcaCaseFilesViewState();
}

class _LcaCaseFilesViewState extends State<LcaCaseFilesView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Closed", "value": "closed"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> cases = [
    {
      "id": 1,
      "caseNumber": "CV-2024-001",
      "title": "Johnson vs. Acme Corporation",
      "client": "Sarah Johnson",
      "attorney": "Michael Rodriguez",
      "status": "active",
      "priority": "high",
      "caseType": "Personal Injury",
      "dateOpened": "2024-01-10",
      "lastActivity": "2024-01-15",
      "nextDeadline": "2024-01-25",
      "documentCount": 47,
      "totalSize": "125.8 MB",
      "description": "Slip and fall accident at client's workplace resulting in severe back injury",
      "courtDate": "2024-02-15",
      "estimatedValue": 250000,
    },
    {
      "id": 2,
      "caseNumber": "CR-2024-002",
      "title": "State vs. Williams",
      "client": "Robert Williams",
      "attorney": "Lisa Chen",
      "status": "pending",
      "priority": "high",
      "caseType": "Criminal Defense",
      "dateOpened": "2024-01-08",
      "lastActivity": "2024-01-14",
      "nextDeadline": "2024-01-20",
      "documentCount": 23,
      "totalSize": "67.4 MB",
      "description": "DUI charges with potential license suspension and criminal penalties",
      "courtDate": "2024-01-28",
      "estimatedValue": null,
    },
    {
      "id": 3,
      "caseNumber": "FL-2024-003",
      "title": "Martinez Family Custody",
      "client": "Elena Martinez",
      "attorney": "David Thompson",
      "status": "active",
      "priority": "medium",
      "caseType": "Family Law",
      "dateOpened": "2024-01-05",
      "lastActivity": "2024-01-13",
      "nextDeadline": "2024-01-30",
      "documentCount": 31,
      "totalSize": "89.2 MB",
      "description": "Child custody dispute following divorce proceedings",
      "courtDate": "2024-02-10",
      "estimatedValue": null,
    },
    {
      "id": 4,
      "caseNumber": "RE-2024-004",
      "title": "Commercial Property Dispute",
      "client": "Downtown Properties LLC",
      "attorney": "Jennifer Adams",
      "status": "closed",
      "priority": "low",
      "caseType": "Real Estate",
      "dateOpened": "2023-11-15",
      "lastActivity": "2024-01-10",
      "nextDeadline": null,
      "documentCount": 156,
      "totalSize": "245.7 MB",
      "description": "Boundary dispute between commercial property owners",
      "courtDate": null,
      "estimatedValue": 75000,
    },
    {
      "id": 5,
      "caseNumber": "CO-2024-005",
      "title": "TechStart Inc. Incorporation",
      "client": "TechStart Inc.",
      "attorney": "Mark Johnson",
      "status": "on_hold",
      "priority": "medium",
      "caseType": "Corporate",
      "dateOpened": "2024-01-12",
      "lastActivity": "2024-01-12",
      "nextDeadline": "2024-02-05",
      "documentCount": 12,
      "totalSize": "15.3 MB",
      "description": "Business incorporation and initial legal setup for technology startup",
      "courtDate": null,
      "estimatedValue": null,
    },
  ];

  List<Map<String, dynamic>> get filteredCases {
    return cases.where((caseItem) {
      bool matchesSearch = caseItem["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          caseItem["caseNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          caseItem["client"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || caseItem["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || caseItem["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "closed":
        return disabledBoldColor;
      case "on_hold":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildCaseCard(Map<String, dynamic> caseItem) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor("${caseItem["priority"]}"),
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
                  "${caseItem["caseNumber"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${caseItem["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseItem["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${caseItem["status"]}"),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${caseItem["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseItem["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getPriorityColor("${caseItem["priority"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${caseItem["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${caseItem["description"]}",
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
                "Client: ${caseItem["client"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.account_balance, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${caseItem["attorney"]}",
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
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${caseItem["caseType"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.folder, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${caseItem["documentCount"]} docs (${caseItem["totalSize"]})",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (caseItem["nextDeadline"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "Next Deadline: ${caseItem["nextDeadline"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ],
          if (caseItem["courtDate"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.gavel, size: 16, color: dangerColor),
                SizedBox(width: spXs),
                Text(
                  "Court Date: ${caseItem["courtDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ],
          if (caseItem["estimatedValue"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.attach_money, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Est. Value: \$${((caseItem["estimatedValue"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Files",
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

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Files"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new case
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search cases",
              value: searchQuery,
              hint: "Search by case number, title, or client",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Filters
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
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Stats Overview
            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    "Total Cases",
                    "${cases.length}",
                    Icons.folder,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "Active",
                    "${cases.where((c) => c["status"] == "active").length}",
                    Icons.play_arrow,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "High Priority",
                    "${cases.where((c) => c["priority"] == "high").length}",
                    Icons.priority_high,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "This Month",
                    "${cases.where((c) => c["dateOpened"].toString().startsWith("2024-01")).length}",
                    Icons.calendar_today,
                    infoColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Cases List
            Row(
              children: [
                Text(
                  "Cases (${filteredCases.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedStatus != "All" || selectedPriority != "All") ...[
                  SizedBox(width: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "FILTERED",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: spSm),

            if (filteredCases.isEmpty)
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
                    Icon(Icons.search_off, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No cases found",
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
                children: filteredCases.map((caseItem) => _buildCaseCard(caseItem)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
