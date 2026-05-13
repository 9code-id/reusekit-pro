import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlScanner2View extends StatefulWidget {
  @override
  State<GrlScanner2View> createState() => _GrlScanner2ViewState();
}

class _GrlScanner2ViewState extends State<GrlScanner2View> {
  bool isScanningActive = false;
  String selectedDocumentType = "Business Card";
  bool autoCapture = true;
  bool enhanceImage = true;
  double confidenceThreshold = 85.0;
  
  List<String> documentTypes = [
    "Business Card", "Receipt", "Invoice", "ID Card", "Passport", 
    "License", "Document", "Text", "Handwriting"
  ];
  
  List<Map<String, dynamic>> scanResults = [
    {
      "type": "Business Card",
      "title": "John Smith - Marketing Director",
      "content": {
        "name": "John Smith",
        "title": "Marketing Director",
        "company": "Tech Solutions Inc.",
        "email": "john.smith@techsolutions.com",
        "phone": "+1 (555) 123-4567",
        "address": "123 Tech Street, Silicon Valley, CA 94105"
      },
      "confidence": 92,
      "timestamp": "2024-06-22 11:30:00",
      "thumbnail": "https://picsum.photos/100/60?random=1"
    },
    {
      "type": "Receipt",
      "title": "Coffee Shop Receipt",
      "content": {
        "merchant": "Central Coffee",
        "date": "2024-06-22",
        "time": "09:15:00",
        "items": [
          {"name": "Latte", "price": 4.50},
          {"name": "Croissant", "price": 3.25}
        ],
        "subtotal": 7.75,
        "tax": 0.62,
        "total": 8.37,
        "payment": "Credit Card"
      },
      "confidence": 89,
      "timestamp": "2024-06-22 09:20:00",
      "thumbnail": "https://picsum.photos/100/60?random=2"
    },
    {
      "type": "Document",
      "title": "Meeting Notes",
      "content": {
        "text": "Project kick-off meeting scheduled for next Monday at 2:00 PM. Key stakeholders: Sarah Johnson, Mike Chen, Lisa Wang. Agenda items: project timeline, resource allocation, milestone review."
      },
      "confidence": 76,
      "timestamp": "2024-06-21 15:45:00",
      "thumbnail": "https://picsum.photos/100/60?random=3"
    }
  ];
  
  List<Map<String, dynamic>> scanSettings = [
    {"name": "Auto Capture", "enabled": true, "description": "Automatically capture when document is detected"},
    {"name": "Image Enhancement", "enabled": true, "description": "Improve image quality for better recognition"},
    {"name": "Multi-language", "enabled": false, "description": "Detect text in multiple languages"},
    {"name": "Real-time Preview", "enabled": true, "description": "Show live text recognition preview"}
  ];
  
