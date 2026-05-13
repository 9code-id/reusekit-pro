import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAnnouncementsView extends StatefulWidget {
  const ElaAnnouncementsView({super.key});

  @override
  State<ElaAnnouncementsView> createState() => _ElaAnnouncementsViewState();
}

class _ElaAnnouncementsViewState extends State<ElaAnnouncementsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriority = "All";
  bool showOnlyUnread = false;

  List<Map<String, dynamic>> announcements = [
    {
      "id": 1,
      "title": "Parent-Teacher Conference - March 25, 2024",
      "content": "We are pleased to invite all parents to our upcoming Parent-Teacher Conference on March 25, 2024, from 2:00 PM to 6:00 PM. This is an excellent opportunity to discuss your child's academic progress, address any concerns, and collaborate on strategies to support their learning journey. Please confirm your attendance by March 20th.",
      "author": "Principal Johnson",
      "date": "2024-03-15T10:00:00Z",
      "category": "Academic",
      "priority": "high",
      "isRead": false,
      "isPinned": true,
      "attachments": ["conference_schedule.pdf", "parking_map.pdf"],
      "views": 245,
      "likes": 32
    },
    {
      "id": 2,
      "title": "School Closure Due to Weather - March 16",
      "content": "Due to severe weather conditions and safety concerns, Eastwood Learning Academy will be closed on Friday, March 16, 2024. All classes, activities, and after-school programs are cancelled. School will resume normal operations on Monday, March 19th. Please stay safe and warm!",
      "author": "Emergency Alert System",
      "date": "2024-03-15T18:30:00Z",
      "category": "Emergency",
      "priority": "urgent",
      "isRead": false,
      "isPinned": true,
      "attachments": [],
      "views": 892,
      "likes": 156
    },
    {
      "id": 3,
      "title": "Science Fair 2024 - Call for Participation",
      "content": "The annual Eastwood Science Fair is scheduled for April 15, 2024. We encourage all students from grades 3-8 to participate and showcase their scientific creativity. Registration deadline is March 30th. Prizes will be awarded for outstanding projects in each grade category.",
      "author": "Science Department",
      "date": "2024-03-14T14:20:00Z",
      "category": "Events",
      "priority": "medium",
      "isRead": true,
      "isPinned": false,
      "attachments": ["science_fair_guidelines.pdf"],
      "views": 178,
      "likes": 24
    },
    {
      "id": 4,
      "title": "New Library Resources Available",
      "content": "We're excited to announce that our library has acquired new digital resources including access to National Geographic Kids, Brain POP, and Reading A-Z. Students can now access these educational platforms from home using their school credentials.",
      "author": "Library Staff",
      "date": "2024-03-13T11:15:00Z",
      "category": "Resources",
      "priority": "medium",
      "isRead": true,
      "isPinned": false,
      "attachments": ["digital_resources_guide.pdf"],
      "views": 134,
      "likes": 18
    },
    {
      "id": 5,
      "title": "Updated School Uniform Policy",
      "content": "Please note the updated school uniform policy effective April 1, 2024. New guidelines include approved colors for accessories and updated shoe requirements. Full details are available in the attached document.",
      "author": "Administration Office",
      "date": "2024-03-12T09:30:00Z",
      "category": "Policies",
      "priority": "medium",
      "isRead": false,
      "isPinned": false,
      "attachments": ["uniform_policy_2024.pdf"],
      "views": 267,
      "likes": 8
    },
    {
      "id": 6,
      "title": "Spring Break Schedule Reminder",
      "content": "Spring Break will be from March 25-29, 2024. School will be closed during this period. After-school care will not be available. Regular classes resume on April 1st. Have a wonderful break with your families!",
      "author": "Academic Office",
      "date": "2024-03-11T16:00:00Z",
      "category": "Schedule",
      "priority": "low",
      "isRead": true,
      "isPinned": false,
      "attachments": [],
      "views": 456,
      "likes": 67
    }
  ];

  List<Map<String, dynamic>> get filteredAnnouncements {
    var filtered = announcements.where((announcement) {
      bool matchesSearch = announcement["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          announcement["content"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || announcement["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || announcement["priority"] == selectedPriority;
      bool matchesReadStatus = !showOnlyUnread || !(announcement["isRead"] as bool);
      
      return matchesSearch && matchesCategory && matchesPriority && matchesReadStatus;
    }).toList();
    
    // Sort: pinned first, then by date (newest first)
    filtered.sort((a, b) {
      if ((a["isPinned"] as bool) && !(b["isPinned"] as bool)) return -1;
      if (!(a["isPinned"] as bool) && (b["isPinned"] as bool)) return 1;
      return DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"]));
    });
    
    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Emergency":
        return dangerColor;
      case "Academic":
        return primaryColor;
      case "Events":
        return successColor;
      case "Resources":
        return infoColor;
      case "Policies":
        return warningColor;
      case "Schedule":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School Announcements"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => _showNotificationSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search announcements...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.filter_list,
                        size: bs.sm,
                        onPressed: () => _showFilterDialog(),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": "All"},
                            {"label": "Emergency", "value": "Emergency"},
                            {"label": "Academic", "value": "Academic"},
                            {"label": "Events", "value": "Events"},
                            {"label": "Resources", "value": "Resources"},
                            {"label": "Policies", "value": "Policies"},
                            {"label": "Schedule", "value": "Schedule"},
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: [
                            {"label": "All Priorities", "value": "All"},
                            {"label": "Urgent", "value": "urgent"},
                            {"label": "High", "value": "high"},
                            {"label": "Medium", "value": "medium"},
                            {"label": "Low", "value": "low"},
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Show only unread announcements",
                        "value": true,
                        "checked": showOnlyUnread,
                      }
                    ],
                    value: [
                      if (showOnlyUnread)
                        {
                          "label": "Show only unread announcements",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOnlyUnread = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      "Total",
                      "${announcements.length}",
                      Icons.campaign,
                      primaryColor,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      "Unread",
                      "${announcements.where((a) => !(a["isRead"] as bool)).length}",
                      Icons.mark_email_unread,
                      warningColor,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      "Pinned",
                      "${announcements.where((a) => a["isPinned"] as bool).length}",
                      Icons.push_pin,
                      infoColor,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: primaryColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Stay informed with the latest school announcements and important updates",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  QButton(
                    label: "Mark All Read",
                    size: bs.sm,
                    onPressed: () => _markAllAsRead(),
                  ),
                ],
              ),
            ),

            // Announcements List
            ...filteredAnnouncements.map((announcement) => _buildAnnouncementCard(announcement)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _refreshAnnouncements(),
        backgroundColor: primaryColor,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    bool isUnread = !(announcement["isRead"] as bool);
    bool isPinned = announcement["isPinned"] as bool;
    DateTime date = DateTime.parse(announcement["date"]);
    List attachments = announcement["attachments"] as List;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isPinned 
            ? Border.all(color: warningColor.withAlpha(100), width: 2)
            : isUnread 
                ? Border.all(color: primaryColor.withAlpha(100), width: 1)
                : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusSm),
          onTap: () => _viewAnnouncementDetail(announcement),
          child: Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Header
                Row(
                  children: [
                    if (isPinned) ...[
                      Icon(Icons.push_pin, size: 16, color: warningColor),
                      SizedBox(width: spXs),
                    ],
                    Expanded(
                      child: Text(
                        "${announcement["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                
                // Content
                Text(
                  "${announcement["content"]}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                
                // Meta Information
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${announcement["author"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      date.dMMMy,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Tags and Attachments
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(announcement["category"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${announcement["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getCategoryColor(announcement["category"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(announcement["priority"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${announcement["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getPriorityColor(announcement["priority"]),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (attachments.isNotEmpty) ...[
                      Icon(Icons.attach_file, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${attachments.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
                
                // Engagement Stats
                Container(
                  padding: EdgeInsets.only(top: spXs),
                  child: Row(
                    children: [
                      Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${announcement["views"]} views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.thumb_up, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${announcement["likes"]} likes",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _toggleLike(announcement),
                        child: Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _shareAnnouncement(announcement),
                        child: Icon(
                          Icons.share,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    // Show advanced filter dialog
  }

  void _showNotificationSettings() {
    // Show notification preferences
  }

  void _markAllAsRead() async {
    bool isConfirmed = await confirm("Mark all announcements as read?");
    if (isConfirmed) {
      for (var announcement in announcements) {
        announcement["isRead"] = true;
      }
      setState(() {});
      ss("All announcements marked as read");
    }
  }

  void _refreshAnnouncements() {
    // Refresh announcements from server
    ss("Announcements refreshed");
  }

  void _viewAnnouncementDetail(Map<String, dynamic> announcement) {
    announcement["isRead"] = true;
    setState(() {});
    // Navigate to announcement detail
  }

  void _toggleLike(Map<String, dynamic> announcement) {
    int currentLikes = announcement["likes"] as int;
    announcement["likes"] = currentLikes + 1;
    setState(() {});
  }

  void _shareAnnouncement(Map<String, dynamic> announcement) {
    // Share announcement functionality
    ss("Announcement shared");
  }
}
