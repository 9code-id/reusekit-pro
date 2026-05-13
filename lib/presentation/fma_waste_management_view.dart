import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaWasteManagementView extends StatefulWidget {
  const FmaWasteManagementView({super.key});

  @override
  State<FmaWasteManagementView> createState() => _FmaWasteManagementViewState();
}

class _FmaWasteManagementViewState extends State<FmaWasteManagementView> {
  int currentTab = 0;

  // Filter states
  String selectedPeriod = "week";
  String selectedWasteType = "all";
  String selectedLocation = "all";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> wasteTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Food Waste", "value": "food"},
    {"label": "Packaging", "value": "packaging"},
    {"label": "Oil/Grease", "value": "oil"},
    {"label": "General", "value": "general"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "all"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Prep Area", "value": "prep"},
    {"label": "Dining", "value": "dining"},
    {"label": "Storage", "value": "storage"},
  ];

  // Waste tracking data
  List<Map<String, dynamic>> wasteEntries = [
    {
      "id": "W001",
      "type": "Food Waste",
      "category": "Vegetables",
      "weight": 12.5,
      "location": "Kitchen",
      "timestamp": "2024-06-15T14:30:00",
      "reason": "Overripe produce",
      "cost": 25.0,
      "staff": "John Smith",
    },
    {
      "id": "W002",
      "type": "Packaging",
      "category": "Cardboard",
      "weight": 8.2,
      "location": "Storage",
      "timestamp": "2024-06-15T11:15:00",
      "reason": "Delivery boxes",
      "cost": 0.0,
      "staff": "Sarah Johnson",
    },
    {
      "id": "W003",
      "type": "Food Waste",
      "category": "Meat",
      "weight": 3.8,
      "location": "Prep Area",
      "timestamp": "2024-06-15T09:45:00",
      "reason": "Expired products",
      "cost": 45.0,
      "staff": "Mike Wilson",
    },
  ];

  List<Map<String, dynamic>> reductionStrategies = [
    {
      "title": "Portion Control Training",
      "description": "Train staff on proper portion sizes",
      "impact": "High",
      "effort": "Medium",
      "savings": 150.0,
      "timeline": "2 weeks",
      "status": "In Progress",
    },
    {
      "title": "Inventory Rotation System",
      "description": "Implement FIFO system for ingredients",
      "impact": "High",
      "effort": "Low",
      "savings": 200.0,
      "timeline": "1 week",
      "status": "Planned",
    },
    {
      "title": "Composting Program",
      "description": "Set up composting for organic waste",
      "impact": "Medium",
      "effort": "High",
      "savings": 80.0,
      "timeline": "1 month",
      "status": "Under Review",
    },
  ];

  // Log waste form
  String wasteType = "food";
  String wasteCategory = "";
  String wasteWeight = "";
  String wasteLocation = "kitchen";
  String wasteReason = "";
  String estimatedCost = "";

