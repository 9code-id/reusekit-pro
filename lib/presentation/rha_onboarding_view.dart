import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaOnboardingView extends StatefulWidget {
  const RhaOnboardingView({super.key});

  @override
  State<RhaOnboardingView> createState() => _RhaOnboardingViewState();
}

class _RhaOnboardingViewState extends State<RhaOnboardingView> {
  int currentPage = 0;
  bool loading = false;

  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Comprehensive Patient Care",
      "subtitle": "Manage patient records, treatment plans, and medical history",
      "description": "Streamline your healthcare workflow with our comprehensive patient management system. Access medical records, track treatment progress, and coordinate care plans all in one place.",
      "image": "https://picsum.photos/300/300?random=1&keyword=medical",
      "icon": Icons.medical_services,
      "color": primaryColor,
    },
    {
      "title": "Rehabilitation Tracking",
      "subtitle": "Monitor progress and customize therapy programs",
      "description": "Track patient rehabilitation progress with detailed analytics, customize therapy programs, and monitor recovery milestones to ensure optimal patient outcomes.",
      "image": "https://picsum.photos/300/300?random=2&keyword=rehabilitation",
      "icon": Icons.fitness_center,
      "color": successColor,
    },
    {
      "title": "Secure & Compliant",
      "subtitle": "HIPAA compliant with advanced security features",
      "description": "Your patient data is protected with enterprise-grade security. Our platform is fully HIPAA compliant, ensuring privacy and security for all medical information.",
      "image": "https://picsum.photos/300/300?random=3&keyword=security",
      "icon": Icons.security,
      "color": infoColor,
    },
    {
      "title": "Team Collaboration",
      "subtitle": "Coordinate care with your healthcare team",
      "description": "Collaborate seamlessly with doctors, nurses, therapists, and specialists. Share patient information securely and coordinate treatment plans across your entire care team.",
      "image": "https://picsum.photos/300/300?random=4&keyword=teamwork",
      "icon": Icons.group,
      "color": warningColor,
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
              onboardingData[currentPage]["color"].withAlpha(20),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildPageContent(),
              ),
              _buildBottomNavigation(),
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
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.medical_services,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "RehabAssist",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          if (currentPage < onboardingData.length - 1)
            GestureDetector(
              onTap: () => _skipOnboarding(),
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
    );
  }

  Widget _buildPageContent() {
    final data = onboardingData[currentPage];
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spLg),
      child: Column(
        children: [
          SizedBox(height: spLg),
          _buildFeatureIcon(data),
          SizedBox(height: spLg),
          _buildImage(data),
          SizedBox(height: spLg),
          _buildContent(data),
          SizedBox(height: spXl),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(Map<String, dynamic> data) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: (data["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: (data["color"] as Color).withAlpha(50),
          width: 2,
        ),
      ),
      child: Icon(
        data["icon"] as IconData,
        size: 40,
        color: data["color"] as Color,
      ),
    );
  }

  Widget _buildImage(Map<String, dynamic> data) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowLg],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusLg),
        child: Image.network(
          "${data["image"]}",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(Map<String, dynamic> data) {
    return Column(
      children: [
        Text(
          "${data["title"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            height: 1.2,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "${data["subtitle"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: data["color"] as Color,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "${data["description"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        children: [
          _buildPageIndicator(),
          SizedBox(height: spLg),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index 
                ? onboardingData[currentPage]["color"] as Color
                : disabledColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (currentPage > 0) ...[
          Expanded(
            child: QButton(
              label: "Previous",
              icon: Icons.arrow_back,
              size: bs.md,
              onPressed: () => _previousPage(),
            ),
          ),
          SizedBox(width: spSm),
        ],
        Expanded(
          flex: currentPage > 0 ? 1 : 2,
          child: QButton(
            label: currentPage == onboardingData.length - 1 
                ? "Get Started" 
                : "Next",
            icon: currentPage == onboardingData.length - 1 
                ? Icons.rocket_launch 
                : Icons.arrow_forward,
            size: bs.md,
            onPressed: loading ? null : () => _nextPage(),
          ),
        ),
      ],
    );
  }

  void _nextPage() async {
    if (currentPage == onboardingData.length - 1) {
      // Complete onboarding
      loading = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 1));
      
      loading = false;
      setState(() {});
      
      // ss('Next page'));
      ss("Welcome to RehabAssist!");
    } else {
      // Go to next page
      setState(() {
        currentPage++;
      });
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void _skipOnboarding() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(milliseconds: 500));
    
    loading = false;
    setState(() {});
    
    // ss('Next page'));
    si("Onboarding skipped");
  }
}
