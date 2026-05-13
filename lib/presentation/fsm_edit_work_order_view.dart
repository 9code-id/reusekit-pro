import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEditWorkOrderView extends StatefulWidget {
  const FsmEditWorkOrderView({super.key});

  @override
  State<FsmEditWorkOrderView> createState() => _FsmEditWorkOrderViewState();
}

class _FsmEditWorkOrderViewState extends State<FsmEditWorkOrderView> {
  final formKey = GlobalKey<FormState>();
  
  // Mock existing work order data
  Map<String, dynamic> originalWorkOrder = {
    "id": "WO-2024-001",
    "title": "HVAC System Maintenance",
    "description": "Annual HVAC system maintenance and filter replacement. System showing warning signs and requires immediate attention.",
    "client": "downtown_office",
    "clientContact": "Robert Johnson",
    "clientPhone": "+1 555-0123",
    "clientEmail": "robert.johnson@downtown-office.com",
    "location": "123 Business Ave, Suite 500",
    "assignedTo": "john_smith",
    "priority": "critical",
    "type": "maintenance",
    "status": "in_progress",
    "scheduledDate": "2024-12-19",
    "scheduledTime": "09:00",
    "dueDate": "2024-12-19",
    "dueTime": "17:00",
    "estimatedDuration": 4.0,
    "actualDuration": 3.5,
    "laborCost": 600.00,
    "materialCost": 250.00,
    "tags": ["Maintenance", "HVAC", "Annual", "Critical"],
    "progress": 75,
  };
  
  // Editable fields
  String title = "";
  String description = "";
  String selectedClient = "";
  String clientContact = "";
  String clientPhone = "";
  String clientEmail = "";
  String location = "";
  String selectedTechnician = "";
  String selectedPriority = "";
  String workOrderType = "";
  String selectedStatus = "";
  DateTime scheduledDate = DateTime.now();
  TimeOfDay scheduledTime = TimeOfDay.now();
  DateTime dueDate = DateTime.now();
  TimeOfDay dueTime = TimeOfDay.now();
  String estimatedDuration = "";
  String actualDuration = "";
  String laborCost = "";
  String materialCost = "";
  List<String> selectedTags = [];
  int progress = 0;
  
  // Additional fields for editing
  List<Map<String, dynamic>> materials = [];
  List<Map<String, dynamic>> timeEntries = [];
  List<Map<String, dynamic>> statusHistory = [];
  List<String> attachments = [];
  String editReason = "";

  List<Map<String, dynamic>> clientItems = [
    {"label": "Downtown Office Complex", "value": "downtown_office"},
    {"label": "City Hospital", "value": "city_hospital"},
    {"label": "Manufacturing Plant", "value": "manufacturing_plant"},
    {"label": "Retail Store Chain", "value": "retail_store"},
    {"label": "School District", "value": "school_district"},
    {"label": "Tech Startup Inc.", "value": "tech_startup"},
  ];

