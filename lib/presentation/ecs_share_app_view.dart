import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsShareAppView extends StatefulWidget {
  const EcsShareAppView({super.key});

  @override
  State<EcsShareAppView> createState() => _EcsShareAppViewState();
}

class _EcsShareAppViewState extends State<EcsShareAppView> {
  String personalMessage = "Check out this amazing shopping app I've been using!";
  String selectedPlatform = "";
  List<String> selectedContacts = [];
  
  List<Map<String, dynamic>> socialPlatforms = [
    {
      "name": "WhatsApp",
      "icon": Icons.message,
      "color": successColor,
      "description": "Share with friends and family"
    },
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": primaryColor,
      "description": "Post to your timeline"
    },
    {
      "name": "Twitter",
      "icon": Icons.alternate_email,
      "color": infoColor,
      "description": "Tweet to your followers"
    },
    {
      "name": "Instagram",
      "icon": Icons.camera_alt,
      "color": dangerColor,
      "description": "Share to your story"
    },
    {
      "name": "Email",
      "icon": Icons.email,
      "color": disabledBoldColor,
      "description": "Send via email"
    },
    {
      "name": "SMS",
      "icon": Icons.sms,
      "color": warningColor,
      "description": "Send text message"
    }
  ];

  List<Map<String, dynamic>> contacts = [
    {
      "name": "John Doe",
      "email": "john.doe@email.com",
      "phone": "+1 234 567 8900",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person"
    },
    {
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com", 
      "phone": "+1 234 567 8901",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person"
    },
    {
      "name": "Mike Wilson",
      "email": "mike.wilson@email.com",
      "phone": "+1 234 567 8902",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person"
    },
    {
      "name": "Emily Davis",
      "email": "emily.davis@email.com",
      "phone": "+1 234 567 8903",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person"
    },
    {
      "name": "Alex Brown",
      "email": "alex.brown@email.com",
      "phone": "+1 234 567 8904",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person"
    }
  ];

  Map<String, dynamic> appInfo = {
    "name": "ShopEasy",
    "description": "Your favorite shopping companion with amazing deals and fast delivery",
    "downloadLink": "https://shopyeasy.com/download",
    "rating": 4.8,
    "downloads": "10M+",
    "features": [
      "🛍️ Best deals and discounts",
      "🚚 Fast and free delivery",
      "🔒 Secure payment options",
      "📱 Easy to use interface",
      "💬 24/7 customer support"
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share App"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppPreview(),
            SizedBox(height: spLg),
            _buildPersonalMessage(),
            SizedBox(height: spLg),
            _buildSocialPlatforms(),
            SizedBox(height: spLg),
            _buildReferralBenefits(),
            SizedBox(height: spLg),
            _buildContactSelection(),
            SizedBox(height: spXl),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppPreview() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${appInfo["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${appInfo["rating"]} • ${appInfo["downloads"]} downloads",
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
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${appInfo["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: (appInfo["features"] as List<String>).map((feature) => 
              Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalMessage() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Personal Message",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Your Message",
            value: personalMessage,
            hint: "Add a personal touch to your recommendation",
            onChanged: (value) {
              personalMessage = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.tips_and_updates, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Personalized messages get better responses",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialPlatforms() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.share, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Choose Platform",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 140,
            children: socialPlatforms.map((platform) {
              bool isSelected = selectedPlatform == platform["name"];
              return GestureDetector(
                onTap: () {
                  selectedPlatform = platform["name"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : null,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: platform["color"],
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          platform["icon"],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${platform["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${platform["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 10,
                        ),
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

  Widget _buildReferralBenefits() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.card_giftcard, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Referral Benefits",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor.withAlpha(20), successColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.monetization_on, color: successColor, size: 32),
                          SizedBox(height: spXs),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "For You",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: successColor.withAlpha(50),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.person_add, color: successColor, size: 32),
                          SizedBox(height: spXs),
                          Text(
                            "\$5",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "For Friend",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Earn rewards when your friends sign up and make their first purchase!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contacts, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Select Contacts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (selectedPlatform == "Email" || selectedPlatform == "SMS") ...[
            Text(
              "Choose contacts to share with:",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: spMd),
            ...contacts.map((contact) => _buildContactItem(contact)).toList(),
          ] else ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: disabledBoldColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Select a platform to choose specific contacts",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    bool isSelected = selectedContacts.contains(contact["name"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () {
          if (isSelected) {
            selectedContacts.remove(contact["name"]);
          } else {
            selectedContacts.add(contact["name"]);
          }
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : null,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${contact["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${contact["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      selectedPlatform == "Email" ? "${contact["email"]}" : "${contact["phone"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    bool canShare = selectedPlatform.isNotEmpty;
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Share Now",
            size: bs.md,
            onPressed: canShare ? _shareApp : null,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Copy Link",
            size: bs.md,
            onPressed: _copyLink,
          ),
        ),
        if (selectedContacts.isNotEmpty) ...[
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Sharing with ${selectedContacts.length} contact(s)",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _shareApp() {
    String message = "$personalMessage\n\n${appInfo["description"]}\n\nDownload: ${appInfo["downloadLink"]}";
    
    if (selectedContacts.isNotEmpty) {
      ss("Shared with ${selectedContacts.length} contacts via $selectedPlatform");
    } else {
      ss("Shared via $selectedPlatform");
    }
    
    back();
  }

  void _copyLink() {
    ss("App download link copied to clipboard");
  }
}
