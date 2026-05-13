import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaMessageRequestsView extends StatefulWidget {
  const SmaMessageRequestsView({super.key});

  @override
  State<SmaMessageRequestsView> createState() => _SmaMessageRequestsViewState();
}

class _SmaMessageRequestsViewState extends State<SmaMessageRequestsView> {
  String searchQuery = "";
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> messageRequests = [
    {
      "id": 1,
      "senderName": "Alex Johnson",
      "senderImage": "https://picsum.photos/50/50?random=1&keyword=profile",
      "message": "Hey! I found your profile through mutual friends. Would love to connect and chat about travel experiences!",
      "timestamp": "2024-06-16T10:30:00Z",
      "mutualFriends": 5,
      "isVerified": true,
      "requestType": "connection",
    },
    {
      "id": 2,
      "senderName": "Sarah Wilson",
      "senderImage": "https://picsum.photos/50/50?random=2&keyword=profile",
      "message": "Hi there! I noticed we have similar interests in photography. Would you like to chat?",
      "timestamp": "2024-06-16T09:15:00Z",
      "mutualFriends": 3,
      "isVerified": false,
      "requestType": "interest",
    },
    {
      "id": 3,
      "senderName": "Mike Chen",
      "senderImage": "https://picsum.photos/50/50?random=3&keyword=profile",
      "message": "Hello! I'm organizing a local hiking group and thought you might be interested in joining us.",
      "timestamp": "2024-06-16T08:45:00Z",
      "mutualFriends": 8,
      "isVerified": true,
      "requestType": "group",
    },
    {
      "id": 4,
      "senderName": "Emma Rodriguez",
      "senderImage": "https://picsum.photos/50/50?random=4&keyword=profile",
      "message": "Hi! I saw your post about cooking recipes and would love to exchange some family recipes with you.",
      "timestamp": "2024-06-15T22:20:00Z",
      "mutualFriends": 2,
      "isVerified": false,
      "requestType": "hobby",
    },
    {
      "id": 5,
      "senderName": "David Thompson",
      "senderImage": "https://picsum.photos/50/50?random=5&keyword=profile",
      "message": "Hey! We met at the tech conference last month. Hope you remember me, would love to stay in touch!",
      "timestamp": "2024-06-15T19:30:00Z",
      "mutualFriends": 12,
      "isVerified": true,
      "requestType": "professional",
    },
    {
      "id": 6,
      "senderName": "Lisa Park",
      "senderImage": "https://picsum.photos/50/50?random=6&keyword=profile",
      "message": "Hello! I'm new to the city and looking to make friends. Would you like to grab coffee sometime?",
      "timestamp": "2024-06-15T16:45:00Z",
      "mutualFriends": 1,
      "isVerified": false,
      "requestType": "social",
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    var filtered = messageRequests.where((request) {
      if (searchQuery.isNotEmpty) {
        return "${request["senderName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${request["message"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }
      return true;
    }).toList();

    if (selectedFilter != "all") {
      filtered = filtered.where((request) => request["requestType"] == selectedFilter).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Requests", "value": "all"},
    {"label": "Connection", "value": "connection"},
    {"label": "Interest", "value": "interest"},
    {"label": "Group", "value": "group"},
    {"label": "Hobby", "value": "hobby"},
    {"label": "Professional", "value": "professional"},
    {"label": "Social", "value": "social"},
  ];

  String _getRequestTypeColor(String type) {
    switch (type) {
      case "connection":
        return "blue";
      case "interest":
        return "purple";
      case "group":
        return "green";
      case "hobby":
        return "orange";
      case "professional":
        return "indigo";
      case "social":
        return "pink";
      default:
        return "gray";
    }
  }

  Color _getTypeColor(String colorName) {
    switch (colorName) {
      case "blue":
        return Colors.blue;
      case "purple":
        return Colors.purple;
      case "green":
        return Colors.green;
      case "orange":
        return Colors.orange;
      case "indigo":
        return Colors.indigo;
      case "pink":
        return Colors.pink;
      default:
        return disabledColor;
    }
  }

  void _handleRequest(Map<String, dynamic> request, String action) {
    if (action == "accept") {
      ss("Message request accepted from ${request["senderName"]}");
    } else if (action == "decline") {
      sw("Message request declined from ${request["senderName"]}");
    } else if (action == "block") {
      se("User ${request["senderName"]} has been blocked");
    }

    setState(() {
      messageRequests.removeWhere((r) => r["id"] == request["id"]);
    });
  }

  void _showRequestDetails(Map<String, dynamic> request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${request["senderImage"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${request["senderName"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (request["isVerified"] as bool) ...[
                            SizedBox(width: spXs),
                            Icon(
                              Icons.verified,
                              color: primaryColor,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(request["mutualFriends"] as int)} mutual friends",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${request["message"]}",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Accept",
                    onPressed: () {
                      back();
                      _handleRequest(request, "accept");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Decline",
                      color: disabledBoldColor,
                      onPressed: () {
                        back();
                        _handleRequest(request, "decline");
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Block User",
                color: dangerColor,
                onPressed: () {
                  back();
                  _handleRequest(request, "block");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Filter Requests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spMd),
                      ...filterOptions.map((option) => ListTile(
                        title: Text("${option["label"]}"),
                        leading: Radio<String>(
                          value: "${option["value"]}",
                          groupValue: selectedFilter,
                          onChanged: (value) {
                            setState(() {
                              selectedFilter = value!;
                            });
                            back();
                          },
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search requests...",
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
          ),
          if (filteredRequests.isEmpty) ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Message Requests",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "You don't have any pending message requests",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                itemCount: filteredRequests.length,
                itemBuilder: (context, index) {
                  final request = filteredRequests[index];
                  final requestType = "${request["requestType"]}";
                  final typeColor = _getTypeColor(_getRequestTypeColor(requestType));
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusMd),
                        onTap: () => _showRequestDetails(request),
                        child: Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage("${request["senderImage"]}"),
                                      ),
                                      if (request["isVerified"] as bool)
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.verified,
                                              color: primaryColor,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${request["senderName"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: typeColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                requestType.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: typeColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${(request["mutualFriends"] as int)} mutual friends",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    DateTime.parse("${request["timestamp"]}").dMMMy,
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${request["message"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Accept",
                                      size: bs.sm,
                                      onPressed: () => _handleRequest(request, "accept"),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: QButton(
                                        label: "Decline",
                                        size: bs.sm,
                                        color: disabledBoldColor,
                                        onPressed: () => _handleRequest(request, "decline"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.more_vert,
                                    size: bs.sm,
                                    color: disabledBoldColor,
                                    onPressed: () => _showRequestDetails(request),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
