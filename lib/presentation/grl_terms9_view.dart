import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms9View extends StatefulWidget {
  @override
  State<GrlTerms9View> createState() => _GrlTerms9ViewState();
}

class _GrlTerms9ViewState extends State<GrlTerms9View> {
  int currentVersion = 3;
  Map<int, bool> versionAcceptance = {};
  String selectedVersionId = "v3.2";

  List<Map<String, dynamic>> versionHistory = [
    {
      "id": "v3.2",
      "version": "3.2",
      "releaseDate": "June 15, 2024",
      "status": "current",
      "title": "Current Terms",
      "changes": [
        "Enhanced data protection clauses",
        "Updated user responsibilities section",
        "Clarified service limitation terms",
        "Added new dispute resolution procedures"
      ],
      "color": primaryColor,
      "icon": Icons.verified,
    },
    {
      "id": "v3.1",
      "version": "3.1",
      "releaseDate": "April 20, 2024",
      "status": "previous",
      "title": "Previous Version",
      "changes": [
        "Modified cookie policy",
        "Updated international data transfer clauses",
        "Revised termination procedures",
        "Enhanced security requirements"
      ],
      "color": infoColor,
      "icon": Icons.history,
    },
    {
      "id": "v3.0",
      "version": "3.0",
      "releaseDate": "January 10, 2024",
      "status": "archived",
      "title": "Major Update",
      "changes": [
        "Complete terms restructuring",
        "New privacy compliance framework",
        "Updated liability limitations",
        "Enhanced intellectual property clauses"
      ],
      "color": warningColor,
      "icon": Icons.archive,
    },
    {
      "id": "v2.8",
      "version": "2.8",
      "releaseDate": "November 5, 2023",
      "status": "archived",
      "title": "Legacy Version",
      "changes": [
        "Minor clause clarifications",
        "Updated contact information",
        "Revised payment terms",
        "Bug fixes in legal text"
      ],
      "color": disabledBoldColor,
      "icon": Icons.folder,
    },
  ];

