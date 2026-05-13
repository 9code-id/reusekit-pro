import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaAnnouncementView extends StatefulWidget {
  const PmaAnnouncementView({super.key});

  @override
  State<PmaAnnouncementView> createState() => _PmaAnnouncementViewState();
}

class _PmaAnnouncementViewState extends State<PmaAnnouncementView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedPriority = "all";
  String selectedStatus = "all";
  String selectedSort = "newest";
  bool isCreatingAnnouncement = false;

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "General", "value": "general"},
    {"label": "Company News", "value": "company"},
    {"label": "Project Updates", "value": "project"},
    {"label": "Policy Changes", "value": "policy"},
    {"label": "Events", "value": "events"},
    {"label": "System Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Expired", "value": "expired"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Most Views", "value": "views"},
    {"label": "Priority", "value": "priority"},
  ];

  List<Map<String, dynamic>> announcements = [
    {
      "id": "1",
      "title": "Company All-Hands Meeting - Q1 2024 Results",
      "content": "Join us for our quarterly all-hands meeting where we'll discuss Q1 achievements, upcoming projects, and team recognitions. Light refreshments will be provided.",
      "category": "company",
      "priority": "high",
      "status": "active",
      "author": "CEO Office",
      "authorRole": "Executive Team",
      "publishDate": "2024-01-15 09:00:00",
      "expiryDate": "2024-02-15 18:00:00",
      "viewCount": 342,
      "likeCount": 45,
      "commentCount": 12,
      "isSticky": true,
      "tags": ["meeting", "quarterly", "results"],
      "attachments": [
        {"name": "Q1_Results_Presentation.pdf", "size": "2.4 MB", "type": "pdf"},
        {"name": "Meeting_Agenda.docx", "size": "156 KB", "type": "doc"},
      ],
      "targetAudience": "All Employees",
      "departments": ["All"],
    },
    {
      "id": "2",
      "title": "New Project Management Guidelines",
      "content": "We're implementing new project management guidelines to improve efficiency and collaboration. Please review the attached documentation and attend the upcoming training sessions.",
      "category": "policy",
      "priority": "high",
      "status": "active",
      "author": "Project Management Office",
      "authorRole": "PMO Team",
      "publishDate": "2024-01-14 14:30:00",
      "expiryDate": "2024-03-01 18:00:00",
      "viewCount": 198,
      "likeCount": 28,
      "commentCount": 8,
      "isSticky": true,
      "tags": ["guidelines", "training", "process"],
      "attachments": [
        {"name": "PM_Guidelines_v2.0.pdf", "size": "1.8 MB", "type": "pdf"},
      ],
      "targetAudience": "Project Teams",
      "departments": ["Development", "Design", "QA"],
    },
    {
      "id": "3",
      "title": "System Maintenance - Weekend Downtime",
      "content": "Scheduled system maintenance will occur this weekend from Saturday 10 PM to Sunday 6 AM. All services will be temporarily unavailable during this period.",
      "category": "maintenance",
      "priority": "medium",
      "status": "scheduled",
      "author": "IT Operations",
      "authorRole": "System Admin",
      "publishDate": "2024-01-13 16:45:00",
      "expiryDate": "2024-01-21 06:00:00",
      "viewCount": 156,
      "likeCount": 12,
      "commentCount": 3,
      "isSticky": false,
      "tags": ["maintenance", "downtime", "weekend"],
      "attachments": [],
      "targetAudience": "All Users",
      "departments": ["All"],
    },
    {
      "id": "4",
      "title": "Team Building Event - Spring Retreat",
      "content": "Join us for our annual spring team building retreat! Activities include workshops, outdoor games, and networking sessions. Registration is now open.",
      "category": "events",
      "priority": "low",
      "status": "active",
      "author": "HR Department",
      "authorRole": "Human Resources",
      "publishDate": "2024-01-12 11:20:00",
      "expiryDate": "2024-04-01 18:00:00",
      "viewCount": 289,
      "likeCount": 67,
      "commentCount": 23,
      "isSticky": false,
      "tags": ["team building", "retreat", "registration"],
      "attachments": [
        {"name": "Retreat_Information.pdf", "size": "943 KB", "type": "pdf"},
        {"name": "Registration_Form.xlsx", "size": "67 KB", "type": "excel"},
      ],
      "targetAudience": "All Employees",
      "departments": ["All"],
    },
    {
      "id": "5",
      "title": "Mobile App V2.0 Launch Success",
      "content": "Congratulations to the mobile development team! The V2.0 app launch exceeded all expectations with 50K downloads in the first week.",
      "category": "project",
      "priority": "medium",
      "status": "active",
      "author": "Product Manager",
      "authorRole": "Product Team",
      "publishDate": "2024-01-11 13:15:00",
      "expiryDate": "2024-02-11 18:00:00",
      "viewCount": 234,
      "likeCount": 89,
      "commentCount": 17,
      "isSticky": false,
      "tags": ["launch", "success", "mobile app"],
      "attachments": [
        {"name": "Launch_Metrics.pdf", "size": "1.2 MB", "type": "pdf"},
      ],
      "targetAudience": "Development Team",
      "departments": ["Development", "Product", "Marketing"],
    },
    {
      "id": "6",
      "title": "New Employee Onboarding Process",
      "content": "We've updated our employee onboarding process to provide better orientation and faster integration for new team members.",
      "category": "general",
      "priority": "low",
      "status": "draft",
      "author": "HR Department",
      "authorRole": "Human Resources",
      "publishDate": "2024-01-10 10:30:00",
      "expiryDate": "2024-03-15 18:00:00",
      "viewCount": 87,
      "likeCount": 15,
      "commentCount": 4,
      "isSticky": false,
      "tags": ["onboarding", "process", "new employees"],
      "attachments": [],
      "targetAudience": "HR Team",
      "departments": ["HR", "Management"],
    },
  ];

  List<Map<String, dynamic>> announcementStats = [
    {
      "title": "Total Announcements",
      "value": 24,
      "icon": Icons.campaign,
      "color": primaryColor,
    },
    {
      "title": "Active",
      "value": 18,
      "icon": Icons.visibility,
      "color": successColor,
    },
    {
      "title": "Total Views",
      "value": 1247,
      "icon": Icons.remove_red_eye,
      "color": infoColor,
    },
    {
      "title": "Engagement Rate",
      "value": 78,
      "icon": Icons.thumb_up,
      "color": warningColor,
      "suffix": "%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcements"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateAnnouncementDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsSection(),
            SizedBox(height: spMd),
            _buildSearchAndFilters(),
            SizedBox(height: spMd),
            _buildQuickActions(),
            SizedBox(height: spMd),
            _buildAnnouncementsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Announcement Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: announcementStats.map((stat) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${stat["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (stat.containsKey("suffix"))
                        Text(
                          "${stat["suffix"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: stat["color"] as Color,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        QTextField(
          label: "Search Announcements",
          value: searchQuery,
          hint: "Search by title, content, or author...",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: categoryFilters,
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
                items: priorityFilters,
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: statusFilters,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Sort By",
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
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Create Announcement",
                icon: Icons.add_box,
                size: bs.sm,
                onPressed: () {
                  _showCreateAnnouncementDialog();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Manage Templates",
                icon: Icons.description,
                size: bs.sm,
                onPressed: () {
                  _manageTemplates();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnnouncementsList() {
    List<Map<String, dynamic>> filteredAnnouncements = announcements.where((announcement) {
      bool matchesSearch = searchQuery.isEmpty ||
          (announcement["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (announcement["content"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (announcement["author"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "all" ||
          announcement["category"] == selectedCategory;

      bool matchesPriority = selectedPriority == "all" ||
          announcement["priority"] == selectedPriority;

      bool matchesStatus = selectedStatus == "all" ||
          announcement["status"] == selectedStatus;

      return matchesSearch && matchesCategory && matchesPriority && matchesStatus;
    }).toList();

    // Sort announcements
    filteredAnnouncements.sort((a, b) {
      switch (selectedSort) {
        case "oldest":
          return DateTime.parse(a["publishDate"] as String)
              .compareTo(DateTime.parse(b["publishDate"] as String));
        case "views":
          return (b["viewCount"] as int).compareTo(a["viewCount"] as int);
        case "priority":
          Map<String, int> priorityOrder = {"high": 3, "medium": 2, "low": 1};
          return (priorityOrder[b["priority"]] ?? 0)
              .compareTo(priorityOrder[a["priority"]] ?? 0);
        default: // newest
          return DateTime.parse(b["publishDate"] as String)
              .compareTo(DateTime.parse(a["publishDate"] as String));
      }
    });

    // Move sticky announcements to top
    filteredAnnouncements.sort((a, b) {
      if ((a["isSticky"] as bool) && !(b["isSticky"] as bool)) return -1;
      if (!(a["isSticky"] as bool) && (b["isSticky"] as bool)) return 1;
      return 0;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Announcements (${filteredAnnouncements.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Refresh",
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                _refreshAnnouncements();
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        if (filteredAnnouncements.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.campaign_outlined,
                  size: 48,
                  color: disabledColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "No announcements found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Try adjusting your filters or search criteria",
                  style: TextStyle(
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredAnnouncements.map((announcement) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor(announcement["priority"] as String),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (announcement["isSticky"] as bool)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.push_pin,
                                  size: 16,
                                  color: warningColor,
                                ),
                              ),
                            Expanded(
                              child: Text(
                                "${announcement["title"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(announcement["status"] as String).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${announcement["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(announcement["status"] as String),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${announcement["content"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "By ${announcement["author"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(announcement["category"] as String).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getCategoryLabel(announcement["category"] as String),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getCategoryColor(announcement["category"] as String),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              _formatDate(announcement["publishDate"] as String),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                        if ((announcement["tags"] as List).isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (announcement["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        if ((announcement["attachments"] as List).isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(13),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(announcement["attachments"] as List).length} attachment(s)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 16,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${announcement["viewCount"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 16,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${announcement["likeCount"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.comment,
                                  size: 16,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${announcement["commentCount"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(announcement["priority"] as String).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${announcement["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getPriorityColor(announcement["priority"] as String),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(13),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Read More",
                            size: bs.sm,
                            onPressed: () {
                              _viewAnnouncementDetails(announcement);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Like",
                          icon: Icons.thumb_up,
                          size: bs.sm,
                          onPressed: () {
                            _likeAnnouncement(announcement["id"] as String);
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Share",
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            _shareAnnouncement(announcement);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "scheduled":
        return warningColor;
      case "expired":
        return disabledColor;
      case "draft":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "company":
        return primaryColor;
      case "project":
        return successColor;
      case "policy":
        return warningColor;
      case "events":
        return infoColor;
      case "maintenance":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "company":
        return "Company";
      case "project":
        return "Project";
      case "policy":
        return "Policy";
      case "events":
        return "Events";
      case "maintenance":
        return "Maintenance";
      default:
        return "General";
    }
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  void _showCreateAnnouncementDialog() {
    si("Opening create announcement dialog");
  }

  void _manageTemplates() {
    si("Opening announcement templates management");
  }

  void _refreshAnnouncements() {
    ss("Announcements refreshed");
  }

  void _viewAnnouncementDetails(Map<String, dynamic> announcement) {
    // Increment view count
    announcement["viewCount"] = (announcement["viewCount"] as int) + 1;
    setState(() {});
    si("Viewing announcement: ${announcement["title"]}");
  }

  void _likeAnnouncement(String announcementId) {
    int index = announcements.indexWhere((a) => a["id"] == announcementId);
    if (index != -1) {
      announcements[index]["likeCount"] = (announcements[index]["likeCount"] as int) + 1;
      setState(() {});
      ss("Announcement liked");
    }
  }

  void _shareAnnouncement(Map<String, dynamic> announcement) {
    si("Sharing announcement: ${announcement["title"]}");
  }
}
