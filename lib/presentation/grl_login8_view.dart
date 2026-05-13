import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLogin8View extends StatefulWidget {
  const GrlLogin8View({super.key});

  @override
  State<GrlLogin8View> createState() => _GrlLogin8ViewState();
}

class _GrlLogin8ViewState extends State<GrlLogin8View> {
  String username = "";
  String password = "";
  String twoFactorCode = "";
  bool isTwoFactorStep = false;
  int selectedMethod = 0;

  final List<Map<String, dynamic>> authMethods = [
    {
      "title": "Authenticator App",
      "subtitle": "Use your authenticator app",
      "icon": Icons.smartphone,
    },
    {
      "title": "SMS Verification",
      "subtitle": "Send code to your phone",
      "icon": Icons.sms,
    },
    {
      "title": "Email Verification",
      "subtitle": "Send code to your email",
      "icon": Icons.email,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withAlpha(50),
              Colors.white,
              secondaryColor.withAlpha(30),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: spLg),
                
                // Header with Security Badge
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primaryColor, secondaryColor],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [shadowXl],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shield_outlined,
                            size: 50,
                            color: primaryColor,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "SecureVault",
                      style: TextStyle(
                        fontSize: fsH1,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "Two-Factor Authentication",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXl),
                
                // Main Content Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius2xl),
                    boxShadow: [shadowXl],
                  ),
                  child: Column(
                    children: [
                      if (!isTwoFactorStep) ...[
                        // Step 1: Username & Password
                        Text(
                          "Step 1: Login Credentials",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Text(
                          "Enter your username and password",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Column(
                          spacing: spMd,
                          children: [
                            QTextField(
                              label: "Username",
                              value: username,
                              hint: "Enter your username",
                              onChanged: (value) {
                                username = value;
                                setState(() {});
                              },
                            ),
                            
                            QTextField(
                              label: "Password",
                              value: password,
                              obscureText: true,
                              hint: "Enter your password",
                              onChanged: (value) {
                                password = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Continue to 2FA",
                            size: bs.md,
                            onPressed: () {
                              if (username.isNotEmpty && password.isNotEmpty) {
                                isTwoFactorStep = true;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ] else ...[
                        // Step 2: Two-Factor Authentication
                        Text(
                          "Step 2: Two-Factor Authentication",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Text(
                          "Choose your verification method",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Authentication Method Selection
                        Column(
                          spacing: spSm,
                          children: List.generate(authMethods.length, (index) {
                            final method = authMethods[index];
                            final isSelected = selectedMethod == index;
                            
                            return GestureDetector(
                              onTap: () {
                                selectedMethod = index;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor.withAlpha(50) : Colors.grey.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: isSelected ? primaryColor : disabledColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        method["icon"],
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${method["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected ? primaryColor : disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${method["subtitle"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: primaryColor,
                                        size: 24,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        QTextField(
                          label: "Verification Code",
                          value: twoFactorCode,
                          hint: "Enter 6-digit code",
                          onChanged: (value) {
                            twoFactorCode = value;
                            setState(() {});
                          },
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Resend code
                              },
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: Container(
                                child: QButton(
                                  label: "Back",
                                  size: bs.md,
                                  onPressed: () {
                                    isTwoFactorStep = false;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: QButton(
                                  label: "Verify & Login",
                                  size: bs.md,
                                  onPressed: () {
                                    // Handle 2FA verification
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
                
                // Security Information
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: infoColor.withAlpha(100)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Two-factor authentication adds an extra layer of security to your account by requiring a second form of verification.",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Help Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Need help? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to help
                      },
                      child: Text(
                        "Contact Support",
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
            ),
          ),
        ),
      ),
    );
  }
}
