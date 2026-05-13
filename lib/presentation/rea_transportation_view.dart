import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaTransportationView extends StatefulWidget {
  const ReaTransportationView({super.key});

  @override
  State<ReaTransportationView> createState() => _ReaTransportationViewState();
}

class _ReaTransportationViewState extends State<ReaTransportationView> {
  String selectedTransportType = "All";
  String searchQuery = "";
  bool showMap = false;

  List<Map<String, dynamic>> transportOptions = [
    {
      "id": 1,
      "name": "Metro Line A",
      "type": "Metro",
      "distance": "0.3km",
      "walkTime": "4 min walk",
      "frequency": "Every 5 minutes",
      "operatingHours": "5:00 AM - 12:00 AM",
      "fare": "\$2.50",
      "icon": Icons.train,
      "color": Colors.blue,
      "image": "https://picsum.photos/300/200?random=1&keyword=metro",
      "stops": ["Downtown", "City Center", "North Station", "Airport"],
      "accessibility": true,
      "cardPayment": true
    },
    {
      "id": 2,
      "name": "Bus Route 45",
      "type": "Bus",
      "distance": "0.1km",
      "walkTime": "2 min walk",
      "frequency": "Every 15 minutes",
      "operatingHours": "6:00 AM - 10:00 PM",
      "fare": "\$1.25",
      "icon": Icons.directions_bus,
      "color": Colors.green,
      "image": "https://picsum.photos/300/200?random=2&keyword=bus",
      "stops": ["Main St", "Shopping Mall", "University", "Hospital"],
      "accessibility": true,
      "cardPayment": true
    },
    {
      "id": 3,
      "name": "City Bike Share",
      "type": "Bike Share",
      "distance": "0.2km",
      "walkTime": "3 min walk",
      "frequency": "24/7 available",
      "operatingHours": "24/7",
      "fare": "\$0.50/hour",
      "icon": Icons.pedal_bike,
      "color": Colors.orange,
      "image": "https://picsum.photos/300/200?random=3&keyword=bike",
      "stops": ["Station A", "Station B", "Station C", "Station D"],
      "accessibility": false,
      "cardPayment": true
    },
    {
      "id": 4,
      "name": "Taxi Service",
      "type": "Taxi",
      "distance": "On demand",
      "walkTime": "5-10 min wait",
      "frequency": "On demand",
      "operatingHours": "24/7",
      "fare": "\$3.00 base + \$2.50/km",
      "icon": Icons.local_taxi,
      "color": Colors.yellow[700],
      "image": "https://picsum.photos/300/200?random=4&keyword=taxi",
      "stops": ["Door to door service"],
      "accessibility": true,
      "cardPayment": true
    },
    {
      "id": 5,
      "name": "Ride Share",
      "type": "Ride Share",
      "distance": "On demand",
      "walkTime": "3-8 min wait",
      "frequency": "On demand",
      "operatingHours": "24/7",
      "fare": "\$2.00 base + \$1.80/km",
      "icon": Icons.car_rental,
      "color": Colors.purple,
      "image": "https://picsum.photos/300/200?random=5&keyword=car",
      "stops": ["Door to door service"],
      "accessibility": true,
      "cardPayment": true
    },
    {
      "id": 6,
      "name": "Electric Scooter",
      "type": "E-Scooter",
      "distance": "0.1km",
      "walkTime": "1 min walk",
      "frequency": "Available when parked",
      "operatingHours": "6:00 AM - 11:00 PM",
      "fare": "\$1.00 unlock + \$0.25/min",
      "icon": Icons.electric_scooter,
      "color": Colors.teal,
      "image": "https://picsum.photos/300/200?random=6&keyword=scooter",
      "stops": ["Scattered locations"],
      "accessibility": false,
      "cardPayment": true
    }
  ];

