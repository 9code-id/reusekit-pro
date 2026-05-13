import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSpeakerListView extends StatefulWidget {
  const EmaSpeakerListView({super.key});

  @override
  State<EmaSpeakerListView> createState() => _EmaSpeakerListViewState();
}

class _EmaSpeakerListViewState extends State<EmaSpeakerListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String sortBy = "rating";
  String viewMode = "grid";
  
  List<Map<String, dynamic>> speakers = [
    {
      "id": "speaker_001",
      "name": "Dr. Sarah Johnson",
      "title": "Chief Technology Officer",
      "company": "MedTech Solutions",
      "avatar": "https://picsum.photos/150/150?random=1&keyword=doctor",
      "rating": 4.9,
      "totalRatings": 324,
      "followers": 1250,
      "expertise": ["AI", "Healthcare", "Technology"],
      "sessionsCount": 12,
      "isFollowing": false,
      "category": "technology",
      "experience": "15+ years",
      "location": "San Francisco, CA",
      "upcomingSessions": 3,
      "featured": true,
    },
    {
      "id": "speaker_002",
      "name": "Prof. Michael Chen",
      "title": "Research Director",
      "company": "Innovation Labs",
      "avatar": "https://picsum.photos/150/150?random=2&keyword=professor",
      "rating": 4.8,
      "totalRatings": 256,
      "followers": 980,
      "expertise": ["Research", "Innovation", "Data Science"],
      "sessionsCount": 8,
      "isFollowing": true,
      "category": "research",
      "experience": "12+ years",
      "location": "Boston, MA",
      "upcomingSessions": 2,
      "featured": false,
    },
    {
      "id": "speaker_003",
      "name": "Jennifer Walsh",
      "title": "Marketing Strategy Lead",
      "company": "Digital Growth Inc",
      "avatar": "https://picsum.photos/150/150?random=3&keyword=business",
      "rating": 4.7,
      "totalRatings": 189,
      "followers": 756,
      "expertise": ["Marketing", "Strategy", "Digital"],
      "sessionsCount": 6,
      "isFollowing": false,
      "category": "marketing",
      "experience": "10+ years",
      "location": "New York, NY",
      "upcomingSessions": 1,
      "featured": true,
    },
    {
      "id": "speaker_004",
      "name": "David Park",
      "title": "UX Design Director",
      "company": "Creative Studio",
      "avatar": "https://picsum.photos/150/150?random=4&keyword=designer",
      "rating": 4.9,
      "totalRatings": 412,
      "followers": 1456,
      "expertise": ["UX Design", "Product", "Innovation"],
      "sessionsCount": 15,
      "isFollowing": true,
      "category": "design",
      "experience": "8+ years",
      "location": "Seattle, WA",
      "upcomingSessions": 4,
      "featured": false,
    },
    {
      "id": "speaker_005",
      "name": "Dr. Amanda White",
      "title": "Environmental Scientist",
      "company": "Green Future Foundation",
      "avatar": "https://picsum.photos/150/150?random=5&keyword=scientist",
      "rating": 4.6,
      "totalRatings": 134,
      "followers": 543,
      "expertise": ["Environment", "Sustainability", "Climate"],
      "sessionsCount": 4,
      "isFollowing": false,
      "category": "environment",
      "experience": "11+ years",
      "location": "Portland, OR",
      "upcomingSessions": 1,
      "featured": true,
    },
    {
      "id": "speaker_006",
      "name": "Robert Kim",
      "title": "Financial Technology Expert",
      "company": "FinTech Innovations",
      "avatar": "https://picsum.photos/150/150?random=6&keyword=finance",
      "rating": 4.8,
      "totalRatings": 298,
      "followers": 1124,
      "expertise": ["FinTech", "Blockchain", "Finance"],
      "sessionsCount": 9,
      "isFollowing": false,
      "category": "finance",
      "experience": "13+ years",
      "location": "Chicago, IL",
      "upcomingSessions": 2,
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"id": "all", "name": "All Speakers", "icon": Icons.people},
    {"id": "technology", "name": "Technology", "icon": Icons.computer},
    {"id": "research", "name": "Research", "icon": Icons.science},
    {"id": "marketing", "name": "Marketing", "icon": Icons.campaign},
    {"id": "design", "name": "Design", "icon": Icons.design_services},
    {"id": "environment", "name": "Environment", "icon": Icons.eco},
    {"id": "finance", "name": "Finance", "icon": Icons.attach_money},
  ];

  List<Map<String, dynamic>> get filteredSpeakers {
    List<Map<String, dynamic>> filtered = speakers;
    
    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((speaker) => speaker["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((speaker) {
        String name = speaker["name"].toString().toLowerCase();
        String company = speaker["company"].toString().toLowerCase();
        String title = speaker["title"].toString().toLowerCase();
        List<String> expertise = List<String>.from(speaker["expertise"]);
        String expertiseStr = expertise.join(" ").toLowerCase();
        
        return name.contains(searchQuery.toLowerCase()) ||
               company.contains(searchQuery.toLowerCase()) ||
               title.contains(searchQuery.toLowerCase()) ||
               expertiseStr.contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Sort speakers
    filtered.sort((a, b) {
      switch (sortBy) {
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "followers":
          return (b["followers"] as int).compareTo(a["followers"] as int);
        case "sessions":
          return (b["sessionsCount"] as int).compareTo(a["sessionsCount"] as int);
        case "name":
          return (a["name"] as String).compareTo(b["name"] as String);
        default:
          return 0;
      }
    });
    
    return filtered;
  }

  void _toggleFollow(String speakerId) {
    int index = speakers.indexWhere((speaker) => speaker["id"] == speakerId);
    if (index != -1) {
      speakers[index]["isFollowing"] = !speakers[index]["isFollowing"];
      setState(() {});
      ss(speakers[index]["isFollowing"] ? "Following speaker" : "Unfollowed speaker");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speakers"),
        actions: [
          GestureDetector(
            onTap: () {
              viewMode = viewMode == "grid" ? "list" : "grid";
              setState(() {});
            },
            child: Icon(
              viewMode == "grid" ? Icons.view_list : Icons.grid_view,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.record_voice_over,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expert Speakers",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${filteredSpeakers.length} speakers available",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${speakers.where((s) => s["featured"] == true).length} Featured",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.people, color: successColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "${speakers.where((s) => s["isFollowing"] == true).length} Following",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search speakers...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                GestureDetector(
                  onTap: () {
                    //navigateTo filter speakers
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Categories
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QHorizontalScroll(
              children: categories.map((category) => _buildCategoryChip(category)).toList(),
            ),

            SizedBox(height: spLg),

            // Sort Options
            Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spMd),
                _buildSortChip("Rating", "rating"),
                SizedBox(width: spSm),
                _buildSortChip("Followers", "followers"),
                SizedBox(width: spSm),
                _buildSortChip("Sessions", "sessions"),
              ],
            ),

            SizedBox(height: spLg),

            // Speakers List/Grid
            Text(
              "Speakers (${filteredSpeakers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            if (viewMode == "grid")
              ResponsiveGridView(
                minItemWidth: 200,
                children: filteredSpeakers.map((speaker) => _buildSpeakerCard(speaker)).toList(),
              )
            else
              Column(
                children: filteredSpeakers.map((speaker) => _buildSpeakerListItem(speaker)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(Map<String, dynamic> category) {
    bool isSelected = selectedCategory == category["id"];
    
    return GestureDetector(
      onTap: () {
        selectedCategory = category["id"];
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spMd),
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              category["icon"],
              color: isSelected ? Colors.white : disabledBoldColor,
              size: 16,
            ),
            SizedBox(width: spSm),
            Text(
              category["name"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    bool isSelected = sortBy == value;
    
    return GestureDetector(
      onTap: () {
        sortBy = value;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSpeakerCard(Map<String, dynamic> speaker) {
    return GestureDetector(
      onTap: () {
        //navigateTo speaker detail
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            // Avatar and Featured Badge
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("${speaker["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (speaker["featured"] == true)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: warningColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spMd),

            // Name and Title
            Text(
              "${speaker["name"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${speaker["title"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${speaker["company"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: spMd),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${speaker["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${speaker["followers"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${speaker["sessionsCount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Sessions",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Expertise Tags
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: (speaker["expertise"] as List).take(2).map((skill) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$skill",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Follow Button
            Container(
              width: double.infinity,
              child: QButton(
                label: speaker["isFollowing"] ? "Following" : "Follow",
                size: bs.sm,
                onPressed: () => _toggleFollow(speaker["id"]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerListItem(Map<String, dynamic> speaker) {
    return GestureDetector(
      onTap: () {
        //navigateTo speaker detail
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("${speaker["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (speaker["featured"] == true)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: warningColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: spMd),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${speaker["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${speaker["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${speaker["company"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${speaker["rating"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.people, color: primaryColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${speaker["followers"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "${speaker["upcomingSessions"]} upcoming",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Follow Button
            QButton(
              label: speaker["isFollowing"] ? "Following" : "Follow",
              size: bs.sm,
              onPressed: () => _toggleFollow(speaker["id"]),
            ),
          ],
        ),
      ),
    );
  }
}
