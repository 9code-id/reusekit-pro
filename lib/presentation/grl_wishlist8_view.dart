import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist8View extends StatefulWidget {
  @override
  State<GrlWishlist8View> createState() => _GrlWishlist8ViewState();
}

class _GrlWishlist8ViewState extends State<GrlWishlist8View> {
  bool loading = false;
  String searchQuery = "";
  String selectedGroupType = "all";
  
  List<Map<String, dynamic>> socialGroups = [
    {
      "id": 1,
      "name": "Tech Enthusiasts",
      "description": "Latest gadgets and technology deals",
      "memberCount": 1247,
      "type": "public",
      "category": "Electronics",
      "image": "https://picsum.photos/400/200?random=60&keyword=technology",
      "isJoined": true,
      "isAdmin": false,
      "lastActivity": "2024-12-20T14:30:00",
      "recentPosts": [
        {
          "author": "TechGuru42",
          "content": "Found an amazing deal on the new iPhone 15 Pro!",
          "likes": 23,
          "timestamp": "2024-12-20T13:45:00",
        }
      ],
    },
    {
      "id": 2,
      "name": "Fashion Hunters",
      "description": "Designer deals and fashion finds",
      "memberCount": 892,
      "type": "public",
      "category": "Fashion",
      "image": "https://picsum.photos/400/200?random=61&keyword=fashion",
      "isJoined": true,
      "isAdmin": true,
      "lastActivity": "2024-12-20T12:15:00",
      "recentPosts": [
        {
          "author": "StyleQueen",
          "content": "Zara sale starts tomorrow - 50% off everything!",
          "likes": 45,
          "timestamp": "2024-12-20T11:30:00",
        }
      ],
    },
    {
      "id": 3,
      "name": "Home & Garden Deals",
      "description": "Best deals for your home and garden",
      "memberCount": 634,
      "type": "private",
      "category": "Home",
      "image": "https://picsum.photos/400/200?random=62&keyword=home",
      "isJoined": false,
      "isAdmin": false,
      "lastActivity": "2024-12-20T10:45:00",
      "recentPosts": [],
    },
    {
      "id": 4,
      "name": "Book Lovers Club",
      "description": "Share your favorite book deals and recommendations",
      "memberCount": 456,
      "type": "public",
      "category": "Books",
      "image": "https://picsum.photos/400/200?random=63&keyword=books",
      "isJoined": true,
      "isAdmin": false,
      "lastActivity": "2024-12-19T18:20:00",
      "recentPosts": [
        {
          "author": "BookWorm",
          "content": "Amazon has 70% off programming books this week!",
          "likes": 12,
          "timestamp": "2024-12-19T17:15:00",
        }
      ],
    },
  ];

