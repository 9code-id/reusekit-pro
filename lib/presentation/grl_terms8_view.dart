import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms8View extends StatefulWidget {
  @override
  State<GrlTerms8View> createState() => _GrlTerms8ViewState();
}

class _GrlTerms8ViewState extends State<GrlTerms8View> {
  String userType = "individual";
  String companyName = "";
  String companyAddress = "";
  String taxId = "";
  String authorizedPerson = "";
  String position = "";
  bool hasLegalAuthority = false;
  bool agreedToCorporateTerms = false;

  List<Map<String, dynamic>> userTypes = [
    {
      "id": "individual",
      "title": "Individual User",
      "description": "Personal account for individual use",
      "icon": Icons.person,
      "color": primaryColor,
      "features": ["Basic features", "Personal data protection", "Individual support"],
    },
    {
      "id": "business",
      "title": "Business Account",
      "description": "Small business or professional use",
      "icon": Icons.business,
      "color": successColor,
      "features": ["Business features", "Team collaboration", "Priority support", "Analytics"],
    },
    {
      "id": "enterprise",
      "title": "Enterprise Account",
      "description": "Large organization with advanced needs",
      "icon": Icons.corporate_fare,
      "color": infoColor,
      "features": ["Enterprise features", "Custom integration", "Dedicated support", "Advanced security"],
    },
    {
      "id": "nonprofit",
      "title": "Non-Profit Organization",
      "description": "Special terms for non-profit entities",
      "icon": Icons.volunteer_activism,
      "color": warningColor,
      "features": ["Discounted pricing", "Non-profit features", "Community support", "Grant assistance"],
    },
  ];

