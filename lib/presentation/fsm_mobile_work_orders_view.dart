import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobileWorkOrdersView extends StatefulWidget {
  const FsmMobileWorkOrdersView({super.key});

  @override
  State<FsmMobileWorkOrdersView> createState() => _FsmMobileWorkOrdersViewState();
}

class _FsmMobileWorkOrdersViewState extends State<FsmMobileWorkOrdersView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedPriority = "";
  String selectedTechnician = "";

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO-2024-001",
      "title": "HVAC System Maintenance",
      "description": "Complete inspection and maintenance of central air conditioning system including filter replacement and coolant check.",
      "customerName": "Metro Office Complex",
      "customerPhone": "+1 234 567 8901",
      "location": "1234 Business Center Dr, Suite 500",
      "priority": "High",
      "status": "In Progress",
      "assignedTechnician": "Alex Johnson",
      "technicianPhone": "+1 234 567 8901",
      "scheduledDate": "2024-12-20 14:00:00",
      "estimatedDuration": "3 hours",
      "estimatedCost": 350.0,
      "actualStartTime": "2024-12-20 14:15:00",
      "category": "HVAC",
      "urgencyLevel": "Critical",
      "equipment": ["Carrier 48VL", "Honeywell T6"],
      "materials": ["Air Filter", "Refrigerant R410A"],
      "progress": 65,
      "notes": "Customer reported unusual noises. Initial inspection shows worn fan belt.",
      "attachments": 3,
      "lastUpdate": "2024-12-20 15:30:00",
    },
    {
      "id": "WO-2024-002",
      "title": "Plumbing Emergency Repair",
      "description": "Fix burst water pipe in basement and restore water pressure to building.",
      "customerName": "Riverside Apartments",
      "customerPhone": "+1 234 567 8902",
      "location": "5678 Riverside Ave, Building A",
      "priority": "Critical",
      "status": "Pending",
      "assignedTechnician": "Maria Rodriguez",
      "technicianPhone": "+1 234 567 8902",
      "scheduledDate": "2024-12-20 16:00:00",
      "estimatedDuration": "2 hours",
      "estimatedCost": 280.0,
      "actualStartTime": "",
      "category": "Plumbing",
      "urgencyLevel": "Emergency",
      "equipment": ["Pipe Wrench Set", "Leak Detector"],
      "materials": ["PVC Pipe", "Pipe Fittings", "Thread Sealant"],
      "progress": 0,
      "notes": "Emergency call received at 15:45. Water shut off to prevent flooding.",
      "attachments": 1,
      "lastUpdate": "2024-12-20 15:45:00",
    },
    {
      "id": "WO-2024-003",
      "title": "Electrical Outlet Installation",
      "description": "Install 6 new electrical outlets in office renovation area with proper grounding.",
      "customerName": "Creative Design Studio",
      "customerPhone": "+1 234 567 8903",
      "location": "9012 Creative Blvd, Floor 3",
      "priority": "Medium",
      "status": "Scheduled",
      "assignedTechnician": "David Kim",
      "technicianPhone": "+1 234 567 8903",
      "scheduledDate": "2024-12-21 09:00:00",
      "estimatedDuration": "4 hours",
      "estimatedCost": 520.0,
      "actualStartTime": "",
      "category": "Electrical",
      "urgencyLevel": "Normal",
      "equipment": ["Drill", "Wire Stripper", "Voltage Tester"],
      "materials": ["GFCI Outlets", "Electrical Wire", "Junction Boxes"],
      "progress": 0,
      "notes": "Customer requested specific outlet placement for workstation setup.",
      "attachments": 2,
      "lastUpdate": "2024-12-20 10:00:00",
    },
    {
      "id": "WO-2024-004",
      "title": "Landscaping Maintenance",
      "description": "Weekly grounds maintenance including lawn mowing, hedge trimming, and flower bed care.",
      "customerName": "Sunset Shopping Center",
      "customerPhone": "+1 234 567 8904",
      "location": "3456 Sunset Plaza, Outdoor Areas",
      "priority": "Low",
      "status": "Completed",
      "assignedTechnician": "Sarah Wilson",
      "technicianPhone": "+1 234 567 8904",
      "scheduledDate": "2024-12-19 08:00:00",
      "estimatedDuration": "6 hours",
      "estimatedCost": 420.0,
      "actualStartTime": "2024-12-19 08:15:00",
      "category": "Landscaping",
      "urgencyLevel": "Routine",
      "equipment": ["Lawn Mower", "Hedge Trimmer", "Leaf Blower"],
      "materials": ["Fertilizer", "Mulch", "Plant Food"],
      "progress": 100,
      "notes": "All areas completed. Added seasonal flowers as requested.",
      "attachments": 4,
      "lastUpdate": "2024-12-19 15:00:00",
    },
    {
      "id": "WO-2024-005",
      "title": "Security System Check",
      "description": "Monthly security system inspection and camera maintenance for retail location.",
      "customerName": "TechMart Electronics",
      "customerPhone": "+1 234 567 8905",
      "location": "7890 Tech Avenue, Main Store",
      "priority": "Medium",
      "status": "On Hold",
      "assignedTechnician": "James Chen",
      "technicianPhone": "+1 234 567 8905",
      "scheduledDate": "2024-12-21 13:00:00",
      "estimatedDuration": "2 hours",
      "estimatedCost": 180.0,
      "actualStartTime": "",
      "category": "Security",
      "urgencyLevel": "Scheduled",
      "equipment": ["Camera Tester", "Network Analyzer"],
      "materials": ["Camera Lens Cleaner", "Cable Ties"],
      "progress": 0,
      "notes": "Waiting for customer confirmation on additional camera installation.",
      "attachments": 0,
      "lastUpdate": "2024-12-20 11:30:00",
    },
  ];

  List<Map<String, dynamic>> get filteredWorkOrders {
    return workOrders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${order["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus.isEmpty || order["status"] == selectedStatus;
      bool matchesPriority = selectedPriority.isEmpty || order["priority"] == selectedPriority;
      bool matchesTechnician = selectedTechnician.isEmpty || order["assignedTechnician"] == selectedTechnician;
      return matchesSearch && matchesStatus && matchesPriority && matchesTechnician;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Scheduled":
        return infoColor;
      case "In Progress":
        return primaryColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Pending":
        return Icons.schedule;
      case "Scheduled":
        return Icons.event;
      case "In Progress":
        return Icons.engineering;
      case "Completed":
        return Icons.check_circle;
      case "On Hold":
        return Icons.pause_circle;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Work Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_task),
            onPressed: () {
              // navigateTo('CreateWorkOrderView')
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
                    label: "Search work orders...",
                    value: searchQuery,
                    hint: "Search by title, customer, or ID",
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
                          items: [
                            {"label": "All Status", "value": ""},
                            {"label": "Pending", "value": "Pending"},
                            {"label": "Scheduled", "value": "Scheduled"},
                            {"label": "In Progress", "value": "In Progress"},
                            {"label": "Completed", "value": "Completed"},
                            {"label": "On Hold", "value": "On Hold"},
                          ],
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
                          items: [
                            {"label": "All Priority", "value": ""},
                            {"label": "Critical", "value": "Critical"},
                            {"label": "High", "value": "High"},
                            {"label": "Medium", "value": "Medium"},
                            {"label": "Low", "value": "Low"},
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Work Order Statistics
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
                        Icon(Icons.assignment, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${workOrders.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
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
                        Icon(Icons.engineering, color: warningColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${workOrders.where((o) => o["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Active",
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
                          "${workOrders.where((o) => o["status"] == "Completed").length}",
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

            // Work Orders List
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
                        Icon(Icons.work_outline, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Work Orders (${filteredWorkOrders.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredWorkOrders.map((order) {
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
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getStatusColor("${order["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      getStatusIcon("${order["status"]}"),
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${order["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getPriorityColor("${order["priority"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${order["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${order["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${order["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${order["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(Icons.business, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  "${order["customerName"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${order["assignedTechnician"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${((order["estimatedCost"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${DateTime.parse("${order["scheduledDate"]}").dMMMy} • ${order["estimatedDuration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if ((order["attachments"] as int) > 0)
                                Row(
                                  children: [
                                    Icon(Icons.attach_file, size: 14, color: disabledBoldColor),
                                    Text(
                                      "${order["attachments"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if ("${order["status"]}" == "In Progress")
                            Column(
                              children: [
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Progress: ${order["progress"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                LinearProgressIndicator(
                                  value: (order["progress"] as num) / 100,
                                  backgroundColor: disabledColor.withAlpha(50),
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('WorkOrderDetailView')
                                },
                              ),
                              SizedBox(width: spSm),
                              if ("${order["status"]}" == "Scheduled")
                                QButton(
                                  label: "Start Work",
                                  size: bs.sm,
                                  color: successColor,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Start this work order?");
                                    if (isConfirmed) {
                                      ss("Work order started successfully");
                                    }
                                  },
                                ),
                              if ("${order["status"]}" == "In Progress")
                                QButton(
                                  label: "Update",
                                  size: bs.sm,
                                  color: warningColor,
                                  onPressed: () {
                                    // navigateTo('UpdateWorkOrderView')
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
