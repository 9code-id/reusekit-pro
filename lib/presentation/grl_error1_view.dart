import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError1View extends StatefulWidget {
  @override
  State<GrlError1View> createState() => _GrlError1ViewState();
}

class _GrlError1ViewState extends State<GrlError1View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: dangerColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Error Code
            Text(
              "404",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Error Title
            Text(
              "Page Not Found",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Error Description
            Text(
              "The page you are looking for doesn't exist or has been moved. Please check the URL and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action Buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Go Back Home",
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
                    label: "Refresh Page",
                    size: bs.md,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Help Text
            GestureDetector(
              onTap: () {
                // navigateTo(ContactSupportView());
              },
              child: Text(
                "Need help? Contact Support",
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
