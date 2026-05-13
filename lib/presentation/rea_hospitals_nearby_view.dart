import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaHospitalsNearbyView extends StatefulWidget {
  const ReaHospitalsNearbyView({super.key});

  @override
  State<ReaHospitalsNearbyView> createState() => _ReaHospitalsNearbyViewState();
}

class _ReaHospitalsNearbyViewState extends State<ReaHospitalsNearbyView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedDistance = "5km";
  bool showMap = false;

  List<Map<String, dynamic>> hospitals = [
    {
      "id": 1,
      "name": "City General Hospital",
      "type": "General Hospital",
      "distance": "1.2km",
      "rating": 4.5,
      "reviews": 234,
      "specialties": ["Emergency", "Cardiology", "Orthopedics"],
      "phone": "(555) 123-4567",
      "address": "123 Medical Center Dr",
      "image": "https://picsum.photos/300/200?random=1&keyword=hospital",
      "emergencyServices": true,
      "operatingHours": "24/7",
      "beds": 250,
      "departments": 12
    },
    {
      "id": 2,
      "name": "Saint Mary's Medical Center",
      "type": "Private Hospital",
      "distance": "2.1km",
      "rating": 4.7,
      "reviews": 456,
      "specialties": ["Pediatrics", "Maternity", "Surgery"],
      "phone": "(555) 234-5678",
      "address": "456 Healthcare Ave",
      "image": "https://picsum.photos/300/200?random=2&keyword=medical",
      "emergencyServices": true,
      "operatingHours": "24/7",
      "beds": 180,
      "departments": 8
    },
    {
      "id": 3,
      "name": "Downtown Clinic",
      "type": "Clinic",
      "distance": "0.8km",
      "rating": 4.2,
      "reviews": 123,
      "specialties": ["Family Medicine", "Internal Medicine"],
      "phone": "(555) 345-6789",
      "address": "789 Health St",
      "image": "https://picsum.photos/300/200?random=3&keyword=clinic",
      "emergencyServices": false,
      "operatingHours": "8:00 AM - 6:00 PM",
      "beds": 20,
      "departments": 3
    },
    {
      "id": 4,
      "name": "Regional Trauma Center",
      "type": "Trauma Center",
      "distance": "3.5km",
      "rating": 4.8,
      "reviews": 567,
      "specialties": ["Trauma", "Neurosurgery", "Critical Care"],
      "phone": "(555) 456-7890",
      "address": "321 Emergency Blvd",
      "image": "https://picsum.photos/300/200?random=4&keyword=emergency",
      "emergencyServices": true,
      "operatingHours": "24/7",
      "beds": 300,
      "departments": 15
    },
    {
      "id": 5,
      "name": "Children's Hospital",
      "type": "Specialty Hospital",
      "distance": "4.2km",
      "rating": 4.6,
      "reviews": 345,
      "specialties": ["Pediatrics", "Neonatology", "Pediatric Surgery"],
      "phone": "(555) 567-8901",
      "address": "654 Kids Care Way",
      "image": "https://picsum.photos/300/200?random=5&keyword=children",
      "emergencyServices": true,
      "operatingHours": "24/7",
      "beds": 120,
      "departments": 6
    },
    {
      "id": 6,
      "name": "Heart & Vascular Institute",
      "type": "Specialty Center",
      "distance": "2.8km",
      "rating": 4.9,
      "reviews": 189,
      "specialties": ["Cardiology", "Cardiac Surgery", "Vascular Surgery"],
      "phone": "(555) 678-9012",
      "address": "987 Heart Lane",
      "image": "https://picsum.photos/300/200?random=6&keyword=heart",
      "emergencyServices": false,
      "operatingHours": "7:00 AM - 7:00 PM",
      "beds": 80,
      "departments": 4
    }
  ];

  List<Map<String, dynamic>> hospitalTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "General Hospital", "value": "General Hospital"},
    {"label": "Private Hospital", "value": "Private Hospital"},
    {"label": "Clinic", "value": "Clinic"},
    {"label": "Trauma Center", "value": "Trauma Center"},
    {"label": "Specialty Hospital", "value": "Specialty Hospital"},
    {"label": "Specialty Center", "value": "Specialty Center"},
  ];

  List<Map<String, dynamic>> distanceOptions = [
    {"label": "1 km", "value": "1km"},
    {"label": "5 km", "value": "5km"},
    {"label": "10 km", "value": "10km"},
    {"label": "20 km", "value": "20km"},
    {"label": "50 km", "value": "50km"},
  ];

  List<Map<String, dynamic>> get filteredHospitals {
    return hospitals.where((hospital) {
      bool matchesSearch = "${hospital["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${hospital["type"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || hospital["type"] == selectedType;
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
                  label: "Search hospitals...",
                  value: searchQuery,
                  hint: "Enter hospital name or type",
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Hospital Type",
                  items: hospitalTypes,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Distance",
                  items: distanceOptions,
                  value: selectedDistance,
                  onChanged: (value, label) {
                    selectedDistance = value;
                    setState(() {});
                  },
                ),
              ),
            ],
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
                  image: NetworkImage("https://picsum.photos/400/300?random=100&keyword=map"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Hospital markers
            ...List.generate(filteredHospitals.length, (index) {
              final hospital = filteredHospitals[index];
              return Positioned(
                left: (index * 60.0) + 50,
                top: (index % 2 == 0 ? 80.0 : 150.0),
                child: GestureDetector(
                  onTap: () {
                    // Show hospital info
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.local_hospital,
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
                    Icon(Icons.location_on, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${filteredHospitals.length} hospitals found",
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

  Widget _buildHospitalCard(Map<String, dynamic> hospital) {
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
          // Hospital Image
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
              image: DecorationImage(
                image: NetworkImage("${hospital["image"]}"),
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
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: hospital["emergencyServices"] ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        hospital["emergencyServices"] ? "24/7 Emergency" : "Regular Hours",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${hospital["distance"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Hospital Name and Type
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${hospital["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${hospital["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: successColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${hospital["rating"]}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Hospital Info
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(Icons.bed, "${hospital["beds"]} beds"),
                    ),
                    Expanded(
                      child: _buildInfoItem(Icons.business, "${hospital["departments"]} depts"),
                    ),
                    Expanded(
                      child: _buildInfoItem(Icons.reviews, "${hospital["reviews"]} reviews"),
                    ),
                  ],
                ),

                // Specialties
                Text(
                  "Specialties:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (hospital["specialties"] as List).map((specialty) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${specialty}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Contact Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: primaryColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "${hospital["phone"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${hospital["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "${hospital["operatingHours"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call",
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          // Make phone call
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Directions",
                        icon: Icons.directions,
                        size: bs.sm,
                        onPressed: () {
                          // Open directions
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

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: disabledBoldColor, size: 14),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospitals Nearby"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          if (showMap) _buildMapView(),
          Expanded(
            child: filteredHospitals.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No hospitals found",
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
                    itemCount: filteredHospitals.length,
                    itemBuilder: (context, index) {
                      return _buildHospitalCard(filteredHospitals[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
