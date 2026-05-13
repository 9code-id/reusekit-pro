import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaMutualFriendsView extends StatefulWidget {
  const SmaMutualFriendsView({super.key});

  @override
  State<SmaMutualFriendsView> createState() => _SmaMutualFriendsViewState();
}

class _SmaMutualFriendsViewState extends State<SmaMutualFriendsView> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> mutualFriends = [
    {
      "id": 1,
      "name": "Alex Chen",
      "profile_image": "https://picsum.photos/100/100?random=1&keyword=man",
      "mutual_with": "Sarah Johnson",
      "common_friends_count": 15,
      "relationship": "close_friend",
      "last_interaction": "2 hours ago",
      "location": "San Francisco, CA",
      "work": "Senior Developer at Google",
      "connection_strength": 0.9,
      "shared_groups": ["Tech Enthusiasts", "SF Developers"],
      "shared_interests": ["Programming", "AI", "Travel"],
    },
    {
      "id": 2,
      "name": "Maria Rodriguez",
      "profile_image": "https://picsum.photos/100/100?random=2&keyword=woman",
      "mutual_with": "Michael Chen",
      "common_friends_count": 8,
      "relationship": "colleague",
      "last_interaction": "1 day ago",
      "location": "Los Angeles, CA",
      "work": "Product Manager at Meta",
      "connection_strength": 0.7,
      "shared_groups": ["Product Managers", "Women in Tech"],
      "shared_interests": ["Design", "Leadership", "Fitness"],
    },
    {
      "id": 3,
      "name": "David Kim",
      "profile_image": "https://picsum.photos/100/100?random=3&keyword=man",
      "mutual_with": "Emily Rodriguez",
      "common_friends_count": 12,
      "relationship": "family_friend",
      "last_interaction": "3 days ago",
      "location": "Seattle, WA",
      "work": "UX Designer at Amazon",
      "connection_strength": 0.8,
      "shared_groups": ["Design Community", "Seattle Friends"],
      "shared_interests": ["Design", "Photography", "Gaming"],
    },
    {
      "id": 4,
      "name": "Jennifer Lee",
      "profile_image": "https://picsum.photos/100/100?random=4&keyword=woman",
      "mutual_with": "James Wilson",
      "common_friends_count": 6,
      "relationship": "acquaintance",
      "last_interaction": "1 week ago",
      "location": "Boston, MA",
      "work": "Data Scientist at MIT",
      "connection_strength": 0.5,
      "shared_groups": ["Data Science", "MIT Alumni"],
      "shared_interests": ["Data", "Research", "Books"],
    },
    {
      "id": 5,
      "name": "Robert Smith",
      "profile_image": "https://picsum.photos/100/100?random=5&keyword=man",
      "mutual_with": "Jessica Liu",
      "common_friends_count": 20,
      "relationship": "close_friend",
      "last_interaction": "30 minutes ago",
      "location": "New York, NY",
      "work": "Marketing Director at Apple",
      "connection_strength": 0.95,
      "shared_groups": ["NY Marketing", "College Friends"],
      "shared_interests": ["Marketing", "Sports", "Music"],
    },
    {
      "id": 6,
      "name": "Lisa Wang",
      "profile_image": "https://picsum.photos/100/100?random=6&keyword=woman",
      "mutual_with": "Daniel Garcia",
      "common_friends_count": 9,
      "relationship": "colleague",
      "last_interaction": "5 days ago",
      "location": "Austin, TX",
      "work": "Software Engineer at Dell",
      "connection_strength": 0.6,
      "shared_groups": ["Austin Tech", "Women Engineers"],
      "shared_interests": ["Coding", "Hiking", "Food"],
    },
  ];

  List<String> filterOptions = ["All", "Close Friends", "Colleagues", "Family Friends", "Acquaintances"];
  
  List<Map<String, dynamic>> get filteredFriends {
    var filtered = mutualFriends;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((friend) =>
        (friend["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (friend["mutual_with"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (friend["work"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    if (selectedFilter != "All") {
      String filterValue = selectedFilter.toLowerCase().replaceAll(" ", "_");
      filtered = filtered.where((friend) =>
        (friend["relationship"] as String) == filterValue
      ).toList();
    }
    
    return filtered;
  }

  Color _getRelationshipColor(String relationship) {
    switch (relationship) {
      case "close_friend":
        return successColor;
      case "colleague":
        return primaryColor;
      case "family_friend":
        return warningColor;
      case "acquaintance":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getRelationshipLabel(String relationship) {
    return relationship.split("_").map((word) => 
      word[0].toUpperCase() + word.substring(1)
    ).join(" ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mutual Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Show sort options
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search mutual friends",
                    value: searchQuery,
                    hint: "Search by name or connection",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredFriends.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Mutual Friends",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${mutualFriends.where((f) => f["relationship"] == "close_friend").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Close Friends",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Mutual Friends List
            ...filteredFriends.map((friend) {
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
                        // Profile Image with Connection Strength Indicator
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage("${friend["profile_image"]}"),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: _getRelationshipColor(friend["relationship"] as String),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        
                        // Friend Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${friend["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Mutual with ${friend["mutual_with"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${friend["work"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Connection Strength
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getRelationshipColor(friend["relationship"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getRelationshipLabel(friend["relationship"] as String),
                            style: TextStyle(
                              fontSize: 11,
                              color: _getRelationshipColor(friend["relationship"] as String),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.group,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${friend["common_friends_count"]} common",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Active ${friend["last_interaction"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // Shared Groups
                    if ((friend["shared_groups"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (friend["shared_groups"] as List).take(2).map((group) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$group",
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
                            label: "View Profile",
                            icon: Icons.person,
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to profile
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Message",
                          icon: Icons.message,
                          color: successColor,
                          size: bs.sm,
                          onPressed: () {
                            // Open chat
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          color: secondaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // Show more options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Load More
            if (filteredFriends.length >= 6)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Friends",
                  icon: Icons.refresh,
                  color: secondaryColor,
                  size: bs.md,
                  onPressed: () {
                    // Load more mutual friends
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
