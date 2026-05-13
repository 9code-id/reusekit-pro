import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaEquipmentListView extends StatefulWidget {
  const ComaEquipmentListView({super.key});

  @override
  State<ComaEquipmentListView> createState() => _ComaEquipmentListViewState();
}

class _ComaEquipmentListViewState extends State<ComaEquipmentListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> equipmentList = [
    {
      "id": "EQ001",
      "name": "Excavator CAT 320D2",
      "category": "Heavy Machinery",
      "status": "Active",
      "location": "Site A - Block 1",
      "operator": "John Smith",
      "lastMaintenance": "2024-12-15",
      "nextMaintenance": "2025-01-15",
      "hoursUsed": 1240,
      "efficiency": 87.5,
      "image": "https://picsum.photos/400/300?random=1&keyword=excavator"
    },
    {
      "id": "EQ002", 
      "name": "Bulldozer D6T",
      "category": "Heavy Machinery",
      "status": "Maintenance",
      "location": "Workshop",
      "operator": "Mike Johnson",
      "lastMaintenance": "2024-11-20",
      "nextMaintenance": "2024-12-20",
      "hoursUsed": 890,
      "efficiency": 92.3,
      "image": "https://picsum.photos/400/300?random=2&keyword=bulldozer"
    },
    {
      "id": "EQ003",
      "name": "Crane Tower CT-250",
      "category": "Lifting Equipment",
      "status": "Active",
      "location": "Site B - Tower 2",
      "operator": "Sarah Wilson",
      "lastMaintenance": "2024-12-10",
      "nextMaintenance": "2025-02-10",
      "hoursUsed": 567,
      "efficiency": 94.1,
      "image": "https://picsum.photos/400/300?random=3&keyword=crane"
    },
    {
      "id": "EQ004",
      "name": "Concrete Mixer CM-500",
      "category": "Concrete Equipment", 
      "status": "Inactive",
      "location": "Storage Yard",
      "operator": "Not Assigned",
      "lastMaintenance": "2024-10-05",
      "nextMaintenance": "2025-01-05",
      "hoursUsed": 234,
      "efficiency": 76.8,
      "image": "https://picsum.photos/400/300?random=4&keyword=concrete"
    },
    {
      "id": "EQ005",
      "name": "Dump Truck DT-40",
      "category": "Transportation",
      "status": "Active",
      "location": "Site C - Road Access",
      "operator": "Robert Brown",
      "lastMaintenance": "2024-12-08",
      "nextMaintenance": "2025-01-08",
      "hoursUsed": 1567,
      "efficiency": 89.2,
      "image": "https://picsum.photos/400/300?random=5&keyword=dumptruck"
    },
    {
      "id": "EQ006",
      "name": "Compactor RC-25",
      "category": "Road Equipment",
      "status": "Active", 
      "location": "Site A - Access Road",
      "operator": "David Lee",
      "lastMaintenance": "2024-11-25",
      "nextMaintenance": "2024-12-25",
      "hoursUsed": 678,
      "efficiency": 91.7,
      "image": "https://picsum.photos/400/300?random=6&keyword=compactor"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Heavy Machinery", "value": "Heavy Machinery"},
    {"label": "Lifting Equipment", "value": "Lifting Equipment"},
    {"label": "Concrete Equipment", "value": "Concrete Equipment"},
    {"label": "Transportation", "value": "Transportation"},
    {"label": "Road Equipment", "value": "Road Equipment"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Inactive", "value": "Inactive"}
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipmentList.where((equipment) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${equipment["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${equipment["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || 
          "${equipment["category"]}" == selectedCategory;
      
      bool matchesStatus = selectedStatus == "All" ||
          "${equipment["status"]}" == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Maintenance":
        return warningColor;
      case "Inactive":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search equipment...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  // Filters
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
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
                ],
              ),
            ),

            // Equipment Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
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
                            Icon(Icons.construction, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Total Equipment",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${equipmentList.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${equipmentList.where((e) => e["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.build, color: warningColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Maintenance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${equipmentList.where((e) => e["status"] == "Maintenance").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Equipment List
            ...filteredEquipment.map((equipment) {
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${equipment["image"]}",
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${equipment["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${equipment["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${equipment["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusColor("${equipment["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${equipment["id"]} • ${equipment["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "${equipment["location"]}",
                                    style: TextStyle(
                                      fontSize: 11,
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Operator",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${equipment["operator"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
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
                                "Hours Used",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${equipment["hoursUsed"]}h",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
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
                                "Efficiency",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(equipment["efficiency"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
