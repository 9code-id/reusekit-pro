import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsWelcomeView extends StatefulWidget {
  const DmsWelcomeView({super.key});

  @override
  State<DmsWelcomeView> createState() => _DmsWelcomeViewState();
}

class _DmsWelcomeViewState extends State<DmsWelcomeView> {
  List<Map<String, dynamic>> features = [
    {
      "title": "Centralized Dealership Management",
      "description": "Manage all your dealership operations from a single, powerful platform designed for automotive professionals.",
      "icon": Icons.business,
      "color": primaryColor,
    },
    {
      "title": "Inventory Management",
      "description": "Track vehicles, parts, and accessories with real-time inventory updates and automated reorder alerts.",
      "icon": Icons.inventory,
      "color": successColor,
    },
    {
      "title": "Customer Relationship Management",
      "description": "Build lasting customer relationships with comprehensive CRM tools and automated follow-up systems.",
      "icon": Icons.people,
      "color": infoColor,
    },
    {
      "title": "Sales & Finance Tracking",
      "description": "Monitor sales performance, track financing options, and generate detailed financial reports.",
      "icon": Icons.analytics,
      "color": warningColor,
    },
    {
      "title": "Service Department Integration",
      "description": "Seamlessly connect sales and service operations for enhanced customer experience and retention.",
      "icon": Icons.build,
      "color": dangerColor,
    },
    {
      "title": "Digital Documentation",
      "description": "Go paperless with digital contracts, automated document generation, and secure cloud storage.",
      "icon": Icons.description,
      "color": secondaryColor,
    },
  ];

  List<Map<String, dynamic>> benefits = [
    {
      "metric": "40%",
      "description": "Increase in sales efficiency",
      "icon": Icons.trending_up,
    },
    {
      "metric": "60%",
      "description": "Reduction in paperwork",
      "icon": Icons.content_paste,
    },
    {
      "metric": "25%",
      "description": "Improvement in customer satisfaction",
      "icon": Icons.star,
    },
    {
      "metric": "50%",
      "description": "Faster inventory turnover",
      "icon": Icons.speed,
    },
  ];

  List<Map<String, dynamic>> testimonials = [
    {
      "name": "Mike Johnson",
      "position": "General Manager",
      "company": "Premier Auto Group",
      "quote": "This system transformed our dealership operations. We've seen significant improvements in efficiency and customer satisfaction.",
      "rating": 5,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=manager",
    },
    {
      "name": "Sarah Williams",
      "position": "Sales Director",
      "company": "Metro Motors",
      "quote": "The CRM features are outstanding. We can now track every customer interaction and never miss a follow-up opportunity.",
      "rating": 5,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=woman",
    },
    {
      "name": "David Chen",
      "position": "Service Manager",
      "company": "Elite Auto Center",
      "quote": "Integration between sales and service is seamless. Our customers love the unified experience we can now provide.",
      "rating": 5,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=service",
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
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: spXl),
                  Icon(
                    Icons.directions_car,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "DealershipFlow",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Complete Dealership Management System",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: Colors.white.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Streamline Your Automotive Business",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "From inventory management to customer relationships, handle everything with our comprehensive dealership management platform.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Get Started",
                            size: bs.md,
                            onPressed: () {
                              //navigateTo DmsLoginView
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Learn More",
                            size: bs.md,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Features Section
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  SizedBox(height: spLg),
                  Text(
                    "Powerful Features for Modern Dealerships",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Everything you need to run a successful automotive dealership",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: features.map((feature) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (feature["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusLg),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
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

            // Benefits Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Proven Results",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Join thousands of dealerships already achieving success",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: benefits.map((benefit) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              benefit["icon"] as IconData,
                              size: 32,
                              color: successColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${benefit["metric"]}",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${benefit["description"]}",
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
                ],
              ),
            ),

            // Testimonials Section
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Text(
                    "What Our Customers Say",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Real feedback from dealership professionals",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Column(
                    spacing: spMd,
                    children: testimonials.map((testimonial) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: index < (testimonial["rating"] as int) ? warningColor : disabledColor,
                                );
                              }),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "\"${testimonial["quote"]}\"",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: primaryColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage("${testimonial["avatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${testimonial["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${testimonial["position"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${testimonial["company"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
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

            // CTA Section
            Container(
              padding: EdgeInsets.all(spMd),
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
              child: Column(
                children: [
                  Icon(
                    Icons.rocket_launch,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Ready to Transform Your Dealership?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Join the digital revolution in automotive retail. Start your free trial today and experience the difference.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(230),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Start Free Trial",
                            size: bs.md,
                            onPressed: () {
                              //navigateTo DmsRegisterView
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Sign In",
                            size: bs.md,
                            onPressed: () {
                              //navigateTo DmsLoginView
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "No credit card required",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.support, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "24/7 support included",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_car, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "DealershipFlow",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Empowering automotive professionals with cutting-edge technology",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "© 2024 DealershipFlow. All rights reserved.",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
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
