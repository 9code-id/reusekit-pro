import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmWorkOrderDetailView extends StatefulWidget {
  const FsmWorkOrderDetailView({super.key});

  @override
  State<FsmWorkOrderDetailView> createState() => _FsmWorkOrderDetailViewState();
}

class _FsmWorkOrderDetailViewState extends State<FsmWorkOrderDetailView> {
  Map<String, dynamic> workOrder = {
    "id": "WO-2024-001",
    "title": "HVAC System Maintenance",
    "description": "Annual HVAC system maintenance and filter replacement. System showing warning signs and requires immediate attention to prevent complete failure.",
    "client": "Downtown Office Complex",
    "clientContact": "Robert Johnson",
    "clientPhone": "+1 555-0123",
    "clientEmail": "robert.johnson@downtown-office.com",
    "location": "123 Business Ave, Suite 500, Downtown",
    "coordinates": {"lat": 40.7589, "lng": -73.9851},
    "priority": "critical",
    "status": "in_progress",
    "assignedTo": "John Smith",
    "technicianId": "TECH-001",
    "technicianPhone": "+1 555-0198",
    "technicianEmail": "john.smith@company.com",
    "scheduledDate": "2024-12-19",
    "scheduledTime": "09:00",
    "actualStartTime": "09:15",
    "dueDate": "2024-12-19",
    "dueTime": "17:00",
    "estimatedDuration": 4.0,
    "actualDuration": 3.5,
    "cost": 850.00,
    "laborCost": 600.00,
    "materialCost": 250.00,
    "progress": 75,
    "createdDate": "2024-12-15",
    "createdBy": "Manager",
    "lastUpdated": "2024-12-19 10:30",
    "lastUpdatedBy": "John Smith",
    "tags": ["Maintenance", "HVAC", "Annual", "Critical"],
    "equipment": [
      {"name": "HVAC Unit A-1", "model": "Carrier 50TC", "serialNumber": "C50TC123456"},
      {"name": "Air Filters", "model": "MERV 8", "quantity": 12},
      {"name": "Thermostat", "model": "Honeywell T6", "location": "Main Floor"},
    ],
    "materials": [
      {"name": "Air Filter MERV 8", "quantity": 12, "unitCost": 15.00, "totalCost": 180.00},
      {"name": "Refrigerant R-410A", "quantity": 2, "unitCost": 25.00, "totalCost": 50.00},
      {"name": "Misc Hardware", "quantity": 1, "unitCost": 20.00, "totalCost": 20.00},
    ],
    "checklistItems": [
      {"task": "Visual inspection of HVAC unit", "completed": true, "completedBy": "John Smith", "completedTime": "09:30"},
      {"task": "Replace air filters", "completed": true, "completedBy": "John Smith", "completedTime": "10:15"},
      {"task": "Check refrigerant levels", "completed": true, "completedBy": "John Smith", "completedTime": "10:45"},
      {"task": "Clean evaporator coils", "completed": false, "completedBy": "", "completedTime": ""},
      {"task": "Test thermostat functionality", "completed": false, "completedBy": "", "completedTime": ""},
      {"task": "Final system testing", "completed": false, "completedBy": "", "completedTime": ""},
    ],
    "notes": [
      {
        "id": "NOTE-001",
        "text": "System filters were extremely dirty, indicating poor maintenance schedule.",
        "timestamp": "2024-12-19 09:45",
        "author": "John Smith",
        "type": "observation"
      },
      {
        "id": "NOTE-002",
        "text": "Refrigerant levels were low, topped up with R-410A.",
        "timestamp": "2024-12-19 10:30",
        "author": "John Smith",
        "type": "action"
      },
      {
        "id": "NOTE-003",
        "text": "Client requested additional maintenance window for next month.",
        "timestamp": "2024-12-19 11:00",
        "author": "John Smith",
        "type": "client_request"
      },
    ],
    "timeEntries": [
      {
        "startTime": "09:15",
        "endTime": "12:00",
        "duration": 2.75,
        "description": "Initial inspection and filter replacement",
        "billable": true,
      },
      {
        "startTime": "13:00",
        "endTime": "13:45",
        "duration": 0.75,
        "description": "Refrigerant level check and refill",
        "billable": true,
      },
    ],
    "attachments": [
      {"name": "Before_inspection.jpg", "type": "image", "size": "2.1 MB", "uploadedBy": "John Smith"},
      {"name": "Filter_replacement.jpg", "type": "image", "size": "1.8 MB", "uploadedBy": "John Smith"},
      {"name": "Maintenance_checklist.pdf", "type": "document", "size": "245 KB", "uploadedBy": "John Smith"},
    ],
  };

