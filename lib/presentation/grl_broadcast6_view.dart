import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast6View extends StatefulWidget {
  @override
  State<GrlBroadcast6View> createState() => _GrlBroadcast6ViewState();
}

class _GrlBroadcast6ViewState extends State<GrlBroadcast6View> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> featuredChannels = [
    {
      "id": 1,
      "name": "TechNews Daily",
      "description": "Latest technology news and reviews",
      "subscribers": 245000,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=tech",
      "cover": "https://picsum.photos/300/120?random=1&keyword=technology",
      "isLive": true,
      "currentShow": "AI Revolution Discussion",
      "viewers": 12500,
      "category": "Technology"
    },
    {
      "id": 2,
      "name": "SportsCentral",
      "description": "Live sports coverage and analysis",
      "subscribers": 180000,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=sports",
      "cover": "https://picsum.photos/300/120?random=2&keyword=sports",
      "isLive": true,
      "currentShow": "Match Analysis",
      "viewers": 8900,
      "category": "Sports"
    },
    {
      "id": 3,
      "name": "CookingMasters",
      "description": "Professional cooking tutorials",
      "subscribers": 120000,
      "avatar": "https://picsum.photos/80/80?random=3&keyword=cooking",
      "cover": "https://picsum.photos/300/120?random=3&keyword=cooking",
      "isLive": false,
      "currentShow": "Italian Cuisine Basics",
      "viewers": 0,
      "category": "Lifestyle"
    }
  ];

  List<Map<String, dynamic>> myChannels = [
    {
      "id": 1,
      "name": "My Tech Channel",
      "description": "Personal technology reviews and tutorials",
      "subscribers": 5600,
      "avatar": "https://picsum.photos/80/80?random=11&keyword=person",
      "cover": "https://picsum.photos/300/120?random=11&keyword=tech",
      "totalViews": 125000,
      "totalVideos": 45,
      "status": "Active"
    },
    {
      "id": 2,
      "name": "Creative Studio",
      "description": "Design and creative content",
      "subscribers": 2300,
      "avatar": "https://picsum.photos/80/80?random=12&keyword=art",
      "cover": "https://picsum.photos/300/120?random=12&keyword=design",
      "totalViews": 67000,
      "totalVideos": 23,
      "status": "Active"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "count": 150, "active": true},
    {"name": "Technology", "count": 45, "active": false},
    {"name": "Sports", "count": 32, "active": false},
    {"name": "Lifestyle", "count": 28, "active": false},
    {"name": "Education", "count": 25, "active": false},
    {"name": "Entertainment", "count": 20, "active": false}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Broadcast Channels",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "My Channels", icon: Icon(Icons.tv)),
        Tab(text: "Following", icon: Icon(Icons.favorite)),
      ],
      tabChildren: [
        _buildDiscoverTab(),
        _buildMyChannelsTab(),
        _buildFollowingTab(),
      ],
    );
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          SizedBox(height: spLg),
          _buildCategoryFilter(),
          SizedBox(height: spLg),
          _buildLiveChannelsSection(),
          SizedBox(height: spMd),
          _buildFeaturedChannels(),
          SizedBox(height: spLg),
          _buildTrendingSection(),
        ],
      ),
    );
  }

  Widget _buildMyChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreateChannelButton(),
          SizedBox(height: spLg),
          _buildMyChannelsList(),
          SizedBox(height: spLg),
          _buildChannelAnalytics(),
        ],
      ),
    );
  }

  Widget _buildFollowingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFollowingHeader(),
          SizedBox(height: spMd),
          _buildFollowingChannels(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search channels...",
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
                      color: (category["active"] as bool) ? Colors.white.withAlpha(30) : disabledColor,
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

  Widget _buildLiveChannelsSection() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: dangerColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.circle,
            color: Colors.white,
            size: 8,
          ),
        ),
        SizedBox(width: spSm),
        Text(
          "Live Channels",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Text(
          "${featuredChannels.where((c) => c["isLive"] as bool).length} live",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedChannels() {
    return Column(
      children: featuredChannels.map((channel) {
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
                      "${channel["cover"]}",
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (channel["isLive"] as bool)
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
                  if (channel["isLive"] as bool)
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(channel["viewers"] as int) > 1000 ? '${((channel["viewers"] as int) / 1000).toStringAsFixed(1)}K' : channel["viewers"]} viewers",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
                          radius: 25,
                          backgroundImage: NetworkImage("${channel["avatar"]}"),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${channel["name"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${channel["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                            "${channel["category"]}",
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
                    if (channel["isLive"] as bool)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: dangerColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.live_tv, color: dangerColor, size: 16),
                            SizedBox(width: spSm),
                            Text(
                              "Now: ${channel["currentShow"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(Icons.people, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${(channel["subscribers"] as int) > 1000 ? '${((channel["subscribers"] as int) / 1000).toStringAsFixed(1)}K' : channel["subscribers"]} subscribers",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            QButton(
                              label: "Follow",
                              size: bs.sm,
                              onPressed: () {
                                ss("Following ${channel["name"]}");
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.play_arrow,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
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

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.trending_up,
              color: warningColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Trending Channels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: featuredChannels.map((channel) {
            return Container(
              width: 200,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                    child: Image.network(
                      "${channel["cover"]}",
                      width: double.infinity,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage("${channel["avatar"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${channel["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(channel["subscribers"] as int) > 1000 ? '${((channel["subscribers"] as int) / 1000).toStringAsFixed(1)}K' : channel["subscribers"]} subscribers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
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

  Widget _buildCreateChannelButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            "Create New Channel",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Start broadcasting and build your audience",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Get Started",
            size: bs.sm,
            onPressed: () {
              si("Channel creation wizard opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMyChannelsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Channels",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Column(
          children: myChannels.map((channel) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${channel["avatar"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${channel["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${channel["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            _buildChannelStat("Subscribers", "${channel["subscribers"]}"),
                            SizedBox(width: spMd),
                            _buildChannelStat("Videos", "${channel["totalVideos"]}"),
                            SizedBox(width: spMd),
                            _buildChannelStat("Views", "${(channel["totalViews"] as int) > 1000 ? '${((channel["totalViews"] as int) / 1000).toStringAsFixed(1)}K' : channel["totalViews"]}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Manage",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildChannelStat(String label, String value) {
    return Column(
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
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelAnalytics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Channel Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticCard(
                  title: "Total Views",
                  value: "192K",
                  change: "+15.2%",
                  color: successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticCard(
                  title: "Subscribers",
                  value: "7.9K",
                  change: "+8.1%",
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticCard(
                  title: "Watch Time",
                  value: "1.2K hrs",
                  change: "+12.5%",
                  color: warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticCard(
                  title: "Revenue",
                  value: "\$245",
                  change: "+22.3%",
                  color: dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticCard({
    required String title,
    required String value,
    required String change,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowingHeader() {
    return Row(
      children: [
        Icon(
          Icons.favorite,
          color: dangerColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Text(
          "Following",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Text(
          "8 channels",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFollowingChannels() {
    return Column(
      children: featuredChannels.take(2).map((channel) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${channel["avatar"]}"),
                  ),
                  if (channel["isLive"] as bool)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 8,
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
                    Text(
                      "${channel["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    if (channel["isLive"] as bool)
                      Text(
                        "Live: ${channel["currentShow"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      Text(
                        "${channel["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    SizedBox(height: spXs),
                    Text(
                      "${(channel["subscribers"] as int) > 1000 ? '${((channel["subscribers"] as int) / 1000).toStringAsFixed(1)}K' : channel["subscribers"]} subscribers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (channel["isLive"] as bool)
                QButton(
                  label: "Watch",
                  size: bs.sm,
                  onPressed: () {},
                )
              else
                QButton(
                  icon: Icons.notifications,
                  size: bs.sm,
                  onPressed: () {},
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
