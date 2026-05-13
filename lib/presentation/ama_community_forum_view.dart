import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCommunityForumView extends StatefulWidget {
  const AmaCommunityForumView({super.key});

  @override
  State<AmaCommunityForumView> createState() => _AmaCommunityForumViewState();
}

class _AmaCommunityForumViewState extends State<AmaCommunityForumView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String selectedSort = "Latest";
  int selectedTab = 0;
  
  List<Map<String, dynamic>> forumPosts = [
    {
      "id": "fp001",
      "title": "Best practices for organic pest control in tomatoes",
      "content": "I've been struggling with aphids on my tomato plants. Looking for organic solutions that won't harm beneficial insects. What methods have worked best for you?",
      "author": "GreenThumb_Sarah",
      "author_avatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "category": "Pest Control",
      "replies": 23,
      "likes": 45,
      "views": 342,
      "created_at": "2024-01-15T10:30:00",
      "last_reply": "2024-01-15T15:45:00",
      "tags": ["organic", "tomatoes", "pests", "aphids"],
      "is_pinned": false,
      "is_solved": true,
      "has_images": true,
      "expertise_level": "Intermediate",
    },
    {
      "id": "fp002",
      "title": "Crop rotation schedule for small farms - Need advice",
      "content": "Planning my crop rotation for next season on 5 acres. Current crops: corn, beans, wheat. Looking for sustainable rotation patterns that maintain soil health.",
      "author": "FarmLife_Mike",
      "author_avatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "category": "Crop Management",
      "replies": 18,
      "likes": 32,
      "views": 256,
      "created_at": "2024-01-14T14:20:00",
      "last_reply": "2024-01-15T09:15:00",
      "tags": ["rotation", "soil-health", "planning", "sustainability"],
      "is_pinned": true,
      "is_solved": false,
      "has_images": false,
      "expertise_level": "Beginner",
    },
    {
      "id": "fp003",
      "title": "Smart irrigation system recommendations?",
      "content": "Looking to upgrade to smart irrigation. Budget around \$2000. Need something that works with different crop zones and weather integration. Experiences?",
      "author": "TechFarmer_Alex",
      "author_avatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "category": "Technology",
      "replies": 31,
      "likes": 67,
      "views": 489,
      "created_at": "2024-01-13T16:45:00",
      "last_reply": "2024-01-15T12:30:00",
      "tags": ["irrigation", "technology", "smart-farming", "automation"],
      "is_pinned": false,
      "is_solved": false,
      "has_images": true,
      "expertise_level": "Advanced",
    },
    {
      "id": "fp004",
      "title": "Dealing with drought conditions - Water conservation tips",
      "content": "Third year of drought in our area. Need practical water conservation strategies that don't compromise yield too much. What's working for others?",
      "author": "DroughtSurvivor_Lisa",
      "author_avatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "category": "Water Management",
      "replies": 27,
      "likes": 54,
      "views": 378,
      "created_at": "2024-01-12T11:15:00",
      "last_reply": "2024-01-15T08:20:00",
      "tags": ["drought", "water-conservation", "climate", "adaptation"],
      "is_pinned": false,
      "is_solved": false,
      "has_images": false,
      "expertise_level": "Intermediate",
    },
    {
      "id": "fp005",
      "title": "Livestock feed costs rising - Alternative feed sources?",
      "content": "Feed costs up 40% this year. Exploring alternative feed sources and supplements. Anyone tried sprouted grains or local waste streams?",
      "author": "CattleRancher_Tom",
      "author_avatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "category": "Livestock",
      "replies": 22,
      "likes": 41,
      "views": 293,
      "created_at": "2024-01-11T09:30:00",
      "last_reply": "2024-01-14T17:45:00",
      "tags": ["livestock", "feed", "costs", "alternatives"],
      "is_pinned": false,
      "is_solved": false,
      "has_images": false,
      "expertise_level": "Intermediate",
    },
    {
      "id": "fp006",
      "title": "Soil testing results interpretation help needed",
      "content": "Got my soil test results back and need help interpreting the numbers. pH 6.2, organic matter 2.8%. What amendments should I prioritize?",
      "author": "NewFarmer_Jessica",
      "author_avatar": "https://picsum.photos/40/40?random=6&keyword=person",
      "category": "Soil Health",
      "replies": 15,
      "likes": 28,
      "views": 187,
      "created_at": "2024-01-10T13:20:00",
      "last_reply": "2024-01-15T11:10:00",
      "tags": ["soil-testing", "amendments", "ph", "organic-matter"],
      "is_pinned": false,
      "is_solved": true,
      "has_images": true,
      "expertise_level": "Beginner",
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return forumPosts.where((post) {
      bool matchesCategory = selectedCategory == "All" || post["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
        post["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        post["content"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesSearch;
    }).toList()..sort((a, b) {
      switch (selectedSort) {
        case "Latest":
          return DateTime.parse(b["created_at"]).compareTo(DateTime.parse(a["created_at"]));
        case "Most Replies":
          return (b["replies"] as int).compareTo(a["replies"] as int);
        case "Most Likes":
          return (b["likes"] as int).compareTo(a["likes"] as int);
        case "Most Views":
          return (b["views"] as int).compareTo(a["views"] as int);
        default:
          return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Forum"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Overview
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${forumPosts.length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Active Posts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${forumPosts.fold(0, (sum, post) => sum + (post["replies"] as int))}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Replies",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${forumPosts.where((p) => p["is_solved"] == true).length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Solved",
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
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search and Filters
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: disabledBoldColor, size: 20),
                              SizedBox(width: spXs),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    searchQuery = value;
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Search discussions...",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: disabledBoldColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSort,
                            onChanged: (value) {
                              selectedSort = value!;
                              setState(() {});
                            },
                            items: ["Latest", "Most Replies", "Most Likes", "Most Views"]
                                .map((sort) => DropdownMenuItem(
                                      value: sort,
                                      child: Text(
                                        sort,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Category Filter
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: selectedCategory == "All" ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: selectedCategory == "All" ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              selectedCategory = "All";
                              setState(() {});
                            },
                            child: Text(
                              "All Topics",
                              style: TextStyle(
                                color: selectedCategory == "All" ? Colors.white : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        ...["Crop Management", "Livestock", "Pest Control", "Soil Health", "Water Management", "Technology"]
                            .map((category) => Container(
                              margin: EdgeInsets.only(left: spXs),
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: selectedCategory == category ? primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: selectedCategory == category ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  selectedCategory = category;
                                  setState(() {});
                                },
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: selectedCategory == category ? Colors.white : disabledBoldColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Forum Posts
                  Text(
                    "Discussions (${filteredPosts.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: post["is_pinned"] == true ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
                            width: post["is_pinned"] == true ? 1.5 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Post Header
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${post["author_avatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${post["author"]}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (post["is_pinned"] == true) ...[
                                            SizedBox(width: spXs),
                                            Icon(Icons.push_pin, color: primaryColor, size: 12),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        DateTime.parse(post["created_at"]).dMMMy,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(post["category"]).withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: _getCategoryColor(post["category"]).withAlpha(30),
                                    ),
                                  ),
                                  child: Text(
                                    "${post["category"]}",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: _getCategoryColor(post["category"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Post Title and Content
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${post["title"]}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (post["is_solved"] == true)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(color: successColor.withAlpha(30)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.check_circle, color: successColor, size: 10),
                                        SizedBox(width: 2),
                                        Text(
                                          "Solved",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${post["content"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (post["tags"] as List).take(3).map<Widget>((tag) => Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Post Stats and Actions
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.comment_outlined, color: disabledBoldColor, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "${post["replies"]}",
                                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(Icons.favorite_border, color: disabledBoldColor, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "${post["likes"]}",
                                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(Icons.visibility_outlined, color: disabledBoldColor, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "${post["views"]}",
                                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                                if (post["has_images"] == true) ...[
                                  SizedBox(width: spSm),
                                  Icon(Icons.image, color: disabledBoldColor, size: 14),
                                ],
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getExpertiseColor(post["expertise_level"]).withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: _getExpertiseColor(post["expertise_level"]).withAlpha(30),
                                    ),
                                  ),
                                  child: Text(
                                    "${post["expertise_level"]}",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: _getExpertiseColor(post["expertise_level"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Discussion",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.favorite_border,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.bookmark_border,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case "Crop Management":
        return successColor;
      case "Livestock":
        return warningColor;
      case "Pest Control":
        return dangerColor;
      case "Soil Health":
        return Colors.brown;
      case "Water Management":
        return infoColor;
      case "Technology":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getExpertiseColor(String level) {
    switch (level) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
