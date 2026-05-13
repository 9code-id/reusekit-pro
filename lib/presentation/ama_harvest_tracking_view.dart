import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaHarvestTrackingView extends StatefulWidget {
  const AmaHarvestTrackingView({super.key});

  @override
  State<AmaHarvestTrackingView> createState() => _AmaHarvestTrackingViewState();
}

class _AmaHarvestTrackingViewState extends State<AmaHarvestTrackingView> {
  String selectedCrop = "All Crops";
  String selectedStatus = "In Progress";
  String selectedField = "All Fields";
  int currentTab = 0;

  List<Map<String, dynamic>> harvestItems = [
    {
      "id": "HV001",
      "cropName": "Wheat",
      "fieldName": "North Field A1",
      "plannedDate": DateTime(2024, 6, 15),
      "actualStartDate": DateTime(2024, 6, 16),
      "estimatedQuantity": 2500,
      "harvestedQuantity": 1800,
      "progress": 72,
      "status": "In Progress",
      "quality": "Premium",
      "workers": 8,
      "equipment": ["Combine Harvester", "Grain Cart", "Truck"],
      "weatherCondition": "Sunny",
      "moistureLevel": 12.5,
      "notes": "Good weather conditions, ahead of schedule",
      "image": "https://picsum.photos/300/200?random=1&keyword=wheat"
    },
    {
      "id": "HV002",
      "cropName": "Corn",
      "fieldName": "South Field B2",
      "plannedDate": DateTime(2024, 6, 18),
      "actualStartDate": DateTime(2024, 6, 18),
      "estimatedQuantity": 3200,
      "harvestedQuantity": 3200,
      "progress": 100,
      "status": "Completed",
      "quality": "Good",
      "workers": 12,
      "equipment": ["Combine Harvester", "Grain Cart", "Storage Bins"],
      "weatherCondition": "Partly Cloudy",
      "moistureLevel": 15.2,
      "notes": "Harvest completed successfully",
      "image": "https://picsum.photos/300/200?random=2&keyword=corn"
    },
    {
      "id": "HV003",
      "cropName": "Soybeans",
      "fieldName": "East Field C1",
      "plannedDate": DateTime(2024, 6, 20),
      "actualStartDate": null,
      "estimatedQuantity": 1800,
      "harvestedQuantity": 0,
      "progress": 0,
      "status": "Scheduled",
      "quality": "Pending",
      "workers": 6,
      "equipment": ["Combine Harvester", "Grain Cart"],
      "weatherCondition": "Rain Expected",
      "moistureLevel": 0,
      "notes": "Waiting for weather to clear",
      "image": "https://picsum.photos/300/200?random=3&keyword=soybeans"
    },
    {
      "id": "HV004",
      "cropName": "Rice",
      "fieldName": "West Field D3",
      "plannedDate": DateTime(2024, 6, 22),
      "actualStartDate": DateTime(2024, 6, 22),
      "estimatedQuantity": 4500,
      "harvestedQuantity": 2700,
      "progress": 60,
      "status": "In Progress",
      "quality": "Premium",
      "workers": 15,
      "equipment": ["Rice Harvester", "Trucks", "Drying Equipment"],
      "weatherCondition": "Clear",
      "moistureLevel": 18.5,
      "notes": "High quality rice, excellent conditions",
      "image": "https://picsum.photos/300/200?random=4&keyword=rice"
    },
    {
      "id": "HV005",
      "cropName": "Barley",
      "fieldName": "North Field A2",
      "plannedDate": DateTime(2024, 6, 25),
      "actualStartDate": null,
      "estimatedQuantity": 2100,
      "harvestedQuantity": 0,
      "progress": 0,
      "status": "Delayed",
      "quality": "Pending",
      "workers": 0,
      "equipment": ["Combine Harvester"],
      "weatherCondition": "Stormy",
      "moistureLevel": 0,
      "notes": "Delayed due to equipment maintenance",
      "image": "https://picsum.photos/300/200?random=5&keyword=barley"
    }
  ];

