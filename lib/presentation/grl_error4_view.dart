import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError4View extends StatefulWidget {
  @override
  State<GrlError4View> createState() => _GrlError4ViewState();
}

class _GrlError4ViewState extends State<GrlError4View> {
  bool isReporting = false;
  String selectedCategory = "Bug Report";
  String description = "";

  List<String> errorCategories = [
    "Bug Report",
    "Performance Issue",
    "Feature Request",
    "UI/UX Issue",
    "Data Loss",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Something Went Wrong"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Error Illustration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    warningColor.withAlpha(20),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 80,
                    color: warningColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Oops!",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Something unexpected happened",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Error Details
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
                    color: warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Error Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildDetailRow("Error Code", "APP_ERROR_500"),
                  _buildDetailRow("Timestamp", "${DateTime.now().toString().substring(0, 19)}"),
                  _buildDetailRow("Module", "UserDashboard"),
                  _buildDetailRow("Action", "LoadUserData"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Actions
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
                  Text(
                    "Quick Actions",
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
                        child: _buildActionCard(
                          "Refresh",
                          Icons.refresh,
                          successColor,
                          () {
                            setState(() {});
                            ss("Page refreshed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildActionCard(
                          "Go Back",
                          Icons.arrow_back,
                          infoColor,
                          () {
                            // back();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Report Issue Section
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
                        Icons.bug_report,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Report This Issue",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Help us improve by reporting this error",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Category Selector
                  QDropdownField(
                    label: "Issue Category",
                    items: errorCategories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Description
                  QMemoField(
                    label: "Describe the issue (optional)",
                    value: description,
                    hint: "What were you trying to do when this error occurred?",
                    onChanged: (value) {
                      description = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Report Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isReporting ? "Reporting..." : "Report Issue",
                      size: bs.md,
                      onPressed: isReporting ? () {} : () async {
                        isReporting = true;
                        setState(() {});
                        
                        // Simulate report submission
                        await Future.delayed(Duration(seconds: 2));
                        
                        isReporting = false;
                        setState(() {});
                        
                        ss("Issue reported successfully. Thank you!");
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Support Information
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
                        Icons.support_agent,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Immediate Help?",
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
                    "Our support team is available 24/7 to help you resolve any issues.",
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
                            // navigateTo(ContactSupportView());
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
                                  Icons.chat,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Live Chat",
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
                            // navigateTo(HelpCenterView());
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
                                  Icons.help_center,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Help Center",
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(30),
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
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