  List<Map<String, dynamic>> technicianItems = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Wilson", "value": "mike_wilson"},
    {"label": "Lisa Brown", "value": "lisa_brown"},
    {"label": "David Chen", "value": "david_chen"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Pending", "value": "pending"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Repair", "value": "repair"},
    {"label": "Installation", "value": "installation"},
    {"label": "Inspection", "value": "inspection"},
    {"label": "Emergency", "value": "emergency"},
    {"label": "Upgrade", "value": "upgrade"},
  ];

  List<String> availableTags = [
    "HVAC", "Plumbing", "Electrical", "Security", "Fire Safety", 
    "Maintenance", "Emergency", "Annual", "Quarterly", "Installation",
    "Repair", "Upgrade", "Inspection", "Industrial", "Office", "Hospital"
  ];

  @override
  void initState() {
    super.initState();
    _loadWorkOrderData();
  }

  void _loadWorkOrderData() {
    // Load existing work order data into form fields
    title = originalWorkOrder["title"];
    description = originalWorkOrder["description"];
    selectedClient = originalWorkOrder["client"];
    clientContact = originalWorkOrder["clientContact"];
    clientPhone = originalWorkOrder["clientPhone"];
    clientEmail = originalWorkOrder["clientEmail"];
    location = originalWorkOrder["location"];
    selectedTechnician = originalWorkOrder["assignedTo"];
    selectedPriority = originalWorkOrder["priority"];
    workOrderType = originalWorkOrder["type"];
    selectedStatus = originalWorkOrder["status"];
    estimatedDuration = originalWorkOrder["estimatedDuration"].toString();
    actualDuration = originalWorkOrder["actualDuration"].toString();
    laborCost = originalWorkOrder["laborCost"].toString();
    materialCost = originalWorkOrder["materialCost"].toString();
    selectedTags = List<String>.from(originalWorkOrder["tags"]);
    progress = originalWorkOrder["progress"];
    
    // Parse dates and times
    scheduledDate = DateTime.parse(originalWorkOrder["scheduledDate"]);
    scheduledTime = TimeOfDay(
      hour: int.parse(originalWorkOrder["scheduledTime"].split(":")[0]),
      minute: int.parse(originalWorkOrder["scheduledTime"].split(":")[1]),
    );
    dueDate = DateTime.parse(originalWorkOrder["dueDate"]);
    dueTime = TimeOfDay(
      hour: int.parse(originalWorkOrder["dueTime"].split(":")[0]),
      minute: int.parse(originalWorkOrder["dueTime"].split(":")[1]),
    );

    // Mock additional data
    materials = [
      {"name": "Air Filter MERV 8", "quantity": "12", "unitCost": "15.00", "totalCost": 180.00},
      {"name": "Refrigerant R-410A", "quantity": "2", "unitCost": "25.00", "totalCost": 50.00},
      {"name": "Misc Hardware", "quantity": "1", "unitCost": "20.00", "totalCost": 20.00},
    ];

    timeEntries = [
      {
        "date": "2024-12-19",
        "startTime": "09:15",
        "endTime": "12:00",
        "duration": 2.75,
        "description": "Initial inspection and filter replacement",
        "technician": "John Smith",
      },
      {
        "date": "2024-12-19",
        "startTime": "13:00",
        "endTime": "13:45",
        "duration": 0.75,
        "description": "Refrigerant level check and refill",
        "technician": "John Smith",
      },
    ];

    statusHistory = [
      {"status": "pending", "timestamp": "2024-12-15 10:00", "changedBy": "Manager", "reason": "Initial creation"},
      {"status": "assigned", "timestamp": "2024-12-16 09:30", "changedBy": "Manager", "reason": "Assigned to technician"},
      {"status": "in_progress", "timestamp": "2024-12-19 09:15", "changedBy": "John Smith", "reason": "Work started on site"},
    ];

    setState(() {});
  }

  void _addMaterial() {
    materials.add({
      "name": "",
      "quantity": "",
      "unitCost": "",
      "totalCost": 0.0,
    });
    setState(() {});
  }

  void _removeMaterial(int index) {
    materials.removeAt(index);
    setState(() {});
  }

  void _updateMaterialCost(int index) {
    final material = materials[index];
    final quantity = double.tryParse(material["quantity"] ?? "0") ?? 0;
    final unitCost = double.tryParse(material["unitCost"] ?? "0") ?? 0;
    material["totalCost"] = quantity * unitCost;
    setState(() {});
  }

  void _toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    setState(() {});
  }

  double get totalMaterialCost {
    return materials.fold(0.0, (sum, material) => sum + (material["totalCost"] as double));
  }

  double get totalEstimatedCost {
    final labor = double.tryParse(laborCost) ?? 0.0;
    return labor + totalMaterialCost;
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

  bool _hasChanges() {
    // Check if any field has been modified
    return title != originalWorkOrder["title"] ||
           description != originalWorkOrder["description"] ||
           selectedClient != originalWorkOrder["client"] ||
           selectedTechnician != originalWorkOrder["assignedTo"] ||
           selectedPriority != originalWorkOrder["priority"] ||
           selectedStatus != originalWorkOrder["status"];
  }

  void _saveChanges() {
    if (!formKey.currentState!.validate()) return;

    if (!_hasChanges() && editReason.trim().isEmpty) {
      sw("No changes detected");
      return;
    }

    if (_hasChanges() && editReason.trim().isEmpty) {
      se("Please provide a reason for editing this work order");
      return;
    }

    // Create updated work order data
    Map<String, dynamic> updatedData = {
      "id": originalWorkOrder["id"],
      "title": title,
      "description": description,
      "client": selectedClient,
      "clientContact": clientContact,
      "clientPhone": clientPhone,
      "clientEmail": clientEmail,
      "location": location,
      "assignedTo": selectedTechnician,
      "priority": selectedPriority,
      "type": workOrderType,
      "status": selectedStatus,
      "scheduledDate": scheduledDate.toIso8601String(),
      "scheduledTime": scheduledTime.format(context),
      "dueDate": dueDate.toIso8601String(),
      "dueTime": dueTime.format(context),
      "estimatedDuration": double.tryParse(estimatedDuration) ?? 0.0,
      "actualDuration": double.tryParse(actualDuration) ?? 0.0,
      "laborCost": double.tryParse(laborCost) ?? 0.0,
      "materialCost": totalMaterialCost,
      "totalCost": totalEstimatedCost,
      "materials": materials,
      "tags": selectedTags,
      "progress": progress,
      "editReason": editReason,
      "lastModified": DateTime.now().toIso8601String(),
      "modifiedBy": "Current User",
    };

    ss("Work order updated successfully");
    back();
  }

  void _discardChanges() async {
    if (!_hasChanges()) {
      back();
      return;
    }

    bool isConfirmed = await confirm("Discard all unsaved changes?");
    if (isConfirmed) {
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Work Order"),
        leading: QButton(
          icon: Icons.close,
          size: bs.sm,
          onPressed: _discardChanges,
        ),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveChanges,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Work Order Header
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Work Order ${originalWorkOrder["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(selectedStatus).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${selectedStatus}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(selectedStatus),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_hasChanges())
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "You have unsaved changes",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Edit Reason (Required when changes are made)
              if (_hasChanges())
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
                        "Edit Reason (Required)",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      QMemoField(
                        label: "Reason for editing",
                        value: editReason,
                        hint: "Please explain why you are editing this work order",
                        validator: Validator.required,
                        onChanged: (value) {
                          editReason = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

              // Basic Information
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
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Work Order Title",
                      value: title,
                      hint: "Enter a descriptive title for this work order",
                      validator: Validator.required,
                      onChanged: (value) {
                        title = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Provide detailed description of the work to be performed",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Work Order Type",
                            items: typeItems,
                            value: workOrderType,
                            onChanged: (value, label) {
                              workOrderType = value;
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
                    QDropdownField(
                      label: "Status",
                      items: statusItems,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Assignment & Scheduling
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
                      "Assignment & Scheduling",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Assign Technician",
                      items: technicianItems,
                      value: selectedTechnician,
                      onChanged: (value, label) {
                        selectedTechnician = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Scheduled Date",
                            value: scheduledDate,
                            onChanged: (value) {
                              scheduledDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Scheduled Time",
                            value: scheduledTime,
                            onChanged: (value) {
                              scheduledTime = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Due Date",
                            value: dueDate,
                            onChanged: (value) {
                              dueDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Due Time",
                            value: dueTime,
                            onChanged: (value) {
                              dueTime = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Estimated Duration (hours)",
                            value: estimatedDuration,
                            hint: "e.g. 4.5",
                            validator: Validator.required,
                            onChanged: (value) {
                              estimatedDuration = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Actual Duration (hours)",
                            value: actualDuration,
                            hint: "e.g. 3.5",
                            onChanged: (value) {
                              actualDuration = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    if (selectedStatus == "in_progress" || selectedStatus == "completed")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Progress: $progress%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Slider(
                            value: progress.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 20,
                            label: "$progress%",
                            onChanged: (value) {
                              progress = value.round();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Client Information
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
                      "Client Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Select Client",
                      items: clientItems,
                      value: selectedClient,
                      onChanged: (value, label) {
                        selectedClient = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Contact Person",
                            value: clientContact,
                            hint: "Primary contact name",
                            validator: Validator.required,
                            onChanged: (value) {
                              clientContact = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: clientPhone,
                            hint: "+1 555-0000",
                            validator: Validator.required,
                            onChanged: (value) {
                              clientPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Email",
                      value: clientEmail,
                      hint: "contact@client.com",
                      validator: Validator.email,
                      onChanged: (value) {
                        clientEmail = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Location/Address",
                      value: location,
                      hint: "Full address where work will be performed",
                      validator: Validator.required,
                      onChanged: (value) {
                        location = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Cost & Materials
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
                      "Cost & Materials",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Labor Cost (\$)",
                      value: laborCost,
                      hint: "0.00",
                      onChanged: (value) {
                        laborCost = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Materials Used",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "Add Material",
                          size: bs.sm,
                          onPressed: _addMaterial,
                        ),
                      ],
                    ),
                    ...materials.asMap().entries.map((entry) {
                      final index = entry.key;
                      final material = entry.value;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: QTextField(
                                    label: "Material Name",
                                    value: material["name"],
                                    hint: "Enter material name",
                                    onChanged: (value) {
                                      material["name"] = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () => _removeMaterial(index),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: QNumberField(
                                    label: "Quantity",
                                    value: material["quantity"],
                                    hint: "0",
                                    onChanged: (value) {
                                      material["quantity"] = value;
                                      _updateMaterialCost(index);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QNumberField(
                                    label: "Unit Cost (\$)",
                                    value: material["unitCost"],
                                    hint: "0.00",
                                    onChanged: (value) {
                                      material["unitCost"] = value;
                                      _updateMaterialCost(index);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(material["totalCost"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total Material Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "\$${totalMaterialCost.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Total Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "\$${totalEstimatedCost.toStringAsFixed(2)}",
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
                  ],
                ),
              ),

              // Tags
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
                      "Tags & Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: availableTags.map((tag) {
                        final isSelected = selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () => _toggleTag(tag),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.grey[100],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Status History
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
                      "Status History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...statusHistory.map((history) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: _getStatusColor(history["status"]),
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(history["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${history["status"]}".replaceAll("_", " ").toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor(history["status"]),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${history["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${history["reason"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "by ${history["changedBy"]}",
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

              // Action Buttons
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Discard Changes",
                        size: bs.sm,
                        onPressed: _discardChanges,
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Save Changes",
                        size: bs.sm,
                        onPressed: _saveChanges,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
