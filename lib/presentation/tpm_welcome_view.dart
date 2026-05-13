import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmWelcomeView extends StatefulWidget {
  const TpmWelcomeView({super.key});

  @override
  State<TpmWelcomeView> createState() => _TpmWelcomeViewState();
}

class _TpmWelcomeViewState extends State<TpmWelcomeView> {
  int currentSlide = 0;

  List<Map<String, dynamic>> slides = [
    {
      "image": "https://picsum.photos/300/300?random=1&keyword=teamwork",
      "title": "Collaborate Seamlessly",
      "subtitle": "Work together on projects with real-time collaboration tools",
      "description": "Share ideas, assign tasks, and track progress with your team members in one unified platform.",
    },
    {
      "image": "https://picsum.photos/300/300?random=2&keyword=productivity",
      "title": "Boost Productivity",
      "subtitle": "Streamline your workflow with powerful project management",
      "description": "Organize tasks, set deadlines, and monitor progress to ensure your projects are completed on time.",
    },
    {
      "image": "https://picsum.photos/300/300?random=3&keyword=analytics",
      "title": "Track Performance",
      "subtitle": "Get insights into your team's performance and project metrics",
      "description": "Make data-driven decisions with comprehensive analytics and reporting features.",
    },
  ];

  List<Map<String, dynamic>> features = [
    {
      "icon": Icons.group,
      "title": "Team Management",
      "description": "Organize and manage your team members efficiently",
      "color": primaryColor,
    },
    {
      "icon": Icons.task,
      "title": "Task Tracking",
      "description": "Keep track of all tasks and their progress",
      "color": successColor,
    },
    {
      "icon": Icons.timeline,
      "title": "Timeline View",
      "description": "Visualize project timelines and milestones",
      "color": infoColor,
    },
    {
      "icon": Icons.analytics,
      "title": "Analytics",
      "description": "Get detailed insights and performance metrics",
      "color": warningColor,
    },
  ];

  void _nextSlide() {
    if (currentSlide < slides.length - 1) {
      currentSlide++;
      setState(() {});
    }
  }

  void _previousSlide() {
    if (currentSlide > 0) {
      currentSlide--;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: spLg),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        Icons.work,
                        size: 64,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "TeamPro Manager",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Your Ultimate Project Management Solution",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Slides Section
            Container(
              height: 500,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(spMd),
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${slides[currentSlide]["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: spLg),
                          Text(
                            "${slides[currentSlide]["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${slides[currentSlide]["subtitle"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${slides[currentSlide]["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Slide Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(slides.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: currentSlide == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentSlide == index ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: spMd),
                  
                  // Navigation Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Row(
                      children: [
                        if (currentSlide > 0) ...[
                          QButton(
                            icon: Icons.arrow_back,
                            size: bs.sm,
                            onPressed: _previousSlide,
                          ),
                        ] else ...[
                          SizedBox(width: 40),
                        ],
                        Spacer(),
                        if (currentSlide < slides.length - 1) ...[
                          QButton(
                            icon: Icons.arrow_forward,
                            size: bs.sm,
                            onPressed: _nextSlide,
                          ),
                        ] else ...[
                          SizedBox(width: 40),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Features Section
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Key Features",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: features.map((feature) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (feature["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                feature["icon"] as IconData,
                                size: 32,
                                color: feature["color"] as Color,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${feature["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${feature["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Statistics Section
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(50),
                    successColor.withAlpha(50),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Trusted by Teams Worldwide",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "10K+",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Active Teams",
                              style: TextStyle(
                                fontSize: 14,
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
                              "500K+",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Projects Completed",
                              style: TextStyle(
                                fontSize: 14,
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
                              "98%",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Satisfaction Rate",
                              style: TextStyle(
                                fontSize: 14,
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

            // Action Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Get Started",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to register
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Sign In",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to login
                      },
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By continuing, you agree to our ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "and ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
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
    );
  }
}
