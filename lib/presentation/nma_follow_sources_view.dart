import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaFollowSourcesView extends StatefulWidget {
  const NmaFollowSourcesView({super.key});

  @override
  State<NmaFollowSourcesView> createState() => _NmaFollowSourcesViewState();
}

class _NmaFollowSourcesViewState extends State<NmaFollowSourcesView> {
  String searchQuery = "";
  String selectedTab = "following";
  
  List<Map<String, dynamic>> followedSources = [
    {
      "id": "bbc",
      "name": "BBC News",
      "description": "Breaking news, world news, UK news and analysis",
      "logo": "https://picsum.photos/60/60?random=1&keyword=bbc",
      "verified": true,
      "followers": 15420000,
      "articlesPerDay": 120,
      "notificationsEnabled": true,
      "followedAt": "2024-01-15",
      "category": "General News",
    },
    {
      "id": "cnn",
      "name": "CNN",
      "description": "Breaking news and live coverage from CNN",
      "logo": "https://picsum.photos/60/60?random=2&keyword=news",
      "verified": true,
      "followers": 12800000,
      "articlesPerDay": 100,
      "notificationsEnabled": false,
      "followedAt": "2024-02-20",
      "category": "General News",
    },
    {
      "id": "techcrunch",
      "name": "TechCrunch",
      "description": "Startup and technology news",
      "logo": "https://picsum.photos/60/60?random=3&keyword=tech",
      "verified": true,
      "followers": 4200000,
      "articlesPerDay": 45,
      "notificationsEnabled": true,
      "followedAt": "2024-03-10",
      "category": "Technology",
    },
    {
      "id": "bloomberg",
      "name": "Bloomberg",
      "description": "Business and financial news",
      "logo": "https://picsum.photos/60/60?random=4&keyword=bloomberg",
      "verified": true,
      "followers": 5400000,
      "articlesPerDay": 60,
      "notificationsEnabled": true,
      "followedAt": "2024-01-28",
      "category": "Business",
    },
    {
      "id": "espn",
      "name": "ESPN",
      "description": "Sports news, scores, and highlights",
      "logo": "https://picsum.photos/60/60?random=5&keyword=sports",
      "verified": true,
      "followers": 8100000,
      "articlesPerDay": 80,
      "notificationsEnabled": false,
      "followedAt": "2024-02-05",
      "category": "Sports",
    },
  ];

  List<Map<String, dynamic>> suggestedSources = [
    {
      "id": "reuters",
      "name": "Reuters",
      "description": "International breaking news and headlines",
      "logo": "https://picsum.photos/60/60?random=6&keyword=reuters",
      "verified": true,
      "followers": 8950000,
      "articlesPerDay": 85,
      "category": "General News",
      "reason": "Popular in General News",
    },
    {
      "id": "guardian",
      "name": "The Guardian",
      "description": "Latest news, sport and comment from the Guardian",
      "logo": "https://picsum.photos/60/60?random=7&keyword=guardian",
      "verified": true,
      "followers": 6800000,
      "articlesPerDay": 90,
      "category": "General News",
      "reason": "Recommended for you",
    },
    {
      "id": "wired",
      "name": "WIRED",
      "description": "Technology, science and culture news",
      "logo": "https://picsum.photos/60/60?random=8&keyword=wired",
      "verified": true,
      "followers": 3200000,
      "articlesPerDay": 35,
      "category": "Technology",
      "reason": "Similar to TechCrunch",
    },
    {
      "id": "wsj",
      "name": "Wall Street Journal",
      "description": "Business and financial news and analysis",
      "logo": "https://picsum.photos/60/60?random=9&keyword=wall",
      "verified": true,
      "followers": 4800000,
      "articlesPerDay": 70,
      "category": "Business",
      "reason": "Similar to Bloomberg",
    },
  ];

