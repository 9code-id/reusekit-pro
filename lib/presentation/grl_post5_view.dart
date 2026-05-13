import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost5View extends StatefulWidget {
  @override
  State<GrlPost5View> createState() => _GrlPost5ViewState();
}

class _GrlPost5ViewState extends State<GrlPost5View> {
  bool isLiked = false;
  bool isSaved = false;
  bool isFollowing = false;
  String commentText = "";

  Map<String, dynamic> article = {
    "id": 1,
    "title": "The Future of Artificial Intelligence in Healthcare",
    "subtitle": "Exploring how AI is revolutionizing patient care and medical diagnosis",
    "author": "Dr. Emily Watson",
    "authorAvatar": "https://picsum.photos/100/100?random=1&keyword=doctor",
    "authorBio": "Senior Researcher at MIT Health Tech Lab, specializing in AI applications in healthcare",
    "publishedAt": "June 20, 2025",
    "readTime": 12,
    "category": "Technology",
    "tags": ["AI", "Healthcare", "Technology", "Innovation"],
    "image": "https://picsum.photos/800/400?random=1&keyword=healthcare",
    "likes": 1247,
    "comments": 89,
    "shares": 156,
    "content": [
      {
        "type": "paragraph",
        "text": "Artificial Intelligence is transforming healthcare at an unprecedented pace. From diagnostic imaging to drug discovery, AI technologies are enhancing the capabilities of healthcare professionals and improving patient outcomes across the globe."
      },
      {
        "type": "heading",
        "text": "AI in Medical Diagnosis"
      },
      {
        "type": "paragraph",
        "text": "One of the most promising applications of AI in healthcare is in medical diagnosis. Machine learning algorithms can analyze medical images with remarkable accuracy, often detecting conditions that might be missed by human eyes."
      },
      {
        "type": "image",
        "url": "https://picsum.photos/600/300?random=2&keyword=medical",
        "caption": "AI-powered medical imaging systems"
      },
      {
        "type": "heading",
        "text": "Personalized Treatment Plans"
      },
      {
        "type": "paragraph",
        "text": "AI enables the creation of personalized treatment plans based on individual patient data, genetic information, and treatment history. This personalized approach leads to better outcomes and fewer side effects."
      },
      {
        "type": "quote",
        "text": "The integration of AI in healthcare is not about replacing doctors, but about augmenting their capabilities to provide better patient care.",
        "author": "Dr. Sarah Johnson, Healthcare AI Expert"
      },
      {
        "type": "paragraph",
        "text": "As we look to the future, the potential for AI in healthcare continues to expand. From robotic surgery to predictive analytics, we are only beginning to scratch the surface of what's possible."
      }
    ]
  };

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "author": "Michael Chen",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=portrait",
      "time": "2 hours ago",
      "text": "Fascinating article! I'm particularly interested in the applications of AI in radiology. The accuracy improvements are remarkable.",
      "likes": 23,
      "isLiked": false,
      "replies": [
        {
          "id": 11,
          "author": "Dr. Emily Watson",
          "avatar": "https://picsum.photos/50/50?random=1&keyword=doctor",
          "time": "1 hour ago",
          "text": "Thank you Michael! Radiology is indeed one of the most advanced areas of AI implementation.",
          "likes": 8,
          "isLiked": true,
        }
      ]
    },
    {
      "id": 2,
      "author": "Sarah Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=portrait",
      "time": "4 hours ago",
      "text": "What are your thoughts on the ethical implications of AI in healthcare decision-making?",
      "likes": 15,
      "isLiked": true,
      "replies": []
    },
    {
      "id": 3,
      "author": "David Kim",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=portrait",
      "time": "6 hours ago",
      "text": "Great insights! I'd love to see more discussion about data privacy concerns in AI healthcare systems.",
      "likes": 31,
      "isLiked": false,
      "replies": []
    }
  ];

  List<Map<String, dynamic>> relatedPosts = [
    {
      "id": 2,
      "title": "Machine Learning in Drug Discovery",
      "author": "Dr. James Wilson",
      "image": "https://picsum.photos/200/120?random=6&keyword=laboratory",
      "readTime": 8,
      "category": "Research"
    },
    {
      "id": 3,
      "title": "The Ethics of AI in Medicine",
      "author": "Prof. Lisa Thompson",
      "image": "https://picsum.photos/200/120?random=7&keyword=ethics",
      "readTime": 10,
      "category": "Ethics"
    },
    {
      "id": 4,
      "title": "Robotic Surgery: Current State and Future",
      "author": "Dr. Robert Chang",
      "image": "https://picsum.photos/200/120?random=8&keyword=surgery",
      "readTime": 15,
      "category": "Innovation"
    }
  ];

  void _toggleLike() {
    isLiked = !isLiked;
    if (isLiked) {
      article["likes"] = (article["likes"] as int) + 1;
    } else {
      article["likes"] = (article["likes"] as int) - 1;
    }
    setState(() {});
  }

  void _toggleSave() {
    isSaved = !isSaved;
    setState(() {});
  }

  void _toggleFollow() {
    isFollowing = !isFollowing;
    setState(() {});
    if (isFollowing) {
      ss("Following ${article["author"]}");
    } else {
      ss("Unfollowed ${article["author"]}");
    }
  }

  void _toggleCommentLike(int commentId) {
    int index = comments.indexWhere((comment) => comment["id"] == commentId);
    if (index != -1) {
      comments[index]["isLiked"] = !(comments[index]["isLiked"] as bool);
      if (comments[index]["isLiked"] as bool) {
        comments[index]["likes"] = (comments[index]["likes"] as int) + 1;
      } else {
        comments[index]["likes"] = (comments[index]["likes"] as int) - 1;
      }
      setState(() {});
    }
  }

  void _addComment() {
    if (commentText.trim().isNotEmpty) {
      Map<String, dynamic> newComment = {
        "id": comments.length + 1,
        "author": "You",
        "avatar": "https://picsum.photos/50/50?random=99&keyword=portrait",
        "time": "Just now",
        "text": commentText,
        "likes": 0,
        "isLiked": false,
        "replies": []
      };
      comments.insert(0, newComment);
      commentText = "";
      setState(() {});
      ss("Comment added successfully");
    }
  }

  Widget _buildContentSection(Map<String, dynamic> content) {
    switch (content["type"]) {
      case "paragraph":
        return Padding(
          padding: EdgeInsets.only(bottom: spMd),
          child: Text(
            "${content["text"]}",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: primaryColor,
            ),
          ),
        );
      case "heading":
        return Padding(
          padding: EdgeInsets.symmetric(vertical: spMd),
          child: Text(
            "${content["text"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        );
      case "image":
        return Padding(
          padding: EdgeInsets.only(bottom: spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${content["url"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              if (content["caption"] != null) ...[
                SizedBox(height: spSm),
                Text(
                  "${content["caption"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        );
      case "quote":
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
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
              Text(
                "\"${content["text"]}\"",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
              if (content["author"] != null) ...[
                SizedBox(height: spSm),
                Text(
                  "— ${content["author"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildCommentCard(Map<String, dynamic> comment) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
                radius: 18,
                backgroundImage: NetworkImage("${comment["avatar"]}"),
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
                      "${comment["time"]}",
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
          SizedBox(height: spSm),
          Text(
            "${comment["text"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              GestureDetector(
                onTap: () => _toggleCommentLike(comment["id"] as int),
                child: Row(
                  children: [
                    Icon(
                      (comment["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: (comment["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${comment["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Reply",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if ((comment["replies"] as List).isNotEmpty) ...[
            SizedBox(height: spMd),
            ...((comment["replies"] as List).map((reply) {
              return Container(
                margin: EdgeInsets.only(left: spLg, top: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage("${reply["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${reply["author"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${reply["time"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${reply["text"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }).toList()),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Article shared");
            },
          ),
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleSave,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${article["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${article["title"]}",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                height: 1.3,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${article["subtitle"]}",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: spMd),
            
            // Author Info
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage("${article["authorAvatar"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${article["author"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${article["authorBio"]}",
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
                            "${article["publishedAt"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            " • ${(article["readTime"] as int)} min read",
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
                  label: isFollowing ? "Following" : "Follow",
                  size: bs.sm,
                  onPressed: _toggleFollow,
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            // Article Image
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${article["image"]}",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: spLg),
            
            // Article Content
            ...(article["content"] as List<Map<String, dynamic>>).map((content) => _buildContentSection(content)).toList(),
            
            SizedBox(height: spLg),
            
            // Tags
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: (article["tags"] as List<String>).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "#$tag",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),
            
            // Article Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? dangerColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${article["likes"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spLg),
                  Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${article["comments"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      ss("Article shared");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${article["shares"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Related Posts
            Text(
              "Related Articles",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QHorizontalScroll(
              children: relatedPosts.map((post) {
                return Container(
                  width: 250,
                  margin: EdgeInsets.only(right: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${post["image"]}",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
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
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "${post["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(post["readTime"] as int)} min",
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
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),
            
            // Comments Section
            Row(
              children: [
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${comments.length} comments",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Add Comment
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Add a comment...",
                    value: commentText,
                    hint: "Share your thoughts",
                    onChanged: (value) {
                      commentText = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: _addComment,
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Comments List
            ...comments.map((comment) => _buildCommentCard(comment)).toList(),
          ],
        ),
      ),
    );
  }
}
