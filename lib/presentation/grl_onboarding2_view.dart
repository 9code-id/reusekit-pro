import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding2View extends StatefulWidget {
  const GrlOnboarding2View({super.key});

  @override
  State<GrlOnboarding2View> createState() => _GrlOnboarding2ViewState();
}

class _GrlOnboarding2ViewState extends State<GrlOnboarding2View> {
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
                  "https://picsum.photos/400/300?random=2&keyword=features",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spXl),
            Text(
              "Powerful Features",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Access a comprehensive suite of tools and features that will revolutionize how you work and interact with technology.",
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
                  width: index == 1 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 1 ? primaryColor : disabledColor,
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
                      //navigateTo('onboarding1')
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Next",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('onboarding3')
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