  List<Map<String, dynamic>> todayActivity = [
    {
      "time": "06:00",
      "activity": "Field inspection started",
      "field": "North Field A1",
      "status": "completed"
    },
    {
      "time": "07:30",
      "activity": "Harvesting equipment deployed",
      "field": "North Field A1", 
      "status": "completed"
    },
    {
      "time": "09:15",
      "activity": "First batch harvested",
      "field": "North Field A1",
      "status": "completed"
    },
    {
      "time": "12:00",
      "activity": "Lunch break",
      "field": "All Fields",
      "status": "completed"
    },
    {
      "time": "13:30",
      "activity": "Quality assessment",
      "field": "West Field D3",
      "status": "in_progress"
    },
    {
      "time": "15:00",
      "activity": "Equipment maintenance",
      "field": "Equipment Bay",
      "status": "scheduled"
    }
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "All Crops"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Barley", "value": "Barley"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Delayed", "value": "Delayed"}
  ];

  List<Map<String, dynamic>> fieldOptions = [
    {"label": "All Fields", "value": "All Fields"},
    {"label": "North Field A1", "value": "North Field A1"},
    {"label": "North Field A2", "value": "North Field A2"},
    {"label": "South Field B2", "value": "South Field B2"},
    {"label": "East Field C1", "value": "East Field C1"},
    {"label": "West Field D3", "value": "West Field D3"}
  ];

  List<Map<String, dynamic>> get filteredHarvests {
    return harvestItems.where((harvest) {
      bool cropMatch = selectedCrop == "All Crops" || harvest["cropName"] == selectedCrop;
      bool statusMatch = selectedStatus == "All Status" || harvest["status"] == selectedStatus;
      bool fieldMatch = selectedField == "All Fields" || harvest["fieldName"] == selectedField;
      return cropMatch && statusMatch && fieldMatch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Scheduled":
        return warningColor;
      case "Delayed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getQualityColor(String quality) {
    switch (quality) {
      case "Premium":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "scheduled":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _startHarvest(Map<String, dynamic> harvest) {
    setState(() {
      harvest["status"] = "In Progress";
      harvest["actualStartDate"] = DateTime.now();
    });
    ss("Harvest started for ${harvest["cropName"]} in ${harvest["fieldName"]}");
  }

  void _updateProgress(Map<String, dynamic> harvest) {
    // Simulate progress update
    ss("Progress updated for ${harvest["cropName"]}");
  }

  void _completeHarvest(Map<String, dynamic> harvest) {
    setState(() {
      harvest["status"] = "Completed";
      harvest["progress"] = 100;
      harvest["harvestedQuantity"] = harvest["estimatedQuantity"];
    });
    ss("Harvest completed for ${harvest["cropName"]}");
  }

  void _addQualityNote(Map<String, dynamic> harvest) {
    ss("Quality assessment recorded for ${harvest["cropName"]}");
  }

  Widget _buildOverviewTab() {
    int totalHarvests = harvestItems.length;
    int completedHarvests = harvestItems.where((h) => h["status"] == "Completed").length;
    int inProgressHarvests = harvestItems.where((h) => h["status"] == "In Progress").length;
    int scheduledHarvests = harvestItems.where((h) => h["status"] == "Scheduled").length;

    double totalEstimated = harvestItems
        .map((h) => h["estimatedQuantity"] as int)
        .fold(0.0, (sum, qty) => sum + qty.toDouble());
    
    double totalHarvested = harvestItems
        .map((h) => h["harvestedQuantity"] as int)
        .fold(0.0, (sum, qty) => sum + qty.toDouble());

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(Icons.agriculture, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Harvests",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$totalHarvests",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$completedHarvests",
                        style: TextStyle(
                          fontSize: fsH3,
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

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(Icons.schedule, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$inProgressHarvests",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(Icons.pending, color: infoColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Scheduled",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$scheduledHarvests",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Yield Summary
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.inventory, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Yield Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Estimated",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${totalEstimated.toInt()} kg",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Harvested",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${totalHarvested.toInt()} kg",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Efficiency",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${((totalHarvested / totalEstimated) * 100).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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

          // Today's Activity
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.today, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Today's Activity",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...todayActivity.map((activity) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          child: Text(
                            "${activity["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getActivityStatusColor(activity["status"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["activity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${activity["field"]}",
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
        ],
      ),
    );
  }

  Widget _buildHarvestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Crop",
                  items: cropOptions,
                  value: selectedCrop,
                  onChanged: (value, label) {
                    selectedCrop = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Field",
            items: fieldOptions,
            value: selectedField,
            onChanged: (value, label) {
              selectedField = value;
              setState(() {});
            },
          ),

          // Harvest List
          ...filteredHarvests.map((harvest) {
            return Container(
              padding: EdgeInsets.all(spMd),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${harvest["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${harvest["cropName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(harvest["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${harvest["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getStatusColor(harvest["status"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${harvest["fieldName"]} • ID: ${harvest["id"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Planned: ${(harvest["plannedDate"] as DateTime).dMMMy}",
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
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${harvest["progress"]}%",
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
                        value: (harvest["progress"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Harvest Details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Estimated",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${harvest["estimatedQuantity"]} kg",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Harvested",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${harvest["harvestedQuantity"]} kg",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "Quality",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${harvest["quality"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getQualityColor(harvest["quality"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (harvest["notes"] != null && (harvest["notes"] as String).isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.notes, size: 16, color: primaryColor),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${harvest["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: spMd),

                  // Action Buttons
                  Row(
                    spacing: spSm,
                    children: [
                      if (harvest["status"] == "Scheduled") ...[
                        Expanded(
                          child: QButton(
                            label: "Start Harvest",
                            size: bs.sm,
                            onPressed: () => _startHarvest(harvest),
                          ),
                        ),
                      ],
                      if (harvest["status"] == "In Progress") ...[
                        Expanded(
                          child: QButton(
                            label: "Update Progress",
                            size: bs.sm,
                            onPressed: () => _updateProgress(harvest),
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Complete",
                            size: bs.sm,
                            onPressed: () => _completeHarvest(harvest),
                          ),
                        ),
                      ],
                      if (harvest["status"] == "Completed") ...[
                        Expanded(
                          child: QButton(
                            label: "Quality Notes",
                            size: bs.sm,
                            onPressed: () => _addQualityNote(harvest),
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Harvest Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Harvests", icon: Icon(Icons.agriculture)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildHarvestsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
