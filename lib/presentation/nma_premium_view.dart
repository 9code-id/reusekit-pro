import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPremiumView extends StatefulWidget {
  const NmaPremiumView({Key? key}) : super(key: key);

  @override
  State<NmaPremiumView> createState() => _NmaPremiumViewState();
}

class _NmaPremiumViewState extends State<NmaPremiumView> {
  bool isPremiumUser = false;
  String currentPlan = "Free";
  String nextBillingDate = "2025-07-16";
  double monthlySpent = 9.99;
  
  List<Map<String, dynamic>> premiumFeatures = [
    {
      "title": "Ad-Free Experience",
      "description": "Read news without any interruptions from advertisements",
      "icon": Icons.block,
      "available": true,
      "category": "Experience"
    },
    {
      "title": "Offline Reading",
      "description": "Download articles and read them without internet connection",
      "icon": Icons.offline_pin,
      "available": true,
      "category": "Convenience"
    },
    {
      "title": "Unlimited Articles",
      "description": "Access unlimited articles from all news sources",
      "icon": Icons.all_inclusive,
      "available": true,
      "category": "Content"
    },
    {
      "title": "Breaking News Alerts",
      "description": "Get instant notifications for breaking news stories",
      "icon": Icons.notifications_active,
      "available": true,
      "category": "Alerts"
    },
    {
      "title": "Premium Sources",
      "description": "Access exclusive content from premium news sources",
      "icon": Icons.workspace_premium,
      "available": true,
      "category": "Content"
    },
    {
      "title": "AI News Summaries",
      "description": "Get AI-powered summaries of long articles",
      "icon": Icons.auto_awesome,
      "available": true,
      "category": "AI"
    },
    {
      "title": "Dark Mode",
      "description": "Comfortable reading experience in low light",
      "icon": Icons.dark_mode,
      "available": true,
      "category": "Experience"
    },
    {
      "title": "Custom Categories",
      "description": "Create and customize your own news categories",
      "icon": Icons.category,
      "available": true,
      "category": "Personalization"
    },
  ];

  List<Map<String, dynamic>> usageStats = [
    {
      "label": "Articles Read",
      "value": "247",
      "description": "This month",
      "icon": Icons.article,
      "color": primaryColor
    },
    {
      "label": "Time Saved",
      "value": "12.5h",
      "description": "With AI summaries",
      "icon": Icons.timer,
      "color": successColor
    },
    {
      "label": "Offline Downloads",
      "value": "89",
      "description": "Articles saved",
      "icon": Icons.download,
      "color": infoColor
    },
    {
      "label": "Alerts Received",
      "value": "43",
      "description": "Breaking news",
      "icon": Icons.notifications,
      "color": warningColor
    },
  ];

