import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding10View extends StatefulWidget {
  const GrlOnboarding10View({super.key});

  @override
  State<GrlOnboarding10View> createState() => _GrlOnboarding10ViewState();
}

class _GrlOnboarding10ViewState extends State<GrlOnboarding10View> {
  bool showConfetti = false;

  final List<Map<String, dynamic>> completedSteps = [
    {
      "icon": Icons.person_add,
      "title": "Account Created",
      "description": "Your account has been successfully created",
    },
    {
      "icon": Icons.verified_user,
      "title": "Email Verified",
      "description": "Your email address has been confirmed",
    },
    {
      "icon": Icons.settings,
      "title": "Profile Setup",
      "description": "Your profile information has been saved",
    },
    {
      "icon": Icons.tune,
      "title": "Preferences Set",
      "description": "Your app preferences have been configured",
    },
  ];

  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.dashboard,
      "title": "Dashboard",
      "description": "Access your personalized dashboard",
      "color": primaryColor,
    },
    {
      "icon": Icons.analytics,
      "title": "Analytics",
      "description": "Track your progress and insights",
      "color": successColor,
    },
    {
      "icon": Icons.notifications,
      "title": "Notifications",
      "description": "Stay updated with smart alerts",
      "color": infoColor,
    },
    {
      "icon": Icons.support_agent,
      "title": "Support",
      "description": "Get help when you need it",
      "color": warningColor,
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      showConfetti = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(10),
              Colors.white,
              successColor.withAlpha(5),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              SizedBox(height: spXl),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXl),
                  boxShadow: [shadowLg],
                ),
                child: Icon(
                  Icons.check,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spXl),
              Text(
                "🎉 Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Welcome to Our Platform",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Your account setup is complete! You're now ready to explore all the amazing features we have to offer.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.6,
                ),
              ),
              SizedBox(height: sp2xl),
              Container(
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
                      "Setup Complete ✅",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Column(
                      children: completedSteps.map((step) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  step["icon"] as IconData,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${step["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${step["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sp2xl),
              Text(
                "What's Next?",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: features.map((feature) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (feature["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            feature["icon"] as IconData,
                            color: feature["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${feature["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${feature["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: sp2xl),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Start Exploring",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo('dashboard')
                  },
                ),
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Take a Tour",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    //navigateTo('tour')
                  },
                ),
              ),
              SizedBox(height: spXl),
            ],
          ),
        ),
      ),
    );
  }
}
