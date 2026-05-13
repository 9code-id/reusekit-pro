import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobilePhotosView extends StatefulWidget {
  const FsmMobilePhotosView({super.key});

  @override
  State<FsmMobilePhotosView> createState() => _FsmMobilePhotosViewState();
}

class _FsmMobilePhotosViewState extends State<FsmMobilePhotosView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedWorkOrder = "";
  String selectedDate = "";

  List<Map<String, dynamic>> photos = [
    {
      "id": "PHT-001",
      "title": "HVAC Unit - Before Maintenance",
      "description": "Air conditioning unit showing wear on fan belt and filter needs replacement",
      "category": "Before Work",
      "workOrder": "WO-2024-001",
      "customer": "Metro Office Complex",
      "technician": "Alex Johnson",
      "capturedDate": "2024-12-20 08:30:00",
      "location": "Rooftop - Building A",
      "imageUrl": "https://picsum.photos/300/200?random=1&keyword=hvac",
      "thumbnailUrl": "https://picsum.photos/150/100?random=1&keyword=hvac",
      "fileSize": "2.4 MB",
      "resolution": "1920x1080",
      "notes": "Significant dust accumulation visible on coils",
      "tags": ["HVAC", "Maintenance", "Filter", "Before"],
      "gpsCoordinates": "40.7128,-74.0060",
      "weatherConditions": "Clear, 72°F",
    },
    {
      "id": "PHT-002",
      "title": "HVAC Unit - After Maintenance",
      "description": "Completed maintenance work with new filter installed and cleaned coils",
      "category": "After Work",
      "workOrder": "WO-2024-001",
      "customer": "Metro Office Complex",
      "technician": "Alex Johnson",
      "capturedDate": "2024-12-20 11:45:00",
      "location": "Rooftop - Building A",
      "imageUrl": "https://picsum.photos/300/200?random=2&keyword=hvac",
      "thumbnailUrl": "https://picsum.photos/150/100?random=2&keyword=hvac",
      "fileSize": "2.1 MB",
      "resolution": "1920x1080",
      "notes": "Unit running efficiently after maintenance",
      "tags": ["HVAC", "Maintenance", "After", "Completed"],
      "gpsCoordinates": "40.7128,-74.0060",
      "weatherConditions": "Clear, 75°F",
    },
    {
      "id": "PHT-003",
      "title": "Burst Pipe Damage Assessment",
      "description": "Water damage in basement area from burst pipe - requires immediate attention",
      "category": "Damage Assessment",
      "workOrder": "WO-2024-002",
      "customer": "Riverside Apartments",
      "technician": "Maria Rodriguez",
      "capturedDate": "2024-12-19 20:45:00",
      "location": "Basement - Building B",
      "imageUrl": "https://picsum.photos/300/200?random=3&keyword=pipe",
      "thumbnailUrl": "https://picsum.photos/150/100?random=3&keyword=pipe",
      "fileSize": "3.2 MB",
      "resolution": "1920x1080",
      "notes": "Extensive water damage to flooring and walls",
      "tags": ["Plumbing", "Emergency", "Damage", "Water"],
      "gpsCoordinates": "40.7589,-73.9851",
      "weatherConditions": "Cloudy, 68°F",
    },
    {
      "id": "PHT-004",
      "title": "Electrical Panel Installation",
      "description": "New electrical panel installation progress at creative studio",
      "category": "Work in Progress",
      "workOrder": "WO-2024-003",
      "customer": "Creative Design Studio",
      "technician": "David Kim",
      "capturedDate": "2024-12-20 14:20:00",
      "location": "Electrical Room - Floor 3",
      "imageUrl": "https://picsum.photos/300/200?random=4&keyword=electrical",
      "thumbnailUrl": "https://picsum.photos/150/100?random=4&keyword=electrical",
      "fileSize": "2.8 MB",
      "resolution": "1920x1080",
      "notes": "Panel installation 60% complete, wiring in progress",
      "tags": ["Electrical", "Installation", "Panel", "Progress"],
      "gpsCoordinates": "40.7505,-73.9934",
      "weatherConditions": "Sunny, 70°F",
    },
    {
      "id": "PHT-005",
      "title": "Safety Equipment Inspection",
      "description": "Monthly safety equipment check at construction site",
      "category": "Safety Documentation",
      "workOrder": "",
      "customer": "Construction Site Alpha",
      "technician": "Maria Rodriguez",
      "capturedDate": "2024-12-20 09:15:00",
      "location": "Site Entrance",
      "imageUrl": "https://picsum.photos/300/200?random=5&keyword=safety",
      "thumbnailUrl": "https://picsum.photos/150/100?random=5&keyword=safety",
      "fileSize": "1.9 MB",
      "resolution": "1920x1080",
      "notes": "All safety equipment properly maintained and accessible",
      "tags": ["Safety", "Inspection", "Equipment", "Compliance"],
      "gpsCoordinates": "40.7282,-74.0776",
      "weatherConditions": "Partly cloudy, 69°F",
    },
    {
      "id": "PHT-006",
      "title": "Material Delivery Documentation",
      "description": "HVAC filters and parts delivered for upcoming maintenance work",
      "category": "Material Documentation",
      "workOrder": "WO-2024-001",
      "customer": "Metro Office Complex",
      "technician": "Sarah Wilson",
      "capturedDate": "2024-12-20 07:30:00",
      "location": "Loading Dock",
      "imageUrl": "https://picsum.photos/300/200?random=6&keyword=delivery",
      "thumbnailUrl": "https://picsum.photos/150/100?random=6&keyword=delivery",
      "fileSize": "2.5 MB",
      "resolution": "1920x1080",
      "notes": "All materials accounted for and in good condition",
      "tags": ["Materials", "Delivery", "HVAC", "Inventory"],
      "gpsCoordinates": "40.7128,-74.0060",
      "weatherConditions": "Clear, 68°F",
    },
    {
      "id": "PHT-007",
      "title": "Equipment Calibration Check",
      "description": "Digital multimeter calibration verification for electrical work",
      "category": "Equipment Documentation",
      "workOrder": "",
      "customer": "",
      "technician": "David Kim",
      "capturedDate": "2024-12-20 12:00:00",
      "location": "Mobile Van #18",
      "imageUrl": "https://picsum.photos/300/200?random=7&keyword=multimeter",
      "thumbnailUrl": "https://picsum.photos/150/100?random=7&keyword=multimeter",
      "fileSize": "1.7 MB",
      "resolution": "1920x1080",
      "notes": "Equipment within calibration tolerances",
      "tags": ["Equipment", "Calibration", "Tools", "Quality"],
      "gpsCoordinates": "40.7505,-73.9934",
      "weatherConditions": "Sunny, 72°F",
    },
    {
      "id": "PHT-008",
      "title": "Customer Walkthrough",
      "description": "Final walkthrough with customer showing completed electrical work",
      "category": "Customer Documentation",
      "workOrder": "WO-2024-003",
      "customer": "Creative Design Studio",
      "technician": "David Kim",
      "capturedDate": "2024-12-20 16:30:00",
      "location": "Office Space - Floor 3",
      "imageUrl": "https://picsum.photos/300/200?random=8&keyword=office",
      "thumbnailUrl": "https://picsum.photos/150/100?random=8&keyword=office",
      "fileSize": "2.3 MB",
      "resolution": "1920x1080",
      "notes": "Customer satisfied with installation quality",
      "tags": ["Customer", "Walkthrough", "Completion", "Satisfaction"],
      "gpsCoordinates": "40.7505,-73.9934",
      "weatherConditions": "Sunny, 73°F",
    },
  ];

  List<Map<String, dynamic>> get filteredPhotos {
    return photos.where((photo) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${photo["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${photo["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${photo["technician"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory.isEmpty || photo["category"] == selectedCategory;
      bool matchesWorkOrder = selectedWorkOrder.isEmpty || photo["workOrder"] == selectedWorkOrder;
      bool matchesDate = selectedDate.isEmpty || 
          "${photo["capturedDate"]}".startsWith(selectedDate);
      return matchesSearch && matchesCategory && matchesWorkOrder && matchesDate;
    }).toList();
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Before Work":
        return warningColor;
      case "After Work":
        return successColor;
      case "Work in Progress":
        return primaryColor;
      case "Damage Assessment":
        return dangerColor;
      case "Safety Documentation":
        return infoColor;
      case "Material Documentation":
        return primaryColor;
      case "Equipment Documentation":
        return warningColor;
      case "Customer Documentation":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case "Before Work":
        return Icons.start;
      case "After Work":
        return Icons.done;
      case "Work in Progress":
        return Icons.work;
      case "Damage Assessment":
        return Icons.report_problem;
      case "Safety Documentation":
        return Icons.security;
      case "Material Documentation":
        return Icons.inventory;
      case "Equipment Documentation":
        return Icons.build;
      case "Customer Documentation":
        return Icons.people;
      default:
        return Icons.photo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Photos"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              ss("Camera opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () {
              // navigateTo('PhotoGalleryView')
            },
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
                  QTextField(
                    label: "Search photos...",
                    value: searchQuery,
                    hint: "Search by title, description, or technician",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": ""},
                            {"label": "Before Work", "value": "Before Work"},
                            {"label": "After Work", "value": "After Work"},
                            {"label": "Work in Progress", "value": "Work in Progress"},
                            {"label": "Damage Assessment", "value": "Damage Assessment"},
                            {"label": "Safety Documentation", "value": "Safety Documentation"},
                            {"label": "Material Documentation", "value": "Material Documentation"},
                            {"label": "Equipment Documentation", "value": "Equipment Documentation"},
                            {"label": "Customer Documentation", "value": "Customer Documentation"},
                          ],
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
                          label: "Work Order",
                          items: [
                            {"label": "All Work Orders", "value": ""},
                            {"label": "WO-2024-001", "value": "WO-2024-001"},
                            {"label": "WO-2024-002", "value": "WO-2024-002"},
                            {"label": "WO-2024-003", "value": "WO-2024-003"},
                          ],
                          value: selectedWorkOrder,
                          onChanged: (value, label) {
                            selectedWorkOrder = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Photo Statistics
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
                      children: [
                        Icon(Icons.photo_library, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${photos.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Photos",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      children: [
                        Icon(Icons.today, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${photos.where((p) => "${p["capturedDate"]}".startsWith("2024-12-20")).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      children: [
                        Icon(Icons.storage, color: infoColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${(photos.fold(0.0, (sum, p) => sum + double.parse((p["fileSize"] as String).split(" ")[0])) / 1024).toStringAsFixed(1)}GB",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Storage Used",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
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
                    children: [
                      Icon(Icons.flash_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Take Photo",
                          icon: Icons.camera_alt,
                          size: bs.sm,
                          onPressed: () {
                            ss("Camera opened for new photo");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Upload from Gallery",
                          icon: Icons.photo_library,
                          color: primaryColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("Gallery opened for photo selection");
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Sync Photos",
                          icon: Icons.sync,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("Photos synced to cloud");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Backup All",
                          icon: Icons.backup,
                          color: successColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("All photos backed up successfully");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Photos Grid
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.photo_camera, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Photos (${filteredPhotos.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.all(spSm),
                    minItemWidth: 200,
                    children: filteredPhotos.map((photo) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                image: DecorationImage(
                                  image: NetworkImage("${photo["imageUrl"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: getCategoryColor("${photo["category"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            getCategoryIcon("${photo["category"]}"),
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${photo["category"]}",
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${photo["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${photo["description"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if ("${photo["workOrder"]}".isNotEmpty)
                                    Row(
                                      children: [
                                        Icon(Icons.work, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 2),
                                        Text(
                                          "${photo["workOrder"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          "${photo["technician"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "${DateTime.parse("${photo["capturedDate"]}").dMMMy}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${photo["fileSize"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      QButton(
                                        label: "View",
                                        size: bs.sm,
                                        onPressed: () {
                                          // navigateTo('PhotoDetailView')
                                        },
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.share,
                                        size: bs.sm,
                                        color: infoColor,
                                        onPressed: () {
                                          ss("Photo shared");
                                        },
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.download,
                                        size: bs.sm,
                                        color: successColor,
                                        onPressed: () {
                                          ss("Photo downloaded");
                                        },
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
