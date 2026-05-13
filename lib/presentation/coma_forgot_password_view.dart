import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaForgotPasswordView extends StatefulWidget {
  const ComaForgotPasswordView({super.key});

  @override
  State<ComaForgotPasswordView> createState() => _ComaForgotPasswordViewState();
}

class _ComaForgotPasswordViewState extends State<ComaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String selectedMethod = "email";
  bool loading = false;
  bool emailSent = false;

  List<Map<String, dynamic>> recoveryMethods = [
    {"label": "Email Recovery", "value": "email"},
    {"label": "SMS Recovery", "value": "sms"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Recovery"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spXl),

                    // Header
                    if (!emailSent) ...[
                      Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock_reset,
                            size: 64,
                            color: primaryColor,
                          ),
                          Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: fsH1,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Enter your email address and we'll send you instructions to reset your password.",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Recovery Method Selection
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recovery Method",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            QDropdownField(
                              label: "Select Recovery Method",
                              items: recoveryMethods,
                              value: selectedMethod,
                              onChanged: (value, label) {
                                selectedMethod = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: selectedMethod == "email" ? "Email Address" : "Phone Number",
                              value: email,
                              validator: selectedMethod == "email" ? Validator.email : Validator.required,
                              hint: selectedMethod == "email" 
                                  ? "Enter your registered email address"
                                  : "Enter your registered phone number",
                              onChanged: (value) {
                                email = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      // Security Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: infoColor.withAlpha(50)),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: infoColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Security Information",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "For security reasons, password reset links expire after 1 hour. If you don't receive the email, check your spam folder or try again.",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Send Reset Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: selectedMethod == "email" ? "Send Reset Email" : "Send Reset SMS",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              emailSent = true;
                              setState(() {});
                              
                              ss("Reset instructions sent successfully");
                            }
                          },
                        ),
                      ),
                    ],

                    // Success State
                    if (emailSent) ...[
                      Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mark_email_read,
                            size: 80,
                            color: successColor,
                          ),
                          Text(
                            "Check Your ${selectedMethod == 'email' ? 'Email' : 'Phone'}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            selectedMethod == "email"
                                ? "We've sent password reset instructions to $email"
                                : "We've sent a verification code to $email",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Next Steps
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next Steps",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.looks_one,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    selectedMethod == "email"
                                        ? "Check your email inbox and spam folder"
                                        : "Check your phone for the verification code",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.looks_two,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    selectedMethod == "email"
                                        ? "Click the reset link in the email"
                                        : "Enter the code to verify your identity",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.looks_3,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Create your new password",
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

                      // Action Buttons
                      Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Resend Instructions",
                              size: bs.md,
                              onPressed: () async {
                                loading = true;
                                setState(() {});
                                
                                await Future.delayed(Duration(seconds: 2));
                                
                                loading = false;
                                setState(() {});
                                
                                ss("Instructions resent successfully");
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Back to Login",
                              size: bs.md,
                              onPressed: () {
                                back();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Back to Login Link
                    if (!emailSent)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Remember your password? ",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              back();
                            },
                            child: Text(
                              "Back to Login",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
