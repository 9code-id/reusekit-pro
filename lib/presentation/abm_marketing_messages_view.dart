import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbmMarketingMessagesView extends StatefulWidget {
  const AbmMarketingMessagesView({Key? key}) : super(key: key);

  @override
  State<AbmMarketingMessagesView> createState() => _AbmMarketingMessagesViewState();
}

class _AbmMarketingMessagesViewState extends State<AbmMarketingMessagesView> {
  String searchQuery = "";
  String selectedCategory = "all";
  bool loading = false;
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "title": "Summer Beauty Package",
      "content": "Get 30% off on all beauty treatments this summer! Book now and save big.",
      "category": "promotion",
      "status": "active",
      "sentDate": "2024-06-15T10:30:00Z",
      "recipients": 1250,
      "openRate": 68.5,
      "clickRate": 15.2,
      "type": "email",
    },
    {
      "id": "2", 
      "title": "New Facial Treatment Available",
      "content": "Introducing our revolutionary anti-aging facial treatment with premium ingredients.",
      "category": "announcement",
      "status": "draft",
      "sentDate": "2024-06-18T14:15:00Z",
      "recipients": 890,
      "openRate": 0.0,
      "clickRate": 0.0,
      "type": "sms",
    },
    {
      "id": "3",
      "title": "Birthday Special Offer",
      "content": "Celebrate your birthday with us! Get a complimentary massage with any beauty package.",
      "category": "promotion",
      "status": "scheduled",
      "sentDate": "2024-06-20T09:00:00Z",
      "recipients": 2100,
      "openRate": 0.0,
      "clickRate": 0.0,
      "type": "email",
    },
    {
      "id": "4",
      "title": "Appointment Reminder",
      "content": "Don't forget your appointment tomorrow at 2 PM. We're excited to see you!",
      "category": "reminder",
      "status": "active",
      "sentDate": "2024-06-16T18:00:00Z",
      "recipients": 345,
      "openRate": 92.3,
      "clickRate": 8.7,
      "type": "sms",
    },
    {
      "id": "5",
      "title": "Weekly Beauty Tips",
      "content": "5 simple steps to maintain glowing skin at home. Expert tips from our professionals.",
      "category": "educational",
      "status": "active",
      "sentDate": "2024-06-12T08:00:00Z",  
      "recipients": 1800,
      "openRate": 45.6,
      "clickRate": 12.8,
      "type": "email",
    },
    {
      "id": "6",
      "title": "Client Satisfaction Survey",
      "content": "Help us improve our services. Complete this 2-minute survey and get a discount code.",
      "category": "feedback",
      "status": "active",
      "sentDate": "2024-06-14T16:20:00Z",
      "recipients": 750,
      "openRate": 34.2,
      "clickRate": 18.9,
      "type": "email",
    },
  ];
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Promotions", "value": "promotion"},
    {"label": "Announcements", "value": "announcement"},
    {"label": "Reminders", "value": "reminder"},
    {"label": "Educational", "value": "educational"},
    {"label": "Feedback", "value": "feedback"},
  ];

  List<Map<String, dynamic>> get filteredMessages {
    return messages.where((message) {
      bool matchesSearch = message["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          message["content"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "all" || message["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'draft':
        return warningColor;
      case 'scheduled':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Sent';
      case 'draft':
        return 'Draft';
      case 'scheduled':
        return 'Scheduled';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Messages"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create message
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filter Section
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search messages...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  // Category Filter
                  QDropdownField(
                    label: "Filter by Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  
                  // Statistics Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email, color: primaryColor, size: 20),
                                SizedBox(width: spXs),
                                Text(
                                  "Total Messages",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${messages.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.send, color: successColor, size: 20),
                                SizedBox(width: spXs),
                                Text(
                                  "Sent Messages",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${messages.where((m) => m["status"] == "active").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.visibility, color: infoColor, size: 20),
                                SizedBox(width: spXs),
                                Text(
                                  "Avg Open Rate",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${((messages.where((m) => m["status"] == "active").map((m) => m["openRate"] as num).reduce((a, b) => a + b)) / messages.where((m) => m["status"] == "active").length).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Messages List
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Messages (${filteredMessages.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...filteredMessages.map((message) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${message["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(message["status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        _getStatusText(message["status"]),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor(message["status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${message["content"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      message["type"] == "email" ? Icons.email : Icons.sms,
                                      color: disabledBoldColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${message["type"].toString().toUpperCase()}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.group, color: disabledBoldColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${message["recipients"]} recipients",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    if (message["status"] == "active") ...[
                                      Text(
                                        "Open: ${(message["openRate"] as num).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Click: ${(message["clickRate"] as num).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sent: ${DateTime.parse(message["sentDate"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Spacer(),
                                    QButton(
                                      icon: Icons.edit,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to edit message
                                      },
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.copy,
                                      size: bs.sm,
                                      onPressed: () {
                                        ss("Message duplicated successfully");
                                      },
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.delete,
                                      size: bs.sm,
                                      onPressed: () async {
                                        bool isConfirmed = await confirm("Are you sure you want to delete this message?");
                                        if (isConfirmed) {
                                          messages.removeWhere((m) => m["id"] == message["id"]);
                                          setState(() {});
                                          ss("Message deleted successfully");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new message
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
