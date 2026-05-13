import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPeopleSearchView extends StatefulWidget {
  const SmaPeopleSearchView({super.key});

  @override
  State<SmaPeopleSearchView> createState() => _SmaPeopleSearchViewState();
}

class _SmaPeopleSearchViewState extends State<SmaPeopleSearchView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool isSearching = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Verified", "value": "Verified"},
    {"label": "Influencers", "value": "Influencers"},
    {"label": "Artists", "value": "Artists"},
    {"label": "Businesses", "value": "Businesses"},
  ];

  List<Map<String, dynamic>> suggestedPeople = [
    {
      "username": "@tech_innovator",
      "name": "Michael Chen",
      "avatar": "https://picsum.photos/80/80?random=401",
      "followers": 234567,
      "following": 1567,
      "posts": 892,
      "verified": true,
      "category": "Technology",
      "bio": "Tech entrepreneur & AI researcher 🤖 Building the future",
      "isFollowing": false,
      "mutualFriends": 12,
    },
    {
      "username": "@creative_artist",
      "name": "Elena Rodriguez",
      "avatar": "https://picsum.photos/80/80?random=402",
      "followers": 156789,
      "following": 2341,
      "posts": 1245,
      "verified": true,
      "category": "Art",
      "bio": "Digital artist & designer ✨ Creating magical worlds",
      "isFollowing": true,
      "mutualFriends": 8,
    },
    {
      "username": "@fitness_coach",
      "name": "Ryan Thompson",
      "avatar": "https://picsum.photos/80/80?random=403",
      "followers": 89456,
      "following": 567,
      "posts": 2156,
      "verified": false,
      "category": "Fitness",
      "bio": "Personal trainer 💪 Transform your body & mind",
      "isFollowing": false,
      "mutualFriends": 5,
    },
    {
      "username": "@food_explorer",
      "name": "Julia Martinez",
      "avatar": "https://picsum.photos/80/80?random=404",
      "followers": 123456,
      "following": 2890,
      "posts": 3421,
      "verified": true,
      "category": "Food",
      "bio": "Chef & food photographer 🍜 Taste the world with me",
      "isFollowing": false,
      "mutualFriends": 15,
    },
    {
      "username": "@travel_wanderer",
      "name": "David Kim",
      "avatar": "https://picsum.photos/80/80?random=405",
      "followers": 298567,
      "following": 1234,
      "posts": 1876,
      "verified": true,
      "category": "Travel",
      "bio": "Travel photographer 📸 Exploring hidden gems worldwide",
      "isFollowing": true,
      "mutualFriends": 22,
    },
    {
      "username": "@business_mentor",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/80/80?random=406",
      "followers": 345678,
      "following": 890,
      "posts": 567,
      "verified": true,
      "category": "Business",
      "bio": "Entrepreneur & business coach 📈 Scale your startup",
      "isFollowing": false,
      "mutualFriends": 7,
    },
  ];

  List<Map<String, dynamic>> searchResults = [];

  List<Map<String, dynamic>> get filteredPeople {
    List<Map<String, dynamic>> people = searchQuery.isEmpty ? suggestedPeople : searchResults;
    
    if (selectedFilter == "All") return people;
    
    return people.where((person) {
      switch (selectedFilter) {
        case "Verified":
          return person["verified"] == true;
        case "Influencers":
          return (person["followers"] as int) > 100000;
        case "Artists":
          return person["category"] == "Art";
        case "Businesses":
          return person["category"] == "Business";
        default:
          return true;
      }
    }).toList();
  }

  void performSearch() {
    if (searchQuery.trim().isEmpty) {
      searchResults.clear();
      setState(() {});
      return;
    }
    
    isSearching = true;
    setState(() {});
    
    // Simulate search
    Future.delayed(Duration(milliseconds: 1000), () {
      searchResults = suggestedPeople.where((person) =>
        person["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        person["username"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        person["bio"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        person["category"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
      
      isSearching = false;
      setState(() {});
    });
  }

  void toggleFollow(int index) {
    List<Map<String, dynamic>> currentList = searchQuery.isEmpty ? suggestedPeople : searchResults;
    currentList[index]["isFollowing"] = !currentList[index]["isFollowing"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find People"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // QR code scanner
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search people by name or username...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      if (value.isEmpty) {
                        searchResults.clear();
                      }
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: performSearch,
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            QCategoryPicker(
              label: "Filter People",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Section Title
            Row(
              children: [
                Text(
                  searchQuery.isEmpty ? "Suggested People" : "Search Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  Spacer(),
                  Text(
                    "${filteredPeople.length} results",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Loading State
            if (isSearching) ...[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: spSm),
                    Text(
                      "Searching people...",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ]
            
            // People List
            else if (filteredPeople.isEmpty && searchQuery.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.person_search,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No people found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Column(
                children: filteredPeople.map((person) {
                  final index = (searchQuery.isEmpty ? suggestedPeople : searchResults).indexOf(person);
                  
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${person["avatar"]}"),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            // User Info
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
                                      if (person["verified"] == true) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  Text(
                                    "${person["username"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${person["bio"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Follow Button
                            GestureDetector(
                              onTap: () => toggleFollow(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: person["isFollowing"] 
                                    ? primaryColor 
                                    : Colors.transparent,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  person["isFollowing"] ? "Following" : "Follow",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: person["isFollowing"] 
                                      ? Colors.white 
                                      : primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Stats Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((person["followers"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((person["following"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((person["posts"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Posts",
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
                        
                        // Additional Info Row
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${person["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            
                            if ((person["mutualFriends"] as int) > 0) ...[
                              SizedBox(width: spSm),
                              Text(
                                "${person["mutualFriends"]} mutual friends",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                            
                            Spacer(),
                            
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //navigateTo('MessageView')
                                  },
                                  child: Icon(
                                    Icons.message,
                                    size: 20,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                SizedBox(width: spSm),
                                
                                Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: disabledBoldColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
