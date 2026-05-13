import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore5View extends StatefulWidget {
  @override
  State<GrlExplore5View> createState() => _GrlExplore5ViewState();
}

class _GrlExplore5ViewState extends State<GrlExplore5View> {
  String searchQuery = "";
  String selectedDifficulty = "All Levels";
  String selectedRegion = "All Regions";
  String selectedDuration = "All Durations";
  bool showMultiDay = false;

  List<Map<String, dynamic>> adventures = [
    {
      "id": 1,
      "title": "Everest Base Camp Trek",
      "region": "Nepal Himalayas",
      "difficulty": "Expert",
      "duration": "14 days",
      "price": 2499.00,
      "rating": 4.9,
      "reviews": 456,
      "image": "https://picsum.photos/300/200?random=1&keyword=mountain",
      "elevation": "5,364m",
      "groupSize": "8-12 people",
      "description": "Epic trek to the base camp of the world's highest peak",
      "highlights": ["Base Camp Views", "Sherpa Culture", "Mountain Scenery"],
      "equipment": "Provided",
      "guide": "Expert Mountain Guide",
      "isFavorite": true,
      "isMultiDay": true,
      "featured": true,
      "season": "Spring/Autumn"
    },
    {
      "id": 2,
      "title": "Amazon Rainforest Expedition",
      "region": "Peru Amazon",
      "difficulty": "Intermediate",
      "duration": "7 days",
      "price": 1299.00,
      "rating": 4.8,
      "reviews": 234,
      "image": "https://picsum.photos/300/200?random=2&keyword=jungle",
      "elevation": "200m",
      "groupSize": "6-10 people",
      "description": "Deep jungle exploration with wildlife encounters",
      "highlights": ["Wildlife Spotting", "Indigenous Culture", "Canopy Walk"],
      "equipment": "Partially Provided",
      "guide": "Local Nature Expert",
      "isFavorite": false,
      "isMultiDay": true,
      "featured": false,
      "season": "Year Round"
    },
    {
      "id": 3,
      "title": "Sahara Desert Crossing",
      "region": "Morocco Sahara",
      "difficulty": "Advanced",
      "duration": "5 days",
      "price": 899.00,
      "rating": 4.7,
      "reviews": 189,
      "image": "https://picsum.photos/300/200?random=3&keyword=desert",
      "elevation": "400m",
      "groupSize": "4-8 people",
      "description": "Camel trekking across the golden dunes",
      "highlights": ["Camel Trekking", "Desert Camping", "Star Gazing"],
      "equipment": "Fully Provided",
      "guide": "Berber Guide",
      "isFavorite": true,
      "isMultiDay": true,
      "featured": true,
      "season": "Winter/Spring"
    },
    {
      "id": 4,
      "title": "Patagonia Glacier Hike",
      "region": "Argentina Patagonia",
      "difficulty": "Intermediate",
      "duration": "1 day",
      "price": 189.00,
      "rating": 4.6,
      "reviews": 312,
      "image": "https://picsum.photos/300/200?random=4&keyword=glacier",
      "elevation": "1,200m",
      "groupSize": "10-15 people",
      "description": "Ice walking on the spectacular Perito Moreno Glacier",
      "highlights": ["Ice Walking", "Glacier Views", "Photography"],
      "equipment": "Provided",
      "guide": "Glacier Specialist",
      "isFavorite": false,
      "isMultiDay": false,
      "featured": false,
      "season": "Summer"
    },
    {
      "id": 5,
      "title": "Northern Lights Adventure",
      "region": "Iceland Arctic",
      "difficulty": "Beginner",
      "duration": "3 days",
      "price": 699.00,
      "rating": 4.8,
      "reviews": 278,
      "image": "https://picsum.photos/300/200?random=5&keyword=aurora",
      "elevation": "50m",
      "groupSize": "6-12 people",
      "description": "Aurora hunting in the land of fire and ice",
      "highlights": ["Aurora Viewing", "Ice Caves", "Hot Springs"],
      "equipment": "Winter Gear Provided",
      "guide": "Aurora Expert",
      "isFavorite": true,
      "isMultiDay": true,
      "featured": true,
      "season": "Winter"
    },
    {
      "id": 6,
      "title": "Volcano Summit Climb",
      "region": "Indonesia Java",
      "difficulty": "Advanced",
      "duration": "2 days",
      "price": 349.00,
      "rating": 4.5,
      "reviews": 156,
      "image": "https://picsum.photos/300/200?random=6&keyword=volcano",
      "elevation": "3,676m",
      "groupSize": "5-8 people",
      "description": "Sunrise summit climb of active volcano",
      "highlights": ["Sunrise Summit", "Active Crater", "Sulfur Mining"],
      "equipment": "Basic Provided",
      "guide": "Mountain Guide",
      "isFavorite": false,
      "isMultiDay": true,
      "featured": false,
      "season": "Dry Season"
    }
  ];

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All Levels", "value": "All Levels"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "All Regions", "value": "All Regions"},
    {"label": "Nepal Himalayas", "value": "Nepal Himalayas"},
    {"label": "Peru Amazon", "value": "Peru Amazon"},
    {"label": "Morocco Sahara", "value": "Morocco Sahara"},
    {"label": "Argentina Patagonia", "value": "Argentina Patagonia"},
    {"label": "Iceland Arctic", "value": "Iceland Arctic"},
    {"label": "Indonesia Java", "value": "Indonesia Java"},
  ];

  List<Map<String, dynamic>> durations = [
    {"label": "All Durations", "value": "All Durations"},
    {"label": "Day Trips", "value": "Day Trips"},
    {"label": "2-3 Days", "value": "2-3 Days"},
    {"label": "4-7 Days", "value": "4-7 Days"},
    {"label": "8+ Days", "value": "8+ Days"},
  ];

  List<Map<String, dynamic>> get filteredAdventures {
    return adventures.where((adventure) {
      bool matchesSearch = adventure["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          adventure["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDifficulty = selectedDifficulty == "All Levels" || 
          adventure["difficulty"] == selectedDifficulty;
      
      bool matchesRegion = selectedRegion == "All Regions" || 
          adventure["region"] == selectedRegion;
      
      bool matchesDuration = true;
      if (selectedDuration == "Day Trips") {
        matchesDuration = adventure["duration"].contains("day") && !adventure["duration"].contains("days");
      } else if (selectedDuration == "2-3 Days") {
        matchesDuration = adventure["duration"].contains("2 days") || adventure["duration"].contains("3 days");
      } else if (selectedDuration == "4-7 Days") {
        matchesDuration = ["4 days", "5 days", "6 days", "7 days"].any((d) => adventure["duration"].contains(d));
      } else if (selectedDuration == "8+ Days") {
        int days = int.tryParse(adventure["duration"].split(" ").first) ?? 0;
        matchesDuration = days >= 8;
      }
      
      bool matchesMultiDay = !showMultiDay || adventure["isMultiDay"] == true;
      
      return matchesSearch && matchesDifficulty && matchesRegion && matchesDuration && matchesMultiDay;
    }).toList();
  }

  List<Map<String, dynamic>> get featuredAdventures {
    return adventures.where((adventure) => adventure["featured"] == true).toList();
  }

  void _toggleFavorite(int adventureId) {
    setState(() {
      int index = adventures.indexWhere((adv) => adv["id"] == adventureId);
      if (index != -1) {
        adventures[index]["isFavorite"] = !adventures[index]["isFavorite"];
      }
    });
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return infoColor;
      case "Advanced":
        return warningColor;
      case "Expert":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adventure Explorer"),
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
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -40,
                    top: -20,
                    child: Icon(
                      Icons.terrain,
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
                          "Epic Adventures\nAwait",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Discover extraordinary journeys\nacross the globe",
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
              label: "Search adventures...",
              value: searchQuery,
              hint: "Everest, Amazon, Sahara...",
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
                    label: "Difficulty",
                    items: difficultyLevels,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
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
                    label: "Duration",
                    items: durations,
                    value: selectedDuration,
                    onChanged: (value, label) {
                      selectedDuration = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Multi-Day Only",
                        "value": true,
                        "checked": showMultiDay,
                      }
                    ],
                    value: [
                      if (showMultiDay)
                        {
                          "label": "Multi-Day Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showMultiDay = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Featured Adventures
            if (featuredAdventures.isNotEmpty) ...[
              Text(
                "Epic Adventures",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: featuredAdventures.map((adventure) {
                  return Container(
                    width: 300,
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
                                "${adventure["image"]}",
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(adventure["difficulty"]),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${adventure["difficulty"]}",
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
                                  onTap: () => _toggleFavorite(adventure["id"]),
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [shadowSm],
                                    ),
                                    child: Icon(
                                      adventure["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                      color: adventure["isFavorite"] ? dangerColor : disabledBoldColor,
                                      size: 18,
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
                                    "${adventure["duration"]}",
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
                              Text(
                                "${adventure["title"]}",
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
                                  Icon(Icons.location_on, color: primaryColor, size: 14),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${adventure["region"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${adventure["rating"]} (${adventure["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${(adventure["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  QButton(
                                    label: "Book",
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
                  "All Adventures (${filteredAdventures.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Adventures List
            ...filteredAdventures.map((adventure) {
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
                            "${adventure["image"]}",
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => _toggleFavorite(adventure["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  adventure["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                  color: adventure["isFavorite"] ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(adventure["difficulty"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${adventure["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (adventure["isMultiDay"])
                            Positioned(
                              bottom: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "MULTI-DAY",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
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
                              Expanded(
                                child: Text(
                                  "${adventure["title"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${adventure["rating"]} (${adventure["reviews"]})",
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
                          SizedBox(height: spXs),
                          Text(
                            "${adventure["description"]}",
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
                              Icon(Icons.location_on, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${adventure["region"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.terrain, color: disabledBoldColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${adventure["elevation"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${adventure["duration"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.group, color: disabledBoldColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${adventure["groupSize"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: (adventure["highlights"] as List).map<Widget>((highlight) {
                              return Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$highlight",
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
                            children: [
                              Icon(Icons.person, color: disabledBoldColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${adventure["guide"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.backpack, color: disabledBoldColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${adventure["equipment"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${(adventure["price"] as double).currency}",
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
                                label: "Book Adventure",
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
