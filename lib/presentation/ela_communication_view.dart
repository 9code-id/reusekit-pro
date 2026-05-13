import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCommunicationView extends StatefulWidget {
  const ElaCommunicationView({super.key});

  @override
  State<ElaCommunicationView> createState() => _ElaCommunicationViewState();
}

class _ElaCommunicationViewState extends State<ElaCommunicationView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> communicationItems = [
    {
      "id": 1,
      "type": "announcement",
      "title": "Important: Parent-Teacher Conference Schedule",
      "content": "Dear parents, we would like to invite you to our upcoming parent-teacher conference on March 25, 2024. Please confirm your attendance.",
      "sender": "Principal Johnson",
      "date": "2024-03-15T10:30:00Z",
      "priority": "high",
      "isRead": false,
      "hasAttachment": true,
      "category": "Academic"
    },
    {
      "id": 2,
      "type": "message",
      "title": "Weekly Progress Report - Sarah Johnson",
      "content": "Sarah has shown excellent improvement in mathematics this week. She completed all assignments on time and participated actively in class discussions.",
      "sender": "Ms. Anderson (Math Teacher)",
      "date": "2024-03-14T14:20:00Z",
      "priority": "medium",
      "isRead": true,
      "hasAttachment": false,
      "category": "Progress"
    },
    {
      "id": 3,
      "type": "reminder",
      "title": "Field Trip Permission Slip Due Tomorrow",
      "content": "Please remember to submit the signed permission slip for the science museum field trip by tomorrow, March 16th.",
      "sender": "Grade 5 Office",
      "date": "2024-03-14T09:15:00Z",
      "priority": "high",
      "isRead": false,
      "hasAttachment": true,
      "category": "Events"
    },
    {
      "id": 4,
      "type": "message",
      "title": "Homework Assignment - Week 12",
      "content": "This week's homework includes reading chapter 8, completing the worksheet on page 45, and preparing for the spelling test on Friday.",
      "sender": "Mrs. Thompson (English)",
      "date": "2024-03-13T16:45:00Z",
      "priority": "medium",
      "isRead": true,
      "hasAttachment": true,
      "category": "Homework"
    },
    {
      "id": 5,
      "type": "notification",
      "title": "School Closure - Weather Alert",
      "content": "Due to severe weather conditions, the school will be closed tomorrow, March 16th. All classes and activities are cancelled.",
      "sender": "Emergency Alert System",
      "date": "2024-03-15T18:30:00Z",
      "priority": "urgent",
      "isRead": false,
      "hasAttachment": false,
      "category": "Emergency"
    }
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    var filtered = communicationItems.where((item) {
      bool matchesSearch = item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["content"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" || 
                          item["category"] == selectedFilter ||
                          (selectedFilter == "Unread" && !(item["isRead"] as bool)) ||
                          (selectedFilter == "High Priority" && item["priority"] == "high");
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    // Sort by date (newest first)
    filtered.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));
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
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "announcement":
        return Icons.campaign;
      case "message":
        return Icons.message;
      case "reminder":
        return Icons.alarm;
      case "notification":
        return Icons.notifications;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Communication",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Messages", icon: Icon(Icons.inbox)),
        Tab(text: "Announcements", icon: Icon(Icons.campaign)),
        Tab(text: "Direct Messages", icon: Icon(Icons.message)),
      ],
      tabChildren: [
        _buildAllMessagesTab(),
        _buildAnnouncementsTab(),
        _buildDirectMessagesTab(),
      ],
    );
  }

  Widget _buildAllMessagesTab() {
    return SingleChildScrollView(
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
                        label: "Search communications...",
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
                    Text(
                      "Filter:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "Unread", "value": "Unread"},
                          {"label": "High Priority", "value": "High Priority"},
                          {"label": "Academic", "value": "Academic"},
                          {"label": "Events", "value": "Events"},
                          {"label": "Emergency", "value": "Emergency"},
                        ],
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
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
                    "${communicationItems.length}",
                    Icons.inbox,
                    primaryColor,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    "Unread",
                    "${communicationItems.where((item) => !(item["isRead"] as bool)).length}",
                    Icons.mark_email_unread,
                    warningColor,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    "Priority",
                    "${communicationItems.where((item) => item["priority"] == "high" || item["priority"] == "urgent").length}",
                    Icons.priority_high,
                    dangerColor,
                  ),
                ),
              ],
            ),
          ),

          // Communication List
          ...filteredCommunications.map((item) => _buildCommunicationCard(item)),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsTab() {
    var announcements = communicationItems.where((item) => item["type"] == "announcement").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.campaign, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Official school announcements and important notices",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...announcements.map((item) => _buildCommunicationCard(item)),
        ],
      ),
    );
  }

  Widget _buildDirectMessagesTab() {
    var messages = communicationItems.where((item) => item["type"] == "message").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.message, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Personal messages from teachers and school staff",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Compose New Message",
            icon: Icons.edit,
            size: bs.md,
            onPressed: () {
              // Navigate to compose message
            },
          ),
          ...messages.map((item) => _buildCommunicationCard(item)),
        ],
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
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationCard(Map<String, dynamic> item) {
    bool isUnread = !(item["isRead"] as bool);
    DateTime date = DateTime.parse(item["date"]);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isUnread ? Border.all(color: primaryColor.withAlpha(100), width: 2) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusSm),
          onTap: () => _viewCommunicationDetail(item),
          child: Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(item["priority"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        _getTypeIcon(item["type"]),
                        size: 16,
                        color: _getPriorityColor(item["priority"]),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${item["title"]}",
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
                
                Text(
                  "${item["content"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${item["sender"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    if (item["hasAttachment"] as bool)
                      Container(
                        margin: EdgeInsets.only(right: spXs),
                        child: Icon(Icons.attach_file, size: 14, color: disabledBoldColor),
                      ),
                    Text(
                      date.dMMMy,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(item["priority"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getPriorityColor(item["priority"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(item["priority"]).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getPriorityColor(item["priority"]),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    // Show filter options dialog
  }

  void _viewCommunicationDetail(Map<String, dynamic> item) {
    // Mark as read and navigate to detail
    item["isRead"] = true;
    setState(() {});
  }
}
