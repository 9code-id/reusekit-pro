import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess1View extends StatefulWidget {
  @override
  State<GrlSuccess1View> createState() => _GrlSuccess1ViewState();
}

class _GrlSuccess1ViewState extends State<GrlSuccess1View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success"),
      ),
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.check_circle,
                size: 80,
                color: successColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Success!",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your action has been completed successfully. Everything is working as expected.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue",
                size: bs.md,
                onPressed: () {
                  back();
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Go to Home",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  // Navigate to home
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
