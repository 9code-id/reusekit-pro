import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation10View extends StatefulWidget {
  @override
  State<GrlConfirmation10View> createState() => _GrlConfirmation10ViewState();
}

class _GrlConfirmation10ViewState extends State<GrlConfirmation10View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                size: 70,
                color: infoColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Backup Data",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Would you like to backup your data to the cloud? This will help you restore your information on other devices.",
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
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.backup,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "What will be backed up:",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      "App settings and preferences",
                      "User profile and personal data",
                      "Saved items and favorites",
                      "Transaction history",
                      "Custom configurations"
                    ].map((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: infoColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: infoColor,
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
                    Icons.security,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Secure & Encrypted",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Your data will be encrypted and stored securely",
                          style: TextStyle(
                            fontSize: 13,
                            color: successColor,
                          ),
                        ),
                      ],
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
                    label: "Backup Now",
                    color: infoColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Backup Later",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Skip backup",
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
