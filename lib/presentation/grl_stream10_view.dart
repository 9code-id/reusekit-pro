import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream10View extends StatefulWidget {
  @override
  State<GrlStream10View> createState() => _GrlStream10ViewState();
}

class _GrlStream10ViewState extends State<GrlStream10View> {
  String selectedFilter = "All";
  bool isGridView = true;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Following", "value": "Following"},
    {"label": "Recommended", "value": "Recommended"},
    {"label": "Trending", "value": "Trending"},
  ];

  List<Map<String, dynamic>> liveStreams = [
    {
      "id": 1,
      "title": "Epic Gaming Tournament - Finals!",
      "streamer": "ProGamer2024",
      "category": "Gaming",
      "viewers": 45600,
      "thumbnail": "https://picsum.photos/300/200?random=1101&keyword=gaming",
      "avatar": "https://picsum.photos/40/40?random=1201&keyword=person",
      "isFollowing": true,
      "duration": "3:45:20",
      "tags": ["tournament", "competitive", "live"],
    },
    {
      "id": 2,
      "title": "Flutter Development - Building Real Apps",
      "streamer": "CodeMaster",
      "category": "Technology",
      "viewers": 12800,
      "thumbnail": "https://picsum.photos/300/200?random=1102&keyword=coding",
      "avatar": "https://picsum.photos/40/40?random=1202&keyword=person",
      "isFollowing": false,
      "duration": "2:15:30",
      "tags": ["tutorial", "flutter", "coding"],
    },
    {
      "id": 3,
      "title": "Digital Art Creation Live Session",
      "streamer": "ArtMaster",
      "category": "Art",
      "viewers": 8900,
      "thumbnail": "https://picsum.photos/300/200?random=1103&keyword=art",
      "avatar": "https://picsum.photos/40/40?random=1203&keyword=person",
      "isFollowing": true,
      "duration": "1:55:45",
      "tags": ["art", "digital", "creative"],
    },
    {
      "id": 4,
      "title": "Jazz Music Evening Session",
      "streamer": "JazzVibes",
      "category": "Music",
      "viewers": 5670,
      "thumbnail": "https://picsum.photos/300/200?random=1104&keyword=music",
      "avatar": "https://picsum.photos/40/40?random=1204&keyword=person",
      "isFollowing": false,
      "duration": "4:30:15",
      "tags": ["jazz", "music", "live"],
    },
    {
      "id": 5,
      "title": "Cooking Italian Cuisine",
      "streamer": "ChefMario",
      "category": "Cooking",
      "viewers": 3420,
      "thumbnail": "https://picsum.photos/300/200?random=1105&keyword=cooking",
      "avatar": "https://picsum.photos/40/40?random=1205&keyword=person",
      "isFollowing": true,
      "duration": "1:20:30",
      "tags": ["cooking", "italian", "recipe"],
    },
    {
      "id": 6,
      "title": "Physics Explained Simply",
      "streamer": "ScienceTeacher",
      "category": "Education",
      "viewers": 2340,
      "thumbnail": "https://picsum.photos/300/200?random=1106&keyword=science",
      "avatar": "https://picsum.photos/40/40?random=1206&keyword=person",
      "isFollowing": false,
      "duration": "0:45:20",
      "tags": ["education", "physics", "learning"],
    },
  ];

  List<Map<String, dynamic>> get filteredStreams {
    var streams = liveStreams;
    
    switch (selectedFilter) {
      case "Following":
        streams = streams.where((stream) => stream["isFollowing"] as bool).toList();
        break;
      case "Recommended":
        // Sort by viewers for recommended
        streams.sort((a, b) => (b["viewers"] as int).compareTo(a["viewers"] as int));
        streams = streams.take(4).toList();
        break;
      case "Trending":
        streams.sort((a, b) => (b["viewers"] as int).compareTo(a["viewers"] as int));
        break;
    }
    
    return streams;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Streams"),
        actions: [
          GestureDetector(
            onTap: () {
              isGridView = !isGridView;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                isGridView ? Icons.view_list : Icons.grid_view,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Live Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "LIVE NOW",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredStreams.length} streams",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Filter Categories
          QCategoryPicker(
            items: filterOptions,
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),

          // Streams Display
          Expanded(
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Starting new stream...");
        },
        backgroundColor: dangerColor,
        child: Icon(
          Icons.videocam,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      minItemWidth: 300,
      children: filteredStreams.map((stream) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail with Live Badge
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                  image: DecorationImage(
                    image: NetworkImage("${stream["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Live Badge
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
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "LIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Viewer Count
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(178),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${((stream["viewers"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Duration
                    Positioned(
                      bottom: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(178),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${stream["duration"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),

                    // Follow Button
                    if (!(stream["isFollowing"] as bool))
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        child: GestureDetector(
                          onTap: () => _toggleFollow(stream["id"]),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Stream Information
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      "${stream["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spSm),

                    // Streamer Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage("${stream["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${stream["streamer"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${stream["category"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (stream["isFollowing"] as bool)
                          Icon(
                            Icons.favorite,
                            color: dangerColor,
                            size: 16,
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (stream["tags"] as List).take(3).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "#$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
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

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: filteredStreams.length,
      itemBuilder: (context, index) {
        final stream = filteredStreams[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              // Thumbnail
              Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${stream["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Live Badge
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Duration
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(178),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${stream["duration"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),

              // Stream Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      "${stream["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),

                    // Streamer
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundImage: NetworkImage("${stream["avatar"]}"),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${stream["streamer"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (stream["isFollowing"] as bool) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.favorite,
                            color: dangerColor,
                            size: 12,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),

                    // Stats and Category
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${((stream["viewers"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${stream["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Button
              Column(
                children: [
                  if (!(stream["isFollowing"] as bool))
                    GestureDetector(
                      onTap: () => _toggleFollow(stream["id"]),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: spSm),
                  Icon(
                    Icons.more_vert,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFollow(int streamId) {
    final streamIndex = liveStreams.indexWhere((stream) => stream["id"] == streamId);
    if (streamIndex != -1) {
      liveStreams[streamIndex]["isFollowing"] = !(liveStreams[streamIndex]["isFollowing"] as bool);
      setState(() {});
      
      if (liveStreams[streamIndex]["isFollowing"] as bool) {
        ss("Following ${liveStreams[streamIndex]["streamer"]}");
      } else {
        si("Unfollowed ${liveStreams[streamIndex]["streamer"]}");
      }
    }
  }
}
