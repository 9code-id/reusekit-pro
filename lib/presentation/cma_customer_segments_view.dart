import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerSegmentsView extends StatefulWidget {
  const CmaCustomerSegmentsView({super.key});

  @override
  State<CmaCustomerSegmentsView> createState() => _CmaCustomerSegmentsViewState();
}

class _CmaCustomerSegmentsViewState extends State<CmaCustomerSegmentsView> {
  String searchQuery = "";
  String selectedSegmentType = "";
  bool showCreateDialog = false;
  String newSegmentName = "";
  String newSegmentDescription = "";
  String selectedSegmentCriteria = "";
  String minValue = "";
  String maxValue = "";

  List<Map<String, dynamic>> segmentTypes = [
    {"label": "All Types", "value": ""},
    {"label": "Value-Based", "value": "value"},
    {"label": "Behavioral", "value": "behavioral"},
    {"label": "Geographic", "value": "geographic"},
    {"label": "Demographic", "value": "demographic"},
  ];

  List<Map<String, dynamic>> segmentCriteria = [
    {"label": "Annual Revenue", "value": "annual_revenue"},
    {"label": "Order Frequency", "value": "order_frequency"},
    {"label": "Customer Lifetime Value", "value": "clv"},
    {"label": "Geographic Location", "value": "location"},
    {"label": "Company Size", "value": "company_size"},
    {"label": "Industry Type", "value": "industry"},
  ];

  List<Map<String, dynamic>> segments = [
    {
      "id": "1",
      "name": "High-Value Enterprise",
      "description": "Large enterprise customers with annual revenue > \$1M",
      "type": "value",
      "criteria": "annual_revenue",
      "minValue": 1000000.0,
      "maxValue": null,
      "customerCount": 87,
      "totalRevenue": 15600000.0,
      "avgClv": 178450.0,
      "growthRate": 12.5,
      "churnRate": 2.1,
      "lastUpdated": "2024-12-15",
      "isActive": true,
    },
    {
      "id": "2",
      "name": "Mid-Market Regulars",
      "description": "Medium-sized businesses with consistent ordering patterns",
      "type": "behavioral",
      "criteria": "order_frequency",
      "minValue": 12.0,
      "maxValue": 50.0,
      "customerCount": 456,
      "totalRevenue": 8900000.0,
      "avgClv": 19515.0,
      "growthRate": 8.3,
      "churnRate": 5.7,
      "lastUpdated": "2024-12-14",
      "isActive": true,
    },
    {
      "id": "3",
      "name": "Small Business Startups",
      "description": "Early-stage companies with growth potential",
      "type": "demographic",
      "criteria": "company_size",
      "minValue": 1.0,
      "maxValue": 50.0,
      "customerCount": 1234,
      "totalRevenue": 2340000.0,
      "avgClv": 1896.0,
      "growthRate": 25.6,
      "churnRate": 18.9,
      "lastUpdated": "2024-12-13",
      "isActive": true,
    },
    {
      "id": "4",
      "name": "Geographic - West Coast",
      "description": "Customers located in California, Oregon, Washington",
      "type": "geographic",
      "criteria": "location",
      "minValue": null,
      "maxValue": null,
      "customerCount": 789,
      "totalRevenue": 5670000.0,
      "avgClv": 7187.0,
      "growthRate": 15.2,
      "churnRate": 8.4,
      "lastUpdated": "2024-12-12",
      "isActive": true,
    },
    {
      "id": "5",
      "name": "Loyal Champions",
      "description": "Customers with CLV > \$50K and low churn risk",
      "type": "value",
      "criteria": "clv",
      "minValue": 50000.0,
      "maxValue": null,
      "customerCount": 156,
      "totalRevenue": 12400000.0,
      "avgClv": 79487.0,
      "growthRate": 6.8,
      "churnRate": 1.2,
      "lastUpdated": "2024-12-11",
      "isActive": true,
    },
    {
      "id": "6",
      "name": "At-Risk Customers",
      "description": "Customers showing declining engagement patterns",
      "type": "behavioral",
      "criteria": "order_frequency",
      "minValue": null,
      "maxValue": 2.0,
      "customerCount": 234,
      "totalRevenue": 890000.0,
      "avgClv": 3803.0,
      "growthRate": -15.4,
      "churnRate": 45.6,
      "lastUpdated": "2024-12-10",
      "isActive": false,
    },
  ];

