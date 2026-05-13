import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding5View extends StatefulWidget {
  const GrlOnboarding5View({super.key});

  @override
  State<GrlOnboarding5View> createState() => _GrlOnboarding5ViewState();
}

class _GrlOnboarding5ViewState extends State<GrlOnboarding5View> {
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
                  "https://picsum.photos/400/300?random=5&keyword=start",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spXl),
            Text(
              "Ready to Get Started?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "You're all set! Let's begin your journey with us and explore everything our platform has to offer. Welcome aboard!",
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
                  width: index == 4 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 4 ? primaryColor : disabledColor,
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
                      //navigateTo('onboarding4')
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Get Started",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('login')
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
