import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaBlogView extends StatefulWidget {
  const TtaBlogView({super.key});

  @override
  State<TtaBlogView> createState() => _TtaBlogViewState();
}

class _TtaBlogViewState extends State<TtaBlogView> {
  String selectedCategory = "All";

  List<Map<String, dynamic>> blogCategories = [
    {"label": "All", "value": "All"},
    {"label": "Destinations", "value": "Destinations"},
    {"label": "Tips", "value": "Tips"},
    {"label": "Culture", "value": "Culture"},
    {"label": "Adventure", "value": "Adventure"},
    {"label": "Food", "value": "Food"},
  ];

  List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "Hidden Gems of Southeast Asia: Off the Beaten Path",
      "category": "Destinations",
      "author": {
        "name": "Emma Rodriguez",
        "avatar": "https://picsum.photos/40/40?random=1",
        "verified": true
      },
      "publishedDate": "2024-06-10",
      "readTime": "8 min read",
      "image": "https://picsum.photos/400/250?random=1&keyword=asia",
      "excerpt": "Discover 10 incredible destinations in Southeast Asia that most tourists never hear about. From secret beaches to ancient temples...",
      "content": "Full blog content would go here...",
      "tags": ["Southeast Asia", "Hidden Gems", "Adventure"],
      "likes": 3456,
      "comments": 89,
      "shares": 156,
      "isLiked": false,
      "isBookmarked": true,
      "views": 15420
    },
    {
      "id": 2,
      "title": "Digital Nomad Life: Working from Paradise",
      "category": "Tips",
      "author": {
        "name": "Alex Chen",
        "avatar": "https://picsum.photos/40/40?random=2",
        "verified": false
      },
      "publishedDate": "2024-06-08",
      "readTime": "12 min read",
      "image": "https://picsum.photos/400/250?random=2&keyword=remote",
      "excerpt": "Learn how to balance work and travel as a digital nomad. Tips for productivity, internet connectivity, and creating a mobile office...",
      "content": "Full blog content would go here...",
      "tags": ["Digital Nomad", "Remote Work", "Productivity"],
      "likes": 2890,
      "comments": 145,
      "shares": 89,
      "isLiked": true,
      "isBookmarked": false,
      "views": 12380
    },
    {
      "id": 3,
      "title": "Street Food Adventures: A Culinary Journey Through Bangkok",
      "category": "Food",
      "author": {
        "name": "Maria Santos",
        "avatar": "https://picsum.photos/40/40?random=3",
        "verified": true
      },
      "publishedDate": "2024-06-05",
      "readTime": "6 min read",
      "image": "https://picsum.photos/400/250?random=3&keyword=bangkok",
      "excerpt": "Explore Bangkok's incredible street food scene with our comprehensive guide to the best markets, stalls, and local favorites...",
      "content": "Full blog content would go here...",
      "tags": ["Bangkok", "Street Food", "Thailand"],
      "likes": 4567,
      "comments": 234,
      "shares": 267,
      "isLiked": false,
      "isBookmarked": true,
      "views": 18920
    },
    {
      "id": 4,
      "title": "Sustainable Travel: How to Explore Responsibly",
      "category": "Tips",
      "author": {
        "name": "David Kumar",
        "avatar": "https://picsum.photos/40/40?random=4",
        "verified": false
      },
      "publishedDate": "2024-06-03",
      "readTime": "10 min read",
      "image": "https://picsum.photos/400/250?random=4&keyword=nature",
      "excerpt": "Make a positive impact while traveling with these sustainable tourism practices and eco-friendly travel tips...",
      "content": "Full blog content would go here...",
      "tags": ["Sustainable Travel", "Eco-friendly", "Responsible Tourism"],
      "likes": 1893,
      "comments": 67,
      "shares": 134,
      "isLiked": true,
      "isBookmarked": false,
      "views": 9560
    },
    {
      "id": 5,
      "title": "Mountain Climbing in the Himalayas: A Life-Changing Experience",
      "category": "Adventure",
      "author": {
        "name": "Sophie Wilson",
        "avatar": "https://picsum.photos/40/40?random=5",
        "verified": true
      },
      "publishedDate": "2024-06-01",
      "readTime": "15 min read",
      "image": "https://picsum.photos/400/250?random=5&keyword=mountains",
      "excerpt": "Follow my journey climbing in the Himalayas, from preparation and training to reaching base camp and the lessons learned...",
      "content": "Full blog content would go here...",
      "tags": ["Himalayas", "Mountain Climbing", "Adventure"],
      "likes": 2345,
      "comments": 98,
      "shares": 78,
      "isLiked": false,
      "isBookmarked": true,
      "views": 11670
    },
  ];

  List<Map<String, dynamic>> featuredPosts = [
    {
      "title": "Best Budget Airlines in Europe",
      "image": "https://picsum.photos/300/180?random=10&keyword=airplane",
      "readTime": "5 min",
      "views": 25690
    },
    {
      "title": "Solo Female Travel Safety Guide",
      "image": "https://picsum.photos/300/180?random=11&keyword=woman",
      "readTime": "12 min",
      "views": 34520
    },
    {
      "title": "Photography Tips for Landscapes",
      "image": "https://picsum.photos/300/180?random=12&keyword=landscape",
      "readTime": "8 min",
      "views": 18340
    },
  ];

  List<Map<String, dynamic>> popularTags = [
    {"name": "Solo Travel", "count": 156},
    {"name": "Budget Travel", "count": 234},
    {"name": "Digital Nomad", "count": 89},
    {"name": "Adventure", "count": 187},
    {"name": "Food & Culture", "count": 145},
    {"name": "Photography", "count": 98},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPosts = selectedCategory == "All" 
        ? blogPosts 
        : blogPosts.where((post) => post["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Blog"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Posts Section
            Container(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Featured Posts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: QHorizontalScroll(
                      children: featuredPosts.map((post) {
                        return Container(
                          width: 300,
                          margin: EdgeInsets.only(left: spMd),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusMd),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${post["image"]}",
                                  width: 300,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: 300,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withAlpha(200),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: spSm,
                                  left: spSm,
                                  right: spSm,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${post["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${post["readTime"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Icon(
                                            Icons.visibility,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${(post["views"] as int).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Categories Filter
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: QCategoryPicker(
                items: blogCategories,
                value: selectedCategory,
                onChanged: (index, label, value, item) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),

            SizedBox(height: spLg),

            // Blog Posts Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Text(
                    "Latest Posts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${filteredPosts.length} articles",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spSm),

            // Blog Posts List
            Column(
              children: filteredPosts.map((post) {
                final author = post["author"] as Map<String, dynamic>;
                
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${post["image"]}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
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
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${post["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: GestureDetector(
                                onTap: () {
                                  post["isBookmarked"] = !(post["isBookmarked"] as bool);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(200),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    (post["isBookmarked"] as bool) 
                                        ? Icons.bookmark 
                                        : Icons.bookmark_border,
                                    size: 20,
                                    color: (post["isBookmarked"] as bool) 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Post Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author Info
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    "${author["avatar"]}",
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${author["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (author["verified"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.verified,
                                              size: 14,
                                              color: primaryColor,
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${DateTime.parse(post["publishedDate"] as String).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${post["readTime"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Post Title
                            Text(
                              "${post["title"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: spXs),

                            // Post Excerpt
                            Text(
                              "${post["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: spSm),

                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (post["tags"] as List).take(3).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: spSm),

                            // Post Stats and Actions
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    post["isLiked"] = !(post["isLiked"] as bool);
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        (post["isLiked"] as bool) 
                                            ? Icons.favorite 
                                            : Icons.favorite_border,
                                        size: 18,
                                        color: (post["isLiked"] as bool) 
                                            ? Colors.red 
                                            : disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${(post["likes"] as int).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.comment_outlined,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${post["comments"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(post["views"] as int).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                QButton(
                                  label: "Read More",
                                  size: bs.sm,
                                  onPressed: () {},
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
            ),

            SizedBox(height: spLg),

            // Popular Tags Section
            Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Tags",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: popularTags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(30),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${tag["name"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "(${tag["count"]})",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
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

            SizedBox(height: spLg),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
