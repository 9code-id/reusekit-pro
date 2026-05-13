import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast6View extends StatefulWidget {
  @override
  State<GrlPodcast6View> createState() => _GrlPodcast6ViewState();
}

class _GrlPodcast6ViewState extends State<GrlPodcast6View> {
  List<Map<String, dynamic>> myPodcasts = [
    {
      "id": 1,
      "title": "Tech Insights Daily",
      "host": "Alex Thompson",
      "episodes": 187,
      "totalDuration": "142:30:00",
      "image": "https://picsum.photos/300/300?random=1&keyword=tech",
      "lastPlayed": "Today",
      "progress": 0.65,
      "isDownloaded": true,
      "downloadedEpisodes": 12
    },
    {
      "id": 2,
      "title": "Marketing Mastery",
      "host": "Jennifer Lee",
      "episodes": 98,
      "totalDuration": "87:15:00",
      "image": "https://picsum.photos/300/300?random=2&keyword=marketing",
      "lastPlayed": "Yesterday",
      "progress": 0.0,
      "isDownloaded": false,
      "downloadedEpisodes": 0
    },
    {
      "id": 3,
      "title": "Health & Fitness Guide",
      "host": "Dr. Sarah Wilson",
      "episodes": 156,
      "totalDuration": "198:45:00",
      "image": "https://picsum.photos/300/300?random=3&keyword=fitness",
      "lastPlayed": "3 days ago",
      "progress": 0.3,
      "isDownloaded": true,
      "downloadedEpisodes": 8
    },
    {
      "id": 4,
      "title": "Creative Stories",
      "host": "Michael Chen",
      "episodes": 76,
      "totalDuration": "62:20:00",
      "image": "https://picsum.photos/300/300?random=4&keyword=creative",
      "lastPlayed": "1 week ago",
      "progress": 0.85,
      "isDownloaded": false,
      "downloadedEpisodes": 0
    }
  ];

  List<Map<String, dynamic>> recentEpisodes = [
    {
      "id": 1,
      "title": "Future of Artificial Intelligence",
      "podcast": "Tech Insights Daily",
      "duration": "45:22",
      "date": "2024-01-15",
      "image": "https://picsum.photos/250/250?random=5&keyword=ai",
      "progress": 0.8,
      "isDownloaded": true
    },
    {
      "id": 2,
      "title": "Social Media Strategy 2024",
      "podcast": "Marketing Mastery",
      "duration": "38:15",
      "date": "2024-01-14",
      "image": "https://picsum.photos/250/250?random=6&keyword=social",
      "progress": 0.0,
      "isDownloaded": false
    },
    {
      "id": 3,
      "title": "Morning Workout Routine",
      "podcast": "Health & Fitness Guide",
      "duration": "32:10",
      "date": "2024-01-13",
      "image": "https://picsum.photos/250/250?random=7&keyword=workout",
      "progress": 0.4,
      "isDownloaded": true
    }
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Downloaded", "In Progress", "Unplayed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Podcasts"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Listening Stats",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Podcasts",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${myPodcasts.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hours Listened",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "142h",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Downloaded",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${myPodcasts.where((p) => p["downloadedEpisodes"] > 0).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Options
            QCategoryPicker(
              label: "Filter",
              items: filterOptions.map((filter) => {
                "label": filter,
                "value": filter,
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // My Podcasts
            Text(
              "Subscribed Podcasts",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: myPodcasts.map((podcast) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Podcast Image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                image: DecorationImage(
                                  image: NetworkImage("${podcast["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: podcast["isDownloaded"] == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusLg),
                                        color: Colors.black.withAlpha(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.download_done,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(width: spSm),

                            // Podcast Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${podcast["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "by ${podcast["host"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.headset,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${podcast["episodes"]} episodes",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${podcast["totalDuration"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Last played: ${podcast["lastPlayed"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Actions
                            Column(
                              children: [
                                QButton(
                                  icon: Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Progress Bar
                        if ((podcast["progress"] as double) > 0) ...[
                          SizedBox(height: spSm),
                          Column(
                            children: [
                              LinearProgressIndicator(
                                value: podcast["progress"] as double,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${((podcast["progress"] as double) * 100).toInt()}% completed",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (podcast["downloadedEpisodes"] > 0)
                                    Text(
                                      "${podcast["downloadedEpisodes"]} downloaded",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Recent Episodes
            Text(
              "Continue Listening",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: recentEpisodes.map((episode) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${episode["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (episode["isDownloaded"] == true)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.download_done,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${episode["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${episode["podcast"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${episode["duration"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${episode["date"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if ((episode["progress"] as double) > 0) ...[
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: episode["progress"] as double,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ],
                          ],
                        ),
                      ),
                      QButton(
                        icon: (episode["progress"] as double) > 0 ? Icons.play_arrow : Icons.play_circle,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
