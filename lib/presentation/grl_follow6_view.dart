import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow6View extends StatefulWidget {
  @override
  State<GrlFollow6View> createState() => _GrlFollow6ViewState();
}

class _GrlFollow6ViewState extends State<GrlFollow6View> {
  String searchQuery = "";
  String selectedFilter = "All";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Mutual Friends", "value": "Mutual"},
    {"label": "Verified", "value": "Verified"},
  ];

  List<Map<String, dynamic>> followRequests = [
    {
      "id": 1,
      "name": "Jessica Martinez",
      "username": "@jessicam",
      "image": "https://picsum.photos/150/150?random=201&keyword=portrait",
      "bio": "Digital marketing specialist & content creator",
      "mutualFriends": 15,
      "requestDate": "2 hours ago",
      "isVerified": false,
      "category": "Business",
      "followers": 8500,
      "posts": 342,
    },
    {
      "id": 2,
      "name": "Alex Chen",
      "username": "@alexc_dev",
      "image": "https://picsum.photos/150/150?random=202&keyword=portrait",
      "bio": "Software engineer at Tech Corp",
      "mutualFriends": 7,
      "requestDate": "5 hours ago",
      "isVerified": true,
      "category": "Technology",
      "followers": 12300,
      "posts": 156,
    },
    {
      "id": 3,
      "name": "Sarah Williams",
      "username": "@sarahw_photo",
      "image": "https://picsum.photos/150/150?random=203&keyword=portrait",
      "bio": "Professional photographer capturing moments",
      "mutualFriends": 22,
      "requestDate": "1 day ago",
      "isVerified": false,
      "category": "Photography",
      "followers": 25600,
      "posts": 892,
    },
    {
      "id": 4,
      "name": "Michael Davis",
      "username": "@mike_fitness",
      "image": "https://picsum.photos/150/150?random=204&keyword=portrait",
      "bio": "Personal trainer & nutrition coach",
      "mutualFriends": 3,
      "requestDate": "2 days ago",
      "isVerified": true,
      "category": "Fitness",
      "followers": 18900,
      "posts": 567,
    },
    {
      "id": 5,
      "name": "Emma Thompson",
      "username": "@emma_travels",
      "image": "https://picsum.photos/150/150?random=205&keyword=portrait",
      "bio": "Travel blogger exploring the world",
      "mutualFriends": 11,
      "requestDate": "3 days ago",
      "isVerified": false,
      "category": "Travel",
      "followers": 34200,
      "posts": 1204,
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    List<Map<String, dynamic>> filtered = followRequests;

    if (selectedFilter != "All") {
      switch (selectedFilter) {
        case "Recent":
          filtered = filtered.where((request) {
            return "${request["requestDate"]}".contains("hour");
          }).toList();
          break;
        case "Mutual":
          filtered = filtered.where((request) {
            return (request["mutualFriends"] as int) > 10;
          }).toList();
          break;
        case "Verified":
          filtered = filtered.where((request) {
            return request["isVerified"] as bool;
          }).toList();
          break;
      }
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((request) {
        return "${request["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${request["username"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${request["bio"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  void _acceptRequest(Map<String, dynamic> request) {
    setState(() {
      followRequests.remove(request);
    });
    ss("Follow request from ${request["name"]} accepted");
  }

  void _declineRequest(Map<String, dynamic> request) {
    setState(() {
      followRequests.remove(request);
    });
    si("Follow request from ${request["name"]} declined");
  }

  void _acceptAllRequests() async {
    bool isConfirmed = await confirm("Accept all ${followRequests.length} follow requests?");
    if (isConfirmed) {
      setState(() {
        followRequests.clear();
      });
      ss("All follow requests accepted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow Requests"),
        actions: [
          if (followRequests.isNotEmpty)
            QButton(
              label: "Accept All",
              size: bs.sm,
              onPressed: _acceptAllRequests,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You have ${followRequests.length} pending follow requests",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search
            QTextField(
              label: "Search requests",
              value: searchQuery,
              hint: "Search by name or username",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filter
            QDropdownField(
              label: "Filter by",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Results Header
            Row(
              children: [
                Text(
                  "Requests",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredRequests.length} requests",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Requests List
            if (filteredRequests.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.person_add_disabled,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No follow requests",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      searchQuery.isNotEmpty
                          ? "No requests match your search"
                          : "When people request to follow you, they'll appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredRequests.map((request) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${request["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${request["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
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
                                Text(
                                  "${request["username"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${request["bio"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Requested ${request["requestDate"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if ((request["mutualFriends"] as int) > 0) ...[
                                      Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                                      Text(
                                        "${request["mutualFriends"]} mutual",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
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
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Decline",
                              size: bs.sm,
                              onPressed: () => _declineRequest(request),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Accept",
                              size: bs.sm,
                              onPressed: () => _acceptRequest(request),
                            ),
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
    );
  }
}