  Map<String, String> versionContent = {
    "v3.2": """
TERMS OF SERVICE - VERSION 3.2
Effective Date: June 15, 2024

1. ACCEPTANCE OF TERMS
By accessing and using this application, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.

2. ENHANCED DATA PROTECTION
We have strengthened our data protection measures to ensure compliance with global privacy regulations including GDPR, CCPA, and other applicable laws.

3. USER RESPONSIBILITIES
Users are required to:
- Provide accurate and current information
- Maintain account security
- Comply with all applicable laws
- Report any violations or security issues

4. SERVICE LIMITATIONS
Our services are provided "as is" with specific limitations on liability and warranties as outlined in our detailed service agreement.

5. DISPUTE RESOLUTION
New mandatory arbitration procedures have been established for resolving disputes efficiently and fairly.

6. INTELLECTUAL PROPERTY
Enhanced protection for both user-generated content and our proprietary technologies.

7. TERMINATION
Clear procedures for account termination by either party with appropriate notice periods.

8. GOVERNING LAW
These terms are governed by applicable jurisdiction laws with enhanced international compliance.
    """,
    "v3.1": """
TERMS OF SERVICE - VERSION 3.1
Effective Date: April 20, 2024

[Previous version content with modified sections for cookie policy, international data transfers, termination procedures, and security requirements]

1. ACCEPTANCE OF TERMS
Standard acceptance clause with updated reference materials.

2. DATA PROTECTION
Previous data protection framework with enhanced cookie management.

3. INTERNATIONAL TRANSFERS
Updated clauses for cross-border data transfer compliance.

4. SECURITY REQUIREMENTS
Enhanced security standards for user accounts and data protection.

5. TERMINATION PROCEDURES
Revised procedures for account termination and data retention.
    """,
    "v3.0": """
TERMS OF SERVICE - VERSION 3.0
Effective Date: January 10, 2024

[Major restructuring of all terms with comprehensive updates to privacy compliance, liability limitations, and intellectual property clauses]

Complete overhaul of terms structure with new sections for:
- Privacy compliance framework
- Enhanced liability protections
- Intellectual property rights management
- Service level agreements
- User conduct policies
    """,
    "v2.8": """
TERMS OF SERVICE - VERSION 2.8
Effective Date: November 5, 2023

[Legacy version with minor updates]

Standard terms with clarifications to existing clauses and updated contact information for legal notices.
    """,
  };

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedVersion = versionHistory.firstWhere(
      (version) => version["id"] == selectedVersionId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Terms Version History"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "v${currentVersion}.2",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Version History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    itemCount: versionHistory.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> version = versionHistory[index];
                      bool isSelected = selectedVersionId == version["id"];
                      bool isAccepted = versionAcceptance[index] ?? false;

                      return GestureDetector(
                        onTap: () {
                          selectedVersionId = version["id"];
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? version["color"].withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? version["color"] : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: version["color"].withAlpha(isSelected ? 30 : 10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      version["icon"],
                                      color: version["color"],
                                      size: 20,
                                    ),
                                  ),
                                  if (isAccepted)
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                  if (version["status"] == "current")
                                    Positioned(
                                      bottom: -2,
                                      left: -2,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "v${version["version"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? version["color"] : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${version["status"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    spacing: spXs,
                    children: [
                      QButton(
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          si("Downloading version history archive");
                        },
                      ),
                      Text(
                        "Download Archive",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: selectedVersion["color"].withAlpha(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: selectedVersion["color"].withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          selectedVersion["icon"],
                          color: selectedVersion["color"],
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
                                Text(
                                  "Version ${selectedVersion["version"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: selectedVersion["color"],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: selectedVersion["color"].withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${selectedVersion["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: selectedVersion["color"],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${selectedVersion["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Released: ${selectedVersion["releaseDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (versionAcceptance[versionHistory.indexWhere((v) => v["id"] == selectedVersionId)] ?? false)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        if (selectedVersion["status"] == "current")
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: successColor.withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: successColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Current Active Version",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "This is the version currently in effect and must be accepted to use our services",
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
                                    Icons.change_history,
                                    color: selectedVersion["color"],
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Key Changes in This Version",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: selectedVersion["color"],
                                    ),
                                  ),
                                ],
                              ),
                              
                              ...(selectedVersion["changes"] as List<String>).map((change) {
                                return Container(
                                  margin: EdgeInsets.only(top: spSm),
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: selectedVersion["color"].withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: selectedVersion["color"].withAlpha(30),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.fiber_manual_record,
                                          color: selectedVersion["color"],
                                          size: 8,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          change,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
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
                                    Icons.article,
                                    color: selectedVersion["color"],
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Terms Content",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: selectedVersion["color"],
                                    ),
                                  ),
                                ],
                              ),
                              
                              Container(
                                height: 300,
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    versionContent[selectedVersionId] ?? "Content not available for this version.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (selectedVersion["status"] != "current")
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: warningColor.withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: warningColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Historical Version",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                      Text(
                                        "This version is no longer active. Please review and accept the current version to continue using our services.",
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
                ),

                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      if (selectedVersion["status"] == "current")
                        Row(
                          children: [
                            Checkbox(
                              value: versionAcceptance[versionHistory.indexWhere((v) => v["id"] == selectedVersionId)] ?? false,
                              onChanged: (value) {
                                int index = versionHistory.indexWhere((v) => v["id"] == selectedVersionId);
                                versionAcceptance[index] = value ?? false;
                                setState(() {});
                              },
                              activeColor: selectedVersion["color"],
                            ),
                            Expanded(
                              child: Text(
                                "I have read and agree to Terms of Service Version ${selectedVersion["version"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Download PDF",
                              onPressed: () {
                                si("Downloading Terms v${selectedVersion["version"]} as PDF");
                              },
                            ),
                          ),
                          if (selectedVersion["status"] == "current")
                            Expanded(
                              child: QButton(
                                label: (versionAcceptance[versionHistory.indexWhere((v) => v["id"] == selectedVersionId)] ?? false) 
                                  ? "Accepted" : "Accept Version",
                                onPressed: (versionAcceptance[versionHistory.indexWhere((v) => v["id"] == selectedVersionId)] ?? false) 
                                  ? null : () {
                                    int index = versionHistory.indexWhere((v) => v["id"] == selectedVersionId);
                                    versionAcceptance[index] = true;
                                    setState(() {});
                                    ss("Terms Version ${selectedVersion["version"]} accepted");
                                  },
                              ),
                            ),
                        ],
                      ),

                      if ((versionAcceptance[versionHistory.indexWhere((v) => v["status"] == "current")] ?? false))
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
                                size: 32,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Current Terms Accepted",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "You have accepted the current terms and can continue using our services",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              QButton(
                                label: "Continue to Application",
                                onPressed: () {
                                  ss("Terms accepted - proceeding to application");
                                },
                              ),
                            ],
                          ),
                        ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Current Version",
                          onPressed: () {
                            selectedVersionId = versionHistory.firstWhere((v) => v["status"] == "current")["id"];
                            setState(() {});
                          },
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
    );
  }
}
