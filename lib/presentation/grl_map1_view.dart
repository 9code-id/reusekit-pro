import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMap1View extends StatefulWidget {
  @override
  State<GrlMap1View> createState() => _GrlMap1ViewState();
}

class _GrlMap1ViewState extends State<GrlMap1View> {
  String searchQuery = "";
  String selectedFilter = "all";
  bool loading = false;
  
  final List<Map<String, dynamic>> locations = [
    {
      "id": 1,
      "name": "Central Mall",
      "category": "shopping",
      "address": "123 Main Street, Downtown",
      "distance": "0.5 km",
      "rating": 4.8,
      "reviews": 234,
      "isOpen": true,
      "latitude": 37.7749,
      "longitude": -122.4194,
      "image": "https://picsum.photos/100/100?random=1&keyword=mall",
    },
    {
      "id": 2,
      "name": "Blue Ocean Restaurant",
      "category": "restaurant",
      "address": "456 Ocean Drive, Seaside",
      "distance": "1.2 km",
      "rating": 4.6,
      "reviews": 156,
      "isOpen": true,
      "latitude": 37.7849,
      "longitude": -122.4094,
      "image": "https://picsum.photos/100/100?random=2&keyword=restaurant",
    },
    {
      "id": 3,
      "name": "Green Park",
      "category": "park",
      "address": "789 Park Avenue, Greenside",
      "distance": "2.1 km",
      "rating": 4.4,
      "reviews": 89,
      "isOpen": true,
      "latitude": 37.7649,
      "longitude": -122.4294,
      "image": "https://picsum.photos/100/100?random=3&keyword=park",
    },
    {
      "id": 4,
      "name": "Tech Hub Café",
      "category": "cafe",
      "address": "321 Silicon Street, Tech District",
      "distance": "0.8 km",
      "rating": 4.7,
      "reviews": 312,
      "isOpen": false,
      "latitude": 37.7949,
      "longitude": -122.3994,
      "image": "https://picsum.photos/100/100?random=4&keyword=cafe",
    },
    {
      "id": 5,
      "name": "City Hospital",
      "category": "hospital",
      "address": "555 Health Boulevard, Medical Center",
      "distance": "3.5 km",
      "rating": 4.2,
      "reviews": 445,
      "isOpen": true,
      "latitude": 37.7549,
      "longitude": -122.4394,
      "image": "https://picsum.photos/100/100?random=5&keyword=hospital",
    },
  ];

  List<Map<String, dynamic>> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
  }

  void _filterLocations() {
    filteredLocations = locations.where((location) {
      final matchesSearch = "${location["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${location["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = selectedFilter == "all" || location["category"] == selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              ss("Current location updated");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
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
                        label: "Search places...",
                        value: searchQuery,
                        hint: "Enter location name or category",
                        onChanged: (value) {
                          searchQuery = value;
                          _filterLocations();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {
                        _filterLocations();
                      },
                    ),
                  ],
                ),
                
                // Category Filter
                QHorizontalScroll(
                  children: [
                    _buildFilterChip("all", "All", Icons.apps),
                    _buildFilterChip("restaurant", "Restaurant", Icons.restaurant),
                    _buildFilterChip("shopping", "Shopping", Icons.shopping_bag),
                    _buildFilterChip("cafe", "Café", Icons.local_cafe),
                    _buildFilterChip("park", "Park", Icons.park),
                    _buildFilterChip("hospital", "Hospital", Icons.local_hospital),
                  ],
                ),
              ],
            ),
          ),
          
          // Map View Section
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue[100]!,
                          Colors.green[100]!,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Interactive Map View",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                  
                  // Location Markers
                  ...filteredLocations.map((location) {
                    return Positioned(
                      left: ((location["longitude"] as double) + 122.4194) * 1000,
                      top: (37.7749 - (location["latitude"] as double)) * 2000 + 200,
                      child: GestureDetector(
                        onTap: () {
                          _showLocationDetails(location);
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
                            _getCategoryIcon("${location["category"]}"),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  // Map Controls
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Column(
                      spacing: spSm,
                      children: [
                        _buildMapButton(Icons.add, () {
                          ss("Zoom in");
                        }),
                        _buildMapButton(Icons.remove, () {
                          ss("Zoom out");
                        }),
                        _buildMapButton(Icons.layers, () {
                          ss("Change map type");
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Location List Section
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Found ${filteredLocations.length} places",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredLocations.length,
                      itemBuilder: (context, index) {
                        final location = filteredLocations[index];
                        return _buildLocationCard(location);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label, IconData icon) {
    final isSelected = selectedFilter == value;
    return GestureDetector(
      onTap: () {
        selectedFilter = value;
        _filterLocations();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> location) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Location Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${location["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          
          // Location Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${location["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (location["isOpen"] as bool) ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        (location["isOpen"] as bool) ? "Open" : "Closed",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${location["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${location["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " (${location["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${location["distance"]}",
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
          
          // Action Button
          GestureDetector(
            onTap: () {
              _showLocationDetails(location);
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.directions,
                color: primaryColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "restaurant":
        return Icons.restaurant;
      case "shopping":
        return Icons.shopping_bag;
      case "cafe":
        return Icons.local_cafe;
      case "park":
        return Icons.park;
      case "hospital":
        return Icons.local_hospital;
      default:
        return Icons.place;
    }
  }

  void _showLocationDetails(Map<String, dynamic> location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledOutlineBorderColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            SizedBox(height: spMd),
            
            // Location Header
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("${location["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${location["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.star, color: warningColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${location["rating"]} (${location["reviews"]} reviews)",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: primaryColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${location["distance"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Address
            Text(
              "Address",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${location["address"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Directions",
                    icon: Icons.directions,
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Opening directions...");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Call",
                    icon: Icons.phone,
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Calling location...");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
