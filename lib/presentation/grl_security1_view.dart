import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity1View extends StatefulWidget {
  @override
  State<GrlSecurity1View> createState() => _GrlSecurity1ViewState();
}

class _GrlSecurity1ViewState extends State<GrlSecurity1View> {
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.lock_outline,
                size: 40,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Update Your Password",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Create a strong password to keep your account secure.",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spXl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Current Password",
                  value: currentPassword,
                  obscureText: obscureCurrentPassword,
                  onChanged: (value) {
                    currentPassword = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spXs),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      obscureCurrentPassword = !obscureCurrentPassword;
                      setState(() {});
                    },
                    child: Text(
                      obscureCurrentPassword ? "Show" : "Hide",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "New Password",
                  value: newPassword,
                  obscureText: obscureNewPassword,
                  onChanged: (value) {
                    newPassword = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spXs),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      obscureNewPassword = !obscureNewPassword;
                      setState(() {});
                    },
                    child: Text(
                      obscureNewPassword ? "Show" : "Hide",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QTextField(
                  label: "Confirm New Password",
                  value: confirmPassword,
                  obscureText: obscureConfirmPassword,
                  onChanged: (value) {
                    confirmPassword = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spXs),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      obscureConfirmPassword = !obscureConfirmPassword;
                      setState(() {});
                    },
                    child: Text(
                      obscureConfirmPassword ? "Show" : "Hide",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Password Requirements",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      "At least 8 characters long",
                      "Include uppercase and lowercase letters",
                      "Include at least one number",
                      "Include at least one special character"
                    ].map((requirement) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: infoColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                requirement,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: infoColor,
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
            Container(
              width: double.infinity,
              child: QButton(
                label: "Update Password",
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
