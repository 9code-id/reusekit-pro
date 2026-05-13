import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAboutView extends StatefulWidget {
  const WcaAboutView({super.key});

  @override
  State<WcaAboutView> createState() => _WcaAboutViewState();
}

class _WcaAboutViewState extends State<WcaAboutView> {
  final String appVersion = "2.8.1";
  final String buildNumber = "1247";
  final String releaseDate = "March 15, 2024";
  final String developedBy = "WeatherTech Solutions";
  final String copyright = "© 2024 WeatherTech Solutions";

  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.location_on,
      "title": "Location-Based Weather",
      "description": "Accurate weather data for your current location and saved locations worldwide",
    },
    {
      "icon": Icons.schedule,
      "title": "Real-Time Updates",
      "description": "Live weather updates every 15 minutes from multiple reliable data sources",
    },
    {
      "icon": Icons.warning_amber,
      "title": "Weather Alerts",
      "description": "Severe weather warnings and customizable notifications for safety",
    },
    {
      "icon": Icons.radar,
      "title": "Weather Radar",
      "description": "Interactive weather radar maps with precipitation and storm tracking",
    },
    {
      "icon": Icons.timeline,
      "title": "Extended Forecasts",
      "description": "Detailed 14-day weather forecasts with hourly breakdowns",
    },
    {
      "icon": Icons.air,
      "title": "Air Quality Index",
      "description": "Real-time air quality monitoring and health recommendations",
    },
  ];

  final List<Map<String, dynamic>> credits = [
    {
      "title": "Weather Data",
      "provider": "OpenWeatherMap",
      "description": "Primary weather data provider",
      "website": "openweathermap.org",
    },
    {
      "title": "Backup Data",
      "provider": "AccuWeather",
      "description": "Secondary weather data source",
      "website": "accuweather.com",
    },
    {
      "title": "Satellite Imagery",
      "provider": "NASA Earth Observatory",
      "description": "Satellite weather imagery",
      "website": "earthobservatory.nasa.gov",
    },
    {
      "title": "Air Quality Data",
      "provider": "World Air Quality Index",
      "description": "Global air quality information",
      "website": "waqi.info",
    },
  ];

  final List<Map<String, dynamic>> team = [
    {
      "name": "Sarah Johnson",
      "role": "Lead Developer",
      "expertise": "Mobile App Development",
    },
    {
      "name": "Michael Chen",
      "role": "Weather Data Scientist",
      "expertise": "Meteorology & Data Analysis",
    },
    {
      "name": "Emily Rodriguez",
      "role": "UI/UX Designer",
      "expertise": "User Interface Design",
    },
    {
      "name": "David Park",
      "role": "Backend Engineer",
      "expertise": "Server & API Development",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Weather App"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Share app information");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo and Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.cloud,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Weather App",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your Personal Weather Companion",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Version $appVersion",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Build $buildNumber",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
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
                children: [
                  Text(
                    "About This App",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Weather App provides accurate, real-time weather information and forecasts for locations worldwide. Our app combines data from multiple reliable sources to deliver the most precise weather predictions and timely alerts to help you plan your day and stay safe.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Released: $releaseDate",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Key Features
            Text(
              "Key Features",
              style: TextStyle(
                fontSize: fsH6,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        feature["icon"],
                        size: 32,
                        color: primaryColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        feature["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        feature["description"],
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

            // Development Team
            Text(
              "Development Team",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: team.map((member) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: primaryColor,
                        child: Text(
                          member["name"].toString().split(' ').map((name) => name[0]).join(''),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member["name"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              member["role"],
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              member["expertise"],
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

            // Data Sources & Credits
            Text(
              "Data Sources & Credits",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: credits.map((credit) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.public,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              credit["provider"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              credit["description"],
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              credit["website"],
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
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

            // App Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "App Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Developed by:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        developedBy,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Release Date:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        releaseDate,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Copyright:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        copyright,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Support & Feedback",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Help us improve by sharing your feedback or rating the app",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Rate App",
                          size: bs.sm,
                          onPressed: () {
                            si("Redirecting to app store...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Send Feedback",
                          size: bs.sm,
                          onPressed: () {
                            si("Opening feedback form...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Legal Links
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Privacy Policy",
                    size: bs.sm,
                    onPressed: () {
                      si("Opening privacy policy...");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Terms of Service",
                    size: bs.sm,
                    onPressed: () {
                      si("Opening terms of service...");
                    },
                  ),
                ),
              ],
            ),

            // Copyright Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Center(
                child: Text(
                  "$copyright\nAll rights reserved.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
