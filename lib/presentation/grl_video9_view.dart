import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVideo9View extends StatefulWidget {
  @override
  State<GrlVideo9View> createState() => _GrlVideo9ViewState();
}

class _GrlVideo9ViewState extends State<GrlVideo9View> {
  String selectedTab = "Subscriptions";
  String searchQuery = "";
  bool isCreatorMode = false;

  List<Map<String, dynamic>> subscriptions = [
    {
      "id": "1",
      "name": "Tech Reviews Pro",
      "avatar": "https://picsum.photos/60/60?random=91&keyword=tech",
      "subscribers": 2500000,
      "isVerified": true,
      "isSubscribed": true,
      "latestVideo": {
        "title": "iPhone 15 Pro Max Complete Review",
        "thumbnail": "https://picsum.photos/300/200?random=191&keyword=iphone",
        "duration": "15:30",
        "views": 1200000,
        "uploadTime": "2 days ago",
      },
      "category": "Technology",
      "notificationEnabled": true,
    },
    {
      "id": "2",
      "name": "Cooking With Sarah",
      "avatar": "https://picsum.photos/60/60?random=92&keyword=cooking",
      "subscribers": 1800000,
      "isVerified": true,
      "isSubscribed": true,
      "latestVideo": {
        "title": "5-Minute Pasta Recipes",
        "thumbnail": "https://picsum.photos/300/200?random=192&keyword=pasta",
        "duration": "8:45",
        "views": 890000,
        "uploadTime": "1 day ago",
      },
      "category": "Food & Cooking",
      "notificationEnabled": false,
    },
    {
      "id": "3",
      "name": "Fitness Journey",
      "avatar": "https://picsum.photos/60/60?random=93&keyword=fitness",
      "subscribers": 950000,
      "isVerified": false,
      "isSubscribed": true,
      "latestVideo": {
        "title": "30-Day Abs Challenge",
        "thumbnail": "https://picsum.photos/300/200?random=193&keyword=workout",
        "duration": "12:20",
        "views": 567000,
        "uploadTime": "3 days ago",
      },
      "category": "Health & Fitness",
      "notificationEnabled": true,
    },
    {
      "id": "4",
      "name": "Music Covers Studio",
      "avatar": "https://picsum.photos/60/60?random=94&keyword=music",
      "subscribers": 3200000,
      "isVerified": true,
      "isSubscribed": true,
      "latestVideo": {
        "title": "Top 10 Songs Acoustic Cover",
        "thumbnail": "https://picsum.photos/300/200?random=194&keyword=guitar",
        "duration": "25:15",
        "views": 2100000,
        "uploadTime": "5 days ago",
      },
      "category": "Music",
      "notificationEnabled": true,
    },
  ];

  List<Map<String, dynamic>> trending = [
    {
      "id": "1",
      "creator": "Viral Moments",
      "avatar": "https://picsum.photos/50/50?random=95&keyword=viral",
      "title": "Most Watched Video This Week",
      "thumbnail": "https://picsum.photos/300/200?random=195&keyword=trending",
      "duration": "3:42",
      "views": 15000000,
      "likes": 2800000,
      "uploadTime": "1 week ago",
      "category": "Entertainment",
      "trendingRank": 1,
    },
    {
      "id": "2",
      "creator": "News Today",
      "avatar": "https://picsum.photos/50/50?random=96&keyword=news",
      "title": "Breaking: Major Tech Announcement",
      "thumbnail": "https://picsum.photos/300/200?random=196&keyword=tech",
      "duration": "12:05",
      "views": 8500000,
      "likes": 1200000,
      "uploadTime": "2 days ago",
      "category": "News",
      "trendingRank": 2,
    },
    {
      "id": "3",
      "creator": "Comedy Central",
      "avatar": "https://picsum.photos/50/50?random=97&keyword=comedy",
      "title": "Funniest Moments Compilation",
      "thumbnail": "https://picsum.photos/300/200?random=197&keyword=funny",
      "duration": "18:30",
      "views": 6200000,
      "likes": 890000,
      "uploadTime": "4 days ago",
      "category": "Comedy",
      "trendingRank": 3,
    },
  ];

