import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmEmailTrackingView extends StatefulWidget {
  const CrmEmailTrackingView({super.key});

  @override
  State<CrmEmailTrackingView> createState() => _CrmEmailTrackingViewState();
}

class _CrmEmailTrackingViewState extends State<CrmEmailTrackingView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedTimeRange = "7_days";
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Opened", "value": "opened"},
    {"label": "Clicked", "value": "clicked"},
    {"label": "Bounced", "value": "bounced"},
    {"label": "Unsubscribed", "value": "unsubscribed"},
  ];

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Last 24 Hours", "value": "24_hours"},
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "Last 6 Months", "value": "6_months"},
  ];

  List<Map<String, dynamic>> emailTrackingData = [
    {
      "id": "track_001",
      "recipient": "john.doe@example.com",
      "subject": "Product Launch Announcement",
      "campaign": "Q2 Product Launch",
      "sentAt": "2024-06-19T14:30:00Z",
      "deliveredAt": "2024-06-19T14:30:45Z",
      "openedAt": "2024-06-19T15:25:12Z",
      "clickedAt": "2024-06-19T15:26:30Z",
      "status": "clicked",
      "opens": 3,
      "clicks": 2,
      "bounceReason": null,
      "unsubscribed": false,
      "deviceType": "mobile",
      "location": "New York, US",
      "emailClient": "Gmail",
    },
    {
      "id": "track_002",
      "recipient": "sarah.johnson@company.com",
      "subject": "Weekly Newsletter #45",
      "campaign": "Weekly Newsletter",
      "sentAt": "2024-06-19T10:00:00Z",
      "deliveredAt": "2024-06-19T10:00:30Z",
      "openedAt": "2024-06-19T11:15:22Z",
      "clickedAt": null,
      "status": "opened",
      "opens": 1,
      "clicks": 0,
      "bounceReason": null,
      "unsubscribed": false,
      "deviceType": "desktop",
      "location": "London, UK",
      "emailClient": "Outlook",
    },
    {
      "id": "track_003",
      "recipient": "invalid@bounced.com",
      "subject": "Special Offer - 30% Off",
      "campaign": "Summer Sale",
      "sentAt": "2024-06-19T09:15:00Z",
      "deliveredAt": null,
      "openedAt": null,
      "clickedAt": null,
      "status": "bounced",
      "opens": 0,
      "clicks": 0,
      "bounceReason": "Invalid email address",
      "unsubscribed": false,
      "deviceType": null,
      "location": null,
      "emailClient": null,
    },
    {
      "id": "track_004",
      "recipient": "mike.wilson@tech.co",
      "subject": "Event Invitation - Tech Summit 2024",
      "campaign": "Tech Summit Invites",
      "sentAt": "2024-06-18T16:45:00Z",
      "deliveredAt": "2024-06-18T16:45:25Z",
      "openedAt": "2024-06-18T17:20:10Z",
      "clickedAt": "2024-06-18T17:22:45Z",
      "status": "clicked",
      "opens": 2,
      "clicks": 1,
      "bounceReason": null,
      "unsubscribed": false,
      "deviceType": "desktop",
      "location": "San Francisco, US",
      "emailClient": "Apple Mail",
    },
    {
      "id": "track_005",
      "recipient": "lisa.brown@startup.io",
      "subject": "Monthly Report - May 2024",
      "campaign": "Monthly Reports",
      "sentAt": "2024-06-17T14:00:00Z",
      "deliveredAt": "2024-06-17T14:00:15Z",
      "openedAt": null,
      "clickedAt": null,
      "status": "delivered",
      "opens": 0,
      "clicks": 0,
      "bounceReason": null,
      "unsubscribed": false,
      "deviceType": null,
      "location": null,
      "emailClient": null,
    },
  ];

  List<Map<String, dynamic>> get filteredTrackingData {
    return emailTrackingData.where((track) {
      bool matchesSearch = track["recipient"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          track["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          track["campaign"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || track["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Map<String, dynamic> get trackingStats {
    int totalEmails = emailTrackingData.length;
    int delivered = emailTrackingData.where((t) => t["status"] != "bounced").length;
    int opened = emailTrackingData.where((t) => t["openedAt"] != null).length;
    int clicked = emailTrackingData.where((t) => t["clickedAt"] != null).length;
    int bounced = emailTrackingData.where((t) => t["status"] == "bounced").length;
    
    double deliveryRate = totalEmails > 0 ? (delivered / totalEmails) * 100 : 0;
    double openRate = delivered > 0 ? (opened / delivered) * 100 : 0;
    double clickRate = opened > 0 ? (clicked / opened) * 100 : 0;
    double bounceRate = totalEmails > 0 ? (bounced / totalEmails) * 100 : 0;
    
    return {
      "totalEmails": totalEmails,
      "delivered": delivered,
      "opened": opened,
      "clicked": clicked,
      "bounced": bounced,
      "deliveryRate": deliveryRate,
      "openRate": openRate,
      "clickRate": clickRate,
      "bounceRate": bounceRate,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "delivered":
        return infoColor;
      case "opened":
        return successColor;
      case "clicked":
        return primaryColor;
      case "bounced":
        return dangerColor;
      case "unsubscribed":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "delivered":
        return "Delivered";
      case "opened":
        return "Opened";
      case "clicked":
        return "Clicked";
      case "bounced":
        return "Bounced";
      case "unsubscribed":
        return "Unsubscribed";
      default:
        return "Unknown";
    }
  }

  void _viewTrackingDetails(Map<String, dynamic> track) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Email Tracking Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow("Recipient", "${track["recipient"]}"),
                _buildDetailRow("Subject", "${track["subject"]}"),
                _buildDetailRow("Campaign", "${track["campaign"]}"),
                _buildDetailRow("Status", _getStatusLabel("${track["status"]}")),
                SizedBox(height: spSm),
                _buildDetailRow("Sent At", "${track["sentAt"]}"),
                if (track["deliveredAt"] != null)
                  _buildDetailRow("Delivered At", "${track["deliveredAt"]}"),
                if (track["openedAt"] != null)
                  _buildDetailRow("Opened At", "${track["openedAt"]}"),
                if (track["clickedAt"] != null)
                  _buildDetailRow("Clicked At", "${track["clickedAt"]}"),
                SizedBox(height: spSm),
                _buildDetailRow("Opens", "${track["opens"]}"),
                _buildDetailRow("Clicks", "${track["clicks"]}"),
                if (track["deviceType"] != null)
                  _buildDetailRow("Device", "${track["deviceType"]}"),
                if (track["location"] != null)
                  _buildDetailRow("Location", "${track["location"]}"),
                if (track["emailClient"] != null)
                  _buildDetailRow("Email Client", "${track["emailClient"]}"),
                if (track["bounceReason"] != null)
                  _buildDetailRow("Bounce Reason", "${track["bounceReason"]}"),
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exportTrackingData() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Email tracking data exported successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    final stats = trackingStats;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportTrackingData,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Performance Overview",
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
                    children: [
                      _buildStatCard(
                        "Total Emails",
                        "${stats["totalEmails"]}",
                        Icons.email,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Delivery Rate",
                        "${(stats["deliveryRate"] as double).toStringAsFixed(1)}%",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildStatCard(
                        "Open Rate",
                        "${(stats["openRate"] as double).toStringAsFixed(1)}%",
                        Icons.visibility,
                        infoColor,
                      ),
                      _buildStatCard(
                        "Click Rate",
                        "${(stats["clickRate"] as double).toStringAsFixed(1)}%",
                        Icons.mouse,
                        warningColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search emails...",
                          value: searchQuery,
                          hint: "Search by recipient, subject, or campaign",
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
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: statusOptions,
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
                          label: "Time Range",
                          items: timeRangeOptions,
                          value: selectedTimeRange,
                          onChanged: (value, label) {
                            selectedTimeRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Email Tracking Results (${filteredTrackingData.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTrackingData.length,
                    itemBuilder: (context, index) {
                      final track = filteredTrackingData[index];
                      return _buildTrackingCard(track);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Tracking",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(Map<String, dynamic> track) {
    Color statusColor = _getStatusColor("${track["status"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${track["recipient"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${track["subject"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getStatusLabel("${track["status"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Campaign: ${track["campaign"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Sent: ${track["sentAt"]}",
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
                    "Opens: ${track["opens"]} | Clicks: ${track["clicks"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _viewTrackingDetails(track),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
