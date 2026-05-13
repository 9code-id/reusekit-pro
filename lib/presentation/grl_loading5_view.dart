import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlLoading5View extends StatefulWidget {
  @override
  State<GrlLoading5View> createState() => _GrlLoading5ViewState();
}

class _GrlLoading5ViewState extends State<GrlLoading5View>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotateController;
  bool isLoading = true;
  int currentStep = 0;
  String statusMessage = "Getting things ready...";

  List<Map<String, dynamic>> loadingSteps = [
    {
      "title": "Connecting",
      "icon": Icons.wifi,
      "color": Colors.blue,
      "message": "Establishing connection...",
    },
    {
      "title": "Verifying",
      "icon": Icons.verified_user,
      "color": Colors.green,
      "message": "Verifying credentials...",
    },
    {
      "title": "Loading",
      "icon": Icons.download,
      "color": Colors.orange,
      "message": "Loading your data...",
    },
    {
      "title": "Optimizing",
      "icon": Icons.tune,
      "color": Colors.purple,
      "message": "Optimizing performance...",
    },
    {
      "title": "Ready",
      "icon": Icons.check_circle,
      "color": Colors.green,
      "message": "All set! Welcome aboard!",
    },
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _rotateController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _bounceController.repeat(reverse: true);
    _rotateController.repeat();
    
    _startLoadingProcess();
  }

  void _startLoadingProcess() async {
    for (int i = 0; i < loadingSteps.length; i++) {
      if (!mounted) return;
      
      currentStep = i;
      statusMessage = loadingSteps[i]["message"];
      setState(() {});
      
      if (i == loadingSteps.length - 1) {
        await Future.delayed(Duration(milliseconds: 1500));
        isLoading = false;
        setState(() {});
      } else {
        await Future.delayed(Duration(milliseconds: 2000));
      }
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade50,
              Colors.teal.shade100,
              Colors.teal.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              
              // Main Loading Animation
              AnimatedBuilder(
                animation: _bounceController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -20 * _bounceController.value),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade300.withAlpha(100),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _rotateController,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotateController.value * 2 * 3.14159,
                                child: Icon(
                                  loadingSteps[currentStep]["icon"],
                                  size: 70,
                                  color: loadingSteps[currentStep]["color"],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              
              SizedBox(height: spXl),
              
              // App Title
              Text(
                "TaskFlow Pro",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Professional Task Management",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Current Status
              Container(
                padding: EdgeInsets.all(spLg),
                margin: EdgeInsets.symmetric(horizontal: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.shade200.withAlpha(100),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      loadingSteps[currentStep]["title"],
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: loadingSteps[currentStep]["color"],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      statusMessage,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: spMd),
                    if (isLoading)
                      LinearProgressIndicator(
                        backgroundColor: Colors.teal.shade100,
                        color: loadingSteps[currentStep]["color"],
                      ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Progress Steps
              Container(
                margin: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(loadingSteps.length, (index) {
                    bool isCompleted = index < currentStep;
                    bool isActive = index == currentStep;
                    bool isUpcoming = index > currentStep;
                    
                    return Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? Colors.green.shade500
                                : isActive 
                                    ? loadingSteps[index]["color"]
                                    : Colors.grey.shade300,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActive 
                                  ? loadingSteps[index]["color"]
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            isCompleted 
                                ? Icons.check
                                : loadingSteps[index]["icon"],
                            color: isUpcoming ? Colors.grey.shade600 : Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          loadingSteps[index]["title"],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive 
                                ? loadingSteps[index]["color"]
                                : isCompleted 
                                    ? Colors.green.shade600
                                    : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Features Preview
              Container(
                margin: EdgeInsets.symmetric(horizontal: spMd),
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Text(
                      "What awaits you:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFeatureCard(
                            Icons.task_alt,
                            "Smart Tasks",
                            "AI-powered task prioritization",
                            Colors.blue,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildFeatureCard(
                            Icons.people,
                            "Team Sync",
                            "Real-time collaboration",
                            Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFeatureCard(
                            Icons.analytics,
                            "Analytics",
                            "Detailed performance insights",
                            Colors.purple,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildFeatureCard(
                            Icons.schedule,
                            "Time Track",
                            "Automatic time tracking",
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Bottom Message
              if (!isLoading)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spLg,
                    vertical: spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade500, Colors.green.shade600],
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.celebration,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Welcome to TaskFlow Pro!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

  Widget _buildFeatureCard(IconData icon, String title, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
