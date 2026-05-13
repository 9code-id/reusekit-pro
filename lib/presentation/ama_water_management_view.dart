import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaWaterManagementView extends StatefulWidget {
  const AmaWaterManagementView({super.key});

  @override
  State<AmaWaterManagementView> createState() => _AmaWaterManagementViewState();
}

class _AmaWaterManagementViewState extends State<AmaWaterManagementView> {
  int selectedPeriod = 0;
  String selectedSource = "all";
  
  List<Map<String, dynamic>> waterSources = [
    {
      "id": "WS001",
      "name": "Main Well",
      "type": "Ground Water",
      "capacity": "50000 L",
      "currentLevel": 42500,
      "maxLevel": 50000,
      "flowRate": "45 L/min",
      "quality": "Excellent",
      "qualityColor": successColor,
      "status": "Active",
      "lastTested": "2024-06-10",
      "ph": 7.2,
      "conductivity": 450,
      "temperature": 18.5,
      "location": "North Field",
      "depth": "120 meters"
    },
    {
      "id": "WS002",
      "name": "Rainwater Tank",
      "type": "Surface Water",
      "capacity": "25000 L",
      "currentLevel": 18750,
      "maxLevel": 25000,
      "flowRate": "25 L/min",
      "quality": "Good",
      "qualityColor": infoColor,
      "status": "Active",
      "lastTested": "2024-06-12",
      "ph": 6.8,
      "conductivity": 125,
      "temperature": 22.0,
      "location": "Central Storage",
      "depth": "Surface collection"
    },
    {
      "id": "WS003",
      "name": "River Intake",
      "type": "Surface Water",
      "capacity": "Unlimited",
      "currentLevel": 0,
      "maxLevel": 0,
      "flowRate": "85 L/min",
      "quality": "Fair",
      "qualityColor": warningColor,
      "status": "Seasonal",
      "lastTested": "2024-06-08",
      "ph": 7.8,
      "conductivity": 680,
      "temperature": 20.5,
      "location": "East Boundary",
      "depth": "2 meters intake"
    },
    {
      "id": "WS004",
      "name": "Secondary Well",
      "type": "Ground Water",
      "capacity": "30000 L",
      "currentLevel": 24000,
      "maxLevel": 30000,
      "flowRate": "35 L/min",
      "quality": "Good",
      "qualityColor": infoColor,
      "status": "Backup",
      "lastTested": "2024-06-05",
      "ph": 7.5,
      "conductivity": 520,
      "temperature": 19.2,
      "location": "South Field",
      "depth": "95 meters"
    }
  ];

  List<Map<String, dynamic>> waterUsageData = [
    {
      "period": "Today",
      "totalUsage": 15680,
      "irrigation": 12540,
      "livestock": 2140,
      "processing": 750,
      "domestic": 250,
      "cost": 125.44,
      "efficiency": 89
    },
    {
      "period": "This Week", 
      "totalUsage": 98450,
      "irrigation": 78760,
      "livestock": 14980,
      "processing": 3710,
      "domestic": 1000,
      "cost": 787.60,
      "efficiency": 87
    },
    {
      "period": "This Month",
      "totalUsage": 425630,
      "irrigation": 340504,
      "livestock": 63843,
      "processing": 15541,
      "domestic": 5742,
      "cost": 3405.04,
      "efficiency": 85
    }
  ];

  List<Map<String, dynamic>> periodFilters = [
    {"label": "Today", "value": 0},
    {"label": "This Week", "value": 1}, 
    {"label": "This Month", "value": 2}
  ];

  List<Map<String, dynamic>> sourceFilters = [
    {"label": "All Sources", "value": "all"},
    {"label": "Ground Water", "value": "Ground Water"},
    {"label": "Surface Water", "value": "Surface Water"}
  ];

  List<Map<String, dynamic>> getFilteredSources() {
    if (selectedSource == "all") {
      return waterSources;
    }
    return waterSources.where((source) => source["type"] == selectedSource).toList();
  }

