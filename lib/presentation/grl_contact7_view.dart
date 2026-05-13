import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact7View extends StatefulWidget {
  @override
  State<GrlContact7View> createState() => _GrlContact7ViewState();
}

class _GrlContact7ViewState extends State<GrlContact7View> {
  String searchQuery = '';
  String selectedFilter = 'all';
  
  List<Map<String, dynamic>> communications = [
    {
      "id": 1,
      "contactName": "Sarah Johnson",
      "contactAvatar": "https://picsum.photos/100/100?random=50&keyword=woman",
      "type": "call",
      "direction": "outgoing",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
      "duration": "12:34",
      "status": "completed",
      "location": "Office",
    },
    {
      "id": 2,
      "contactName": "Michael Chen",
      "contactAvatar": "https://picsum.photos/100/100?random=51&keyword=man",
      "type": "message",
      "direction": "incoming",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "content": "Hey, are we still meeting for lunch tomorrow?",
      "status": "read",
      "messageCount": 1,
    },
    {
      "id": 3,
      "contactName": "Emily Rodriguez",
      "contactAvatar": "https://picsum.photos/100/100?random=52&keyword=woman",
      "type": "email",
      "direction": "outgoing",
      "timestamp": DateTime.now().subtract(Duration(hours: 4)),
      "subject": "Project Update - Q4 Goals",
      "status": "sent",
      "attachments": 2,
    },
    {
      "id": 4,
      "contactName": "David Wilson",
      "contactAvatar": "https://picsum.photos/100/100?random=53&keyword=man",
      "type": "call",
      "direction": "incoming",
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
      "duration": "5:23",
      "status": "missed",
      "location": "Mobile",
    },
    {
      "id": 5,
      "contactName": "Lisa Thompson",
      "contactAvatar": "https://picsum.photos/100/100?random=54&keyword=woman",
      "type": "message",
      "direction": "outgoing",
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
      "content": "Thanks for the great presentation today! 👏",
      "status": "delivered",
      "messageCount": 3,
    },
    {
      "id": 6,
      "contactName": "Robert Johnson",
      "contactAvatar": "https://picsum.photos/100/100?random=55&keyword=man",
      "type": "videocall",
      "direction": "outgoing",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "duration": "45:12",
      "status": "completed",
      "participants": 4,
    },
    {
      "id": 7,
      "contactName": "Jessica Davis",
      "contactAvatar": "https://picsum.photos/100/100?random=56&keyword=woman",
      "type": "email",
      "direction": "incoming",
      "timestamp": DateTime.now().subtract(Duration(days: 1, hours: 3)),
      "subject": "Invoice #INV-2024-001",
      "status": "read",
      "attachments": 1,
    },
    {
      "id": 8,
      "contactName": "Tom Anderson",
      "contactAvatar": "https://picsum.photos/100/100?random=57&keyword=man",
      "type": "call",
      "direction": "outgoing",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
      "duration": "8:45",
      "status": "completed",
      "location": "Home",
    },
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    List<Map<String, dynamic>> filtered = communications;
    
    if (selectedFilter != 'all') {
      filtered = filtered.where((comm) => comm["type"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((comm) =>
        (comm["contactName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (comm["content"] as String? ?? "").toLowerCase().contains(searchQuery.toLowerCase()) ||
        (comm["subject"] as String? ?? "").toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Map<String, int> get communicationStats {
    return {
      'all': communications.length,
      'call': communications.where((c) => c["type"] == "call").length,
      'message': communications.where((c) => c["type"] == "message").length,
      'email': communications.where((c) => c["type"] == "email").length,
      'videocall': communications.where((c) => c["type"] == "videocall").length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communication History"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Communication Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        Icons.phone,
                        "Calls",
                        "${communicationStats['call']}",
                        Colors.white,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        Icons.message,
                        "Messages",
                        "${communicationStats['message']}",
                        Colors.white,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        Icons.email,
                        "Emails",
                        "${communicationStats['email']}",
                        Colors.white,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        Icons.videocam,
                        "Video",
                        "${communicationStats['videocall']}",
                        Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Tabs
          Container(
            height: 60,
            padding: EdgeInsets.all(spMd),
            child: QHorizontalScroll(
              children: [
                'all', 'call', 'message', 'email', 'videocall'
              ].map((filter) => GestureDetector(
                onTap: () {
                  selectedFilter = filter;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedFilter == filter ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedFilter == filter ? primaryColor : disabledColor,
                    ),
                    boxShadow: selectedFilter == filter ? [shadowSm] : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getFilterIcon(filter),
                        size: 16,
                        color: selectedFilter == filter ? Colors.white : primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        _getFilterLabel(filter),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedFilter == filter ? Colors.white : primaryColor,
                        ),
                      ),
                      if (filter != 'all') ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: selectedFilter == filter 
                                ? Colors.white.withAlpha(50)
                                : primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${communicationStats[filter]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: selectedFilter == filter ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Communications List
          Expanded(
            child: filteredCommunications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredCommunications.length,
                    itemBuilder: (context, index) {
                      final comm = filteredCommunications[index];
                      return _buildCommunicationItem(comm, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value, Color textColor) {
    return Column(
      children: [
        Icon(
          icon,
          color: textColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: textColor.withAlpha(180),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunicationItem(Map<String, dynamic> comm, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getCommunicationTypeColor(comm["type"]),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                // Contact Avatar
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${comm["contactAvatar"]}"),
                ),
                SizedBox(width: spMd),
                
                // Contact Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${comm["contactName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Status Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(comm["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${comm["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(comm["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getCommunicationTypeColor(comm["type"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getCommunicationTypeIcon(comm["type"]),
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${comm["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getCommunicationTypeColor(comm["type"]),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            comm["direction"] == "incoming" 
                                ? Icons.call_received 
                                : Icons.call_made,
                            size: 12,
                            color: comm["direction"] == "incoming" 
                                ? successColor 
                                : primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${comm["direction"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: comm["direction"] == "incoming" 
                                  ? successColor 
                                  : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Action Button
                IconButton(
                  icon: Icon(
                    _getCommunicationTypeIcon(comm["type"]),
                    color: _getCommunicationTypeColor(comm["type"]),
                  ),
                  onPressed: () {
                    _repeatCommunication(comm);
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Communication Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Duration or Content
                  if (comm["duration"] != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Duration: ${comm["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (comm["location"] != null) ...[
                          SizedBox(width: spSm),
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${comm["location"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  
                  if (comm["content"] != null) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.message,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${comm["content"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (comm["messageCount"] != null && (comm["messageCount"] as int) > 1) ...[
                      SizedBox(height: spXs),
                      Text(
                        "+${(comm["messageCount"] as int) - 1} more messages",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                  
                  if (comm["subject"] != null) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.subject,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${comm["subject"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (comm["attachments"] != null && (comm["attachments"] as int) > 0) ...[
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.attachment,
                            size: 12,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${comm["attachments"]} attachment${(comm["attachments"] as int) > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                  
                  if (comm["participants"] != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${comm["participants"]} participants",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (comm["duration"] != null) ...[
                          SizedBox(width: spSm),
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${comm["duration"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  
                  SizedBox(height: spSm),
                  
                  // Timestamp
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: disabledColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        _formatTimestamp(comm["timestamp"] as DateTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      Spacer(),
                      if (comm["status"] == "missed") ...[
                        Icon(
                          Icons.phone_missed,
                          size: 12,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "MISSED CALL",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No Communications Found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            searchQuery.isNotEmpty
                ? "No results for '$searchQuery'"
                : "No communications matching the current filter",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Clear Filter",
            size: bs.sm,
            onPressed: () {
              selectedFilter = 'all';
              searchQuery = '';
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Communications"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Search by contact, content, or subject...",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                searchQuery = '';
                setState(() {});
                back();
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                back();
              },
              child: Text("Search"),
            ),
          ],
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter Communications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              // Communication Types
              Text(
                "Communication Type",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                children: ['all', 'call', 'message', 'email', 'videocall'].map((filter) {
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getFilterIcon(filter),
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(_getFilterLabel(filter)),
                      ],
                    ),
                    selected: selectedFilter == filter,
                    onSelected: (selected) {
                      if (selected) {
                        selectedFilter = filter;
                        setState(() {});
                        back();
                      }
                    },
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
              
              // Quick Filters
              Text(
                "Quick Filters",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              
              ListTile(
                leading: Icon(Icons.phone_missed, color: dangerColor),
                title: Text("Missed Calls"),
                subtitle: Text("${communications.where((c) => c["status"] == "missed").length} items"),
                onTap: () {
                  back();
                  // Apply missed calls filter
                },
              ),
              
              ListTile(
                leading: Icon(Icons.message_outlined, color: infoColor),
                title: Text("Unread Messages"),
                subtitle: Text("${communications.where((c) => c["type"] == "message" && c["status"] != "read").length} items"),
                onTap: () {
                  back();
                  // Apply unread messages filter
                },
              ),
              
              ListTile(
                leading: Icon(Icons.today, color: primaryColor),
                title: Text("Today's Communications"),
                subtitle: Text("${communications.where((c) => _isToday(c["timestamp"] as DateTime)).length} items"),
                onTap: () {
                  back();
                  // Apply today filter
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _repeatCommunication(Map<String, dynamic> comm) {
    String action = '';
    switch (comm["type"]) {
      case 'call':
        action = "Calling ${comm["contactName"]}...";
        break;
      case 'message':
        action = "Opening messages with ${comm["contactName"]}...";
        break;
      case 'email':
        action = "Opening email composer...";
        break;
      case 'videocall':
        action = "Starting video call with ${comm["contactName"]}...";
        break;
    }
    ss(action);
  }

  Color _getCommunicationTypeColor(String type) {
    switch (type) {
      case 'call':
        return successColor;
      case 'message':
        return infoColor;
      case 'email':
        return primaryColor;
      case 'videocall':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCommunicationTypeIcon(String type) {
    switch (type) {
      case 'call':
        return Icons.phone;
      case 'message':
        return Icons.message;
      case 'email':
        return Icons.email;
      case 'videocall':
        return Icons.videocam;
      default:
        return Icons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
      case 'sent':
      case 'delivered':
      case 'read':
        return successColor;
      case 'missed':
      case 'failed':
        return dangerColor;
      case 'pending':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  IconData _getFilterIcon(String filter) {
    switch (filter) {
      case 'all':
        return Icons.all_inclusive;
      case 'call':
        return Icons.phone;
      case 'message':
        return Icons.message;
      case 'email':
        return Icons.email;
      case 'videocall':
        return Icons.videocam;
      default:
        return Icons.filter_list;
    }
  }

  String _getFilterLabel(String filter) {
    switch (filter) {
      case 'all':
        return "ALL";
      case 'call':
        return "CALLS";
      case 'message':
        return "MESSAGES";
      case 'email':
        return "EMAILS";
      case 'videocall':
        return "VIDEO";
      default:
        return filter.toUpperCase();
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays == 1) {
      return "Yesterday ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return timestamp.dMMMy;
    }
  }
}
