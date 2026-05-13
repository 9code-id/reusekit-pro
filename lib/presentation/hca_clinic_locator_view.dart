import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaClinicLocatorView extends StatefulWidget {
  const HcaClinicLocatorView({super.key});

  @override
  State<HcaClinicLocatorView> createState() => _HcaClinicLocatorViewState();
}

class _HcaClinicLocatorViewState extends State<HcaClinicLocatorView> {
  String searchQuery = "";
  String selectedSpecialty = "";
  String selectedLocation = "";
  double selectedRadius = 10.0;
  bool showMap = false;

  List<Map<String, dynamic>> specialties = [
    {"label": "All Specialties", "value": ""},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Dermatology", "value": "dermatology"},
    {"label": "Pediatrics", "value": "pediatrics"},
    {"label": "Orthopedics", "value": "orthopedics"},
    {"label": "Neurology", "value": "neurology"},
    {"label": "Oncology", "value": "oncology"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Current Location", "value": ""},
    {"label": "New York, NY", "value": "newyork"},
    {"label": "Los Angeles, CA", "value": "losangeles"},
    {"label": "Chicago, IL", "value": "chicago"},
    {"label": "Houston, TX", "value": "houston"},
    {"label": "Phoenix, AZ", "value": "phoenix"},
  ];

  List<Map<String, dynamic>> clinics = [
    {
      "id": "1",
      "name": "Metropolitan Medical Center",
      "specialty": "Multi-specialty",
      "address": "123 Medical Plaza, New York, NY 10001",
      "phone": "+1 (555) 123-4567",
      "rating": 4.8,
      "reviews": 342,
      "distance": 1.2,
      "isOpen": true,
      "openHours": "8:00 AM - 8:00 PM",
      "image": "https://picsum.photos/300/200?random=1&keyword=hospital",
      "services": ["Emergency Care", "Surgery", "Diagnostics"],
      "insurance": ["Blue Cross", "Aetna", "Cigna"],
      "coordinates": {"lat": 40.7128, "lng": -74.0060}
    },
    {
      "id": "2",
      "name": "Heart & Vascular Institute",
      "specialty": "Cardiology",
      "address": "456 Cardiac Ave, New York, NY 10002",
      "phone": "+1 (555) 234-5678",
      "rating": 4.9,
      "reviews": 278,
      "distance": 2.5,
      "isOpen": true,
      "openHours": "7:00 AM - 7:00 PM",
      "image": "https://picsum.photos/300/200?random=2&keyword=clinic",
      "services": ["Heart Surgery", "Cardiac Testing", "Consultation"],
      "insurance": ["Blue Cross", "Medicare", "Medicaid"],
      "coordinates": {"lat": 40.7589, "lng": -73.9851}
    },
    {
      "id": "3",
      "name": "Children's Health Center",
      "specialty": "Pediatrics",
      "address": "789 Kids Way, New York, NY 10003",
      "phone": "+1 (555) 345-6789",
      "rating": 4.7,
      "reviews": 456,
      "distance": 3.8,
      "isOpen": false,
      "openHours": "9:00 AM - 6:00 PM",
      "image": "https://picsum.photos/300/200?random=3&keyword=pediatric",
      "services": ["Pediatric Care", "Vaccinations", "Check-ups"],
      "insurance": ["Blue Cross", "Aetna", "UnitedHealth"],
      "coordinates": {"lat": 40.7614, "lng": -73.9776}
    },
    {
      "id": "4",
      "name": "Skin Care Specialists",
      "specialty": "Dermatology",
      "address": "321 Derma Street, New York, NY 10004",
      "phone": "+1 (555) 456-7890",
      "rating": 4.6,
      "reviews": 189,
      "distance": 4.2,
      "isOpen": true,
      "openHours": "8:30 AM - 5:30 PM",
      "image": "https://picsum.photos/300/200?random=4&keyword=dermatology",
      "services": ["Skin Treatment", "Cosmetic Surgery", "Laser Therapy"],
      "insurance": ["Aetna", "Cigna", "Humana"],
      "coordinates": {"lat": 40.7505, "lng": -73.9934}
    },
    {
      "id": "5",
      "name": "Orthopedic Sports Medicine",
      "specialty": "Orthopedics",
      "address": "654 Bone Ave, New York, NY 10005",
      "phone": "+1 (555) 567-8901",
      "rating": 4.5,
      "reviews": 234,
      "distance": 5.1,
      "isOpen": true,
      "openHours": "7:30 AM - 6:30 PM",
      "image": "https://picsum.photos/300/200?random=5&keyword=orthopedic",
      "services": ["Sports Medicine", "Joint Replacement", "Physical Therapy"],
      "insurance": ["Blue Cross", "Aetna", "Medicare"],
      "coordinates": {"lat": 40.7282, "lng": -74.0776}
    }
  ];

  List<Map<String, dynamic>> get filteredClinics {
    return clinics.where((clinic) {
      bool matchesSearch = searchQuery.isEmpty || 
          clinic["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          clinic["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesSpecialty = selectedSpecialty.isEmpty || 
          clinic["specialty"].toString().toLowerCase().contains(selectedSpecialty.toLowerCase());
      
      bool matchesDistance = (clinic["distance"] as double) <= selectedRadius;
      
      return matchesSearch && matchesSpecialty && matchesDistance;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Clinics"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
              ss(showMap ? "Map view enabled" : "List view enabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          if (showMap) _buildMapView() else _buildListView(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search clinics, specialties...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: disabledColor,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.my_location,
                size: bs.sm,
                onPressed: () {
                  ss("Getting current location");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Specialty",
                  items: specialties,
                  value: selectedSpecialty,
                  onChanged: (value, label) {
                    selectedSpecialty = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locations,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
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
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "https://picsum.photos/400/600?random=100&keyword=map",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Simulated map markers
            ...filteredClinics.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> clinic = entry.value;
              return Positioned(
                left: 50.0 + (index * 60.0) % 200,
                top: 100.0 + (index * 80.0) % 300,
                child: GestureDetector(
                  onTap: () {
                    _showClinicDetails(clinic);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.local_hospital,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              );
            }).toList(),
            Positioned(
              top: spMd,
              right: spMd,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.zoom_in,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(height: spSm),
                    Icon(
                      Icons.zoom_out,
                      color: primaryColor,
                      size: 20,
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

  Widget _buildListView() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(spMd),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Found ${filteredClinics.length} clinics near you",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          ...filteredClinics.map((clinic) => _buildClinicCard(clinic)).toList(),
        ],
      ),
    );
  }

  Widget _buildClinicCard(Map<String, dynamic> clinic) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
              image: DecorationImage(
                image: NetworkImage("${clinic["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: clinic["isOpen"] ? successColor : dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      clinic["isOpen"] ? "Open" : "Closed",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(clinic["distance"] as double).toStringAsFixed(1)} km away",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${clinic["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${clinic["specialty"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${clinic["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          " (${clinic["reviews"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${clinic["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${clinic["openHours"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (clinic["services"] as List).take(3).map((service) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${service}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _showClinicDetails(clinic);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {
                        ss("Getting directions to ${clinic["name"]}");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {
                        ss("Calling ${clinic["name"]}");
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
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                "Filter Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search Radius: ${selectedRadius.toInt()} km",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Slider(
                    value: selectedRadius,
                    min: 1.0,
                    max: 50.0,
                    divisions: 49,
                    label: "${selectedRadius.toInt()} km",
                    onChanged: (value) {
                      setDialogState(() {
                        selectedRadius = value;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Open Now Only",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Show only open clinics",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                    ss("Filters applied");
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showClinicDetails(Map<String, dynamic> clinic) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${clinic["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${clinic["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (clinic["services"] as List).map((service) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: infoColor.withAlpha(40)),
                            ),
                            child: Text(
                              "${service}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Insurance Accepted",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((clinic["insurance"] as List).map((insurance) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(40)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${insurance}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                      SizedBox(height: spMd),
                      Text(
                        "Contact Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${clinic["address"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${clinic["phone"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${clinic["openHours"]}",
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
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Book Appointment",
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Booking appointment at ${clinic["name"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Getting directions to ${clinic["name"]}");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
