import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTimeMaterialBillingView extends StatefulWidget {
  const FsmTimeMaterialBillingView({super.key});

  @override
  State<FsmTimeMaterialBillingView> createState() => _FsmTimeMaterialBillingViewState();
}

class _FsmTimeMaterialBillingViewState extends State<FsmTimeMaterialBillingView> {
  String selectedProject = "PRJ-001";
  String selectedTechnician = "TECH-001";
  DateTime selectedDate = DateTime.now();
  double hoursWorked = 0.0;
  double hourlyRate = 75.0;
  String workDescription = "";
  bool includeTravel = false;
  double travelHours = 0.0;
  String materialUsed = "";
  double materialCost = 0.0;
  bool billable = true;

  List<Map<String, dynamic>> projects = [
    {
      "id": "PRJ-001",
      "name": "ABC Corp Maintenance",
      "client": "ABC Corporation",
      "hourlyRate": 75.0,
      "status": "Active",
    },
    {
      "id": "PRJ-002",
      "name": "XYZ System Upgrade",
      "client": "XYZ Industries",
      "hourlyRate": 85.0,
      "status": "Active",
    },
    {
      "id": "PRJ-003",
      "name": "Tech Solutions Support",
      "client": "Tech Solutions Inc",
      "hourlyRate": 65.0,
      "status": "Active",
    },
  ];

  List<Map<String, dynamic>> technicians = [
    {
      "id": "TECH-001",
      "name": "John Smith",
      "rate": 75.0,
      "speciality": "HVAC",
    },
    {
      "id": "TECH-002",
      "name": "Mike Johnson",
      "rate": 85.0,
      "speciality": "Electrical",
    },
    {
      "id": "TECH-003",
      "name": "Sarah Wilson",
      "rate": 80.0,
      "speciality": "Plumbing",
    },
  ];

  List<Map<String, dynamic>> timeEntries = [
    {
      "id": "TE-001",
      "date": "2024-01-15",
      "technician": "John Smith",
      "project": "ABC Corp Maintenance",
      "hours": 8.0,
      "rate": 75.0,
      "total": 600.0,
      "description": "HVAC system maintenance and inspection",
      "status": "Approved",
      "billable": true,
      "invoiced": false,
    },
    {
      "id": "TE-002",
      "date": "2024-01-15",
      "technician": "Mike Johnson",
      "project": "XYZ System Upgrade",
      "hours": 6.5,
      "rate": 85.0,
      "total": 552.50,
      "description": "Electrical panel upgrade installation",
      "status": "Pending",
      "billable": true,
      "invoiced": false,
    },
    {
      "id": "TE-003",
      "date": "2024-01-14",
      "technician": "Sarah Wilson",
      "project": "Tech Solutions Support",
      "hours": 4.0,
      "rate": 80.0,
      "total": 320.0,
      "description": "Emergency plumbing repair",
      "status": "Approved",
      "billable": true,
      "invoiced": true,
    },
    {
      "id": "TE-004",
      "date": "2024-01-14",
      "technician": "John Smith",
      "project": "ABC Corp Maintenance",
      "hours": 2.0,
      "rate": 75.0,
      "total": 150.0,
      "description": "Travel time to client site",
      "status": "Approved",
      "billable": false,
      "invoiced": false,
    },
  ];

