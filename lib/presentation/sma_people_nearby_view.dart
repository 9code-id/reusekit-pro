import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPeopleNearbyView extends StatefulWidget {
  const SmaPeopleNearbyView({super.key});

  @override
  State<SmaPeopleNearbyView> createState() => _SmaPeopleNearbyViewState();
}

class _SmaPeopleNearbyViewState extends State<SmaPeopleNearbyView> {
  String searchQuery = "";
  double maxDistance = 10.0;
  bool showOnlineOnly = false;
  String selectedAgeRange = "All";
  
  List<Map<String, dynamic>> nearbyPeople = [
    {
      "id": 1,
      "name": "Sophie Miller",
      "profile_image": "https://picsum.photos/100/100?random=1&keyword=woman",
      "distance": 0.5,
      "age": 28,
      "status": "online",
      "last_seen": "Just now",
      "occupation": "Graphic Designer",
      "interests": ["Art", "Coffee", "Photography"],
      "location_name": "Central Park Cafe",
      "is_verified": true,
      "common_interests": 3,
      "safety_score": 0.95,
    },
    {
      "id": 2,
      "name": "Ryan Cooper",
      "profile_image": "https://picsum.photos/100/100?random=2&keyword=man",
      "distance": 1.2,
      "age": 32,
      "status": "online",
      "last_seen": "5 minutes ago",
      "occupation": "Software Engineer",
      "interests": ["Tech", "Gaming", "Fitness"],
      "location_name": "Tech Hub Coworking",
      "is_verified": true,
      "common_interests": 2,
      "safety_score": 0.88,
    },
    {
      "id": 3,
      "name": "Emma Davis",
      "profile_image": "https://picsum.photos/100/100?random=3&keyword=woman",
      "distance": 2.8,
      "age": 26,
      "status": "away",
      "last_seen": "30 minutes ago",
      "occupation": "Marketing Manager",
      "interests": ["Travel", "Food", "Yoga"],
      "location_name": "Yoga Studio Downtown",
      "is_verified": false,
      "common_interests": 1,
      "safety_score": 0.75,
    },
    {
      "id": 4,
      "name": "Marcus Johnson",
      "profile_image": "https://picsum.photos/100/100?random=4&keyword=man",
      "distance": 3.5,
      "age": 35,
      "status": "offline",
      "last_seen": "2 hours ago",
      "occupation": "Business Analyst",
      "interests": ["Business", "Sports", "Reading"],
      "location_name": "City Library",
      "is_verified": true,
      "common_interests": 4,
      "safety_score": 0.92,
    },
    {
      "id": 5,
      "name": "Chloe Anderson",
      "profile_image": "https://picsum.photos/100/100?random=5&keyword=woman",
      "distance": 4.7,
      "age": 24,
      "status": "online",
      "last_seen": "Just now",
      "occupation": "Fashion Blogger",
      "interests": ["Fashion", "Music", "Dancing"],
      "location_name": "Fashion District",
      "is_verified": true,
      "common_interests": 2,
      "safety_score": 0.82,
    },
    {
      "id": 6,
      "name": "Jake Wilson",
      "profile_image": "https://picsum.photos/100/100?random=6&keyword=man",
      "distance": 6.1,
      "age": 29,
      "status": "away",
      "last_seen": "1 hour ago",
      "occupation": "Personal Trainer",
      "interests": ["Fitness", "Nutrition", "Hiking"],
      "location_name": "Mountain View Gym",
      "is_verified": false,
      "common_interests": 3,
      "safety_score": 0.78,
    },
  ];

  List<String> ageRanges = ["All", "18-25", "26-30", "31-35", "36+"];
  
  List<Map<String, dynamic>> get filteredPeople {
    var filtered = nearbyPeople;
    
    // Distance filter
    filtered = filtered.where((person) => 
      (person["distance"] as double) <= maxDistance
    ).toList();
    
    // Online filter
    if (showOnlineOnly) {
      filtered = filtered.where((person) => 
        (person["status"] as String) == "online"
      ).toList();
    }
    
    // Age filter
    if (selectedAgeRange != "All") {
      filtered = filtered.where((person) {
        int age = person["age"] as int;
        switch (selectedAgeRange) {
          case "18-25":
            return age >= 18 && age <= 25;
          case "26-30":
            return age >= 26 && age <= 30;
          case "31-35":
            return age >= 31 && age <= 35;
          case "36+":
            return age >= 36;
          default:
            return true;
        }
      }).toList();
    }
    
    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((person) =>
        (person["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (person["occupation"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (person["interests"] as List).any((interest) => 
          (interest as String).toLowerCase().contains(searchQuery.toLowerCase())
        )
      ).toList();
    }
    
    // Sort by distance
    filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "online":
        return successColor;
      case "away":
        return warningColor;
      case "offline":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People Nearby"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Refresh location
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Privacy settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search nearby people",
              value: searchQuery,
              hint: "Search by name, occupation, or interests",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Distance Filter
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Distance: ${maxDistance.toStringAsFixed(1)} km",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: maxDistance,
                    min: 0.5,
                    max: 50.0,
                    divisions: 20,
                    onChanged: (value) {
                      maxDistance = value;
                      setState(() {});
                    },
                  ),
                  
                  // Other Filters
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Age Range",
                          items: ageRanges.map((range) => {
                            "label": range,
                            "value": range,
                          }).toList(),
                          value: selectedAgeRange,
                          onChanged: (value, label) {
                            selectedAgeRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Online Only",
                              "value": true,
                              "checked": showOnlineOnly,
                            }
                          ],
                          value: [
                            if (showOnlineOnly) {
                              "label": "Online Only",
                              "value": true,
                              "checked": true
                            }
                          ],
                          onChanged: (values, ids) {
                            showOnlineOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Results Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${filteredPeople.length} people nearby",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.location_on,
                  color: successColor,
                  size: 16,
                ),
                Text(
                  "Location On",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
            
            // People List
            ...filteredPeople.map((person) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        // Profile Image with Status
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage("${person["profile_image"]}"),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(person["status"] as String),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                            if (person["is_verified"] as bool)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.verified,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        
                        // Person Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${person["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${person["age"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${person["occupation"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${person["location_name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Distance and Status
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${(person["distance"] as double).toStringAsFixed(1)}km",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${person["last_seen"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: _getStatusColor(person["status"] as String),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Stats Row
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 14,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${person["common_interests"]} common interests",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.security,
                          size: 14,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Safety ${((person["safety_score"] as double) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Interests
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (person["interests"] as List).map((interest) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$interest",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Say Hi",
                            icon: Icons.waving_hand,
                            size: bs.sm,
                            onPressed: () {
                              // Send greeting
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "View Profile",
                          icon: Icons.person,
                          color: secondaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // View profile
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            // More options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Refresh Button
            if (filteredPeople.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Refresh Location",
                  icon: Icons.refresh,
                  color: successColor,
                  size: bs.md,
                  onPressed: () {
                    // Refresh location and nearby people
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
