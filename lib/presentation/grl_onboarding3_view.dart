import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding3View extends StatefulWidget {
  const GrlOnboarding3View({super.key});

  @override
  State<GrlOnboarding3View> createState() => _GrlOnboarding3ViewState();
}

class _GrlOnboarding3ViewState extends State<GrlOnboarding3View> {
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
                  "https://picsum.photos/400/300?random=3&keyword=secure",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spXl),
            Text(
              "Secure & Private",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Your data is protected with enterprise-grade security measures. We prioritize your privacy and keep your information safe at all times.",
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
                  width: index == 2 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 2 ? primaryColor : disabledColor,
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
                      //navigateTo('onboarding2')
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Next",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('onboarding4')
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
