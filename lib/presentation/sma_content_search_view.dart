import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaContentSearchView extends StatefulWidget {
  const SmaContentSearchView({super.key});

  @override
  State<SmaContentSearchView> createState() => _SmaContentSearchViewState();
}

class _SmaContentSearchViewState extends State<SmaContentSearchView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedSort = "Recent";
  bool isSearching = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Photos", "value": "Photos"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Stories", "value": "Stories"},
    {"label": "Reels", "value": "Reels"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Most Liked", "value": "Most Liked"},
    {"label": "Most Commented", "value": "Most Commented"},
  ];

  List<Map<String, dynamic>> content = [
    {
      "id": 1,
      "type": "photo",
      "user": "@nature_photographer",
      "userAvatar": "https://picsum.photos/50/50?random=501",
      "image": "https://picsum.photos/300/400?random=601&keyword=nature",
      "caption": "Golden hour magic in the mountains ✨ Nature never ceases to amaze me! #nature #photography #mountains",
      "likes": 15847,
      "comments": 342,
      "shares": 89,
      "timeAgo": "2h",
      "hashtags": ["#nature", "#photography", "#mountains"],
      "location": "Rocky Mountains, Colorado",
    },
    {
      "id": 2,
      "type": "video",
      "user": "@cooking_master",
      "userAvatar": "https://picsum.photos/50/50?random=502",
      "image": "https://picsum.photos/300/400?random=602&keyword=food",
      "caption": "Quick 15-minute pasta recipe that will blow your mind! 🍝 Perfect for busy weekdays #cooking #pasta #recipe",
      "likes": 23456,
      "comments": 567,
      "shares": 234,
      "timeAgo": "4h",
      "hashtags": ["#cooking", "#pasta", "#recipe"],
      "duration": "0:45",
    },
    {
      "id": 3,
      "type": "photo",
      "user": "@fitness_journey",
      "userAvatar": "https://picsum.photos/50/50?random=503",
      "image": "https://picsum.photos/300/500?random=603&keyword=fitness",
      "caption": "6 months transformation update! Consistency is key 💪 Never give up on yourself #fitness #transformation",
      "likes": 8934,
      "comments": 178,
      "shares": 45,
      "timeAgo": "6h",
      "hashtags": ["#fitness", "#transformation"],
    },
    {
      "id": 4,
      "type": "video",
      "user": "@travel_explorer",
      "userAvatar": "https://picsum.photos/50/50?random=504",
      "image": "https://picsum.photos/300/400?random=604&keyword=travel",
      "caption": "Hidden gem in Bali you NEED to visit! 🏝️ This place is absolutely magical #travel #bali #hidden",
      "likes": 34567,
      "comments": 891,
      "shares": 456,
      "timeAgo": "8h",
      "hashtags": ["#travel", "#bali", "#hidden"],
      "location": "Sekumpul Falls, Bali",
      "duration": "1:23",
    },
    {
      "id": 5,
      "type": "photo",
      "user": "@art_studio",
      "userAvatar": "https://picsum.photos/50/50?random=505",
      "image": "https://picsum.photos/300/600?random=605&keyword=art",
      "caption": "New digital artwork completed! What do you think? 🎨 Spent 3 weeks on this piece #digitalart #artwork",
      "likes": 12345,
      "comments": 234,
      "shares": 67,
      "timeAgo": "12h",
      "hashtags": ["#digitalart", "#artwork"],
    },
    {
      "id": 6,
      "type": "video",
      "user": "@tech_reviews",
      "userAvatar": "https://picsum.photos/50/50?random=506",
      "image": "https://picsum.photos/300/400?random=606&keyword=tech",
      "caption": "iPhone 15 Pro detailed review! Is it worth the upgrade? 📱 Link in bio for full review #tech #iphone #review",
      "likes": 45678,
      "comments": 1234,
      "shares": 789,
      "timeAgo": "1d",
      "hashtags": ["#tech", "#iphone", "#review"],
      "duration": "10:45",
    },
  ];

  List<Map<String, dynamic>> searchResults = [];

  List<Map<String, dynamic>> get filteredContent {
    List<Map<String, dynamic>> currentContent = searchQuery.isEmpty ? content : searchResults;
    
    if (selectedFilter == "All") return currentContent;
    
    return currentContent.where((item) {
      switch (selectedFilter) {
        case "Photos":
          return item["type"] == "photo";
        case "Videos":
          return item["type"] == "video";
        case "Stories":
          return item["type"] == "story";
        case "Reels":
          return item["type"] == "reel";
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
      searchResults = content.where((item) =>
        item["caption"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        item["user"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        (item["hashtags"] as List).any((tag) => 
          tag.toLowerCase().contains(searchQuery.toLowerCase())) ||
        (item["location"] != null && 
          item["location"].toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
      
      isSearching = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Content"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
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
                    label: "Search posts, captions, hashtags...",
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
            
            // Filters Row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QDropdownField(
                    label: "Content Type",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  searchQuery.isEmpty ? "Trending Content" : "Search Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  Spacer(),
                  Text(
                    "${filteredContent.length} results",
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
                      "Searching content...",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ]
            
            // No Results
            else if (filteredContent.isEmpty && searchQuery.isNotEmpty) ...[
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
                      Icons.search_off,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No content found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try different keywords or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ]
            
            // Content Grid
            else ...[
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredContent.map((item) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Content Image/Video
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusMd),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                "${item["image"]}",
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              
                              // Video Indicator
                              if (item["type"] == "video") ...[
                                Positioned(
                                  right: spSm,
                                  top: spSm,
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
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        if (item["duration"] != null) ...[
                                          SizedBox(width: 2),
                                          Text(
                                            "${item["duration"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              
                              // Content Type Badge
                              Positioned(
                                left: spSm,
                                top: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(200),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["type"].toUpperCase()}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Content Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User Info
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      "${item["userAvatar"]}",
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item["user"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${item["timeAgo"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Caption
                              Text(
                                "${item["caption"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Hashtags
                              if (item["hashtags"] != null) ...[
                                Wrap(
                                  spacing: spXs,
                                  children: (item["hashtags"] as List).take(3).map((hashtag) {
                                    return Text(
                                      "$hashtag",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }).toList(),
                                ),
                                
                                SizedBox(height: spSm),
                              ],
                              
                              // Location
                              if (item["location"] != null) ...[
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        "${item["location"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                              ],
                              
                              // Engagement Stats
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 14,
                                    color: dangerColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${((item["likes"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.comment,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${item["comments"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.share,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${item["shares"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
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
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
