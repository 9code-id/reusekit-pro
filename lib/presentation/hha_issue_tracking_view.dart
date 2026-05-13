import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaIssueTrackingView extends StatefulWidget {
  const HhaIssueTrackingView({super.key});

  @override
  State<HhaIssueTrackingView> createState() => _HhaIssueTrackingViewState();
}

class _HhaIssueTrackingViewState extends State<HhaIssueTrackingView> {
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedDepartment = "All";

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Front Office", "value": "Front Office"},
    {"label": "Food & Beverage", "value": "Food & Beverage"},
    {"label": "IT Support", "value": "IT Support"},
    {"label": "Security", "value": "Security"},
    {"label": "Guest Complaint", "value": "Guest Complaint"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Front Desk", "value": "Front Desk"},
    {"label": "Restaurant", "value": "Restaurant"},
    {"label": "IT Department", "value": "IT Department"},
    {"label": "Security", "value": "Security"},
    {"label": "Management", "value": "Management"},
  ];

  List<Map<String, dynamic>> issues = [
    {
      "id": "ISS001",
      "title": "Air Conditioning Not Working",
      "description": "Room 302 AC unit is not cooling properly",
      "category": "Maintenance",
      "priority": "High",
      "status": "In Progress",
      "reportedBy": "John Smith",
      "assignedTo": "Mike Johnson",
      "department": "Maintenance",
      "location": "Room 302",
      "reportedDate": "2024-01-15T08:30:00",
      "targetDate": "2024-01-15T16:00:00",
      "lastUpdated": "2024-01-15T10:15:00",
      "guestImpacted": true,
      "estimatedCost": 150.0,
      "actualCost": null,
      "notes": "Technician dispatched, checking refrigerant levels",
      "attachments": 2,
      "updates": 3,
    },
    {
      "id": "ISS002",
      "title": "Dirty Bathroom in Room 205",
      "description": "Guest complained about unclean bathroom upon check-in",
      "category": "Housekeeping",
      "priority": "Critical",
      "status": "Resolved",
      "reportedBy": "Sarah Davis",
      "assignedTo": "Maria Santos",
      "department": "Housekeeping",
      "location": "Room 205",
      "reportedDate": "2024-01-14T14:20:00",
      "targetDate": "2024-01-14T15:00:00",
      "lastUpdated": "2024-01-14T14:45:00",
      "guestImpacted": true,
      "estimatedCost": 0.0,
      "actualCost": 0.0,
      "notes": "Room thoroughly cleaned and re-inspected",
      "attachments": 1,
      "updates": 2,
    },
    {
      "id": "ISS003",
      "title": "Wi-Fi Connection Issues",
      "description": "Multiple guests reporting slow internet in floor 3",
      "category": "IT Support",
      "priority": "Medium",
      "status": "Open",
      "reportedBy": "Reception Team",
      "assignedTo": "IT Support",
      "department": "IT Department",
      "location": "Floor 3",
      "reportedDate": "2024-01-15T12:00:00",
      "targetDate": "2024-01-16T09:00:00",
      "lastUpdated": "2024-01-15T12:00:00",
      "guestImpacted": true,
      "estimatedCost": 200.0,
      "actualCost": null,
      "notes": "Initial assessment needed",
      "attachments": 0,
      "updates": 1,
    },
    {
      "id": "ISS004",
      "title": "Broken Elevator Door",
      "description": "Elevator B door sensor malfunction",
      "category": "Maintenance",
      "priority": "Critical",
      "status": "Pending",
      "reportedBy": "Security Guard",
      "assignedTo": "Elevator Company",
      "department": "Maintenance",
      "location": "Elevator B",
      "reportedDate": "2024-01-15T09:15:00",
      "targetDate": "2024-01-15T18:00:00",
      "lastUpdated": "2024-01-15T11:30:00",
      "guestImpacted": true,
      "estimatedCost": 500.0,
      "actualCost": null,
      "notes": "Waiting for technician arrival",
      "attachments": 3,
      "updates": 2,
    },
    {
      "id": "ISS005",
      "title": "Kitchen Equipment Malfunction",
      "description": "Main oven temperature control not working",
      "category": "Food & Beverage",
      "priority": "High",
      "status": "In Progress",
      "reportedBy": "Chef Rodriguez",
      "assignedTo": "Equipment Repair",
      "department": "Restaurant",
      "location": "Main Kitchen",
      "reportedDate": "2024-01-15T06:00:00",
      "targetDate": "2024-01-15T12:00:00",
      "lastUpdated": "2024-01-15T09:45:00",
      "guestImpacted": false,
      "estimatedCost": 300.0,
      "actualCost": 275.0,
      "notes": "Parts ordered, temporary solution implemented",
      "attachments": 1,
      "updates": 4,
    },
    {
      "id": "ISS006",
      "title": "Noisy Neighbors Complaint",
      "description": "Guest in 405 complaining about noise from 406",
      "category": "Guest Complaint",
      "priority": "Medium",
      "status": "Closed",
      "reportedBy": "Night Manager",
      "assignedTo": "Security",
      "department": "Security",
      "location": "Floor 4",
      "reportedDate": "2024-01-14T23:30:00",
      "targetDate": "2024-01-15T00:00:00",
      "lastUpdated": "2024-01-15T00:15:00",
      "guestImpacted": true,
      "estimatedCost": 0.0,
      "actualCost": 0.0,
      "notes": "Issue resolved through guest communication",
      "attachments": 0,
      "updates": 2,
    },
  ];

