import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMaintenanceRequestsView extends StatefulWidget {
  const ReaMaintenanceRequestsView({super.key});

  @override
  State<ReaMaintenanceRequestsView> createState() => _ReaMaintenanceRequestsViewState();
}

class _ReaMaintenanceRequestsViewState extends State<ReaMaintenanceRequestsView> {
  String searchQuery = "";
  String filterStatus = "all";
  String filterPriority = "all";
  
  List<Map<String, dynamic>> maintenanceRequests = [
    {
      "id": "MR001",
      "title": "Broken Air Conditioning",
      "description": "AC unit in master bedroom stopped working",
      "category": "HVAC",
      "priority": "high",
      "status": "open",
      "tenantName": "John Smith",
      "propertyName": "Downtown Apartment 2A",
      "propertyImage": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "submittedDate": "2024-01-15",
      "scheduledDate": "2024-01-16",
      "completedDate": null,
      "assignedTo": "Mike's HVAC Services",
      "estimatedCost": 150.0,
      "actualCost": null,
      "images": [
        "https://picsum.photos/400/300?random=11&keyword=airconditioner",
        "https://picsum.photos/400/300?random=12&keyword=hvac"
      ],
      "notes": "Tenant reports strange noises before it stopped working"
    },
    {
      "id": "MR002",
      "title": "Leaking Kitchen Faucet",
      "description": "Kitchen faucet drips constantly",
      "category": "Plumbing",
      "priority": "medium",
      "status": "in_progress",
      "tenantName": "Sarah Johnson",
      "propertyName": "Sunset Villa Unit B", 
      "propertyImage": "https://picsum.photos/300/200?random=2&keyword=villa",
      "submittedDate": "2024-01-10",
      "scheduledDate": "2024-01-12",
      "completedDate": null,
      "assignedTo": "City Plumbing Co.",
      "estimatedCost": 75.0,
      "actualCost": null,
      "images": [
        "https://picsum.photos/400/300?random=13&keyword=faucet"
      ],
      "notes": "May need faucet replacement"
    },
    {
      "id": "MR003",
      "title": "Broken Window Lock",
      "description": "Bedroom window lock is broken",
      "category": "Security",
      "priority": "medium",
      "status": "completed",
      "tenantName": "Mike Wilson",
      "propertyName": "City Center Studio",
      "propertyImage": "https://picsum.photos/300/200?random=3&keyword=studio",
      "submittedDate": "2024-01-05",
      "scheduledDate": "2024-01-08",
      "completedDate": "2024-01-08",
      "assignedTo": "Security Solutions Inc",
      "estimatedCost": 50.0,
      "actualCost": 45.0,
      "images": [
        "https://picsum.photos/400/300?random=14&keyword=window"
      ],
      "notes": "Lock replaced successfully"
    },
    {
      "id": "MR004",
      "title": "Electrical Outlet Not Working",
      "description": "Living room outlet has no power",
      "category": "Electrical",
      "priority": "high",
      "status": "scheduled",
      "tenantName": "Emma Davis",
      "propertyName": "Garden View Condo",
      "propertyImage": "https://picsum.photos/300/200?random=4&keyword=condo",
      "submittedDate": "2024-01-14",
      "scheduledDate": "2024-01-17",
      "completedDate": null,
      "assignedTo": "Power Electric Services",
      "estimatedCost": 120.0,
      "actualCost": null,
      "images": [
        "https://picsum.photos/400/300?random=15&keyword=outlet"
      ],
      "notes": "Potential wiring issue"
    },
    {
      "id": "MR005",
      "title": "Clogged Bathroom Drain",
      "description": "Bathroom sink drains very slowly",
      "category": "Plumbing",
      "priority": "low",
      "status": "open",
      "tenantName": "David Brown",
      "propertyName": "Luxury Penthouse",
      "propertyImage": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "submittedDate": "2024-01-16",
      "scheduledDate": null,
      "completedDate": null,
      "assignedTo": null,
      "estimatedCost": 60.0,
      "actualCost": null,
      "images": [
        "https://picsum.photos/400/300?random=16&keyword=drain"
      ],
      "notes": "Likely hair clog"
    }
  ];

