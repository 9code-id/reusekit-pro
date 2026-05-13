import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError3View extends StatefulWidget {
  @override
  State<GrlError3View> createState() => _GrlError3ViewState();
}

class _GrlError3ViewState extends State<GrlError3View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Access Denied"),
        backgroundColor: dangerColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spXl),
            
            // Lock Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radius4xl),
              ),
              child: Icon(
                Icons.lock_outline,
                size: 48,
                color: dangerColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Error Code
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spSm,
              ),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                "403 - FORBIDDEN",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Error Title
            Text(
              "Access Denied",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Error Description
            Text(
              "You don't have permission to access this resource. Please contact your administrator if you believe this is an error.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Permission Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
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
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: dangerColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Access Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildInfoRow("Status", "Access Denied", dangerColor),
                  _buildInfoRow("Required Role", "Administrator", warningColor),
                  _buildInfoRow("Your Role", "User", disabledBoldColor),
                  _buildInfoRow("Resource", "/admin/dashboard", primaryColor),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Possible Solutions
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
                        Icons.help_outline,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "What can you do?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildSolutionItem("Contact your system administrator", Icons.person),
                  _buildSolutionItem("Request access permissions", Icons.key),
                  _buildSolutionItem("Check if you're logged in correctly", Icons.login),
                  _buildSolutionItem("Try accessing a different resource", Icons.explore),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action Buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Go Back",
                    size: bs.md,
                    onPressed: () {
                      // back();
                    },
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Request Access",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(RequestAccessView());
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Contact Support
            GestureDetector(
              onTap: () {
                // navigateTo(ContactSupportView());
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Contact Support",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionItem(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: infoColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
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
