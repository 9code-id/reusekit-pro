import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaArticleDetailView extends StatefulWidget {
  const NmaArticleDetailView({super.key});

  @override
  State<NmaArticleDetailView> createState() => _NmaArticleDetailViewState();
}

class _NmaArticleDetailViewState extends State<NmaArticleDetailView> {
  bool isBookmarked = false;
  bool isLiked = false;
  int likes = 1247;
  int shares = 89;
  int comments = 156;
  
  List<Map<String, dynamic>> relatedArticles = [
    {
      "title": "Climate Change Policies Under Review",
      "author": "Dr. Sarah Johnson",
      "time": "2 hours ago",
      "image": "https://picsum.photos/300/200?random=1&keyword=climate",
      "category": "Environment"
    },
    {
      "title": "Economic Recovery Shows Signs of Progress",
      "author": "Mark Thompson",
      "time": "4 hours ago", 
      "image": "https://picsum.photos/300/200?random=2&keyword=economy",
      "category": "Business"
    },
    {
      "title": "Tech Innovation Drives New Opportunities",
      "author": "Lisa Chen",
      "time": "6 hours ago",
      "image": "https://picsum.photos/300/200?random=3&keyword=technology",
      "category": "Technology"
    },
    {
      "title": "Healthcare Breakthrough in Cancer Treatment",
      "author": "Dr. Michael Brown",
      "time": "8 hours ago",
      "image": "https://picsum.photos/300/200?random=4&keyword=medical",
      "category": "Health"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article"),
        actions: [
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              isBookmarked = !isBookmarked;
              setState(() {});
              if (isBookmarked) {
                ss("Article bookmarked");
              } else {
                si("Bookmark removed");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Article shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "BREAKING NEWS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: spSm),

            // Article Title
            Text(
              "Global Summit Addresses Climate Change with Unprecedented International Cooperation",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                height: 1.3,
              ),
            ),
            SizedBox(height: spSm),

            // Article Meta Info
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage("https://picsum.photos/100/100?random=1&keyword=journalist"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "By Jennifer Martinez",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Senior Political Correspondent • 3 hours ago",
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
            SizedBox(height: spMd),

            // Article Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/200?random=1&keyword=summit"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spSm),

            // Image Caption
            Text(
              "World leaders gather at the Climate Action Summit in Geneva to discuss unprecedented cooperation measures.",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: spMd),

            // Article Content
            Text(
              "GENEVA - In an unprecedented show of international unity, world leaders from over 150 countries have convened at the Global Climate Action Summit to address the mounting challenges of climate change. The three-day summit, which began this morning, marks the largest gathering of heads of state focused exclusively on environmental action since the Paris Agreement.\n\n",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: primaryColor,
              ),
            ),

            Text(
              "The summit comes at a critical time as recent scientific reports indicate that global temperatures have risen faster than previously predicted. Dr. Elena Rodriguez, Chief Climate Scientist at the International Environmental Research Institute, presented data showing that immediate action is required to prevent irreversible damage to global ecosystems.\n\n",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: primaryColor,
              ),
            ),

            Text(
              "Key proposals under discussion include:\n\n• Aggressive carbon reduction targets by 2030\n• International carbon tax implementation\n• Massive reforestation initiatives\n• Clean energy technology sharing agreements\n• Climate refugee protection protocols\n\n",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: primaryColor,
              ),
            ),

            Text(
              "President Sarah Chen of the Global Environmental Alliance emphasized the historic nature of the gathering: \"Never before have we seen such unified commitment to tackling climate change. This summit represents a turning point in our collective response to the climate crisis.\"\n\n",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: primaryColor,
              ),
            ),

            Text(
              "The summit will continue through Thursday, with final agreements expected to be announced at the closing ceremony. Environmental activists and policy experts worldwide are watching closely as these discussions could shape global climate policy for decades to come.",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            // Tags
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: [
                "Climate Change",
                "International Summit",
                "Environmental Policy",
                "Global Cooperation",
                "Geneva"
              ].map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: spMd),

            // Article Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  // Like Button
                  GestureDetector(
                    onTap: () {
                      isLiked = !isLiked;
                      if (isLiked) {
                        likes++;
                        ss("Article liked");
                      } else {
                        likes--;
                      }
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Icon(
                          isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                          color: isLiked ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${likes}",
                          style: TextStyle(
                            color: isLiked ? primaryColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),

                  // Comments
                  Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${comments}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),

                  // Shares
                  Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${shares}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  // Text to Speech
                  IconButton(
                    icon: Icon(Icons.volume_up_outlined),
                    color: disabledBoldColor,
                    onPressed: () {
                      ss("Text-to-speech started");
                    },
                  ),

                  // Font Settings
                  IconButton(
                    icon: Icon(Icons.text_fields),
                    color: disabledBoldColor,
                    onPressed: () {
                      // Navigate to font settings
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Related Articles Section
            Text(
              "Related Articles",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: relatedArticles.map((article) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${article["image"]}"),
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
                              "${article["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${article["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["time"]}",
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
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: disabledBoldColor,
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