  List<Map<String, dynamic>> get filteredRequests {
    List<Map<String, dynamic>> filtered = maintenanceRequests;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((request) {
        return (request["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (request["tenantName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (request["propertyName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (request["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (filterStatus != "all") {
      filtered = filtered.where((request) => request["status"] == filterStatus).toList();
    }
    
    if (filterPriority != "all") {
      filtered = filtered.where((request) => request["priority"] == filterPriority).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "open":
        return infoColor;
      case "in_progress":
        return warningColor;
      case "scheduled":
        return primaryColor;
      case "completed":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "open":
        return "Open";
      case "in_progress":
        return "In Progress";
      case "scheduled":
        return "Scheduled";
      case "completed":
        return "Completed";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search requests...",
                    value: searchQuery,
                    hint: "Search by title, tenant, property",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Open Requests",
                  "${maintenanceRequests.where((r) => r["status"] == "open").length}",
                  Icons.assignment,
                  infoColor,
                ),
                _buildSummaryCard(
                  "In Progress",
                  "${maintenanceRequests.where((r) => r["status"] == "in_progress").length}",
                  Icons.build,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Completed",
                  "${maintenanceRequests.where((r) => r["status"] == "completed").length}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildSummaryCard(
                  "High Priority",
                  "${maintenanceRequests.where((r) => r["priority"] == "high").length}",
                  Icons.priority_high,
                  dangerColor,
                ),
              ],
            ),

            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    label: "Status",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "Open", "value": "open"},
                      {"label": "Scheduled", "value": "scheduled"},
                      {"label": "In Progress", "value": "in_progress"},
                      {"label": "Completed", "value": "completed"},
                    ],
                    value: filterStatus,
                    onChanged: (index, label, value, item) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    label: "Priority",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "High", "value": "high"},
                      {"label": "Medium", "value": "medium"},
                      {"label": "Low", "value": "low"},
                    ],
                    value: filterPriority,
                    onChanged: (index, label, value, item) {
                      filterPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Maintenance Requests List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.build_circle, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Maintenance Requests",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRequests.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return _buildMaintenanceRequestItem(request);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateRequestDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceRequestItem(Map<String, dynamic> request) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Property Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${request["propertyImage"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              
              // Request Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${request["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(request["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${request["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: _getPriorityColor(request["priority"]),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${request["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${request["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(request["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel(request["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(request["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Additional Info
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${request["tenantName"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${request["propertyName"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.category, size: 16, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "${request["category"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.attach_money, size: 16, color: successColor),
              Text(
                "\$${(request["estimatedCost"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 13,
                  color: successColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                "Submitted: ${DateTime.parse(request["submittedDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          if (request["assignedTo"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.engineering, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "Assigned to: ${request["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: warningColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showRequestDetailDialog(request);
                },
              ),
              SizedBox(width: spSm),
              if (request["status"] != "completed") ...[
                QButton(
                  label: "Update Status",
                  size: bs.sm,
                  onPressed: () {
                    _showUpdateStatusDialog(request);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Apply Filters",
              onPressed: () {
                back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Maintenance Request"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Create a new maintenance request"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => back(),
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showRequestDetailDialog(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${request["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: ${request["description"]}"),
            SizedBox(height: spSm),
            Text("Category: ${request["category"]}"),
            Text("Priority: ${request["priority"]}"),
            Text("Status: ${request["status"]}"),
            if (request["notes"] != null) ...[
              SizedBox(height: spSm),
              Text("Notes: ${request["notes"]}"),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showUpdateStatusDialog(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Update status for: ${request["title"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => back(),
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
