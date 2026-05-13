import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation5View extends StatefulWidget {
  @override
  State<GrlConfirmation5View> createState() => _GrlConfirmation5ViewState();
}

class _GrlConfirmation5ViewState extends State<GrlConfirmation5View> {
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
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.delete_outline,
                size: 70,
                color: dangerColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Delete Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Are you sure you want to permanently delete your account? This action cannot be undone.",
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
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: dangerColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "What will be deleted:",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      "All your personal data and preferences",
                      "Order history and transaction records",
                      "Saved items and favorites",
                      "Account settings and configurations"
                    ].map((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: dangerColor,
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
            SizedBox(height: spXl),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Yes, Delete My Account",
                    color: dangerColor,
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
