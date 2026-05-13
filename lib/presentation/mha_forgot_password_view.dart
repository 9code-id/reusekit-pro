import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaForgotPasswordView extends StatefulWidget {
  const MhaForgotPasswordView({super.key});

  @override
  State<MhaForgotPasswordView> createState() => _MhaForgotPasswordViewState();
}

class _MhaForgotPasswordViewState extends State<MhaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;
  bool emailSent = false;

  void _sendResetEmail() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate sending reset email
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      emailSent = true;
      setState(() {});
      
      ss("Password reset email sent!");
    }
  }

  void _resendEmail() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Email resent successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spLg),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    emailSent ? Icons.email : Icons.lock_reset,
                    size: 40,
                    color: warningColor,
                  ),
                ),
              ),
              SizedBox(height: spLg),
              Text(
                emailSent ? "Check Your Email" : "Reset Password",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                emailSent 
                  ? "We've sent a password reset link to your email address"
                  : "Enter your email address and we'll send you a link to reset your password",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: spXl),
              if (!emailSent) ...[
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter your email",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spXl),
                if (loading)
                  Center(child: CircularProgressIndicator())
                else
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Reset Link",
                      size: bs.md,
                      onPressed: _sendResetEmail,
                    ),
                  ),
              ] else ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Email Sent Successfully",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Please check your email ($email) for the password reset link. Don't forget to check your spam folder.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spXl),
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
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the email? ",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: _resendEmail,
                      child: Text(
                        "Resend",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: spXl),
              if (!emailSent) ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Password Reset Tips",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "• Check your spam/junk folder\n• Make sure the email address is correct\n• The reset link expires in 24 hours\n• Contact support if you still have issues",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: spXl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Remember your password? ",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      back();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
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
