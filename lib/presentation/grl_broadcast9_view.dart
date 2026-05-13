import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast9View extends StatefulWidget {
  @override
  State<GrlBroadcast9View> createState() => _GrlBroadcast9ViewState();
}

class _GrlBroadcast9ViewState extends State<GrlBroadcast9View> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool isGridView = true;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Broadcasts", "value": "All"},
    {"label": "Live Now", "value": "Live"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Recorded", "value": "Recorded"},
    {"label": "Draft", "value": "Draft"},
  ];

  List<Map<String, dynamic>> broadcasts = [
    {
      "id": 1,
      "title": "Tech Innovation Summit 2024",
      "description": "Latest trends in artificial intelligence and machine learning",
      "status": "Live",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=tech",
      "duration": "2h 45m",
      "viewers": 15420,
      "startTime": "10:00 AM",
      "date": "Today",
      "category": "Technology",
      "isLive": true
    },
    {
      "id": 2,
      "title": "Weekly Sports Analysis",
      "description": "Comprehensive analysis of weekend matches and player performance",
      "status": "Scheduled",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=sports",
      "duration": "1h 30m",
      "viewers": 0,
      "startTime": "3:00 PM",
      "date": "Tomorrow",
      "category": "Sports",
      "isLive": false
    },
    {
      "id": 3,
      "title": "Cooking Masterclass: Italian Cuisine",
      "description": "Learn authentic Italian recipes from professional chefs",
      "status": "Recorded",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=cooking",
      "duration": "3h 15m",
      "viewers": 28600,
      "startTime": "2:00 PM",
      "date": "Jan 18",
      "category": "Lifestyle",
      "isLive": false
    },
    {
      "id": 4,
      "title": "Financial Market Updates",
      "description": "Daily market analysis and investment insights",
      "status": "Live",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=finance",
      "duration": "1h 20m",
      "viewers": 9800,
      "startTime": "9:00 AM",
      "date": "Today",
      "category": "Finance",
      "isLive": true
    },
    {
      "id": 5,
      "title": "Music Production Workshop",
      "description": "Behind the scenes of creating hit songs",
      "status": "Draft",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=music",
      "duration": "2h 00m",
      "viewers": 0,
      "startTime": "7:00 PM",
      "date": "Jan 25",
      "category": "Music",
      "isLive": false
    },
    {
      "id": 6,
      "title": "Gaming Tournament Finals",
      "description": "Championship finals with top esports teams",
      "status": "Scheduled",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=gaming",
      "duration": "4h 00m",
      "viewers": 0,
      "startTime": "6:00 PM",
      "date": "Jan 22",
      "category": "Gaming",
      "isLive": false
    }
  ];

  List<Map<String, dynamic>> get filteredBroadcasts {
    List<Map<String, dynamic>> filtered = broadcasts;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((broadcast) => broadcast["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((broadcast) => 
        (broadcast["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (broadcast["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

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
            _buildSearchAndFilter(),
            SizedBox(height: spLg),
            _buildViewToggle(),
            SizedBox(height: spMd),
            _buildBroadcastsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Create new broadcast");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [dangerColor, warningColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.video_library,
            color: Colors.white,
            size: 28,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Broadcasts",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Manage all your live streams and recordings",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        _buildStatsCard(),
      ],
    );
  }

  Widget _buildStatsCard() {
    int liveCount = broadcasts.where((b) => b["status"] == "Live").length;
    int scheduledCount = broadcasts.where((b) => b["status"] == "Scheduled").length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatItem("Live", liveCount, dangerColor),
              SizedBox(width: spMd),
              _buildStatItem("Scheduled", scheduledCount, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
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

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        Row(
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
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: filterOptions.map((filter) {
            bool isSelected = selectedFilter == filter["value"];
            int count = filter["value"] == "All" 
                ? broadcasts.length 
                : broadcasts.where((b) => b["status"] == filter["value"]).length;
            
            return GestureDetector(
              onTap: () {
                selectedFilter = filter["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${filter["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withAlpha(30) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$count",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildViewToggle() {
    return Row(
      children: [
        Text(
          "${filteredBroadcasts.length} broadcasts found",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                isGridView = false;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: !isGridView ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: primaryColor),
                ),
                child: Icon(
                  Icons.list,
                  color: !isGridView ? Colors.white : primaryColor,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: spXs),
            GestureDetector(
              onTap: () {
                isGridView = true;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: isGridView ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: primaryColor),
                ),
                child: Icon(
                  Icons.grid_view,
                  color: isGridView ? Colors.white : primaryColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBroadcastsList() {
    if (isGridView) {
      return ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 300,
        children: filteredBroadcasts.map((broadcast) => _buildGridBroadcastCard(broadcast)).toList(),
      );
    } else {
      return Column(
        children: filteredBroadcasts.map((broadcast) => _buildListBroadcastCard(broadcast)).toList(),
      );
    }
  }

  Widget _buildGridBroadcastCard(Map<String, dynamic> broadcast) {
    Color statusColor = _getStatusColor(broadcast["status"]);
    
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
                  "${broadcast["thumbnail"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (broadcast["isLive"] as bool)
                        Icon(Icons.circle, color: Colors.white, size: 8)
                      else
                        Icon(_getStatusIcon(broadcast["status"]), color: Colors.white, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${broadcast["status"]}".toUpperCase(),
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
              if (broadcast["isLive"] as bool)
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
                      "${(broadcast["viewers"] as int) > 1000 ? '${((broadcast["viewers"] as int) / 1000).toStringAsFixed(1)}K' : broadcast["viewers"]} viewers",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                    "${broadcast["duration"]}",
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
                Text(
                  "${broadcast["title"]}",
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
                  "${broadcast["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${broadcast["startTime"]} • ${broadcast["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${broadcast["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    _buildActionButton(broadcast),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListBroadcastCard(Map<String, dynamic> broadcast) {
    Color statusColor = _getStatusColor(broadcast["status"]);
    
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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${broadcast["thumbnail"]}",
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${broadcast["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                  "${broadcast["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${broadcast["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${broadcast["startTime"]} • ${broadcast["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (broadcast["isLive"] as bool) ...[
                      Icon(Icons.visibility, size: 14, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "${(broadcast["viewers"] as int) > 1000 ? '${((broadcast["viewers"] as int) / 1000).toStringAsFixed(1)}K' : broadcast["viewers"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          _buildActionButton(broadcast),
        ],
      ),
    );
  }

  Widget _buildActionButton(Map<String, dynamic> broadcast) {
    String status = broadcast["status"];
    
    switch (status) {
      case "Live":
        return QButton(
          label: "View",
          size: bs.sm,
          onPressed: () {},
        );
      case "Scheduled":
        return QButton(
          label: "Edit",
          size: bs.sm,
          onPressed: () {},
        );
      case "Recorded":
        return QButton(
          label: "Watch",
          size: bs.sm,
          onPressed: () {},
        );
      case "Draft":
        return QButton(
          label: "Complete",
          size: bs.sm,
          onPressed: () {},
        );
      default:
        return QButton(
          icon: Icons.more_vert,
          size: bs.sm,
          onPressed: () {},
        );
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live":
        return dangerColor;
      case "Scheduled":
        return warningColor;
      case "Recorded":
        return successColor;
      case "Draft":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Live":
        return Icons.circle;
      case "Scheduled":
        return Icons.schedule;
      case "Recorded":
        return Icons.play_circle_filled;
      case "Draft":
        return Icons.edit;
      default:
        return Icons.broadcast_on_personal;
    }
  }
}
