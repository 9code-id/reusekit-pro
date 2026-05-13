import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaEquipmentView extends StatefulWidget {
  const FwaEquipmentView({super.key});

  @override
  State<FwaEquipmentView> createState() => _FwaEquipmentViewState();
}

class _FwaEquipmentViewState extends State<FwaEquipmentView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedAvailability = "All";
  
  List<String> categories = ["All", "Cardio", "Strength", "Free Weights", "Functional", "Accessories"];
  List<String> availabilityOptions = ["All", "Available", "In Use", "Maintenance"];
  
  List<Map<String, dynamic>> equipment = [
    {
      "id": 1,
      "name": "Treadmill Pro X1",
      "category": "Cardio",
      "status": "Available",
      "location": "Cardio Zone A",
      "description": "High-performance treadmill with incline feature and heart rate monitoring",
      "image": "https://picsum.photos/120/120?random=1&keyword=treadmill",
      "maxSpeed": "20 km/h",
      "features": ["Heart Rate Monitor", "Incline", "Pre-set Programs"],
      "maintenanceDate": "2024-05-15",
      "nextMaintenance": "2024-08-15"
    },
    {
      "id": 2,
      "name": "Leg Press Machine",
      "category": "Strength",
      "status": "In Use",
      "location": "Strength Zone B",
      "description": "Heavy-duty leg press machine for lower body strength training",
      "image": "https://picsum.photos/120/120?random=2&keyword=gym",
      "maxWeight": "500 kg",
      "features": ["Adjustable Seat", "Safety Locks", "Weight Stack"],
      "maintenanceDate": "2024-04-20",
      "nextMaintenance": "2024-07-20"
    },
    {
      "id": 3,
      "name": "Olympic Barbell Set",
      "category": "Free Weights",
      "status": "Available",
      "location": "Free Weight Area",
      "description": "Professional Olympic barbell with weight plates set",
      "image": "https://picsum.photos/120/120?random=3&keyword=barbell",
      "maxWeight": "300 kg",
      "features": ["Olympic Standard", "Knurled Grip", "Rotating Sleeves"],
      "maintenanceDate": "2024-06-01",
      "nextMaintenance": "2024-09-01"
    },
    {
      "id": 4,
      "name": "Cable Machine",
      "category": "Functional",
      "status": "Available",
      "location": "Functional Zone",
      "description": "Multi-station cable machine for versatile strength training",
      "image": "https://picsum.photos/120/120?random=4&keyword=cable",
      "maxWeight": "200 kg",
      "features": ["Dual Pulley System", "Multiple Attachments", "Adjustable Height"],
      "maintenanceDate": "2024-05-10",
      "nextMaintenance": "2024-08-10"
    },
    {
      "id": 5,
      "name": "Rowing Machine",
      "category": "Cardio",
      "status": "Maintenance",
      "location": "Cardio Zone B",
      "description": "Water resistance rowing machine for full-body cardio workout",
      "image": "https://picsum.photos/120/120?random=5&keyword=rowing",
      "maxResistance": "Level 10",
      "features": ["Water Resistance", "LCD Display", "Folding Design"],
      "maintenanceDate": "2024-06-10",
      "nextMaintenance": "2024-06-20"
    },
    {
      "id": 6,
      "name": "Kettlebell Set",
      "category": "Free Weights", 
      "status": "Available",
      "location": "Functional Zone",
      "description": "Complete kettlebell set ranging from 5kg to 40kg",
      "image": "https://picsum.photos/120/120?random=6&keyword=kettlebell",
      "range": "5-40 kg",
      "features": ["Cast Iron", "Wide Handle", "Flat Bottom"],
      "maintenanceDate": "2024-05-25",
      "nextMaintenance": "2024-08-25"
    }
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipment.where((item) {
      bool nameMatch = (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool categoryMatch = selectedCategory == "All" || (item["category"] as String) == selectedCategory;
      bool availabilityMatch = selectedAvailability == "All" || (item["status"] as String) == selectedAvailability;
      
      return nameMatch && categoryMatch && availabilityMatch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available": return successColor;
      case "In Use": return warningColor;
      case "Maintenance": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Available": return Icons.check_circle;
      case "In Use": return Icons.person;
      case "Maintenance": return Icons.build;
      default: return Icons.help;
    }
  }

  Widget _buildEquipmentStats() {
    int available = equipment.where((item) => (item["status"] as String) == "Available").length;
    int inUse = equipment.where((item) => (item["status"] as String) == "In Use").length;
    int maintenance = equipment.where((item) => (item["status"] as String) == "Maintenance").length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$available",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Available",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$inUse",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "In Use",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$maintenance",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Maintenance",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Equipment"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // QR scanner for equipment
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Equipment stats
            _buildEquipmentStats(),
            
            SizedBox(height: spMd),
            
            // Search bar
            QTextField(
              label: "Search Equipment",
              value: searchQuery,
              hint: "Search by name or model...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: availabilityOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Equipment list header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Equipment (${filteredEquipment.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Toggle view mode
                  },
                  child: Icon(
                    Icons.view_list,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Equipment grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredEquipment.map((item) {
                Color statusColor = _getStatusColor(item["status"] as String);
                IconData statusIcon = _getStatusIcon(item["status"] as String);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Equipment image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${item["image"]}",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Status badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              statusIcon,
                              size: 12,
                              color: statusColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${item["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      // Equipment name
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: spXs),
                      
                      // Category
                      Text(
                        "${item["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${item["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Key specification
                      if (item.containsKey("maxWeight"))
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fitness_center,
                                size: 12,
                                color: infoColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Max: ${item["maxWeight"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      if (item.containsKey("maxSpeed"))
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.speed,
                                size: 12,
                                color: infoColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Max: ${item["maxSpeed"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      if (item.containsKey("range"))
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fitness_center,
                                size: 12,
                                color: infoColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Range: ${item["range"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      SizedBox(height: spSm),
                      
                      // Action button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: (item["status"] as String) == "Available" ? "View Details" : "View Status",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to equipment details
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Report equipment issue
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.report_problem,
          color: Colors.white,
        ),
      ),
    );
  }
}
