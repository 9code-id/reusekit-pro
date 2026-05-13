import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPickupPointsView extends StatefulWidget {
  const SpaPickupPointsView({super.key});

  @override
  State<SpaPickupPointsView> createState() => _SpaPickupPointsViewState();
}

class _SpaPickupPointsViewState extends State<SpaPickupPointsView> {
  String selectedCity = "All Cities";
  String searchQuery = "";
  bool showMapView = false;
  String selectedPickupPoint = "";
  
  List<Map<String, dynamic>> pickupPoints = [
    {
      "id": "pickup1",
      "name": "Downtown Shopping Center",
      "address": "123 Main Street, Downtown",
      "city": "New York",
      "type": "Shopping Mall",
      "phone": "+1 (555) 123-4567",
      "distance": 0.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=shopping",
      "latitude": 40.7128,
      "longitude": -74.0060,
      "openingHours": {
        "monday": "9:00 AM - 9:00 PM",
        "tuesday": "9:00 AM - 9:00 PM",
        "wednesday": "9:00 AM - 9:00 PM",
        "thursday": "9:00 AM - 10:00 PM",
        "friday": "9:00 AM - 10:00 PM",
        "saturday": "10:00 AM - 10:00 PM",
        "sunday": "11:00 AM - 8:00 PM",
      },
      "isAvailable": true,
      "capacity": "Large",
      "amenities": ["Parking", "Food Court", "WiFi", "Restrooms"],
      "description": "Convenient pickup location inside the main shopping center",
      "instructions": "Enter through main entrance, pickup counter is near the information desk",
      "estimatedWaitTime": "5-10 minutes",
    },
    {
      "id": "pickup2",
      "name": "Metro Station Plaza",
      "address": "456 Transit Hub, Midtown",
      "city": "New York",
      "type": "Transit Hub",
      "phone": "+1 (555) 234-5678",
      "distance": 1.5,
      "image": "https://picsum.photos/300/200?random=2&keyword=metro",
      "latitude": 40.7589,
      "longitude": -73.9851,
      "openingHours": {
        "monday": "6:00 AM - 11:00 PM",
        "tuesday": "6:00 AM - 11:00 PM",
        "wednesday": "6:00 AM - 11:00 PM",
        "thursday": "6:00 AM - 11:00 PM",
        "friday": "6:00 AM - 12:00 AM",
        "saturday": "6:00 AM - 12:00 AM",
        "sunday": "7:00 AM - 11:00 PM",
      },
      "isAvailable": true,
      "capacity": "Medium",
      "amenities": ["Public Transport", "Security", "Covered Area"],
      "description": "Pickup point located at the main metro station entrance",
      "instructions": "Exit the metro and look for the pickup booth near gate A",
      "estimatedWaitTime": "3-7 minutes",
    },
    {
      "id": "pickup3",
      "name": "University Campus Center",
      "address": "789 College Avenue, Uptown",
      "city": "New York",
      "type": "Educational",
      "phone": "+1 (555) 345-6789",
      "distance": 2.3,
      "image": "https://picsum.photos/300/200?random=3&keyword=university",
      "latitude": 40.7831,
      "longitude": -73.9712,
      "openingHours": {
        "monday": "7:00 AM - 8:00 PM",
        "tuesday": "7:00 AM - 8:00 PM",
        "wednesday": "7:00 AM - 8:00 PM",
        "thursday": "7:00 AM - 8:00 PM",
        "friday": "7:00 AM - 6:00 PM",
        "saturday": "9:00 AM - 5:00 PM",
        "sunday": "Closed",
      },
      "isAvailable": false,
      "capacity": "Small",
      "amenities": ["Student Parking", "WiFi", "Cafeteria Nearby"],
      "description": "Campus pickup point for students and staff",
      "instructions": "Located in the student center lobby, first floor",
      "estimatedWaitTime": "2-5 minutes",
    },
    {
      "id": "pickup4",
      "name": "Brooklyn Heights Promenade",
      "address": "321 Riverside Drive, Brooklyn",
      "city": "Brooklyn",
      "type": "Public Area",
      "phone": "+1 (555) 456-7890",
      "distance": 4.2,
      "image": "https://picsum.photos/300/200?random=4&keyword=promenade",
      "latitude": 40.6782,
      "longitude": -73.9442,
      "openingHours": {
        "monday": "8:00 AM - 7:00 PM",
        "tuesday": "8:00 AM - 7:00 PM",
        "wednesday": "8:00 AM - 7:00 PM",
        "thursday": "8:00 AM - 7:00 PM",
        "friday": "8:00 AM - 8:00 PM",
        "saturday": "9:00 AM - 8:00 PM",
        "sunday": "9:00 AM - 6:00 PM",
      },
      "isAvailable": true,
      "capacity": "Medium",
      "amenities": ["Scenic View", "Benches", "Public Restrooms"],
      "description": "Pickup point with beautiful waterfront views",
      "instructions": "Meet at the central kiosk on the promenade",
      "estimatedWaitTime": "5-12 minutes",
    },
    {
      "id": "pickup5",
      "name": "Queens Mall Food Court",
      "address": "654 Queens Boulevard, Queens",
      "city": "Queens",
      "type": "Shopping Mall",
      "phone": "+1 (555) 567-8901",
      "distance": 6.1,
      "image": "https://picsum.photos/300/200?random=5&keyword=foodcourt",
      "latitude": 40.7282,
      "longitude": -73.7949,
      "openingHours": {
        "monday": "10:00 AM - 9:00 PM",
        "tuesday": "10:00 AM - 9:00 PM",
        "wednesday": "10:00 AM - 9:00 PM",
        "thursday": "10:00 AM - 10:00 PM",
        "friday": "10:00 AM - 10:00 PM",
        "saturday": "10:00 AM - 10:00 PM",
        "sunday": "11:00 AM - 8:00 PM",
      },
      "isAvailable": true,
      "capacity": "Large",
      "amenities": ["Dining", "Parking", "WiFi", "Family Area"],
      "description": "Pickup counter located in the busy food court area",
      "instructions": "Find our branded pickup counter near the central seating area",
      "estimatedWaitTime": "8-15 minutes",
    },
    {
      "id": "pickup6",
      "name": "Central Park Visitors Center",
      "address": "987 Park Drive, Manhattan",
      "city": "Manhattan",
      "type": "Tourist Area",
      "phone": "+1 (555) 678-9012",
      "distance": 3.7,
      "image": "https://picsum.photos/300/200?random=6&keyword=park",
      "latitude": 40.7505,
      "longitude": -73.9934,
      "openingHours": {
        "monday": "9:00 AM - 6:00 PM",
        "tuesday": "9:00 AM - 6:00 PM",
        "wednesday": "9:00 AM - 6:00 PM",
        "thursday": "9:00 AM - 6:00 PM",
        "friday": "9:00 AM - 7:00 PM",
        "saturday": "8:00 AM - 7:00 PM",
        "sunday": "8:00 AM - 6:00 PM",
      },
      "isAvailable": true,
      "capacity": "Medium",
      "amenities": ["Tourist Info", "Restrooms", "Gift Shop", "Parking"],
      "description": "Pickup point at the main park visitors center",
      "instructions": "Located inside the visitors center, ask at the information desk",
      "estimatedWaitTime": "3-8 minutes",
    },
  ];

