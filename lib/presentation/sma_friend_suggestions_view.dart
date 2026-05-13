import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFriendSuggestionsView extends StatefulWidget {
  const SmaFriendSuggestionsView({super.key});

  @override
  State<SmaFriendSuggestionsView> createState() => _SmaFriendSuggestionsViewState();
}

class _SmaFriendSuggestionsViewState extends State<SmaFriendSuggestionsView> {
  String searchQuery = "";
  
  List<Map<String, dynamic>> friendSuggestions = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "profile_image": "https://picsum.photos/100/100?random=1&keyword=woman",
      "mutual_friends": 5,
      "location": "New York, NY",
      "work": "Software Engineer at Google",
      "education": "MIT Computer Science",
      "common_interests": ["Technology", "Travel", "Photography"],
      "mutual_friends_names": ["Alex Chen", "Maria Rodriguez", "David Kim"],
      "is_sent": false,
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "profile_image": "https://picsum.photos/100/100?random=2&keyword=man",
      "mutual_friends": 8,
      "location": "San Francisco, CA",
      "work": "Product Manager at Meta",
      "education": "Stanford Business School",
      "common_interests": ["Startup", "Design", "Music"],
      "mutual_friends_names": ["Jennifer Lee", "Robert Smith", "Lisa Wang"],
      "is_sent": false,
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "profile_image": "https://picsum.photos/100/100?random=3&keyword=woman",
      "mutual_friends": 12,
      "location": "Los Angeles, CA",
      "work": "UX Designer at Apple",
      "education": "UCLA Design",
      "common_interests": ["Art", "Fitness", "Cooking"],
      "mutual_friends_names": ["Carlos Martinez", "Amy Johnson", "Mike Davis"],
      "is_sent": false,
    },
    {
      "id": 4,
      "name": "James Wilson",
      "profile_image": "https://picsum.photos/100/100?random=4&keyword=man",
      "mutual_friends": 3,
      "location": "Seattle, WA",
      "work": "Data Scientist at Amazon",
      "education": "University of Washington",
      "common_interests": ["Data", "Gaming", "Hiking"],
      "mutual_friends_names": ["Tom Brown", "Sarah Lee", "Nick Wilson"],
      "is_sent": false,
    },
    {
      "id": 5,
      "name": "Jessica Liu",
      "profile_image": "https://picsum.photos/100/100?random=5&keyword=woman",
      "mutual_friends": 7,
      "location": "Boston, MA",
      "work": "Marketing Director at HubSpot",
      "education": "Harvard Business School",
      "common_interests": ["Marketing", "Books", "Yoga"],
      "mutual_friends_names": ["Kevin Zhang", "Sophie Turner", "Mark Johnson"],
      "is_sent": true,
    },
    {
      "id": 6,
      "name": "Daniel Garcia",
      "profile_image": "https://picsum.photos/100/100?random=6&keyword=man",
      "mutual_friends": 9,
      "location": "Austin, TX",
      "work": "Full Stack Developer at Dell",
      "education": "UT Austin Computer Science",
      "common_interests": ["Programming", "Music", "Sports"],
      "mutual_friends_names": ["Anna Kim", "Chris Brown", "Maya Patel"],
      "is_sent": false,
    },
  ];
  
  List<Map<String, dynamic>> get filteredSuggestions {
    if (searchQuery.isEmpty) return friendSuggestions;
    return friendSuggestions.where((suggestion) =>
      (suggestion["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (suggestion["work"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (suggestion["location"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  void _sendFriendRequest(int id) {
    setState(() {
      final index = friendSuggestions.indexWhere((suggestion) => suggestion["id"] == id);
      if (index != -1) {
        friendSuggestions[index]["is_sent"] = true;
      }
    });
    ss("Friend request sent successfully!");
  }

  void _removeSuggestion(int id) {
    setState(() {
      friendSuggestions.removeWhere((suggestion) => suggestion["id"] == id);
    });
    si("Suggestion removed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Suggestions"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              // Show filter options
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
              label: "Search suggestions",
              value: searchQuery,
              hint: "Search by name, work, or location",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            // Suggestions Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    "People You May Know",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${filteredSuggestions.length} suggestions",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            // Friend Suggestions List
            ...filteredSuggestions.map((suggestion) {
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
                        // Profile Image
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${suggestion["profile_image"]}"),
                        ),
                        SizedBox(width: spSm),
                        
                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${suggestion["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if ((suggestion["work"] as String).isNotEmpty)
                                Text(
                                  "${suggestion["work"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              Text(
                                "${suggestion["location"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // More Options
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: disabledBoldColor),
                          onSelected: (value) {
                            if (value == 'remove') {
                              _removeSuggestion(suggestion["id"] as int);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'remove',
                              child: Row(
                                children: [
                                  Icon(Icons.remove_circle_outline, color: dangerColor),
                                  SizedBox(width: spXs),
                                  Text("Remove suggestion"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Mutual Friends
                    if ((suggestion["mutual_friends"] as int) > 0)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${suggestion["mutual_friends"]} mutual friends",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    // Common Interests
                    if ((suggestion["common_interests"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (suggestion["common_interests"] as List).map((interest) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$interest",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: suggestion["is_sent"] as bool
                              ? QButton(
                                  label: "Request Sent",
                                  icon: Icons.check,
                                  color: successColor,
                                  size: bs.sm,
                                  onPressed: () {},
                                )
                              : QButton(
                                  label: "Add Friend",
                                  icon: Icons.person_add,
                                  size: bs.sm,
                                  onPressed: () => _sendFriendRequest(suggestion["id"] as int),
                                ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "View Profile",
                          icon: Icons.visibility,
                          color: secondaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to profile
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Load More Button
            if (filteredSuggestions.length >= 6)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Suggestions",
                  icon: Icons.refresh,
                  color: secondaryColor,
                  size: bs.md,
                  onPressed: () {
                    // Load more suggestions
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
