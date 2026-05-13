import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword8View extends StatefulWidget {
  @override
  State<GrlForgotPassword8View> createState() => _GrlForgotPassword8ViewState();
}

class _GrlForgotPassword8ViewState extends State<GrlForgotPassword8View> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String supportMessage = "";
  bool loading = false;
  bool messageSubmitted = false;

  final List<Map<String, dynamic>> supportReasons = [
    {
      "title": "Can't access email",
      "description": "Your email account is no longer accessible",
      "icon": Icons.email_outlined,
    },
    {
      "title": "Forgot username",
      "description": "You don't remember your username or email",
      "icon": Icons.person_search,
    },
    {
      "title": "Account compromised",
      "description": "You suspect your account has been hacked",
      "icon": Icons.security,
    },
    {
      "title": "Other issues",
      "description": "Different problem not listed above",
      "icon": Icons.help_outline,
    },
  ];

  String selectedReason = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Support"),
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
                    
                    if (!messageSubmitted) ...[
                      // Support Form
                      
                      // Header
                      Center(
                        child: Column(
                          spacing: spMd,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    infoColor.withAlpha(20),
                                    infoColor.withAlpha(5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(radius3xl),
                              ),
                              child: Icon(
                                Icons.support_agent,
                                size: 60,
                                color: infoColor,
                              ),
                            ),
                            
                            Column(
                              spacing: spSm,
                              children: [
                                Text(
                                  "We're Here to Help",
                                  style: TextStyle(
                                    fontSize: fsH3,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Can't reset your password using the regular methods? Our support team will assist you in recovering your account.",
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
                      
                      // Contact Information
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
                                  Icons.contact_mail,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Contact Information",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            QTextField(
                              label: "Your Email Address",
                              value: email,
                              hint: "Enter email where we can reach you",
                              validator: Validator.email,
                              onChanged: (value) {
                                email = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Issue Category
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
                                  Icons.category,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "What's the issue?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Column(
                              spacing: spSm,
                              children: supportReasons.map((reason) {
                                final isSelected = selectedReason == reason["title"];
                                return GestureDetector(
                                  onTap: () {
                                    selectedReason = reason["title"];
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: isSelected 
                                          ? primaryColor.withAlpha(10) 
                                          : Colors.grey.withAlpha(5),
                                      border: Border.all(
                                        color: isSelected 
                                            ? primaryColor 
                                            : disabledOutlineBorderColor,
                                        width: isSelected ? 2 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: isSelected 
                                                ? primaryColor 
                                                : disabledColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            reason["icon"],
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: spMd),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reason["title"],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: isSelected 
                                                      ? primaryColor 
                                                      : disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                reason["description"],
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
                                            size: 20,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Additional Message
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
                                  Icons.message,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Additional Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            QMemoField(
                              label: "Describe your issue",
                              value: supportMessage,
                              hint: "Please provide any additional details that might help us assist you better...",
                              validator: Validator.required,
                              onChanged: (value) {
                                supportMessage = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Response Time Info
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: successColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Response Time",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "We typically respond within 2-4 hours during business hours",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Submit Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Submit Support Request",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate() && selectedReason.isNotEmpty) {
                              loading = true;
                              setState(() {});
                              
                              // Simulate submission
                              await Future.delayed(Duration(seconds: 2));
                              
                              loading = false;
                              messageSubmitted = true;
                              setState(() {});
                              
                              ss("Support request submitted successfully!");
                            } else if (selectedReason.isEmpty) {
                              sw("Please select an issue category");
                            }
                          },
                        ),
                      ),
                    ] else ...[
                      // Success State
                      
                      Center(
                        child: Column(
                          spacing: spLg,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radius3xl),
                                border: Border.all(
                                  color: successColor.withAlpha(30),
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.check_circle_outline,
                                size: 80,
                                color: successColor,
                              ),
                            ),
                            
                            Column(
                              spacing: spSm,
                              children: [
                                Text(
                                  "Request Submitted!",
                                  style: TextStyle(
                                    fontSize: fsH2,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Thank you for contacting us. We've received your support request and will get back to you soon.",
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
                      
                      // Request Details
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
                                  Icons.confirmation_number,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Request Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Request ID:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "#${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Issue Type:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  selectedReason,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Contact Email:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // What's Next
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
                                  Icons.info_outline,
                                  color: infoColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "What happens next?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "• Our support team will review your request\n• You'll receive an email with further instructions\n• We may ask for additional verification\n• Once verified, we'll help reset your password",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spXl),
                    
                    // Alternative Options
                    if (!messageSubmitted) ...[
                      Row(
                        children: [
                          Expanded(child: Divider(color: disabledColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: spMd),
                            child: Text(
                              "or try other methods",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: disabledColor)),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
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
                                // navigateTo(SecurityQuestionView());
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
                                      Icons.quiz,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Security Q&A",
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
