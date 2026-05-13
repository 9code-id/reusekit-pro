import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaWasteManagementView extends StatefulWidget {
  const ComaWasteManagementView({super.key});

  @override
  State<ComaWasteManagementView> createState() => _ComaWasteManagementViewState();
}

class _ComaWasteManagementViewState extends State<ComaWasteManagementView> {
  String searchQuery = "";
  String selectedWasteType = "All";
  String selectedProject = "All";
  String selectedStatus = "All";
  DateTime? fromDate;
  DateTime? toDate;

  List<Map<String, dynamic>> wasteTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Construction Debris", "value": "Construction Debris"},
    {"label": "Concrete Waste", "value": "Concrete Waste"},
    {"label": "Metal Scraps", "value": "Metal Scraps"},
    {"label": "Wood Waste", "value": "Wood Waste"},
    {"label": "Packaging Materials", "value": "Packaging Materials"},
    {"label": "Hazardous Waste", "value": "Hazardous Waste"},
  ];

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All", "value": "All"},
    {"label": "Foundation Project Phase 2", "value": "Foundation Project Phase 2"},
    {"label": "Building Construction A", "value": "Building Construction A"},
    {"label": "Road Infrastructure", "value": "Road Infrastructure"},
    {"label": "Residential Complex", "value": "Residential Complex"},
    {"label": "Commercial Plaza", "value": "Commercial Plaza"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Generated", "value": "Generated"},
    {"label": "Collected", "value": "Collected"},
    {"label": "Sorted", "value": "Sorted"},
    {"label": "Recycled", "value": "Recycled"},
    {"label": "Disposed", "value": "Disposed"},
  ];

  List<Map<String, dynamic>> wasteRecords = [
    {
      "id": "WST001",
      "date": "2024-06-18T10:30:00",
      "wasteType": "Construction Debris",
      "project": "Foundation Project Phase 2",
      "location": "Site A - Block 1",
      "quantity": 2.5,
      "unit": "tons",
      "estimatedCost": 125.00,
      "actualCost": 120.00,
      "status": "Collected",
      "collectedBy": "Waste Management Co",
      "collectorContact": "+1-555-0200",
      "generatedBy": "John Smith",
      "sortedMaterials": [
        {"material": "Broken Concrete", "quantity": 1.8, "unit": "tons"},
        {"material": "Steel Fragments", "quantity": 0.4, "unit": "tons"},
        {"material": "Mixed Debris", "quantity": 0.3, "unit": "tons"}
      ],
      "recyclingRate": 72,
      "disposalMethod": "Landfill",
      "environmentalImpact": "Medium",
      "notes": "Regular construction waste from foundation work",
      "scheduledCollection": "2024-06-18T14:00:00",
      "actualCollection": "2024-06-18T14:15:00",
      "image": "https://picsum.photos/120/120?random=61&keyword=construction"
    },
    {
      "id": "WST002",
      "date": "2024-06-17T09:15:00",
      "wasteType": "Metal Scraps",
      "project": "Building Construction A",
      "location": "Site B - Floor 3",
      "quantity": 0.8,
      "unit": "tons",
      "estimatedCost": 0.00,
      "actualCost": -120.00,
      "status": "Recycled",
      "collectedBy": "Metal Recycling Ltd",
      "collectorContact": "+1-555-0201",
      "generatedBy": "Sarah Wilson",
      "sortedMaterials": [
        {"material": "Steel Bars", "quantity": 0.5, "unit": "tons"},
        {"material": "Aluminum", "quantity": 0.2, "unit": "tons"},
        {"material": "Copper Wire", "quantity": 0.1, "unit": "tons"}
      ],
      "recyclingRate": 95,
      "disposalMethod": "Recycling",
      "environmentalImpact": "Low",
      "notes": "Valuable metal scraps sold for recycling",
      "scheduledCollection": "2024-06-17T11:00:00",
      "actualCollection": "2024-06-17T11:30:00",
      "image": "https://picsum.photos/120/120?random=62&keyword=metal"
    },
    {
      "id": "WST003",
      "date": "2024-06-16T14:20:00",
      "wasteType": "Concrete Waste",
      "project": "Road Infrastructure",
      "location": "Highway Section C",
      "quantity": 5.2,
      "unit": "tons",
      "estimatedCost": 260.00,
      "actualCost": 250.00,
      "status": "Sorted",
      "collectedBy": "Green Waste Solutions",
      "collectorContact": "+1-555-0202",
      "generatedBy": "David Brown",
      "sortedMaterials": [
        {"material": "Clean Concrete", "quantity": 4.1, "unit": "tons"},
        {"material": "Reinforced Concrete", "quantity": 1.1, "unit": "tons"}
      ],
      "recyclingRate": 85,
      "disposalMethod": "Crushing & Reuse",
      "environmentalImpact": "Low",
      "notes": "Concrete to be crushed for road base material",
      "scheduledCollection": "2024-06-16T16:00:00",
      "actualCollection": "2024-06-16T15:45:00",
      "image": "https://picsum.photos/120/120?random=63&keyword=concrete"
    },
    {
      "id": "WST004",
      "date": "2024-06-15T11:45:00",
      "wasteType": "Wood Waste",
      "project": "Residential Complex",
      "location": "Building 2 - Unit A",
      "quantity": 1.2,
      "unit": "tons",
      "estimatedCost": 80.00,
      "actualCost": 75.00,
      "status": "Recycled",
      "collectedBy": "Wood Recyclers Inc",
      "collectorContact": "+1-555-0203",
      "generatedBy": "Lisa Anderson",
      "sortedMaterials": [
        {"material": "Clean Timber", "quantity": 0.8, "unit": "tons"},
        {"material": "Treated Wood", "quantity": 0.2, "unit": "tons"},
        {"material": "Sawdust", "quantity": 0.2, "unit": "tons"}
      ],
      "recyclingRate": 90,
      "disposalMethod": "Biomass & Chipping",
      "environmentalImpact": "Very Low",
      "notes": "Wood waste processed into biomass fuel",
      "scheduledCollection": "2024-06-15T13:00:00",
      "actualCollection": "2024-06-15T13:20:00",
      "image": "https://picsum.photos/120/120?random=64&keyword=wood"
    },
    {
      "id": "WST005",
      "date": "2024-06-14T08:30:00",
      "wasteType": "Hazardous Waste",
      "project": "Commercial Plaza",
      "location": "Shop Area - Paint Storage",
      "quantity": 0.15,
      "unit": "tons",
      "estimatedCost": 450.00,
      "actualCost": 465.00,
      "status": "Disposed",
      "collectedBy": "HazWaste Specialists",
      "collectorContact": "+1-555-0204",
      "generatedBy": "Tom Wilson",
      "sortedMaterials": [
        {"material": "Paint Cans", "quantity": 0.08, "unit": "tons"},
        {"material": "Solvents", "quantity": 0.04, "unit": "tons"},
        {"material": "Contaminated Materials", "quantity": 0.03, "unit": "tons"}
      ],
      "recyclingRate": 25,
      "disposalMethod": "Hazardous Waste Facility",
      "environmentalImpact": "High",
      "notes": "Special handling required for paint and solvent waste",
      "scheduledCollection": "2024-06-14T10:00:00",
      "actualCollection": "2024-06-14T10:15:00",
      "image": "https://picsum.photos/120/120?random=65&keyword=hazardous"
    },
    {
      "id": "WST006",
      "date": "2024-06-13T16:00:00",
      "wasteType": "Packaging Materials",
      "project": "Foundation Project Phase 2",
      "location": "Site A - Storage Area",
      "quantity": 0.5,
      "unit": "tons",
      "estimatedCost": 25.00,
      "actualCost": 20.00,
      "status": "Recycled",
      "collectedBy": "Paper & Plastic Recycling",
      "collectorContact": "+1-555-0205",
      "generatedBy": "John Smith",
      "sortedMaterials": [
        {"material": "Cardboard", "quantity": 0.3, "unit": "tons"},
        {"material": "Plastic Wrap", "quantity": 0.1, "unit": "tons"},
        {"material": "Paper Bags", "quantity": 0.1, "unit": "tons"}
      ],
      "recyclingRate": 88,
      "disposalMethod": "Material Recovery",
      "environmentalImpact": "Very Low",
      "notes": "Packaging materials from cement and material deliveries",
      "scheduledCollection": "2024-06-13T17:00:00",
      "actualCollection": "2024-06-13T16:45:00",
      "image": "https://picsum.photos/120/120?random=66&keyword=packaging"
    },
  ];

  List<Map<String, dynamic>> get filteredWasteRecords {
    return wasteRecords.where((waste) {
      bool matchesSearch = searchQuery.isEmpty ||
          (waste["wasteType"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (waste["project"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (waste["generatedBy"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (waste["collectedBy"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesWasteType = selectedWasteType == "All" || waste["wasteType"] == selectedWasteType;
      bool matchesProject = selectedProject == "All" || waste["project"] == selectedProject;
      bool matchesStatus = selectedStatus == "All" || waste["status"] == selectedStatus;

      DateTime wasteDate = DateTime.parse(waste["date"] as String);
      bool matchesDateRange = true;
      if (fromDate != null && toDate != null) {
        matchesDateRange = wasteDate.isAfter(fromDate!) && 
                          wasteDate.isBefore(toDate!.add(Duration(days: 1)));
      }

      return matchesSearch && matchesWasteType && matchesProject && matchesStatus && matchesDateRange;
    }).toList()..sort((a, b) => 
        DateTime.parse(b["date"] as String).compareTo(DateTime.parse(a["date"] as String)));
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Generated":
        return warningColor;
      case "Collected":
        return infoColor;
      case "Sorted":
        return primaryColor;
      case "Recycled":
        return successColor;
      case "Disposed":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color _getEnvironmentalImpactColor(String impact) {
    switch (impact) {
      case "Very Low":
        return successColor;
      case "Low":
        return infoColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waste Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('waste_analytics')
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
              label: "Search waste records...",
              value: searchQuery,
              hint: "Enter waste type, project, or collector",
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
                    "${wasteRecords.length}",
                    Icons.delete,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Recycled",
                    "${wasteRecords.where((w) => w["status"] == "Recycled").length}",
                    Icons.recycling,
                    successColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Weight",
                    "${(wasteRecords.fold(0.0, (sum, item) => sum + (item["quantity"] as double))).toStringAsFixed(1)} tons",
                    Icons.scale,
                    infoColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Avg Recycling",
                    "${(wasteRecords.fold(0, (sum, item) => sum + (item["recyclingRate"] as int)) / wasteRecords.length).round()}%",
                    Icons.eco,
                    successColor,
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
                  _buildQuickFilter("All", selectedStatus == "All"),
                  _buildQuickFilter("Generated", selectedStatus == "Generated"),
                  _buildQuickFilter("Collected", selectedStatus == "Collected"),
                  _buildQuickFilter("Recycled", selectedStatus == "Recycled"),
                  _buildQuickFilter("Hazardous", selectedWasteType == "Hazardous Waste"),
                ],
              ),
            ),

            // Waste Records List
            Column(
              spacing: spSm,
              children: filteredWasteRecords.map((waste) {
                return _buildWasteCard(waste);
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
        if (label == "All") {
          selectedStatus = "All";
          selectedWasteType = "All";
        } else if (label == "Hazardous") {
          selectedWasteType = "Hazardous Waste";
        } else {
          selectedStatus = label;
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

  Widget _buildWasteCard(Map<String, dynamic> waste) {
    Color statusColor = _getStatusColor(waste["status"] as String);
    Color impactColor = _getEnvironmentalImpactColor(waste["environmentalImpact"] as String);
    DateTime wasteDate = DateTime.parse(waste["date"] as String);
    int recyclingRate = waste["recyclingRate"] as int;
    double actualCost = waste["actualCost"] as double;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                  "${waste["image"]}",
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
                      "${waste["wasteType"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${waste["id"]} • ${waste["project"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${wasteDate.dMMMykkss}",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${waste["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${waste["quantity"]} ${waste["unit"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Location & Collection Info
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
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${waste["location"]}",
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
                    Icon(
                      Icons.local_shipping,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Collected by ${waste["collectedBy"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //callPhone(waste["collectorContact"])
                      },
                      child: Icon(
                        Icons.phone,
                        size: 16,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Metrics Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (recyclingRate >= 80 ? successColor : recyclingRate >= 50 ? warningColor : dangerColor).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Recycling Rate",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$recyclingRate%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: recyclingRate >= 80 ? successColor : recyclingRate >= 50 ? warningColor : dangerColor,
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
                    color: impactColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Impact",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${waste["environmentalImpact"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: impactColor,
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
                    color: (actualCost >= 0 ? dangerColor : successColor).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Cost",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${actualCost >= 0 ? '' : '+'}${(actualCost.abs()).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: actualCost >= 0 ? dangerColor : successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sorted Materials
          if ((waste["sortedMaterials"] as List).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sorted Materials",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...(waste["sortedMaterials"] as List).map((material) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${material["material"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${material["quantity"]} ${material["unit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

          // Disposal Method & Personnel
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Method: ${waste["disposalMethod"]}",
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
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Generated by ${waste["generatedBy"]}",
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

          // Collection Timing
          if (waste["scheduledCollection"] != null && waste["actualCollection"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Collection Timing",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Scheduled: ${DateTime.parse(waste["scheduledCollection"] as String).dMMMykkss}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Actual: ${DateTime.parse(waste["actualCollection"] as String).dMMMykkss}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

          // Notes
          if (waste["notes"] != null && (waste["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${waste["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('waste_details')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Status",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('update_waste_status')
                  },
                ),
              ),
            ],
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
          title: Text("Filter Waste Records"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Waste Type",
                items: wasteTypeOptions,
                value: selectedWasteType,
                onChanged: (value, label) {
                  selectedWasteType = value;
                  setState(() {});
                },
              ),
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
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedWasteType = "All";
                selectedProject = "All";
                selectedStatus = "All";
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
