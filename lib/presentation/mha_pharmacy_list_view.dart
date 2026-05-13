import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPharmacyListView extends StatefulWidget {
  const MhaPharmacyListView({super.key});

  @override
  State<MhaPharmacyListView> createState() => _MhaPharmacyListViewState();
}

class _MhaPharmacyListViewState extends State<MhaPharmacyListView> {
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedSort = "distance";
  bool isMapView = false;

  List<Map<String, dynamic>> pharmacies = [
    {
      "id": 1,
      "name": "MedPlus Pharmacy",
      "address": "123 Health Street, Medical District",
      "phone": "+1 (555) 123-4567",
      "email": "contact@medplus.com",
      "website": "www.medplus.com",
      "image": "https://picsum.photos/300/200?random=1&keyword=pharmacy",
      "rating": 4.8,
      "reviews": 156,
      "distance": 0.5,
      "isOpen": true,
      "openHours": "24/7",
      "deliveryAvailable": true,
      "deliveryTime": "30-45 mins",
      "deliveryFee": 2.99,
      "prescriptionRequired": true,
      "services": [
        "Prescription Filling",
        "Home Delivery",
        "Health Checkup",
        "Vaccination",
        "Medicine Consultation"
      ],
      "specialties": [
        "Diabetes Care",
        "Heart Health",
        "Women's Health"
      ],
      "coordinates": {
        "lat": 37.7749,
        "lng": -122.4194
      },
      "verified": true,
      "discount": 15
    },
    {
      "id": 2,
      "name": "Apollo Pharmacy",
      "address": "456 Wellness Avenue, Health City",
      "phone": "+1 (555) 234-5678",
      "email": "info@apollo.com",
      "website": "www.apollo.com",
      "image": "https://picsum.photos/300/200?random=2&keyword=pharmacy",
      "rating": 4.6,
      "reviews": 234,
      "distance": 1.2,
      "isOpen": true,
      "openHours": "8:00 AM - 10:00 PM",
      "deliveryAvailable": true,
      "deliveryTime": "45-60 mins",
      "deliveryFee": 3.99,
      "prescriptionRequired": true,
      "services": [
        "Prescription Filling",
        "Home Delivery",
        "Lab Tests",
        "Medicine Consultation"
      ],
      "specialties": [
        "Pediatric Care",
        "Senior Care",
        "Chronic Disease Management"
      ],
      "coordinates": {
        "lat": 37.7849,
        "lng": -122.4094
      },
      "verified": true,
      "discount": 10
    },
    {
      "id": 3,
      "name": "Wellness Pharmacy",
      "address": "789 Care Boulevard, Healing Heights",
      "phone": "+1 (555) 345-6789",
      "email": "support@wellness.com",
      "website": "www.wellness.com",
      "image": "https://picsum.photos/300/200?random=3&keyword=pharmacy",
      "rating": 4.7,
      "reviews": 189,
      "distance": 2.1,
      "isOpen": false,
      "openHours": "9:00 AM - 9:00 PM",
      "deliveryAvailable": true,
      "deliveryTime": "60-90 mins",
      "deliveryFee": 4.99,
      "prescriptionRequired": true,
      "services": [
        "Prescription Filling",
        "Home Delivery",
        "Health Screening",
        "Nutrition Counseling"
      ],
      "specialties": [
        "Mental Health",
        "Dermatology",
        "Orthopedic Care"
      ],
      "coordinates": {
        "lat": 37.7649,
        "lng": -122.4294
      },
      "verified": true,
      "discount": 20
    },
    {
      "id": 4,
      "name": "HealthFirst Pharmacy",
      "address": "321 Medicine Lane, Cure City",
      "phone": "+1 (555) 456-7890",
      "email": "care@healthfirst.com",
      "website": "www.healthfirst.com",
      "image": "https://picsum.photos/300/200?random=4&keyword=pharmacy",
      "rating": 4.5,
      "reviews": 312,
      "distance": 3.5,
      "isOpen": true,
      "openHours": "7:00 AM - 11:00 PM",
      "deliveryAvailable": false,
      "deliveryTime": null,
      "deliveryFee": null,
      "prescriptionRequired": true,
      "services": [
        "Prescription Filling",
        "Walk-in Clinic",
        "Immunizations",
        "Blood Pressure Check"
      ],
      "specialties": [
        "Travel Medicine",
        "Geriatric Care",
        "Pain Management"
      ],
      "coordinates": {
        "lat": 37.7549,
        "lng": -122.4394
      },
      "verified": false,
      "discount": 5
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Open Now", "value": "open"},
    {"label": "24/7", "value": "24_7"},
    {"label": "Delivery Available", "value": "delivery"},
    {"label": "Verified", "value": "verified"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Distance", "value": "distance"},
    {"label": "Rating", "value": "rating"},
    {"label": "Reviews", "value": "reviews"},
    {"label": "Delivery Time", "value": "delivery_time"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPharmacies = _getFilteredPharmacies();

    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Pharmacies"),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              isMapView = !isMapView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filters
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              children: [
                // Search bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search pharmacies...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        _showSortOptions();
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.sort, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              _getSortLabel(selectedSort),
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Quick stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredPharmacies.length}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Pharmacies",
                              style: TextStyle(
                                fontSize: 12,
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
                          color: successColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredPharmacies.where((p) => p["isOpen"]).length}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Open Now",
                              style: TextStyle(
                                fontSize: 12,
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
                          color: infoColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredPharmacies.where((p) => p["deliveryAvailable"]).length}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: isMapView ? _buildMapView() : _buildListView(filteredPharmacies),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> pharmacies) {
    if (pharmacies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_pharmacy,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No pharmacies found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: pharmacies.length,
      itemBuilder: (context, index) {
        final pharmacy = pharmacies[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Header image
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${pharmacy["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withAlpha(100)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Status indicators
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Row(
                          children: [
                            if (pharmacy["verified"])
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.verified, size: 12, color: Colors.white),
                                    SizedBox(width: 2),
                                    Text(
                                      "Verified",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (pharmacy["discount"] > 0) ...[
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${pharmacy["discount"]}% OFF",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      // Open/closed status
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: pharmacy["isOpen"] ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            pharmacy["isOpen"] ? "Open" : "Closed",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${pharmacy["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: warningColor),
                            SizedBox(width: 2),
                            Text(
                              "${pharmacy["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " (${pharmacy["reviews"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spXs),

                    // Address and distance
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${pharmacy["address"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${pharmacy["distance"]} km",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spXs),

                    // Hours
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${pharmacy["openHours"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    if (pharmacy["deliveryAvailable"]) ...[
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.delivery_dining, size: 14, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Delivery: ${pharmacy["deliveryTime"]} • \$${(pharmacy["deliveryFee"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Services
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (pharmacy["services"] as List).take(3).map((service) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXxs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$service",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spSm),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to pharmacy details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (pharmacy["isOpen"])
                          Expanded(
                            child: QButton(
                              label: "Order Now",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to order
                              },
                            ),
                          ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            _callPharmacy(pharmacy);
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.phone,
                              color: successColor,
                              size: 20,
                            ),
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
      },
    );
  }

  Widget _buildMapView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: [
          // Placeholder for map
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "Map View",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Interactive map with pharmacy locations",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),

          // Map controls
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pharmacies.length,
                itemBuilder: (context, index) {
                  final pharmacy = pharmacies[index];
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${pharmacy["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${pharmacy["address"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.star, size: 12, color: warningColor),
                              SizedBox(width: 2),
                              Text(
                                "${pharmacy["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${pharmacy["distance"]} km",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPharmacies() {
    List<Map<String, dynamic>> filtered = pharmacies.where((pharmacy) {
      // Search filter
      bool matchesSearch = searchQuery.isEmpty ||
          pharmacy["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          pharmacy["address"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      // Category filter
      bool matchesFilter = true;
      switch (selectedFilter) {
        case "open":
          matchesFilter = pharmacy["isOpen"];
          break;
        case "24_7":
          matchesFilter = pharmacy["openHours"] == "24/7";
          break;
        case "delivery":
          matchesFilter = pharmacy["deliveryAvailable"];
          break;
        case "verified":
          matchesFilter = pharmacy["verified"];
          break;
      }

      return matchesSearch && matchesFilter;
    }).toList();

    // Sort
    switch (selectedSort) {
      case "distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "reviews":
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
      case "delivery_time":
        filtered.sort((a, b) {
          if (!a["deliveryAvailable"]) return 1;
          if (!b["deliveryAvailable"]) return -1;
          return a["deliveryTime"].toString().compareTo(b["deliveryTime"].toString());
        });
        break;
    }

    return filtered;
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filter Pharmacies",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ...filterOptions.map((option) {
                bool isSelected = selectedFilter == option["value"];
                return ListTile(
                  title: Text("${option["label"]}"),
                  leading: Radio<String>(
                    value: option["value"],
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      selectedFilter = value!;
                      setState(() {});
                      back();
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort By",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ...sortOptions.map((option) {
                bool isSelected = selectedSort == option["value"];
                return ListTile(
                  title: Text("${option["label"]}"),
                  leading: Radio<String>(
                    value: option["value"],
                    groupValue: selectedSort,
                    onChanged: (value) {
                      selectedSort = value!;
                      setState(() {});
                      back();
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  String _getSortLabel(String sort) {
    switch (sort) {
      case "distance":
        return "Distance";
      case "rating":
        return "Rating";
      case "reviews":
        return "Reviews";
      case "delivery_time":
        return "Delivery";
      default:
        return "Sort";
    }
  }

  void _callPharmacy(Map<String, dynamic> pharmacy) {
    // Make phone call
    ss("Calling ${pharmacy["name"]}...");
  }
}
