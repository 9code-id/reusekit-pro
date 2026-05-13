import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaDocumentUploadView extends StatefulWidget {
  const BfaDocumentUploadView({super.key});

  @override
  State<BfaDocumentUploadView> createState() => _BfaDocumentUploadViewState();
}

class _BfaDocumentUploadViewState extends State<BfaDocumentUploadView> {
  List<String> uploadedImages = [];
  bool loading = false;
  String selectedDocumentType = "aadhar";

  List<Map<String, dynamic>> documentTypes = [
    {
      "label": "Aadhar Card",
      "value": "aadhar",
      "icon": Icons.credit_card,
      "color": primaryColor,
      "description": "Upload both front and back of Aadhar card",
      "required": true,
    },
    {
      "label": "PAN Card",
      "value": "pan",
      "icon": Icons.credit_card,
      "color": successColor,
      "description": "Upload clear image of PAN card",
      "required": true,
    },
    {
      "label": "Passport",
      "value": "passport",
      "icon": Icons.book,
      "color": infoColor,
      "description": "Upload passport first page",
      "required": false,
    },
    {
      "label": "Driving License",
      "value": "license",
      "icon": Icons.drive_eta,
      "color": warningColor,
      "description": "Upload both front and back",
      "required": false,
    },
    {
      "label": "Bank Statement",
      "value": "statement",
      "icon": Icons.description,
      "color": primaryColor,
      "description": "Upload last 3 months statement",
      "required": true,
    },
    {
      "label": "Salary Slip",
      "value": "salary",
      "icon": Icons.receipt,
      "color": successColor,
      "description": "Upload latest salary slip",
      "required": false,
    },
  ];

  List<Map<String, dynamic>> uploadedDocuments = [];

  Future<void> _uploadDocument() async {
    loading = true;
    setState(() {});

    // Simulate image upload
    await Future.delayed(Duration(seconds: 2));

    final selectedDoc = documentTypes.firstWhere((doc) => doc["value"] == selectedDocumentType);
    
    uploadedDocuments.add({
      "type": selectedDocumentType,
      "name": selectedDoc["label"],
      "images": List.from(uploadedImages),
      "timestamp": DateTime.now(),
      "status": "uploaded", // uploaded, processing, verified, rejected
    });

    uploadedImages.clear();
    loading = false;
    setState(() {});

    ss("${selectedDoc["label"]} uploaded successfully");
  }

  Future<void> _removeDocument(int index) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this document?");
    if (isConfirmed) {
      uploadedDocuments.removeAt(index);
      setState(() {});
      si("Document removed");
    }
  }

  void _reuploadDocument(int index) {
    final doc = uploadedDocuments[index];
    selectedDocumentType = doc["type"];
    uploadedImages = List.from(doc["images"]);
    uploadedDocuments.removeAt(index);
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "uploaded":
        return infoColor;
      case "processing":
        return warningColor;
      case "verified":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "uploaded":
        return Icons.cloud_upload;
      case "processing":
        return Icons.sync;
      case "verified":
        return Icons.verified;
      case "rejected":
        return Icons.error;
      default:
        return Icons.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDoc = documentTypes.firstWhere((doc) => doc["value"] == selectedDocumentType);
    final requiredDocs = documentTypes.where((doc) => doc["required"] as bool).toList();
    final uploadedRequiredCount = uploadedDocuments
        .where((doc) => requiredDocs.any((req) => req["value"] == doc["type"]))
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Document Upload"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: uploadedRequiredCount == requiredDocs.length ? successColor : warningColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "$uploadedRequiredCount/${requiredDocs.length} Required",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.upload_file,
                    color: primaryColor,
                    size: 40,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Documents",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Upload clear, readable images of your documents for verification",
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
            ),

            SizedBox(height: spXl),

            // Document Type Selection
            Text(
              "Select Document Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: documentTypes.map((docType) {
                bool isSelected = selectedDocumentType == docType["value"];
                bool isRequired = docType["required"] as bool;
                bool isUploaded = uploadedDocuments.any((doc) => doc["type"] == docType["value"]);

                return GestureDetector(
                  onTap: () {
                    selectedDocumentType = docType["value"] as String;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? (docType["color"] as Color).withAlpha(10) : Colors.white,
                      border: Border.all(
                        color: isSelected 
                            ? (docType["color"] as Color) 
                            : isUploaded 
                                ? successColor 
                                : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: docType["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                docType["icon"] as IconData,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            if (isUploaded)
                              Positioned(
                                top: -5,
                                right: -5,
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
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: spSm),

                        Text(
                          "${docType["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),

                        if (isRequired)
                          Container(
                            margin: EdgeInsets.only(top: spXs),
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXxs),
                            ),
                            child: Text(
                              "REQUIRED",
                              style: TextStyle(
                                fontSize: 8,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spXl),

            // Selected Document Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: (selectedDoc["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: (selectedDoc["color"] as Color).withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedDoc["icon"] as IconData,
                    color: selectedDoc["color"] as Color,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedDoc["label"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: selectedDoc["color"] as Color,
                          ),
                        ),
                        Text(
                          "${selectedDoc["description"]}",
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
            ),

            SizedBox(height: spMd),

            // Image Upload Section
            QMultiImagePicker(
              label: "Upload ${selectedDoc["label"]}",
              value: uploadedImages,
              maxImages: selectedDocumentType == "aadhar" || selectedDocumentType == "license" ? 2 : 1,
              hint: "Select images to upload",
              validator: (images) {
                if (images == null || images.isEmpty) {
                  return "Please select at least one image";
                }
                return null;
              },
              onChanged: (value) {
                uploadedImages = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Upload Button
            if (uploadedImages.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Uploading..." : "Upload Document",
                  size: bs.md,
                  onPressed: loading ? null : _uploadDocument,
                ),
              ),

            SizedBox(height: sp2xl),

            // Uploaded Documents List
            if (uploadedDocuments.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "Uploaded Documents",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${uploadedDocuments.length} Documents",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              ...uploadedDocuments.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> doc = entry.value;
                List<String> docImages = doc["images"] as List<String>;
                String status = doc["status"] as String;
                Color statusColor = _getStatusColor(status);

                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: statusColor),
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
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
                                    "${doc["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        _getStatusIcon(status),
                                        color: statusColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        status.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton(
                              icon: Icon(Icons.more_vert, color: disabledBoldColor),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'reupload',
                                  child: Row(
                                    children: [
                                      Icon(Icons.refresh, color: primaryColor, size: 18),
                                      SizedBox(width: spSm),
                                      Text("Re-upload"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'remove',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: dangerColor, size: 18),
                                      SizedBox(width: spSm),
                                      Text("Remove"),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'reupload') {
                                  _reuploadDocument(index);
                                } else if (value == 'remove') {
                                  _removeDocument(index);
                                }
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Document Images
                        QHorizontalScroll(
                          children: docImages.map((imageUrl) {
                            return Container(
                              width: 100,
                              height: 80,
                              margin: EdgeInsets.only(right: spSm),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                boxShadow: [shadowSm],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: spSm),

                        Text(
                          "Uploaded on ${(doc["timestamp"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],

            SizedBox(height: sp2xl),

            // Document Guidelines
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upload Guidelines",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "• Ensure all text is clearly visible and readable\n"
                    "• Document should be well-lit without shadows\n"
                    "• All four corners of the document should be visible\n"
                    "• Image should be in focus and not blurry\n"
                    "• File size should be less than 5MB per image\n"
                    "• Supported formats: JPG, PNG, PDF",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Continue Button
            if (uploadedRequiredCount == requiredDocs.length)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue to Verification",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(BfaIdentityVerificationView());
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
