import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSocialSharingView extends StatefulWidget {
  const EcsSocialSharingView({super.key});

  @override
  State<EcsSocialSharingView> createState() => _EcsSocialSharingViewState();
}

class _EcsSocialSharingViewState extends State<EcsSocialSharingView> {
  String selectedProduct = "Wireless Headphones";
  String shareMessage = "";
  List<String> selectedPlatforms = [];
  bool includeProductLink = true;
  bool includeDiscount = true;
  bool addPersonalMessage = false;
  String personalMessage = "";
  
  List<Map<String, dynamic>> sharingPlatforms = [
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": Color(0xFF1877F2),
      "isSelected": false,
      "description": "Share with friends and family"
    },
    {
      "name": "Instagram",
      "icon": Icons.camera_alt,
      "color": Color(0xFFE4405F),
      "isSelected": false,
      "description": "Share to your story or feed"
    },
    {
      "name": "Twitter",
      "icon": Icons.alternate_email,
      "color": Color(0xFF1DA1F2),
      "isSelected": false,
      "description": "Tweet to your followers"
    },
    {
      "name": "WhatsApp",
      "icon": Icons.chat,
      "color": Color(0xFF25D366),
      "isSelected": false,
      "description": "Share with contacts"
    },
    {
      "name": "Telegram",
      "icon": Icons.send,
      "color": Color(0xFF0088CC),
      "isSelected": false,
      "description": "Send to Telegram contacts"
    },
    {
      "name": "Pinterest",
      "icon": Icons.push_pin,
      "color": Color(0xFFBD081C),
      "isSelected": false,
      "description": "Pin to your boards"
    },
    {
      "name": "LinkedIn",
      "icon": Icons.work,
      "color": Color(0xFF0077B5),
      "isSelected": false,
      "description": "Share professionally"
    },
    {
      "name": "Email",
      "icon": Icons.email,
      "color": Color(0xFF34495E),
      "isSelected": false,
      "description": "Send via email"
    },
  ];

  List<Map<String, dynamic>> shareTemplates = [
    {
      "title": "Product Recommendation",
      "message": "Just found this amazing product! 😍 Check it out:",
      "emoji": "👍",
    },
    {
      "title": "Great Deal Alert",
      "message": "Don't miss this incredible deal! 🔥 Limited time offer:",
      "emoji": "💰",
    },
    {
      "title": "Review Share",
      "message": "I'm loving this product! ⭐ Here's my honest review:",
      "emoji": "📝",
    },
    {
      "title": "Gift Idea",
      "message": "Perfect gift idea! 🎁 This would be amazing for:",
      "emoji": "🎁",
    },
  ];

  Map<String, dynamic> currentProduct = {
    "name": "Wireless Headphones",
    "price": 299.99,
    "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
    "rating": 4.5,
    "discount": 25,
    "link": "https://example.com/product/wireless-headphones",
  };

  @override
  void initState() {
    super.initState();
    _generateShareMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _showSharingHistory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductPreview(),
            SizedBox(height: spLg),
            _buildShareTemplates(),
            SizedBox(height: spLg),
            _buildCustomMessage(),
            SizedBox(height: spLg),
            _buildShareOptions(),
            SizedBox(height: spLg),
            _buildSocialPlatforms(),
            SizedBox(height: spLg),
            _buildSharePreview(),
            SizedBox(height: spLg),
            _buildSharingStats(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Share Now",
                size: bs.md,
                onPressed: _shareProduct,
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.copy,
              size: bs.md,
              onPressed: _copyShareLink,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPreview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${currentProduct["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${currentProduct["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "\$${((currentProduct["price"] as double) * (1 - (currentProduct["discount"] as int) / 100)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${(currentProduct["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 14,
                        color: index < (currentProduct["rating"] as double).floor()
                            ? warningColor
                            : disabledColor,
                      );
                    }),
                    SizedBox(width: spXs),
                    Text(
                      "${currentProduct["rating"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: dangerColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "-${currentProduct["discount"]}%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareTemplates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Share Templates",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: shareTemplates.map((template) {
            return GestureDetector(
              onTap: () => _selectTemplate(template),
              child: Container(
                width: 200,
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${template["emoji"]}",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${template["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${template["message"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCustomMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Add Personal Message",
                    "value": true,
                    "checked": addPersonalMessage,
                  }
                ],
                value: [
                  if (addPersonalMessage)
                    {
                      "label": "Add Personal Message",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  addPersonalMessage = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        if (addPersonalMessage) ...[
          SizedBox(height: spSm),
          QMemoField(
            label: "Personal Message",
            value: personalMessage,
            hint: "Add your personal thoughts about this product...",
            onChanged: (value) {
              personalMessage = value;
              _generateShareMessage();
            },
          ),
        ],
      ],
    );
  }

  Widget _buildShareOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Product Link",
                      "value": true,
                      "checked": includeProductLink,
                    }
                  ],
                  value: [
                    if (includeProductLink)
                      {
                        "label": "Include Product Link",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    includeProductLink = values.isNotEmpty;
                    _generateShareMessage();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Discount Info",
                      "value": true,
                      "checked": includeDiscount,
                    }
                  ],
                  value: [
                    if (includeDiscount)
                      {
                        "label": "Include Discount Info",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    includeDiscount = values.isNotEmpty;
                    _generateShareMessage();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialPlatforms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Platforms",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: sharingPlatforms.map((platform) {
            bool isSelected = platform["isSelected"];
            return GestureDetector(
              onTap: () => _togglePlatform(platform["name"]),
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? (platform["color"] as Color).withAlpha(25)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected 
                        ? (platform["color"] as Color)
                        : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      platform["icon"],
                      size: 32,
                      color: isSelected 
                          ? (platform["color"] as Color)
                          : disabledBoldColor,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${platform["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected 
                            ? (platform["color"] as Color)
                            : disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${platform["description"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSharePreview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (shareMessage.isNotEmpty) ...[
                  Text(
                    shareMessage,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                // Product card preview
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${currentProduct["image"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentProduct["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${((currentProduct["price"] as double) * (1 - (currentProduct["discount"] as int) / 100)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
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
        ],
      ),
    );
  }

  Widget _buildSharingStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sharing Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  "Total Shares",
                  "1,234",
                  Icons.share,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatItem(
                  "This Month",
                  "89",
                  Icons.trending_up,
                  successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  "Clicks",
                  "3,456",
                  Icons.mouse,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatItem(
                  "Conversions",
                  "67",
                  Icons.shopping_cart,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _selectTemplate(Map<String, dynamic> template) {
    shareMessage = template["message"];
    _generateShareMessage();
  }

  void _generateShareMessage() {
    String message = shareMessage.isEmpty ? "Check out this amazing product!" : shareMessage;
    
    if (addPersonalMessage && personalMessage.isNotEmpty) {
      message += "\n\n$personalMessage";
    }
    
    if (includeDiscount) {
      message += "\n\n🔥 Special ${currentProduct["discount"]}% OFF - Limited time!";
    }
    
    if (includeProductLink) {
      message += "\n\n${currentProduct["link"]}";
    }
    
    setState(() {});
  }

  void _togglePlatform(String platformName) {
    var platformIndex = sharingPlatforms.indexWhere(
      (p) => p["name"] == platformName,
    );
    if (platformIndex != -1) {
      sharingPlatforms[platformIndex]["isSelected"] = 
          !sharingPlatforms[platformIndex]["isSelected"];
      
      if (sharingPlatforms[platformIndex]["isSelected"]) {
        selectedPlatforms.add(platformName);
      } else {
        selectedPlatforms.remove(platformName);
      }
      
      setState(() {});
    }
  }

  void _shareProduct() {
    if (selectedPlatforms.isEmpty) {
      se("Please select at least one platform to share");
      return;
    }
    
    showLoading();
    
    // Simulate sharing process
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Product shared successfully to ${selectedPlatforms.length} platform(s)");
      
      // Reset selections
      for (var platform in sharingPlatforms) {
        platform["isSelected"] = false;
      }
      selectedPlatforms.clear();
      setState(() {});
    });
  }

  void _copyShareLink() {
    // Copy link to clipboard
    ss("Product link copied to clipboard");
  }

  void _showSharingHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Recent Shares",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your recent sharing activity will appear here",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Close",
                size: bs.sm,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
