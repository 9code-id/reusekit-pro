import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaFloorPlanView extends StatefulWidget {
  const ReaFloorPlanView({super.key});

  @override
  State<ReaFloorPlanView> createState() => _ReaFloorPlanViewState();
}

class _ReaFloorPlanViewState extends State<ReaFloorPlanView> {
  int selectedFloor = 0;
  bool showMeasurements = true;
  bool showRoomLabels = true;
  bool isZoomed = false;
  double zoomLevel = 1.0;

  final List<Map<String, dynamic>> floors = [
    {
      "id": 0,
      "name": "Ground Floor",
      "area": "1,200 sq ft",
      "image": "https://picsum.photos/800/600?random=1&keyword=floorplan",
      "rooms": [
        {"name": "Living Room", "area": "300 sq ft", "x": 0.2, "y": 0.3},
        {"name": "Kitchen", "area": "180 sq ft", "x": 0.6, "y": 0.2},
        {"name": "Dining", "area": "150 sq ft", "x": 0.4, "y": 0.5},
        {"name": "Powder Room", "area": "40 sq ft", "x": 0.7, "y": 0.6},
      ],
    },
    {
      "id": 1,
      "name": "First Floor",
      "area": "950 sq ft",
      "image": "https://picsum.photos/800/600?random=2&keyword=floorplan",
      "rooms": [
        {"name": "Master Bedroom", "area": "220 sq ft", "x": 0.3, "y": 0.3},
        {"name": "Bedroom 2", "area": "160 sq ft", "x": 0.6, "y": 0.3},
        {"name": "Bathroom", "area": "80 sq ft", "x": 0.2, "y": 0.6},
        {"name": "Balcony", "area": "60 sq ft", "x": 0.7, "y": 0.5},
      ],
    },
    {
      "id": 2,
      "name": "Basement",
      "area": "800 sq ft",
      "image": "https://picsum.photos/800/600?random=3&keyword=floorplan",
      "rooms": [
        {"name": "Recreation Room", "area": "400 sq ft", "x": 0.3, "y": 0.3},
        {"name": "Storage", "area": "150 sq ft", "x": 0.6, "y": 0.3},
        {"name": "Utility Room", "area": "100 sq ft", "x": 0.2, "y": 0.6},
        {"name": "Workshop", "area": "150 sq ft", "x": 0.7, "y": 0.6},
      ],
    },
  ];

  final List<Map<String, dynamic>> floorPlanFeatures = [
    {
      "icon": Icons.straighten,
      "title": "Measurements",
      "description": "Accurate room dimensions",
      "isActive": true,
    },
    {
      "icon": Icons.label,
      "title": "Room Labels",
      "description": "Clear room identification",
      "isActive": true,
    },
    {
      "icon": Icons.zoom_in,
      "title": "High Resolution",
      "description": "Detailed floor plans",
      "isActive": false,
    },
    {
      "icon": Icons.download,
      "title": "Download",
      "description": "Save for reference",
      "isActive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Floor Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadFloorPlan,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareFloorPlan,
          ),
        ],
      ),
      body: Column(
        children: [
          // Floor selector
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: floors.length,
              itemBuilder: (context, index) {
                final floor = floors[index];
                final isSelected = index == selectedFloor;

                return GestureDetector(
                  onTap: () => _selectFloor(index),
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 1,
                      ),
                      boxShadow: isSelected ? [shadowSm] : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${floor["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${floor["area"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Floor plan viewer
          Expanded(
            child: Container(
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    // Floor plan image
                    Positioned.fill(
                      child: InteractiveViewer(
                        panEnabled: true,
                        scaleEnabled: true,
                        minScale: 0.5,
                        maxScale: 4.0,
                        onInteractionUpdate: (details) {
                          setState(() {
                            zoomLevel = details.scale;
                            isZoomed = zoomLevel > 1.0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("${floors[selectedFloor]["image"]}"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Room labels overlay
                              if (showRoomLabels) ..._buildRoomLabels(),
                              
                              // Measurements overlay
                              if (showMeasurements) ..._buildMeasurements(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Controls overlay
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Column(
                        children: [
                          _buildControlButton(
                            icon: Icons.straighten,
                            label: "Measurements",
                            isActive: showMeasurements,
                            onTap: () {
                              setState(() {
                                showMeasurements = !showMeasurements;
                              });
                            },
                          ),
                          SizedBox(height: spSm),
                          _buildControlButton(
                            icon: Icons.label,
                            label: "Labels",
                            isActive: showRoomLabels,
                            onTap: () {
                              setState(() {
                                showRoomLabels = !showRoomLabels;
                              });
                            },
                          ),
                          SizedBox(height: spSm),
                          _buildControlButton(
                            icon: Icons.fullscreen,
                            label: "Fullscreen",
                            isActive: false,
                            onTap: _openFullscreen,
                          ),
                        ],
                      ),
                    ),

                    // Zoom indicator
                    if (isZoomed)
                      Positioned(
                        bottom: spMd,
                        left: spMd,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(zoomLevel * 100).toInt()}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Room details
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${floors[selectedFloor]["name"]} - Room Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Total: ${floors[selectedFloor]["area"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (floors[selectedFloor]["rooms"] as List).length,
                    itemBuilder: (context, index) {
                      final room = (floors[selectedFloor]["rooms"] as List)[index];
                      
                      return Container(
                        width: 120,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${room["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.square_foot,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${room["area"]}",
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRoomLabels() {
    final rooms = floors[selectedFloor]["rooms"] as List;
    return rooms.map<Widget>((room) {
      return Positioned(
        left: (room["x"] as double) * 300,
        top: (room["y"] as double) * 400,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spXs,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            "${room["name"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildMeasurements() {
    return [
      // Sample measurement lines
      Positioned(
        left: 50,
        top: 100,
        child: Container(
          width: 100,
          height: 1,
          color: dangerColor,
          child: Stack(
            children: [
              Positioned(
                left: -5,
                top: -5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: -15,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "12'",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : primaryColor,
              size: 20,
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : primaryColor,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _selectFloor(int index) {
    setState(() {
      selectedFloor = index;
      zoomLevel = 1.0;
      isZoomed = false;
    });
  }

  void _downloadFloorPlan() {
    ss("Floor plan downloaded successfully!");
  }

  void _shareFloorPlan() {
    ss("Floor plan shared successfully!");
  }

  void _openFullscreen() {
    ss("Opening fullscreen view...");
  }
}
