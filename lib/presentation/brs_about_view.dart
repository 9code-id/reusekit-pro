import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsAboutView extends StatefulWidget {
  const BrsAboutView({super.key});

  @override
  State<BrsAboutView> createState() => _BrsAboutViewState();
}

class _BrsAboutViewState extends State<BrsAboutView> {
  final List<Map<String, dynamic>> features = [
    {
      "title": "Easy Booking",
      "description": "Quick and simple appointment scheduling",
      "icon": Icons.calendar_today,
    },
    {
      "title": "Expert Barbers",
      "description": "Skilled professionals for all your grooming needs",
      "icon": Icons.person,
    },
    {
      "title": "Premium Services",
      "description": "High-quality haircuts, shaves, and styling",
      "icon": Icons.star,
    },
    {
      "title": "Flexible Payments",
      "description": "Multiple payment options for your convenience",
      "icon": Icons.payment,
    },
  ];

  final List<Map<String, dynamic>> teamMembers = [
    {
      "name": "John Smith",
      "role": "Founder & CEO",
      "image": "https://picsum.photos/120/120?random=1&keyword=man",
      "experience": "15 years",
    },
    {
      "name": "Mike Johnson",
      "role": "Lead Developer",
      "image": "https://picsum.photos/120/120?random=2&keyword=developer",
      "experience": "8 years",
    },
    {
      "name": "Sarah Wilson",
      "role": "UX Designer",
      "image": "https://picsum.photos/120/120?random=3&keyword=woman",
      "experience": "6 years",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // App Logo and Name
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.content_cut,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "BarberShop Pro",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Professional Barbershop Management",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // App Description
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "About Our App",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "BarberShop Pro is the ultimate solution for modern barbershop management. Our app streamlines appointment booking, customer management, and business operations to help barbershops deliver exceptional service while growing their business.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Features Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Key Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...features.map((feature) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              feature["icon"] as IconData,
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
                                  "${feature["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${feature["description"]}",
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
                    );
                  }).toList(),
                ],
              ),
            ),

            // Team Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Our Team",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...teamMembers.map((member) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${member["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${member["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${member["role"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${member["experience"]} experience",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Version Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "App Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Version",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "1.0.0",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Build",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "100",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Release Date",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "June 2025",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "support@barbershoppro.com",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "+1 (555) 123-4567",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "www.barbershoppro.com",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Rate Our App",
                    icon: Icons.star,
                    size: bs.md,
                    onPressed: () {
                      ss("Thank you for your feedback!");
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Share with Friends",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      ss("Share link copied to clipboard!");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
