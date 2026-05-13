import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFarmOverviewView extends StatefulWidget {
  const AmaFarmOverviewView({super.key});

  @override
  State<AmaFarmOverviewView> createState() => _AmaFarmOverviewViewState();
}

class _AmaFarmOverviewViewState extends State<AmaFarmOverviewView> {
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Fields", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Harvesting", "value": "Harvesting"},
    {"label": "Preparing", "value": "Preparing"},
    {"label": "Maintenance", "value": "Maintenance"},
  ];

  List<Map<String, dynamic>> farmFields = [
    {
      "id": 1,
      "name": "Main Field A",
      "crop": "Wheat",
      "variety": "Hard Red Winter",
      "area": "25.5",
      "status": "Active",
      "stage": "Flowering",
      "health": 95,
      "plantingDate": "2024-03-15",
      "expectedHarvest": "2024-07-20",
      "soilType": "Loamy",
      "irrigation": "Sprinkler",
      "image": "https://picsum.photos/300/200?random=1&keyword=wheat",
      "coordinates": "40.7128, -74.0060",
      "lastActivity": "Fertilizer application",
      "activityDate": "2 days ago",
    },
    {
      "id": 2,
      "name": "South Pasture",
      "crop": "Corn",
      "variety": "Sweet Corn",
      "area": "18.2",
      "status": "Active",
      "stage": "Vegetative",
      "health": 88,
      "plantingDate": "2024-04-01",
      "expectedHarvest": "2024-08-15",
      "soilType": "Clay",
      "irrigation": "Drip",
      "image": "https://picsum.photos/300/200?random=2&keyword=corn",
      "coordinates": "40.7500, -74.0100",
      "lastActivity": "Pest monitoring",
      "activityDate": "1 day ago",
    },
    {
      "id": 3,
      "name": "East Garden",
      "crop": "Tomatoes",
      "variety": "Cherry Tomatoes",
      "area": "8.7",
      "status": "Active",
      "stage": "Fruiting",
      "health": 76,
      "plantingDate": "2024-04-15",
      "expectedHarvest": "2024-07-30",
      "soilType": "Sandy",
      "irrigation": "Manual",
      "image": "https://picsum.photos/300/200?random=3&keyword=tomato",
      "coordinates": "40.7200, -74.0200",
      "lastActivity": "Watering",
      "activityDate": "6 hours ago",
    },
    {
      "id": 4,
      "name": "North Field",
      "crop": "Soybeans",
      "variety": "Non-GMO",
      "area": "15.3",
      "status": "Preparing",
      "stage": "Land Preparation",
      "health": 100,
      "plantingDate": "2024-06-01",
      "expectedHarvest": "2024-10-15",
      "soilType": "Loamy",
      "irrigation": "Sprinkler",
      "image": "https://picsum.photos/300/200?random=4&keyword=soybean",
      "coordinates": "40.7300, -74.0050",
      "lastActivity": "Soil testing",
      "activityDate": "3 days ago",
    },
    {
      "id": 5,
      "name": "West Orchard",
      "crop": "Apples",
      "variety": "Gala",
      "area": "12.8",
      "status": "Harvesting",
      "stage": "Mature",
      "health": 92,
      "plantingDate": "2020-03-01",
      "expectedHarvest": "2024-09-30",
      "soilType": "Silty",
      "irrigation": "Sprinkler",
      "image": "https://picsum.photos/300/200?random=5&keyword=apple",
      "coordinates": "40.7400, -74.0150",
      "lastActivity": "Harvesting",
      "activityDate": "Today",
    },
  ];

  List<Map<String, dynamic>> get filteredFields {
    if (selectedFilter == "All") return farmFields;
    return farmFields.where((field) => field["status"] == selectedFilter).toList();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'harvesting':
        return primaryColor;
      case 'preparing':
        return warningColor;
      case 'maintenance':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getHealthColor(int health) {
    if (health >= 90) return successColor;
    if (health >= 75) return primaryColor;
    if (health >= 60) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Open farm map view");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Add new field");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Farm Summary Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Farm Statistics",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${farmFields.fold(0.0, (sum, field) => sum + (double.tryParse(field["area"]) ?? 0.0)).toStringAsFixed(1)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Total Hectares",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${farmFields.length}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Active Fields",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${farmFields.where((f) => f["status"] == "Active").length}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "In Production",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((farmFields.fold(0, (sum, field) => sum + (field["health"] as int)) / farmFields.length)).toInt()}%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Avg Health",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
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

            // Filter Options
            QCategoryPicker(
              label: "Field Status Filter",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fields (${filteredFields.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    QButton(
                      icon: Icons.view_list,
                      size: bs.sm,
                      onPressed: () {
                        si("Switch to list view");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.grid_view,
                      size: bs.sm,
                      onPressed: () {
                        si("Current grid view");
                      },
                    ),
                  ],
                ),
              ],
            ),

            if (filteredFields.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.agriculture,
                      color: disabledBoldColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No fields found",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filter or add a new field",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredFields.map((field) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${field["image"]}",
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(field["status"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${field["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${field["area"]} ha",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${field["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${field["crop"]} - ${field["variety"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              
                              SizedBox(height: spSm),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stage",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${field["stage"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
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
                                          "Health",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${field["health"]}%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: getHealthColor(field["health"]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last Activity",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${field["lastActivity"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      "${field["activityDate"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(height: spSm),
                              
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Open ${field["name"]} details");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            // Quick Actions
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Field",
                          size: bs.sm,
                          onPressed: () {
                            si("Navigate to add field form");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Schedule Task",
                          size: bs.sm,
                          onPressed: () {
                            si("Open task scheduler");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          size: bs.sm,
                          onPressed: () {
                            si("Open report generator");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          size: bs.sm,
                          onPressed: () {
                            si("Export farm data");
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
      ),
    );
  }
}
