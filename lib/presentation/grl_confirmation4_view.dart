import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation4View extends StatefulWidget {
  @override
  State<GrlConfirmation4View> createState() => _GrlConfirmation4ViewState();
}

class _GrlConfirmation4ViewState extends State<GrlConfirmation4View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.error_outline,
                size: 60,
                color: warningColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Action Required",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your account requires verification to continue using this feature. This will only take a few minutes.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spXl),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: warningColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You'll receive a verification code via SMS or email",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Verify Account",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Remind Me Later",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Skip for now",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
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
