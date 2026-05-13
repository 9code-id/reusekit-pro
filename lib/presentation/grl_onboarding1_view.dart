import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOnboarding1View extends StatefulWidget {
  const GrlOnboarding1View({super.key});

  @override
  State<GrlOnboarding1View> createState() => _GrlOnboarding1ViewState();
}

class _GrlOnboarding1ViewState extends State<GrlOnboarding1View> {
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
                  "https://picsum.photos/400/300?random=1&keyword=welcome",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spXl),
            Text(
              "Welcome to Our App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Discover amazing features and unlock your potential with our innovative platform designed to enhance your daily experience.",
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
                  width: index == 0 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 0 ? primaryColor : disabledColor,
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
                    label: "Skip",
                    color: disabledColor,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('login')
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Next",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('onboarding2')
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
