import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAudio7View extends StatefulWidget {
  @override
  State<GrlAudio7View> createState() => _GrlAudio7ViewState();
}

class _GrlAudio7ViewState extends State<GrlAudio7View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Popular";
  bool showFavorites = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Education", "value": "Education"},
    {"label": "Business", "value": "Business"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Health", "value": "Health"},
    {"label": "Entertainment", "value": "Entertainment"},
  ];

  List<Map<String, dynamic>> podcasts = [
    {
      "title": "The Tim Ferriss Show",
      "author": "Tim Ferriss",
      "description": "World-class performers in every field sharing tactics, routines, and habits",
      "cover": "https://picsum.photos/150/150?random=1&keyword=podcast",
      "subscribers": 2500000,
      "episodes": 678,
      "rating": 4.8,
      "category": "Business",
      "isSubscribed": true,
      "lastEpisode": "Interview with Naval Ravikant",
      "publishDate": "2025-06-20",
      "duration": "2h 15m",
      "tags": ["entrepreneurship", "productivity", "success"],
    },
    {
      "title": "Coders Corner Podcast",
      "author": "Tech Talk Media",
      "description": "Weekly insights into programming, software development, and tech careers",
      "cover": "https://picsum.photos/150/150?random=2&keyword=technology",
      "subscribers": 850000,
      "episodes": 234,
      "rating": 4.6,
      "category": "Technology",
      "isSubscribed": false,
      "lastEpisode": "Future of AI Development",
      "publishDate": "2025-06-19",
      "duration": "1h 32m",
      "tags": ["programming", "ai", "software"],
    },
    {
      "title": "Health & Wellness Today",
      "author": "Dr. Sarah Chen",
      "description": "Evidence-based health advice from medical professionals",
      "cover": "https://picsum.photos/150/150?random=3&keyword=health",
      "subscribers": 1200000,
      "episodes": 456,
      "rating": 4.9,
      "category": "Health",
      "isSubscribed": true,
      "lastEpisode": "Mental Health in the Digital Age",
      "publishDate": "2025-06-21",
      "duration": "45m",
      "tags": ["wellness", "medicine", "lifestyle"],
    },
    {
      "title": "The Learning Path",
      "author": "Education Network",
      "description": "Exploring innovative approaches to education and learning",
      "cover": "https://picsum.photos/150/150?random=4&keyword=education",
      "subscribers": 675000,
      "episodes": 189,
      "rating": 4.7,
      "category": "Education",
      "isSubscribed": false,
      "lastEpisode": "Online Learning Best Practices",
      "publishDate": "2025-06-18",
      "duration": "58m",
      "tags": ["learning", "teaching", "innovation"],
    },
  ];

  List<Map<String, dynamic>> featuredEpisodes = [
    {
      "title": "The Future of Remote Work",
      "podcast": "Business Today",
      "duration": "34m",
      "publishDate": "2025-06-21",
      "cover": "https://picsum.photos/80/80?random=5&keyword=business",
      "plays": 125000,
      "likes": 8900,
      "isNew": true,
    },
    {
      "title": "Machine Learning Fundamentals",
      "podcast": "Tech Deep Dive",
      "duration": "1h 12m",
      "publishDate": "2025-06-20",
      "cover": "https://picsum.photos/80/80?random=6&keyword=ai",
      "plays": 89000,
      "likes": 6700,
      "isNew": true,
    },
    {
      "title": "Nutrition Myths Debunked",
      "podcast": "Science & Health",
      "duration": "42m",
      "publishDate": "2025-06-19",
      "cover": "https://picsum.photos/80/80?random=7&keyword=nutrition",
      "plays": 67000,
      "likes": 4500,
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podcast Discovery"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            _buildFeaturedEpisodes(),
            _buildCategoryFilter(),
            _buildDiscoveryStats(),
            _buildTrendingPodcasts(),
            _buildPodcastGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search podcasts...",
                value: searchQuery,
                hint: "Title, author, or topic",
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
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Sort by",
                items: [
                  {"label": "Popular", "value": "Popular"},
                  {"label": "Recent", "value": "Recent"},
                  {"label": "Rating", "value": "Rating"},
                  {"label": "Subscribers", "value": "Subscribers"},
                ],
                value: sortBy,
                onChanged: (value, label) {
                  sortBy = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: showFavorites ? "All" : "Favorites",
              icon: showFavorites ? Icons.clear : Icons.favorite,
              size: bs.sm,
              onPressed: () {
                showFavorites = !showFavorites;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedEpisodes() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Episodes",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        QHorizontalScroll(
          children: featuredEpisodes.map((episode) {
            return Container(
              width: 280,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${episode["cover"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            if (episode["isNew"] as bool)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "NEW",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            Text(
                              "${episode["title"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${episode["podcast"]}",
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
                  Row(
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 16,
                        color: primaryColor,
                      ),
                      Text(
                        "${((episode["plays"] as int) / 1000).toInt()}K plays",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledBoldColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        "${episode["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Play Episode",
                      icon: Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildCategoryFilter() {
    return QCategoryPicker(
      label: "Browse Categories",
      items: categories,
      value: selectedCategory,
      onChanged: (index, label, value, item) {
        selectedCategory = value;
        setState(() {});
      },
    );
  }

  Widget _buildDiscoveryStats() {
    return Row(
      children: [
        _buildStatCard("Total Podcasts", "12.5K", Icons.podcasts),
        SizedBox(width: spSm),
        _buildStatCard("New This Week", "245", Icons.fiber_new),
        SizedBox(width: spSm),
        _buildStatCard("Your Subscriptions", "18", Icons.subscriptions),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingPodcasts() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Trending This Week",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "See More",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                warningColor.withAlpha(10),
                primaryColor.withAlpha(5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${podcasts[0]["cover"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#1",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                  spacing: spXs,
                  children: [
                    Text(
                      "${podcasts[0]["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${podcasts[0]["author"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        Text(
                          "${podcasts[0]["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${((podcasts[0]["subscribers"] as int) / 1000000).toStringAsFixed(1)}M subscribers",
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
              QButton(
                label: "Listen",
                icon: Icons.play_arrow,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPodcastGrid() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Discover Podcasts",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: podcasts.map((podcast) {
            return _buildPodcastCard(podcast);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPodcastCard(Map<String, dynamic> podcast) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${podcast["cover"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    podcast["isSubscribed"] as bool ? Icons.check_circle : Icons.add_circle_outline,
                    size: 16,
                    color: podcast["isSubscribed"] as bool ? successColor : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${podcast["title"]}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${podcast["author"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${podcast["description"]}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: warningColor,
              ),
              Text(
                "${podcast["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledBoldColor,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                "${podcast["episodes"]} episodes",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((podcast["tags"] as List).isNotEmpty) ...[
            QHorizontalScroll(
              children: (podcast["tags"] as List).map<Widget>((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$tag",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Latest Episode:",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${podcast["lastEpisode"]}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  spacing: spXs,
                  children: [
                    Text(
                      "${podcast["duration"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        color: disabledBoldColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      "${podcast["publishDate"]}",
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: podcast["isSubscribed"] as bool ? "Unsubscribe" : "Subscribe",
                  icon: podcast["isSubscribed"] as bool ? Icons.remove_circle_outline : Icons.add_circle_outline,
                  size: bs.sm,
                  onPressed: () {
                    podcast["isSubscribed"] = !(podcast["isSubscribed"] as bool);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Play Latest",
                  icon: Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
