import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory9View extends StatefulWidget {
  @override
  State<GrlCategory9View> createState() => _GrlCategory9ViewState();
}

class _GrlCategory9ViewState extends State<GrlCategory9View> {
  String selectedCategory = 'all';
  String searchQuery = '';
  bool showFavoritesOnly = false;
  
  List<Map<String, dynamic>> appCategories = [
    {
      "id": 1,
      "name": "Augmented Reality",
      "shortName": "AR",
      "description": "Immersive AR experiences and virtual object interaction",
      "icon": Icons.view_in_ar,
      "gradient": [0xFF6A1B9A, 0xFF9C27B0],
      "totalApps": 89,
      "newAppsThisMonth": 12,
      "rating": 4.3,
      "downloads": "2.1M",
      "trending": true,
      "emerging": true,
      "growth": "+45%",
      "userSatisfaction": 89,
      "developerInterest": 94,
      "marketPotential": "High",
      "investmentLevel": "\$24M",
      "keyFeatures": ["3D Objects", "Face Tracking", "World Tracking", "Image Recognition"],
      "topApps": ["Snapchat", "Instagram", "Pokemon GO", "IKEA Place"],
      "useCases": ["Social Media", "Gaming", "Shopping", "Education"],
      "targetAudience": "Gen Z, Millennials",
      "technicalRequirements": "High-end devices",
    },
    {
      "id": 2,
      "name": "Artificial Intelligence",
      "shortName": "AI/ML",
      "description": "AI-powered applications and machine learning tools",
      "icon": Icons.psychology,
      "gradient": [0xFF1976D2, 0xFF42A5F5],
      "totalApps": 156,
      "newAppsThisMonth": 23,
      "rating": 4.6,
      "downloads": "5.8M",
      "trending": true,
      "emerging": true,
      "growth": "+67%",
      "userSatisfaction": 92,
      "developerInterest": 98,
      "marketPotential": "Very High",
      "investmentLevel": "\$156M",
      "keyFeatures": ["Natural Language", "Computer Vision", "Predictive Analytics", "Automation"],
      "topApps": ["ChatGPT", "Grammarly", "Google Assistant", "Siri"],
      "useCases": ["Productivity", "Content Creation", "Analysis", "Personal Assistant"],
      "targetAudience": "Professionals, Students",
      "technicalRequirements": "Cloud connectivity",
    },
    {
      "id": 3,
      "name": "Blockchain & Web3",
      "shortName": "Web3",
      "description": "Decentralized applications and cryptocurrency tools",
      "icon": Icons.currency_bitcoin,
      "gradient": [0xFFFF5722, 0xFFFF8A65],
      "totalApps": 67,
      "newAppsThisMonth": 18,
      "rating": 4.1,
      "downloads": "1.3M",
      "trending": true,
      "emerging": true,
      "growth": "+89%",
      "userSatisfaction": 78,
      "developerInterest": 87,
      "marketPotential": "High",
      "investmentLevel": "\$89M",
      "keyFeatures": ["Smart Contracts", "NFT Support", "DeFi Integration", "Wallet Management"],
      "topApps": ["MetaMask", "Coinbase", "OpenSea", "Uniswap"],
      "useCases": ["Finance", "Art & Collectibles", "Gaming", "Investment"],
      "targetAudience": "Crypto enthusiasts, Investors",
      "technicalRequirements": "Wallet integration",
    },
    {
      "id": 4,
      "name": "Internet of Things",
      "shortName": "IoT",
      "description": "Smart device control and home automation systems",
      "icon": Icons.devices,
      "gradient": [0xFF388E3C, 0xFF66BB6A],
      "totalApps": 234,
      "newAppsThisMonth": 15,
      "rating": 4.4,
      "downloads": "8.2M",
      "trending": false,
      "emerging": true,
      "growth": "+32%",
      "userSatisfaction": 86,
      "developerInterest": 79,
      "marketPotential": "Very High",
      "investmentLevel": "\$67M",
      "keyFeatures": ["Device Control", "Automation", "Energy Management", "Security"],
      "topApps": ["SmartThings", "Philips Hue", "Nest", "Ring"],
      "useCases": ["Home Automation", "Security", "Energy", "Health Monitoring"],
      "targetAudience": "Homeowners, Tech enthusiasts",
      "technicalRequirements": "Smart devices",
    },
    {
      "id": 5,
      "name": "Voice Technology",
      "shortName": "Voice",
      "description": "Voice-controlled interfaces and audio processing",
      "icon": Icons.mic,
      "gradient": [0xFFE91E63, 0xFFF06292],
      "totalApps": 123,
      "newAppsThisMonth": 9,
      "rating": 4.5,
      "downloads": "4.7M",
      "trending": false,
      "emerging": false,
      "growth": "+28%",
      "userSatisfaction": 91,
      "developerInterest": 73,
      "marketPotential": "Medium",
      "investmentLevel": "\$43M",
      "keyFeatures": ["Speech Recognition", "Voice Synthesis", "Natural Language", "Audio Processing"],
      "topApps": ["Alexa", "Google Assistant", "Siri", "Dragon"],
      "useCases": ["Smart Assistants", "Accessibility", "Transcription", "Language Learning"],
      "targetAudience": "General public, Accessibility users",
      "technicalRequirements": "Microphone access",
    },
    {
      "id": 6,
      "name": "Extended Reality",
      "shortName": "XR/VR",
      "description": "Virtual and mixed reality immersive experiences",
      "icon": Icons.view_in_ar_outlined,
      "gradient": [0xFF795548, 0xFFA1887F],
      "totalApps": 45,
      "newAppsThisMonth": 8,
      "rating": 4.2,
      "downloads": "892K",
      "trending": true,
      "emerging": true,
      "growth": "+56%",
      "userSatisfaction": 84,
      "developerInterest": 91,
      "marketPotential": "High",
      "investmentLevel": "\$78M",
      "keyFeatures": ["Immersive Experience", "3D Environments", "Hand Tracking", "Spatial Audio"],
      "topApps": ["Oculus", "Beat Saber", "Half-Life Alyx", "VRChat"],
      "useCases": ["Gaming", "Training", "Social", "Entertainment"],
      "targetAudience": "Gamers, Early adopters",
      "technicalRequirements": "VR headset",
    },
  ];

