import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation9View extends StatefulWidget {
  @override
  State<GrlConfirmation9View> createState() => _GrlConfirmation9ViewState();
}

class _GrlConfirmation9ViewState extends State<GrlConfirmation9View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.refresh,
                size: 65,
                color: warningColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Reset All Settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "This will restore all settings to their default values. Your data will remain safe.",
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Settings that will be reset:",
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      "Theme and appearance preferences",
                      "Notification settings",
                      "Privacy and security options",
                      "Language and region settings",
                      "App behavior preferences"
                    ].map((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Your personal data, files, and account information will not be affected",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
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
                    label: "Reset Settings",
                    color: warningColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Cancel",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