  List<Map<String, dynamic>> materials = [
    {
      "id": "MAT-001",
      "name": "HVAC Filter",
      "cost": 25.00,
      "quantity": 4,
      "total": 100.00,
      "project": "ABC Corp Maintenance",
      "date": "2024-01-15",
      "invoiced": false,
    },
    {
      "id": "MAT-002",
      "name": "Electrical Wire",
      "cost": 3.50,
      "quantity": 50,
      "total": 175.00,
      "project": "XYZ System Upgrade",
      "date": "2024-01-15",
      "invoiced": false,
    },
    {
      "id": "MAT-003",
      "name": "Pipe Fittings",
      "cost": 12.00,
      "quantity": 8,
      "total": 96.00,
      "project": "Tech Solutions Support",
      "date": "2024-01-14",
      "invoiced": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time & Material Billing"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // View time history
            },
          ),
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: () {
              // Generate invoice
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildTimeEntryForm(),
            _buildMaterialEntry(),
            _buildTimeEntriesList(),
            _buildMaterialsList(),
            _buildBillingSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeEntryForm() {
    return Container(
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
            "Time Entry",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Project",
            items: projects.map((p) => {
              "label": "${p["name"]} - ${p["client"]}",
              "value": p["id"],
            }).toList(),
            value: selectedProject,
            onChanged: (value, label) {
              selectedProject = value;
              final project = projects.firstWhere((p) => p["id"] == value);
              hourlyRate = (project["hourlyRate"] as num).toDouble();
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Technician",
            items: technicians.map((t) => {
              "label": "${t["name"]} - ${t["speciality"]}",
              "value": t["id"],
            }).toList(),
            value: selectedTechnician,
            onChanged: (value, label) {
              selectedTechnician = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Work Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Hours Worked",
                  value: hoursWorked.toString(),
                  onChanged: (value) {
                    hoursWorked = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Hourly Rate (\$)",
                  value: hourlyRate.toString(),
                  onChanged: (value) {
                    hourlyRate = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Work Description",
            value: workDescription,
            hint: "Describe the work performed...",
            onChanged: (value) {
              workDescription = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Travel Time",
                "value": true,
                "checked": includeTravel,
              }
            ],
            value: [
              if (includeTravel)
                {
                  "label": "Include Travel Time",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                includeTravel = values.isNotEmpty;
              });
            },
          ),
          if (includeTravel) ...[
            QNumberField(
              label: "Travel Hours",
              value: travelHours.toString(),
              onChanged: (value) {
                travelHours = double.tryParse(value) ?? 0.0;
                setState(() {});
              },
            ),
          ],
          QSwitch(
            items: [
              {
                "label": "Billable",
                "value": true,
                "checked": billable,
              }
            ],
            value: [
              if (billable)
                {
                  "label": "Billable",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                billable = values.isNotEmpty;
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Time Cost:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$${((hoursWorked + (includeTravel ? travelHours : 0)) * hourlyRate).toStringAsFixed(2)}",
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
            width: double.infinity,
            child: QButton(
              label: "Save Time Entry",
              size: bs.md,
              onPressed: _saveTimeEntry,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialEntry() {
    return Container(
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
            "Material Entry",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Material Used",
            value: materialUsed,
            hint: "Enter material name/description",
            onChanged: (value) {
              materialUsed = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Material Cost (\$)",
            value: materialCost.toString(),
            onChanged: (value) {
              materialCost = double.tryParse(value) ?? 0.0;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Material",
              size: bs.md,
              onPressed: _addMaterial,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntriesList() {
    return Container(
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
                "Recent Time Entries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View all time entries
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...timeEntries.take(4).map((entry) => _buildTimeEntryItem(entry)),
        ],
      ),
    );
  }

  Widget _buildTimeEntryItem(Map<String, dynamic> entry) {
    Color statusColor;
    IconData statusIcon;
    
    switch (entry["status"]) {
      case "Approved":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Pending":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.timer;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${entry["technician"]} - ${entry["project"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${entry["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${entry["date"]} • ${entry["hours"]}h @ \$${entry["rate"]}/h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((entry["total"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (entry["billable"]) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Billable",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                  ],
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${entry["status"]}",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsList() {
    return Container(
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
                "Recent Materials",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View all materials
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...materials.take(3).map((material) => _buildMaterialItem(material)),
        ],
      ),
    );
  }

  Widget _buildMaterialItem(Map<String, dynamic> material) {
    Color statusColor = material["invoiced"] ? successColor : warningColor;
    String statusText = material["invoiced"] ? "Invoiced" : "Pending";

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.build,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${material["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${material["project"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${material["date"]} • Qty: ${material["quantity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((material["total"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingSummary() {
    double totalLabor = timeEntries
        .where((e) => e["billable"] && !e["invoiced"])
        .fold(0.0, (sum, e) => sum + (e["total"] as num).toDouble());
    
    double totalMaterials = materials
        .where((m) => !m["invoiced"])
        .fold(0.0, (sum, m) => sum + (m["total"] as num).toDouble());

    return Container(
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
            "Billing Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Unbilled Labor:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalLabor.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Unbilled Materials:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalMaterials.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Unbilled:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${(totalLabor + totalMaterials).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate Invoice",
              size: bs.md,
              onPressed: _generateInvoice,
            ),
          ),
        ],
      ),
    );
  }

  void _saveTimeEntry() {
    if (hoursWorked > 0 && workDescription.isNotEmpty) {
      ss("Time entry saved successfully!");
      // Reset form
      hoursWorked = 0.0;
      workDescription = "";
      includeTravel = false;
      travelHours = 0.0;
      setState(() {});
    } else {
      se("Please fill in all required fields");
    }
  }

  void _addMaterial() {
    if (materialUsed.isNotEmpty && materialCost > 0) {
      ss("Material added successfully!");
      // Reset form
      materialUsed = "";
      materialCost = 0.0;
      setState(() {});
    } else {
      se("Please fill in material details");
    }
  }

  void _generateInvoice() {
    ss("Invoice generated for unbilled items!");
  }
}
