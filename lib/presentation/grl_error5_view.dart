import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError5View extends StatefulWidget {
  @override
  State<GrlError5View> createState() => _GrlError5ViewState();
}

class _GrlError5ViewState extends State<GrlError5View> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withAlpha(10),
              Colors.white,
              primaryColor.withAlpha(10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              
              // Maintenance Icon
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius4xl),
                  boxShadow: [shadowLg],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.construction,
                      size: 64,
                      color: warningColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "503",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Maintenance Title
              Text(
                "Under Maintenance",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Maintenance Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "We're currently performing scheduled maintenance to improve your experience. The service will be back online shortly.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Estimated time: 2 hours",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Progress Indicator
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
                          Icons.timeline,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Maintenance Progress",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Progress Steps
                    _buildProgressStep("Database optimization", true, true),
                    _buildProgressStep("Server updates", true, false),
                    _buildProgressStep("Performance improvements", false, false),
                    _buildProgressStep("Final testing", false, false),
                    
                    SizedBox(height: spMd),
                    
                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Overall Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "65%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radius3xl),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.65,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radius3xl),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // What's New Section
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
                          Icons.new_releases,
                          size: 20,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "What's Coming",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    _buildFeatureItem("Improved loading speeds", Icons.speed),
                    _buildFeatureItem("Enhanced security features", Icons.security),
                    _buildFeatureItem("New dashboard design", Icons.dashboard),
                    _buildFeatureItem("Bug fixes and optimizations", Icons.bug_report),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Status Updates
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
                          Icons.notifications_active,
                          size: 20,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Stay Updated",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Follow our status page for real-time updates on the maintenance progress and estimated completion time.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(StatusPageView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.web,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Status Page",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {});
                              si("Page refreshed");
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: infoColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    size: 16,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Refresh",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Auto-refresh notice
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.autorenew,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "This page will auto-refresh when maintenance is complete",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
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

  Widget _buildProgressStep(String title, bool isCompleted, bool isActive) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isCompleted ? successColor : isActive ? warningColor : disabledColor,
              borderRadius: BorderRadius.circular(radius4xl),
            ),
            child: Icon(
              isCompleted ? Icons.check : isActive ? Icons.more_horiz : Icons.circle,
              size: 12,
              color: Colors.white,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isCompleted ? successColor : isActive ? warningColor : disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: successColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
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
