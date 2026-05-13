import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaHomeView extends StatefulWidget {
  const NmaHomeView({super.key});

  @override
  State<NmaHomeView> createState() => _NmaHomeViewState();
}

class _NmaHomeViewState extends State<NmaHomeView> {
  List breakingNews = [
    {
      "id": 1,
      "title": "Global Climate Summit Reaches Breakthrough Agreement",
      "summary": "World leaders unite on ambitious carbon reduction targets",
      "author": "Emma Johnson",
      "timestamp": "2 hours ago",
      "category": "World",
      "image": "https://picsum.photos/400/250?random=1&keyword=climate",
      "isBreaking": true,
    },
    {
      "id": 2,
      "title": "Tech Giant Announces Revolutionary AI Assistant",
      "summary": "New AI technology promises to transform workplace productivity",
      "author": "Michael Chen",
      "timestamp": "4 hours ago",
      "category": "Technology",
      "image": "https://picsum.photos/400/250?random=2&keyword=technology",
      "isBreaking": true,
    },
  ];

  List topStories = [
    {
      "id": 3,
      "title": "Stock Markets Hit Record Highs as Economy Shows Strong Growth",
      "summary": "Major indices surge amid positive economic indicators and corporate earnings",
      "author": "Sarah Williams",
      "timestamp": "1 hour ago",
      "category": "Business",
      "image": "https://picsum.photos/300/200?random=3&keyword=business",
      "readTime": "3 min read",
    },
    {
      "id": 4,
      "title": "Olympic Games Preparation Enters Final Phase",
      "summary": "Athletes and organizers make final preparations for the upcoming games",
      "author": "David Thompson",
      "timestamp": "3 hours ago",
      "category": "Sports",
      "image": "https://picsum.photos/300/200?random=4&keyword=olympics",
      "readTime": "4 min read",
    },
    {
      "id": 5,
      "title": "New Medical Breakthrough Offers Hope for Cancer Patients",
      "summary": "Clinical trials show promising results for innovative treatment approach",
      "author": "Dr. Lisa Rodriguez",
      "timestamp": "5 hours ago",
      "category": "Health",
      "image": "https://picsum.photos/300/200?random=5&keyword=medical",
      "readTime": "6 min read",
    },
    {
      "id": 6,
      "title": "Space Mission Successfully Lands on Mars",
      "summary": "Historic mission marks new chapter in space exploration",
      "author": "James Park",
      "timestamp": "8 hours ago",
      "category": "Science",
      "image": "https://picsum.photos/300/200?random=6&keyword=space",
      "readTime": "5 min read",
    },
  ];

  List categories = [
    {"name": "Politics", "icon": Icons.how_to_vote, "color": primaryColor},
    {"name": "Business", "icon": Icons.business, "color": successColor},
    {"name": "Technology", "icon": Icons.computer, "color": infoColor},
    {"name": "Sports", "icon": Icons.sports_football, "color": warningColor},
    {"name": "Health", "icon": Icons.health_and_safety, "color": dangerColor},
    {"name": "Science", "icon": Icons.science, "color": secondaryColor},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Central"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // navigateTo(NmaSearchView());
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // navigateTo(NmaNotificationsView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildBreakingNewsSection(),
            _buildCategoriesSection(),
            _buildTopStoriesSection(),
            _buildQuickLinksSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakingNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "BREAKING",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: spSm),
            Text(
              "Latest News",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Container(
          height: 200,
          child: QHorizontalScroll(
            children: List.generate(breakingNews.length, (index) {
              final news = breakingNews[index];
              return Container(
                width: 320,
                margin: EdgeInsets.only(
                  right: index < breakingNews.length - 1 ? spSm : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${news["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "LIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${news["title"]}",
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
                                Text(
                                  "${news["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  " • ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${news["timestamp"]}",
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
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Browse Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: categories.map((category) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      category["icon"] as IconData,
                      size: 32,
                      color: category["color"] as Color,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${category["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
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

  Widget _buildTopStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Top Stories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // navigateTo(NmaTopStoriesView());
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...List.generate(topStories.length, (index) {
          final story = topStories[index];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${story["image"]}",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${story["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${story["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${story["summary"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "${story["author"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            " • ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${story["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            " • ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${story["readTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
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
        }),
      ],
    );
  }

  Widget _buildQuickLinksSection() {
    List quickLinks = [
      {"title": "Headlines", "icon": Icons.newspaper, "color": primaryColor},
      {"title": "Breaking News", "icon": Icons.flash_on, "color": dangerColor},
      {"title": "Weather", "icon": Icons.wb_sunny, "color": warningColor},
      {"title": "Local News", "icon": Icons.location_on, "color": infoColor},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Quick Access",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          spacing: spSm,
          children: List.generate(quickLinks.length, (index) {
            final link = quickLinks[index];
            return Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (link["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: (link["color"] as Color).withAlpha(30),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      link["icon"] as IconData,
                      size: 24,
                      color: link["color"] as Color,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${link["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
