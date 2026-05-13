import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation7View extends StatefulWidget {
  @override
  State<GrlConfirmation7View> createState() => _GrlConfirmation7ViewState();
}

class _GrlConfirmation7ViewState extends State<GrlConfirmation7View> {
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
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.logout,
                size: 65,
                color: infoColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Are you sure you want to sign out? You'll need to sign in again to access your account.",
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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "john.doe@example.com",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Premium Account",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Your data will remain safe and available when you sign back in",
                            style: TextStyle(
                              fontSize: 13,
                              color: warningColor,
                            ),
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
                    label: "Sign Out",
                    color: infoColor,
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
