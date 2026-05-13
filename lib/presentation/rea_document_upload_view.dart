import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaDocumentUploadView extends StatefulWidget {
  const ReaDocumentUploadView({super.key});

  @override
  State<ReaDocumentUploadView> createState() => _ReaDocumentUploadViewState();
}

class _ReaDocumentUploadViewState extends State<ReaDocumentUploadView> {
  bool isUploading = false;
  
  Map<String, List<String>> uploadedDocuments = {
    "identity": [],
    "income": [],
    "property": [],
    "bank": [],
    "additional": [],
  };

  List<Map<String, dynamic>> documentCategories = [
    {
      "id": "identity",
      "title": "Identity Documents",
      "description": "Government issued photo identification",
      "icon": Icons.person,
      "color": primaryColor,
      "required": true,
      "documents": [
        {"name": "Passport", "required": false, "uploaded": false},
        {"name": "Driver's License", "required": true, "uploaded": false},
        {"name": "National ID", "required": false, "uploaded": false},
        {"name": "Social Security Card", "required": true, "uploaded": false},
      ]
    },
    {
      "id": "income",
      "title": "Income Documents",
      "description": "Proof of income and employment",
      "icon": Icons.work,
      "color": successColor,
      "required": true,
      "documents": [
        {"name": "Pay Stubs (Last 3 months)", "required": true, "uploaded": false},
        {"name": "Employment Letter", "required": true, "uploaded": false},
        {"name": "Tax Returns (Last 2 years)", "required": true, "uploaded": false},
        {"name": "Bank Statements (Last 6 months)", "required": true, "uploaded": false},
        {"name": "W-2 Forms", "required": false, "uploaded": false},
      ]
    },
    {
      "id": "property",
      "title": "Property Documents",
      "description": "Property related documentation",
      "icon": Icons.home,
      "color": infoColor,
      "required": true,
      "documents": [
        {"name": "Property Agreement", "required": true, "uploaded": false},
        {"name": "Property Valuation Report", "required": true, "uploaded": false},
        {"name": "Title Documents", "required": true, "uploaded": false},
        {"name": "Property Insurance", "required": false, "uploaded": false},
        {"name": "Property Photos", "required": false, "uploaded": false},
      ]
    },
    {
      "id": "bank",
      "title": "Banking Documents",
      "description": "Bank statements and financial records",
      "icon": Icons.account_balance,
      "color": warningColor,
      "required": true,
      "documents": [
        {"name": "Bank Statements (Last 6 months)", "required": true, "uploaded": false},
        {"name": "Credit Report", "required": true, "uploaded": false},
        {"name": "Investment Statements", "required": false, "uploaded": false},
        {"name": "Existing Loan Documents", "required": false, "uploaded": false},
      ]
    },
    {
      "id": "additional",
      "title": "Additional Documents",
      "description": "Supporting documents",
      "icon": Icons.folder,
      "color": dangerColor,
      "required": false,
      "documents": [
        {"name": "Character Certificate", "required": false, "uploaded": false},
        {"name": "Reference Letters", "required": false, "uploaded": false},
        {"name": "Business Registration", "required": false, "uploaded": false},
        {"name": "Partnership Deed", "required": false, "uploaded": false},
      ]
    },
  ];

  int get totalRequiredDocuments {
    int count = 0;
    for (var category in documentCategories) {
      if (category["required"] as bool) {
        count += (category["documents"] as List).where((doc) => doc["required"] as bool).length;
      }
    }
    return count;
  }

  int get uploadedRequiredDocuments {
    int count = 0;
    for (var category in documentCategories) {
      if (category["required"] as bool) {
        count += (category["documents"] as List).where((doc) => 
          (doc["required"] as bool) && (doc["uploaded"] as bool)).length;
      }
    }
    return count;
  }

