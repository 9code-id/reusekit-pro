import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaNearbyPropertiesView extends StatefulWidget {
  const ReaNearbyPropertiesView({super.key});

  @override
  State<ReaNearbyPropertiesView> createState() => _ReaNearbyPropertiesViewState();
}

class _ReaNearbyPropertiesViewState extends State<ReaNearbyPropertiesView> {
  String selectedRadius = "5 km";
  String selectedSortBy = "Distance";
  String selectedPropertyType = "All";
  String selectedPriceRange = "Any Price";
  bool isMapView = false;

  List<String> radiusOptions = ["1 km", "2 km", "5 km", "10 km", "20 km"];
  List<String> sortOptions = ["Distance", "Price: Low to High", "Price: High to Low", "Recently Added", "Most Popular"];
  List<String> propertyTypes = ["All", "House", "Apartment", "Villa", "Condo", "Townhouse"];
  List<String> priceRanges = ["Any Price", "Under \$500k", "\$500k - \$1M", "\$1M - \$2M", "Above \$2M"];

  List<Map<String, dynamic>> nearbyProperties = [
    {
      "id": "prop_001",
      "title": "Modern Family Home",
      "address": "123 Oak Street, Downtown",
      "price": 750000,
      "type": "House",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2500,
      "distance": 0.8,
      "walkingTime": "10 min",
      "drivingTime": "3 min",
      "image": "https://picsum.photos/300/200?random=1&keyword=house",
      "agent": "Sarah Johnson",
      "rating": 4.8,
      "status": "For Sale",
      "yearBuilt": 2018,
      "parking": 2,
      "amenities": ["Garden", "Garage", "Swimming Pool"],
      "nearbyPlaces": [
        {"name": "Central Park", "distance": "200m", "type": "Park"},
        {"name": "Roosevelt School", "distance": "500m", "type": "School"},
        {"name": "City Hospital", "distance": "1.2km", "type": "Hospital"},
      ]
    },
    {
      "id": "prop_002",
      "title": "Luxury Apartment",
      "address": "456 Pine Avenue, Midtown",
      "price": 1200000,
      "type": "Apartment",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1800,
      "distance": 1.2,
      "walkingTime": "15 min",
      "drivingTime": "5 min",
      "image": "https://picsum.photos/300/200?random=2&keyword=apartment",
      "agent": "Mike Wilson",
      "rating": 4.6,
      "status": "For Sale",
      "yearBuilt": 2020,
      "parking": 1,
      "amenities": ["Balcony", "Gym", "Concierge"],
      "nearbyPlaces": [
        {"name": "Shopping Mall", "distance": "300m", "type": "Shopping"},
        {"name": "Metro Station", "distance": "150m", "type": "Transport"},
        {"name": "Coffee Shop", "distance": "100m", "type": "Cafe"},
      ]
    },
    {
      "id": "prop_003",
      "title": "Cozy Villa",
      "address": "789 Maple Drive, Suburbs",
      "price": 950000,
      "type": "Villa",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 3200,
      "distance": 2.1,
      "walkingTime": "25 min",
      "drivingTime": "8 min",
      "image": "https://picsum.photos/300/200?random=3&keyword=villa",
      "agent": "Emily Davis",
      "rating": 4.9,
      "status": "For Sale",
      "yearBuilt": 2015,
      "parking": 3,
      "amenities": ["Garden", "Pool", "Patio", "Study Room"],
      "nearbyPlaces": [
        {"name": "Golf Course", "distance": "800m", "type": "Sports"},
        {"name": "Private School", "distance": "600m", "type": "School"},
        {"name": "Supermarket", "distance": "1km", "type": "Shopping"},
      ]
    },
    {
      "id": "prop_004",
      "title": "Downtown Condo",
      "address": "321 Cedar Lane, City Center",
      "price": 650000,
      "type": "Condo",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1400,
      "distance": 1.8,
      "walkingTime": "22 min",
      "drivingTime": "7 min",
      "image": "https://picsum.photos/300/200?random=4&keyword=condo",
      "agent": "David Brown",
      "rating": 4.4,
      "status": "For Sale",
      "yearBuilt": 2017,
      "parking": 1,
      "amenities": ["City View", "Rooftop", "Gym"],
      "nearbyPlaces": [
        {"name": "Business District", "distance": "400m", "type": "Business"},
        {"name": "Restaurant Row", "distance": "200m", "type": "Dining"},
        {"name": "Library", "distance": "300m", "type": "Education"},
      ]
    },
    {
      "id": "prop_005",
      "title": "Spacious Townhouse",
      "address": "555 Birch Street, Riverside",
      "price": 820000,
      "type": "Townhouse",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2200,
      "distance": 3.2,
      "walkingTime": "40 min",
      "drivingTime": "12 min",
      "image": "https://picsum.photos/300/200?random=5&keyword=townhouse",
      "agent": "Lisa Anderson",
      "rating": 4.7,
      "status": "For Sale",
      "yearBuilt": 2019,
      "parking": 2,
      "amenities": ["River View", "Deck", "Storage"],
      "nearbyPlaces": [
        {"name": "Riverside Park", "distance": "100m", "type": "Park"},
        {"name": "Marina", "distance": "500m", "type": "Recreation"},
        {"name": "Clinic", "distance": "700m", "type": "Healthcare"},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> filtered = nearbyProperties;
    
    // Filter by radius
    double radiusKm = double.parse(selectedRadius.split(' ')[0]);
    filtered = filtered.where((prop) => (prop["distance"] as double) <= radiusKm).toList();
    
    // Filter by property type
    if (selectedPropertyType != "All") {
      filtered = filtered.where((prop) => prop["type"] == selectedPropertyType).toList();
    }
    
    // Filter by price range
    if (selectedPriceRange != "Any Price") {
      filtered = filtered.where((prop) {
        int price = prop["price"] as int;
        switch (selectedPriceRange) {
          case "Under \$500k":
            return price < 500000;
          case "\$500k - \$1M":
            return price >= 500000 && price <= 1000000;
          case "\$1M - \$2M":
            return price > 1000000 && price <= 2000000;
          case "Above \$2M":
            return price > 2000000;
          default:
            return true;
        }
      }).toList();
    }
    
    // Sort properties
    switch (selectedSortBy) {
      case "Distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      case "Price: Low to High":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Price: High to Low":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "Recently Added":
        filtered.sort((a, b) => (b["yearBuilt"] as int).compareTo(a["yearBuilt"] as int));
        break;
      case "Most Popular":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Properties"),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              isMapView = !isMapView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Radius",
                        items: radiusOptions.map((radius) => {
                          "label": radius,
                          "value": radius,
                        }).toList(),
                        value: selectedRadius,
                        onChanged: (value, label) {
                          selectedRadius = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort By",
                        items: sortOptions.map((sort) => {
                          "label": sort,
                          "value": sort,
                        }).toList(),
                        value: selectedSortBy,
                        onChanged: (value, label) {
                          selectedSortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Found ${filteredProperties.length} properties nearby",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Within $selectedRadius",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Properties List
          Expanded(
            child: isMapView ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: filteredProperties.length,
      itemBuilder: (context, index) {
        final property = filteredProperties[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Property Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${property["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${property["distance"]} km away",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(127),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () {
                            ss("Added to favorites");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Property Details
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${property["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${property["address"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((property["price"] as int) / 1000).toInt()}k",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Property Features
                    Row(
                      children: [
                        _buildFeature(Icons.bed, "${property["bedrooms"]} Beds"),
                        SizedBox(width: spSm),
                        _buildFeature(Icons.bathtub, "${property["bathrooms"]} Baths"),
                        SizedBox(width: spSm),
                        _buildFeature(Icons.square_foot, "${property["area"]} sqft"),
                        Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${property["rating"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Travel Times
                    Row(
                      children: [
                        _buildTravelTime(Icons.directions_walk, "${property["walkingTime"]}"),
                        SizedBox(width: spMd),
                        _buildTravelTime(Icons.directions_car, "${property["drivingTime"]}"),
                        Spacer(),
                        Text(
                          "Built ${property["yearBuilt"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Nearby Places
                    Text(
                      "Nearby:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    QHorizontalScroll(
                      children: (property["nearbyPlaces"] as List).map<Widget>((place) {
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${place["name"]} (${place["distance"]})",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('PropertyDetailView');
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Contact Agent",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('ContactAgentView');
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
      },
    );
  }

  Widget _buildMapView() {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "Interactive Map View",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Showing ${filteredProperties.length} properties",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Properties within $selectedRadius",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: spSm,
                mainAxisSpacing: spSm,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${property["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${property["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${((property["price"] as int) / 1000).toInt()}k",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${property["distance"]} km away",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
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

  Widget _buildTravelTime(IconData icon, String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(width: spXs),
        Text(
          time,
          style: TextStyle(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Properties",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Property Type",
              items: propertyTypes.map((type) => {
                "label": type,
                "value": type,
              }).toList(),
              value: selectedPropertyType,
              onChanged: (value, label) {
                selectedPropertyType = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Price Range",
              items: priceRanges.map((range) => {
                "label": range,
                "value": range,
              }).toList(),
              value: selectedPriceRange,
              onChanged: (value, label) {
                selectedPriceRange = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset Filters",
                    size: bs.sm,
                    onPressed: () {
                      selectedPropertyType = "All";
                      selectedPriceRange = "Any Price";
                      selectedRadius = "5 km";
                      selectedSortBy = "Distance";
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
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
