import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment7View extends StatefulWidget {
  @override
  State<GrlComment7View> createState() => _GrlComment7ViewState();
}

class _GrlComment7ViewState extends State<GrlComment7View> {
  String comment = "";
  String selectedFilter = "All Comments";
  List<String> filterOptions = ["All Comments", "My Comments", "Mentions", "Favorites"];
  
  List<Map<String, dynamic>> comments = [
    {
      "id": "1",
      "user": {
        "name": "Dr. Elena Vasquez",
        "avatar": "https://picsum.photos/40/40?random=31",
        "role": "Technical Lead",
        "department": "AI Research",
        "status": "online",
        "reputation": 2340,
      },
      "content": "This implementation showcases excellent design patterns. I particularly appreciate the clean separation of concerns and the thoughtful error handling. The documentation is also top-notch!\n\nFor those interested in diving deeper, I recommend checking out the companion repository with additional examples and test cases.",
      "likes": 187,
      "replies": 28,
      "shares": 15,
      "isLiked": true,
      "isBookmarked": false,
      "timestamp": "2h ago",
      "lastEdited": "1h ago",
      "visibility": "public",
      "sentiment": "positive",
      "attachments": [
        {
          "type": "link",
          "title": "Related Documentation",
          "url": "https://docs.example.com",
          "preview": "Comprehensive guide to advanced patterns"
        }
      ],
      "mentions": ["@john_doe", "@sarah_tech"],
      "hashtags": ["#bestpractices", "#architecture", "#flutter"],
      "location": "San Francisco, CA",
      "replies_list": [
        {
          "id": "1-1",
          "user": {
            "name": "Marcus Thompson",
            "avatar": "https://picsum.photos/40/40?random=32",
            "role": "Senior Developer",
          },
          "content": "Absolutely agree! The error handling approach here is something our team has been looking for. Mind if I adapt this for our project?",
          "likes": 45,
          "isLiked": false,
          "timestamp": "1h ago",
        }
      ]
    },
    {
      "id": "2",
      "user": {
        "name": "James Rodriguez",
        "avatar": "https://picsum.photos/40/40?random=33",
        "role": "Product Manager",
        "department": "Mobile Team",
        "status": "away",
        "reputation": 1850,
      },
      "content": "From a product perspective, this feature addresses several key user pain points we've identified. The UX flow is intuitive and the performance metrics are impressive.\n\nOur beta testing showed a 35% increase in user engagement with this implementation! 📊",
      "likes": 134,
      "replies": 19,
      "shares": 8,
      "isLiked": false,
      "isBookmarked": true,
      "timestamp": "4h ago",
      "lastEdited": "",
      "visibility": "public",
      "sentiment": "positive",
      "attachments": [
        {
          "type": "image",
          "title": "Performance Metrics",
          "url": "https://picsum.photos/400/250?random=2",
          "preview": "Chart showing user engagement improvements"
        }
      ],
      "mentions": [],
      "hashtags": ["#userexperience", "#metrics", "#success"],
      "location": "Remote",
      "replies_list": []
    },
    {
      "id": "3",
      "user": {
        "name": "Sarah Kim",
        "avatar": "https://picsum.photos/40/40?random=34",
        "role": "QA Engineer",
        "department": "Quality Assurance",
        "status": "online",
        "reputation": 1650,
      },
      "content": "Excellent work! I've tested this across multiple devices and platforms. The cross-platform compatibility is outstanding. Here are my findings:\n\n✅ iOS 14+ - Perfect\n✅ Android 8+ - Smooth performance\n✅ Web - Responsive design works great\n⚠️ Older devices - Minor lag but acceptable\n\nOverall quality score: 9.2/10",
      "likes": 98,
      "replies": 12,
      "shares": 22,
      "isLiked": true,
      "isBookmarked": false,
      "timestamp": "6h ago",
      "lastEdited": "5h ago",
      "visibility": "public",
      "sentiment": "positive",
      "attachments": [],
      "mentions": ["@dev_team"],
      "hashtags": ["#testing", "#quality", "#crossplatform"],
      "location": "Seoul, South Korea",
      "replies_list": []
    },
    {
      "id": "4",
      "user": {
        "name": "Ahmed Hassan",
        "avatar": "https://picsum.photos/40/40?random=35",
        "role": "Security Specialist",
        "department": "InfoSec",
        "status": "busy",
        "reputation": 2100,
      },
      "content": "From a security standpoint, this implementation follows industry best practices. The input validation is robust and the data handling meets our compliance requirements.\n\nOne suggestion: consider implementing additional rate limiting for the API endpoints to prevent abuse. Otherwise, this is ready for production! 🔒",
      "likes": 76,
      "replies": 8,
      "shares": 5,
      "isLiked": false,
      "isBookmarked": true,
      "timestamp": "8h ago",
      "lastEdited": "",
      "visibility": "public",
      "sentiment": "neutral",
      "attachments": [
        {
          "type": "document",
          "title": "Security Audit Report",
          "url": "https://docs.example.com/security",
          "preview": "Detailed security analysis and recommendations"
        }
      ],
      "mentions": ["@security_team"],
      "hashtags": ["#security", "#compliance", "#production"],
      "location": "Dubai, UAE",
      "replies_list": []
    }
  ];

