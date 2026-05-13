import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAnnouncementBoardView extends StatefulWidget {
  const HhaAnnouncementBoardView({super.key});

  @override
  State<HhaAnnouncementBoardView> createState() => _HhaAnnouncementBoardViewState();
}

class _HhaAnnouncementBoardViewState extends State<HhaAnnouncementBoardView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {
      "label": "All Categories",
      "value": "All",
    },
    {
      "label": "General",
      "value": "general",
    },
    {
      "label": "Policy Updates",
      "value": "policy",
    },
    {
      "label": "Training & Events",
      "value": "training",
    },
    {
      "label": "Safety Alerts",
      "value": "safety",
    },
    {
      "label": "Maintenance Notices",
      "value": "maintenance",
    },
    {
      "label": "Holiday & Schedule",
      "value": "schedule",
    },
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {
      "label": "All Priority",
      "value": "All",
    },
    {
      "label": "Critical",
      "value": "critical",
    },
    {
      "label": "High",
      "value": "high",
    },
    {
      "label": "Normal",
      "value": "normal",
    },
    {
      "label": "Low",
      "value": "low",
    },
  ];

  List<Map<String, dynamic>> announcements = [
    {
      "id": "ANN001",
      "title": "Emergency: Fire Safety Drill Tomorrow",
      "content": "Mandatory fire safety drill will be conducted tomorrow at 2:00 PM. All staff must participate. Guest notification protocols are in effect. Please ensure all guests are informed 1 hour before the drill begins.",
      "category": "safety",
      "priority": "critical",
      "author": "John Wilson",
      "author_role": "Safety Coordinator",
      "created_at": "2024-12-15T08:00:00",
      "expires_at": "2024-12-20T23:59:59",
      "is_pinned": true,
      "views": 45,
      "likes": 12,
      "comments": 8,
      "image": "https://picsum.photos/600/300?random=1&keyword=safety",
      "attachments": [
        {
          "name": "fire_drill_procedures.pdf",
          "type": "document",
          "size": "1.2 MB",
          "url": "#"
        }
      ]
    },
    {
      "id": "ANN002", 
      "title": "New Guest Check-in Procedures Effective Immediately",
      "content": "Updated check-in procedures are now in effect. All front desk staff must verify guest identification, confirm reservation details, and collect contact information before issuing room keys. Please see attached document for complete procedures.",
      "category": "policy",
      "priority": "high",
      "author": "Maria Santos",
      "author_role": "Front Office Manager",
      "created_at": "2024-12-14T15:30:00",
      "expires_at": "2024-12-30T23:59:59",
      "is_pinned": true,
      "views": 38,
      "likes": 15,
      "comments": 5,
      "image": null,
      "attachments": [
        {
          "name": "check_in_procedures_v2.pdf",
          "type": "document",
          "size": "850 KB",
          "url": "#"
        }
      ]
    },
    {
      "id": "ANN003",
      "title": "Holiday Work Schedule - December 2024",
      "content": "Holiday work schedules for December are now available. Overtime opportunities are available for those interested. Please contact HR to sign up for additional shifts. Thank you for your flexibility during the busy holiday season.",
      "category": "schedule",
      "priority": "normal",
      "author": "Sarah Johnson",
      "author_role": "HR Manager",
      "created_at": "2024-12-13T11:15:00",
      "expires_at": "2025-01-02T23:59:59",
      "is_pinned": false,
      "views": 52,
      "likes": 8,
      "comments": 12,
      "image": "https://picsum.photos/600/300?random=2&keyword=holiday",
      "attachments": [
        {
          "name": "december_schedule.xlsx",
          "type": "spreadsheet",
          "size": "125 KB",
          "url": "#"
        }
      ]
    },
    {
      "id": "ANN004",
      "title": "Customer Service Excellence Training Workshop",
      "content": "Join us for a comprehensive customer service training workshop designed to enhance guest satisfaction. All guest-facing staff are required to attend. Light refreshments will be provided.",
      "category": "training",
      "priority": "high",
      "author": "David Brown",
      "author_role": "Training Manager",
      "created_at": "2024-12-12T09:45:00",
      "expires_at": "2024-12-22T23:59:59",
      "is_pinned": false,
      "views": 31,
      "likes": 18,
      "comments": 6,
      "image": "https://picsum.photos/600/300?random=3&keyword=training",
      "attachments": []
    },
    {
      "id": "ANN005",
      "title": "Pool Area Maintenance - Temporary Closure",
      "content": "The pool area will be temporarily closed for maintenance from December 18-20. Please inform guests about the closure and direct them to nearby partner facilities if needed. Regular operations will resume on December 21st.",
      "category": "maintenance",
      "priority": "normal",
      "author": "Mike Rodriguez",
      "author_role": "Maintenance Supervisor",
      "created_at": "2024-12-11T14:20:00",
      "expires_at": "2024-12-21T23:59:59",
      "is_pinned": false,
      "views": 28,
      "likes": 5,
      "comments": 3,
      "image": "https://picsum.photos/600/300?random=4&keyword=pool",
      "attachments": [
        {
          "name": "partner_facilities_list.pdf",
          "type": "document", 
          "size": "245 KB",
          "url": "#"
        }
      ]
    },
    {
      "id": "ANN006",
      "title": "Team Building Event - January 2025",
      "content": "Save the date! Our annual team building event is scheduled for January 15, 2025. This year's theme is 'Unity in Service'. More details will follow soon. Looking forward to seeing everyone there!",
      "category": "general",
      "priority": "low",
      "author": "Lisa Chen",
      "author_role": "Event Coordinator",
      "created_at": "2024-12-10T16:30:00",
      "expires_at": "2025-01-16T23:59:59",
      "is_pinned": false,
      "views": 22,
      "likes": 25,
      "comments": 14,
      "image": "https://picsum.photos/600/300?random=5&keyword=team",
      "attachments": []
    },
  ];

  List<Map<String, dynamic>> get filteredAnnouncements {
    return announcements.where((ann) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${ann["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${ann["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${ann["author"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || ann["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || ann["priority"] == selectedPriority;
      
      return matchesSearch && matchesCategory && matchesPriority;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "normal":
        return infoColor;
      case "low":
        return successColor;  
      default:
        return disabledColor;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case "critical":
        return Icons.emergency;
      case "high":
        return Icons.priority_high;
      case "normal":
        return Icons.info;
      case "low":
        return Icons.info_outline;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement Board"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create announcement
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search announcements...",
                    value: searchQuery,
                    hint: "Search by title, content, or author",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
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
                          items: priorityOptions,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.campaign,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${announcements.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Announcements",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.push_pin,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${announcements.where((a) => a["is_pinned"] == true).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pinned",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((announcements.map((a) => a["views"] as int).reduce((a, b) => a + b)) / announcements.length).round()}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Avg. Views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${announcements.map((a) => a["likes"] as int).reduce((a, b) => a + b)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Likes",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Announcements List
            ...filteredAnnouncements.map((announcement) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: announcement["is_pinned"] == true
                      ? Border.all(color: warningColor, width: 2)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Header with Priority and Pin
                    Row(
                      children: [
                        if (announcement["is_pinned"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.push_pin,
                                  size: 12,
                                  color: warningColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "PINNED",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (announcement["is_pinned"] == true)
                          SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${announcement["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${announcement["priority"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getPriorityIcon("${announcement["priority"]}"),
                                size: 12,
                                color: _getPriorityColor("${announcement["priority"]}"),
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${announcement["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getPriorityColor("${announcement["priority"]}"),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Author Information
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: primaryColor.withAlpha(30),
                          child: Text(
                            "${announcement["author"]}".split(' ').map((name) => name[0]).join(''),
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${announcement["author"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${announcement["author_role"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateTime.parse("${announcement["created_at"]}").dMMMy,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Expires ${DateTime.parse("${announcement["expires_at"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Image if available
                    if (announcement["image"] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${announcement["image"]}",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),

                    // Content
                    Text(
                      "${announcement["content"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),

                    // Attachments
                    if ((announcement["attachments"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Attachments:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            ...(announcement["attachments"] as List).map((attachment) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.attach_file,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${attachment["name"]} (${attachment["size"]})",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  QButton(
                                    label: "Download",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Download attachment
                                    },
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                    // Engagement Stats and Actions
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${announcement["views"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${announcement["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.comment,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${announcement["comments"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.thumb_up,
                          size: bs.sm,
                          onPressed: () {
                            // Like announcement
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.comment,
                          size: bs.sm,
                          onPressed: () {
                            // View comments
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            // Share announcement
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
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

            if (filteredAnnouncements.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.campaign,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No announcements found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create announcement
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
