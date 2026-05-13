import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPremiumFeaturesView extends StatefulWidget {
  const PpaPremiumFeaturesView({super.key});

  @override
  State<PpaPremiumFeaturesView> createState() => _PpaPremiumFeaturesViewState();
}

class _PpaPremiumFeaturesViewState extends State<PpaPremiumFeaturesView> {
  int selectedTab = 0;
  bool showComparison = false;

  List<Map<String, dynamic>> premiumFeatures = [
    {
      "category": "AI-Powered Tools",
      "icon": Icons.psychology,
      "color": Color(0xFF9C27B0),
      "features": [
        {
          "title": "Smart Composition",
          "description": "AI guides help you frame perfect shots with rule of thirds, leading lines, and symmetry detection.",
          "image": "https://picsum.photos/300/200?random=1&keyword=composition",
          "benefit": "Improve photo composition by 80%"
        },
        {
          "title": "Scene Recognition",
          "description": "Automatically detect and optimize settings for portraits, landscapes, macro, and other scene types.",
          "image": "https://picsum.photos/300/200?random=2&keyword=scene",
          "benefit": "Perfect settings every time"
        },
        {
          "title": "Object Removal",
          "description": "Remove unwanted objects from photos with AI-powered content-aware fill technology.",
          "image": "https://picsum.photos/300/200?random=3&keyword=editing",
          "benefit": "Save hours of manual editing"
        },
        {
          "title": "Auto Enhancement",
          "description": "Intelligent color correction, noise reduction, and sharpening based on photo analysis.",
          "image": "https://picsum.photos/300/200?random=4&keyword=enhancement",
          "benefit": "Professional results instantly"
        }
      ]
    },
    {
      "category": "Professional Editing",
      "icon": Icons.tune,
      "color": Color(0xFF2196F3),
      "features": [
        {
          "title": "RAW Processing",
          "description": "Full RAW file support with non-destructive editing and professional color grading tools.",
          "image": "https://picsum.photos/300/200?random=5&keyword=raw",
          "benefit": "Maximum image quality"
        },
        {
          "title": "Batch Processing",
          "description": "Apply edits to hundreds of photos simultaneously with customizable presets and actions.",
          "image": "https://picsum.photos/300/200?random=6&keyword=batch",
          "benefit": "10x faster workflow"
        },
        {
          "title": "Advanced Filters",
          "description": "Access to 200+ professional filters including film emulations, artistic effects, and vintage looks.",
          "image": "https://picsum.photos/300/200?random=7&keyword=filters",
          "benefit": "Unique creative styles"
        },
        {
          "title": "Precision Tools",
          "description": "Professional masking, gradients, radial filters, and selective adjustments for pixel-perfect edits.",
          "image": "https://picsum.photos/300/200?random=8&keyword=precision",
          "benefit": "Studio-quality control"
        }
      ]
    },
    {
      "category": "Cloud & Sync",
      "icon": Icons.cloud,
      "color": Color(0xFF4CAF50),
      "features": [
        {
          "title": "Unlimited Storage",
          "description": "Store unlimited photos and videos in high-quality cloud storage with instant access anywhere.",
          "image": "https://picsum.photos/300/200?random=9&keyword=cloud",
          "benefit": "Never run out of space"
        },
        {
          "title": "Multi-Device Sync",
          "description": "Seamlessly sync projects, edits, and photos across all your devices in real-time.",
          "image": "https://picsum.photos/300/200?random=10&keyword=sync",
          "benefit": "Work from anywhere"
        },
        {
          "title": "Backup & Recovery",
          "description": "Automatic backup with version history and one-click recovery for accidental deletions.",
          "image": "https://picsum.photos/300/200?random=11&keyword=backup",
          "benefit": "Never lose your work"
        },
        {
          "title": "Offline Access",
          "description": "Download photos for offline editing and sync changes when you're back online.",
          "image": "https://picsum.photos/300/200?random=12&keyword=offline",
          "benefit": "Edit anywhere, anytime"
        }
      ]
    },
    {
      "category": "Collaboration",
      "icon": Icons.people,
      "color": Color(0xFFFF9800),
      "features": [
        {
          "title": "Team Workspace",
          "description": "Collaborate with clients and team members with shared albums, comments, and approval workflows.",
          "image": "https://picsum.photos/300/200?random=13&keyword=team",
          "benefit": "Streamline client work"
        },
        {
          "title": "Portfolio Sharing",
          "description": "Create stunning online portfolios with customizable themes and client proofing galleries.",
          "image": "https://picsum.photos/300/200?random=14&keyword=portfolio",
          "benefit": "Showcase your best work"
        },
        {
          "title": "Live Collaboration",
          "description": "Real-time editing sessions with multiple users and instant feedback on shared projects.",
          "image": "https://picsum.photos/300/200?random=15&keyword=collaboration",
          "benefit": "Faster project completion"
        },
        {
          "title": "Client Delivery",
          "description": "Professional client galleries with download permissions, watermarking, and usage tracking.",
          "image": "https://picsum.photos/300/200?random=16&keyword=delivery",
          "benefit": "Professional client experience"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> planComparison = [
    {
      "feature": "Photo uploads per day",
      "free": "5 photos",
      "pro": "Unlimited"
    },
    {
      "feature": "Cloud storage",
      "free": "1GB",
      "pro": "Unlimited"
    },
    {
      "feature": "RAW file support",
      "free": "No",
      "pro": "Yes"
    },
    {
      "feature": "Batch processing",
      "free": "No",
      "pro": "Yes"
    },
    {
      "feature": "Professional filters",
      "free": "10 basic",
      "pro": "200+ premium"
    },
    {
      "feature": "AI-powered tools",
      "free": "Limited",
      "pro": "Full access"
    },
    {
      "feature": "Team collaboration",
      "free": "No",
      "pro": "Yes"
    },
    {
      "feature": "Priority support",
      "free": "No",
      "pro": "Yes"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium Features"),
        actions: [
          IconButton(
            icon: Icon(showComparison ? Icons.grid_view : Icons.compare),
            onPressed: () {
              showComparison = !showComparison;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Unlock Professional Photography",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Discover powerful tools and features that will transform your photography workflow",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          if (!showComparison) ...[
            // Category Tabs
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spMd),
                itemCount: premiumFeatures.length,
                itemBuilder: (context, index) {
                  final category = premiumFeatures[index];
                  final isSelected = selectedTab == index;

                  return GestureDetector(
                    onTap: () {
                      selectedTab = index;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm, top: spSm, bottom: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? (category["color"] as Color) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: isSelected ? (category["color"] as Color) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category["icon"] as IconData,
                            size: 20,
                            color: isSelected ? Colors.white : (category["color"] as Color),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${category["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : (category["color"] as Color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Features List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: (premiumFeatures[selectedTab]["features"] as List).length,
                itemBuilder: (context, index) {
                  final feature = (premiumFeatures[selectedTab]["features"] as List)[index];
                  final categoryColor = premiumFeatures[selectedTab]["color"] as Color;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Feature Image
                        Container(
                          height: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${feature["image"]}",
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 180,
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
                                  bottom: spSm,
                                  left: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: categoryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${feature["benefit"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Feature Content
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Text(
                                "${feature["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: categoryColor,
                                ),
                              ),
                              Text(
                                "${feature["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Try This Feature",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('PpaSubscriptionView')
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            // Plan Comparison
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Comparison Header
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Feature",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Free Plan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Pro Plan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Comparison Rows
                    Column(
                      spacing: spSm,
                      children: planComparison.map((comparison) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${comparison["feature"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${comparison["free"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: comparison["free"] == "No" ? disabledColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (comparison["pro"] == "Yes")
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: successColor,
                                      )
                                    else
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                    SizedBox(width: spXs),
                                    Flexible(
                                      child: Text(
                                        "${comparison["pro"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    // Pricing Card
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withAlpha(200)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Ready to Upgrade?",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Get access to all premium features and transform your photography workflow",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //navigateTo('PpaSubscriptionView')
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                    ),
                                    child: Text(
                                      "Start Free Trial",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
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
            ),
          ],
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "View Pricing",
                size: bs.md,
                onPressed: () {
                  //navigateTo('PpaSubscriptionView')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
