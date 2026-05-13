import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite5View extends StatefulWidget {
  @override
  State<GrlFavorite5View> createState() => _GrlFavorite5ViewState();
}

class _GrlFavorite5ViewState extends State<GrlFavorite5View> {
  String searchQuery = "";
  String selectedType = "All";
  String sortBy = "Rating";
  bool showOnlyAvailable = false;

  List<Map<String, dynamic>> favoriteServices = [
    {
      "id": 1,
      "name": "Premium Car Wash",
      "type": "Automotive",
      "rating": 4.8,
      "reviews": 245,
      "price": 25.0,
      "image": "https://picsum.photos/150/150?random=1&keyword=car",
      "provider": "AutoCare Pro",
      "location": "Downtown",
      "distance": 2.5,
      "available": true,
      "nextSlot": "2:00 PM",
      "description": "Complete car wash with interior cleaning",
      "duration": "45 min",
      "features": ["Interior Cleaning", "Wax Polish", "Tire Shine"]
    },
    {
      "id": 2,
      "name": "Hair Styling & Cut",
      "type": "Beauty",
      "rating": 4.9,
      "reviews": 156,
      "price": 45.0,
      "image": "https://picsum.photos/150/150?random=2&keyword=salon",
      "provider": "Style Studio",
      "location": "Mall Area",
      "distance": 1.2,
      "available": true,
      "nextSlot": "3:30 PM",
      "description": "Professional hair styling and cutting service",
      "duration": "60 min",
      "features": ["Consultation", "Wash & Cut", "Styling"]
    },
    {
      "id": 3,
      "name": "Home Cleaning",
      "type": "Home",
      "rating": 4.7,
      "reviews": 89,
      "price": 80.0,
      "image": "https://picsum.photos/150/150?random=3&keyword=cleaning",
      "provider": "CleanHome Services",
      "location": "Citywide",
      "distance": 0.8,
      "available": false,
      "nextSlot": "Tomorrow 9:00 AM",
      "description": "Complete home cleaning service",
      "duration": "2 hours",
      "features": ["Deep Clean", "Sanitization", "Eco-friendly"]
    },
    {
      "id": 4,
      "name": "Pet Grooming",
      "type": "Pet Care",
      "rating": 4.6,
      "reviews": 67,
      "price": 35.0,
      "image": "https://picsum.photos/150/150?random=4&keyword=pet",
      "provider": "Happy Paws",
      "location": "Pet District",
      "distance": 3.1,
      "available": true,
      "nextSlot": "4:00 PM",
      "description": "Professional pet grooming and care",
      "duration": "90 min",
      "features": ["Bath & Dry", "Nail Trim", "Ear Cleaning"]
    },
    {
      "id": 5,
      "name": "Massage Therapy",
      "type": "Health",
      "rating": 4.8,
      "reviews": 134,
      "price": 60.0,
      "image": "https://picsum.photos/150/150?random=5&keyword=massage",
      "provider": "Wellness Center",
      "location": "Health District",
      "distance": 2.0,
      "available": true,
      "nextSlot": "5:15 PM",
      "description": "Relaxing therapeutic massage session",
      "duration": "60 min",
      "features": ["Swedish Massage", "Hot Stones", "Aromatherapy"]
    }
  ];

  List<Map<String, dynamic>> get filteredServices {
    var filtered = favoriteServices.where((service) {
      bool matchesSearch = service["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          service["provider"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || service["type"] == selectedType;
      bool matchesAvailability = !showOnlyAvailable || (service["available"] as bool);
      
      return matchesSearch && matchesType && matchesAvailability;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Price":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "Distance":
          return (a["distance"] as double).compareTo(b["distance"] as double);
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
        title: Text("Favorite Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
                  _buildStatCard("Total Services", "${favoriteServices.length}", Icons.favorite),
                  _buildStatCard("Available Now", "${favoriteServices.where((s) => s["available"] as bool).length}", Icons.access_time),
                  _buildStatCard("Avg Rating", "4.8", Icons.star),
                ],
              ),
            ),

            // Search and Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search services...",
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
                    label: "Service Type",
                    items: [
                      {"label": "All Types", "value": "All"},
                      {"label": "Automotive", "value": "Automotive"},
                      {"label": "Beauty", "value": "Beauty"},
                      {"label": "Home", "value": "Home"},
                      {"label": "Pet Care", "value": "Pet Care"},
                      {"label": "Health", "value": "Health"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Price", "value": "Price"},
                      {"label": "Distance", "value": "Distance"},
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

            // Available Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only available services",
                  "value": true,
                  "checked": showOnlyAvailable,
                }
              ],
              value: showOnlyAvailable ? [{"label": "Show only available services", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                showOnlyAvailable = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Services List
            if (filteredServices.isEmpty)
              Container(
                height: 200,
                child: Column(
                  spacing: spSm,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      "No favorite services found",
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
                      label: "Browse Services",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            else
              ...filteredServices.map((service) => _buildServiceCard(service)),
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

  Widget _buildServiceCard(Map<String, dynamic> service) {
    bool isAvailable = service["available"] as bool;
    
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
              // Service Image
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${service["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),

              // Service Info
              Expanded(
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isAvailable ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isAvailable ? "Available" : "Busy",
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
                      "${service["provider"]} • ${service["location"]}",
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
                          "${service["rating"]} (${service["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(service["price"] as double).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Service Details
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
                  "${service["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${service["duration"]}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${(service["distance"] as double).toStringAsFixed(1)} km",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    Spacer(),
                    Text(
                      "Next: ${service["nextSlot"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Features
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (service["features"] as List).map((feature) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                feature,
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: isAvailable ? "Book Now" : "Schedule",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.favorite,
                size: bs.sm,
                color: dangerColor,
                onPressed: () async {
                  bool isConfirmed = await confirm("Remove '${service["name"]}' from favorites?");
                  if (isConfirmed) {
                    favoriteServices.removeWhere((s) => s["id"] == service["id"]);
                    setState(() {});
                    ss("Service removed from favorites");
                  }
                },
              ),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                color: infoColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
