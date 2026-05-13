import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMapView extends StatefulWidget {
  const ReaMapView({super.key});

  @override
  State<ReaMapView> createState() => _ReaMapViewState();
}

class _ReaMapViewState extends State<ReaMapView> {
  String selectedMapType = "Satellite";
  String selectedFilter = "All";
  bool showPropertyDetails = true;
  bool showNearbyPlaces = true;
  String searchQuery = "";
  Map<String, dynamic>? selectedProperty;

  List<String> mapTypes = ["Satellite", "Street", "Terrain", "Hybrid"];
  List<String> filters = ["All", "For Sale", "For Rent", "Recently Sold", "New Listings"];

  List<Map<String, dynamic>> mapProperties = [
    {
      "id": "prop_001",
      "title": "Luxury Villa",
      "price": 2500000,
      "type": "Villa",
      "status": "For Sale",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 3500,
      "latitude": 37.7749,
      "longitude": -122.4194,
      "address": "123 Luxury Lane, San Francisco",
      "image": "https://picsum.photos/300/200?random=1&keyword=villa",
      "agent": "Sarah Johnson",
      "rating": 4.8,
    },
    {
      "id": "prop_002",
      "title": "Modern Apartment",
      "price": 850000,
      "type": "Apartment",
      "status": "For Sale",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1200,
      "latitude": 37.7849,
      "longitude": -122.4094,
      "address": "456 Modern St, San Francisco",
      "image": "https://picsum.photos/300/200?random=2&keyword=apartment",
      "agent": "Mike Wilson",
      "rating": 4.6,
    },
    {
      "id": "prop_003",
      "title": "Family House",
      "price": 4500,
      "type": "House",
      "status": "For Rent",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 2100,
      "latitude": 37.7649,
      "longitude": -122.4294,
      "address": "789 Family Ave, San Francisco",
      "image": "https://picsum.photos/300/200?random=3&keyword=house",
      "agent": "Emily Davis",
      "rating": 4.7,
    },
    {
      "id": "prop_004",
      "title": "Downtown Condo",
      "price": 1200000,
      "type": "Condo",
      "status": "Recently Sold",
      "bedrooms": 2,
      "bathrooms": 1,
      "area": 950,
      "latitude": 37.7949,
      "longitude": -122.3994,
      "address": "321 Downtown Blvd, San Francisco",
      "image": "https://picsum.photos/300/200?random=4&keyword=condo",
      "agent": "David Brown",
      "rating": 4.5,
    },
  ];

  List<Map<String, dynamic>> nearbyPlaces = [
    {
      "name": "Golden Gate Park",
      "type": "Park",
      "distance": "0.5 km",
      "icon": Icons.park,
      "latitude": 37.7694,
      "longitude": -122.4862,
    },
    {
      "name": "UCSF Medical Center",
      "type": "Hospital",
      "distance": "1.2 km",
      "icon": Icons.local_hospital,
      "latitude": 37.7625,
      "longitude": -122.4598,
    },
    {
      "name": "Irving Elementary",
      "type": "School",
      "distance": "0.8 km",
      "icon": Icons.school,
      "latitude": 37.7636,
      "longitude": -122.4686,
    },
    {
      "name": "Whole Foods Market",
      "type": "Shopping",
      "distance": "0.3 km",
      "icon": Icons.shopping_cart,
      "latitude": 37.7733,
      "longitude": -122.4167,
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> filtered = mapProperties;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((prop) => prop["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((prop) => 
        prop["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        prop["address"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  void _selectProperty(Map<String, dynamic> property) {
    selectedProperty = property;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () {
              _showMapTypeSelector();
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Container (Simulated)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade200,
                  Colors.green.shade200,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Map Background Pattern
                ...List.generate(20, (index) {
                  return Positioned(
                    left: (index % 5) * 100.0,
                    top: (index ~/ 5) * 150.0,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  );
                }),
                
                // Property Markers
                ...filteredProperties.map((property) {
                  double left = ((property["longitude"] as double) + 122.4194) * 1000;
                  double top = (37.7749 - (property["latitude"] as double)) * 2000 + 200;
                  
                  return Positioned(
                    left: left,
                    top: top,
                    child: GestureDetector(
                      onTap: () => _selectProperty(property),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedProperty?["id"] == property["id"] 
                              ? primaryColor 
                              : property["status"] == "For Sale" 
                                  ? successColor
                                  : property["status"] == "For Rent"
                                      ? warningColor
                                      : disabledBoldColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [shadowMd],
                        ),
                        child: Center(
                          child: Text(
                            "\$${property["status"] == "For Rent" ? "${(property["price"] as int)}k" : "${((property["price"] as int) / 1000).toInt()}k"}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                
                // Nearby Places Markers
                if (showNearbyPlaces)
                  ...nearbyPlaces.map((place) {
                    double left = ((place["longitude"] as double) + 122.4194) * 1000;
                    double top = (37.7749 - (place["latitude"] as double)) * 2000 + 200;
                    
                    return Positioned(
                      left: left,
                      top: top,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: infoColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          place["icon"] as IconData,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
          
          // Search Bar
          Positioned(
            top: spSm,
            left: spMd,
            right: spMd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search properties or locations...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(spSm),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      ss("Locating your position...");
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Filter Chips
          Positioned(
            top: 100,
            left: spMd,
            right: spMd,
            child: Container(
              height: 50,
              child: QHorizontalScroll(
                children: filters.map((filter) {
                  bool isSelected = selectedFilter == filter;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedFilter = filter;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // Property Details Card
          if (selectedProperty != null)
            Positioned(
              bottom: spMd,
              left: spMd,
              right: spMd,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowLg],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${selectedProperty!["image"]}"),
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
                                "${selectedProperty!["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${selectedProperty!["address"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    selectedProperty!["status"] == "For Rent" 
                                        ? "\$${selectedProperty!["price"]}/month"
                                        : "\$${((selectedProperty!["price"] as int) / 1000).toInt()}k",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${selectedProperty!["rating"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            selectedProperty = null;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        _buildPropertyDetail(Icons.bed, "${selectedProperty!["bedrooms"]} Beds"),
                        SizedBox(width: spSm),
                        _buildPropertyDetail(Icons.bathtub, "${selectedProperty!["bathrooms"]} Baths"),
                        SizedBox(width: spSm),
                        _buildPropertyDetail(Icons.square_foot, "${selectedProperty!["area"]} sqft"),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('PropertyDetailView');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          
          // Map Controls
          Positioned(
            right: spMd,
            top: 200,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          ss("Zoomed in");
                        },
                      ),
                      Container(
                        height: 1,
                        width: 20,
                        color: disabledOutlineBorderColor,
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          ss("Zoomed out");
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowMd],
                  ),
                  child: IconButton(
                    icon: Icon(showNearbyPlaces ? Icons.place : Icons.place_outlined),
                    onPressed: () {
                      showNearbyPlaces = !showNearbyPlaces;
                      setState(() {});
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

  Widget _buildPropertyDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _showMapTypeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Map Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...mapTypes.map((type) {
              bool isSelected = selectedMapType == type;
              return ListTile(
                leading: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                title: Text(type),
                onTap: () {
                  selectedMapType = type;
                  Navigator.pop(context);
                  setState(() {});
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Properties",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Text("Show Property Details"),
                Spacer(),
                Switch(
                  value: showPropertyDetails,
                  onChanged: (value) {
                    showPropertyDetails = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Show Nearby Places"),
                Spacer(),
                Switch(
                  value: showNearbyPlaces,
                  onChanged: (value) {
                    showNearbyPlaces = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
