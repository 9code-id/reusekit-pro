import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoading2View extends StatefulWidget {
  @override
  State<GrlLoading2View> createState() => _GrlLoading2ViewState();
}

class _GrlLoading2ViewState extends State<GrlLoading2View>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  bool isLoading = true;
  String currentMessage = "Connecting to server...";
  int messageIndex = 0;

  List<String> loadingMessages = [
    "Connecting to server...",
    "Authenticating user...",
    "Loading user data...",
    "Synchronizing content...",
    "Almost ready...",
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    
    _startMessageCycle();
  }

  void _startMessageCycle() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      if (messageIndex < loadingMessages.length - 1) {
        messageIndex++;
        currentMessage = loadingMessages[messageIndex];
        setState(() {});
      } else {
        isLoading = false;
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading Animation
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.1),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radius4xl),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withAlpha(30),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Rotating Border
                        AnimatedBuilder(
                          animation: _rotationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationController.value * 2 * 3.14159,
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius4xl),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 3,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // Center Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radius3xl),
                          ),
                          child: Icon(
                            Icons.cloud_download,
                            size: 40,
                            color: Colors.white,
                          ),
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
              "DataSync Pro",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Enterprise Data Management",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Loading Message
            Container(
              height: 60,
              child: Column(
                children: [
                  if (isLoading) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          currentMessage,
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Ready to use!",
                          style: TextStyle(
                            fontSize: 18,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Progress Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                bool isActive = index <= messageIndex;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                );
              }),
            ),
            
            SizedBox(height: spXl),
            
            // Features Preview
            Container(
              margin: EdgeInsets.symmetric(horizontal: spLg),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "What's coming up:",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeature(
                          Icons.security,
                          "Secure\nBackup",
                        ),
                      ),
                      Expanded(
                        child: _buildFeature(
                          Icons.sync,
                          "Real-time\nSync",
                        ),
                      ),
                      Expanded(
                        child: _buildFeature(
                          Icons.analytics,
                          "Smart\nAnalytics",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Spacer(),
            
            // Bottom Text
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "Please wait while we prepare your workspace",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
