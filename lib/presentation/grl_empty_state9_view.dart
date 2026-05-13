import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState9View extends StatefulWidget {
  @override
  State<GrlEmptyState9View> createState() => _GrlEmptyState9ViewState();
}

class _GrlEmptyState9ViewState extends State<GrlEmptyState9View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connection"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              dangerColor.withAlpha(5),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              SizedBox(height: 60),
              
              // No Connection Illustration
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circles
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // WiFi icon with X
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Disconnected indicator
                    Positioned(
                      top: 30,
                      right: 30,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Title
              Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Description
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Text(
                  "Please check your internet connection and try again. Make sure you're connected to WiFi or mobile data.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Connection Status
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.signal_wifi_statusbar_null,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Connection Status",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Offline",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "DISCONNECTED",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Troubleshooting Steps
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.build,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Troubleshooting Steps",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildTroubleshootStep(
                      "Check WiFi connection",
                      "Make sure you're connected to a WiFi network",
                      Icons.wifi,
                    ),
                    _buildTroubleshootStep(
                      "Toggle airplane mode",
                      "Turn airplane mode on/off to reset connection",
                      Icons.airplanemode_active,
                    ),
                    _buildTroubleshootStep(
                      "Restart your device",
                      "Power off and on your device",
                      Icons.refresh,
                    ),
                    _buildTroubleshootStep(
                      "Check mobile data",
                      "Ensure mobile data is enabled if no WiFi",
                      Icons.signal_cellular_4_bar,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Network Types
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connection Types",
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
                          child: _buildConnectionTypeCard(
                            "WiFi",
                            Icons.wifi,
                            infoColor,
                            "Fast & Stable",
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildConnectionTypeCard(
                            "4G/5G",
                            Icons.signal_cellular_4_bar,
                            successColor,
                            "Mobile Data",
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildConnectionTypeCard(
                            "Ethernet",
                            Icons.cable,
                            warningColor,
                            "Wired",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Try Again",
                  size: bs.md,
                  onPressed: () {
                    // Retry connection
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Check Settings",
                      size: bs.md,
                      onPressed: () {
                        // Open network settings
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Offline Mode",
                      size: bs.md,
                      onPressed: () {
                        // Switch to offline mode
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTroubleshootStep(String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              size: 20,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
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
  }

  Widget _buildConnectionTypeCard(String title, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(60),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
