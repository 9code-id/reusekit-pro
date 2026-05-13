import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaShareArticleView extends StatefulWidget {
  const NmaShareArticleView({super.key});

  @override
  State<NmaShareArticleView> createState() => _NmaShareArticleViewState();
}

class _NmaShareArticleViewState extends State<NmaShareArticleView> {
  String articleTitle = "Breaking: Major Infrastructure Development Announced";
  String articleUrl = "https://news.local/infrastructure-development-2024";
  String personalMessage = "";
  List<String> selectedPlatforms = [];
  bool includePersonalMessage = false;
  bool trackShares = true;

  final Map<String, dynamic> article = {
    "title": "Breaking: Major Infrastructure Development Announced",
    "summary": "City officials announced a \$500M infrastructure development project that will transform downtown area over the next 3 years.",
    "author": "Sarah Johnson",
    "publishDate": "2024-01-15",
    "readTime": "3 min read",
    "category": "Local News",
    "image": "https://picsum.photos/400/300?random=1&city",
    "url": "https://news.local/infrastructure-development-2024",
    "views": 2534,
    "shares": 127
  };

  final List<Map<String, dynamic>> socialPlatforms = [
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": Color(0xFF1877F2),
      "description": "Share with friends and family",
      "maxLength": 2000,
      "features": ["Text", "Link Preview", "Images"]
    },
    {
      "name": "Twitter",
      "icon": Icons.alternate_email,
      "color": Color(0xFF1DA1F2),
      "description": "Tweet to your followers",
      "maxLength": 280,
      "features": ["Text", "Hashtags", "Mentions"]
    },
    {
      "name": "LinkedIn",
      "icon": Icons.work,
      "color": Color(0xFF0077B5),
      "description": "Share with professional network",
      "maxLength": 1300,
      "features": ["Text", "Professional Context", "Link Preview"]
    },
    {
      "name": "WhatsApp",
      "icon": Icons.message,
      "color": Color(0xFF25D366),
      "description": "Send to contacts and groups",
      "maxLength": 4096,
      "features": ["Text", "Link", "Direct Messaging"]
    },
    {
      "name": "Telegram",
      "icon": Icons.send,
      "color": Color(0xFF0088CC),
      "description": "Share in channels and chats",
      "maxLength": 4096,
      "features": ["Text", "Channels", "Rich Formatting"]
    },
    {
      "name": "Email",
      "icon": Icons.email,
      "color": Color(0xFF34A853),
      "description": "Send via email",
      "maxLength": 10000,
      "features": ["Subject", "Rich Text", "Attachments"]
    }
  ];

  final List<Map<String, dynamic>> shareTemplates = [
    {
      "name": "Breaking News",
      "template": "🚨 BREAKING: {title}\n\nRead more: {url}\n\n#BreakingNews #LocalNews",
      "description": "For urgent news updates"
    },
    {
      "name": "Informative",
      "template": "📰 Important update: {title}\n\n{summary}\n\nFull article: {url}",
      "description": "For general news sharing"
    },
    {
      "name": "Discussion Starter",
      "template": "What are your thoughts on this? 🤔\n\n{title}\n\n{url}\n\n#Discussion #Community",
      "description": "To encourage engagement"
    },
    {
      "name": "Professional",
      "template": "Industry update: {title}\n\nKey insights from this article could impact our sector.\n\n{url}",
      "description": "For LinkedIn and professional networks"
    }
  ];

  final List<Map<String, dynamic>> recentShares = [
    {
      "article": "Local Park Restoration Update",
      "platform": "Facebook",
      "timestamp": "2 hours ago",
      "engagement": "12 likes, 3 comments"
    },
    {
      "article": "Traffic Alert: Main Street",
      "platform": "Twitter",
      "timestamp": "5 hours ago",
      "engagement": "8 retweets, 15 likes"
    },
    {
      "article": "Community Festival Announcement",
      "platform": "WhatsApp",
      "timestamp": "1 day ago",
      "engagement": "Sent to 5 contacts"
    }
  ];

  String _formatTemplate(String template) {
    return template
        .replaceAll("{title}", article["title"])
        .replaceAll("{summary}", article["summary"])
        .replaceAll("{url}", article["url"])
        .replaceAll("{author}", article["author"]);
  }

  Color _getPlatformColor(String platform) {
    final platformData = socialPlatforms.firstWhere(
      (p) => p["name"] == platform,
      orElse: () => {"color": primaryColor},
    );
    return platformData["color"];
  }

  void _shareToMultiplePlatforms() {
    if (selectedPlatforms.isEmpty) {
      se("Please select at least one platform");
      return;
    }

    for (String platform in selectedPlatforms) {
      // In a real app, this would integrate with platform-specific APIs
      ss("Shared to $platform successfully");
    }

    // Clear selections after sharing
    selectedPlatforms.clear();
    personalMessage = "";
    includePersonalMessage = false;
    setState(() {});
  }

  Widget _buildArticlePreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.article, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Article to Share",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${article["image"]}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${article["category"]}",
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${article["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${article["summary"]}",
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text("${article["author"]}", style: TextStyle(color: disabledBoldColor)),
              SizedBox(width: spMd),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text("${article["readTime"]}", style: TextStyle(color: disabledBoldColor)),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.link, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${article["url"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ss("Link copied to clipboard");
                  },
                  child: Icon(Icons.copy, size: 16, color: primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Platforms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Choose where you want to share this article",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            minItemWidth: 200,
            children: socialPlatforms.map((platform) {
              final isSelected = selectedPlatforms.contains(platform["name"]);
              
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedPlatforms.remove(platform["name"]);
                  } else {
                    selectedPlatforms.add(platform["name"]);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? (platform["color"] as Color).withAlpha(30) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? platform["color"] : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        platform["icon"],
                        color: platform["color"],
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${platform["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${platform["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (platform["features"] as List).take(2).map<Widget>((feature) {
                          return Container(
                            margin: EdgeInsets.only(right: spXs),
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageCustomization() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Customize Message",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Switch(
                value: includePersonalMessage,
                onChanged: (value) {
                  includePersonalMessage = value;
                  setState(() {});
                },
              ),
            ],
          ),
          
          if (includePersonalMessage) ...[
            SizedBox(height: spMd),
            
            Text(
              "Quick Templates",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: shareTemplates.map((template) {
                return GestureDetector(
                  onTap: () {
                    personalMessage = _formatTemplate(template["template"]);
                    setState(() {});
                  },
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            QMemoField(
              label: "Your Message",
              value: personalMessage,
              hint: "Add your personal message or use a template above",
              onChanged: (value) {
                personalMessage = value;
                setState(() {});
              },
            ),
          ],
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Track share performance",
                      "value": true,
                      "checked": trackShares,
                    }
                  ],
                  value: [
                    if (trackShares)
                      {
                        "label": "Track share performance",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    trackShares = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareHistory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Shares",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...recentShares.map((share) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getPlatformColor(share["platform"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      _getPlatformIcon(share["platform"]),
                      color: _getPlatformColor(share["platform"]),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${share["article"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Shared on ${share["platform"]} • ${share["timestamp"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        if (share["engagement"] != null)
                          Text(
                            "${share["engagement"]}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case "Facebook": return Icons.facebook;
      case "Twitter": return Icons.alternate_email;
      case "WhatsApp": return Icons.message;
      default: return Icons.share;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Article"),
        actions: [
          IconButton(
            onPressed: () {
              ss("Article bookmarked");
            },
            icon: Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildArticlePreview(),
            _buildPlatformSelection(),
            _buildMessageCustomization(),
            _buildShareHistory(),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: selectedPlatforms.isEmpty 
                    ? "Select Platforms to Share" 
                    : "Share to ${selectedPlatforms.length} Platform${selectedPlatforms.length > 1 ? 's' : ''}",
                size: bs.md,
                onPressed: selectedPlatforms.isEmpty ? null : _shareToMultiplePlatforms,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
