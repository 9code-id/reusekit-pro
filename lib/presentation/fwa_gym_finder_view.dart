import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaGymFinderView extends StatefulWidget {
  const FwaGymFinderView({Key? key}) : super(key: key);

  @override
  State<FwaGymFinderView> createState() => _FwaGymFinderViewState();
}

class _FwaGymFinderViewState extends State<FwaGymFinderView> {
  String searchQuery = "";
  String selectedLocation = "Current Location";
  String selectedSort = "Distance";
  String selectedFilter = "All";
  bool showMap = false;
  
  List<Map<String, dynamic>> locationOptions = [
    {"label": "Current Location", "value": "Current Location"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Uptown", "value": "Uptown"},
    {"label": "East Side", "value": "East Side"},
    {"label": "West Side", "value": "West Side"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Distance", "value": "Distance"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Price", "value": "Price"},
    {"label": "Newest", "value": "Newest"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "24/7", "value": "24/7"},
    {"label": "Pool", "value": "Pool"},
    {"label": "Sauna", "value": "Sauna"},
    {"label": "Classes", "value": "Classes"},
    {"label": "Personal Trainer", "value": "Personal Trainer"},
  ];

  List<Map<String, dynamic>> gyms = [
    {
      "id": 1,
      "name": "FitZone Premium",
      "address": "123 Main Street, Downtown",
      "distance": 0.8,
      "rating": 4.8,
      "reviews": 1245,
      "priceRange": "\$\$\$",
      "isOpen": true,
      "hours": "5:00 AM - 11:00 PM",
      "image": "https://picsum.photos/300/200?random=1&keyword=gym",
      "amenities": ["Pool", "Sauna", "Classes", "Personal Trainer", "Parking"],
      "phone": "+1 (555) 123-4567",
      "website": "www.fitzonepremium.com",
      "membershipPrice": 89.99,
      "isPartner": true,
      "specialOffers": ["Free trial week", "Student discount 20%"],
      "equipmentTypes": ["Cardio", "Free Weights", "Machines", "Functional Training"]
    },
    {
      "id": 2,
      "name": "PowerHouse Gym",
      "address": "456 Oak Avenue, Uptown",
      "distance": 1.2,
      "rating": 4.6,
      "reviews": 892,
      "priceRange": "\$\$",
      "isOpen": true,
      "hours": "24/7",
      "image": "https://picsum.photos/300/200?random=2&keyword=fitness",
      "amenities": ["24/7", "Personal Trainer", "Parking", "Smoothie Bar"],
      "phone": "+1 (555) 234-5678",
      "website": "www.powerhousegym.com",
      "membershipPrice": 59.99,
      "isPartner": false,
      "specialOffers": ["First month \$29.99"],
      "equipmentTypes": ["Free Weights", "Machines", "Cardio"]
    },
    {
      "id": 3,
      "name": "Aqua Fitness Center",
      "address": "789 River Road, East Side",
      "distance": 2.1,
      "rating": 4.7,
      "reviews": 567,
      "priceRange": "\$\$\$\$",
      "isOpen": false,
      "hours": "6:00 AM - 10:00 PM",
      "image": "https://picsum.photos/300/200?random=3&keyword=pool",
      "amenities": ["Pool", "Sauna", "Classes", "Spa", "Parking"],
      "phone": "+1 (555) 345-6789",
      "website": "www.aquafitness.com",
      "membershipPrice": 129.99,
      "isPartner": true,
      "specialOffers": ["Spa package discount", "Family membership deals"],
      "equipmentTypes": ["Pool Equipment", "Cardio", "Classes", "Rehabilitation"]
    },
    {
      "id": 4,
      "name": "Budget Fitness",
      "address": "321 Pine Street, West Side",
      "distance": 1.8,
      "rating": 4.2,
      "reviews": 234,
      "priceRange": "\$",
      "isOpen": true,
      "hours": "5:00 AM - 12:00 AM",
      "image": "https://picsum.photos/300/200?random=4&keyword=workout",
      "amenities": ["Basic Equipment", "Parking"],
      "phone": "+1 (555) 456-7890",
      "website": "www.budgetfitness.com",
      "membershipPrice": 19.99,
      "isPartner": false,
      "specialOffers": ["No signup fee"],
      "equipmentTypes": ["Basic Cardio", "Free Weights"]
    },
    {
      "id": 5,
      "name": "Elite Training Studio",
      "address": "555 Elite Way, Downtown",
      "distance": 0.5,
      "rating": 4.9,
      "reviews": 789,
      "priceRange": "\$\$\$\$",
      "isOpen": true,
      "hours": "6:00 AM - 10:00 PM",
      "image": "https://picsum.photos/300/200?random=5&keyword=elite",
      "amenities": ["Personal Trainer", "Classes", "Nutrition Coaching", "Recovery Room"],
      "phone": "+1 (555) 567-8901",
      "website": "www.elitetraining.com",
      "membershipPrice": 199.99,
      "isPartner": true,
      "specialOffers": ["Personal training package", "Nutrition consultation"],
      "equipmentTypes": ["High-end Equipment", "Functional Training", "Recovery Tools"]
    },
    {
      "id": 6,
      "name": "Yoga & Wellness Center",
      "address": "888 Zen Street, Uptown",
      "distance": 1.5,
      "rating": 4.5,
      "reviews": 432,
      "priceRange": "\$\$",
      "isOpen": true,
      "hours": "7:00 AM - 9:00 PM",
      "image": "https://picsum.photos/300/200?random=6&keyword=yoga",
      "amenities": ["Classes", "Meditation Room", "Wellness Shop"],
      "phone": "+1 (555) 678-9012",
      "website": "www.yogawellness.com",
      "membershipPrice": 79.99,
      "isPartner": false,
      "specialOffers": ["Unlimited classes for 30 days"],
      "equipmentTypes": ["Yoga Props", "Meditation", "Wellness"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredGyms = _getFilteredGyms();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Gyms"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
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
          // Search and Location Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search gyms",
                  value: searchQuery,
                  hint: "Find gyms near you...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Location",
                        items: locationOptions,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: selectedSort,
                        onChanged: (value, label) {
                          selectedSort = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Count and Toggle
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredGyms.length} gyms found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showMap = false;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: !showMap ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "List",
                          style: TextStyle(
                            fontSize: 12,
                            color: !showMap ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        showMap = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: showMap ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Map",
                          style: TextStyle(
                            fontSize: 12,
                            color: showMap ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: showMap ? _buildMapView() : _buildListView(filteredGyms),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> gyms) {
    if (gyms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No gyms found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: gyms.length,
      itemBuilder: (context, index) {
        final gym = gyms[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    child: Image.network(
                      "${gym["image"]}",
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (gym["isPartner"] as bool)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Partner",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
                        color: (gym["isOpen"] as bool) ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        (gym["isOpen"] as bool) ? "Open" : "Closed",
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
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${gym["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${gym["priceRange"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
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
                            "${gym["address"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(gym["distance"] as double).toStringAsFixed(1)} km",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${gym["rating"]} (${gym["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.schedule,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${gym["hours"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    // Amenities
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (gym["amenities"] as List<String>).take(4).map((amenity) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            amenity,
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    // Special Offers
                    if ((gym["specialOffers"] as List<String>).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: warningColor.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: warningColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                (gym["specialOffers"] as List<String>).first,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to gym details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            // Make phone call
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.directions,
                          size: bs.sm,
                          onPressed: () {
                            // Open directions
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
      },
    );
  }

  Widget _buildMapView() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Map View",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Interactive map would be displayed here",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Map bottom sheet with gym cards
          Container(
            height: 120,
            child: QHorizontalScroll(
              children: _getFilteredGyms().map((gym) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.all(spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${gym["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${gym["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(gym["distance"] as double).toStringAsFixed(1)} km away",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${gym["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${gym["priceRange"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredGyms() {
    List<Map<String, dynamic>> filtered = gyms.where((gym) {
      bool matchesSearch = searchQuery.isEmpty ||
          (gym["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (gym["address"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesFilter = selectedFilter == "All" ||
          (gym["amenities"] as List<String>).contains(selectedFilter);

      return matchesSearch && matchesFilter;
    }).toList();

    // Sort results
    filtered.sort((a, b) {
      switch (selectedSort) {
        case "Distance":
          return (a["distance"] as double).compareTo(b["distance"] as double);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Price":
          return (a["membershipPrice"] as double).compareTo(b["membershipPrice"] as double);
        default:
          return 0;
      }
    });

    return filtered;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Gyms"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Amenities",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Sort by",
              items: sortOptions,
              value: selectedSort,
              onChanged: (value, label) {
                selectedSort = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedFilter = "All";
              selectedSort = "Distance";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }
}
