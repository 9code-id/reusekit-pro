import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaCommunityView extends StatefulWidget {
  const MhaCommunityView({super.key});

  @override
  State<MhaCommunityView> createState() => _MhaCommunityViewState();
}

class _MhaCommunityViewState extends State<MhaCommunityView> {
  int selectedTabIndex = 0;
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> communityGroups = [
    {
      "name": "Diabetes Support Group",
      "category": "Chronic Conditions",
      "members": 1247,
      "posts": 156,
      "description": "A supportive community for people living with diabetes and their families",
      "image": "https://picsum.photos/100/100?random=16&keyword=diabetes",
      "isJoined": true,
      "privacy": "public",
      "activity": "high",
      "moderators": 3,
      "lastActivity": "2 hours ago"
    },
    {
      "name": "Mental Health Warriors",
      "category": "Mental Health",
      "members": 2156,
      "posts": 289,
      "description": "Breaking stigma and supporting each other through mental health journeys",
      "image": "https://picsum.photos/100/100?random=17&keyword=mental-health",
      "isJoined": false,
      "privacy": "public",
      "activity": "high",
      "moderators": 5,
      "lastActivity": "1 hour ago"
    },
    {
      "name": "Cancer Survivors",
      "category": "Cancer Support",
      "members": 892,
      "posts": 234,
      "description": "Sharing strength, hope, and healing with fellow cancer survivors",
      "image": "https://picsum.photos/100/100?random=18&keyword=cancer-support",
      "isJoined": true,
      "privacy": "private",
      "activity": "medium",
      "moderators": 4,
      "lastActivity": "3 hours ago"
    },
    {
      "name": "Heart Health Heroes",
      "category": "Heart Disease",
      "members": 567,
      "posts": 123,
      "description": "Supporting cardiovascular health through lifestyle and medical management",
      "image": "https://picsum.photos/100/100?random=19&keyword=heart-health",
      "isJoined": false,
      "privacy": "public",
      "activity": "medium",
      "moderators": 2,
      "lastActivity": "5 hours ago"
    },
    {
      "name": "New Parents Network",
      "category": "Parenting",
      "members": 1834,
      "posts": 567,
      "description": "First-time parents sharing experiences and seeking advice",
      "image": "https://picsum.photos/100/100?random=20&keyword=parenting",
      "isJoined": true,
      "privacy": "public",
      "activity": "high",
      "moderators": 6,
      "lastActivity": "30 minutes ago"
    }
  ];

  List<Map<String, dynamic>> recentPosts = [
    {
      "title": "Managing blood sugar during holidays",
      "author": "Sarah M.",
      "group": "Diabetes Support Group",
      "timeAgo": "2 hours ago",
      "replies": 23,
      "likes": 45,
      "content": "Has anyone found effective strategies for managing blood sugar levels during holiday celebrations? The social pressure and food choices can be overwhelming...",
      "category": "Question",
      "isFollowing": true
    },
    {
      "title": "Celebrating 1 year anxiety-free!",
      "author": "Mike R.",
      "group": "Mental Health Warriors",
      "timeAgo": "4 hours ago",
      "replies": 67,
      "likes": 156,
      "content": "Today marks one full year without a panic attack. I wanted to share my journey and thank this amazing community for the support...",
      "category": "Success Story",
      "isFollowing": false
    },
    {
      "title": "Chemo side effects - hair loss tips",
      "author": "Linda K.",
      "group": "Cancer Survivors",
      "timeAgo": "6 hours ago",
      "replies": 34,
      "likes": 78,
      "content": "Starting my third round of chemo next week. Looking for practical advice on dealing with hair loss and maintaining confidence...",
      "category": "Support",
      "isFollowing": true
    },
    {
      "title": "Heart-healthy meal prep ideas",
      "author": "David L.",
      "group": "Heart Health Heroes",
      "timeAgo": "8 hours ago",
      "replies": 19,
      "likes": 42,
      "content": "Sharing my weekly meal prep routine focused on heart-healthy recipes. Batch cooking has been a game-changer for my diet...",
      "category": "Tips",
      "isFollowing": false
    },
    {
      "title": "Sleep training success story",
      "author": "Emma W.",
      "group": "New Parents Network",
      "timeAgo": "12 hours ago",
      "replies": 89,
      "likes": 234,
      "content": "After 6 months of sleep deprivation, we finally found a method that worked for our baby. Here's what we learned...",
      "category": "Success Story",
      "isFollowing": true
    }
  ];

