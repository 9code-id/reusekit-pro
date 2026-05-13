import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore4View extends StatefulWidget {
  @override
  State<GrlExplore4View> createState() => _GrlExplore4ViewState();
}

class _GrlExplore4ViewState extends State<GrlExplore4View> {
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedLocation = "All Locations";
  String selectedPriceRange = "All Prices";
  bool showFavorites = false;

  List<Map<String, dynamic>> experiences = [
    {
      "id": 1,
      "title": "Wine Tasting Tour",
      "category": "Food & Drink",
      "location": "Napa Valley",
      "price": 89.99,
      "rating": 4.8,
      "reviews": 245,
      "duration": "4 hours",
      "image": "https://picsum.photos/300/200?random=1&keyword=wine",
      "hostName": "Sarah Wilson",
      "hostImage": "https://picsum.photos/50/50?random=101",
      "description": "Explore premium wineries with expert sommelier guide",
      "maxGuests": 8,
      "isFavorite": true,
      "availability": "Available Today",
      "tags": ["Premium", "Small Group"],
      "featured": true
    },
    {
      "id": 2,
      "title": "Urban Photography Walk",
      "category": "Arts & Culture",
      "location": "Downtown",
      "price": 45.00,
      "rating": 4.6,
      "reviews": 128,
      "duration": "3 hours",
      "image": "https://picsum.photos/300/200?random=2&keyword=photography",
      "hostName": "Mike Chen",
      "hostImage": "https://picsum.photos/50/50?random=102",
      "description": "Capture stunning city shots with professional photographer",
      "maxGuests": 6,
      "isFavorite": false,
      "availability": "Available Tomorrow",
      "tags": ["Beginner Friendly", "Equipment Provided"],
      "featured": false
    },
    {
      "id": 3,
      "title": "Cooking Masterclass",
      "category": "Food & Drink",
      "location": "Little Italy",
      "price": 125.00,
      "rating": 4.9,
      "reviews": 312,
      "duration": "5 hours",
      "image": "https://picsum.photos/300/200?random=3&keyword=cooking",
      "hostName": "Chef Antonio",
      "hostImage": "https://picsum.photos/50/50?random=103",
      "description": "Learn authentic Italian cooking from Michelin-trained chef",
      "maxGuests": 10,
      "isFavorite": true,
      "availability": "Booking Required",
      "tags": ["Professional Chef", "Certificate Included"],
      "featured": true
    },
    {
      "id": 4,
      "title": "Street Art Discovery",
      "category": "Arts & Culture",
      "location": "Arts District",
      "price": 35.00,
      "rating": 4.5,
      "reviews": 89,
      "duration": "2.5 hours",
      "image": "https://picsum.photos/300/200?random=4&keyword=streetart",
      "hostName": "Luna Rodriguez",
      "hostImage": "https://picsum.photos/50/50?random=104",
      "description": "Explore hidden murals and meet local street artists",
      "maxGuests": 12,
      "isFavorite": false,
      "availability": "Available Today",
      "tags": ["Local Artists", "Hidden Gems"],
      "featured": false
    },
    {
      "id": 5,
      "title": "Sunset Yoga Session",
      "category": "Wellness",
      "location": "Beachfront",
      "price": 25.00,
      "rating": 4.7,
      "reviews": 156,
      "duration": "1.5 hours",
      "image": "https://picsum.photos/300/200?random=5&keyword=yoga",
      "hostName": "Zen Master David",
      "hostImage": "https://picsum.photos/50/50?random=105",
      "description": "Peaceful yoga practice with ocean views",
      "maxGuests": 15,
      "isFavorite": true,
      "availability": "Available Today",
      "tags": ["All Levels", "Mats Provided"],
      "featured": false
    },
    {
      "id": 6,
      "title": "Historic Pub Crawl",
      "category": "Nightlife",
      "location": "Old Town",
      "price": 55.00,
      "rating": 4.4,
      "reviews": 203,
      "duration": "4 hours",
      "image": "https://picsum.photos/300/200?random=6&keyword=pub",
      "hostName": "Tommy O'Brien",
      "hostImage": "https://picsum.photos/50/50?random=106",
      "description": "Visit centuries-old pubs with fascinating stories",
      "maxGuests": 20,
      "isFavorite": false,
      "availability": "Weekend Only",
      "tags": ["21+", "History Included"],
      "featured": true
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Food & Drink", "value": "Food & Drink"},
    {"label": "Arts & Culture", "value": "Arts & Culture"},
    {"label": "Wellness", "value": "Wellness"},
    {"label": "Nightlife", "value": "Nightlife"},
    {"label": "Adventure", "value": "Adventure"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Napa Valley", "value": "Napa Valley"},
    {"label": "Little Italy", "value": "Little Italy"},
    {"label": "Arts District", "value": "Arts District"},
    {"label": "Beachfront", "value": "Beachfront"},
    {"label": "Old Town", "value": "Old Town"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "Under \$50", "value": "Under \$50"},
    {"label": "\$50 - \$100", "value": "\$50 - \$100"},
    {"label": "Over \$100", "value": "Over \$100"},
  ];

  List<Map<String, dynamic>> get filteredExperiences {
    return experiences.where((experience) {
      bool matchesSearch = experience["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          experience["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All Categories" || 
          experience["category"] == selectedCategory;
      
      bool matchesLocation = selectedLocation == "All Locations" || 
          experience["location"] == selectedLocation;
      
      bool matchesPrice = true;
      if (selectedPriceRange == "Under \$50") {
        matchesPrice = (experience["price"] as double) < 50;
      } else if (selectedPriceRange == "\$50 - \$100") {
        matchesPrice = (experience["price"] as double) >= 50 && (experience["price"] as double) <= 100;
      } else if (selectedPriceRange == "Over \$100") {
        matchesPrice = (experience["price"] as double) > 100;
      }
      
      bool matchesFavorites = !showFavorites || experience["isFavorite"] == true;
      
      return matchesSearch && matchesCategory && matchesLocation && matchesPrice && matchesFavorites;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredExperiences {
    return experiences.where((experience) => experience["featured"] == true).toList();
  }

  void _toggleFavorite(int experienceId) {
    setState(() {
      int index = experiences.indexWhere((exp) => exp["id"] == experienceId);
      if (index != -1) {
        experiences[index]["isFavorite"] = !experiences[index]["isFavorite"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Experiences"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -50,
                    top: -30,
                    child: Icon(
                      Icons.explore,
                      size: 120,
                      color: Colors.white.withAlpha(50),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Discover Unique\nExperiences",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Book authentic local experiences\nwith passionate hosts",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            QTextField(
              label: "Search experiences...",
              value: searchQuery,
              hint: "Wine tasting, cooking class, photography...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
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

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Price Range",
                    items: priceRanges,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Favorites Only",
                        "value": true,
                        "checked": showFavorites,
                      }
                    ],
                    value: [
                      if (showFavorites)
                        {
                          "label": "Show Favorites Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showFavorites = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Featured Experiences
            if (featuredExperiences.isNotEmpty) ...[
              Text(
                "Featured Experiences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: featuredExperiences.map((experience) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Stack(
                            children: [
                              Image.network(
                                "${experience["image"]}",
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
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
                                    "FEATURED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: GestureDetector(
                                  onTap: () => _toggleFavorite(experience["id"]),
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [shadowSm],
                                    ),
                                    child: Icon(
                                      experience["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                      color: experience["isFavorite"] ? dangerColor : disabledBoldColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${experience["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${experience["rating"]} (${experience["reviews"]})",
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
                                  Expanded(
                                    child: Text(
                                      "${experience["location"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${(experience["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  QButton(
                                    label: "Book Now",
                                    size: bs.sm,
                                    onPressed: () {},
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
            ],

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Experiences (${filteredExperiences.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Experiences List
            ...filteredExperiences.map((experience) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${experience["image"]}",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => _toggleFavorite(experience["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  experience["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                  color: experience["isFavorite"] ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${experience["availability"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${experience["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${experience["rating"]} (${experience["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${experience["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${experience["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage("${experience["hostImage"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hosted by ${experience["hostName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${experience["duration"]} • Max ${experience["maxGuests"]} guests",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: (experience["tags"] as List).map<Widget>((tag) {
                              return Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${(experience["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "per person",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              QButton(
                                label: "Book Experience",
                                size: bs.md,
                                onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
