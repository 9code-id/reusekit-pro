import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus8View extends StatefulWidget {
  @override
  State<GrlStatus8View> createState() => _GrlStatus8ViewState();
}

class _GrlStatus8ViewState extends State<GrlStatus8View> {
  int currentStep = 2; // Current active step (0-based index)
  
  List<Map<String, dynamic>> registrationSteps = [
    {
      "id": 1,
      "title": "Personal Information",
      "subtitle": "Basic details about yourself",
      "description": "Provide your full name, date of birth, and contact information",
      "status": "completed",
      "icon": Icons.person,
      "completedAt": "2024-07-20 10:30 AM",
      "fields": [
        {"label": "Full Name", "value": "John Doe", "status": "verified"},
        {"label": "Email", "value": "john.doe@email.com", "status": "verified"},
        {"label": "Phone", "value": "+1 (555) 123-4567", "status": "verified"},
        {"label": "Date of Birth", "value": "January 15, 1990", "status": "verified"},
      ],
      "requirements": [
        "Valid government-issued ID",
        "Current email address",
        "Active phone number",
      ],
    },
    {
      "id": 2,
      "title": "Address Verification",
      "subtitle": "Confirm your residential address",
      "description": "Upload proof of address and verify your current location",
      "status": "completed",
      "icon": Icons.location_on,
      "completedAt": "2024-07-21 02:15 PM",
      "fields": [
        {"label": "Street Address", "value": "123 Main Street, Apt 4B", "status": "verified"},
        {"label": "City", "value": "New York", "status": "verified"},
        {"label": "State", "value": "NY", "status": "verified"},
        {"label": "ZIP Code", "value": "10001", "status": "verified"},
      ],
      "requirements": [
        "Utility bill (last 3 months)",
        "Bank statement",
        "Lease agreement",
      ],
    },
    {
      "id": 3,
      "title": "Identity Verification",
      "subtitle": "Verify your identity documents",
      "description": "Upload government ID and complete identity verification process",
      "status": "in_progress",
      "icon": Icons.verified_user,
      "completedAt": null,
      "fields": [
        {"label": "ID Type", "value": "Driver's License", "status": "pending"},
        {"label": "ID Number", "value": "DL123456789", "status": "pending"},
        {"label": "Expiry Date", "value": "December 2027", "status": "pending"},
        {"label": "Photo Verification", "value": "In Review", "status": "pending"},
      ],
      "requirements": [
        "Clear photo of front and back",
        "Document must be valid",
        "Face verification selfie",
      ],
    },
    {
      "id": 4,
      "title": "Financial Information",
      "subtitle": "Link your financial accounts",
      "description": "Connect bank account and verify financial standing",
      "status": "pending",
      "icon": Icons.account_balance,
      "completedAt": null,
      "fields": [
        {"label": "Bank Name", "value": "", "status": "not_started"},
        {"label": "Account Type", "value": "", "status": "not_started"},
        {"label": "Routing Number", "value": "", "status": "not_started"},
        {"label": "Account Number", "value": "", "status": "not_started"},
      ],
      "requirements": [
        "Valid bank account",
        "Account in your name",
        "Minimum balance verification",
      ],
    },
    {
      "id": 5,
      "title": "Background Check",
      "subtitle": "Complete background verification",
      "description": "Authorize and complete comprehensive background screening",
      "status": "pending",
      "icon": Icons.security,
      "completedAt": null,
      "fields": [
        {"label": "Criminal History", "value": "", "status": "not_started"},
        {"label": "Employment History", "value": "", "status": "not_started"},
        {"label": "References", "value": "", "status": "not_started"},
        {"label": "Credit Check", "value": "", "status": "not_started"},
      ],
      "requirements": [
        "Authorization consent",
        "Previous employment details",
        "Character references",
      ],
    },
    {
      "id": 6,
      "title": "Final Review",
      "subtitle": "Complete application review",
      "description": "Final verification and approval of your application",
      "status": "pending",
      "icon": Icons.fact_check,
      "completedAt": null,
      "fields": [
        {"label": "Application Status", "value": "", "status": "not_started"},
        {"label": "Review Date", "value": "", "status": "not_started"},
        {"label": "Approval Status", "value": "", "status": "not_started"},
        {"label": "Account Activation", "value": "", "status": "not_started"},
      ],
      "requirements": [
        "All previous steps completed",
        "Documentation verified",
        "Approval committee review",
      ],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return primaryColor;
      case "pending":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getFieldStatusColor(String status) {
    switch (status) {
      case "verified":
        return successColor;
      case "pending":
        return warningColor;
      case "rejected":
        return dangerColor;
      case "not_started":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildProgressIndicator() {
    int completedSteps = registrationSteps.where((step) => step["status"] == "completed").length;
    double progress = completedSteps / registrationSteps.length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Registration Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Step ${currentStep + 1} of ${registrationSteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(progress * 100).toInt()}% Complete",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withAlpha(60),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${registrationSteps[currentStep]["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          Text(
            "${registrationSteps[currentStep]["subtitle"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsList() {
    return Column(
      children: registrationSteps.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> step = entry.value;
        
        return _buildStepCard(step, index);
      }).toList(),
    );
  }

  Widget _buildStepCard(Map<String, dynamic> step, int index) {
    Color statusColor = _getStatusColor(step["status"] as String);
    bool isActive = index == currentStep;
    bool isCompleted = step["status"] == "completed";
    bool isInProgress = step["status"] == "in_progress";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isActive ? Border.all(color: primaryColor, width: 2) : 
                 isCompleted ? Border.all(color: successColor.withAlpha(100)) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Header
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    shape: BoxShape.circle,
                    border: Border.all(color: statusColor, width: 2),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          step["icon"] as IconData,
                          color: statusColor,
                          size: 24,
                        ),
                      ),
                      if (isCompleted)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                SizedBox(width: spSm),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Step ${step["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${step["status"]}".toUpperCase().replaceAll('_', ' '),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "${step["subtitle"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Description
            Text(
              "${step["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Completion Time
            if (step["completedAt"] != null)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Completed on ${step["completedAt"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spSm),
            
            // Fields Status
            if ((step["fields"] as List).isNotEmpty) ...[
              Text(
                "Field Status:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spXs),
              
              Column(
                children: (step["fields"] as List).map((field) {
                  Color fieldStatusColor = _getFieldStatusColor(field["status"] as String);
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: fieldStatusColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: fieldStatusColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${field["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if ((field["value"] as String).isNotEmpty)
                                Text(
                                  "${field["value"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: fieldStatusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${field["status"]}".toUpperCase().replaceAll('_', ' '),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spSm),
            ],
            
            // Requirements
            Text(
              "Requirements:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXs),
            
            Column(
              children: (step["requirements"] as List).map((requirement) => 
                Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: statusColor,
                        size: 8,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "$requirement",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ),
            
            SizedBox(height: spSm),
            
            // Action Buttons
            if (isInProgress)
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Continue Step",
                      size: bs.md,
                      onPressed: () {
                        si("Continuing step ${step["id"]}");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Help",
                    size: bs.sm,
                    onPressed: () {
                      si("Help for step ${step["id"]}");
                    },
                  ),
                ],
              )
            else if (step["status"] == "pending")
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Start Step",
                  size: bs.md,
                  onPressed: () {
                    currentStep = index;
                    registrationSteps[index]["status"] = "in_progress";
                    setState(() {});
                    ss("Step ${step["id"]} started");
                  },
                ),
              )
            else if (isCompleted)
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        si("Viewing details for step ${step["id"]}");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Edit",
                    size: bs.sm,
                    onPressed: () {
                      sw("Editing completed step may require re-verification");
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Status"),
        actions: [
          Icon(Icons.help_outline, color: disabledBoldColor),
          SizedBox(width: spSm),
          Icon(Icons.support_agent, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview
            _buildProgressIndicator(),
            
            SizedBox(height: spMd),
            
            // Steps List
            _buildStepsList(),
            
            SizedBox(height: spMd),
            
            // Support Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Our support team is available 24/7 to help you complete your registration process.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          size: bs.sm,
                          onPressed: () {
                            si("Live chat opened");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Call Support",
                          size: bs.sm,
                          onPressed: () {
                            si("Support call initiated");
                          },
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
    );
  }
}
