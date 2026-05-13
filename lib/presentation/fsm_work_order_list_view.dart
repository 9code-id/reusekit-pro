import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmWorkOrderListView extends StatefulWidget {
  const FsmWorkOrderListView({super.key});

  @override
  State<FsmWorkOrderListView> createState() => _FsmWorkOrderListViewState();
}

class _FsmWorkOrderListViewState extends State<FsmWorkOrderListView> {
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedTechnician = "all";
  String searchQuery = "";
  String sortBy = "date_desc";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> technicianItems = [
    {"label": "All Technicians", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Wilson", "value": "mike_wilson"},
    {"label": "Lisa Brown", "value": "lisa_brown"},
    {"label": "David Chen", "value": "david_chen"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Date (Newest)", "value": "date_desc"},
    {"label": "Date (Oldest)", "value": "date_asc"},
    {"label": "Priority (High to Low)", "value": "priority_desc"},
    {"label": "Priority (Low to High)", "value": "priority_asc"},
    {"label": "Status", "value": "status"},
    {"label": "Client Name", "value": "client"},
  ];

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO-2024-001",
      "title": "HVAC System Maintenance",
      "description": "Annual HVAC system maintenance and filter replacement",
      "client": "Downtown Office Complex",
      "clientContact": "Robert Johnson",
      "clientPhone": "+1 555-0123",
      "location": "123 Business Ave, Suite 500",
      "priority": "critical",
      "status": "in_progress",
      "assignedTo": "John Smith",
      "technicianPhone": "+1 555-0198",
      "scheduledDate": "2024-12-19",
      "scheduledTime": "09:00",
      "dueDate": "2024-12-19",
      "estimatedDuration": 4.0,
      "actualDuration": 3.5,
      "cost": 850.00,
      "progress": 75,
      "createdDate": "2024-12-15",
      "lastUpdated": "2024-12-19 10:30",
      "tags": ["Maintenance", "HVAC", "Annual"],
      "equipment": ["HVAC Unit A-1", "Filters", "Thermostat"],
    },
    {
      "id": "WO-2024-002",
      "title": "Plumbing Repair - Emergency",
      "description": "Fix leaking pipes in emergency department",
      "client": "City Hospital",
      "clientContact": "Dr. Emily Davis",
      "clientPhone": "+1 555-0456",
      "location": "789 Medical Center Dr",
      "priority": "high",
      "status": "assigned",
      "assignedTo": "Sarah Johnson",
      "technicianPhone": "+1 555-0287",
      "scheduledDate": "2024-12-19",
      "scheduledTime": "14:00",
      "dueDate": "2024-12-19",
      "estimatedDuration": 2.0,
      "actualDuration": 0.0,
      "cost": 450.00,
      "progress": 0,
      "createdDate": "2024-12-18",
      "lastUpdated": "2024-12-18 16:45",
      "tags": ["Emergency", "Plumbing", "Hospital"],
      "equipment": ["Pipe Wrench", "Replacement Pipes", "Sealant"],
    },
    {
      "id": "WO-2024-003",
      "title": "Electrical Panel Upgrade",
      "description": "Upgrade main electrical panel and install new breakers",
      "client": "Manufacturing Plant",
      "clientContact": "Mark Thompson",
      "clientPhone": "+1 555-0789",
      "location": "456 Industrial Rd",
      "priority": "medium",
      "status": "completed",
      "assignedTo": "Mike Wilson",
      "technicianPhone": "+1 555-0321",
      "scheduledDate": "2024-12-18",
      "scheduledTime": "08:00",
      "dueDate": "2024-12-18",
      "estimatedDuration": 6.0,
      "actualDuration": 7.5,
      "cost": 1200.00,
      "progress": 100,
      "createdDate": "2024-12-15",
      "lastUpdated": "2024-12-18 17:30",
      "tags": ["Electrical", "Upgrade", "Industrial"],
      "equipment": ["Electrical Panel", "Breakers", "Wiring"],
    },
    {
      "id": "WO-2024-004",
      "title": "Security System Installation",
      "description": "Install new security cameras and access control system",
      "client": "Retail Store Chain",
      "clientContact": "Jennifer Lee",
      "clientPhone": "+1 555-0012",
      "location": "321 Shopping Plaza",
      "priority": "low",
      "status": "on_hold",
      "assignedTo": "Lisa Brown",
      "technicianPhone": "+1 555-0654",
      "scheduledDate": "2024-12-21",
      "scheduledTime": "10:00",
      "dueDate": "2024-12-22",
      "estimatedDuration": 3.0,
      "actualDuration": 0.0,
      "cost": 750.00,
      "progress": 25,
      "createdDate": "2024-12-16",
      "lastUpdated": "2024-12-17 09:15",
      "tags": ["Security", "Installation", "Retail"],
      "equipment": ["Cameras", "Access Control", "Cables"],
    },
    {
      "id": "WO-2024-005",
      "title": "Fire Safety Inspection",
      "description": "Quarterly fire safety system inspection and testing",
      "client": "School District",
      "clientContact": "Principal Maria Garcia",
      "clientPhone": "+1 555-0345",
      "location": "555 Education Blvd",
      "priority": "high",
      "status": "pending",
      "assignedTo": "David Chen",
      "technicianPhone": "+1 555-0876",
      "scheduledDate": "2024-12-22",
      "scheduledTime": "11:00",
      "dueDate": "2024-12-22",
      "estimatedDuration": 2.0,
      "actualDuration": 0.0,
      "cost": 300.00,
      "progress": 0,
      "createdDate": "2024-12-17",
      "lastUpdated": "2024-12-17 14:20",
      "tags": ["Inspection", "Fire Safety", "Education"],
      "equipment": ["Testing Equipment", "Checklist", "Ladder"],
    },
    {
      "id": "WO-2024-006",
      "title": "Network Infrastructure Setup",
      "description": "Install and configure network infrastructure for new office",
      "client": "Tech Startup Inc.",
      "clientContact": "Alex Rodriguez",
      "clientPhone": "+1 555-0567",
      "location": "999 Innovation Ave",
      "priority": "medium",
      "status": "cancelled",
      "assignedTo": "John Smith",
      "technicianPhone": "+1 555-0198",
      "scheduledDate": "2024-12-20",
      "scheduledTime": "13:00",
      "dueDate": "2024-12-21",
      "estimatedDuration": 5.0,
      "actualDuration": 0.0,
      "cost": 950.00,
      "progress": 0,
      "createdDate": "2024-12-14",
      "lastUpdated": "2024-12-18 11:00",
      "tags": ["Network", "Installation", "Office"],
      "equipment": ["Switches", "Routers", "Cables"],
    },
  ];

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

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "assigned":
        return infoColor;
      case "in_progress":
        return primaryColor;
      case "on_hold":
        return dangerColor;
      case "completed":
        return successColor;
      case "cancelled":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredAndSortedWorkOrders {
    List<Map<String, dynamic>> filtered = workOrders.where((wo) {
      bool matchesStatus = selectedStatus == "all" || wo["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "all" || wo["priority"] == selectedPriority;
      bool matchesTechnician = selectedTechnician == "all" || 
          wo["assignedTo"].toLowerCase().replaceAll(" ", "_") == selectedTechnician;
      bool matchesSearch = searchQuery.isEmpty ||
          wo["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          wo["client"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          wo["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          wo["assignedTo"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesPriority && matchesTechnician && matchesSearch;
    }).toList();

    // Sort the filtered results
    filtered.sort((a, b) {
      switch (sortBy) {
        case "date_desc":
          return b["createdDate"].compareTo(a["createdDate"]);
        case "date_asc":
          return a["createdDate"].compareTo(b["createdDate"]);
        case "priority_desc":
          List<String> priorityOrder = ["critical", "high", "medium", "low"];
          return priorityOrder.indexOf(a["priority"]).compareTo(priorityOrder.indexOf(b["priority"]));
        case "priority_asc":
          List<String> priorityOrder = ["low", "medium", "high", "critical"];
          return priorityOrder.indexOf(a["priority"]).compareTo(priorityOrder.indexOf(b["priority"]));
        case "status":
          return a["status"].compareTo(b["status"]);
        case "client":
          return a["client"].compareTo(b["client"]);
        default:
          return 0;
      }
    });

    return filtered;
  }

  void _viewWorkOrderDetails(Map<String, dynamic> workOrder) {
    // Navigate to work order details
  }

  void _editWorkOrder(Map<String, dynamic> workOrder) {
    // Navigate to edit work order
  }

  void _duplicateWorkOrder(Map<String, dynamic> workOrder) {
    ss("Work order ${workOrder["id"]} duplicated");
  }

  void _cancelWorkOrder(Map<String, dynamic> workOrder) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this work order?");
    if (isConfirmed) {
      ss("Work order ${workOrder["id"]} cancelled");
    }
  }

  Widget _buildWorkOrderCard(Map<String, dynamic> wo) {
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
            color: _getPriorityColor(wo["priority"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${wo["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(wo["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${wo["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(wo["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${wo["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(wo["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${wo["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(wo["status"]),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${wo["client"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${wo["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${wo["assignedTo"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${wo["scheduledDate"]} ${wo["scheduledTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (wo["status"] == "in_progress" && (wo["progress"] as int) > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${wo["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (wo["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "\$${(wo["cost"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${wo["estimatedDuration"]}h est.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if ((wo["actualDuration"] as double) > 0)
                Text(
                  " • ${wo["actualDuration"]}h actual",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          // Tags
          if ((wo["tags"] as List).isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: spXs),
              child: QHorizontalScroll(
                children: (wo["tags"] as List).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          SizedBox(height: spSm),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewWorkOrderDetails(wo),
                ),
              ),
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () => _editWorkOrder(wo),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Show options menu
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredWorkOrders = filteredAndSortedWorkOrders;

    return Scaffold(
      appBar: AppBar(
        title: Text("Work Orders"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create work order
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              // Show filter options
            },
          ),
          SizedBox(width: spSm),
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
                  Row(
                    children: [
                      Icon(Icons.search, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search work orders",
                          value: searchQuery,
                          hint: "Search by ID, title, client, or technician...",
                          onChanged: (value) {
                            searchQuery = value;
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
                          label: "Status",
                          items: statusItems,
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
                          items: priorityItems,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
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
                          label: "Technician",
                          items: technicianItems,
                          value: selectedTechnician,
                          onChanged: (value, label) {
                            selectedTechnician = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortItems,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Showing ${filteredWorkOrders.length} of ${workOrders.length} work orders",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  if (searchQuery.isNotEmpty || selectedStatus != "all" || 
                      selectedPriority != "all" || selectedTechnician != "all")
                    QButton(
                      label: "Clear Filters",
                      size: bs.sm,
                      onPressed: () {
                        searchQuery = "";
                        selectedStatus = "all";
                        selectedPriority = "all";
                        selectedTechnician = "all";
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

            // Work Orders List
            if (filteredWorkOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No work orders found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search criteria or filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredWorkOrders.map((wo) => _buildWorkOrderCard(wo)).toList(),
          ],
        ),
      ),
    );
  }
}
