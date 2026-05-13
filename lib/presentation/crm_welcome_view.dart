import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmWelcomeView extends StatefulWidget {
  const CrmWelcomeView({super.key});

  @override
  State<CrmWelcomeView> createState() => _CrmWelcomeViewState();
}

class _CrmWelcomeViewState extends State<CrmWelcomeView> {
  List<Map<String, dynamic>> features = [
    {
      "icon": Icons.people,
      "title": "Customer Management",
      "description": "Organize and track all your customer interactions in one place",
      "color": primaryColor,
    },
    {
      "icon": Icons.analytics,
      "title": "Sales Analytics",
      "description": "Get detailed insights into your sales performance and trends",
      "color": successColor,
    },
    {
      "icon": Icons.task_alt,
      "title": "Lead Tracking",
      "description": "Monitor leads from first contact to successful conversion",
      "color": warningColor,
    },
    {
      "icon": Icons.email,
      "title": "Email Integration",
      "description": "Sync your emails and communicate directly from the platform",
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> testimonials = [
    {
      "name": "Sarah Johnson",
      "position": "Sales Manager",
      "company": "TechCorp",
      "comment": "This CRM has transformed how we manage our customer relationships. Sales are up 40% since we started using it.",
      "rating": 5,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=business",
    },
    {
      "name": "Mike Chen",
      "position": "Business Owner",
      "company": "Growth Solutions",
      "comment": "The analytics dashboard gives us insights we never had before. It's like having a crystal ball for our business.",
      "rating": 5,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=business",
    },
    {
      "name": "Emma Wilson",
      "position": "Marketing Director",
      "company": "Digital Plus",
      "comment": "Lead tracking has never been easier. We can see exactly where our customers are in the pipeline.",
      "rating": 5,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=business",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  spacing: spLg,
                  children: [
                    // Logo and Title
                    Column(
                      spacing: spMd,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spLg),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.business_center,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "CRM Pro",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Streamline Your Customer Relationships",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                      ],
                    ),

                    // Key Stats
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "10K+",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Happy Users",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
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
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "99.9%",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Uptime",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
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
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "24/7",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Support",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // CTA Buttons
                    Column(
                      spacing: spSm,
                      children: [
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(vertical: spMd),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                            ),
                            child: Text(
                              "Get Started Free",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.white, width: 2),
                              padding: EdgeInsets.symmetric(vertical: spMd),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Features Section
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                spacing: spLg,
                children: [
                  Text(
                    "Why Choose CRM Pro?",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 280,
                    children: features.map((feature) {
                      return Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: (feature["color"] as Color).withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                feature["icon"] as IconData,
                                size: 32,
                                color: feature["color"] as Color,
                              ),
                            ),
                            Text(
                              "${feature["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${feature["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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

            // Testimonials Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor,
              ),
              child: Column(
                spacing: spLg,
                children: [
                  Text(
                    "What Our Customers Say",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    spacing: spMd,
                    children: testimonials.map((testimonial) {
                      return Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < (testimonial["rating"] as int) 
                                      ? warningColor 
                                      : disabledColor,
                                  size: 20,
                                );
                              }),
                            ),
                            Text(
                              "\"${testimonial["comment"]}\"",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage("${testimonial["avatar"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${testimonial["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "${testimonial["position"]} at ${testimonial["company"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Pricing Section
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                spacing: spLg,
                children: [
                  Text(
                    "Simple, Transparent Pricing",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spLg),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            spacing: spMd,
                            children: [
                              Text(
                                "Starter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$19",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "/month",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Perfect for small teams",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Start Free Trial",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spLg),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spMd,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "POPULAR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Professional",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$49",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "/month",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Best for growing businesses",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: primaryColor,
                                    padding: EdgeInsets.symmetric(vertical: spSm),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(radiusMd),
                                    ),
                                  ),
                                  child: Text(
                                    "Start Free Trial",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Final CTA
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Ready to Transform Your Business?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Join thousands of businesses already using CRM Pro to boost their sales and improve customer relationships.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Get Started Today",
                      size: bs.md,
                      onPressed: () {},
                    ),
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
