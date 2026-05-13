import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle5View extends StatefulWidget {
  @override
  State<GrlArticle5View> createState() => _GrlArticle5ViewState();
}

class _GrlArticle5ViewState extends State<GrlArticle5View> {
  Map<String, dynamic> article = {
    "id": 1,
    "title": "The Future of Artificial Intelligence in Healthcare",
    "category": "Technology",
    "author": "Dr. Sarah Johnson",
    "authorBio": "Leading researcher in AI applications for medical diagnosis",
    "authorImage": "https://picsum.photos/100/100?random=1&keyword=doctor",
    "publishDate": "2024-12-15",
    "readTime": "12 min read",
    "views": 25840,
    "likes": 1567,
    "shares": 234,
    "comments": 89,
    "image": "https://picsum.photos/800/400?random=1&keyword=ai-healthcare",
    "tags": ["AI", "Healthcare", "Technology", "Innovation", "Machine Learning"],
    "content": [
      {
        "type": "paragraph",
        "text": "Artificial Intelligence is revolutionizing healthcare in ways we never imagined. From diagnostic imaging to personalized treatment plans, AI is transforming how we approach medical care and patient outcomes."
      },
      {
        "type": "heading",
        "text": "Current Applications of AI in Healthcare"
      },
      {
        "type": "paragraph",
        "text": "Today's healthcare systems are already benefiting from AI implementation across various domains. Medical imaging analysis has seen significant improvements in accuracy and speed, with AI systems now capable of detecting early-stage cancers that might be missed by human radiologists."
      },
      {
        "type": "list",
        "items": [
          "Diagnostic imaging and radiology",
          "Drug discovery and development",
          "Personalized treatment recommendations",
          "Predictive analytics for patient outcomes",
          "Robotic surgery assistance"
        ]
      },
      {
        "type": "heading",
        "text": "The Promise of Predictive Medicine"
      },
      {
        "type": "paragraph",
        "text": "Machine learning algorithms can now analyze vast amounts of patient data to predict health outcomes before symptoms appear. This predictive capability enables healthcare providers to intervene early, potentially preventing serious conditions and improving patient quality of life."
      },
      {
        "type": "quote",
        "text": "AI doesn't replace doctors; it empowers them to make better decisions faster and with greater confidence.",
        "author": "Dr. Michael Chen, Stanford Medical Center"
      },
      {
        "type": "heading",
        "text": "Challenges and Ethical Considerations"
      },
      {
        "type": "paragraph",
        "text": "While the potential benefits are enormous, implementing AI in healthcare comes with significant challenges. Data privacy, algorithmic bias, and the need for regulatory approval are just some of the hurdles that must be overcome."
      }
    ]
  };

  List<Map<String, dynamic>> relatedArticles = [
    {
      "title": "Machine Learning in Drug Discovery",
      "author": "Prof. Michael Chen",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=medicine"
    },
    {
      "title": "Ethics of AI in Medical Practice",
      "author": "Dr. Lisa Rodriguez",
      "readTime": "10 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=ethics"
    },
    {
      "title": "Telemedicine Revolution",
      "author": "Dr. Amanda Kim",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=telemedicine"
    }
  ];

  bool isBookmarked = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image with Overlay
            Stack(
              children: [
                Image.network(
                  "${article["image"]}",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(150),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + spSm,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + spSm,
                  right: spMd,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.share, color: Colors.white, size: 20),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          isBookmarked = !isBookmarked;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? warningColor : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: spLg,
                  left: spMd,
                  right: spMd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${article["category"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${article["title"]}",
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

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article Meta
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${article["authorImage"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${article["author"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${article["authorBio"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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

                  // Article Stats
                  Row(
                    children: [
                      Text(
                        "${article["publishDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(" • ", style: TextStyle(color: disabledColor)),
                      Text(
                        "${article["readTime"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.visibility, color: disabledColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${(article["views"] as int).toString()}",
                        style: TextStyle(color: disabledColor, fontSize: 14),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Article Content
                  ...(article["content"] as List).map((section) {
                    if (section["type"] == "paragraph") {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spMd),
                        child: Text(
                          section["text"],
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: primaryColor,
                          ),
                        ),
                      );
                    } else if (section["type"] == "heading") {
                      return Padding(
                        padding: EdgeInsets.only(top: spLg, bottom: spMd),
                        child: Text(
                          section["text"],
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      );
                    } else if (section["type"] == "list") {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (section["items"] as List).map<Widget>((item) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else if (section["type"] == "quote") {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: spLg),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border(
                            left: BorderSide(
                              color: primaryColor,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.format_quote, color: primaryColor, size: 32),
                            SizedBox(height: spSm),
                            Text(
                              section["text"],
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "— ${section["author"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  }).toList(),

                  SizedBox(height: spXl),

                  // Tags
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: (article["tags"] as List).map<Widget>((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spXl),

                  // Engagement Actions
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isLiked = !isLiked;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: isLiked ? dangerColor.withAlpha(40) : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: isLiked ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(article["likes"] as int).toString()}",
                                  style: TextStyle(
                                    color: isLiked ? dangerColor : disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.comment_outlined, color: disabledBoldColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "${(article["comments"] as int).toString()}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.share_outlined, color: disabledBoldColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "${(article["shares"] as int).toString()}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spXl),

                  // Related Articles
                  Text(
                    "Related Articles",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  Column(
                    children: relatedArticles.map((relatedArticle) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                              child: Image.network(
                                "${relatedArticle["image"]}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${relatedArticle["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${relatedArticle["author"]} • ${relatedArticle["readTime"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Icon(Icons.arrow_forward_ios, color: disabledColor, size: 16),
                            ),
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