  List<Map<String, dynamic>> get filteredSegments {
    List<Map<String, dynamic>> filtered = segments;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((segment) {
        return segment["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               segment["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedSegmentType.isNotEmpty) {
      filtered = filtered.where((segment) => segment["type"] == selectedSegmentType).toList();
    }
    
    return filtered;
  }

  void _showCreateSegmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Segment"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Segment Name",
                value: newSegmentName,
                onChanged: (value) {
                  newSegmentName = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: newSegmentDescription,
                onChanged: (value) {
                  newSegmentDescription = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Criteria",
                items: segmentCriteria,
                value: selectedSegmentCriteria,
                onChanged: (value, label) {
                  selectedSegmentCriteria = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Min Value",
                      value: minValue,
                      onChanged: (value) {
                        minValue = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Max Value",
                      value: maxValue,
                      onChanged: (value) {
                        maxValue = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetCreateDialog();
            },
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Segment",
            size: bs.sm,
            onPressed: () {
              if (newSegmentName.isNotEmpty && selectedSegmentCriteria.isNotEmpty) {
                _createNewSegment();
                Navigator.pop(context);
                _resetCreateDialog();
                ss("Segment created successfully");
              }
            },
          ),
        ],
      ),
    );
  }

  void _resetCreateDialog() {
    newSegmentName = "";
    newSegmentDescription = "";
    selectedSegmentCriteria = "";
    minValue = "";
    maxValue = "";
  }

  void _createNewSegment() {
    segments.add({
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": newSegmentName,
      "description": newSegmentDescription,
      "type": "value",
      "criteria": selectedSegmentCriteria,
      "minValue": minValue.isNotEmpty ? double.tryParse(minValue) : null,
      "maxValue": maxValue.isNotEmpty ? double.tryParse(maxValue) : null,
      "customerCount": 0,
      "totalRevenue": 0.0,
      "avgClv": 0.0,
      "growthRate": 0.0,
      "churnRate": 0.0,
      "lastUpdated": DateTime.now().toIso8601String().substring(0, 10),
      "isActive": true,
    });
    setState(() {});
  }

  void _deleteSegment(String segmentId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this segment?");
    if (isConfirmed) {
      segments.removeWhere((segment) => segment["id"] == segmentId);
      setState(() {});
      ss("Segment deleted successfully");
    }
  }

  Color _getSegmentTypeColor(String type) {
    switch (type) {
      case "value": return successColor;
      case "behavioral": return infoColor;
      case "geographic": return warningColor;
      case "demographic": return secondaryColor;
      default: return primaryColor;
    }
  }

  String _getSegmentTypeLabel(String type) {
    switch (type) {
      case "value": return "Value-Based";
      case "behavioral": return "Behavioral";
      case "geographic": return "Geographic";
      case "demographic": return "Demographic";
      default: return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Segments"),
        actions: [
          IconButton(
            onPressed: _showCreateSegmentDialog,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.pie_chart,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Segment customers based on behavior, value, and demographics for targeted strategies",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search Segments",
                    value: searchQuery,
                    hint: "Search by name or description...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: segmentTypes,
                    value: selectedSegmentType,
                    onChanged: (value, label) {
                      selectedSegmentType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${segments.where((s) => s["isActive"] == true).length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active Segments",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((segments.map((s) => s["customerCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Customers",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((segments.map((s) => s["totalRevenue"] as double).reduce((a, b) => a + b)) / 1000000).toStringAsFixed(1)}M",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Column(
              spacing: spSm,
              children: filteredSegments.map((segment) {
                Color typeColor = _getSegmentTypeColor(segment["type"]);
                bool isGrowing = (segment["growthRate"] as double) > 0;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: typeColor.withAlpha(100)),
                            ),
                            child: Text(
                              _getSegmentTypeLabel(segment["type"]),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: typeColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${segment["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (segment["isActive"] as bool) ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              (segment["isActive"] as bool) ? "Active" : "Inactive",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (segment["isActive"] as bool) ? successColor : disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Edit"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle edit segment
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.analytics, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Analyze"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle analyze segment
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: dangerColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Delete", style: TextStyle(color: dangerColor)),
                                  ],
                                ),
                                onTap: () => _deleteSegment(segment["id"]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Text(
                        "${segment["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${(segment["customerCount"] as int).toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Customers",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((segment["totalRevenue"] as double) / 1000000).toStringAsFixed(1)}M",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((segment["avgClv"] as double) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Avg CLV",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isGrowing ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isGrowing ? Icons.trending_up : Icons.trending_down,
                                  size: 12,
                                  color: isGrowing ? successColor : dangerColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${(segment["growthRate"] as double) >= 0 ? '+' : ''}${(segment["growthRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: isGrowing ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Churn: ${(segment["churnRate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Updated: ${DateTime.parse(segment["lastUpdated"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (filteredSegments.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.pie_chart_outline,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No segments found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or create a new segment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