  String newNote = "";
  bool isAddingNote = false;

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

  IconData _getNoteTypeIcon(String type) {
    switch (type) {
      case "observation":
        return Icons.visibility;
      case "action":
        return Icons.build;
      case "client_request":
        return Icons.person;
      default:
        return Icons.note;
    }
  }

  Color _getNoteTypeColor(String type) {
    switch (type) {
      case "observation":
        return infoColor;
      case "action":
        return successColor;
      case "client_request":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  void _updateStatus(String newStatus) {
    workOrder["status"] = newStatus;
    workOrder["lastUpdated"] = "2024-12-19 ${TimeOfDay.now().format(context)}";
    setState(() {});
    ss("Work order status updated to ${newStatus.replaceAll('_', ' ')}");
  }

  void _toggleChecklistItem(int index) {
    final item = (workOrder["checklistItems"] as List)[index];
    item["completed"] = !item["completed"];
    if (item["completed"]) {
      item["completedBy"] = "John Smith";
      item["completedTime"] = TimeOfDay.now().format(context);
    } else {
      item["completedBy"] = "";
      item["completedTime"] = "";
    }
    
    // Update progress
    final completedItems = (workOrder["checklistItems"] as List).where((item) => item["completed"]).length;
    final totalItems = (workOrder["checklistItems"] as List).length;
    workOrder["progress"] = ((completedItems / totalItems) * 100).round();
    
    setState(() {});
    ss(item["completed"] ? "Task marked as completed" : "Task marked as incomplete");
  }

  void _addNote() {
    if (newNote.trim().isEmpty) return;
    
    final note = {
      "id": "NOTE-${DateTime.now().millisecondsSinceEpoch}",
      "text": newNote.trim(),
      "timestamp": "2024-12-19 ${TimeOfDay.now().format(context)}",
      "author": "John Smith",
      "type": "action"
    };
    
    (workOrder["notes"] as List).insert(0, note);
    newNote = "";
    isAddingNote = false;
    setState(() {});
    ss("Note added successfully");
  }

  void _editWorkOrder() {
    // Navigate to edit work order
  }

  void _viewMap() {
    // Navigate to map view
  }

  void _callClient() {
    ss("Calling ${workOrder["clientContact"]}...");
  }

  void _callTechnician() {
    ss("Calling ${workOrder["assignedTo"]}...");
  }

  void _viewAttachment(Map<String, dynamic> attachment) {
    ss("Opening ${attachment["name"]}...");
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = (workOrder["checklistItems"] as List).where((item) => item["completed"]).length;
    final totalTasks = (workOrder["checklistItems"] as List).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Work Order Details"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: _editWorkOrder,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Work order shared");
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
            // Header Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor(workOrder["priority"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
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
                                  "${workOrder["id"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(workOrder["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${workOrder["priority"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getPriorityColor(workOrder["priority"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${workOrder["title"]}",
                              style: TextStyle(
                                fontSize: 20,
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
                          color: _getStatusColor(workOrder["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${workOrder["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(workOrder["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${workOrder["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${workOrder["progress"]}% Complete",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: (workOrder["progress"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Start Work",
                          size: bs.sm,
                          onPressed: () => _updateStatus("in_progress"),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Complete",
                          size: bs.sm,
                          onPressed: () => _updateStatus("completed"),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Hold",
                          size: bs.sm,
                          onPressed: () => _updateStatus("on_hold"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Client & Technician Info
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.business, size: 20, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Client",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${workOrder["client"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${workOrder["clientContact"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${workOrder["clientPhone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: _callClient,
                            ),
                          ],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.engineering, size: 20, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Technician",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${workOrder["assignedTo"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "ID: ${workOrder["technicianId"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${workOrder["technicianPhone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: _callTechnician,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Location & Schedule
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location & Schedule",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        icon: Icons.map,
                        size: bs.sm,
                        onPressed: _viewMap,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: dangerColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${workOrder["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spLg,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scheduled",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${workOrder["scheduledDate"]} ${workOrder["scheduledTime"]}",
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
                          children: [
                            Text(
                              "Due Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${workOrder["dueDate"]} ${workOrder["dueTime"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (workOrder["actualStartTime"] != null)
                    Row(
                      children: [
                        Icon(Icons.play_arrow, size: 16, color: successColor),
                        SizedBox(width: spXs),
                        Text(
                          "Started at ${workOrder["actualStartTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Cost Breakdown
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Cost Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Labor Cost:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(workOrder["laborCost"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Material Cost:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(workOrder["materialCost"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Cost:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(workOrder["cost"] as double).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Task Checklist
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Task Checklist",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "$completedTasks/$totalTasks completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...(workOrder["checklistItems"] as List).asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: item["completed"] ? successColor.withAlpha(10) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: item["completed"] ? successColor.withAlpha(100) : disabledColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _toggleChecklistItem(index),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: item["completed"] ? successColor : Colors.transparent,
                                border: Border.all(
                                  color: item["completed"] ? successColor : disabledBoldColor,
                                ),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: item["completed"]
                                  ? Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["task"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: item["completed"] ? successColor : primaryColor,
                                    decoration: item["completed"] ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                if (item["completed"] && item["completedBy"].isNotEmpty)
                                  Text(
                                    "Completed by ${item["completedBy"]} at ${item["completedTime"]}",
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
                    );
                  }).toList(),
                ],
              ),
            ),

            // Notes Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notes & Updates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Add Note",
                        size: bs.sm,
                        onPressed: () {
                          isAddingNote = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  if (isAddingNote)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(100)),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Add note",
                            value: newNote,
                            hint: "Enter your note here...",
                            onChanged: (value) {
                              newNote = value;
                              setState(() {});
                            },
                          ),
                          Row(
                            spacing: spSm,
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Cancel",
                                  size: bs.sm,
                                  onPressed: () {
                                    isAddingNote = false;
                                    newNote = "";
                                    setState(() {});
                                  },
                                ),
                              ),
                              Expanded(
                                child: QButton(
                                  label: "Save Note",
                                  size: bs.sm,
                                  onPressed: _addNote,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ...(workOrder["notes"] as List).map((note) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getNoteTypeColor(note["type"]),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getNoteTypeIcon(note["type"]),
                                size: 16,
                                color: _getNoteTypeColor(note["type"]),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${note["type"]}".replaceAll("_", " ").toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getNoteTypeColor(note["type"]),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${note["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${note["text"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              height: 1.4,
                            ),
                          ),
                          Text(
                            "by ${note["author"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Attachments
            if ((workOrder["attachments"] as List).isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Attachments",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...(workOrder["attachments"] as List).map((attachment) {
                      return GestureDetector(
                        onTap: () => _viewAttachment(attachment),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledColor),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                attachment["type"] == "image" ? Icons.image : Icons.description,
                                size: 24,
                                color: primaryColor,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${attachment["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${attachment["size"]} • by ${attachment["uploadedBy"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                            ],
                          ),
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
