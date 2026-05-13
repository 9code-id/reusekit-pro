import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaBiometricSetupView extends StatefulWidget {
  const BfaBiometricSetupView({super.key});

  @override
  State<BfaBiometricSetupView> createState() => _BfaBiometricSetupViewState();
}

class _BfaBiometricSetupViewState extends State<BfaBiometricSetupView> {
  bool fingerprintEnabled = false;
  bool faceIdEnabled = false;
  bool voiceRecognitionEnabled = false;
  bool loading = false;
  bool setupComplete = false;

  List<Map<String, dynamic>> biometricOptions = [
    {
      "title": "Fingerprint",
      "description": "Use your fingerprint to unlock the app",
      "icon": Icons.fingerprint,
      "color": primaryColor,
      "enabled": false,
      "available": true,
    },
    {
      "title": "Face ID",
      "description": "Use facial recognition for secure access",
      "icon": Icons.face,
      "color": successColor,
      "enabled": false,
      "available": true,
    },
    {
      "title": "Voice Recognition",
      "description": "Use your voice pattern for authentication",
      "icon": Icons.mic,
      "color": infoColor,
      "enabled": false,
      "available": false,
    },
  ];

  Future<void> _toggleBiometric(int index) async {
    if (!biometricOptions[index]["available"]) {
      sw("This biometric option is not available on your device");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate biometric setup process
    await Future.delayed(Duration(seconds: 2));

    biometricOptions[index]["enabled"] = !biometricOptions[index]["enabled"];
    
    if (index == 0) fingerprintEnabled = biometricOptions[index]["enabled"];
    if (index == 1) faceIdEnabled = biometricOptions[index]["enabled"];
    if (index == 2) voiceRecognitionEnabled = biometricOptions[index]["enabled"];

    loading = false;
    setState(() {});

    if (biometricOptions[index]["enabled"]) {
      ss("${biometricOptions[index]["title"]} enabled successfully");
    } else {
      si("${biometricOptions[index]["title"]} disabled");
    }
  }

  Future<void> _completeSetup() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setupComplete = true;
    setState(() {});

    ss("Biometric setup completed successfully");
    
    Future.delayed(Duration(seconds: 1), () {
      // navigateTo(BfaSecurityQuestionsView());
    });
  }

  void _skipSetup() {
    // navigateTo(BfaSecurityQuestionsView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biometric Setup"),
        actions: [
          TextButton(
            onPressed: _skipSetup,
            child: Text(
              "Skip",
              style: TextStyle(
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            if (!setupComplete) ...[
              // Header Section
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Icon(
                  Icons.security,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spXl),
              
              Text(
                "Enhanced Security",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Add an extra layer of security to your banking app with biometric authentication",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              // Biometric Options
              ...List.generate(biometricOptions.length, (index) {
                final option = biometricOptions[index];
                bool isEnabled = option["enabled"] as bool;
                bool isAvailable = option["available"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isEnabled ? (option["color"] as Color).withAlpha(10) : Colors.white,
                      border: Border.all(
                        color: isEnabled 
                            ? (option["color"] as Color) 
                            : isAvailable 
                                ? disabledOutlineBorderColor 
                                : disabledColor,
                        width: isEnabled ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: isEnabled ? [shadowSm] : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isEnabled 
                                ? (option["color"] as Color) 
                                : isAvailable 
                                    ? disabledColor 
                                    : disabledColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            option["icon"] as IconData,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${option["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isAvailable ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  if (!isAvailable)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Not Available",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${option["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        if (isAvailable)
                          GestureDetector(
                            onTap: () => _toggleBiometric(index),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isEnabled ? (option["color"] as Color) : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                isEnabled ? "Enabled" : "Enable",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
              
              SizedBox(height: sp2xl),
              
              // Security Benefits
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Security Benefits",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Faster and more secure login",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Reduce the risk of unauthorized access",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Enhanced protection for sensitive transactions",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              // Action Buttons
              if (!loading) ...[
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Complete Setup",
                    size: bs.md,
                    onPressed: (fingerprintEnabled || faceIdEnabled) ? _completeSetup : null,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledBoldColor),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: GestureDetector(
                      onTap: _skipSetup,
                      child: Text(
                        "Skip for Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              
              if (loading)
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                      SizedBox(height: spLg),
                      Text(
                        "Setting up biometric authentication...",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            
            // Setup Complete State
            if (setupComplete) ...[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 60,
                  color: successColor,
                ),
              ),
              
              SizedBox(height: spXl),
              
              Text(
                "Setup Complete!",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Your biometric authentication has been configured successfully. Your account is now more secure.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: sp2xl),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(BfaSecurityQuestionsView());
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