  List<Map<String, dynamic>> get filteredIssues {
    return issues.where((issue) {
      bool matchesSearch = searchQuery.isEmpty ||
          (issue["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (issue["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (issue["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "All" || issue["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || issue["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || issue["category"] == selectedCategory;
      bool matchesDepartment = selectedDepartment == "All" || issue["department"] == selectedDepartment;
      
      return matchesSearch && matchesPriority && matchesStatus && matchesCategory && matchesDepartment;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return Colors.orange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return Colors.orange;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Issue Tracking"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search issues...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter dropdowns
            QHorizontalScroll(
              children: [
                SizedBox(
                  width: 140,
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
                SizedBox(
                  width: 140,
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
                SizedBox(
                  width: 140,
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
                SizedBox(
                  width: 140,
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                      Row(
                        children: [
                          Icon(Icons.bug_report, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Issues",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${issues.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.priority_high, color: dangerColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Critical",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${issues.where((issue) => issue["priority"] == "Critical").length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.hourglass_empty, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${issues.where((issue) => issue["status"] == "In Progress").length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Resolved",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${issues.where((issue) => issue["status"] == "Resolved" || issue["status"] == "Closed").length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Issues list
            ...filteredIssues.map((issue) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(issue["priority"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(issue["priority"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${issue["priority"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getPriorityColor(issue["priority"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${issue["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (issue["guestImpacted"] as bool)
                                    Padding(
                                      padding: EdgeInsets.only(left: spSm),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Guest Impact",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "${issue["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${issue["description"]}",
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
                            color: _getStatusColor(issue["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${issue["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(issue["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Issue details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${issue["category"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${issue["location"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Assigned: ${issue["assignedTo"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Spacer(),
                              if (issue["attachments"] != null && (issue["attachments"] as int) > 0)
                                Row(
                                  children: [
                                    Icon(Icons.attach_file, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${issue["attachments"]}",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (issue["estimatedCost"] != null && (issue["estimatedCost"] as double) > 0)
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Est. Cost: \$${(issue["estimatedCost"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                ),
                                if (issue["actualCost"] != null && (issue["actualCost"] as double) > 0)
                                  Text(
                                    " | Actual: \$${(issue["actualCost"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w600),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Latest update
                    if (issue["notes"] != null && (issue["notes"] as String).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Latest Update:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "${issue["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Action buttons
                    Row(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        if (issue["status"] != "Closed" && issue["status"] != "Resolved")
                          QButton(
                            label: "Update Status",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        Spacer(),
                        Row(
                          children: [
                            if (issue["updates"] != null && (issue["updates"] as int) > 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${issue["updates"]} updates",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
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
    );
  }
}
