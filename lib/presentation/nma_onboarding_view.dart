import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaOnboardingView extends StatefulWidget {
  const NmaOnboardingView({Key? key}) : super(key: key);

  @override
  State<NmaOnboardingView> createState() => _NmaOnboardingViewState();
}

class _NmaOnboardingViewState extends State<NmaOnboardingView> {
  int currentPage = 0;
  PageController pageController = PageController();

  List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "Stay Updated",
      "subtitle": "Real-time News Coverage",
      "description": "Get breaking news and updates from trusted sources around the world, delivered instantly to your device.",
      "image": "https://picsum.photos/300/300?random=1&keyword=news",
      "icon": Icons.flash_on,
      "color": primaryColor,
    },
    {
      "title": "Personalized Feed",
      "subtitle": "News That Matters to You",
      "description": "AI-powered recommendations based on your interests, reading history, and preferences for a tailored experience.",
      "image": "https://picsum.photos/300/300?random=2&keyword=personalization",
      "icon": Icons.person,
      "color": secondaryColor,
    },
    {
      "title": "Multiple Sources",
      "subtitle": "Comprehensive Coverage",
      "description": "Access news from hundreds of reliable sources including international media, local papers, and specialized publications.",
      "image": "https://picsum.photos/300/300?random=3&keyword=sources",
      "icon": Icons.public,
      "color": infoColor,
    },
    {
      "title": "Offline Reading",
      "subtitle": "Read Anywhere, Anytime",
      "description": "Download articles for offline reading. Never miss important news even when you're not connected to the internet.",
      "image": "https://picsum.photos/300/300?random=4&keyword=offline",
      "icon": Icons.offline_pin,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              onboardingPages[currentPage]["color"].withAlpha(30),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildPageView(),
              ),
              _buildPageIndicator(),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.newspaper,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "NewsMax",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          // Skip Button
          if (currentPage < onboardingPages.length - 1)
            GestureDetector(
              onTap: _skipToEnd,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return QHorizontalScroll(
      children: onboardingPages.asMap().entries.map((entry) {
        final index = entry.key;
        final page = entry.value;
        
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: spXl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: spXl,
            children: [
              // Image/Illustration
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius3xl),
                  boxShadow: [shadowLg],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius3xl),
                  child: Stack(
                    children: [
                      Image.network(
                        "${page["image"]}",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              page["color"].withAlpha(150),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spLg,
                        right: spLg,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [shadowMd],
                          ),
                          child: Icon(
                            page["icon"] as IconData,
                            size: 30,
                            color: page["color"],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Content
              Column(
                spacing: spMd,
                children: [
                  Text(
                    "${page["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: page["color"],
                    ),
                  ),
                  Text(
                    "${page["subtitle"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "${page["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: onboardingPages.asMap().entries.map((entry) {
          final index = entry.key;
          final isActive = index == currentPage;
          
          return Container(
            width: isActive ? 24 : 8,
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isActive 
                ? onboardingPages[currentPage]["color"]
                : disabledColor.withAlpha(100),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          // Previous Button
          if (currentPage > 0)
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                child: QButton(
                  label: "Previous",
                  size: bs.md,
                  onPressed: _previousPage,
                ),
              ),
            )
          else
            Expanded(child: Container()),
          
          // Next/Get Started Button
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: spSm),
              child: QButton(
                label: currentPage == onboardingPages.length - 1 
                    ? "Get Started" 
                    : "Next",
                size: bs.md,
                onPressed: currentPage == onboardingPages.length - 1 
                    ? _completeOnboarding 
                    : _nextPage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      setState(() {
        currentPage++;
      });
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    setState(() {
      currentPage = onboardingPages.length - 1;
    });
    pageController.animateToPage(
      currentPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    ss("Welcome to NewsMax!");
    // ss('Next page'));
  }
}