  double getWaterLevelPercentage(Map<String, dynamic> source) {
    if (source["maxLevel"] == 0) return 0;
    return ((source["currentLevel"] as int) / (source["maxLevel"] as int)) * 100;
  }

  Color getWaterLevelColor(double percentage) {
    if (percentage > 70) return successColor;
    if (percentage > 30) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSources = getFilteredSources();
    Map<String, dynamic> currentUsage = waterUsageData[selectedPeriod];
    double totalCapacity = waterSources.where((s) => s["maxLevel"] != 0).map((s) => s["maxLevel"] as int).fold(0.0, (a, b) => a + b);
    double totalCurrent = waterSources.where((s) => s["maxLevel"] != 0).map((s) => s["currentLevel"] as int).fold(0.0, (a, b) => a + b);
    double totalPercentage = totalCapacity > 0 ? (totalCurrent / totalCapacity) * 100 : 0;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to water analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.water_drop),
            onPressed: () {
              // Water quality reports
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Water Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${totalPercentage.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Water Level",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
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
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.speed,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentUsage["efficiency"]}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Efficiency",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(currentUsage["cost"] as double).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${periodFilters[selectedPeriod]["label"]} Cost",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Water Usage Dashboard
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Water Usage",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 120,
                        child: QDropdownField(
                          label: "Period",
                          items: periodFilters.map((filter) => {
                            "label": filter["label"],
                            "value": filter["value"]
                          }).toList(),
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Total Usage
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.water,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Water Usage",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((currentUsage["totalUsage"] as int) / 1000).toStringAsFixed(1)}K Liters",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Usage Breakdown
                  Text(
                    "Usage Breakdown:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.green.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.grass,
                                color: Colors.green,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${((currentUsage["irrigation"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Irrigation",
                                style: TextStyle(
                                  fontSize: 9,
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
                            color: Colors.brown.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.pets,
                                color: Colors.brown,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${((currentUsage["livestock"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Livestock",
                                style: TextStyle(
                                  fontSize: 9,
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
                            color: Colors.orange.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.factory,
                                color: Colors.orange,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${((currentUsage["processing"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Processing",
                                style: TextStyle(
                                  fontSize: 9,
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
                            color: Colors.blue.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.blue,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${((currentUsage["domestic"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Domestic",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: disabledBoldColor,
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
            ),
            
            SizedBox(height: spLg),
            
            // Water Sources Section
            Row(
              children: [
                Text(
                  "Water Sources",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  width: 150,
                  child: QDropdownField(
                    label: "Filter",
                    items: sourceFilters,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            ...filteredSources.map((source) {
              double levelPercentage = getWaterLevelPercentage(source);
              Color levelColor = getWaterLevelColor(levelPercentage);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: source["qualityColor"] as Color,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (source["qualityColor"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      source["type"] == "Ground Water" ? Icons.water_drop : Icons.waves,
                      color: source["qualityColor"] as Color,
                      size: 24,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${source["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (source["qualityColor"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${source["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: source["qualityColor"] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: spXs),
                      Text(
                        "${source["type"]} • ${source["location"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      if (source["maxLevel"] != 0) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Water Level: ${levelPercentage.toStringAsFixed(0)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: levelColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${((source["currentLevel"] as int) / 1000).toStringAsFixed(0)}K / ${((source["maxLevel"] as int) / 1000).toStringAsFixed(0)}K L",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: levelPercentage / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: levelColor,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Text(
                          "Flow-through source (${source["flowRate"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Water Quality Metrics
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Water Quality - ${source["quality"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "pH Level",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${source["ph"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Conductivity",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${source["conductivity"]} μS/cm",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Temperature",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${source["temperature"]}°C",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Source Details
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Flow Rate",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${source["flowRate"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Depth/Location",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${source["depth"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Last Tested",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${source["lastTested"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Test Quality",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Test water quality
                                  },
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: QButton(
                                  label: "View History",
                                  size: bs.sm,
                                  onPressed: () {
                                    // View usage history
                                  },
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: QButton(
                                  label: "Settings",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Source settings
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new water source
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
