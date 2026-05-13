import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaOnboardingView extends StatefulWidget {
  const MhaOnboardingView({super.key});

  @override
  State<MhaOnboardingView> createState() => _MhaOnboardingViewState();
}

class _MhaOnboardingViewState extends State<MhaOnboardingView> {
  int currentPage = 0;
  
  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Find Healthcare Providers",
      "description": "Connect with qualified doctors, specialists, and healthcare professionals in your area",
      "image": "https://picsum.photos/300/300?random=1&keyword=doctor",
      "icon": Icons.local_hospital,
    },
    {
      "title": "Book Appointments Easily",
      "description": "Schedule appointments, manage your calendar, and receive appointment reminders",
      "image": "https://picsum.photos/300/300?random=2&keyword=calendar",
      "icon": Icons.calendar_today,
    },
    {
      "title": "Track Your Health",
      "description": "Monitor vital signs, medications, and maintain comprehensive health records",
      "image": "https://picsum.photos/300/300?random=3&keyword=health",
      "icon": Icons.favorite,
    },
    {
      "title": "Access Medical Records",
      "description": "Store and access your medical history, prescriptions, and lab results securely",
      "image": "https://picsum.photos/300/300?random=4&keyword=medical",
      "icon": Icons.folder_shared,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spXl),
            
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome to HealthCare",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(MainDashboard)
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return Container(
                  width: currentPage == index ? 24 : 8,
                  height: 8,
                  margin: EdgeInsets.only(right: spXs),
                  decoration: BoxDecoration(
                    color: currentPage == index ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                );
              }),
            ),
            
            SizedBox(height: spLg),
            
            // Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXl),
                    ),
                    child: Icon(
                      onboardingData[currentPage]["icon"],
                      size: 48,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spXl),
                  
                  // Image
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusXl),
                      boxShadow: [shadowMd],
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
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Description
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spLg),
                    child: Text(
                      "${onboardingData[currentPage]["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentPage > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      color: disabledColor,
                      onPressed: () {
                        currentPage--;
                        setState(() {});
                      },
                    ),
                  ),
                
                if (currentPage > 0)
                  SizedBox(width: spSm),
                
                Expanded(
                  child: QButton(
                    label: currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                        // navigateTo(LoginView)
                      } else {
                        currentPage++;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
