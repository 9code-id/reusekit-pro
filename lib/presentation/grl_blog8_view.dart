import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog8View extends StatefulWidget {
  const GrlBlog8View({super.key});

  @override
  State<GrlBlog8View> createState() => _GrlBlog8ViewState();
}

class _GrlBlog8ViewState extends State<GrlBlog8View> {
  String selectedFilter = "All Time";
  bool showComments = false;

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All Time", "value": "All Time"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  final Map<String, dynamic> currentPost = {
    "id": 1,
    "title": "The Future of Artificial Intelligence in Modern Healthcare",
    "subtitle": "How AI is revolutionizing patient care, medical diagnosis, and drug discovery in the 21st century",
    "content": """
Artificial Intelligence has emerged as one of the most transformative technologies in healthcare, promising to revolutionize how we diagnose, treat, and prevent diseases. From machine learning algorithms that can detect cancer cells with unprecedented accuracy to AI-powered drug discovery platforms that are accelerating the development of life-saving medications, the applications are endless.

## The Current State of AI in Healthcare

Today's healthcare systems are increasingly adopting AI technologies to improve patient outcomes and reduce costs. Machine learning models are being used to analyze medical images, predict patient deterioration, and personalize treatment plans. These technologies are not replacing healthcare professionals but rather augmenting their capabilities.

## Key Applications

**Medical Imaging**: AI algorithms can now detect abnormalities in medical scans with accuracy that often exceeds human radiologists. This is particularly valuable in early detection of cancers and other serious conditions.

**Drug Discovery**: Traditional drug development can take 10-15 years and cost billions of dollars. AI is reducing these timelines by identifying promising compounds and predicting their effectiveness.

**Predictive Analytics**: By analyzing patient data, AI can predict which patients are at risk of complications, allowing for preventive interventions.

## Challenges and Considerations

While the potential of AI in healthcare is enormous, there are important challenges to address:

- **Data Privacy**: Patient data must be protected while still enabling AI research
- **Regulatory Approval**: AI systems must meet stringent safety and efficacy standards
- **Integration**: Healthcare systems need to adapt to incorporate AI tools effectively
- **Training**: Healthcare professionals need education on AI capabilities and limitations

## Looking Forward

The future of AI in healthcare is bright, with continued advances in machine learning, increased availability of health data, and growing acceptance among healthcare providers. We can expect to see more personalized medicine, better preventive care, and improved patient outcomes.

The key to success will be ensuring that AI development remains focused on improving patient care while maintaining the human element that is so crucial to healthcare.
""",
    "author": "Dr. Sarah Chen",
    "authorImage": "https://picsum.photos/60/60?random=1&keyword=doctor",
    "authorBio": "Dr. Sarah Chen is a leading researcher in AI applications for healthcare with over 15 years of experience in medical technology innovation.",
    "category": "Healthcare Technology",
    "publishedAt": "2024-01-20T10:30:00Z",
    "readTime": 12,
    "image": "https://picsum.photos/800/400?random=1&keyword=medical",
    "views": 25400,
    "likes": 1892,
    "comments": 256,
    "shares": 423,
    "bookmarks": 1067,
    "tags": ["AI", "Healthcare", "Technology", "Medicine", "Future"],
    "relatedTopics": ["Machine Learning", "Medical Technology", "Digital Health", "Innovation"],
  };

  final List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "author": "Michael Johnson",
      "authorImage": "https://picsum.photos/40/40?random=2&keyword=man",
      "content": "Excellent article! As someone working in medical technology, I can confirm that AI is indeed transforming our field. The potential for early disease detection is particularly exciting.",
      "timestamp": "2024-01-20T11:45:00Z",
      "likes": 23,
      "replies": [
        {
          "id": 11,
          "author": "Dr. Sarah Chen",
          "authorImage": "https://picsum.photos/40/40?random=1&keyword=doctor",
          "content": "Thank you, Michael! It's great to hear from someone in the field. The early detection capabilities are indeed game-changing.",
          "timestamp": "2024-01-20T12:15:00Z",
          "likes": 8,
        },
      ],
    },
    {
      "id": 2,
      "author": "Emily Rodriguez",
      "authorImage": "https://picsum.photos/40/40?random=3&keyword=woman",
      "content": "This is fascinating! I'm curious about the regulatory challenges. How long does it typically take for AI medical devices to get approved?",
      "timestamp": "2024-01-20T13:20:00Z",
      "likes": 15,
      "replies": [],
    },
    {
      "id": 3,
      "author": "David Park",
      "authorImage": "https://picsum.photos/40/40?random=4&keyword=man",
      "content": "Great insights on the ethical considerations. Patient data privacy is crucial as we advance these technologies.",
      "timestamp": "2024-01-20T14:30:00Z",
      "likes": 19,
      "replies": [
        {
          "id": 31,
          "author": "Lisa Wang",
          "authorImage": "https://picsum.photos/40/40?random=5&keyword=woman",
          "content": "Absolutely agree. We need robust frameworks to protect patient privacy while enabling innovation.",
          "timestamp": "2024-01-20T15:00:00Z",
          "likes": 5,
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> relatedPosts = [
    {
      "title": "Machine Learning in Drug Discovery",
      "author": "Dr. James Wilson",
      "readTime": 8,
      "image": "https://picsum.photos/200/120?random=6&keyword=laboratory",
      "views": 12400,
    },
    {
      "title": "Digital Health Trends 2024",
      "author": "Maria Garcia",
      "readTime": 6,
      "image": "https://picsum.photos/200/120?random=7&keyword=health",
      "views": 8900,
    },
    {
      "title": "Ethics in AI Healthcare",
      "author": "Prof. Robert Kim",
      "readTime": 10,
      "image": "https://picsum.photos/200/120?random=8&keyword=ethics",
      "views": 15600,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Image.network(
              "${currentPost["image"]}",
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Read Time
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${currentPost["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${currentPost["readTime"]} min read",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Title and Subtitle
                  Text(
                    "${currentPost["title"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${currentPost["subtitle"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Author Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${currentPost["authorImage"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentPost["author"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Published on Jan 20, 2024",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Follow",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Engagement Stats
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.visibility, color: infoColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${((currentPost["views"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Views",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.favorite, color: dangerColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${currentPost["likes"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Likes",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.comment, color: successColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${currentPost["comments"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Comments",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.bookmark, color: warningColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${currentPost["bookmarks"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Saves",
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

                  SizedBox(height: spMd),

                  // Tags
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (currentPost["tags"] as List).map<Widget>((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spMd),

                  // Article Content
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${currentPost["content"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        height: 1.7,
                      ),
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Author Bio
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${currentPost["authorImage"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "About ${currentPost["author"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${currentPost["authorBio"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Like Article",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Comments Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comments (${comments.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showComments = !showComments;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Text(
                              showComments ? "Hide" : "Show",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              showComments ? Icons.expand_less : Icons.expand_more,
                              color: primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (showComments) ...[
                    SizedBox(height: spSm),
                    Column(
                      children: comments.map((comment) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage("${comment["authorImage"]}"),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${comment["author"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "2 hours ago",
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
                                      Icon(Icons.favorite, size: 14, color: dangerColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${comment["likes"]}",
                                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${comment["content"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  height: 1.4,
                                ),
                              ),
                              if ((comment["replies"] as List).isNotEmpty) ...[
                                SizedBox(height: spSm),
                                Container(
                                  margin: EdgeInsets.only(left: spMd),
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: (comment["replies"] as List).map<Widget>((reply) {
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundImage: NetworkImage("${reply["authorImage"]}"),
                                          ),
                                          SizedBox(width: spSm),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${reply["author"]}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  "${reply["content"]}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  SizedBox(height: spMd),

                  // Related Posts
                  Text(
                    "Related Articles",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),

                  Column(
                    children: relatedPosts.map((post) {
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${post["image"]}",
                                width: 80,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${post["title"]}",
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
                                    "${post["author"]} • ${post["readTime"]} min read",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${((post["views"] as int) / 1000).toStringAsFixed(1)}K views",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward, color: disabledBoldColor),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
