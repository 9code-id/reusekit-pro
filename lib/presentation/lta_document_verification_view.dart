import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDocumentVerificationView extends StatefulWidget {
  const LtaDocumentVerificationView({super.key});

  @override
  State<LtaDocumentVerificationView> createState() => _LtaDocumentVerificationViewState();
}

class _LtaDocumentVerificationViewState extends State<LtaDocumentVerificationView> {
  List<Map<String, dynamic>> verificationSteps = [
    {
      "title": "Document Upload",
      "description": "Upload required documents",
      "status": "completed",
      "icon": Icons.upload_file,
      "time": "2 minutes ago",
    },
    {
      "title": "Identity Verification",
      "description": "Verify your identity documents",
      "status": "in_progress",
      "icon": Icons.person_search,
      "time": "Processing...",
    },
    {
      "title": "Background Check",
      "description": "Background verification in progress",
      "status": "pending",
      "icon": Icons.security,
      "time": "Pending",
    },
    {
      "title": "Final Approval",
      "description": "Final review and approval",
      "status": "pending",
      "icon": Icons.verified_user,
      "time": "Pending",
    },
  ];

  List<Map<String, dynamic>> uploadedDocuments = [
    {
      "name": "Driver License",
      "type": "Identity Document",
      "status": "verified",
      "uploadDate": "2024-01-15",
      "size": "2.5 MB",
      "icon": Icons.credit_card,
    },
    {
      "name": "Vehicle Registration",
      "type": "Vehicle Document",
      "status": "verified",
      "uploadDate": "2024-01-15",
      "size": "1.8 MB",
      "icon": Icons.directions_car,
    },
    {
      "name": "Insurance Certificate",
      "type": "Insurance Document",
      "status": "verified",
      "uploadDate": "2024-01-15",
      "size": "3.2 MB",
      "icon": Icons.shield,
    },
    {
      "name": "Background Check",
      "type": "Background Verification",
      "status": "pending",
      "uploadDate": "2024-01-15",
      "size": "4.1 MB",
      "icon": Icons.assignment,
    },
  ];

  List<Map<String, dynamic>> requirementChecklist = [
    {
      "requirement": "Valid Driver License",
      "status": true,
      "description": "Government issued driver license",
    },
    {
      "requirement": "Vehicle Registration",
      "status": true,
      "description": "Current vehicle registration certificate",
    },
    {
      "requirement": "Insurance Certificate",
      "status": true,
      "description": "Comprehensive vehicle insurance",
    },
    {
      "requirement": "Background Check",
      "status": false,
      "description": "Clean criminal background check",
    },
    {
      "requirement": "Photo Verification",
      "status": true,
      "description": "Clear profile photo matching ID",
    },
    {
      "requirement": "Vehicle Inspection",
      "status": false,
      "description": "Vehicle safety inspection report",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.verified_user,
                    size: 60,
                    color: Colors.white,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Verification in Progress",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "Your documents are being reviewed by our team",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "Estimated completion: 24-48 hours",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Verification Steps
            Text(
              "Verification Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Column(
              spacing: spSm,
              children: verificationSteps.map((step) {
                Color statusColor = step["status"] == "completed" 
                    ? successColor 
                    : step["status"] == "in_progress" 
                        ? warningColor 
                        : disabledBoldColor;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: step["status"] == "in_progress" 
                          ? warningColor.withAlpha(100) 
                          : disabledOutlineBorderColor,
                      width: step["status"] == "in_progress" ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          step["icon"] as IconData,
                          size: 28,
                          color: statusColor,
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${step["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${step["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${step["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      if (step["status"] == "completed")
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        )
                      else if (step["status"] == "in_progress")
                        Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                          ),
                        )
                      else
                        Icon(
                          Icons.schedule,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Uploaded Documents
            Text(
              "Uploaded Documents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: uploadedDocuments.map((doc) {
                Color statusColor = doc["status"] == "verified" 
                    ? successColor 
                    : doc["status"] == "pending" 
                        ? warningColor 
                        : dangerColor;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              doc["icon"] as IconData,
                              size: 20,
                              color: statusColor,
                            ),
                          ),
                          
                          Spacer(),
                          
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              doc["status"] == "verified" ? "Verified" : "Pending",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "${doc["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Text(
                        "${doc["type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${doc["uploadDate"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          Spacer(),
                          
                          Text(
                            "${doc["size"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Requirements Checklist
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification Checklist",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Column(
                    spacing: spSm,
                    children: requirementChecklist.map((item) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: item["status"] 
                              ? successColor.withAlpha(10) 
                              : warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: item["status"] 
                                ? successColor.withAlpha(50) 
                                : warningColor.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item["status"] ? Icons.check_circle : Icons.schedule,
                              size: 20,
                              color: item["status"] ? successColor : warningColor,
                            ),
                            
                            SizedBox(width: spMd),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["requirement"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  
                                  Text(
                                    "${item["description"]}",
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
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Upload More Documents",
                    size: bs.md,
                    icon: Icons.upload,
                    onPressed: () {
                      // Handle upload more documents
                      si("You can upload additional documents if needed");
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Contact Support",
                    size: bs.md,
                    icon: Icons.support_agent,
                    onPressed: () {
                      // Handle contact support
                      si("Support team contacted successfully");
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Help Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Verification Process Information:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• Document review takes 24-48 hours", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Text("• Background check may take 3-5 business days", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Text("• You'll receive email updates on progress", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Text("• Contact support for urgent matters", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Support: support@logitrans.com | +1 (555) 123-4567",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
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
