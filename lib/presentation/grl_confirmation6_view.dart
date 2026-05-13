import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation6View extends StatefulWidget {
  @override
  State<GrlConfirmation6View> createState() => _GrlConfirmation6ViewState();
}

class _GrlConfirmation6ViewState extends State<GrlConfirmation6View> {
  bool agreeToTerms = false;
  bool agreeToPrivacy = false;
  bool agreeToMarketing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.description_outlined,
                size: 50,
                color: infoColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Review and Accept",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Please review and accept our terms to continue using our services.",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          agreeToTerms = !agreeToTerms;
                          setState(() {});
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: agreeToTerms ? successColor : Colors.transparent,
                            border: Border.all(
                              color: agreeToTerms ? successColor : disabledColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: agreeToTerms
                              ? Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Terms of Service",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Read full terms →",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          agreeToPrivacy = !agreeToPrivacy;
                          setState(() {});
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: agreeToPrivacy ? successColor : Colors.transparent,
                            border: Border.all(
                              color: agreeToPrivacy ? successColor : disabledColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: agreeToPrivacy
                              ? Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Read privacy policy →",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          agreeToMarketing = !agreeToMarketing;
                          setState(() {});
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: agreeToMarketing ? successColor : Colors.transparent,
                            border: Border.all(
                              color: agreeToMarketing ? successColor : disabledColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: agreeToMarketing
                              ? Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Marketing Communications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Optional - Receive offers and updates",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Accept and Continue",
                size: bs.md,
                onPressed: (agreeToTerms && agreeToPrivacy)
                    ? () {}
                    : null,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Decline",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
