import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPropertyVideoView extends StatefulWidget {
  const RmaPropertyVideoView({super.key});

  @override
  State<RmaPropertyVideoView> createState() => _RmaPropertyVideoViewState();
}

class _RmaPropertyVideoViewState extends State<RmaPropertyVideoView> {
  List<Map<String, dynamic>> propertyVideos = [
    {
      "id": "1",
      "title": "Virtual Tour - Living Room",
      "thumbnail": "https://picsum.photos/400/250?random=1&keyword=livingroom",
      "duration": "2:45",
      "type": "Virtual Tour",
      "views": 1250,
      "uploadDate": "2024-12-15",
      "isHD": true,
      "description": "Spacious living room with modern furnishings and natural lighting",
    },
    {
      "id": "2", 
      "title": "Kitchen Walkthrough",
      "thumbnail": "https://picsum.photos/400/250?random=2&keyword=kitchen",
      "duration": "1:30",
      "type": "Walkthrough",
      "views": 980,
      "uploadDate": "2024-12-14",
      "isHD": true,
      "description": "Modern kitchen with granite countertops and stainless steel appliances",
    },
    {
      "id": "3",
      "title": "Master Bedroom Suite",
      "thumbnail": "https://picsum.photos/400/250?random=3&keyword=bedroom",
      "duration": "3:20",
      "type": "Room Tour",
      "views": 1580,
      "uploadDate": "2024-12-13",
      "isHD": false,
      "description": "Luxurious master bedroom with walk-in closet and en-suite bathroom",
    },
    {
      "id": "4",
      "title": "Outdoor Spaces & Garden",
      "thumbnail": "https://picsum.photos/400/250?random=4&keyword=garden",
      "duration": "4:15",
      "type": "Exterior",
      "views": 2100,
      "uploadDate": "2024-12-12",
      "isHD": true,
      "description": "Beautiful landscaped garden with patio and outdoor entertainment area",
    },
    {
      "id": "5",
      "title": "Basement Recreation Room",
      "thumbnail": "https://picsum.photos/400/250?random=5&keyword=basement",
      "duration": "2:10",
      "type": "Room Tour",
      "views": 750,
      "uploadDate": "2024-12-11",
      "isHD": true,
      "description": "Finished basement with entertainment center and game area",
    },
    {
      "id": "6",
      "title": "Neighborhood Overview",
      "thumbnail": "https://picsum.photos/400/250?random=6&keyword=neighborhood",
      "duration": "5:30",
      "type": "Area Tour",
      "views": 1890,
      "uploadDate": "2024-12-10",
      "isHD": true,
      "description": "Comprehensive tour of the surrounding neighborhood and amenities",
    },
  ];

  List<String> videoCategories = ["All", "Virtual Tour", "Walkthrough", "Room Tour", "Exterior", "Area Tour"];
  String selectedCategory = "All";
  bool showHDOnly = false;

  List<Map<String, dynamic>> get filteredVideos {
    return propertyVideos.where((video) {
      bool categoryMatch = selectedCategory == "All" || video["type"] == selectedCategory;
      bool hdMatch = !showHDOnly || (video["isHD"] as bool);
      return categoryMatch && hdMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Videos"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyHeader(),
            SizedBox(height: spLg),
            _buildVideoStats(),
            SizedBox(height: spLg),
            _buildCategoryFilter(),
            SizedBox(height: spLg),
            _buildVideoGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/160/160?random=100&keyword=house"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Modern Family Home",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "123 Maple Street, Downtown",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.video_library, size: 16, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "${propertyVideos.length} Videos",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoStats() {
    int totalViews = propertyVideos.fold(0, (sum, video) => sum + (video["views"] as int));
    String totalDuration = _calculateTotalDuration();
    int hdVideos = propertyVideos.where((v) => v["isHD"] as bool).length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.visibility, size: 32, color: infoColor),
                SizedBox(height: spSm),
                Text(
                  "${(totalViews / 1000).toStringAsFixed(1)}K",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Views",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.access_time, size: 32, color: warningColor),
                SizedBox(height: spSm),
                Text(
                  totalDuration,
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Duration",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.hd, size: 32, color: successColor),
                SizedBox(height: spSm),
                Text(
                  "$hdVideos",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "HD Videos",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Video Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: videoCategories.map((category) {
            bool isSelected = selectedCategory == category;
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: QButton(
                label: category,
                size: bs.sm,
                color: isSelected ? primaryColor : disabledColor,
                onPressed: () {
                  selectedCategory = category;
                  setState(() {});
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVideoGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Videos (${filteredVideos.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.hd,
                  size: 16,
                  color: showHDOnly ? successColor : disabledColor,
                ),
                SizedBox(width: spXs),
                Switch(
                  value: showHDOnly,
                  onChanged: (value) {
                    showHDOnly = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: filteredVideos.map((video) {
            return _buildVideoCard(video);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVideoCard(Map<String, dynamic> video) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${video["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
              if (video["isHD"] as bool)
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "HD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(64),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  ),
                  child: Icon(
                    Icons.play_circle_filled,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${video["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${video["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${video["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.visibility, size: 12, color: disabledColor),
                    SizedBox(width: 2),
                    Text(
                      "${video["views"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Watch",
                        size: bs.sm,
                        icon: Icons.play_arrow,
                        onPressed: () => _watchVideo(video),
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      color: disabledColor,
                      onPressed: () => _shareVideo(video),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalDuration() {
    int totalMinutes = 0;
    for (var video in propertyVideos) {
      String duration = video["duration"];
      List<String> parts = duration.split(":");
      totalMinutes += (int.parse(parts[0]) * 60) + int.parse(parts[1]);
    }
    int hours = (totalMinutes / 60).floor();
    int minutes = totalMinutes % 60;
    return hours > 0 ? "${hours}h ${minutes}m" : "${minutes}m";
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Videos"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.hd, color: successColor),
                SizedBox(width: spSm),
                Text("Show HD Only"),
                Spacer(),
                Switch(
                  value: showHDOnly,
                  onChanged: (value) {
                    showHDOnly = value;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _watchVideo(Map<String, dynamic> video) {
    ss("Playing: ${video["title"]}");
  }

  void _shareVideo(Map<String, dynamic> video) {
    ss("Sharing: ${video["title"]}");
  }
}
