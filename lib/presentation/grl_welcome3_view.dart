import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome3View extends StatefulWidget {
  @override
  State<GrlWelcome3View> createState() => _GrlWelcome3ViewState();
}

class _GrlWelcome3ViewState extends State<GrlWelcome3View> {
  int currentPage = 0;
  
  final List<Map<String, dynamic>> pages = [
    {
      "image": "https://picsum.photos/300/200?random=1&keyword=mobile",
      "title": "Discover Amazing Features",
      "subtitle": "Explore powerful tools designed to enhance your productivity",
      "gradient": [primaryColor, successColor],
    },
    {
      "image": "https://picsum.photos/300/200?random=2&keyword=security",
      "title": "Stay Safe & Secure",
      "subtitle": "Your privacy and security are our top priorities",
      "gradient": [infoColor, primaryColor],
    },
    {
      "image": "https://picsum.photos/300/200?random=3&keyword=community",
      "title": "Join the Community",
      "subtitle": "Connect with thousands of users worldwide",
      "gradient": [warningColor, dangerColor],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: pages[currentPage]["gradient"],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // navigateTo('');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      SizedBox(height: sp2xl),
                      
                      // Main Image
                      Container(
                        width: 280,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowXl],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${pages[currentPage]["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Title
                      Text(
                        "${pages[currentPage]["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Subtitle
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Text(
                          "${pages[currentPage]["subtitle"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(220),
                            height: 1.5,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pages.length, (index) {
                          return Container(
                            width: currentPage == index ? 24 : 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: spXs),
                            decoration: BoxDecoration(
                              color: currentPage == index 
                                  ? Colors.white 
                                  : Colors.white.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          );
                        }),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Feature Cards
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: Colors.white.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            if (currentPage == 0) ...[
                              _buildFeatureItem(
                                Icons.flash_on,
                                "Lightning Fast",
                                "Optimized for speed and performance",
                              ),
                              _buildFeatureItem(
                                Icons.offline_bolt,
                                "Works Offline",
                                "Access your content even without internet",
                              ),
                              _buildFeatureItem(
                                Icons.sync,
                                "Auto Sync",
                                "Seamlessly sync across all your devices",
                              ),
                            ] else if (currentPage == 1) ...[
                              _buildFeatureItem(
                                Icons.lock,
                                "End-to-End Encryption",
                                "Your data is encrypted and secure",
                              ),
                              _buildFeatureItem(
                                Icons.fingerprint,
                                "Biometric Login",
                                "Use fingerprint or face recognition",
                              ),
                              _buildFeatureItem(
                                Icons.shield,
                                "Privacy Protection",
                                "We never share your personal data",
                              ),
                            ] else ...[
                              _buildFeatureItem(
                                Icons.people,
                                "Active Community",
                                "Join millions of active users",
                              ),
                              _buildFeatureItem(
                                Icons.chat,
                                "Real-time Chat",
                                "Connect and communicate instantly",
                              ),
                              _buildFeatureItem(
                                Icons.share,
                                "Easy Sharing",
                                "Share content with friends effortlessly",
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                    ],
                  ),
                ),
              ),
              
              // Bottom Navigation
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    if (currentPage > 0)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: QButton(
                            label: "Previous",
                            size: bs.md,
                            onPressed: () {
                              if (currentPage > 0) {
                                currentPage--;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ),
                    if (currentPage > 0) SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QButton(
                          label: currentPage < pages.length - 1 ? "Next" : "Get Started",
                          size: bs.md,
                          onPressed: () {
                            if (currentPage < pages.length - 1) {
                              currentPage++;
                              setState(() {});
                            } else {
                              // navigateTo('');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
