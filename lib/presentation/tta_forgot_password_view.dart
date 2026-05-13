import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaForgotPasswordView extends StatefulWidget {
  const TtaForgotPasswordView({super.key});

  @override
  State<TtaForgotPasswordView> createState() => _TtaForgotPasswordViewState();
}

class _TtaForgotPasswordViewState extends State<TtaForgotPasswordView> {
  String email = "";
  bool loading = false;
  bool emailSent = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              SizedBox(height: sp2xl),
              
              // Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: emailSent ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Icon(
                  emailSent ? Icons.mark_email_read : Icons.lock_reset,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              
              Text(
                emailSent ? "Check Your Email" : "Forgot Password?",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Text(
                emailSent 
                  ? "We've sent password reset instructions to your email address. Please check your inbox and follow the link to reset your password."
                  : "Don't worry! Enter your email address and we'll send you a link to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              
              if (!emailSent) ...[
                SizedBox(height: spXl),
                
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter your registered email",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spXl),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: loading ? "Sending..." : "Send Reset Link",
                    size: bs.md,
                    onPressed: loading ? null : () async {
                      if (formKey.currentState!.validate()) {
                        loading = true;
                        setState(() {});
                        
                        // Simulate sending email
                        await Future.delayed(Duration(seconds: 2));
                        
                        loading = false;
                        emailSent = true;
                        setState(() {});
                        
                        ss("Password reset link sent!");
                      }
                    },
                  ),
                ),
              ],
              
              if (emailSent) ...[
                SizedBox(height: spXl),
                
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Email sent to:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "Didn't receive the email?",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Resend Email",
                    size: bs.md,
                    onPressed: () async {
                      loading = true;
                      setState(() {});
                      
                      // Simulate resending email
                      await Future.delayed(Duration(seconds: 1));
                      
                      loading = false;
                      setState(() {});
                      
                      ss("Email resent successfully!");
                    },
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Use Different Email",
                    size: bs.md,
                    onPressed: () {
                      emailSent = false;
                      email = "";
                      setState(() {});
                    },
                  ),
                ),
              ],
              
              SizedBox(height: sp2xl),
              
              // Tips Container
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Tips:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "• Check your spam/junk folder\n• Make sure you entered the correct email\n• The link expires in 24 hours\n• Contact support if you still have issues",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Back to Login
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
                      // Navigate back to login
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