  List<Map<String, dynamic>> get filteredComments {
    switch (selectedFilter) {
      case "My Comments":
        return comments.where((c) => c["user"]["name"] == "You").toList();
      case "Mentions":
        return comments.where((c) => (c["mentions"] as List).contains("@you")).toList();
      case "Favorites":
        return comments.where((c) => c["isBookmarked"] == true).toList();
      default:
        return comments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Professional Discussion"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              _showFilterModal();
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Professional Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.business,
                      color: primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enterprise Discussion Board",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Share insights • Collaborate • Drive innovation",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard("Active", "127", Icons.people, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildMetricCard("Posts", "${comments.length}", Icons.message, primaryColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildMetricCard("Engagement", "94%", Icons.trending_up, warningColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filter Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Icon(
                  Icons.tune,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    items: filterOptions.map((filter) => {
                      "label": filter,
                      "value": filter,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: filteredComments.map((comment) => _buildProfessionalComment(comment)).toList(),
              ),
            ),
          ),

          // Professional Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowLg],
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Share your professional insight...",
                        value: comment,
                        hint: "Contribute to the discussion with expertise",
                        onChanged: (value) {
                          comment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 12,
                            color: primaryColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Public",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.attachment,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.code,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.tag,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    QButton(
                      label: "Post",
                      size: bs.sm,
                      onPressed: comment.isNotEmpty ? () {
                        _postComment();
                      } : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowXs],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalComment(Map<String, dynamic> comment) {
    final user = comment["user"];
    final attachments = comment["attachments"] as List;
    final mentions = comment["mentions"] as List;
    final hashtags = comment["hashtags"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professional Header
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${user["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _getStatusColor(user["status"]),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
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
                    Row(
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["reputation"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${user["role"]} • ${user["department"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${comment["location"]} • ${comment["timestamp"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (comment["lastEdited"] != "") ...[
                          Text(
                            " • edited ${comment["lastEdited"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getSentimentColor(comment["sentiment"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${comment["visibility"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getSentimentColor(comment["sentiment"]),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Content
          Text(
            "${comment["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.6,
            ),
          ),

          // Hashtags
          if (hashtags.isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: hashtags.map((tag) => GestureDetector(
                onTap: () {},
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],

          // Mentions
          if (mentions.isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: mentions.map((mention) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$mention",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              )).toList(),
            ),
          ],

          // Attachments
          if (attachments.isNotEmpty) ...[
            SizedBox(height: spMd),
            ...attachments.map((attachment) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Row(
                children: [
                  Icon(
                    _getAttachmentIcon(attachment["type"]),
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${attachment["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${attachment["preview"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.launch,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                ],
              ),
            )),
          ],

          SizedBox(height: spMd),

          // Professional Actions
          Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Row(
              children: [
                _buildActionButton(
                  icon: comment["isLiked"] ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: "${comment["likes"]}",
                  color: comment["isLiked"] ? primaryColor : disabledBoldColor,
                  onTap: () {
                    comment["isLiked"] = !comment["isLiked"];
                    if (comment["isLiked"]) {
                      comment["likes"] = (comment["likes"] as int) + 1;
                    } else {
                      comment["likes"] = (comment["likes"] as int) - 1;
                    }
                    setState(() {});
                  },
                ),
                SizedBox(width: spMd),
                _buildActionButton(
                  icon: Icons.reply,
                  label: "${comment["replies"]}",
                  color: disabledBoldColor,
                  onTap: () {},
                ),
                SizedBox(width: spMd),
                _buildActionButton(
                  icon: Icons.share,
                  label: "${comment["shares"]}",
                  color: disabledBoldColor,
                  onTap: () {},
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    comment["isBookmarked"] = !comment["isBookmarked"];
                    setState(() {});
                  },
                  child: Icon(
                    comment["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: comment["isBookmarked"] ? warningColor : disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
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
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "online": return successColor;
      case "away": return warningColor;
      case "busy": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case "positive": return successColor;
      case "negative": return dangerColor;
      case "neutral": return primaryColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getAttachmentIcon(String type) {
    switch (type) {
      case "link": return Icons.link;
      case "image": return Icons.image;
      case "document": return Icons.description;
      case "video": return Icons.video_library;
      default: return Icons.attach_file;
    }
  }

  void _showFilterModal() {
    // Show filter modal implementation
  }

  void _postComment() {
    if (comment.trim().isEmpty) return;
    
    final newComment = {
      "id": "${comments.length + 1}",
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=100",
        "role": "Software Developer",
        "department": "Engineering",
        "status": "online",
        "reputation": 850,
      },
      "content": comment,
      "likes": 0,
      "replies": 0,
      "shares": 0,
      "isLiked": false,
      "isBookmarked": false,
      "timestamp": "now",
      "lastEdited": "",
      "visibility": "public",
      "sentiment": "neutral",
      "attachments": [],
      "mentions": [],
      "hashtags": [],
      "location": "Remote",
      "replies_list": [],
    };
    
    comments.insert(0, newComment);
    comment = "";
    setState(() {});
    
    ss("Professional insight shared successfully!");
  }
}