  List<String> cities = ["All Cities", "New York", "Brooklyn", "Queens", "Manhattan"];
  List<String> pickupTypes = ["All Types", "Shopping Mall", "Transit Hub", "Educational", "Public Area", "Tourist Area"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPoints = _getFilteredPoints();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Points"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredPoints.length} Points",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
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
                        label: "Search pickup points...",
                        value: searchQuery,
                        hint: "Enter location name or address",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: showMapView ? Icons.list : Icons.map,
                      size: bs.sm,
                      onPressed: () {
                        showMapView = !showMapView;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                // Filter Dropdown
                QDropdownField(
                  label: "Filter by City",
                  items: cities.map((city) => {"label": city, "value": city}).toList(),
                  value: selectedCity,
                  onChanged: (value, label) {
                    selectedCity = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // View Toggle
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMapView = false;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: !showMapView ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            color: !showMapView ? Colors.white : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "List View",
                            style: TextStyle(
                              color: !showMapView ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMapView = true;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: showMapView ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: showMapView ? Colors.white : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Map View",
                            style: TextStyle(
                              color: showMapView ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: showMapView ? _buildMapView(filteredPoints) : _buildListView(filteredPoints),
          ),
        ],
      ),
      bottomNavigationBar: selectedPickupPoint.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: QButton(
                label: "Select This Pickup Point",
                size: bs.md,
                onPressed: () {
                  _selectPickupPoint();
                },
              ),
            )
          : null,
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> points) {
    if (points.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No pickup points found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filters",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: points.map((point) => _buildPickupPointCard(point)).toList(),
      ),
    );
  }