  double get completionPercentage {
    if (totalRequiredDocuments == 0) return 0;
    return uploadedRequiredDocuments / totalRequiredDocuments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Upload"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upload Required Documents",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Secure document upload for loan processing",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Progress: $uploadedRequiredDocuments of $totalRequiredDocuments required documents",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: completionPercentage,
                    backgroundColor: Colors.white.withAlpha(100),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${(completionPercentage * 100).toStringAsFixed(0)}% Complete",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Upload Instructions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upload Guidelines",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Ensure documents are clear and readable\n"
                    "• Accepted formats: PDF, JPG, PNG\n"
                    "• Maximum file size: 10MB per document\n"
                    "• All pages of multi-page documents must be included",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Document Categories
            Text(
              "Document Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ...documentCategories.map((category) {
              Color categoryColor = category["color"] as Color;
              bool isRequired = category["required"] as bool;
              List<Map<String, dynamic>> documents = category["documents"] as List<Map<String, dynamic>>;
              int uploadedInCategory = documents.where((doc) => doc["uploaded"] as bool).length;
              int requiredInCategory = documents.where((doc) => doc["required"] as bool).length;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isRequired 
                    ? Border.all(color: categoryColor.withAlpha(100))
                    : null,
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      category["icon"] as IconData,
                      color: categoryColor,
                      size: 24,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${category["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isRequired)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "REQUIRED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Text(
                    "$uploadedInCategory of ${documents.length} documents uploaded" +
                    (isRequired ? " • $requiredInCategory required" : ""),
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: documents.map((document) {
                          bool isDocRequired = document["required"] as bool;
                          bool isUploaded = document["uploaded"] as bool;
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isUploaded 
                                ? successColor.withAlpha(20)
                                : isDocRequired 
                                  ? dangerColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isUploaded 
                                  ? successColor.withAlpha(100)
                                  : isDocRequired 
                                    ? dangerColor.withAlpha(100)
                                    : disabledColor.withAlpha(100),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isUploaded 
                                    ? Icons.check_circle
                                    : isDocRequired 
                                      ? Icons.warning
                                      : Icons.description,
                                  color: isUploaded 
                                    ? successColor
                                    : isDocRequired 
                                      ? dangerColor
                                      : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${document["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        isUploaded 
                                          ? "Uploaded successfully"
                                          : isDocRequired 
                                            ? "Required document"
                                            : "Optional document",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isUploaded 
                                            ? successColor
                                            : isDocRequired 
                                              ? dangerColor
                                              : disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!isUploaded)
                                  QButton(
                                    label: "Upload",
                                    size: bs.sm,
                                    onPressed: () => _uploadDocument(category["id"], document["name"]),
                                  )
                                else
                                  Row(
                                    children: [
                                      QButton(
                                        icon: Icons.visibility,
                                        size: bs.sm,
                                        onPressed: () => _viewDocument(category["id"], document["name"]),
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.delete,
                                        size: bs.sm,
                                        onPressed: () => _deleteDocument(category["id"], document["name"]),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spLg),
            
            // Action Buttons
            if (completionPercentage >= 1.0) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "All required documents uploaded successfully!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Submit for Review",
                        size: bs.md,
                        onPressed: _submitDocuments,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Please upload all required documents to proceed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Save as Draft",
                        size: bs.sm,
                        onPressed: _saveDraft,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spLg),
            
            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "If you have trouble uploading documents or need assistance, please contact our support team.",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Guide",
                          size: bs.sm,
                          onPressed: () {},
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

  void _uploadDocument(String categoryId, String documentName) async {
    // Simulate document upload
    isUploading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    // Find and update the document
    for (var category in documentCategories) {
      if (category["id"] == categoryId) {
        var documents = category["documents"] as List<Map<String, dynamic>>;
        var document = documents.firstWhere((doc) => doc["name"] == documentName);
        document["uploaded"] = true;
        break;
      }
    }
    
    isUploading = false;
    setState(() {});
    
    ss("Document uploaded successfully!");
  }

  void _viewDocument(String categoryId, String documentName) {
    // Implementation for viewing document
    si("Viewing $documentName");
  }

  void _deleteDocument(String categoryId, String documentName) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this document?");
    if (isConfirmed) {
      // Find and update the document
      for (var category in documentCategories) {
        if (category["id"] == categoryId) {
          var documents = category["documents"] as List<Map<String, dynamic>>;
          var document = documents.firstWhere((doc) => doc["name"] == documentName);
          document["uploaded"] = false;
          break;
        }
      }
      setState(() {});
      si("Document deleted successfully");
    }
  }

  void _submitDocuments() async {
    isUploading = true;
    setState(() {});
    
    // Simulate submission
    await Future.delayed(Duration(seconds: 3));
    
    isUploading = false;
    setState(() {});
    
    ss("Documents submitted for review!");
    back();
  }

  void _saveDraft() {
    si("Documents saved as draft");
  }

  void _showHelpDialog() {
    // Implementation for help dialog
  }
}
