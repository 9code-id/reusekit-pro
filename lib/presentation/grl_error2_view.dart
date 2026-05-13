import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError2View extends StatefulWidget {
  @override
  State<GrlError2View> createState() => _GrlError2ViewState();
}

class _GrlError2ViewState extends State<GrlError2View> {
  bool isRetrying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade50,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Animation Container
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusXl),
                boxShadow: [shadowLg],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: 64,
                    color: dangerColor,
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radius2xl),
                    ),
                    child: Container(
                      width: 20,
                      height: 4,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radius2xl),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Error Title
            Text(
              "Connection Failed",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Error Description
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Unable to connect to the server. Please check your internet connection and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Connection Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_wifi_off,
                        size: 20,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "No Internet Connection",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Retry Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isRetrying ? "Retrying..." : "Try Again",
                size: bs.md,
                onPressed: isRetrying ? () {} : () async {
                  isRetrying = true;
                  setState(() {});
                  
                  // Simulate retry delay
                  await Future.delayed(Duration(seconds: 2));
                  
                  isRetrying = false;
                  setState(() {});
                  
                  ss("Connection restored!");
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Troubleshooting Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Troubleshooting Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Check your WiFi or mobile data connection\n• Move to an area with better signal\n• Restart your internet connection",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Help Link
            GestureDetector(
              onTap: () {
                // navigateTo(HelpView());
              },
              child: Text(
                "Still having issues? Get Help",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