  Widget _buildWasteTracking() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Waste Type",
                  items: wasteTypeOptions,
                  value: selectedWasteType,
                  onChanged: (value, label) {
                    selectedWasteType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Waste Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              Container(
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
                          Icons.delete,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Total Waste",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "24.5 kg",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "+12% from last week",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
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
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Cost Impact",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$70.00",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "This week",
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
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Reduction",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "8.5%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "vs last month",
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

          Text(
            "Recent Waste Entries",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...wasteEntries.map((entry) {
            Color typeColor = entry["type"] == "Food Waste" 
                ? dangerColor 
                : entry["type"] == "Packaging"
                    ? infoColor
                    : warningColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: typeColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${entry["type"]} - ${entry["category"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(entry["weight"] as double).toStringAsFixed(1)} kg",
                          style: TextStyle(
                            fontSize: 12,
                            color: typeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Reason: ${entry["reason"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${entry["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if ((entry["cost"] as double) > 0)
                        Text(
                          "\$${(entry["cost"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
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
                        "${entry["staff"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${DateTime.parse(entry["timestamp"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Waste Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
              children: [
                Text(
                  "Waste by Type (This Month)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Food Waste",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "65%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Packaging",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "20%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Oil/Grease",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "10%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: disabledBoldColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "General",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "5%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
              children: [
                Text(
                  "Peak Waste Times",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(Icons.access_time, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Lunch Rush (12:00-14:00)",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "35%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.access_time, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Dinner Service (18:00-21:00)",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "28%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.access_time, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Prep Time (08:00-11:00)",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "22%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
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
              children: [
                Text(
                  "Environmental Impact",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(Icons.eco, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "CO₂ Saved This Month",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "125 kg",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.water_drop, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Water Saved",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "850 L",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
  }

  Widget _buildReduction() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Waste Reduction Strategies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...reductionStrategies.map((strategy) {
            Color statusColor = strategy["status"] == "In Progress" 
                ? warningColor 
                : strategy["status"] == "Planned"
                    ? infoColor
                    : disabledBoldColor;

            Color impactColor = strategy["impact"] == "High" 
                ? dangerColor 
                : strategy["impact"] == "Medium"
                    ? warningColor
                    : successColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${strategy["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${strategy["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${strategy["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: impactColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${strategy["impact"]} Impact",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: impactColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${strategy["effort"]} Effort",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(strategy["savings"] as double).toStringAsFixed(0)}/month",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Timeline: ${strategy["timeline"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Strategy",
              size: bs.md,
              onPressed: () {
                ss("New strategy form opened");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogWaste() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Log Waste Entry",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          QDropdownField(
            label: "Waste Type",
            items: [
              {"label": "Food Waste", "value": "food"},
              {"label": "Packaging", "value": "packaging"},
              {"label": "Oil/Grease", "value": "oil"},
              {"label": "General", "value": "general"},
            ],
            value: wasteType,
            onChanged: (value, label) {
              wasteType = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Category/Item",
            value: wasteCategory,
            hint: "e.g., Vegetables, Cardboard, Used oil",
            onChanged: (value) {
              wasteCategory = value;
              setState(() {});
            },
          ),

          QNumberField(
            label: "Weight (kg)",
            value: wasteWeight,
            hint: "Enter weight in kilograms",
            onChanged: (value) {
              wasteWeight = value;
              setState(() {});
            },
          ),

          QDropdownField(
            label: "Location",
            items: [
              {"label": "Kitchen", "value": "kitchen"},
              {"label": "Prep Area", "value": "prep"},
              {"label": "Dining Area", "value": "dining"},
              {"label": "Storage", "value": "storage"},
              {"label": "Bar", "value": "bar"},
            ],
            value: wasteLocation,
            onChanged: (value, label) {
              wasteLocation = value;
              setState(() {});
            },
          ),

          QMemoField(
            label: "Reason for Waste",
            value: wasteReason,
            hint: "Describe why this item was wasted",
            onChanged: (value) {
              wasteReason = value;
              setState(() {});
            },
          ),

          QNumberField(
            label: "Estimated Cost (\$)",
            value: estimatedCost,
            hint: "Estimated value of wasted item",
            onChanged: (value) {
              estimatedCost = value;
              setState(() {});
            },
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Waste Reduction Tips",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "• Check expiry dates regularly\n• Implement proper storage techniques\n• Train staff on portion control\n• Set up proper inventory rotation",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Entry",
                  size: bs.md,
                  onPressed: () {
                    if (wasteCategory.isNotEmpty && wasteWeight.isNotEmpty) {
                      ss("Waste entry logged successfully");
                      wasteCategory = "";
                      wasteWeight = "";
                      wasteReason = "";
                      estimatedCost = "";
                      setState(() {});
                    } else {
                      se("Please fill in required fields");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Clear Form",
                  size: bs.md,
                  onPressed: () {
                    wasteCategory = "";
                    wasteWeight = "";
                    wasteReason = "";
                    estimatedCost = "";
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Waste Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reduction", icon: Icon(Icons.trending_down)),
        Tab(text: "Log Waste", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildWasteTracking(),
        _buildAnalytics(),
        _buildReduction(),
        _buildLogWaste(),
      ],
    );
  }
}
