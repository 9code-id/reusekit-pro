import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding4View extends StatefulWidget {
  const GrlOnboarding4View({super.key});

  @override
  State<GrlOnboarding4View> createState() => _GrlOnboarding4ViewState();
}

class _GrlOnboarding4ViewState extends State<GrlOnboarding4View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "https://picsum.photos/400/300?random=4&keyword=community",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spXl),
            Text(
              "Join Our Community",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Connect with like-minded individuals and share your experiences. Build meaningful relationships within our vibrant community.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  width: index == 3 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 3 ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                );
              }),
            ),
            SizedBox(height: spXl),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Back",
                    color: disabledColor,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('onboarding3')
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Next",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('onboarding5')
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}