  List<Map<String, dynamic>> events = [
    {
      "title": "Virtual Diabetes Education Workshop",
      "date": "Jan 15, 2025",
      "time": "2:00 PM EST",
      "type": "Online",
      "group": "Diabetes Support Group",
      "attendees": 45,
      "maxAttendees": 100,
      "description": "Learn about latest diabetes management techniques and technologies",
      "isRegistered": true
    },
    {
      "title": "Mental Health Awareness Walk",
      "date": "Jan 20, 2025",
      "time": "10:00 AM",
      "type": "In-Person",
      "location": "Central Park, NYC",
      "group": "Mental Health Warriors",
      "attendees": 156,
      "maxAttendees": 500,
      "description": "Join us for a community walk to raise awareness about mental health",
      "isRegistered": false
    },
    {
      "title": "Nutrition Webinar for Cancer Patients",
      "date": "Jan 25, 2025",
      "time": "7:00 PM EST",
      "type": "Online",
      "group": "Cancer Survivors",
      "attendees": 23,
      "maxAttendees": 50,
      "description": "Expert-led session on nutrition during and after cancer treatment",
      "isRegistered": true
    }
  ];

  List<Map<String, dynamic>> get filteredGroups {
    return communityGroups.where((group) {
      final matchesSearch = searchQuery.isEmpty ||
          (group["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (group["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory == "All" ||
          (group["category"] as String) == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Community"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _showProfile,
          ),
        ],
      ),
      body: Column(
        children: [
          // Community Stats Header
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "2.3K+",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Members",
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
                  height: 40,
                  color: disabledBoldColor.withAlpha(50),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "1.8K+",
                        style: TextStyle(
                          fontSize: 24,
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
                Container(
                  width: 1,
                  height: 40,
                  color: disabledBoldColor.withAlpha(50),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Groups Joined",
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

          // Tab Selection
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton("Groups", 0),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildTabButton("Feed", 1),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildTabButton("Events", 2),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Content based on selected tab
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPost,
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        selectedTabIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledBoldColor,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildGroupsTab();
      case 1:
        return _buildFeedTab();
      case 2:
        return _buildEventsTab();
      default:
        return _buildGroupsTab();
    }
  }

  Widget _buildGroupsTab() {
    return Column(
      children: [
        // Search and Filter
        Container(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search groups...",
                      value: searchQuery,
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
              SizedBox(height: spSm),
              QDropdownField(
                label: "Category",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Chronic Conditions", "value": "Chronic Conditions"},
                  {"label": "Mental Health", "value": "Mental Health"},
                  {"label": "Cancer Support", "value": "Cancer Support"},
                  {"label": "Heart Disease", "value": "Heart Disease"},
                  {"label": "Parenting", "value": "Parenting"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Groups List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredGroups.length,
            itemBuilder: (context, index) {
              final group = filteredGroups[index];
              final isJoined = group["isJoined"] as bool;
              final privacy = group["privacy"] as String;
              final activity = group["activity"] as String;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${group["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${group["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        privacy == "private" 
                                            ? Icons.lock 
                                            : Icons.public,
                                        size: 16,
                                        color: privacy == "private" 
                                            ? warningColor 
                                            : successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _getActivityColor(activity),
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${group["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${group["members"]} members",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.forum,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${group["posts"]} posts",
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
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${group["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "Last activity: ${group["lastActivity"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${group["moderators"]} moderators",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Group",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to group detail
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: isJoined ? "Leave" : "Join",
                            size: bs.sm,
                            onPressed: () {
                              _toggleGroupMembership(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeedTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: recentPosts.length,
      itemBuilder: (context, index) {
        final post = recentPosts[index];
        final category = post["category"] as String;
        final isFollowing = post["isFollowing"] as bool;
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 20,
                    ),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: spXs / 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(category).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getCategoryColor(category),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${post["group"]} • ${post["timeAgo"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFollowing ? Icons.notifications : Icons.notifications_none,
                      size: 20,
                      color: isFollowing ? primaryColor : disabledBoldColor,
                    ),
                    onPressed: () {
                      _togglePostFollow(index);
                    },
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "${post["title"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spXs),
              
              Text(
                "${post["content"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${post["likes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Icon(
                    Icons.comment,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${post["replies"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Read More",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to full post
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventsTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isRegistered = event["isRegistered"] as bool;
        final attendees = event["attendees"] as int;
        final maxAttendees = event["maxAttendees"] as int;
        final type = event["type"] as String;
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: type == "Online" 
                          ? infoColor.withAlpha(20)
                          : successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      type == "Online" 
                          ? Icons.video_call
                          : Icons.location_on,
                      color: type == "Online" 
                          ? infoColor
                          : successColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${event["date"]} at ${event["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["group"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: spXs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: type == "Online" 
                          ? infoColor.withAlpha(20)
                          : successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 10,
                        color: type == "Online" ? infoColor : successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "${event["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              
              if (event["location"] != null) ...[
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "$attendees of $maxAttendees attending",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  if (isRegistered)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: spXs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Registered",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              LinearProgressIndicator(
                value: attendees / maxAttendees,
                backgroundColor: disabledBoldColor.withAlpha(20),
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to event detail
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: isRegistered ? "Cancel" : "Register",
                      size: bs.sm,
                      onPressed: () {
                        _toggleEventRegistration(index);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getActivityColor(String activity) {
    switch (activity) {
      case "high":
        return successColor;
      case "medium":
        return warningColor;
      case "low":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Question":
        return infoColor;
      case "Success Story":
        return successColor;
      case "Support":
        return warningColor;
      case "Tips":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _toggleGroupMembership(int index) {
    final group = filteredGroups[index];
    final isJoined = group["isJoined"] as bool;
    
    setState(() {
      group["isJoined"] = !isJoined;
      if (!isJoined) {
        group["members"] = (group["members"] as int) + 1;
      } else {
        group["members"] = (group["members"] as int) - 1;
      }
    });
    
    ss(isJoined ? "Left group successfully" : "Joined group successfully");
  }

  void _togglePostFollow(int index) {
    setState(() {
      recentPosts[index]["isFollowing"] = !(recentPosts[index]["isFollowing"] as bool);
    });
    
    ss(recentPosts[index]["isFollowing"] as bool 
        ? "Following post updates" 
        : "Unfollowed post");
  }

  void _toggleEventRegistration(int index) {
    final event = events[index];
    final isRegistered = event["isRegistered"] as bool;
    
    setState(() {
      event["isRegistered"] = !isRegistered;
      if (!isRegistered) {
        event["attendees"] = (event["attendees"] as int) + 1;
      } else {
        event["attendees"] = (event["attendees"] as int) - 1;
      }
    });
    
    ss(isRegistered ? "Registration cancelled" : "Successfully registered for event");
  }

  void _createPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create New Post",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Post Title",
              value: "",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Select Group",
              items: communityGroups
                  .where((group) => group["isJoined"] as bool)
                  .map((group) => {
                        "label": "${group["name"]}",
                        "value": "${group["name"]}",
                      })
                  .toList(),
              value: "",
              onChanged: (value, label) {},
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Content",
              value: "",
              onChanged: (value) {},
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Post",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Post created successfully!");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "• New comment on your post\n• Diabetes Support Group event reminder\n• Weekly community digest available\n• New member joined Heart Health Heroes",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfile() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Community Profile",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.person,
                    color: primaryColor,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Community Stats",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "12 groups joined\n23 posts made\n156 helpful reactions",
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
            SizedBox(height: spMd),
            QButton(
              label: "Edit Profile",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                // Navigate to profile edit
              },
            ),
          ],
        ),
      ),
    );
  }
}
