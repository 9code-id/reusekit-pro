import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite8View extends StatefulWidget {
  @override
  State<GrlFavorite8View> createState() => _GrlFavorite8ViewState();
}

class _GrlFavorite8ViewState extends State<GrlFavorite8View> {
  String searchQuery = "";
  String selectedLocation = "All";
  String sortBy = "Distance";
  bool showOnlyOpen = false;

  List<Map<String, dynamic>> favoritePlaces = [
    {
      "id": 1,
      "name": "Central Park Cafe",
      "category": "Restaurant",
      "location": "Downtown",
      "distance": 1.2,
      "rating": 4.8,
      "reviews": 345,
      "image": "https://picsum.photos/150/150?random=1&keyword=cafe",
      "isOpen": true,
      "openUntil": "10:00 PM",
      "priceRange": "\$\$",
      "description": "Cozy cafe with artisanal coffee and fresh pastries",
      "address": "123 Central Ave, Downtown",
      "phone": "+1 (555) 123-4567",
      "tags": ["Coffee", "Breakfast", "WiFi"],
      "features": ["Outdoor Seating", "WiFi", "Pet Friendly"]
    },
    {
      "id": 2,
      "name": "Grand City Museum",
      "category": "Museum",
      "location": "Arts District",
      "distance": 2.8,
      "rating": 4.6,
      "reviews": 892,
      "image": "https://picsum.photos/150/150?random=2&keyword=museum",
      "isOpen": true,
      "openUntil": "6:00 PM",
      "priceRange": "\$",
      "description": "Modern art and historical exhibits",
      "address": "456 Museum Blvd, Arts District",
      "phone": "+1 (555) 234-5678",
      "tags": ["Art", "History", "Education"],
      "features": ["Guided Tours", "Gift Shop", "Accessibility"]
    },
    {
      "id": 3,
      "name": "Sunset Beach Park",
      "category": "Park",
      "location": "Coastal Area",
      "distance": 5.5,
      "rating": 4.9,
      "reviews": 567,
      "image": "https://picsum.photos/150/150?random=3&keyword=beach",
      "isOpen": false,
      "openUntil": "Sunset",
      "priceRange": "Free",
      "description": "Beautiful beach with walking trails and picnic areas",
      "address": "789 Coastal Rd, Coastal Area",
      "phone": "+1 (555) 345-6789",
      "tags": ["Beach", "Nature", "Recreation"],
      "features": ["Swimming", "Picnic Areas", "Parking"]
    },
    {
      "id": 4,
      "name": "TechHub Bookstore",
      "category": "Bookstore",
      "location": "University District",
      "distance": 3.1,
      "rating": 4.7,
      "reviews": 234,
      "image": "https://picsum.photos/150/150?random=4&keyword=bookstore",
      "isOpen": true,
      "openUntil": "9:00 PM",
      "priceRange": "\$\$",
      "description": "Independent bookstore with tech and programming books",
      "address": "321 University Ave, University District",
      "phone": "+1 (555) 456-7890",
      "tags": ["Books", "Technology", "Study"],
      "features": ["Reading Corner", "Events", "Online Orders"]
    },
    {
      "id": 5,
      "name": "Fitness Plus Gym",
      "category": "Gym",
      "location": "Sports Complex",
      "distance": 0.8,
      "rating": 4.5,
      "reviews": 678,
      "image": "https://picsum.photos/150/150?random=5&keyword=gym",
      "isOpen": true,
      "openUntil": "11:00 PM",
      "priceRange": "\$\$\$",
      "description": "Modern gym with latest equipment and group classes",
      "address": "147 Sports Ave, Sports Complex",
      "phone": "+1 (555) 567-8901",
      "tags": ["Fitness", "Classes", "Equipment"],
      "features": ["Personal Training", "Group Classes", "Sauna"]
    }
  ];

  List<Map<String, dynamic>> get filteredPlaces {
    var filtered = favoritePlaces.where((place) {
      bool matchesSearch = place["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          place["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesLocation = selectedLocation == "All" || place["location"] == selectedLocation;
      bool matchesOpen = !showOnlyOpen || (place["isOpen"] as bool);
      
      return matchesSearch && matchesLocation && matchesOpen;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "Distance":
          return (a["distance"] as double).compareTo(b["distance"] as double);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Reviews":
          return (b["reviews"] as int).compareTo(a["reviews"] as int);
        default:
          return a["name"].toString().compareTo(b["name"].toString());
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  _buildStatCard("Total Places", "${favoritePlaces.length}", Icons.place),
                  _buildStatCard("Currently Open", "${favoritePlaces.where((p) => p["isOpen"] as bool).length}", Icons.schedule),
                  _buildStatCard("Avg Rating", "4.7", Icons.star),
                ],
              ),
            ),

            // Search and Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search places...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            // Filter Options
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: [
                      {"label": "All Locations", "value": "All"},
                      {"label": "Downtown", "value": "Downtown"},
                      {"label": "Arts District", "value": "Arts District"},
                      {"label": "Coastal Area", "value": "Coastal Area"},
                      {"label": "University District", "value": "University District"},
                      {"label": "Sports Complex", "value": "Sports Complex"},
                    ],
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Distance", "value": "Distance"},
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Reviews", "value": "Reviews"},
                      {"label": "Name", "value": "Name"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Open Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only open places",
                  "value": true,
                  "checked": showOnlyOpen,
                }
              ],
              value: showOnlyOpen ? [{"label": "Show only open places", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                showOnlyOpen = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Places List
            if (filteredPlaces.isEmpty)
              Container(
                height: 200,
                child: Column(
                  spacing: spSm,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      "No favorite places found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Explore Places",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            else
              ...filteredPlaces.map((place) => _buildPlaceCard(place)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard(Map<String, dynamic> place) {
    bool isOpen = place["isOpen"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: spSm,
            children: [
              // Place Image
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${place["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),

              // Place Info
              Expanded(
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${place["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isOpen ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isOpen ? "Open" : "Closed",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${place["category"]} • ${place["location"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${place["rating"]} (${place["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(place["distance"] as double).toStringAsFixed(1)} km",
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
            ],
          ),

          // Place Details
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${place["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${place["address"]}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      isOpen ? "Open until ${place["openUntil"]}" : "Closed",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    Spacer(),
                    Text(
                      "${place["priceRange"]}",
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

          // Tags
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (place["tags"] as List).map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),

          // Features
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Features:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: 2),
                Wrap(
                  spacing: spXs,
                  runSpacing: 2,
                  children: (place["features"] as List).map((feature) => Text(
                    "• $feature",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Get Directions",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                color: successColor,
                onPressed: () {},
              ),
              QButton(
                icon: Icons.favorite,
                size: bs.sm,
                color: dangerColor,
                onPressed: () async {
                  bool isConfirmed = await confirm("Remove '${place["name"]}' from favorites?");
                  if (isConfirmed) {
                    favoritePlaces.removeWhere((p) => p["id"] == place["id"]);
                    setState(() {});
                    ss("Place removed from favorites");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