  int selectedResult = 0;
  bool showCameraPreview = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Scanner"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () => _scanFromGallery(),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _showScanHistory(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showScannerSettings(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Document type selector
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: QCategoryPicker(
              label: "Document Type",
              items: documentTypes.map((type) => {
                "label": type,
                "value": type,
              }).toList(),
              value: selectedDocumentType,
              onChanged: (index, label, value, item) {
                selectedDocumentType = value;
                setState(() {});
              },
            ),
          ),

          // Camera preview or scanner area
          Expanded(
            flex: showCameraPreview ? 3 : 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: showCameraPreview 
                ? _buildCameraPreview()
                : _buildScannerPlaceholder(),
            ),
          ),

          // Scan results section
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  // Results header
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Scan Results",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
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
                            "${scanResults.length} scans",
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

                  // Results list
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(spSm),
                      itemCount: scanResults.length,
                      itemBuilder: (context, index) {
                        final result = scanResults[index];
                        bool isSelected = selectedResult == index;
                        
                        return GestureDetector(
                          onTap: () {
                            selectedResult = index;
                            setState(() {});
                            _showResultDetails(result);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [shadowSm],
                            ),
                            child: Row(
                              children: [
                                // Thumbnail
                                Container(
                                  width: 60,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: disabledOutlineBorderColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${result["thumbnail"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spMd),
                                
                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                            decoration: BoxDecoration(
                                              color: _getTypeColor(result["type"]).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${result["type"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getTypeColor(result["type"]),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                            decoration: BoxDecoration(
                                              color: _getConfidenceColor((result["confidence"] as int)).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${result["confidence"]}%",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getConfidenceColor((result["confidence"] as int)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spSm),
                                      Text(
                                        "${result["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${result["timestamp"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Action button
                                QButton(
                                  icon: Icons.arrow_forward_ios,
                                  size: bs.sm,
                                  onPressed: () => _showResultDetails(result),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          if (showCameraPreview) {
            _captureDocument();
          } else {
            showCameraPreview = true;
            isScanningActive = true;
            setState(() {});
          }
        },
        backgroundColor: isScanningActive ? dangerColor : primaryColor,
        child: Icon(
          showCameraPreview ? Icons.camera : Icons.document_scanner,
          color: Colors.white,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            QSwitch(
              items: [
                {
                  "label": "Auto Capture",
                  "value": true,
                  "checked": autoCapture,
                }
              ],
              value: [
                if (autoCapture)
                  {
                    "label": "Auto Capture",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  autoCapture = values.isNotEmpty;
                });
              },
            ),
            Spacer(),
            Text(
              showCameraPreview ? "Position document in frame" : "Tap to start scanning",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: showCameraPreview ? Icons.close : Icons.tune,
              size: bs.sm,
              onPressed: () {
                if (showCameraPreview) {
                  showCameraPreview = false;
                  isScanningActive = false;
                  setState(() {});
                } else {
                  _showScannerSettings();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Camera preview placeholder
          Center(
            child: Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getDocumentIcon(selectedDocumentType),
                          size: 48,
                          color: Colors.white,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Position $selectedDocumentType",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "in the frame",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Document detection overlay
                  if (isScanningActive)
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Stack(
                          children: [
                            // Corner guides
                            ...List.generate(4, (index) {
                              return Positioned(
                                top: index < 2 ? 0 : null,
                                bottom: index >= 2 ? 0 : null,
                                left: index % 2 == 0 ? 0 : null,
                                right: index % 2 == 1 ? 0 : null,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: index < 2 ? BorderSide(color: primaryColor, width: 4) : BorderSide.none,
                                      bottom: index >= 2 ? BorderSide(color: primaryColor, width: 4) : BorderSide.none,
                                      left: index % 2 == 0 ? BorderSide(color: primaryColor, width: 4) : BorderSide.none,
                                      right: index % 2 == 1 ? BorderSide(color: primaryColor, width: 4) : BorderSide.none,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Controls overlay
          Positioned(
            top: spMd,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    selectedDocumentType,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                if (autoCapture)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "AUTO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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

  Widget _buildScannerPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.document_scanner,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "Document Scanner",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Tap the scan button to start",
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                Text(
                  "Scanning Tips:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "• Ensure good lighting\n"
                  "• Keep document flat\n"
                  "• Fill the frame completely\n"
                  "• Avoid shadows and glare",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Business Card":
        return primaryColor;
      case "Receipt":
        return successColor;
      case "Invoice":
        return warningColor;
      case "Document":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConfidenceColor(int confidence) {
    if (confidence >= 85) return successColor;
    if (confidence >= 70) return warningColor;
    return dangerColor;
  }

  IconData _getDocumentIcon(String type) {
    switch (type) {
      case "Business Card":
        return Icons.badge;
      case "Receipt":
        return Icons.receipt;
      case "Invoice":
        return Icons.receipt_long;
      case "ID Card":
        return Icons.perm_identity;
      case "Passport":
        return Icons.flight;
      case "License":
        return Icons.card_membership;
      case "Handwriting":
        return Icons.edit;
      default:
        return Icons.description;
    }
  }

  void _captureDocument() {
    // Simulate document capture and OCR processing
    ss("Document captured and processing...");
    
    Future.delayed(Duration(seconds: 2), () {
      ss("Document processed successfully");
      showCameraPreview = false;
      isScanningActive = false;
      setState(() {});
      
      // Add new scan result
      _addNewScanResult();
    });
  }

  void _addNewScanResult() {
    Map<String, dynamic> newResult = {
      "type": selectedDocumentType,
      "title": "New $selectedDocumentType Scan",
      "content": {"text": "Sample extracted text from $selectedDocumentType"},
      "confidence": 85 + (DateTime.now().millisecond % 15),
      "timestamp": DateTime.now().toString().substring(0, 19),
      "thumbnail": "https://picsum.photos/100/60?random=${scanResults.length + 4}"
    };
    
    scanResults.insert(0, newResult);
    setState(() {});
  }

  void _scanFromGallery() {
    ss("Scanning document from gallery");
  }

  void _showScanHistory() {
    // Show full scan history modal
  }

  void _showScannerSettings() {
    // Show scanner settings modal
  }

  void _showResultDetails(Map<String, dynamic> result) {
    // Show detailed view of scan result
    ss("Opening ${result["title"]}");
  }
}
