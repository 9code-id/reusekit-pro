import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast9View extends StatefulWidget {
  @override
  State<GrlPodcast9View> createState() => _GrlPodcast9ViewState();
}

class _GrlPodcast9ViewState extends State<GrlPodcast9View> {
  Map<String, dynamic> podcastDetails = {
    "id": 1,
    "title": "Tech Innovation Weekly",
    "host": "Sarah Johnson & Michael Chen",
    "description": "Exploring the latest trends in technology, artificial intelligence, and digital innovation. Join us every week for in-depth discussions with industry experts, startup founders, and tech visionaries.",
    "category": "Technology",
    "episodes": 287,
    "subscribers": 156000,
    "rating": 4.8,
    "totalReviews": 2340,
    "image": "https://picsum.photos/400/400?random=1&keyword=podcast",
    "bannerImage": "https://picsum.photos/600/300?random=1&keyword=tech",
    "isSubscribed": false,
    "releaseSchedule": "Every Tuesday & Friday",
    "language": "English",
    "website": "techinnovationweekly.com",
    "socialMedia": {
      "twitter": "@techinnovation",
      "instagram": "@techinnovationweekly",
      "facebook": "TechInnovationWeekly"
    }
  };

  List<Map<String, dynamic>> recentEpisodes = [
    {
      "id": 1,
      "title": "The Future of Artificial Intelligence in Healthcare",
      "description": "Exploring how AI is transforming medical diagnosis and treatment",
      "duration": "45:32",
      "publishDate": "2024-01-15",
      "plays": 23500,
      "isNew": true,
      "image": "https://picsum.photos/300/300?random=2&keyword=ai"
    },
    {
      "id": 2,
      "title": "Blockchain Beyond Cryptocurrency",
      "description": "Real-world applications of blockchain technology",
      "duration": "38:15",
      "publishDate": "2024-01-12",
      "plays": 18700,
      "isNew": false,
      "image": "https://picsum.photos/300/300?random=3&keyword=blockchain"
    },
    {
      "id": 3,
      "title": "Startup Success Stories: From Idea to IPO",
      "description": "Conversations with successful entrepreneurs",
      "duration": "52:20",
      "publishDate": "2024-01-10",
      "plays": 31200,
      "isNew": false,
      "image": "https://picsum.photos/300/300?random=4&keyword=startup"
    },
    {
      "id": 4,
      "title": "The Rise of Remote Work Technology",
      "description": "Tools and platforms reshaping how we work",
      "duration": "41:45",
      "publishDate": "2024-01-08",
      "plays": 19800,
      "isNew": false,
      "image": "https://picsum.photos/300/300?random=5&keyword=remote"
    },
    {
      "id": 5,
      "title": "Cybersecurity in the Digital Age",
      "description": "Protecting data in an interconnected world",
      "duration": "47:12",
      "publishDate": "2024-01-05",
      "plays": 22400,
      "isNew": false,
      "image": "https://picsum.photos/300/300?random=6&keyword=security"
    }
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "username": "TechEnthusiast",
      "rating": 5,
      "comment": "Amazing podcast! The hosts really know their stuff and explain complex topics clearly.",
      "date": "2024-01-14",
      "helpful": 12
    },
    {
      "id": 2,
      "username": "StartupFounder",
      "rating": 4,
      "comment": "Great insights into the tech industry. Some episodes are better than others.",
      "date": "2024-01-10",
      "helpful": 8
    },
    {
      "id": 3,
      "username": "AIResearcher",
      "rating": 5,
      "comment": "Excellent coverage of AI topics. The healthcare episode was particularly insightful.",
      "date": "2024-01-08",
      "helpful": 15
    }
  ];

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with banner image
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${podcastDetails["bannerImage"]}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withAlpha(150),
                      Colors.transparent,
                      Colors.black.withAlpha(200),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      children: [
                        // App Bar
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //navigateTo('back')
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        
                        Spacer(),
                        
                        // Podcast info
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                image: DecorationImage(
                                  image: NetworkImage("${podcastDetails["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [shadowLg],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${podcastDetails["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "by ${podcastDetails["host"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      color: Colors.white.withAlpha(200),
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${podcastDetails["rating"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "(${podcastDetails["totalReviews"]} reviews)",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withAlpha(200),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Stats and Subscribe Button
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${podcastDetails["episodes"]}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Episodes",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((podcastDetails["subscribers"] as int) / 1000).toStringAsFixed(0)}k",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Subscribers",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${podcastDetails["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Category",
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
                        SizedBox(height: spLg),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: podcastDetails["isSubscribed"] == true ? "Subscribed" : "Subscribe",
                                icon: podcastDetails["isSubscribed"] == true ? Icons.check : Icons.add,
                                size: bs.md,
                                onPressed: () {
                                  podcastDetails["isSubscribed"] = !podcastDetails["isSubscribed"];
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.play_arrow,
                              size: bs.md,
                              onPressed: () {},
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.download,
                              size: bs.md,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Tab Navigation
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        // Tab Headers
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: disabledColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    currentTab = 0;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: currentTab == 0
                                          ? Border(
                                              bottom: BorderSide(
                                                color: primaryColor,
                                                width: 2,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Text(
                                      "Episodes",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: currentTab == 0 ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    currentTab = 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: currentTab == 1
                                          ? Border(
                                              bottom: BorderSide(
                                                color: primaryColor,
                                                width: 2,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Text(
                                      "About",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: currentTab == 1 ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    currentTab = 2;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: currentTab == 2
                                          ? Border(
                                              bottom: BorderSide(
                                                color: primaryColor,
                                                width: 2,
                                              ),
                                            )
                                          : null,
                                    ),
                                    child: Text(
                                      "Reviews",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: currentTab == 2 ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tab Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: _buildTabContent(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildEpisodesTab();
      case 1:
        return _buildAboutTab();
      case 2:
        return _buildReviewsTab();
      default:
        return _buildEpisodesTab();
    }
  }

  Widget _buildEpisodesTab() {
    return Column(
      children: recentEpisodes.map((episode) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
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
                  if (episode["isNew"] == true)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                      "${episode["description"]}",
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
                          "${episode["duration"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${episode["publishDate"]}",
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
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "${podcastDetails["description"]}",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),
        SizedBox(height: spLg),
        Text(
          "Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        _buildDetailRow("Release Schedule", "${podcastDetails["releaseSchedule"]}"),
        _buildDetailRow("Language", "${podcastDetails["language"]}"),
        _buildDetailRow("Website", "${podcastDetails["website"]}"),
        SizedBox(height: spLg),
        Text(
          "Follow Us",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            QButton(
              icon: Icons.language,
              size: bs.sm,
              onPressed: () {},
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.share,
              size: bs.sm,
              onPressed: () {},
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.email,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reviews & Ratings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${podcastDetails["rating"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${podcastDetails["totalReviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            QButton(
              label: "Write Review",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spLg),
        Column(
          children: reviews.map((review) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${review["username"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                            color: warningColor,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${review["comment"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${review["date"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${review["helpful"]} found helpful",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