  List<Map<String, dynamic>> transportTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "Metro", "value": "Metro"},
    {"label": "Bus", "value": "Bus"},
    {"label": "Bike Share", "value": "Bike Share"},
    {"label": "Taxi", "value": "Taxi"},
    {"label": "Ride Share", "value": "Ride Share"},
    {"label": "E-Scooter", "value": "E-Scooter"},
  ];

  List<Map<String, dynamic>> get filteredTransport {
    return transportOptions.where((transport) {
      bool matchesSearch = "${transport["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${transport["type"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedTransportType == "All" || transport["type"] == selectedTransportType;
      return matchesSearch && matchesType;
    }).toList();
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search transportation...",
                  value: searchQuery,
                  hint: "Enter route name or type",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                decoration: BoxDecoration(
                  color: showMap ? primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.map,
                    color: showMap ? Colors.white : disabledBoldColor,
                  ),
                  onPressed: () {
                    showMap = !showMap;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Transport Type",
            items: transportTypes,
            value: selectedTransportType,
            onChanged: (value, label) {
              selectedTransportType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      height: 300,
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusMd),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/300?random=100&keyword=citymap"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Transport markers
            ...List.generate(filteredTransport.length, (index) {
              final transport = filteredTransport[index];
              return Positioned(
                left: (index * 50.0) + 30,
                top: (index % 3 == 0 ? 60.0 : index % 3 == 1 ? 120.0 : 180.0),
                child: GestureDetector(
                  onTap: () {
                    // Show transport info
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: transport["color"],
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      transport["icon"],
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              );
            }),
            Positioned(
              top: spSm,
              right: spSm,
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.directions_transit, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${filteredTransport.length} options",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportCard(Map<String, dynamic> transport) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transport Image with overlay
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
              image: DecorationImage(
                image: NetworkImage("${transport["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(127),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: transport["color"],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        transport["icon"],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${transport["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${transport["type"]}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${transport["fare"]}",
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
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                // Distance and Time Info
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(Icons.location_on, "Distance", "${transport["distance"]}"),
                    ),
                    Expanded(
                      child: _buildInfoRow(Icons.directions_walk, "Walk", "${transport["walkTime"]}"),
                    ),
                  ],
                ),

                // Frequency and Hours
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(Icons.schedule, "Frequency", "${transport["frequency"]}"),
                    ),
                    Expanded(
                      child: _buildInfoRow(Icons.access_time, "Hours", "${transport["operatingHours"]}"),
                    ),
                  ],
                ),

                // Features
                Row(
                  children: [
                    if (transport["accessibility"]) ...[
                      _buildFeatureChip(Icons.accessible, "Accessible", successColor),
                      SizedBox(width: spXs),
                    ],
                    if (transport["cardPayment"]) ...[
                      _buildFeatureChip(Icons.credit_card, "Card Payment", infoColor),
                      SizedBox(width: spXs),
                    ],
                  ],
                ),

                // Stops/Routes
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transport["type"] == "Taxi" || transport["type"] == "Ride Share" 
                            ? "Service:" 
                            : "Stops:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      if (transport["stops"] is List) ...[
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (transport["stops"] as List).map((stop) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${stop}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ] else ...[
                        Text(
                          "${transport["stops"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    if (transport["type"] == "Metro" || transport["type"] == "Bus") ...[
                      Expanded(
                        child: QButton(
                          label: "Schedule",
                          icon: Icons.schedule,
                          size: bs.sm,
                          onPressed: () {
                            // View schedule
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    if (transport["type"] == "Taxi" || transport["type"] == "Ride Share") ...[
                      Expanded(
                        child: QButton(
                          label: "Book Ride",
                          icon: Icons.car_rental,
                          size: bs.sm,
                          onPressed: () {
                            // Book ride
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    Expanded(
                      child: QButton(
                        label: "Directions",
                        icon: Icons.directions,
                        size: bs.sm,
                        onPressed: () {
                          // Get directions
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Details",
                        icon: Icons.info,
                        size: bs.sm,
                        onPressed: () {
                          // View details
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
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: disabledBoldColor, size: 14),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
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
        title: Text("Transportation"),
        actions: [
          IconButton(
            icon: Icon(Icons.navigation),
            onPressed: () {
              // Open navigation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          if (showMap) _buildMapView(),
          Expanded(
            child: filteredTransport.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_transit,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No transportation found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search criteria",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: spMd),
                    itemCount: filteredTransport.length,
                    itemBuilder: (context, index) {
                      return _buildTransportCard(filteredTransport[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
