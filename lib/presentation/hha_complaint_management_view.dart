import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaComplaintManagementView extends StatefulWidget {
  const HhaComplaintManagementView({super.key});

  @override
  State<HhaComplaintManagementView> createState() => _HhaComplaintManagementViewState();
}

class _HhaComplaintManagementViewState extends State<HhaComplaintManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedPriority = "All";
  String selectedAssignee = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {
      "label": "All Status",
      "value": "All",
    },
    {
      "label": "Open",
      "value": "open",
    },
    {
      "label": "In Progress",
      "value": "in_progress",
    },
    {
      "label": "Pending Guest",
      "value": "pending_guest",
    },
    {
      "label": "Resolved",
      "value": "resolved",
    },
    {
      "label": "Closed",
      "value": "closed",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {
      "label": "All Categories",
      "value": "All",
    },
    {
      "label": "Room Issues",
      "value": "room",
    },
    {
      "label": "Service Quality",
      "value": "service",
    },
    {
      "label": "Facility Problems",
      "value": "facility",
    },
    {
      "label": "Billing Disputes",
      "value": "billing",
    },
    {
      "label": "Staff Behavior",
      "value": "staff",
    },
    {
      "label": "Noise Complaints",
      "value": "noise",
    },
    {
      "label": "Food & Beverage",
      "value": "food",
    },
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {
      "label": "All Priority",
      "value": "All",
    },
    {
      "label": "Critical",
      "value": "critical",
    },
    {
      "label": "High",
      "value": "high",
    },
    {
      "label": "Medium",
      "value": "medium",
    },
    {
      "label": "Low",
      "value": "low",
    },
  ];

  List<Map<String, dynamic>> assigneeOptions = [
    {
      "label": "All Assignees",
      "value": "All",
    },
    {
      "label": "Maria Santos",
      "value": "maria_santos",
    },
    {
      "label": "John Wilson",
      "value": "john_wilson",
    },
    {
      "label": "Lisa Chen",
      "value": "lisa_chen",
    },
    {
      "label": "David Brown",
      "value": "david_brown",
    },
    {
      "label": "Unassigned",
      "value": "unassigned",
    },
  ];

  List<Map<String, dynamic>> complaints = [
    {
      "id": "CMP001",
      "title": "Air conditioning not working in room 305",
      "description": "The AC unit in my room has been malfunctioning for the past 2 days. It's extremely hot and uncomfortable. This is unacceptable for a hotel of this caliber.",
      "category": "room",
      "priority": "high",
      "status": "in_progress",
      "guest_name": "John Smith",
      "guest_email": "john.smith@email.com",
      "room_number": "305",
      "check_in_date": "2024-12-10",
      "check_out_date": "2024-12-18",
      "submitted_at": "2024-12-15T10:30:00",
      "assigned_to": "Mike Rodriguez",
      "department": "Maintenance",
      "last_updated": "2024-12-15T14:30:00",
      "resolution_target": "2024-12-15T18:00:00",
      "satisfaction_rating": null,
      "follow_up_required": true,
      "compensation_offered": "Room upgrade",
      "attachments": [
        {
          "name": "room_photo.jpg",
          "type": "image",
          "url": "https://picsum.photos/400/300?random=1&keyword=room"
        }
      ],
      "comments": [
        {
          "id": "com_001",
          "author": "Mike Rodriguez",
          "comment": "Acknowledged complaint. Dispatching technician to room 305 immediately.",
          "timestamp": "2024-12-15T10:45:00",
          "is_internal": false,
        },
        {
          "id": "com_002",
          "author": "System",
          "comment": "Technician completed initial inspection. AC unit requires part replacement.",
          "timestamp": "2024-12-15T12:15:00",
          "is_internal": true,
        }
      ]
    },
    {
      "id": "CMP002",
      "title": "Poor service at front desk during check-in",
      "description": "The staff at the front desk was extremely rude and unprofessional during my check-in process. I was kept waiting for 30 minutes without any explanation.",
      "category": "service",
      "priority": "medium",
      "status": "open",
      "guest_name": "Emily Johnson",
      "guest_email": "emily.johnson@email.com",
      "room_number": "201",
      "check_in_date": "2024-12-14",
      "check_out_date": "2024-12-20",
      "submitted_at": "2024-12-14T16:45:00",
      "assigned_to": "Maria Santos",
      "department": "Guest Services",
      "last_updated": "2024-12-14T16:45:00",
      "resolution_target": "2024-12-16T12:00:00",
      "satisfaction_rating": null,
      "follow_up_required": true,
      "compensation_offered": null,
      "attachments": [],
      "comments": []
    },
    {
      "id": "CMP003",
      "title": "Billing error - charged twice for room service",
      "description": "I was charged twice for the same room service order on December 13th. The bill shows two identical charges of \$45 each. Please rectify this immediately.",
      "category": "billing",
      "priority": "high",
      "status": "resolved",
      "guest_name": "Michael Chen",
      "guest_email": "m.chen@email.com",
      "room_number": "102",
      "check_in_date": "2024-12-11",
      "check_out_date": "2024-12-16",
      "submitted_at": "2024-12-14T09:20:00",
      "assigned_to": "Sarah Johnson",
      "department": "Finance",
      "last_updated": "2024-12-14T15:30:00",
      "resolution_target": "2024-12-14T17:00:00",
      "satisfaction_rating": 4,
      "follow_up_required": false,
      "compensation_offered": "Refund of duplicate charge",
      "attachments": [
        {
          "name": "receipt_screenshot.png",
          "type": "image",
          "url": "https://picsum.photos/300/400?random=2&keyword=receipt"
        }
      ],
      "comments": [
        {
          "id": "com_003",
          "author": "Sarah Johnson",
          "comment": "Verified the billing error. Processing refund immediately.",
          "timestamp": "2024-12-14T10:30:00",
          "is_internal": false,
        },
        {
          "id": "com_004",
          "author": "Sarah Johnson",
          "comment": "Refund processed successfully. Guest notified via email.",
          "timestamp": "2024-12-14T15:30:00",
          "is_internal": false,
        }
      ]
    },
    {
      "id": "CMP004",
      "title": "Loud noise from neighboring room",
      "description": "The guests in the room next to mine have been extremely loud throughout the night. I haven't been able to sleep properly for two consecutive nights.",
      "category": "noise",
      "priority": "medium",
      "status": "pending_guest",
      "guest_name": "Sarah Williams",
      "guest_email": "sarah.w@email.com",
      "room_number": "206",
      "check_in_date": "2024-12-13",
      "check_out_date": "2024-12-17",
      "submitted_at": "2024-12-15T02:30:00",
      "assigned_to": "David Brown",
      "department": "Security",
      "last_updated": "2024-12-15T08:45:00",
      "resolution_target": "2024-12-15T12:00:00",
      "satisfaction_rating": null,
      "follow_up_required": true,
      "compensation_offered": "Late check-out at no charge",
      "attachments": [],
      "comments": [
        {
          "id": "com_005",
          "author": "David Brown",
          "comment": "Spoke with guests in room 207. They have agreed to keep noise levels down.",
          "timestamp": "2024-12-15T08:45:00",
          "is_internal": false,
        }
      ]
    },
    {
      "id": "CMP005",
      "title": "Pool area not properly maintained",
      "description": "The pool area is dirty with leaves and debris floating in the water. The poolside furniture is also dirty and wet. This is disappointing for a hotel of this standard.",
      "category": "facility",
      "priority": "low",
      "status": "open",
      "guest_name": "Robert Davis",
      "guest_email": "r.davis@email.com",
      "room_number": "150",
      "check_in_date": "2024-12-12",
      "check_out_date": "2024-12-19",
      "submitted_at": "2024-12-15T11:15:00",
      "assigned_to": "unassigned",
      "department": "Unassigned",
      "last_updated": "2024-12-15T11:15:00",
      "resolution_target": "2024-12-16T18:00:00",
      "satisfaction_rating": null,
      "follow_up_required": true,
      "compensation_offered": null,
      "attachments": [
        {
          "name": "pool_condition.jpg",
          "type": "image",
          "url": "https://picsum.photos/600/400?random=3&keyword=pool"
        }
      ],
      "comments": []
    },
  ];

  List<Map<String, dynamic>> get filteredComplaints {
    return complaints.where((complaint) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${complaint["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${complaint["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${complaint["guest_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${complaint["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || complaint["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || complaint["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || complaint["priority"] == selectedPriority;
      bool matchesAssignee = selectedAssignee == "All" || 
          (selectedAssignee == "unassigned" && complaint["assigned_to"] == "unassigned") ||
          "${complaint["assigned_to"]}".toLowerCase().replaceAll(' ', '_') == selectedAssignee;
      
      return matchesSearch && matchesStatus && matchesCategory && matchesPriority && matchesAssignee;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "open":
        return dangerColor;
      case "in_progress":
        return warningColor;
      case "pending_guest":
        return infoColor;
      case "resolved":
        return successColor;
      case "closed":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "in_progress":
        return "In Progress";
      case "pending_guest":
        return "Pending Guest";
      default:
        return status.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new complaint
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters Section
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
                    label: "Search complaints...",
                    value: searchQuery,
                    hint: "Search by ID, title, guest name, or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
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
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Assignee",
                          items: assigneeOptions,
                          value: selectedAssignee,
                          onChanged: (value, label) {
                            selectedAssignee = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.report_problem,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${complaints.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Complaints",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error,
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${complaints.where((c) => c["status"] == "open").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Open",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.work,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${complaints.where((c) => c["status"] == "in_progress").length}",
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
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${complaints.where((c) => c["status"] == "resolved").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Resolved",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Complaints List
            ...filteredComplaints.map((complaint) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: complaint["priority"] == "critical"
                      ? Border.all(color: dangerColor, width: 2)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${complaint["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${complaint["priority"]}").withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${complaint["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getPriorityColor("${complaint["priority"]}"),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${complaint["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${complaint["status"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getStatusLabel("${complaint["status"]}"),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor("${complaint["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Guest Information
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: primaryColor.withAlpha(30),
                          child: Text(
                            "${complaint["guest_name"]}".split(' ').map((name) => name[0]).join(''),
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${complaint["guest_name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Room ${complaint["room_number"]} • ${complaint["guest_email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Description
                    Text(
                      "${complaint["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Details Row
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.category,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Category: ${complaint["category"]}".replaceAll('_', ' '),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.business,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Department: ${complaint["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person_pin,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Assigned to: ${complaint["assigned_to"] == "unassigned" ? "Unassigned" : complaint["assigned_to"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Target: ${DateTime.parse("${complaint["resolution_target"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Attachments
                    if ((complaint["attachments"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${(complaint["attachments"] as List).length} attachment(s)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ),
                            QButton(
                              label: "View",
                              size: bs.sm,
                              onPressed: () {
                                // View attachments
                              },
                            ),
                          ],
                        ),
                      ),

                    // Comments Count
                    if ((complaint["comments"] as List).isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(complaint["comments"] as List).length} comment(s)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (complaint["follow_up_required"] == true) ...[
                            Spacer(),
                            Icon(
                              Icons.notification_important,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Follow-up required",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),

                    // Compensation and Rating
                    if (complaint["compensation_offered"] != null || complaint["satisfaction_rating"] != null)
                      Row(
                        children: [
                          if (complaint["compensation_offered"] != null) ...[
                            Icon(
                              Icons.card_giftcard,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Compensation: ${complaint["compensation_offered"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                          if (complaint["satisfaction_rating"] != null) ...[
                            Icon(
                              Icons.star,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Rating: ${complaint["satisfaction_rating"]}/5",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to complaint details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit complaint
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.comment,
                          size: bs.sm,
                          onPressed: () {
                            // Add comment
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.check,
                          size: bs.sm,
                          onPressed: () {
                            // Mark as resolved
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show more options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredComplaints.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.report_problem,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No complaints found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new complaint
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
