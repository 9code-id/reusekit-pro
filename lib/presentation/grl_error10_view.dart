import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlError10View extends StatefulWidget {
  @override
  State<GrlError10View> createState() => _GrlError10ViewState();
}

class _GrlError10ViewState extends State<GrlError10View> {
  bool isRetrying = false;
  String loginEmail = "";
  String loginPassword = "";
  bool showLoginForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              warningColor.withAlpha(5),
              Colors.white,
              warningColor.withAlpha(10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              
              // Session Icon
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius4xl),
                  boxShadow: [shadowXl],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_clock,
                      size: 64,
                      color: warningColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "SESSION",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Session Title
              Text(
                "Session Expired",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Session Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: warningColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your login session has expired for security reasons. Please sign in again to continue using the app.",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Session expired ${DateTime.now().subtract(Duration(minutes: 15)).toString().substring(11, 16)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Session Details
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Session Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    _buildSessionDetail("Session Duration", "2 hours 45 minutes"),
                    _buildSessionDetail("Last Activity", "15 minutes ago"),
                    _buildSessionDetail("Device", "Mobile App"),
                    _buildSessionDetail("Location", "New York, USA"),
                    _buildSessionDetail("Reason", "Automatic timeout"),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Quick Login Option
              if (!showLoginForm)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.flash_on,
                            size: 20,
                            color: successColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Quick Sign In",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      
                      Text(
                        "Sign in quickly using your saved credentials or biometric authentication.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickLoginOption(
                              "Fingerprint",
                              Icons.fingerprint,
                              primaryColor,
                              () {
                                ss("Fingerprint authentication successful");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: _buildQuickLoginOption(
                              "Face ID",
                              Icons.face,
                              infoColor,
                              () {
                                ss("Face ID authentication successful");
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                // Manual Login Form
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.login,
                            size: 20,
                            color: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      QTextField(
                        label: "Email",
                        value: loginEmail,
                        hint: "Enter your email address",
                        onChanged: (value) {
                          loginEmail = value;
                          setState(() {});
                        },
                      ),
                      
                      SizedBox(height: spMd),
                      
                      QTextField(
                        label: "Password",
                        value: loginPassword,
                        hint: "Enter your password",
                        obscureText: true,
                        onChanged: (value) {
                          loginPassword = value;
                          setState(() {});
                        },
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: isRetrying ? "Signing In..." : "Sign In",
                          size: bs.md,
                          onPressed: isRetrying ? () {} : () async {
                            if (loginEmail.isNotEmpty && loginPassword.isNotEmpty) {
                              isRetrying = true;
                              setState(() {});
                              
                              // Simulate login
                              await Future.delayed(Duration(seconds: 2));
                              
                              isRetrying = false;
                              setState(() {});
                              
                              ss("Welcome back! Login successful");
                            } else {
                              se("Please fill in all fields");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              
              SizedBox(height: spMd),
              
              // Action Buttons
              if (!showLoginForm)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Sign In with Password",
                        size: bs.md,
                        onPressed: () {
                          showLoginForm = true;
                          setState(() {});
                        },
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Continue as Guest",
                        size: bs.md,
                        onPressed: () {
                          si("Continuing with limited features");
                        },
                      ),
                    ),
                  ],
                ),
              
              SizedBox(height: spMd),
              
              // Security Information
              Container(
                width: double.infinity,
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
                          size: 20,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Why did this happen?",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    _buildSecurityReason("Automatic logout after 3 hours of inactivity", Icons.timer),
                    _buildSecurityReason("Protection against unauthorized access", Icons.shield),
                    _buildSecurityReason("Compliance with security policies", Icons.policy),
                    _buildSecurityReason("Prevention of session hijacking", Icons.security),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Account Recovery
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: warningColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 20,
                          color: warningColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "If you're having trouble signing in, we're here to help you regain access to your account.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(ForgotPasswordView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_reset,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(ContactSupportView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: warningColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.support_agent,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Contact Support",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSessionDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLoginOption(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            SizedBox(width: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityReason(String reason, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: infoColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
