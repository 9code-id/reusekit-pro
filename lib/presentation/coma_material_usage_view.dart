import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaMaterialUsageView extends StatefulWidget {
  const ComaMaterialUsageView({super.key});

  @override
  State<ComaMaterialUsageView> createState() => _ComaMaterialUsageViewState();
}

class _ComaMaterialUsageViewState extends State<ComaMaterialUsageView> {
  String searchQuery = "";
  String selectedProject = "All";
  String selectedMaterial = "All";
  DateTime? fromDate;
  DateTime? toDate;
  int currentTab = 0;

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All", "value": "All"},
    {"label": "Foundation Project Phase 2", "value": "Foundation Project Phase 2"},
    {"label": "Building Construction A", "value": "Building Construction A"},
    {"label": "Road Infrastructure", "value": "Road Infrastructure"},
    {"label": "Residential Complex", "value": "Residential Complex"},
    {"label": "Commercial Plaza", "value": "Commercial Plaza"},
  ];

  List<Map<String, dynamic>> materialOptions = [
    {"label": "All", "value": "All"},
    {"label": "Portland Cement", "value": "Portland Cement"},
    {"label": "Steel Reinforcement Bar", "value": "Steel Reinforcement Bar"},
    {"label": "River Sand", "value": "River Sand"},
    {"label": "Red Clay Bricks", "value": "Red Clay Bricks"},
    {"label": "Pine Timber", "value": "Pine Timber"},
    {"label": "Exterior Paint", "value": "Exterior Paint"},
  ];

  List<Map<String, dynamic>> usageRecords = [
    {
      "id": "USE001",
      "date": "2024-06-18T09:30:00",
      "materialId": "MAT001",
      "materialName": "Portland Cement",
      "project": "Foundation Project Phase 2",
      "location": "Site A - Block 1",
      "quantityUsed": 25,
      "unit": "bags",
      "unitCost": 12.50,
      "totalCost": 312.50,
      "requestedBy": "John Smith",
      "approvedBy": "Mike Johnson",
      "supervisor": "Robert Wilson",
      "workType": "Foundation Pouring",
      "notes": "Used for concrete foundation work",
      "weatherConditions": "Clear, 25°C",
      "efficiency": 95,
      "wastePercentage": 3.2,
      "image": "https://picsum.photos/120/120?random=51&keyword=cement"
    },
    {
      "id": "USE002",
      "date": "2024-06-18T11:15:00",
      "materialId": "MAT002",
      "materialName": "Steel Reinforcement Bar",
      "project": "Building Construction A",
      "location": "Site B - Floor 3",
      "quantityUsed": 0.8,
      "unit": "tons",
      "unitCost": 650.00,
      "totalCost": 520.00,
      "requestedBy": "Sarah Wilson",
      "approvedBy": "Mike Johnson",
      "supervisor": "David Brown",
      "workType": "Structural Reinforcement",
      "notes": "Steel bars for beam reinforcement",
      "weatherConditions": "Partly cloudy, 22°C",
      "efficiency": 98,
      "wastePercentage": 1.5,
      "image": "https://picsum.photos/120/120?random=52&keyword=steel"
    },
    {
      "id": "USE003",
      "date": "2024-06-17T14:20:00",
      "materialId": "MAT003",
      "materialName": "River Sand",
      "project": "Road Infrastructure",
      "location": "Highway Section C",
      "quantityUsed": 12,
      "unit": "cubic meters",
      "unitCost": 25.00,
      "totalCost": 300.00,
      "requestedBy": "David Brown",
      "approvedBy": "Mike Johnson",
      "supervisor": "Lisa Anderson",
      "workType": "Road Base Preparation",
      "notes": "Sand for road base layer construction",
      "weatherConditions": "Sunny, 28°C",
      "efficiency": 92,
      "wastePercentage": 4.1,
      "image": "https://picsum.photos/120/120?random=53&keyword=sand"
    },
    {
      "id": "USE004",
      "date": "2024-06-17T08:00:00",
      "materialId": "MAT004",
      "materialName": "Red Clay Bricks",
      "project": "Residential Complex",
      "location": "Building 2 - Unit A",
      "quantityUsed": 850,
      "unit": "pieces",
      "unitCost": 0.35,
      "totalCost": 297.50,
      "requestedBy": "Lisa Anderson",
      "approvedBy": "Mike Johnson",
      "supervisor": "Tom Wilson",
      "workType": "Wall Construction",
      "notes": "Bricks for interior wall construction",
      "weatherConditions": "Light rain, 18°C",
      "efficiency": 88,
      "wastePercentage": 6.8,
      "image": "https://picsum.photos/120/120?random=54&keyword=bricks"
    },
    {
      "id": "USE005",
      "date": "2024-06-16T13:45:00",
      "materialId": "MAT005",
      "materialName": "Pine Timber",
      "project": "Commercial Plaza",
      "location": "Shop Area - Framework",
      "quantityUsed": 2.5,
      "unit": "cubic meters",
      "unitCost": 180.00,
      "totalCost": 450.00,
      "requestedBy": "Tom Wilson",
      "approvedBy": "Mike Johnson",
      "supervisor": "John Smith",
      "workType": "Formwork Construction",
      "notes": "Timber for concrete formwork",
      "weatherConditions": "Overcast, 20°C",
      "efficiency": 94,
      "wastePercentage": 2.8,
      "image": "https://picsum.photos/120/120?random=55&keyword=wood"
    },
    {
      "id": "USE006",
      "date": "2024-06-15T10:30:00",
      "materialId": "MAT006",
      "materialName": "Exterior Paint",
      "project": "Foundation Project Phase 2",
      "location": "Site A - External Walls",
      "quantityUsed": 15,
      "unit": "liters",
      "unitCost": 45.00,
      "totalCost": 675.00,
      "requestedBy": "John Smith",
      "approvedBy": "Mike Johnson",
      "supervisor": "Sarah Wilson",
      "workType": "Exterior Painting",
      "notes": "First coat of exterior wall painting",
      "weatherConditions": "Clear, 26°C",
      "efficiency": 91,
      "wastePercentage": 5.2,
      "image": "https://picsum.photos/120/120?random=56&keyword=paint"
    },
  ];

  List<Map<String, dynamic>> get filteredUsageRecords {
    return usageRecords.where((usage) {
      bool matchesSearch = searchQuery.isEmpty ||
          (usage["materialName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (usage["project"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (usage["requestedBy"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (usage["workType"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesProject = selectedProject == "All" || usage["project"] == selectedProject;
      bool matchesMaterial = selectedMaterial == "All" || usage["materialName"] == selectedMaterial;

      DateTime usageDate = DateTime.parse(usage["date"] as String);
      bool matchesDateRange = true;
      if (fromDate != null && toDate != null) {
        matchesDateRange = usageDate.isAfter(fromDate!) && 
                          usageDate.isBefore(toDate!.add(Duration(days: 1)));
      }

      return matchesSearch && matchesProject && matchesMaterial && matchesDateRange;
    }).toList()..sort((a, b) => 
        DateTime.parse(b["date"] as String).compareTo(DateTime.parse(a["date"] as String)));
  }

  Color _getEfficiencyColor(int efficiency) {
    if (efficiency >= 95) return successColor;
    if (efficiency >= 85) return infoColor;
    if (efficiency >= 75) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Usage"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('usage_analytics')
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
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
            QTextField(
              label: "Search usage records...",
              value: searchQuery,
              hint: "Enter material, project, or work type",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Records",
                    "${usageRecords.length}",
                    Icons.inventory_2,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Today's Usage",
                    "${usageRecords.where((u) => DateTime.parse(u["date"] as String).day == DateTime.now().day).length}",
                    Icons.today,
                    infoColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Cost",
                    "\$${(usageRecords.fold(0.0, (sum, item) => sum + (item["totalCost"] as double))).currency}",
                    Icons.attach_money,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Avg Efficiency",
                    "${(usageRecords.fold(0, (sum, item) => sum + (item["efficiency"] as int)) / usageRecords.length).round()}%",
                    Icons.trending_up,
                    warningColor,
                  ),
                ),
              ],
            ),

            // Date Range Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "From Date",
                      value: fromDate,
                      onChanged: (value) {
                        fromDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "To Date",
                      value: toDate,
                      onChanged: (value) {
                        toDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Quick Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All Projects", selectedProject == "All"),
                  _buildQuickFilter("Foundation", selectedProject == "Foundation Project Phase 2"),
                  _buildQuickFilter("Building A", selectedProject == "Building Construction A"),
                  _buildQuickFilter("Road", selectedProject == "Road Infrastructure"),
                  _buildQuickFilter("Residential", selectedProject == "Residential Complex"),
                ],
              ),
            ),

            // Usage Records List
            Column(
              spacing: spSm,
              children: filteredUsageRecords.map((usage) {
                return _buildUsageCard(usage);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == "All Projects") {
          selectedProject = "All";
        } else if (label == "Foundation") {
          selectedProject = "Foundation Project Phase 2";
        } else if (label == "Building A") {
          selectedProject = "Building Construction A";
        } else if (label == "Road") {
          selectedProject = "Road Infrastructure";
        } else if (label == "Residential") {
          selectedProject = "Residential Complex";
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildUsageCard(Map<String, dynamic> usage) {
    DateTime usageDate = DateTime.parse(usage["date"] as String);
    Color efficiencyColor = _getEfficiencyColor(usage["efficiency"] as int);
    double wastePercentage = usage["wastePercentage"] as double;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: primaryColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${usage["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${usage["materialName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${usage["materialId"]} • ${usage["workType"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${usageDate.dMMMykkss}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${usage["quantityUsed"]} ${usage["unit"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${(usage["totalCost"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Project & Location
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.construction,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${usage["project"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${usage["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Efficiency & Waste
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: efficiencyColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Efficiency",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${usage["efficiency"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: efficiencyColor,
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
                    color: (wastePercentage > 5 ? dangerColor : warningColor).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Waste",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${wastePercentage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: wastePercentage > 5 ? dangerColor : warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Personnel Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Requested: ${usage["requestedBy"]}",
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
                      Icons.check_circle,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Approved: ${usage["approvedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.supervisor_account,
                      size: 16,
                      color: infoColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Supervisor: ${usage["supervisor"]}",
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

          // Weather Conditions
          if (usage["weatherConditions"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Weather: ${usage["weatherConditions"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

          // Notes
          if (usage["notes"] != null && (usage["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${usage["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          // Action Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {
                //navigateTo('usage_details')
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Usage Records"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Project",
                items: projectOptions,
                value: selectedProject,
                onChanged: (value, label) {
                  selectedProject = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Material",
                items: materialOptions,
                value: selectedMaterial,
                onChanged: (value, label) {
                  selectedMaterial = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedProject = "All";
                selectedMaterial = "All";
                fromDate = null;
                toDate = null;
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }
}
