import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaReadyToMoveView extends StatefulWidget {
  const ReaReadyToMoveView({Key? key}) : super(key: key);

  @override
  State<ReaReadyToMoveView> createState() => _ReaReadyToMoveViewState();
}

class _ReaReadyToMoveViewState extends State<ReaReadyToMoveView> {
  String searchQuery = "";
  String selectedLocation = "All Locations";
  String selectedPriceRange = "All Prices";
  String selectedPropertyType = "All Types";
  String selectedBedrooms = "Any";
  String sortBy = "Newest First";
  bool showFilters = false;

  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Suburbs", "value": "Suburbs"},
    {"label": "Waterfront", "value": "Waterfront"},
    {"label": "Business District", "value": "Business District"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "Under \$500K", "value": "Under \$500K"},
    {"label": "\$500K - \$1M", "value": "\$500K - \$1M"},
    {"label": "\$1M - \$2M", "value": "\$1M - \$2M"},
    {"label": "\$2M - \$5M", "value": "\$2M - \$5M"},
    {"label": "Above \$5M", "value": "Above \$5M"},
  ];

  List<Map<String, dynamic>> propertyTypeItems = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Apartment", "value": "Apartment"},
    {"label": "Villa", "value": "Villa"},
    {"label": "Townhouse", "value": "Townhouse"},
    {"label": "Penthouse", "value": "Penthouse"},
    {"label": "Studio", "value": "Studio"},
  ];

  List<Map<String, dynamic>> bedroomItems = [
    {"label": "Any", "value": "Any"},
    {"label": "1 BHK", "value": "1"},
    {"label": "2 BHK", "value": "2"},
    {"label": "3 BHK", "value": "3"},
    {"label": "4+ BHK", "value": "4+"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Newest First", "value": "Newest First"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
    {"label": "Area: Large to Small", "value": "Area: Large to Small"},
    {"label": "Most Popular", "value": "Most Popular"},
  ];

  List<Map<String, dynamic>> readyToMoveProperties = [
    {
      "id": "1",
      "title": "Modern Downtown Apartment",
      "location": "Downtown, City Center",
      "price": 850000,
      "type": "Apartment",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1200,
      "images": [
        "https://picsum.photos/400/300?random=101&keyword=apartment",
        "https://picsum.photos/400/300?random=102&keyword=modern",
        "https://picsum.photos/400/300?random=103&keyword=interior",
      ],
      "features": ["Furnished", "Parking", "Balcony", "Gym"],
      "readyDate": "Available Now",
      "yearBuilt": 2023,
      "possession": "Immediate",
      "rating": 4.8,
      "isFeatured": true,
      "isPremium": false,
      "agent": {
        "name": "Sarah Wilson",
        "phone": "+1 234 567 8901",
        "image": "https://picsum.photos/100/100?random=201&keyword=woman",
      },
    },
    {
      "id": "2",
      "title": "Luxury Waterfront Villa",
      "location": "Waterfront, Marina District",
      "price": 2850000,
      "type": "Villa",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 3500,
      "images": [
        "https://picsum.photos/400/300?random=104&keyword=villa",
        "https://picsum.photos/400/300?random=105&keyword=waterfront",
        "https://picsum.photos/400/300?random=106&keyword=luxury",
      ],
      "features": ["Private Pool", "Garden", "Garage", "Sea View"],
      "readyDate": "Available Now",
      "yearBuilt": 2022,
      "possession": "Immediate",
      "rating": 4.9,
      "isFeatured": true,
      "isPremium": true,
      "agent": {
        "name": "Michael Chen",
        "phone": "+1 234 567 8902",
        "image": "https://picsum.photos/100/100?random=202&keyword=man",
      },
    },
    {
      "id": "3",
      "title": "Family Townhouse",
      "location": "Suburbs, Green Valley",
      "price": 650000,
      "type": "Townhouse",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1800,
      "images": [
        "https://picsum.photos/400/300?random=107&keyword=townhouse",
        "https://picsum.photos/400/300?random=108&keyword=family",
        "https://picsum.photos/400/300?random=109&keyword=garden",
      ],
      "features": ["Garden", "Parking", "Storage", "Pet Friendly"],
      "readyDate": "Available Now",
      "yearBuilt": 2021,
      "possession": "Immediate",
      "rating": 4.6,
      "isFeatured": false,
      "isPremium": false,
      "agent": {
        "name": "Emma Davis",
        "phone": "+1 234 567 8903",
        "image": "https://picsum.photos/100/100?random=203&keyword=woman",
      },
    },
    {
      "id": "4",
      "title": "Executive Penthouse",
      "location": "Business District, High Street",
      "price": 1950000,
      "type": "Penthouse",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2200,
      "images": [
        "https://picsum.photos/400/300?random=110&keyword=penthouse",
        "https://picsum.photos/400/300?random=111&keyword=executive",
        "https://picsum.photos/400/300?random=112&keyword=city-view",
      ],
      "features": ["City View", "Terrace", "Smart Home", "Concierge"],
      "readyDate": "Available Now",
      "yearBuilt": 2023,
      "possession": "Immediate",
      "rating": 4.7,
      "isFeatured": true,
      "isPremium": true,
      "agent": {
        "name": "David Rodriguez",
        "phone": "+1 234 567 8904",
        "image": "https://picsum.photos/100/100?random=204&keyword=man",
      },
    },
    {
      "id": "5",
      "title": "Cozy Studio Apartment",
      "location": "Midtown, Arts Quarter",
      "price": 425000,
      "type": "Studio",
      "bedrooms": 1,
      "bathrooms": 1,
      "area": 650,
      "images": [
        "https://picsum.photos/400/300?random=113&keyword=studio",
        "https://picsum.photos/400/300?random=114&keyword=cozy",
        "https://picsum.photos/400/300?random=115&keyword=compact",
      ],
      "features": ["Furnished", "High Ceilings", "Natural Light", "Metro Access"],
      "readyDate": "Available Now",
      "yearBuilt": 2022,
      "possession": "Immediate",
      "rating": 4.4,
      "isFeatured": false,
      "isPremium": false,
      "agent": {
        "name": "Lisa Thompson",
        "phone": "+1 234 567 8905",
        "image": "https://picsum.photos/100/100?random=205&keyword=woman",
      },
    },
    {
      "id": "6",
      "title": "Suburban Family Home",
      "location": "Suburbs, Oak Ridge",
      "price": 780000,
      "type": "Villa",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2400,
      "images": [
        "https://picsum.photos/400/300?random=116&keyword=suburban",
        "https://picsum.photos/400/300?random=117&keyword=family-home",
        "https://picsum.photos/400/300?random=118&keyword=backyard",
      ],
      "features": ["Large Backyard", "Garage", "Fireplace", "Study Room"],
      "readyDate": "Available Now",
      "yearBuilt": 2020,
      "possession": "Immediate",
      "rating": 4.5,
      "isFeatured": false,
      "isPremium": false,
      "agent": {
        "name": "James Wilson",
        "phone": "+1 234 567 8906",
        "image": "https://picsum.photos/100/100?random=206&keyword=man",
      },
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> filtered = List.from(readyToMoveProperties);

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((property) {
        return property["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               property["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedLocation != "All Locations") {
      filtered = filtered.where((property) {
        return property["location"].toString().contains(selectedLocation);
      }).toList();
    }

    if (selectedPropertyType != "All Types") {
      filtered = filtered.where((property) {
        return property["type"] == selectedPropertyType;
      }).toList();
    }

    if (selectedBedrooms != "Any") {
      if (selectedBedrooms == "4+") {
        filtered = filtered.where((property) {
          return (property["bedrooms"] as int) >= 4;
        }).toList();
      } else {
        filtered = filtered.where((property) {
          return property["bedrooms"].toString() == selectedBedrooms;
        }).toList();
      }
    }

    // Sort properties
    if (sortBy == "Price: Low to High") {
      filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
    } else if (sortBy == "Price: High to Low") {
      filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
    } else if (sortBy == "Area: Large to Small") {
      filtered.sort((a, b) => (b["area"] as int).compareTo(a["area"] as int));
    } else if (sortBy == "Most Popular") {
      filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ready to Move Properties"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Quick Filters
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search properties...",
                        value: searchQuery,
                        hint: "Enter location or property name",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Quick Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Location",
                        items: locationItems,
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
                        label: "Type",
                        items: propertyTypeItems,
                        value: selectedPropertyType,
                        onChanged: (value, label) {
                          selectedPropertyType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Advanced Filters (Collapsible)
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.grey[50],
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Price Range",
                          items: priceRangeItems,
                          value: selectedPriceRange,
                          onChanged: (value, label) {
                            selectedPriceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Bedrooms",
                          items: bedroomItems,
                          value: selectedBedrooms,
                          onChanged: (value, label) {
                            selectedBedrooms = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Sort By",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

          // Results Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "${filteredProperties.length} Properties Available",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Ready to Move",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Properties List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image with Badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${(property["images"] as List)[0]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Ready to Move",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (property["isFeatured"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Featured",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          if (property["isPremium"] as bool)
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Premium",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.photo_library,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(property["images"] as List).length}",
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
                      
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Property Title and Rating
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${property["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${property["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            
                            // Location
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${property["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Price and Property Details
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\$${((property["price"] as int).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "${property["type"]} • ${property["bedrooms"]} BHK",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${property["area"]} sq ft",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Built ${property["yearBuilt"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Features
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (property["features"] as List).take(4).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$feature",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                            
                            // Agent Info and Actions
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage("${property["agent"]["image"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${property["agent"]["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Available for immediate viewing",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {
                                    //call agent
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigate to property detail
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
            ),
          ),
        ],
      ),
    );
  }
}