  List<Map<String, dynamic>> corporateDocuments = [
    {
      "title": "Business License",
      "description": "Valid business registration certificate",
      "required": true,
      "uploaded": false,
    },
    {
      "title": "Tax Identification",
      "description": "Tax ID or EIN documentation",
      "required": true,
      "uploaded": false,
    },
    {
      "title": "Authorization Letter",
      "description": "Letter authorizing signatory if applicable",
      "required": false,
      "uploaded": false,
    },
    {
      "title": "Corporate Resolution",
      "description": "Board resolution for enterprise accounts",
      "required": false,
      "uploaded": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedType = userTypes.firstWhere(
      (type) => type["id"] == userType,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Type & Terms"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
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
                        Icons.account_circle,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Choose Your Account Type",
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
                    "Select the appropriate account type. Different account types have different terms and verification requirements.",
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
                    "Account Types",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...userTypes.map((type) {
                    bool isSelected = userType == type["id"];
                    
                    return GestureDetector(
                      onTap: () {
                        userType = type["id"];
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? type["color"].withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? type["color"] : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: type["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    type["icon"],
                                    color: type["color"],
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${type["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: type["color"],
                                        ),
                                      ),
                                      Text(
                                        "${type["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: type["color"],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                            
                            if (isSelected) ...[
                              SizedBox(height: spSm),
                              Text(
                                "Features Included:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: type["color"],
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(type["features"] as List<String>).map((feature) {
                                return Container(
                                  margin: EdgeInsets.only(top: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: type["color"],
                                        size: 16,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        feature,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            if (userType != "individual") ...[
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
                          Icons.business_center,
                          color: selectedType["color"],
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Organization Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: selectedType["color"],
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Organization Name",
                      value: companyName,
                      hint: "Enter your organization's legal name",
                      onChanged: (value) {
                        companyName = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Business Address",
                      value: companyAddress,
                      hint: "Enter your organization's address",
                      onChanged: (value) {
                        companyAddress = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Tax ID / EIN",
                      value: taxId,
                      hint: "Enter your tax identification number",
                      onChanged: (value) {
                        taxId = value;
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
                          Icons.person_pin,
                          color: selectedType["color"],
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Authorized Representative",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: selectedType["color"],
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Authorized Person Name",
                      value: authorizedPerson,
                      hint: "Name of person authorized to sign",
                      onChanged: (value) {
                        authorizedPerson = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Position/Title",
                      value: position,
                      hint: "Position within the organization",
                      onChanged: (value) {
                        position = value;
                        setState(() {});
                      },
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: warningColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: hasLegalAuthority,
                            onChanged: (value) {
                              hasLegalAuthority = value ?? false;
                              setState(() {});
                            },
                            activeColor: selectedType["color"],
                          ),
                          Expanded(
                            child: Text(
                              "I confirm that I have the legal authority to bind this organization to the terms of this agreement",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
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
                          Icons.upload_file,
                          color: selectedType["color"],
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Required Documentation",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: selectedType["color"],
                          ),
                        ),
                      ],
                    ),
                    
                    ...corporateDocuments.map((doc) {
                      bool isRequired = doc["required"];
                      bool isUploaded = doc["uploaded"];
                      
                      return Container(
                        margin: EdgeInsets.only(top: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isRequired ? dangerColor.withAlpha(10) : infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isRequired ? dangerColor.withAlpha(50) : infoColor.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isUploaded ? Icons.check_circle : Icons.upload_file,
                              color: isUploaded ? successColor : (isRequired ? dangerColor : infoColor),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${doc["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isRequired ? dangerColor : infoColor,
                                        ),
                                      ),
                                      if (isRequired)
                                        Container(
                                          margin: EdgeInsets.only(left: spXs),
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Required",
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    "${doc["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: isUploaded ? "Uploaded" : "Upload",
                              size: bs.sm,
                              onPressed: isUploaded ? null : () {
                                doc["uploaded"] = true;
                                setState(() {});
                                ss("Document uploaded successfully");
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

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
                        Icons.gavel,
                        color: selectedType["color"],
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Account-Specific Terms",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: selectedType["color"],
                        ),
                      ),
                    ],
                  ),
                  
                  Container(
                    height: 200,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _getAccountSpecificTerms(),
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  
                  if (userType != "individual")
                    Row(
                      children: [
                        Checkbox(
                          value: agreedToCorporateTerms,
                          onChanged: (value) {
                            agreedToCorporateTerms = value ?? false;
                            setState(() {});
                          },
                          activeColor: selectedType["color"],
                        ),
                        Expanded(
                          child: Text(
                            "I agree to the additional terms for ${selectedType["title"]} accounts",
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
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(100),
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
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Account Verification",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    userType == "individual" 
                      ? "Individual accounts are verified through email and phone number. No additional documentation required."
                      : "Business accounts require verification of submitted documents. Verification typically takes 1-3 business days.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: _canProceed() ? "Continue with ${selectedType["title"]}" : "Complete Required Fields",
                onPressed: _canProceed() ? () {
                  ss("Account type selected: ${selectedType["title"]}");
                  if (userType != "individual") {
                    si("Account verification process will begin");
                  }
                } : null,
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "View Full Terms by Account Type",
                onPressed: () {
                  si("Opening detailed terms for ${selectedType["title"]}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getAccountSpecificTerms() {
    switch (userType) {
      case "individual":
        return """
INDIVIDUAL ACCOUNT TERMS

1. PERSONAL USE ONLY
This account is intended for personal, non-commercial use only.

2. ACCOUNT RESPONSIBILITY
You are solely responsible for maintaining the confidentiality of your account credentials.

3. PERSONAL DATA
We will process your personal data in accordance with our Privacy Policy and applicable data protection laws.

4. LIABILITY
Our liability to you is limited to the amount you have paid for our services in the preceding 12 months.

5. TERMINATION
You may terminate your account at any time. We may terminate accounts that violate our terms.
        """;
      
      case "business":
        return """
BUSINESS ACCOUNT TERMS

1. COMMERCIAL USE
This account is licensed for commercial use by small to medium businesses.

2. TEAM ACCESS
You may provide access to authorized employees within your organization.

3. DATA OWNERSHIP
You retain ownership of all data you upload or create using our services.

4. SERVICE LEVELS
Business accounts include enhanced support and service level commitments.

5. COMPLIANCE
You agree to use our services in compliance with all applicable business regulations.

6. BILLING
Business accounts are subject to our commercial billing terms and payment schedules.
        """;
      
      case "enterprise":
        return """
ENTERPRISE ACCOUNT TERMS

1. ENTERPRISE LICENSING
This account includes enterprise-grade features and unlimited user access.

2. CUSTOM AGREEMENTS
Enterprise accounts may be subject to additional custom service agreements.

3. SECURITY REQUIREMENTS
Enhanced security measures and compliance requirements apply to enterprise accounts.

4. DEDICATED SUPPORT
Enterprise accounts include dedicated account management and priority support.

5. INTEGRATION RIGHTS
You may integrate our services with your existing enterprise systems.

6. DATA GOVERNANCE
Enterprise-specific data governance and retention policies apply.
        """;
      
      case "nonprofit":
        return """
NON-PROFIT ORGANIZATION TERMS

1. NON-PROFIT STATUS
You must maintain valid non-profit status to use this account type.

2. DISCOUNTED PRICING
Non-profit accounts receive special pricing subject to annual verification.

3. MISSION ALIGNMENT
Use of our services must align with your organization's non-profit mission.

4. COMPLIANCE
You must comply with all regulations governing non-profit organizations.

5. VERIFICATION
Annual verification of non-profit status is required to maintain account benefits.

6. RESTRICTIONS
Certain commercial features may not be available to non-profit accounts.
        """;
      
      default:
        return "Please select an account type to view specific terms.";
    }
  }

  bool _canProceed() {
    if (userType == "individual") {
      return true;
    } else {
      bool requiredDocuments = corporateDocuments
          .where((doc) => doc["required"])
          .every((doc) => doc["uploaded"]);
          
      return companyName.isNotEmpty &&
             companyAddress.isNotEmpty &&
             taxId.isNotEmpty &&
             authorizedPerson.isNotEmpty &&
             position.isNotEmpty &&
             hasLegalAuthority &&
             agreedToCorporateTerms &&
             requiredDocuments;
    }
  }
}
