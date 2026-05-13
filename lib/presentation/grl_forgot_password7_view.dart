import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword7View extends StatefulWidget {
  @override
  State<GrlForgotPassword7View> createState() => _GrlForgotPassword7ViewState();
}

class _GrlForgotPassword7ViewState extends State<GrlForgotPassword7View> {
  final formKey = GlobalKey<FormState>();
  String identifier = "";
  String securityAnswer = "";
  bool loading = false;
  bool questionRetrieved = false;
  String securityQuestion = "";

  final List<Map<String, dynamic>> sampleQuestions = [
    {
      "question": "What was the name of your first pet?",
      "hint": "The furry friend from your childhood"
    },
    {
      "question": "In which city were you born?",
      "hint": "Your birthplace"
    },
    {
      "question": "What was your mother's maiden name?",
      "hint": "Your mother's family name before marriage"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Questions"),
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
                    SizedBox(height: spMd),
                    
                    // Header Section
                    Center(
                      child: Column(
                        spacing: spMd,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radius2xl),
                              border: Border.all(
                                color: warningColor.withAlpha(30),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.quiz,
                              size: 50,
                              color: warningColor,
                            ),
                          ),
                          
                          Column(
                            spacing: spSm,
                            children: [
                              Text(
                                "Security Verification",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                questionRetrieved
                                    ? "Answer your security question to verify your identity"
                                    : "Enter your username or email to retrieve your security question",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: sp2xl),
                    
                    if (!questionRetrieved) ...[
                      // Step 1: Username/Email Input
                      
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person_search,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Account Identification",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            QTextField(
                              label: "Username or Email",
                              value: identifier,
                              hint: "Enter your username or email address",
                              validator: Validator.required,
                              onChanged: (value) {
                                identifier = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Security Info
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: infoColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
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
                                  "Security Notice",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "We'll show you the security question you set up during account creation. This helps verify your identity without compromising your account security.",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Get Question Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Get Security Question",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              // Simulate API call to get security question
                              await Future.delayed(Duration(seconds: 2));
                              
                              // Simulate getting a random question
                              final randomQuestion = sampleQuestions[
                                DateTime.now().millisecond % sampleQuestions.length
                              ];
                              
                              loading = false;
                              questionRetrieved = true;
                              securityQuestion = randomQuestion["question"];
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ] else ...[
                      // Step 2: Security Question & Answer
                      
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  color: warningColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Security Question",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(5),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: warningColor.withAlpha(20),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                securityQuestion,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Answer Input
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Your Answer",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            QTextField(
                              label: "Security Answer",
                              value: securityAnswer,
                              hint: "Enter your answer exactly as you set it",
                              validator: Validator.required,
                              onChanged: (value) {
                                securityAnswer = value;
                                setState(() {});
                              },
                            ),
                            
                            Text(
                              "💡 Tip: Answers are case-sensitive. Enter exactly as you originally set it.",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Wrong Question Option
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "This isn't my security question?",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // navigateTo(ContactSupportView());
                                si("Please contact support for further assistance");
                              },
                              child: Text(
                                "Contact Support",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Verify Answer Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Verify Answer",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loading = true;
                              setState(() {});
                              
                              // Simulate verification
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              setState(() {});
                              
                              // Simulate success/failure
                              if (securityAnswer.toLowerCase().isNotEmpty) {
                                ss("Security question verified!");
                                // navigateTo(NewPasswordView());
                              } else {
                                se("Incorrect answer. Please try again.");
                              }
                            }
                          },
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Start Over
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            questionRetrieved = false;
                            securityAnswer = "";
                            securityQuestion = "";
                            setState(() {});
                          },
                          child: Text(
                            "Try Different Account",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spXl),
                    
                    // Alternative Recovery Options
                    Column(
                      spacing: spMd,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Divider(color: disabledColor)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: spMd),
                              child: Text(
                                "Other Recovery Options",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: disabledColor)),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // navigateTo(EmailRecoveryView());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: disabledOutlineBorderColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Email Reset",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
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
                                  // navigateTo(SmsRecoveryView());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: disabledOutlineBorderColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.sms,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "SMS Reset",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
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
                    
                    SizedBox(height: spMd),
                    
                    // Back to Login
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
