import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaForgotPasswordView extends StatefulWidget {
  const EmaForgotPasswordView({super.key});

  @override
  State<EmaForgotPasswordView> createState() => _EmaForgotPasswordViewState();
}

class _EmaForgotPasswordViewState extends State<EmaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  bool isLoading = false;
  bool emailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spLg),
              
              // Header Section
              Center(
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor, warningColor.withAlpha(180)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radius2xl),
                        boxShadow: [shadowMd],
                      ),
                      child: Icon(
                        emailSent ? Icons.mark_email_read : Icons.lock_reset,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Title
                    Text(
                      emailSent ? "Check Your Email" : "Forgot Password?",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Description
                    Text(
                      emailSent 
                          ? "We've sent password reset instructions to your email address."
                          : "Don't worry! Enter your email address and we'll send you a link to reset your password.",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              if (!emailSent) ...[
                // Reset Form
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Email Field
                      QTextField(
                        label: "Email Address",
                        value: email,
                        hint: "Enter your registered email address",
                        validator: Validator.email,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Send Reset Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Send Reset Link",
                          size: bs.md,
                          onPressed: isLoading ? null : _handleSendReset,
                        ),
                      ),
                      
                      SizedBox(height: spLg),
                      
                      // Back to Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Remember your password? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Email Sent Success State
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 48,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Email Sent Successfully!",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "We've sent a password reset link to:",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Instructions
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(100)),
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
                          SizedBox(width: spMd),
                          Text(
                            "Next Steps:",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      _buildInstructionStep("1", "Check your email inbox"),
                      _buildInstructionStep("2", "Click the reset link in the email"),
                      _buildInstructionStep("3", "Create a new strong password"),
                      _buildInstructionStep("4", "Sign in with your new password"),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Action Buttons
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Open Email App",
                        size: bs.md,
                        onPressed: () {
                          ss("Opening email app");
                        },
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Resend Email",
                        size: bs.md,
                        onPressed: () {
                          _handleResendEmail();
                        },
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back to Sign In",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: sp2xl),
              
              // Help Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    _buildHelpOption(
                      Icons.help_center,
                      "Help Center",
                      "Browse our knowledge base for answers",
                      () => ss("Opening help center"),
                    ),
                    
                    _buildHelpOption(
                      Icons.support_agent,
                      "Contact Support",
                      "Get in touch with our support team",
                      () => ss("Opening contact support"),
                    ),
                    
                    _buildHelpOption(
                      Icons.security,
                      "Account Security",
                      "Learn about keeping your account secure",
                      () => ss("Opening security tips"),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Security Note
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security Notice",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "For security reasons, reset links expire after 24 hours.",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInstructionStep(String number, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: infoColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHelpOption(IconData icon, String title, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
  
  void _handleSendReset() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading = true;
    setState(() {});
    
    // Simulate sending reset email
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    emailSent = true;
    setState(() {});
    
    ss("Password reset email sent successfully");
  }
  
  void _handleResendEmail() async {
    ss("Resending password reset email...");
    
    // Simulate resending email
    await Future.delayed(Duration(seconds: 1));
    
    ss("Reset email sent again");
  }
}
