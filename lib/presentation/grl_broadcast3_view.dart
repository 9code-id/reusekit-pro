import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast3View extends StatefulWidget {
  @override
  State<GrlBroadcast3View> createState() => _GrlBroadcast3ViewState();
}

class _GrlBroadcast3ViewState extends State<GrlBroadcast3View> {
  String selectedStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Failed", "value": "Failed"},
  ];

  List<Map<String, dynamic>> broadcasts = [
    {
      "id": 1,
      "title": "Weekly Newsletter - Tech Updates",
      "type": "Newsletter",
      "audience": "All Followers",
      "audienceSize": 125400,
      "status": "Sent",
      "scheduledDate": "2024-03-20 10:00",
      "sentDate": "2024-03-20 10:00",
      "channels": ["Email", "Push", "In-App"],
      "delivered": 123890,
      "opened": 94567,
      "clicked": 23456,
      "deliveryRate": 98.8,
      "openRate": 76.3,
      "clickRate": 24.8,
      "priority": "Normal",
    },
    {
      "id": 2,
      "title": "Live Stream Starting Soon",
      "type": "Event",
      "audience": "Active Subscribers",
      "audienceSize": 89600,
      "status": "Sent",
      "scheduledDate": "2024-03-18 14:30",
      "sentDate": "2024-03-18 14:30",
      "channels": ["Push", "In-App"],
      "delivered": 88234,
      "opened": 71234,
      "clicked": 18567,
      "deliveryRate": 98.5,
      "openRate": 80.7,
      "clickRate": 26.1,
      "priority": "High",
    },
    {
      "id": 3,
      "title": "New Premium Content Available",
      "type": "Content",
      "audience": "Premium Members",
      "audienceSize": 45200,
      "status": "Scheduled",
      "scheduledDate": "2024-03-25 09:00",
      "sentDate": null,
      "channels": ["Email", "Push"],
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "deliveryRate": 0,
      "openRate": 0,
      "clickRate": 0,
      "priority": "Normal",
    },
    {
      "id": 4,
      "title": "Product Feature Update",
      "type": "Product Update",
      "audience": "All Followers",
      "audienceSize": 125400,
      "status": "Draft",
      "scheduledDate": null,
      "sentDate": null,
      "channels": ["Email", "Push", "In-App"],
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "deliveryRate": 0,
      "openRate": 0,
      "clickRate": 0,
      "priority": "High",
    },
    {
      "id": 5,
      "title": "System Maintenance Notice",
      "type": "Announcement",
      "audience": "All Followers",
      "audienceSize": 125400,
      "status": "Failed",
      "scheduledDate": "2024-03-16 08:00",
      "sentDate": null,
      "channels": ["Email", "Push"],
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "deliveryRate": 0,
      "openRate": 0,
      "clickRate": 0,
      "priority": "Urgent",
    },
    {
      "id": 6,
      "title": "Monthly Analytics Report",
      "type": "Report",
      "audience": "Premium Members",
      "audienceSize": 45200,
      "status": "Scheduled",
      "scheduledDate": "2024-03-30 16:00",
      "sentDate": null,
      "channels": ["Email"],
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "deliveryRate": 0,
      "openRate": 0,
      "clickRate": 0,
      "priority": "Low",
    },
  ];

  List<Map<String, dynamic>> get filteredBroadcasts {
    var filtered = broadcasts;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((broadcast) => broadcast["status"] == selectedStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((broadcast) => 
        (broadcast["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (broadcast["type"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Broadcast History"),
        actions: [
          GestureDetector(
            onTap: () => _createNewBroadcast(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.add, size: 24),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search broadcasts...",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                            contentPadding: EdgeInsets.symmetric(vertical: spSm),
                          ),
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Status Filter
                QCategoryPicker(
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (index, label, value, item) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            alignment: Alignment.centerLeft,
            child: Text(
              "${filteredBroadcasts.length} broadcasts found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: spSm),

          // Broadcasts List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredBroadcasts.length,
              itemBuilder: (context, index) {
                final broadcast = filteredBroadcasts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${broadcast["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${broadcast["type"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(broadcast["priority"]).withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${broadcast["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getPriorityColor(broadcast["priority"]),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _buildStatusBadge(broadcast["status"]),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Audience and Channels Info
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${broadcast["audience"]} (${((broadcast["audienceSize"] as int) / 1000).toStringAsFixed(0)}K)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.send,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              (broadcast["channels"] as List).join(", "),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Date Information
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            _getDateText(broadcast),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Performance Metrics (only for sent broadcasts)
                      if (broadcast["status"] == "Sent") ...[
                        SizedBox(height: spSm),
                        Divider(),
                        SizedBox(height: spSm),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 100,
                          children: [
                            _buildMetricItem("Delivered", "${(broadcast["deliveryRate"] as double).toStringAsFixed(1)}%", successColor),
                            _buildMetricItem("Opened", "${(broadcast["openRate"] as double).toStringAsFixed(1)}%", infoColor),
                            _buildMetricItem("Clicked", "${(broadcast["clickRate"] as double).toStringAsFixed(1)}%", warningColor),
                          ],
                        ),
                      ],

                      // Action Buttons
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          if (broadcast["status"] == "Draft") ...[
                            Expanded(
                              child: QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () => _editBroadcast(broadcast["id"]),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Send Now",
                                color: successColor,
                                size: bs.sm,
                                onPressed: () => _sendBroadcast(broadcast["id"]),
                              ),
                            ),
                          ] else if (broadcast["status"] == "Scheduled") ...[
                            Expanded(
                              child: QButton(
                                label: "Edit Schedule",
                                size: bs.sm,
                                onPressed: () => _editSchedule(broadcast["id"]),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Cancel",
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () => _cancelBroadcast(broadcast["id"]),
                              ),
                            ),
                          ] else if (broadcast["status"] == "Failed") ...[
                            Expanded(
                              child: QButton(
                                label: "Retry",
                                color: warningColor,
                                size: bs.sm,
                                onPressed: () => _retryBroadcast(broadcast["id"]),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "View Error",
                                size: bs.sm,
                                onPressed: () => _viewError(broadcast["id"]),
                              ),
                            ),
                          ] else if (broadcast["status"] == "Sent") ...[
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () => _viewDetails(broadcast["id"]),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Duplicate",
                                size: bs.sm,
                                onPressed: () => _duplicateBroadcast(broadcast["id"]),
                              ),
                            ),
                          ],
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () => _showMoreOptions(broadcast["id"]),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              child: Icon(
                                Icons.more_vert,
                                color: disabledBoldColor,
                                size: 20,
                              ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewBroadcast(),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    IconData icon;
    
    switch (status) {
      case "Sent":
        color = successColor;
        icon = Icons.check_circle;
        break;
      case "Scheduled":
        color = warningColor;
        icon = Icons.schedule;
        break;
      case "Draft":
        color = disabledBoldColor;
        icon = Icons.edit;
        break;
      case "Failed":
        color = dangerColor;
        icon = Icons.error;
        break;
      default:
        color = disabledBoldColor;
        icon = Icons.help;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return warningColor;
      case "Normal":
        return primaryColor;
      case "Low":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getDateText(Map<String, dynamic> broadcast) {
    String status = broadcast["status"];
    String? scheduledDate = broadcast["scheduledDate"];
    String? sentDate = broadcast["sentDate"];
    
    if (status == "Sent" && sentDate != null) {
      return "Sent: ${DateTime.parse(sentDate).toString().split('.')[0]}";
    } else if (status == "Scheduled" && scheduledDate != null) {
      return "Scheduled: ${DateTime.parse(scheduledDate).toString().split('.')[0]}";
    } else if (status == "Failed" && scheduledDate != null) {
      return "Failed: ${DateTime.parse(scheduledDate).toString().split('.')[0]}";
    } else {
      return "Draft";
    }
  }

  void _createNewBroadcast() {
    si("Creating new broadcast...");
  }

  void _editBroadcast(int id) {
    si("Editing broadcast $id");
  }

  void _sendBroadcast(int id) async {
    bool isConfirmed = await confirm("Send this broadcast now?");
    if (isConfirmed) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Broadcast sent successfully!");
        // Update status in the list
        final index = broadcasts.indexWhere((b) => b["id"] == id);
        if (index != -1) {
          broadcasts[index]["status"] = "Sent";
          setState(() {});
        }
      });
    }
  }

  void _editSchedule(int id) {
    si("Editing schedule for broadcast $id");
  }

  void _cancelBroadcast(int id) async {
    bool isConfirmed = await confirm("Cancel this scheduled broadcast?");
    if (isConfirmed) {
      final index = broadcasts.indexWhere((b) => b["id"] == id);
      if (index != -1) {
        broadcasts[index]["status"] = "Draft";
        setState(() {});
        si("Broadcast cancelled and moved to drafts");
      }
    }
  }

  void _retryBroadcast(int id) async {
    bool isConfirmed = await confirm("Retry sending this broadcast?");
    if (isConfirmed) {
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Broadcast retry successful!");
        final index = broadcasts.indexWhere((b) => b["id"] == id);
        if (index != -1) {
          broadcasts[index]["status"] = "Sent";
          setState(() {});
        }
      });
    }
  }

  void _viewError(int id) {
    se("Error details: Connection timeout during broadcast delivery");
  }

  void _viewDetails(int id) {
    si("Opening detailed analytics for broadcast $id");
  }

  void _duplicateBroadcast(int id) {
    si("Duplicating broadcast $id");
  }

  void _showMoreOptions(int id) {
    si("More options for broadcast $id");
  }
}
