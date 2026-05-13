import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaFloorPlanView extends StatefulWidget {
  const EmaFloorPlanView({super.key});

  @override
  State<EmaFloorPlanView> createState() => _EmaFloorPlanViewState();
}

class _EmaFloorPlanViewState extends State<EmaFloorPlanView> {
  String selectedVenue = "madison_square";
  String selectedFloor = "1";
  double zoomLevel = 1.0;
  String eventName = "Grand Concert 2025";
  
  List<Map<String, dynamic>> venues = [
    {"label": "Madison Square Garden", "value": "madison_square"},
    {"label": "Central Park Theater", "value": "central_park"},
    {"label": "Broadway Hall", "value": "broadway_hall"},
  ];

  List<Map<String, dynamic>> floors = [
    {"label": "Ground Floor", "value": "1"},
    {"label": "Mezzanine Level", "value": "2"},
    {"label": "Upper Level", "value": "3"},
  ];

  List<Map<String, dynamic>> getFloorSections() {
    return [
      {
        "id": "section_a",
        "name": "VIP Section A",
        "x": 50.0,
        "y": 100.0,
        "width": 120.0,
        "height": 80.0,
        "capacity": 120,
        "occupied": 89,
        "price": 250.0,
        "color": primaryColor,
      },
      {
        "id": "section_b",
        "name": "Premium Section B",
        "x": 200.0,
        "y": 100.0,
        "width": 140.0,
        "height": 100.0,
        "capacity": 210,
        "occupied": 156,
        "price": 180.0,
        "color": successColor,
      },
      {
        "id": "section_c",
        "name": "Regular Section C",
        "x": 50.0,
        "y": 220.0,
        "width": 160.0,
        "height": 120.0,
        "capacity": 320,
        "occupied": 245,
        "price": 120.0,
        "color": infoColor,
      },
      {
        "id": "section_d",
        "name": "Economy Section D",
        "x": 230.0,
        "y": 220.0,
        "width": 140.0,
        "height": 140.0,
        "capacity": 450,
        "occupied": 298,
        "price": 80.0,
        "color": warningColor,
      },
    ];
  }

  List<Map<String, dynamic>> getFacilities() {
    return [
      {
        "name": "Main Entrance",
        "icon": Icons.login,
        "x": 180.0,
        "y": 50.0,
        "type": "entrance"
      },
      {
        "name": "Emergency Exit",
        "icon": Icons.exit_to_app,
        "x": 50.0,
        "y": 50.0,
        "type": "exit"
      },
      {
        "name": "Restroom",
        "icon": Icons.wc,
        "x": 350.0,
        "y": 150.0,
        "type": "facility"
      },
      {
        "name": "Concession",
        "icon": Icons.fastfood,
        "x": 350.0,
        "y": 200.0,
        "type": "facility"
      },
      {
        "name": "First Aid",
        "icon": Icons.local_hospital,
        "x": 350.0,
        "y": 250.0,
        "type": "facility"
      },
      {
        "name": "Information",
        "icon": Icons.info,
        "x": 350.0,
        "y": 300.0,
        "type": "facility"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sections = getFloorSections();
    final facilities = getFacilities();

    return Scaffold(
      appBar: AppBar(
        title: Text("Floor Plan"),
        actions: [
          QButton(
            icon: Icons.zoom_in,
            size: bs.sm,
            onPressed: () {
              if (zoomLevel < 2.0) {
                zoomLevel += 0.2;
                setState(() {});
              }
            },
          ),
          QButton(
            icon: Icons.zoom_out,
            size: bs.sm,
            onPressed: () {
              if (zoomLevel > 0.6) {
                zoomLevel -= 0.2;
                setState(() {});
              }
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
            // Event Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventName,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Interactive floor plan with seating sections",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Controls
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Venue",
                    items: venues,
                    value: selectedVenue,
                    onChanged: (value, label) {
                      selectedVenue = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Floor",
                    items: floors,
                    value: selectedFloor,
                    onChanged: (value, label) {
                      selectedFloor = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Zoom Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Text(
                    "Zoom: ${(zoomLevel * 100).toInt()}%",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: Icons.fullscreen,
                    size: bs.sm,
                    onPressed: () {
                      zoomLevel = 1.0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Legend
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legend",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("VIP", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("Premium", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: infoColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("Regular", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          Text("Economy", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Floor Plan
            Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Transform.scale(
                    scale: zoomLevel,
                    child: Container(
                      width: 400,
                      height: 400,
                      child: Stack(
                        children: [
                          // Background
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey.shade100,
                          ),

                          // Stage
                          Positioned(
                            left: 120,
                            top: 20,
                            child: Container(
                              width: 160,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  "STAGE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Sections
                          ...sections.map((section) {
                            double occupancyRate = (section["occupied"] as int) / (section["capacity"] as int);
                            
                            return Positioned(
                              left: section["x"],
                              top: section["y"],
                              child: GestureDetector(
                                onTap: () {
                                  //navigateTo('EmaSeatingArrangementView')
                                },
                                child: Container(
                                  width: section["width"],
                                  height: section["height"],
                                  decoration: BoxDecoration(
                                    color: (section["color"] as Color).withAlpha(180),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: section["color"] as Color,
                                      width: 2,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Occupancy indicator
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(100),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(radiusSm),
                                              bottomRight: Radius.circular(radiusSm),
                                            ),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: occupancyRate,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: occupancyRate > 0.8 
                                                  ? dangerColor 
                                                  : occupancyRate > 0.5 
                                                    ? warningColor 
                                                    : successColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(radiusSm),
                                                  bottomRight: occupancyRate == 1.0 
                                                    ? Radius.circular(radiusSm) 
                                                    : Radius.zero,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Section info
                                      Positioned.fill(
                                        child: Padding(
                                          padding: EdgeInsets.all(spXs),
                                          child: Column(
                                            spacing: spXxs,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${section["name"]}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "\$${(section["price"] as double).currency}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "${section["capacity"] - section["occupied"]} left",
                                                style: TextStyle(
                                                  fontSize: 8,
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
                              ),
                            );
                          }),

                          // Facilities
                          ...facilities.map((facility) {
                            return Positioned(
                              left: facility["x"],
                              top: facility["y"],
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: facility["type"] == "entrance" 
                                    ? successColor 
                                    : facility["type"] == "exit" 
                                      ? dangerColor 
                                      : infoColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  facility["icon"],
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Facilities Legend
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Facilities",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: facilities.map((facility) {
                      Color iconColor = facility["type"] == "entrance" 
                        ? successColor 
                        : facility["type"] == "exit" 
                          ? dangerColor 
                          : infoColor;
                      
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Icon(
                            facility["icon"],
                            color: iconColor,
                            size: 16,
                          ),
                          Text(
                            "${facility["name"]}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Section Details
            Text(
              "Section Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: sections.map((section) {
                double occupancyRate = (section["occupied"] as int) / (section["capacity"] as int);
                int available = (section["capacity"] as int) - (section["occupied"] as int);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: section["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${section["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(section["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "$available of ${section["capacity"]} available",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: occupancyRate,
                          child: Container(
                            decoration: BoxDecoration(
                              color: occupancyRate > 0.8 
                                ? dangerColor 
                                : occupancyRate > 0.5 
                                  ? warningColor 
                                  : successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Select Seats",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('EmaSeatingArrangementView')
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
    );
  }
}
