import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast4View extends StatefulWidget {
  @override
  State<GrlPodcast4View> createState() => _GrlPodcast4ViewState();
}

class _GrlPodcast4ViewState extends State<GrlPodcast4View> {
  List<Map<String, dynamic>> podcastEpisodes = [
    {
      "id": 1,
      "title": "The Future of Technology",
      "description": "Exploring emerging trends in AI and machine learning",
      "host": "Tech Talk",
      "duration": "45:30",
      "plays": 15420,
      "date": "2024-01-15",
      "image": "https://picsum.photos/300/300?random=1&keyword=tech",
      "category": "Technology",
      "rating": 4.8,
      "isPlaying": false,
      "progress": 0.3
    },
    {
      "id": 2,
      "title": "Digital Marketing Mastery",
      "description": "Advanced strategies for social media marketing",
      "host": "Marketing Pro",
      "duration": "38:15",
      "plays": 8930,
      "date": "2024-01-12",
      "image": "https://picsum.photos/300/300?random=2&keyword=marketing",
      "category": "Business",
      "rating": 4.6,
      "isPlaying": true,
      "progress": 0.7
    },
    {
      "id": 3,
      "title": "Health & Wellness Journey",
      "description": "Tips for maintaining a balanced lifestyle",
      "host": "Wellness Guide",
      "duration": "52:22",
      "plays": 12750,
      "date": "2024-01-10",
      "image": "https://picsum.photos/300/300?random=3&keyword=health",
      "category": "Health",
      "rating": 4.9,
      "isPlaying": false,
      "progress": 0.0
    },
    {
      "id": 4,
      "title": "Entrepreneurship Stories",
      "description": "Inspiring journeys of successful entrepreneurs",
      "host": "Startup Stories",
      "duration": "41:45",
      "plays": 9680,
      "date": "2024-01-08",
      "image": "https://picsum.photos/300/300?random=4&keyword=business",
      "category": "Business",
      "rating": 4.7,
      "isPlaying": false,
      "progress": 0.5
    },
    {
      "id": 5,
      "title": "Creative Design Process",
      "description": "Behind the scenes of modern design thinking",
      "host": "Design Hub",
      "duration": "35:18",
      "plays": 7240,
      "date": "2024-01-05",
      "image": "https://picsum.photos/300/300?random=5&keyword=design",
      "category": "Design",
      "rating": 4.5,
      "isPlaying": false,
      "progress": 0.0
    }
  ];

  String selectedCategory = "All";
  List<String> categories = ["All", "Technology", "Business", "Health", "Design"];
  int currentlyPlaying = 2;

  @override
  Widget build(BuildContext context) {
    final filteredEpisodes = selectedCategory == "All" 
        ? podcastEpisodes 
        : podcastEpisodes.where((episode) => episode["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Podcast Episodes"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.queue_music),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Episodes List
            Column(
              children: filteredEpisodes.map((episode) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Episode Header
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            // Episode Image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                image: DecorationImage(
                                  image: NetworkImage("${episode["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),

                            // Episode Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${episode["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${episode["host"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${episode["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.play_circle,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${((episode["plays"] as int) / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Rating & Actions
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${episode["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                QButton(
                                  icon: episode["isPlaying"] == true ? Icons.pause : Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Toggle play state
                                    episode["isPlaying"] = !episode["isPlaying"];
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Progress Bar (if episode has progress)
                      if ((episode["progress"] as double) > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                value: episode["progress"] as double,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(((episode["progress"] as double) * 45 * 60).toInt() ~/ 60)}:${(((episode["progress"] as double) * 45 * 60).toInt() % 60).toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${episode["duration"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: spSm),

                      // Episode Description
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Text(
                          "${episode["description"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Download",
                                icon: Icons.download,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.favorite_border,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
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
        ),
      ),
    );
  }
}