  List<String> filters = ['all', 'trending', 'emerging', 'high-potential'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spMd, spMd, spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "Emerging Technologies",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showFavoritesOnly = !showFavoritesOnly;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Discover cutting-edge app categories shaping the future of mobile technology",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spMd),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search emerging technologies...",
                          value: searchQuery,
                          hint: "AR, AI, Blockchain, IoT...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.search,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Tabs
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: filters.map((filter) => Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedCategory = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: selectedCategory == filter ? successColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: selectedCategory == filter ? successColor : disabledBoldColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter.toUpperCase().replaceAll('-', ' '),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedCategory == filter ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Innovation Metrics
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [infoColor, infoColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.rocket_launch,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Innovation Metrics",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${appCategories.fold(0, (sum, cat) => sum + (cat["totalApps"] as int))}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Total Apps",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${appCategories.fold(0, (sum, cat) => sum + (cat["newAppsThisMonth"] as int))}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "New This Month",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${appCategories.where((cat) => cat["emerging"] as bool).length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Emerging",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Categories Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: _getFilteredCategories().map((category) => Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        children: [
                          // Header with Gradient
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color((category["gradient"] as List)[0]),
                                  Color((category["gradient"] as List)[1]),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Icon(
                                        category["icon"] as IconData,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${category["name"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${category["shortName"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        if (category["trending"] as bool)
                                          Container(
                                            margin: EdgeInsets.only(bottom: 4),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withAlpha(51),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "TRENDING",
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        if (category["emerging"] as bool)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withAlpha(51),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "EMERGING",
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "${category["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Content
                          Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              children: [
                                // Key Stats
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${category["totalApps"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: Color((category["gradient"] as List)[0]),
                                            ),
                                          ),
                                          Text(
                                            "Apps",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${category["growth"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                          Text(
                                            "Growth",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${category["marketPotential"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color((category["gradient"] as List)[0]),
                                            ),
                                          ),
                                          Text(
                                            "Potential",
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
                                
                                SizedBox(height: spMd),
                                
                                // Innovation Indicators
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: Color((category["gradient"] as List)[0]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${category["userSatisfaction"]}%",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color((category["gradient"] as List)[0]),
                                              ),
                                            ),
                                            Text(
                                              "User Satisfaction",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: Color((category["gradient"] as List)[1]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${category["developerInterest"]}%",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color((category["gradient"] as List)[1]),
                                              ),
                                            ),
                                            Text(
                                              "Dev Interest",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Key Features
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Key Features:",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Wrap(
                                        spacing: 4,
                                        runSpacing: 4,
                                        children: (category["keyFeatures"] as List).take(3).map((feature) => Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color((category["gradient"] as List)[0]).withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "$feature",
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                              color: Color((category["gradient"] as List)[0]),
                                            ),
                                          ),
                                        )).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Investment & Target Info
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Investment: ${category["investmentLevel"]}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  "Target: ${category["targetAudience"]}",
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
                                    ],
                                  ),
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Explore Button
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Explore Technology",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCategories() {
    List<Map<String, dynamic>> filtered = appCategories;
    
    if (selectedCategory == 'trending') {
      filtered = filtered.where((cat) => cat["trending"] as bool).toList();
    } else if (selectedCategory == 'emerging') {
      filtered = filtered.where((cat) => cat["emerging"] as bool).toList();
    } else if (selectedCategory == 'high-potential') {
      filtered = filtered.where((cat) => cat["marketPotential"] == "Very High" || cat["marketPotential"] == "High").toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((cat) {
        return cat["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               cat["shortName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               cat["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }
}