  List<Map<String, dynamic>> friendActivity = [
    {
      "id": 1,
      "userName": "Sarah Johnson",
      "userAvatar": "https://picsum.photos/60/60?random=65&keyword=woman",
      "action": "added_to_wishlist",
      "productName": "Wireless Charging Pad",
      "productImage": "https://picsum.photos/100/100?random=66&keyword=charger",
      "timestamp": "2024-12-20T15:30:00",
      "price": 29.99,
    },
    {
      "id": 2,
      "userName": "Mike Chen",
      "userAvatar": "https://picsum.photos/60/60?random=67&keyword=man",
      "action": "purchased",
      "productName": "Gaming Headset",
      "productImage": "https://picsum.photos/100/100?random=68&keyword=headset",
      "timestamp": "2024-12-20T14:15:00",
      "price": 129.99,
      "discount": 25,
    },
    {
      "id": 3,
      "userName": "Emma Wilson",
      "userAvatar": "https://picsum.photos/60/60?random=69&keyword=woman",
      "action": "shared_deal",
      "productName": "Smart Fitness Watch",
      "productImage": "https://picsum.photos/100/100?random=70&keyword=smartwatch",
      "timestamp": "2024-12-20T13:45:00",
      "price": 199.99,
      "originalPrice": 249.99,
    },
    {
      "id": 4,
      "userName": "David Brown",
      "userAvatar": "https://picsum.photos/60/60?random=71&keyword=man",
      "action": "found_deal",
      "productName": "Coffee Machine",
      "productImage": "https://picsum.photos/100/100?random=72&keyword=coffee",
      "timestamp": "2024-12-20T12:30:00",
      "price": 89.99,
      "discount": 40,
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    return socialGroups.where((group) {
      bool matchesSearch = "${group["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${group["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedGroupType == "all" || 
                        (selectedGroupType == "joined" && (group["isJoined"] as bool)) ||
                        (selectedGroupType == "public" && group["type"] == "public") ||
                        (selectedGroupType == "private" && group["type"] == "private");
      return matchesSearch && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Social Wishlist"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateGroupDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search groups",
                          value: searchQuery,
                          hint: "Search by name or description",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Filter Groups",
                    items: [
                      {"label": "All Groups", "value": "all"},
                      {"label": "Joined Groups", "value": "joined"},
                      {"label": "Public Groups", "value": "public"},
                      {"label": "Private Groups", "value": "private"},
                    ],
                    value: selectedGroupType,
                    onChanged: (value, label) {
                      selectedGroupType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Social Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  _buildSocialStatCard(
                    "Groups Joined",
                    "${socialGroups.where((g) => g["isJoined"] as bool).length}",
                    Icons.group,
                  ),
                  _buildSocialStatCard(
                    "Friends Connected",
                    "24",
                    Icons.people,
                  ),
                  _buildSocialStatCard(
                    "Deals Shared",
                    "18",
                    Icons.share,
                  ),
                  _buildSocialStatCard(
                    "Total Followers",
                    "156",
                    Icons.favorite,
                  ),
                ],
              ),
            ),

            // Recent Friend Activity
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Friend Activity",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "See what your friends are up to",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.refresh,
                        size: bs.sm,
                        onPressed: () {
                          ss("Activity feed refreshed");
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Container(
                    height: 250,
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: spSm,
                        children: friendActivity.map((activity) {
                          return _buildActivityItem(activity);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Groups Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Wishlist Groups",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${filteredGroups.length} groups",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  if (filteredGroups.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.group,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No groups found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: filteredGroups.map((group) {
                        return _buildGroupCard(group);
                      }).toList(),
                    ),
                ],
              ),
            ),

            // Trending Topics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trending Topics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: [
                      "#BlackFriday",
                      "#TechDeals",
                      "#FashionSale",
                      "#HomeDeco",
                      "#BookLovers",
                      "#GamingGear",
                    ].map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    String actionText = _getActionText(activity["action"] as String);
    Color actionColor = _getActionColor(activity["action"] as String);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("${activity["userAvatar"]}"),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${activity["userName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: actionColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        actionText,
                        style: TextStyle(
                          fontSize: 10,
                          color: actionColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "${activity["productName"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                
                if (activity["discount"] != null)
                  Text(
                    "${activity["discount"]}% off - \$${(activity["price"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  Text(
                    "\$${(activity["price"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${activity["productImage"]}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    bool isJoined = group["isJoined"] as bool;
    bool isAdmin = group["isAdmin"] as bool;
    bool isPrivate = group["type"] == "private";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isJoined ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${group["image"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isPrivate)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    if (isAdmin)
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.admin_panel_settings,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group Info
                Text(
                  "${group["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${group["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Stats
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${group["memberCount"]} members",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${group["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (isJoined && (group["recentPosts"] as List).isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent Post:",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(group["recentPosts"] as List)[0]["content"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                
                SizedBox(height: spSm),
                
                // Action Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isJoined ? "View Group" : (isPrivate ? "Request to Join" : "Join Group"),
                    size: bs.sm,
                    onPressed: () {
                      if (isJoined) {
                        ss("Opening group: ${group["name"]}");
                      } else {
                        if (!isPrivate) {
                          group["isJoined"] = true;
                          setState(() {});
                          ss("Joined ${group["name"]}");
                        } else {
                          ss("Request sent to join ${group["name"]}");
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getActionText(String action) {
    switch (action) {
      case "added_to_wishlist":
        return "WISHED";
      case "purchased":
        return "BOUGHT";
      case "shared_deal":
        return "SHARED";
      case "found_deal":
        return "FOUND";
      default:
        return "ACTIVITY";
    }
  }

  Color _getActionColor(String action) {
    switch (action) {
      case "added_to_wishlist":
        return primaryColor;
      case "purchased":
        return successColor;
      case "shared_deal":
        return infoColor;
      case "found_deal":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showCreateGroupDialog() {
    String name = "";
    String description = "";
    String category = "Electronics";
    bool isPrivate = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Create New Group"),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Group Name",
                      value: name,
                      hint: "Enter group name",
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe your group",
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: [
                        {"label": "Electronics", "value": "Electronics"},
                        {"label": "Fashion", "value": "Fashion"},
                        {"label": "Home", "value": "Home"},
                        {"label": "Books", "value": "Books"},
                        {"label": "Beauty", "value": "Beauty"},
                        {"label": "Sports", "value": "Sports"},
                      ],
                      value: category,
                      onChanged: (value, label) {
                        category = value;
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Make this group private",
                          "value": true,
                          "checked": isPrivate,
                        }
                      ],
                      value: [
                        if (isPrivate)
                          {
                            "label": "Make this group private",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isPrivate = values.isNotEmpty;
                        setDialogState(() {});
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                QButton(
                  label: "Create Group",
                  size: bs.sm,
                  onPressed: () {
                    if (name.isNotEmpty && description.isNotEmpty) {
                      Navigator.pop(context);
                      ss("Group '$name' created successfully");
                    } else {
                      se("Please fill in all fields");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
