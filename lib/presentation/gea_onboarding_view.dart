import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaOnboardingView extends StatefulWidget {
  const GeaOnboardingView({super.key});

  @override
  State<GeaOnboardingView> createState() => _GeaOnboardingViewState();
}

class _GeaOnboardingViewState extends State<GeaOnboardingView> {
  int currentPage = 0;

  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Discover Amazing Games",
      "subtitle": "Explore thousands of games across all genres",
      "description": "From action-packed adventures to relaxing puzzles, find your perfect game in our extensive library.",
      "image": "https://picsum.photos/300/400?random=1&keyword=gaming",
      "color": Colors.blue,
    },
    {
      "title": "Connect with Gamers",
      "subtitle": "Join a community of passionate players",
      "description": "Share achievements, discuss strategies, and make friends with fellow gamers from around the world.",
      "image": "https://picsum.photos/300/400?random=2&keyword=community",
      "color": Colors.purple,
    },
    {
      "title": "Track Your Progress",
      "subtitle": "Monitor your gaming achievements",
      "description": "Keep track of your game progress, unlock achievements, and climb the leaderboards.",
      "image": "https://picsum.photos/300/400?random=3&keyword=achievement",
      "color": Colors.green,
    },
    {
      "title": "Premium Gaming Experience",
      "subtitle": "Enjoy ad-free gaming with exclusive content",
      "description": "Upgrade to premium for unlimited access, exclusive games, and enhanced features.",
      "image": "https://picsum.photos/300/400?random=4&keyword=premium",
      "color": Colors.orange,
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
            colors: [
              onboardingData[currentPage]["color"].withAlpha(230),
              onboardingData[currentPage]["color"].withAlpha(180),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "GameZone",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //navigateTo('GeaLoginView')
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      children: [
                        // Image
                        Container(
                          height: 300,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: spLg),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXl),
                            boxShadow: [shadowLg],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXl),
                            child: Image.network(
                              "${onboardingData[currentPage]["image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(height: spXl),

                        // Title
                        Text(
                          "${onboardingData[currentPage]["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        SizedBox(height: spSm),

                        // Subtitle
                        Text(
                          "${onboardingData[currentPage]["subtitle"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: onboardingData[currentPage]["color"],
                          ),
                        ),

                        SizedBox(height: spMd),

                        // Description
                        Text(
                          "${onboardingData[currentPage]["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: spXl),

                        // Page Indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(onboardingData.length, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: spXs),
                              width: currentPage == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: currentPage == index 
                                    ? onboardingData[currentPage]["color"]
                                    : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: spXl),

                        // Features for current page
                        if (currentPage == 0) _buildGameFeatures(),
                        if (currentPage == 1) _buildCommunityFeatures(),
                        if (currentPage == 2) _buildProgressFeatures(),
                        if (currentPage == 3) _buildPremiumFeatures(),
                      ],
                    ),
                  ),
                ),
              ),

              // Navigation Buttons
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    if (currentPage > 0)
                      Expanded(
                        child: QButton(
                          label: "Previous",
                          size: bs.md,
                          onPressed: () {
                            currentPage--;
                            setState(() {});
                          },
                        ),
                      ),
                    if (currentPage > 0) SizedBox(width: spSm),
                    Expanded(
                      flex: currentPage == 0 ? 1 : 2,
                      child: QButton(
                        label: currentPage == onboardingData.length - 1 
                            ? "Get Started"
                            : "Next",
                        size: bs.md,
                        onPressed: () {
                          if (currentPage == onboardingData.length - 1) {
                            //navigateTo('GeaLoginView')
                          } else {
                            currentPage++;
                            setState(() {});
                          }
                        },
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

  Widget _buildGameFeatures() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.sports_esports, "10K+ Games", "All genres available")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.new_releases, "New Releases", "Weekly updates")),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.search, "Smart Search", "Find games easily")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.favorite, "Wishlist", "Save favorites")),
          ],
        ),
      ],
    );
  }

  Widget _buildCommunityFeatures() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.chat, "Live Chat", "Real-time messaging")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.group, "Gaming Groups", "Join communities")),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.share, "Share Moments", "Post achievements")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.event, "Events", "Join tournaments")),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressFeatures() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.emoji_events, "Achievements", "Unlock rewards")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.leaderboard, "Leaderboards", "Compete globally")),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.analytics, "Statistics", "Track progress")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.history, "Game History", "View past games")),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumFeatures() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.block, "Ad-Free", "No interruptions")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.star, "Exclusive Games", "Premium content")),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.cloud_download, "Offline Play", "Download games")),
            SizedBox(width: spSm),
            Expanded(child: _buildFeatureCard(Icons.priority_high, "Priority Support", "24/7 help")),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: onboardingData[currentPage]["color"],
            size: 32,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
