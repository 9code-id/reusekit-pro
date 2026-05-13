import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCreateWorkOrderView extends StatefulWidget {
  const FsmCreateWorkOrderView({super.key});

  @override
  State<FsmCreateWorkOrderView> createState() => _FsmCreateWorkOrderViewState();
}

class _FsmCreateWorkOrderViewState extends State<FsmCreateWorkOrderView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String title = "";
  String description = "";
  String selectedClient = "";
  String clientContact = "";
  String clientPhone = "";
  String clientEmail = "";
  String location = "";
  
  // Assignment & Scheduling
  String selectedTechnician = "";
  String selectedPriority = "medium";
  DateTime scheduledDate = DateTime.now();
  TimeOfDay scheduledTime = TimeOfDay(hour: 9, minute: 0);
  DateTime dueDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay dueTime = TimeOfDay(hour: 17, minute: 0);
  String estimatedDuration = "";
  
  // Cost & Materials
  String laborCost = "";
  String materialCost = "";
  List<Map<String, dynamic>> materials = [];
  List<Map<String, dynamic>> equipment = [];
  
  // Tags and Categories
  List<String> selectedTags = [];
  String workOrderType = "maintenance";
  
  // Checklist
  List<Map<String, dynamic>> checklistItems = [];
  String newChecklistItem = "";
  
  // Attachments
  List<String> attachments = [];

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
    {"label": "Auto-assign", "value": "auto_assign"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
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

  void _addEquipment() {
    equipment.add({
      "name": "",
      "model": "",
      "serialNumber": "",
      "location": "",
    });
    setState(() {});
  }

  void _removeEquipment(int index) {
    equipment.removeAt(index);
    setState(() {});
  }

  void _addChecklistItem() {
    if (newChecklistItem.trim().isEmpty) return;
    
    checklistItems.add({
      "task": newChecklistItem.trim(),
      "completed": false,
      "required": true,
    });
    newChecklistItem = "";
    setState(() {});
  }

  void _removeChecklistItem(int index) {
    checklistItems.removeAt(index);
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

  void _populateClientInfo(String clientValue) {
    // Simulate populating client contact info based on selection
    Map<String, Map<String, String>> clientData = {
      "downtown_office": {
        "contact": "Robert Johnson",
        "phone": "+1 555-0123",
        "email": "robert.johnson@downtown-office.com",
        "address": "123 Business Ave, Suite 500",
      },
      "city_hospital": {
        "contact": "Dr. Emily Davis",
        "phone": "+1 555-0456",
        "email": "emily.davis@cityhospital.com",
        "address": "789 Medical Center Dr",
      },
      "manufacturing_plant": {
        "contact": "Mark Thompson",
        "phone": "+1 555-0789",
        "email": "mark.thompson@manufacturing.com",
        "address": "456 Industrial Rd",
      },
    };

    if (clientData.containsKey(clientValue)) {
      final data = clientData[clientValue]!;
      clientContact = data["contact"]!;
      clientPhone = data["phone"]!;
      clientEmail = data["email"]!;
      location = data["address"]!;
      setState(() {});
    }
  }

  double get totalMaterialCost {
    return materials.fold(0.0, (sum, material) => sum + (material["totalCost"] as double));
  }

  double get totalEstimatedCost {
    final labor = double.tryParse(laborCost) ?? 0.0;
    return labor + totalMaterialCost;
  }

  void _saveWorkOrder() {
    if (!formKey.currentState!.validate()) return;

    if (selectedClient.isEmpty) {
      se("Please select a client");
      return;
    }

    if (selectedTechnician.isEmpty) {
      se("Please assign a technician");
      return;
    }

    // Create work order data
    Map<String, dynamic> workOrderData = {
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
      "scheduledDate": scheduledDate.toIso8601String(),
      "scheduledTime": scheduledTime.format(context),
      "dueDate": dueDate.toIso8601String(),
      "dueTime": dueTime.format(context),
      "estimatedDuration": double.tryParse(estimatedDuration) ?? 0.0,
      "laborCost": double.tryParse(laborCost) ?? 0.0,
      "materialCost": totalMaterialCost,
      "totalCost": totalEstimatedCost,
      "materials": materials,
      "equipment": equipment,
      "tags": selectedTags,
      "checklistItems": checklistItems,
      "attachments": attachments,
      "status": "pending",
      "progress": 0,
    };

    ss("Work order created successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Work Order"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveWorkOrder,
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
                        _populateClientInfo(value);
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
                    QNumberField(
                      label: "Estimated Duration (hours)",
                      value: estimatedDuration,
                      hint: "e.g. 4.5",
                      validator: Validator.required,
                      onChanged: (value) {
                        estimatedDuration = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Cost Estimation
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
                      "Cost Estimation",
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
                          "Materials",
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
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(100)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Material Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${totalMaterialCost.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Total Estimated Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
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
                    Text(
                      "Task Checklist",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add checklist item",
                            value: newChecklistItem,
                            hint: "Enter task description",
                            onChanged: (value) {
                              newChecklistItem = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: _addChecklistItem,
                        ),
                      ],
                    ),
                    ...checklistItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_box_outline_blank, size: 20, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${item["task"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => _removeChecklistItem(index),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Attachments
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
                    QMultiImagePicker(
                      label: "Work Order Images",
                      value: attachments,
                      hint: "Add photos, documents, or other files",
                      maxImages: 10,
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
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
                        label: "Save as Draft",
                        size: bs.sm,
                        onPressed: () {
                          ss("Work order saved as draft");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Create Work Order",
                        size: bs.sm,
                        onPressed: _saveWorkOrder,
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
