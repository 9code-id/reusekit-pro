import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess2View extends StatefulWidget {
  @override
  State<GrlSuccess2View> createState() => _GrlSuccess2ViewState();
}

class _GrlSuccess2ViewState extends State<GrlSuccess2View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Icon(
                Icons.thumb_up,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Well Done!",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Congratulations on completing this task successfully!",
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
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Your changes have been saved automatically",
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
            Container(
              width: double.infinity,
              child: QButton(
                label: "Finish",
                size: bs.md,
                onPressed: () {
                  back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
