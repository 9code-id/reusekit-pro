import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError6View extends StatefulWidget {
  @override
  State<GrlError6View> createState() => _GrlError6ViewState();
}

class _GrlError6ViewState extends State<GrlError6View> {
  int timeoutSeconds = 30;
  bool isRetrying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && timeoutSeconds > 0) {
        timeoutSeconds--;
        setState(() {});
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Timeout"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spLg),
            
            // Timeout Animation
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius4xl),
                boxShadow: [shadowLg],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular Progress
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: (30 - timeoutSeconds) / 30,
                      strokeWidth: 6,
                      backgroundColor: dangerColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                    ),
                  ),
                  // Clock Icon
                  Icon(
                    Icons.access_time,
                    size: 32,
                    color: dangerColor,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Timeout Title
            Text(
              "Request Timeout",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Timeout Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: dangerColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The request took too long to complete and has timed out. This usually happens due to slow network connection or server overload.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Timeout after: 30 seconds",
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
            
            SizedBox(height: spMd),
            
            // Connection Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.network_check,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Connection Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildStatusRow("Network", "Connected", successColor, Icons.wifi),
                  _buildStatusRow("Server", "Overloaded", warningColor, Icons.dns),
                  _buildStatusRow("Response Time", "> 30s", dangerColor, Icons.speed),
                  
                  SizedBox(height: spMd),
                  
                  // Auto-retry countdown
                  if (timeoutSeconds > 0)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.autorenew,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Auto-retry in ${timeoutSeconds}s",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 16,
                            color: dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Auto-retry failed",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Troubleshooting Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: warningColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        size: 20,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Troubleshooting Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildTipItem("Check your internet connection speed", Icons.speed),
                  _buildTipItem("Try switching to a different network", Icons.wifi),
                  _buildTipItem("Close other apps using internet", Icons.apps),
                  _buildTipItem("Wait a few minutes and try again", Icons.schedule),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Action Buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isRetrying ? "Retrying..." : "Try Again Now",
                    size: bs.md,
                    onPressed: isRetrying ? () {} : () async {
                      isRetrying = true;
                      setState(() {});
                      
                      // Simulate retry
                      await Future.delayed(Duration(seconds: 3));
                      
                      isRetrying = false;
                      timeoutSeconds = 30;
                      setState(() {});
                      _startTimer();
                      
                      si("Request sent again");
                    },
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Go Back",
                        size: bs.md,
                        onPressed: () {
                          // back();
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: "Reload Page",
                        size: bs.md,
                        onPressed: () {
                          setState(() {});
                          ss("Page reloaded");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Performance Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 20,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Optimize Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "To prevent future timeouts, consider upgrading your internet plan or using WiFi instead of mobile data for better stability.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  GestureDetector(
                    onTap: () {
                      // navigateTo(PerformanceTipsView());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "View Performance Tips",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String status, Color color, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: warningColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
