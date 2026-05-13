import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoading1View extends StatefulWidget {
  @override
  State<GrlLoading1View> createState() => _GrlLoading1ViewState();
}

class _GrlLoading1ViewState extends State<GrlLoading1View>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat();
    
    // Simulate loading completion
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            colors: [primaryColor, primaryColor.withAlpha(180)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius3xl),
                boxShadow: [shadowXl],
              ),
              child: Icon(
                Icons.rocket_launch,
                size: 60,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // App Name
            Text(
              "ReuseKit",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Building amazing apps together",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Loading Indicator
            if (isLoading) ...[
              Container(
                width: 200,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 200 * _controller.value,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Loading your experience...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ] else ...[
              // Success State
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spLg,
                  vertical: spMd,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Ready to go!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spXl),
            
            // Loading Steps
            Column(
              children: [
                _buildLoadingStep("Initializing components", 0, isLoading),
                _buildLoadingStep("Loading user preferences", 1, isLoading),
                _buildLoadingStep("Setting up workspace", 2, isLoading),
                _buildLoadingStep("Finalizing setup", 3, isLoading),
              ],
            ),
            
            Spacer(),
            
            // Footer
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingStep(String title, int index, bool loading) {
    bool isCompleted = !loading || index < 2;
    bool isActive = loading && index == 2;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isCompleted 
                  ? Colors.white 
                  : isActive 
                      ? Colors.white54 
                      : Colors.white24,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: isCompleted
                ? Icon(
                    Icons.check,
                    size: 12,
                    color: primaryColor,
                  )
                : null,
          ),
          SizedBox(width: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isCompleted || isActive 
                  ? Colors.white 
                  : Colors.white54,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