  List<Map<String, dynamic>> recommended = [
    {
      "id": "1",
      "creator": "Learn Coding",
      "avatar": "https://picsum.photos/50/50?random=98&keyword=coding",
      "title": "Full Stack Development Course",
      "thumbnail": "https://picsum.photos/300/200?random=198&keyword=programming",
      "duration": "4:35:20",
      "views": 3200000,
      "uploadTime": "1 week ago",
      "category": "Education",
      "watchProgress": 0.25,
    },
    {
      "id": "2",
      "creator": "Travel Vlogs",
      "avatar": "https://picsum.photos/50/50?random=99&keyword=travel",
      "title": "Amazing Places You Must Visit",
      "thumbnail": "https://picsum.photos/300/200?random=199&keyword=travel",
      "duration": "22:15",
      "views": 1800000,
      "uploadTime": "3 days ago",
      "category": "Travel",
      "watchProgress": 0.0,
    },
  ];

  Widget _buildSubscriptionCard(Map<String, dynamic> subscription) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${subscription["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${subscription["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (subscription["isVerified"] as bool) ...[
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
                        "${((subscription["subscribers"] as int) / 1000000).toStringAsFixed(1)}M subscribers",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        subscription["notificationEnabled"] = !subscription["notificationEnabled"];
                        setState(() {});
                      },
                      child: Icon(
                        subscription["notificationEnabled"] as bool ? Icons.notifications : Icons.notifications_off,
                        color: subscription["notificationEnabled"] as bool ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            margin: EdgeInsets.symmetric(horizontal: spMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${subscription["latestVideo"]["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(179),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${subscription["latestVideo"]["duration"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${subscription["latestVideo"]["title"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${((subscription["latestVideo"]["views"] as int) / 1000000).toStringAsFixed(1)}M views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${subscription["latestVideo"]["uploadTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${subscription["category"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCard(Map<String, dynamic> video) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 80,
            margin: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: video["trendingRank"] == 1 ? warningColor :
                     video["trendingRank"] == 2 ? disabledBoldColor :
                     successColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Center(
              child: Text(
                "#${video["trendingRank"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${video["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(179),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${video["duration"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${video["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${video["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${video["creator"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.whatshot,
                      color: warningColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${((video["views"] as int) / 1000000).toInt()}M views",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.favorite,
                      color: dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${((video["likes"] as int) / 1000000).toStringAsFixed(1)}M",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(Map<String, dynamic> video) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              image: DecorationImage(
                image: NetworkImage("${video["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                if ((video["watchProgress"] as double) > 0)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: video["watchProgress"] as double,
                      backgroundColor: Colors.white.withAlpha(77),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                Positioned(
                  bottom: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(179),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${video["duration"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${video["title"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${video["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${video["creator"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${((video["views"] as int) / 1000000).toStringAsFixed(1)}M views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${video["uploadTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${video["category"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Library"),
        actions: [
          GestureDetector(
            onTap: () {
              isCreatorMode = !isCreatorMode;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: isCreatorMode ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor),
              ),
              child: Text(
                "Creator",
                style: TextStyle(
                  color: isCreatorMode ? Colors.white : primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.notifications,
                color: primaryColor,
              ),
            ),
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
                    label: "Search your library...",
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
          QCategoryPicker(
            items: [
              {"label": "Subscriptions", "value": "Subscriptions"},
              {"label": "Trending", "value": "Trending"},
              {"label": "Recommended", "value": "Recommended"},
            ],
            value: selectedTab,
            onChanged: (index, label, value, item) {
              selectedTab = value;
              setState(() {});
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedTab == "Subscriptions") ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest from subscriptions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Manage",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Column(
                      children: subscriptions.map((subscription) {
                        return _buildSubscriptionCard(subscription);
                      }).toList(),
                    ),
                  ] else if (selectedTab == "Trending") ...[
                    Text(
                      "Trending Now",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Column(
                      children: trending.map((video) {
                        return _buildTrendingCard(video);
                      }).toList(),
                    ),
                  ] else if (selectedTab == "Recommended") ...[
                    Text(
                      "Recommended for you",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Column(
                      children: recommended.map((video) {
                        return _buildRecommendedCard(video);
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: isCreatorMode ? GestureDetector(
        onTap: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.video_call,
            color: Colors.white,
            size: 30,
          ),
        ),
      ) : null,
    );
  }
}
