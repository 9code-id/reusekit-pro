import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms1View extends StatefulWidget {
  @override
  State<GrlTerms1View> createState() => _GrlTerms1ViewState();
}

class _GrlTerms1ViewState extends State<GrlTerms1View> {
  bool acceptTerms = false;
  bool acceptPrivacy = false;
  bool acceptMarketing = false;

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
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Review Our Terms",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Please read and accept our terms to continue using the app",
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
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Terms of Service",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        "1. ACCEPTANCE OF TERMS\n\nBy accessing and using this mobile application, you accept and agree to be bound by the terms and provision of this agreement.\n\n2. USE LICENSE\n\nPermission is granted to temporarily download one copy of the materials on this application for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:\n• modify or copy the materials\n• use the materials for any commercial purpose or for any public display\n• attempt to reverse engineer any software contained in the application\n• remove any copyright or other proprietary notations from the materials\n\n3. DISCLAIMER\n\nThe materials on this application are provided on an 'as is' basis. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties including without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        onChanged: (value) {
                          acceptTerms = value ?? false;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: Text(
                          "I have read and agree to the Terms of Service",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        "INFORMATION WE COLLECT\n\nWe collect information you provide directly to us, such as when you create an account, make a purchase, or contact us for support.\n\nUSE OF INFORMATION\n\nWe use the information we collect to:\n• Provide, maintain, and improve our services\n• Process transactions and send related information\n• Send technical notices and support messages\n• Respond to your comments and questions\n• Monitor and analyze trends and usage\n\nSHARING OF INFORMATION\n\nWe do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this privacy policy.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: acceptPrivacy,
                        onChanged: (value) {
                          acceptPrivacy = value ?? false;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: Text(
                          "I have read and agree to the Privacy Policy",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Marketing Communications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Receive updates about new features, promotions, and other marketing communications.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: acceptMarketing,
                        onChanged: (value) {
                          acceptMarketing = value ?? false;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: Text(
                          "I agree to receive marketing communications (Optional)",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: acceptTerms && acceptPrivacy ? "Accept and Continue" : "Please Accept Required Terms",
                onPressed: acceptTerms && acceptPrivacy ? () {
                  ss("Terms accepted successfully");
                } : null,
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "View Full Terms",
                onPressed: () {
                  si("Opening full terms document");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
