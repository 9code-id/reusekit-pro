import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCallLogView extends StatefulWidget {
  const CmaCallLogView({super.key});

  @override
  State<CmaCallLogView> createState() => _CmaCallLogViewState();
}

class _CmaCallLogViewState extends State<CmaCallLogView> {
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedDateRange = "all_time";
  
  List<Map<String, dynamic>> callLogs = [
    {
      "id": 1,
      "contact_name": "John Smith",
      "phone_number": "+1 (555) 123-4567",
      "company": "ABC Corp",
      "call_type": "outgoing",
      "status": "completed",
      "duration": 1245, // seconds
      "start_time": DateTime.now().subtract(Duration(hours: 2)),
      "end_time": DateTime.now().subtract(Duration(hours: 2, minutes: -20)),
      "recording_available": true,
      "notes": "Discussed quarterly targets and upcoming project milestones.",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "lead_score": 85,
      "deal_value": 15000,
    },
    {
      "id": 2,
      "contact_name": "Sarah Johnson",
      "phone_number": "+1 (555) 987-6543",
      "company": "XYZ Industries",
      "call_type": "incoming",
      "status": "missed",
      "duration": 0,
      "start_time": DateTime.now().subtract(Duration(hours: 4)),
      "end_time": null,
      "recording_available": false,
      "notes": "",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "lead_score": 72,
      "deal_value": 8500,
    },
    {
      "id": 3,
      "contact_name": "Mike Davis",
      "phone_number": "+1 (555) 456-7890",
      "company": "Tech Solutions",
      "call_type": "outgoing",
      "status": "completed",
      "duration": 892,
      "start_time": DateTime.now().subtract(Duration(days: 1, hours: 3)),
      "end_time": DateTime.now().subtract(Duration(days: 1, hours: 3, minutes: -14)),
      "recording_available": true,
      "notes": "Product demo went well. Scheduling follow-up meeting next week.",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "lead_score": 91,
      "deal_value": 25000,
    },
    {
      "id": 4,
      "contact_name": "Emma Wilson",
      "phone_number": "+1 (555) 789-0123",
      "company": "Design Studio",
      "call_type": "incoming",
      "status": "completed",
      "duration": 2156,
      "start_time": DateTime.now().subtract(Duration(days: 2, hours: 1)),
      "end_time": DateTime.now().subtract(Duration(days: 2, hours: 1, minutes: -36)),
      "recording_available": true,
      "notes": "Contract negotiation. Agreed on revised pricing structure.",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "lead_score": 78,
      "deal_value": 12000,
    },
    {
      "id": 5,
      "contact_name": "Robert Brown",
      "phone_number": "+1 (555) 321-6547",
      "company": "Marketing Plus",
      "call_type": "outgoing",
      "status": "failed",
      "duration": 0,
      "start_time": DateTime.now().subtract(Duration(days: 3)),
      "end_time": null,
      "recording_available": false,
      "notes": "",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "lead_score": 65,
      "deal_value": 5500,
    },
    {
      "id": 6,
      "contact_name": "Lisa Anderson",
      "phone_number": "+1 (555) 654-3210",
      "company": "Global Tech",
      "call_type": "incoming",
      "status": "completed",
      "duration": 1678,
      "start_time": DateTime.now().subtract(Duration(days: 5, hours: 2)),
      "end_time": DateTime.now().subtract(Duration(days: 5, hours: 2, minutes: -28)),
      "recording_available": true,
      "notes": "Initial consultation. Very interested in our enterprise package.",
      "avatar": "https://picsum.photos/60/60?random=6&keyword=person",
      "lead_score": 88,
      "deal_value": 45000,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Calls", "value": "all"},
    {"label": "Incoming", "value": "incoming"},
    {"label": "Outgoing", "value": "outgoing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Missed", "value": "missed"},
    {"label": "Failed", "value": "failed"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "All Time", "value": "all_time"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last 30 Days", "value": "last_30_days"},
  ];

  List<Map<String, dynamic>> get filteredCallLogs {
    return callLogs.where((call) {
      bool matchesSearch = searchQuery.isEmpty || 
          (call["contact_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (call["company"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (call["phone_number"] as String).contains(searchQuery);
      
      bool matchesFilter = selectedFilter == "all" || 
          call["call_type"] == selectedFilter ||
          call["status"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList()..sort((a, b) => (b["start_time"] as DateTime).compareTo(a["start_time"] as DateTime));
  }

  Color getCallTypeColor(String type) {
    switch (type) {
      case "incoming":
        return successColor;
      case "outgoing":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "missed":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData getCallTypeIcon(String type) {
    switch (type) {
      case "incoming":
        return Icons.call_received;
      case "outgoing":
        return Icons.call_made;
      default:
        return Icons.call;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "missed":
        return Icons.missed_video_call;
      case "failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  String formatDuration(int seconds) {
    if (seconds == 0) return "0s";
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    
    if (hours > 0) {
      return "${hours}h ${minutes}m ${secs}s";
    } else if (minutes > 0) {
      return "${minutes}m ${secs}s";
    } else {
      return "${secs}s";
    }
  }

  Widget _buildStatsOverview() {
    int totalCalls = callLogs.length;
    int completedCalls = callLogs.where((c) => c["status"] == "completed").length;
    int missedCalls = callLogs.where((c) => c["status"] == "missed").length;
    double avgDuration = callLogs.where((c) => (c["duration"] as int) > 0)
        .fold(0.0, (sum, c) => sum + (c["duration"] as int)) / 
        callLogs.where((c) => (c["duration"] as int) > 0).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Calls", "$totalCalls", Icons.call, primaryColor),
        _buildStatCard("Completed", "$completedCalls", Icons.check_circle, successColor),
        _buildStatCard("Missed", "$missedCalls", Icons.missed_video_call, warningColor),
        _buildStatCard("Avg Duration", formatDuration(avgDuration.toInt()), Icons.access_time, infoColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallLogCard(Map<String, dynamic> call) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${call["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: getCallTypeColor("${call["call_type"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          getCallTypeIcon("${call["call_type"]}"),
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              
              // Contact Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${call["contact_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${call["company"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${call["phone_number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status and Actions
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getStatusColor("${call["status"]}").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          getStatusIcon("${call["status"]}"),
                          color: getStatusColor("${call["status"]}"),
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${call["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor("${call["status"]}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      ss("Calling ${call["contact_name"]}");
                    },
                  ),
                ],
              ),
            ],
          ),
          
          // Call Details
          Row(
            children: [
              _buildCallDetail("Duration", formatDuration(call["duration"] as int)),
              SizedBox(width: spMd),
              _buildCallDetail("Lead Score", "${call["lead_score"]}"),
              SizedBox(width: spMd),
              _buildCallDetail("Deal Value", "\$${((call["deal_value"] as int).toDouble()).currency}"),
              Spacer(),
              Text(
                "${(call["start_time"] as DateTime).dMMMykkss}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          // Notes and Recording
          if ((call["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: disabledBoldColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${call["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          // Action Buttons
          Row(
            children: [
              if (call["recording_available"] as bool)
                QButton(
                  label: "Play Recording",
                  icon: Icons.play_arrow,
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Playing call recording");
                  },
                ),
              if (call["recording_available"] as bool)
                SizedBox(width: spSm),
              QButton(
                label: "Add Notes",
                icon: Icons.note_add,
                color: warningColor,
                size: bs.sm,
                onPressed: () {
                  // Navigate to note addition
                },
              ),
              Spacer(),
              if ((call["notes"] as String).isNotEmpty)
                QButton(
                  icon: Icons.share,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Call log shared");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalytics() {
    Map<String, int> callsByType = {};
    Map<String, int> callsByStatus = {};
    
    for (var call in callLogs) {
      String type = call["call_type"] as String;
      String status = call["status"] as String;
      
      callsByType[type] = (callsByType[type] ?? 0) + 1;
      callsByStatus[status] = (callsByStatus[status] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Call Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Call Types", callsByType),
              _buildAnalyticsCard("Call Status", callsByStatus),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, Map<String, int> data) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...data.entries.map((entry) => Row(
            children: [
              Expanded(
                child: Text(
                  entry.key.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "${entry.value}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Log"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Overview
            _buildStatsOverview(),
            
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search call logs...",
                    value: searchQuery,
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
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Analytics
            _buildAnalytics(),
            
            // Call Logs List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.history, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Call History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredCallLogs.length} calls",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredCallLogs.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final call = filteredCallLogs[index];
                      return _buildCallLogCard(call);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
