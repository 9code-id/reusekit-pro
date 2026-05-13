import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms7View extends StatefulWidget {
  @override
  State<GrlTerms7View> createState() => _GrlTerms7ViewState();
}

class _GrlTerms7ViewState extends State<GrlTerms7View> {
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String digitalSignature = "";
  DateTime? signatureDate;
  bool agreedToTerms = false;
  bool agreedToPrivacy = false;
  bool agreedToMarketing = false;
  bool isWitness = false;

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> signatureSteps = [
    {
      "title": "Personal Information",
      "description": "Enter your legal name and contact details",
      "icon": Icons.person,
      "completed": false,
    },
    {
      "title": "Legal Agreements",
      "description": "Review and accept all legal documents",
      "icon": Icons.assignment,
      "completed": false,
    },
    {
      "title": "Digital Signature",
      "description": "Provide your digital signature",
      "icon": Icons.draw,
      "completed": false,
    },
    {
      "title": "Final Confirmation",
      "description": "Confirm and submit your agreement",
      "icon": Icons.verified,
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    _updateStepCompletion();

    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Signature"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Opening signature help guide");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(30), primaryColor.withAlpha(10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Legal Agreement Signature",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your digital signature will be legally binding. Please ensure all information is accurate before signing.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Signature Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...signatureSteps.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> step = entry.value;
                      bool isCompleted = step["completed"];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor.withAlpha(10) : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isCompleted ? successColor.withAlpha(100) : disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: isCompleted ? successColor : disabledColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: isCompleted 
                                  ? Icon(Icons.check, color: Colors.white, size: 16)
                                  : Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${step["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isCompleted ? successColor : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${step["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              step["icon"],
                              color: isCompleted ? successColor : disabledColor,
                              size: 20,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Full Legal Name",
                      value: fullName,
                      hint: "Enter your full name as it appears on legal documents",
                      validator: Validator.required,
                      onChanged: (value) {
                        fullName = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "Enter your email address",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      hint: "Enter your phone number",
                      validator: Validator.required,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Legal Agreements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: dangerColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Required Legal Agreements",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Checkbox(
                                value: agreedToTerms,
                                onChanged: (value) {
                                  agreedToTerms = value ?? false;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                              ),
                              Expanded(
                                child: Text(
                                  "I have read and agree to the Terms of Service",
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
                              Checkbox(
                                value: agreedToPrivacy,
                                onChanged: (value) {
                                  agreedToPrivacy = value ?? false;
                                  setState(() {});
                                },
                                activeColor: primaryColor,
                              ),
                              Expanded(
                                child: Text(
                                  "I have read and agree to the Privacy Policy",
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
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: agreedToMarketing,
                            onChanged: (value) {
                              agreedToMarketing = value ?? false;
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Marketing Communications (Optional)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "I agree to receive marketing emails and notifications",
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
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.draw,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Digital Signature",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Type Your Full Name as Signature",
                      value: digitalSignature,
                      hint: "Type your full name exactly as written above",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digital signature is required";
                        }
                        if (value.toLowerCase() != fullName.toLowerCase()) {
                          return "Signature must match your full name";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        digitalSignature = value;
                        setState(() {});
                      },
                    ),
                    
                    if (digitalSignature.isNotEmpty && digitalSignature.toLowerCase() == fullName.toLowerCase())
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: successColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Digital Signature Verified",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Your signature matches your full name",
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
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Signature Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Signature Date:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "IP Address:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "192.168.1.100",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      children: [
                        Checkbox(
                          value: isWitness,
                          onChanged: (value) {
                            isWitness = value ?? false;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            "I confirm that I am signing this agreement voluntarily and understand its legal implications",
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

              if (_isReadyToSign())
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: successColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.verified,
                        color: successColor,
                        size: 48,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Ready to Sign",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "All requirements have been met. You may now submit your digital signature.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: _isReadyToSign() ? "Submit Digital Signature" : "Complete All Steps First",
                  onPressed: _isReadyToSign() ? () {
                    if (formKey.currentState!.validate()) {
                      ss("Digital signature submitted successfully");
                      si("Agreement legally binding as of ${DateTime.now()}");
                    }
                  } : null,
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your digital signature will have the same legal effect as a handwritten signature. This agreement will be stored securely and can be accessed from your account.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
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

  void _updateStepCompletion() {
    signatureSteps[0]["completed"] = fullName.isNotEmpty && email.isNotEmpty && phoneNumber.isNotEmpty;
    signatureSteps[1]["completed"] = agreedToTerms && agreedToPrivacy;
    signatureSteps[2]["completed"] = digitalSignature.isNotEmpty && digitalSignature.toLowerCase() == fullName.toLowerCase();
    signatureSteps[3]["completed"] = _isReadyToSign();
  }

  bool _isReadyToSign() {
    return fullName.isNotEmpty &&
           email.isNotEmpty &&
           phoneNumber.isNotEmpty &&
           agreedToTerms &&
           agreedToPrivacy &&
           digitalSignature.isNotEmpty &&
           digitalSignature.toLowerCase() == fullName.toLowerCase() &&
           isWitness;
  }
}