  List<Map<String, dynamic>> get filteredFollowedSources {
    if (searchQuery.isEmpty) return followedSources;
    return followedSources.where((source) =>
      (source["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (source["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> get filteredSuggestedSources {
    if (searchQuery.isEmpty) return suggestedSources;
    return suggestedSources.where((source) =>
      (source["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (source["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow Sources"),
        actions: [
          GestureDetector(
            onTap: () {
              _manageNotifications();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Icon(
                Icons.notifications,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search sources...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "following";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "following" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Following (${followedSources.length})",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "following" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "suggested";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "suggested" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Suggested (${suggestedSources.length})",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "suggested" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: selectedTab == "following"
                    ? _buildFollowingTab()
                    : _buildSuggestedTab(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFollowingTab() {
    if (filteredFollowedSources.isEmpty) {
      return [
        Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: disabledColor,
              ),
              SizedBox(height: spMd),
              Text(
                searchQuery.isEmpty 
                    ? "You're not following any sources yet" 
                    : "No sources found matching '${searchQuery}'",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              if (searchQuery.isEmpty)
                SizedBox(height: spMd),
              if (searchQuery.isEmpty)
                QButton(
                  label: "Discover Sources",
                  size: bs.md,
                  onPressed: () {
                    selectedTab = "suggested";
                    setState(() {});
                  },
                ),
            ],
          ),
        ),
      ];
    }

    return filteredFollowedSources.map((source) => _buildFollowedSourceItem(source)).toList();
  }

  List<Widget> _buildSuggestedTab() {
    return [
      // Header
      Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: primaryColor.withAlpha(50)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: primaryColor,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "Sources recommended based on your interests and reading history",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Suggested Sources
      ...filteredSuggestedSources.map((source) => _buildSuggestedSourceItem(source)),
    ];
  }

  Widget _buildFollowedSourceItem(Map<String, dynamic> source) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              // Source Logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${source["logo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              
              // Source Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${source["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (source["verified"] as bool)
                          SizedBox(width: spXs),
                        if (source["verified"] as bool)
                          Icon(
                            Icons.verified,
                            color: primaryColor,
                            size: 16,
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${source["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // More Options
              GestureDetector(
                onTap: () {
                  _showSourceOptions(source);
                },
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          // Source Stats and Notifications
          Row(
            children: [
              Text(
                "${((source["followers"] as int) / 1000000).toStringAsFixed(1)}M followers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "${source["articlesPerDay"]} articles/day",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _toggleNotifications(source["id"]);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      source["notificationsEnabled"] ? Icons.notifications : Icons.notifications_off,
                      size: 16,
                      color: source["notificationsEnabled"] ? primaryColor : disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      source["notificationsEnabled"] ? "On" : "Off",
                      style: TextStyle(
                        fontSize: 12,
                        color: source["notificationsEnabled"] ? primaryColor : disabledBoldColor,
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
    );
  }

  Widget _buildSuggestedSourceItem(Map<String, dynamic> source) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              // Source Logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${source["logo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              
              // Source Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${source["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (source["verified"] as bool)
                          SizedBox(width: spXs),
                        if (source["verified"] as bool)
                          Icon(
                            Icons.verified,
                            color: primaryColor,
                            size: 16,
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${source["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Follow Button
              QButton(
                label: "Follow",
                size: bs.sm,
                onPressed: () {
                  _followSource(source);
                },
              ),
            ],
          ),
          
          // Recommendation Reason and Stats
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${source["reason"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${((source["followers"] as int) / 1000000).toStringAsFixed(1)}M followers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSourceOptions(Map<String, dynamic> source) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Text(
              "${source["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QButton(
              label: "View Source Details",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                // ss('Next page'));
              },
            ),
            QButton(
              label: "Toggle Notifications",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _toggleNotifications(source["id"]);
              },
            ),
            QButton(
              label: "Unfollow",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                _unfollowSource(source["id"]);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleNotifications(String sourceId) {
    int index = followedSources.indexWhere((source) => source["id"] == sourceId);
    if (index != -1) {
      followedSources[index]["notificationsEnabled"] = !followedSources[index]["notificationsEnabled"];
      setState(() {});
      ss(followedSources[index]["notificationsEnabled"] 
          ? "Notifications enabled" 
          : "Notifications disabled");
    }
  }

  void _followSource(Map<String, dynamic> source) {
    Map<String, dynamic> newSource = {
      ...source,
      "notificationsEnabled": true,
      "followedAt": DateTime.now().toString().substring(0, 10),
    };
    newSource.remove("reason");
    
    followedSources.add(newSource);
    suggestedSources.removeWhere((s) => s["id"] == source["id"]);
    setState(() {});
    ss("Now following ${source["name"]}");
  }

  void _unfollowSource(String sourceId) {
    followedSources.removeWhere((source) => source["id"] == sourceId);
    setState(() {});
    ss("Source unfollowed");
  }

  void _manageNotifications() {
    ss("Opening notification settings");
  }
}
