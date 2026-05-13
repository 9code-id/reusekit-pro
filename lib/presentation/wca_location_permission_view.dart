import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaLocationPermissionView extends StatefulWidget {
  const WcaLocationPermissionView({super.key});

  @override
  State<WcaLocationPermissionView> createState() => _WcaLocationPermissionViewState();
}

class _WcaLocationPermissionViewState extends State<WcaLocationPermissionView> {
  bool isLoading = false;

  Future<void> _requestLocationPermission() async {
    isLoading = true;
    setState(() {});

    // Simulate permission request
    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});

    // Navigate to home or location setup
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
              Color(0xFF81C784),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusXl),
                        ),
                        child: Icon(
                          Icons.my_location,
                          size: 80,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(height: spXl),
                      Text(
                        "Enable Location Access",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "To provide accurate weather information for your area, we need access to your location.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(220),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: spLg),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Precise weather for your exact location",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Automatic weather updates",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Severe weather alerts for your area",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
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
                Column(
                  children: [
                    if (isLoading)
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    else
                      QButton(
                        label: "Allow Location Access",
                        size: bs.md,
                        onPressed: _requestLocationPermission,
                      ),
                    SizedBox(height: spMd),
                    GestureDetector(
                      onTap: () {
                        // Navigate to manual location setup
                      },
                      child: Text(
                        "Enter Location Manually",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(200),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "You can change this setting anytime in app settings",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
