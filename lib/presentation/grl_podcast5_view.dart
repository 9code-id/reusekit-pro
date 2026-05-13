import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast5View extends StatefulWidget {
  @override
  State<GrlPodcast5View> createState() => _GrlPodcast5ViewState();
}

class _GrlPodcast5ViewState extends State<GrlPodcast5View> {
  List<Map<String, dynamic>> trendingPodcasts = [
    {
      "id": 1,
      "title": "The Daily Tech",
      "description": "Your daily dose of technology news and insights",
      "host": "Sarah Johnson",
      "episodes": 245,
      "subscribers": 128000,
      "image": "https://picsum.photos/400/400?random=1&keyword=tech",
      "category": "Technology",
      "rating": 4.9,
      "isSubscribed": true,
      "color": Colors.blue
    },
    {
      "id": 2,
      "title": "Business Breakthrough",
      "description": "Strategies and stories from successful entrepreneurs",
      "host": "Michael Chen",
      "episodes": 156,
      "subscribers": 95000,
      "image": "https://picsum.photos/400/400?random=2&keyword=business",
      "category": "Business",
      "rating": 4.7,
      "isSubscribed": false,
      "color": Colors.green
    },
    {
      "id": 3,
      "title": "Mindful Living",
      "description": "Wellness tips for a balanced lifestyle",
      "host": "Emma Wilson",
      "episodes": 89,
      "subscribers": 76000,
      "image": "https://picsum.photos/400/400?random=3&keyword=wellness",
      "category": "Health",
      "rating": 4.8,
      "isSubscribed": true,
      "color": Colors.purple
    },
    {
      "id": 4,
      "title": "Creative Corner",
      "description": "Inspiring conversations with artists and designers",
      "host": "David Kim",
      "episodes": 112,
      "subscribers": 54000,
      "image": "https://picsum.photos/400/400?random=4&keyword=art",
      "category": "Arts",
      "rating": 4.6,
      "isSubscribed": false,
      "color": Colors.orange
    }
  ];

  List<Map<String, dynamic>> newReleases = [
    {
      "id": 1,
      "title": "AI Revolution 2024",
      "podcast": "The Daily Tech",
      "duration": "42:15",
      "date": "Today",
      "image": "https://picsum.photos/300/300?random=5&keyword=ai",
      "plays": 8920
    },
    {
      "id": 2,
      "title": "Startup Success Secrets",
      "podcast": "Business Breakthrough",
      "duration": "38:30",
      "date": "Yesterday",
      "image": "https://picsum.photos/300/300?random=6&keyword=startup",
      "plays": 5670
    },
    {
      "id": 3,
      "title": "Morning Meditation Guide",
      "podcast": "Mindful Living",
      "duration": "25:45",
      "date": "2 days ago",
      "image": "https://picsum.photos/300/300?random=7&keyword=meditation",
      "plays": 12340
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Podcasts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trending Now",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Discover the most popular podcasts this week",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Trending Podcasts
            Text(
              "Popular Podcasts",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QHorizontalScroll(
              children: trendingPodcasts.map((podcast) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Podcast Image
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          image: DecorationImage(
                            image: NetworkImage("${podcast["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(100),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: podcast["color"],
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${podcast["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${podcast["rating"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                QButton(
                                  icon: Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Podcast Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
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
                            Text(
                              "${podcast["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.headset,
                                  size: 16,
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
                                  Icons.people,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${((podcast["subscribers"] as int) / 1000).toStringAsFixed(0)}k",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            QButton(
                              label: podcast["isSubscribed"] == true ? "Subscribed" : "Subscribe",
                              icon: podcast["isSubscribed"] == true ? Icons.check : Icons.add,
                              size: bs.sm,
                              onPressed: () {
                                podcast["isSubscribed"] = !podcast["isSubscribed"];
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // New Releases
            Text(
              "New Releases",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: newReleases.map((episode) {
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
                                SizedBox(width: spSm),
                                Text(
                                  "${((episode["plays"] as int) / 1000).toStringAsFixed(1)}k plays",
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
                      QButton(
                        icon: Icons.play_arrow,
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
