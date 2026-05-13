import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast4View extends StatefulWidget {
  @override
  State<GrlBroadcast4View> createState() => _GrlBroadcast4ViewState();
}

class _GrlBroadcast4ViewState extends State<GrlBroadcast4View> {
  int currentTab = 0;
  String searchQuery = "";
  bool isLive = true;

  List<Map<String, dynamic>> liveStreams = [
    {
      "id": 1,
      "title": "Breaking News: Economic Summit",
      "host": "Sarah Johnson",
      "viewers": 15420,
      "duration": "45 min",
      "category": "News",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=news",
      "isLive": true,
      "avatar": "https://picsum.photos/50/50?random=101&keyword=person"
    },
    {
      "id": 2,
      "title": "Tech Talk: AI Revolution",
      "host": "Michael Chen",
      "viewers": 8930,
      "duration": "1h 15min",
      "category": "Technology",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=technology",
      "isLive": true,
      "avatar": "https://picsum.photos/50/50?random=102&keyword=man"
    },
    {
      "id": 3,
      "title": "Cooking Masterclass",
      "host": "Elena Rodriguez",
      "viewers": 6750,
      "duration": "30 min",
      "category": "Lifestyle",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=cooking",
      "isLive": true,
      "avatar": "https://picsum.photos/50/50?random=103&keyword=woman"
    }
  ];

  List<Map<String, dynamic>> upcomingStreams = [
    {
      "id": 4,
      "title": "Sports Analysis Tonight",
      "host": "David Wilson",
      "scheduledTime": "8:00 PM",
      "category": "Sports",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=sports",
      "subscribers": 12500,
      "avatar": "https://picsum.photos/50/50?random=104&keyword=person"
    },
    {
      "id": 5,
      "title": "Music Jam Session",
      "host": "Lisa Park",
      "scheduledTime": "9:30 PM",
      "category": "Music",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=music",
      "subscribers": 8900,
      "avatar": "https://picsum.photos/50/50?random=105&keyword=artist"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "count": 150, "active": true},
    {"name": "News", "count": 45, "active": false},
    {"name": "Tech", "count": 32, "active": false},
    {"name": "Sports", "count": 28, "active": false},
    {"name": "Music", "count": 25, "active": false},
    {"name": "Gaming", "count": 20, "active": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: spLg),
            _buildSearchBar(),
            SizedBox(height: spLg),
            _buildCategoryFilter(),
            SizedBox(height: spLg),
            _buildLiveIndicator(),
            SizedBox(height: spMd),
            _buildLiveStreams(),
            SizedBox(height: spLg),
            _buildUpcomingSection(),
            SizedBox(height: spMd),
            _buildUpcomingStreams(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: dangerColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            Icons.live_tv,
            color: Colors.white,
            size: 24,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Live Broadcast",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Watch live streams and upcoming shows",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: successColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "LIVE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search broadcasts...",
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
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: categories.map((category) {
            return Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: (category["active"] as bool) ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: (category["active"] as bool) ? primaryColor : disabledOutlineBorderColor,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${category["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: (category["active"] as bool) ? Colors.white : disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (category["active"] as bool) ? Colors.white.withAlpha(20) : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${category["count"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (category["active"] as bool) ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLiveIndicator() {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: dangerColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Text(
          "Live Now",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Text(
          "${liveStreams.length} streams",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLiveStreams() {
    return Column(
      children: liveStreams.map((stream) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                    child: Image.network(
                      "${stream["thumbnail"]}",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: Colors.white, size: 8),
                          SizedBox(width: spXs),
                          Text(
                            "LIVE",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility, color: Colors.white, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${(stream["viewers"] as int) > 1000 ? '${((stream["viewers"] as int) / 1000).toStringAsFixed(1)}K' : stream["viewers"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${stream["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${stream["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${stream["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${stream["host"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${stream["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Watch Now",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingSection() {
    return Row(
      children: [
        Icon(
          Icons.schedule,
          color: warningColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Text(
          "Upcoming Shows",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Text(
          "${upcomingStreams.length} scheduled",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingStreams() {
    return Column(
      children: upcomingStreams.map((stream) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: warningColor.withAlpha(50)),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${stream["thumbnail"]}",
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${stream["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage("${stream["avatar"]}"),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${stream["host"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${stream["scheduledTime"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(Icons.people, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${(stream["subscribers"] as int) > 1000 ? '${((stream["subscribers"] as int) / 1000).toStringAsFixed(1)}K' : stream["subscribers"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Remind Me",
                size: bs.sm,
                onPressed: () {
                  ss("Reminder set successfully");
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