  List<Map<String, dynamic>> exclusiveContent = [
    {
      "title": "Market Analysis: Tech Giants Performance",
      "author": "Sarah Johnson, Senior Analyst",
      "readTime": "8 min read",
      "category": "Premium Analysis",
      "image": "https://picsum.photos/300/200?random=1&keyword=market"
    },
    {
      "title": "Behind the Scenes: Climate Summit Negotiations",
      "author": "Michael Chen, Investigative Reporter",
      "readTime": "12 min read",
      "category": "Exclusive Interview",
      "image": "https://picsum.photos/300/200?random=2&keyword=climate"
    },
    {
      "title": "AI Revolution: What Industry Leaders Think",
      "author": "Emma Rodriguez, Tech Correspondent",
      "readTime": "6 min read",
      "category": "Expert Opinion",
      "image": "https://picsum.photos/300/200?random=3&keyword=ai"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              // ss('Next page'));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPremiumStatus(),
            if (isPremiumUser) ...[
              _buildUsageStats(),
              _buildPremiumFeatures(),
              _buildExclusiveContent(),
              _buildAccountManagement(),
            ] else ...[
              _buildUpgradePromo(),
              _buildFeatureComparison(),
              _buildTestimonials(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumStatus() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPremiumUser
              ? [primaryColor, primaryColor.withAlpha(200)]
              : [disabledColor.withAlpha(100), disabledColor.withAlpha(50)],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  isPremiumUser ? Icons.workspace_premium : Icons.star_outline,
                  size: 30,
                  color: isPremiumUser ? primaryColor : disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      isPremiumUser ? "Premium Active" : "Free Plan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isPremiumUser 
                          ? "Enjoying all premium features"
                          : "Upgrade to unlock premium features",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (isPremiumUser) ...[
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Current Plan",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Text(
                          currentPlan,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Next Billing",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Text(
                          nextBillingDate,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Upgrade to Premium",
                size: bs.md,
                onPressed: () {
                  // ss('Next page'));
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsageStats() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Your Premium Stats",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            minItemWidth: 150,
            children: usageStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (stat["color"] as Color).withAlpha(50),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      size: 30,
                      color: stat["color"],
                    ),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: stat["color"],
                      ),
                    ),
                    Text(
                      "${stat["label"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${stat["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildPremiumFeatures() {
    Map<String, List<Map<String, dynamic>>> categorizedFeatures = {};
    for (var feature in premiumFeatures) {
      String category = feature["category"];
      if (!categorizedFeatures.containsKey(category)) {
        categorizedFeatures[category] = [];
      }
      categorizedFeatures[category]!.add(feature);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Premium Features",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...categorizedFeatures.entries.map((entry) {
            String category = entry.key;
            List<Map<String, dynamic>> features = entry.value;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                ...features.map((feature) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            feature["icon"] as IconData,
                            color: successColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${feature["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${feature["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                }),
                if (entry != categorizedFeatures.entries.last)
                  SizedBox(height: spSm),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildExclusiveContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Exclusive Content",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "PREMIUM",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...exclusiveContent.asMap().entries.map((entry) {
            final index = entry.key;
            final content = entry.value;
            final isLast = index == exclusiveContent.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${content["image"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${content["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "${content["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${content["author"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${content["readTime"]}",
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
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAccountManagement() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Account Management",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.payment,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Billing & Payment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Manage payment methods and billing history",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: disabledBoldColor,
                  size: 16,
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.download,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Download Invoices",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Download your subscription invoices",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: disabledBoldColor,
                  size: 16,
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Cancel Subscription",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Cancel your premium subscription",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: disabledBoldColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradePromo() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withAlpha(200),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Icon(
            Icons.workspace_premium,
            size: 60,
            color: Colors.white,
          ),
          
          Text(
            "Unlock Premium News",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          Text(
            "Get unlimited access, ad-free reading, offline downloads, and exclusive content for just \$9.99/month",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(220),
              height: 1.4,
            ),
          ),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Free Trial",
              size: bs.md,
              onPressed: () {
                // ss('Next page'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureComparison() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Free vs Premium",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Feature",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  child: Text(
                    "Free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    "Premium",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          _buildComparisonRow("Articles per day", "5", "Unlimited"),
          _buildComparisonRow("Ad-free reading", false, true),
          _buildComparisonRow("Offline downloads", false, true),
          _buildComparisonRow("Breaking news alerts", false, true),
          _buildComparisonRow("Premium sources", false, true),
          _buildComparisonRow("AI summaries", false, true),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String feature, dynamic freeValue, dynamic premiumValue) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Container(
            width: 60,
            child: _buildValueWidget(freeValue, false),
          ),
          Container(
            width: 80,
            child: _buildValueWidget(premiumValue, true),
          ),
        ],
      ),
    );
  }

  Widget _buildValueWidget(dynamic value, bool isPremium) {
    if (value is bool) {
      return Icon(
        value ? Icons.check : Icons.close,
        color: value ? (isPremium ? primaryColor : successColor) : dangerColor,
        size: 20,
      );
    } else {
      return Text(
        "$value",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: isPremium ? primaryColor : disabledBoldColor,
          fontWeight: isPremium ? FontWeight.w600 : FontWeight.normal,
        ),
      );
    }
  }

  Widget _buildTestimonials() {
    List<Map<String, dynamic>> testimonials = [
      {
        "text": "The ad-free experience and offline reading are game-changers!",
        "author": "Sarah M.",
        "rating": 5
      },
      {
        "text": "Premium content quality is exceptional. Worth every penny.",
        "author": "Michael R.",
        "rating": 5
      },
      {
        "text": "AI summaries save me so much time. Highly recommended!",
        "author": "Jennifer L.",
        "rating": 5
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "What Premium Users Say",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...testimonials.map((testimonial) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 16,
                        color: index < testimonial["rating"] 
                            ? warningColor 
                            : disabledColor,
                      );
                    }),
                  ),
                  Text(
                    "${testimonial["text"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    "- ${testimonial["author"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
