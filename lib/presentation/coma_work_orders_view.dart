import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaWorkOrdersView extends StatefulWidget {
  const ComaWorkOrdersView({super.key});

  @override
  State<ComaWorkOrdersView> createState() => _ComaWorkOrdersViewState();
}

class _ComaWorkOrdersViewState extends State<ComaWorkOrdersView> {
  String selectedProject = "all";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedType = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> projects = [
    {
      "id": "PRJ001",
      "name": "Skyline Tower",
      "status": "active",
    },
    {
      "id": "PRJ002", 
      "name": "Harbor Bridge",
      "status": "active",
    },
    {
      "id": "PRJ003",
      "name": "Metro Station Complex",
      "status": "planning",
    },
  ];

  List<Map<String, dynamic>> priorities = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Emergency", "value": "emergency"},
  ];

  List<Map<String, dynamic>> statuses = [
    {"label": "Draft", "value": "draft"},
    {"label": "Submitted", "value": "submitted"},
    {"label": "Approved", "value": "approved"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> workOrderTypes = [
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Repair", "value": "repair"},
    {"label": "Installation", "value": "installation"},
    {"label": "Inspection", "value": "inspection"},
    {"label": "Emergency", "value": "emergency"},
  ];

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO001",
      "title": "Crane Maintenance Service",
      "description": "Routine maintenance for tower crane including hydraulic system check and cable inspection",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "type": "maintenance",
      "status": "in_progress",
      "priority": "high",
      "requestedBy": "John Smith",
      "assignedTo": "Mike Davis",
      "contractor": "Heavy Equipment Services Ltd",
      "estimatedCost": 2500.0,
      "actualCost": 0.0,
      "requestDate": "2024-01-15",
      "scheduledDate": "2024-01-20",
      "completionDate": null,
      "estimatedHours": 8.0,
      "actualHours": 6.5,
      "location": "Construction Site - Block A",
      "equipment": ["Tower Crane TC-001", "Hydraulic Tools"],
      "materials": ["Hydraulic Oil", "Cable Lubricant", "Safety Cables"],
      "notes": "Weather conditions permitting. Requires crane shutdown for 4 hours.",
      "createdAt": "2024-01-15T09:30:00Z",
      "updatedAt": "2024-01-25T14:15:00Z",
    },
    {
      "id": "WO002",
      "title": "Foundation Waterproofing Repair",
      "description": "Repair waterproofing membrane damage found during inspection",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "type": "repair",
      "status": "completed",
      "priority": "medium",
      "requestedBy": "Sarah Johnson",
      "assignedTo": "Lisa Wilson",
      "contractor": "Waterproofing Specialists Inc",
      "estimatedCost": 1800.0,
      "actualCost": 1950.0,
      "requestDate": "2024-01-10",
      "scheduledDate": "2024-01-12",
      "completionDate": "2024-01-14",
      "estimatedHours": 6.0,
      "actualHours": 7.5,
      "location": "Foundation Level - Section B",
      "equipment": ["Membrane Application Tools", "Heat Gun"],
      "materials": ["Waterproof Membrane", "Adhesive", "Sealant"],
      "notes": "Additional work required due to extent of damage. Client approved cost overrun.",
      "createdAt": "2024-01-10T11:20:00Z",
      "updatedAt": "2024-01-14T16:45:00Z",
    },
    {
      "id": "WO003",
      "title": "Bridge Deck Inspection",
      "description": "Comprehensive structural inspection of bridge deck before final phase",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "type": "inspection",
      "status": "approved",
      "priority": "high",
      "requestedBy": "Tom Brown",
      "assignedTo": "John Smith",
      "contractor": "Structural Engineers Co",
      "estimatedCost": 3200.0,
      "actualCost": 0.0,
      "requestDate": "2024-01-18",
      "scheduledDate": "2024-01-25",
      "completionDate": null,
      "estimatedHours": 12.0,
      "actualHours": 0.0,
      "location": "Bridge Deck - Main Span",
      "equipment": ["Inspection Equipment", "NDT Tools", "Safety Gear"],
      "materials": ["Test Materials", "Documentation Supplies"],
      "notes": "Critical inspection before proceeding with final construction phase.",
      "createdAt": "2024-01-18T08:15:00Z",
      "updatedAt": "2024-01-22T10:30:00Z",
    },
    {
      "id": "WO004",
      "title": "Emergency Electrical Repair",
      "description": "Urgent repair of main electrical panel after power surge incident",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "type": "emergency",
      "status": "completed",
      "priority": "emergency",
      "requestedBy": "Mike Davis",
      "assignedTo": "Lisa Wilson",
      "contractor": "Emergency Electrical Services",
      "estimatedCost": 1200.0,
      "actualCost": 1350.0,
      "requestDate": "2024-01-22",
      "scheduledDate": "2024-01-22",
      "completionDate": "2024-01-23",
      "estimatedHours": 4.0,
      "actualHours": 5.5,
      "location": "Electrical Room - Control Building",
      "equipment": ["Electrical Testing Equipment", "Safety Tools"],
      "materials": ["Circuit Breakers", "Electrical Components", "Safety Gear"],
      "notes": "Emergency response completed within 24 hours. System restored to full operation.",
      "createdAt": "2024-01-22T14:30:00Z",
      "updatedAt": "2024-01-23T18:20:00Z",
    },
    {
      "id": "WO005",
      "title": "HVAC System Installation",
      "description": "Install temporary HVAC system in construction office building",
      "projectId": "PRJ003",
      "projectName": "Metro Station Complex",
      "type": "installation",
      "status": "submitted",
      "priority": "medium",
      "requestedBy": "Sarah Johnson",
      "assignedTo": "Tom Brown",
      "contractor": "Climate Control Solutions",
      "estimatedCost": 4500.0,
      "actualCost": 0.0,
      "requestDate": "2024-01-20",
      "scheduledDate": "2024-02-01",
      "completionDate": null,
      "estimatedHours": 16.0,
      "actualHours": 0.0,
      "location": "Office Building - 2nd Floor",
      "equipment": ["HVAC Units", "Installation Tools", "Lifts"],
      "materials": ["Ductwork", "Vents", "Control Systems", "Insulation"],
      "notes": "Awaiting approval from project manager. Installation depends on electrical completion.",
      "createdAt": "2024-01-20T13:45:00Z",
      "updatedAt": "2024-01-24T09:15:00Z",
    },
    {
      "id": "WO006",
      "title": "Safety Equipment Inspection",
      "description": "Monthly safety equipment inspection and certification",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "type": "inspection",
      "status": "draft",
      "priority": "medium",
      "requestedBy": "John Smith",
      "assignedTo": "Mike Davis",
      "contractor": "Safety Inspection Services",
      "estimatedCost": 800.0,
      "actualCost": 0.0,
      "requestDate": "2024-01-25",
      "scheduledDate": "2024-02-05",
      "completionDate": null,
      "estimatedHours": 4.0,
      "actualHours": 0.0,
      "location": "Site-wide Safety Equipment",
      "equipment": ["Inspection Tools", "Certification Equipment"],
      "materials": ["Inspection Forms", "Safety Tags"],
      "notes": "Regular monthly inspection required for compliance. Schedule during low activity period.",
      "createdAt": "2024-01-25T10:00:00Z",
      "updatedAt": "2024-01-25T10:00:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredWorkOrders {
    List<Map<String, dynamic>> filtered = workOrders;

    if (selectedProject != "all") {
      filtered = filtered.where((order) => order["projectId"] == selectedProject).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((order) => order["status"] == selectedStatus).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((order) => order["priority"] == selectedPriority).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((order) => order["type"] == selectedType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            order["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            order["projectName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            order["contractor"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  int get totalWorkOrders => filteredWorkOrders.length;

  int get activeWorkOrders {
    return filteredWorkOrders.where((order) => 
      order["status"] == "in_progress" || order["status"] == "approved").length;
  }

  int get completedWorkOrders {
    return filteredWorkOrders.where((order) => order["status"] == "completed").length;
  }

  double get totalEstimatedCost {
    return filteredWorkOrders.fold(0.0, (sum, order) => sum + (order["estimatedCost"] as double));
  }

  double get totalActualCost {
    return filteredWorkOrders.fold(0.0, (sum, order) => sum + (order["actualCost"] as double));
  }

  int get emergencyWorkOrders {
    return filteredWorkOrders.where((order) => order["priority"] == "emergency").length;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "draft":
        return disabledBoldColor;
      case "submitted":
        return warningColor;
      case "approved":
        return infoColor;
      case "in_progress":
        return primaryColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "low":
        return successColor;
      case "medium":
        return infoColor;
      case "high":
        return warningColor;
      case "emergency":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "draft":
        return "Draft";
      case "submitted":
        return "Submitted";
      case "approved":
        return "Approved";
      case "in_progress":
        return "In Progress";
      case "completed":
        return "Completed";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  String getPriorityText(String priority) {
    return priority.substring(0, 1).toUpperCase() + priority.substring(1);
  }

  String getTypeText(String type) {
    return type.substring(0, 1).toUpperCase() + type.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              si("Work order calendar view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              si("Work order analytics opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.assignment,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Work Orders",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$totalWorkOrders",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "across all projects",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active Orders",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$activeWorkOrders",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "in progress or approved",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$completedWorkOrders",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${totalWorkOrders > 0 ? ((completedWorkOrders / totalWorkOrders) * 100).toStringAsFixed(0) : 0}% completion rate",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Estimated Cost",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalEstimatedCost.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "total budget allocated",
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

            // Filters
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
                      Expanded(
                        child: QTextField(
                          label: "Search work orders",
                          value: searchQuery,
                          hint: "Search by title, description, project, or contractor",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "all"},
                            ...projects.map((project) => {
                              "label": "${project["name"]}",
                              "value": "${project["id"]}",
                            }),
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            ...statuses,
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
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: [
                            {"label": "All Priorities", "value": "all"},
                            ...priorities,
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: [
                            {"label": "All Types", "value": "all"},
                            ...workOrderTypes,
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Work Orders Management",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Create Work Order",
                          size: bs.sm,
                          onPressed: () {
                            si("Create new work order");
                          },
                        ),
                      ],
                    ),
                  ),
                  if (filteredWorkOrders.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment_turned_in,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No work orders found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your filters or create new work orders",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredWorkOrders.map((order) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: getPriorityColor("${order["priority"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${order["title"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getStatusColor("${order["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getStatusText("${order["status"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: getStatusColor("${order["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "WO ${order["id"]} • ${order["projectName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getPriorityColor("${order["priority"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getPriorityText("${order["priority"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: getPriorityColor("${order["priority"]}"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: secondaryColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getTypeText("${order["type"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: secondaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Work Order Details
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  Text(
                                    "${order["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Contractor",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${order["contractor"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Assigned To",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${order["assignedTo"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Estimated Cost",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${(order["estimatedCost"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Scheduled Date",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${DateTime.parse(order["scheduledDate"]).dMMMy}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Location",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${order["location"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (order["notes"] != null && (order["notes"] as String).isNotEmpty)
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(top: spXs),
                                      child: Text(
                                        "${order["notes"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  Row(
                                    spacing: spSm,
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Viewing work order details for ${order["id"]}");
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: QButton(
                                          label: "Edit Order",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Editing work order ${order["id"]}");
                                          },
                                        ),
                                      ),
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
          ],
        ),
      ),
    );
  }
}
