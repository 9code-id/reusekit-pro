import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState10View extends StatefulWidget {
  @override
  State<GrlEmptyState10View> createState() => _GrlEmptyState10ViewState();
}

class _GrlEmptyState10ViewState extends State<GrlEmptyState10View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
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
              warningColor.withAlpha(8),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              SizedBox(height: 50),
              
              // Error Illustration
              Container(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Broken gear background
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(15),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Main error icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: warningColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    // Warning triangle
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.warning,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Error Code
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "ERROR 500",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Title
              Text(
                "Something went wrong",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Description
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Text(
                  "We're sorry, but something unexpected happened. Our team has been notified and is working to fix this issue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Error Details
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
                          Icons.bug_report,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Error Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildErrorDetail("Error ID", "#ERR-2024-001"),
                    _buildErrorDetail("Time", "${DateTime.now().toString().substring(0, 16)}"),
                    _buildErrorDetail("Type", "Internal Server Error"),
                    _buildErrorDetail("Status", "Under Investigation"),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // What to do next
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
                          Icons.support_agent,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "What can you do?",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildSolutionStep(
                      "Refresh the page",
                      "Try reloading to see if the issue resolves",
                      Icons.refresh,
                      successColor,
                    ),
                    _buildSolutionStep(
                      "Wait a few minutes",
                      "The issue might be temporary",
                      Icons.schedule,
                      warningColor,
                    ),
                    _buildSolutionStep(
                      "Contact support",
                      "If the problem persists, reach out to us",
                      Icons.headset_mic,
                      infoColor,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Status Updates
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [infoColor, infoColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Stay Updated",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Follow our status page for real-time updates on system health and ongoing maintenance.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
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
                    // Retry the failed operation
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
                        back();
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Contact Support",
                      size: bs.md,
                      onPressed: () {
                        // navigateTo(SupportView());
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Report Issue",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(ReportIssueView());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDetail(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            ": ",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionStep(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
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
}