  Widget _buildPickupPointCard(Map<String, dynamic> point) {
    bool isSelected = selectedPickupPoint == point["id"];
    bool isAvailable = point["isAvailable"];
    
    return GestureDetector(
      onTap: isAvailable ? () {
        selectedPickupPoint = isSelected ? "" : point["id"];
        setState(() {});
      } : null,
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(50) : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowMd],
          border: Border.all(
            color: isSelected ? primaryColor : 
                   isAvailable ? disabledOutlineBorderColor : 
                   disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                  child: Image.network(
                    "${point["image"]}",
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: isAvailable ? null : Colors.grey.withAlpha(100),
                    colorBlendMode: isAvailable ? null : BlendMode.overlay,
                  ),
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isAvailable ? successColor : dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      isAvailable ? "AVAILABLE" : "TEMPORARILY CLOSED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(point["distance"] as double).toStringAsFixed(1)} km",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  // Header Info
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${point["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isAvailable ? (isSelected ? primaryColor : primaryColor) : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${point["address"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getTypeColor(point["type"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${point["type"]}",
                              style: TextStyle(
                                color: _getTypeColor(point["type"]),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: _getCapacityColor(point["capacity"]),
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${point["capacity"]}",
                                style: TextStyle(
                                  color: _getCapacityColor(point["capacity"]),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Description
                  Text(
                    "${point["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),

                  // Amenities
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: ((point["amenities"] as List).take(3)).map((amenity) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$amenity",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Wait Time & Contact
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Wait: ${point["estimatedWaitTime"]}",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.phone,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${point["phone"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Instructions
                  if (isSelected) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Pickup Instructions",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${point["instructions"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Action Buttons
                  if (isAvailable)
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Call Location",
                            size: bs.sm,
                            color: primaryColor,
                            onPressed: () {
                              _callLocation(point);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View Hours",
                            size: bs.sm,
                            color: infoColor,
                            onPressed: () {
                              _viewHours(point);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.directions,
                          size: bs.sm,
                          color: successColor,
                          onPressed: () {
                            _getDirections(point);
                          },
                        ),
                      ],
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "This pickup point is temporarily unavailable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildMapView(List<Map<String, dynamic>> points) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 64,
                          color: primaryColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Pickup Points Map",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Showing ${points.length} pickup locations",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Map Markers
                  ...points.take(4).toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> point = entry.value;
                    
                    return Positioned(
                      left: 60.0 + (index * 50),
                      top: 80.0 + (index * 30),
                      child: GestureDetector(
                        onTap: () {
                          selectedPickupPoint = point["id"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: selectedPickupPoint == point["id"] ? primaryColor : successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(
                            Icons.place,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          SizedBox(height: spMd),

          // Selected Point Info
          if (selectedPickupPoint.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Pickup Point",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${_getSelectedPoint()!["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${_getSelectedPoint()!["address"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Wait: ${_getSelectedPoint()!["estimatedWaitTime"]}",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(_getSelectedPoint()!["distance"] as double).toStringAsFixed(1)} km away",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPoints() {
    return pickupPoints.where((point) {
      bool matchesSearch = searchQuery.isEmpty ||
          (point["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (point["address"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCity = selectedCity == "All Cities" || point["city"] == selectedCity;

      return matchesSearch && matchesCity;
    }).toList();
  }

  Map<String, dynamic>? _getSelectedPoint() {
    if (selectedPickupPoint.isEmpty) return null;
    return pickupPoints.firstWhere((point) => point["id"] == selectedPickupPoint);
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Shopping Mall":
        return primaryColor;
      case "Transit Hub":
        return infoColor;
      case "Educational":
        return warningColor;
      case "Public Area":
        return successColor;
      case "Tourist Area":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCapacityColor(String capacity) {
    switch (capacity) {
      case "Large":
        return successColor;
      case "Medium":
        return warningColor;
      case "Small":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _callLocation(Map<String, dynamic> point) {
    ss("Calling ${point["name"]}...");
  }

  void _viewHours(Map<String, dynamic> point) {
    ss("Viewing hours for ${point["name"]}");
  }

  void _getDirections(Map<String, dynamic> point) {
    ss("Getting directions to ${point["name"]}...");
  }

  void _selectPickupPoint() async {
    Map<String, dynamic>? selectedPoint = _getSelectedPoint();
    if (selectedPoint != null) {
      bool isConfirmed = await confirm("Select ${selectedPoint["name"]} as your pickup point?");
      if (isConfirmed) {
        ss("Pickup point selected: ${selectedPoint["name"]}");
        back();
      }
    }
  }
}
