import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlScanner10View extends StatefulWidget {
  @override
  State<GrlScanner10View> createState() => _GrlScanner10ViewState();
}

class _GrlScanner10ViewState extends State<GrlScanner10View> {
  List<Map<String, dynamic>> scanResults = [
    {
      "id": "1",
      "content": "https://api.example.com/product/verify/ABC123",
      "isAuthentic": true,
      "confidence": 98.5,
      "productName": "Apple iPhone 15 Pro",
      "manufacturer": "Apple Inc.",
      "batchNumber": "B2024001",
      "manufacturingDate": "2024-10-15",
      "verifiedAt": "2024-12-22 14:30:00",
      "warnings": [],
      "certificate": "ISO-9001-2024"
    },
    {
      "id": "2",
      "content": "COUNTERFEIT:DETECTED:Product appears to be fake",
      "isAuthentic": false,
      "confidence": 94.2,
      "productName": "Nike Air Jordan 1",
      "manufacturer": "Unknown",
      "batchNumber": "INVALID",
      "manufacturingDate": "Unknown",
      "verifiedAt": "2024-12-22 13:45:00",
      "warnings": [
        "Serial number not found in database",
        "Packaging inconsistencies detected",
        "Materials do not match authentic specifications"
      ],
      "certificate": null
    },
    {
      "id": "3",
      "content": "VERIFY:PENDING:Additional verification required",
      "isAuthentic": null,
      "confidence": 67.8,
      "productName": "Rolex Submariner Watch",
      "manufacturer": "Rolex SA",
      "batchNumber": "R2024-SUB-789",
      "manufacturingDate": "2024-09-20",
      "verifiedAt": "2024-12-22 12:15:00",
      "warnings": [
        "Requires manual inspection",
        "Database match uncertain"
      ],
      "certificate": "Pending Authentication"
    }
  ];

  String currentScanContent = "";
  bool isScanning = false;
  bool showAdvancedInfo = false;

  void _startAuthentication() {
    isScanning = true;
    currentScanContent = "";
    setState(() {});

    // Simulate scanning process
    Future.delayed(Duration(seconds: 3), () {
      // Simulate scan result
      currentScanContent = "https://api.example.com/product/verify/XYZ789";
      isScanning = false;
      
      // Add new result
      scanResults.insert(0, {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "content": currentScanContent,
        "isAuthentic": true,
        "confidence": 96.3,
        "productName": "Samsung Galaxy S24 Ultra",
        "manufacturer": "Samsung Electronics",
        "batchNumber": "S2024002",
        "manufacturingDate": "2024-11-10",
        "verifiedAt": DateTime.now().toString(),
        "warnings": [],
        "certificate": "CE-2024-SAMSUNG"
      });
      
      setState(() {});
      ss("Product authentication completed");
    });
  }

  void _reportFake(String itemId) async {
    bool isConfirmed = await confirm("Report this product as counterfeit?");
    if (isConfirmed) {
      ss("Counterfeit report submitted successfully");
    }
  }

  void _requestManualVerification(String itemId) {
    si("Manual verification request submitted. You will be notified within 24 hours.");
  }

  Color _getAuthenticationColor(bool? isAuthentic) {
    if (isAuthentic == null) return warningColor;
    return isAuthentic ? successColor : dangerColor;
  }

  String _getAuthenticationStatus(bool? isAuthentic) {
    if (isAuthentic == null) return "Pending Verification";
    return isAuthentic ? "Authentic" : "Counterfeit Detected";
  }

  IconData _getAuthenticationIcon(bool? isAuthentic) {
    if (isAuthentic == null) return Icons.help_outline;
    return isAuthentic ? Icons.verified : Icons.dangerous;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Authentication"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showAdvancedInfo = !showAdvancedInfo;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Scanner Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: isScanning ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isScanning ? primaryColor : disabledBoldColor,
                        width: 3,
                      ),
                    ),
                    child: isScanning
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: primaryColor),
                              SizedBox(height: spSm),
                              Text(
                                "Authenticating...",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.security,
                                size: 48,
                                color: disabledBoldColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Product\nAuthentication",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                  Text(
                    isScanning 
                        ? "Verifying product authenticity..." 
                        : "Scan product code to verify authenticity",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: isScanning ? "Authenticating..." : "Start Authentication",
                    icon: Icons.security,
                    size: bs.md,
                    onPressed: isScanning ? null : _startAuthentication,
                  ),
                ],
              ),
            ),

            // Authentication Statistics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Authentication Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                Icons.verified,
                                color: successColor,
                                size: 24,
                              ),
                              Text(
                                "${scanResults.where((r) => r["isAuthentic"] == true).length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Authentic",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                Icons.dangerous,
                                color: dangerColor,
                                size: 24,
                              ),
                              Text(
                                "${scanResults.where((r) => r["isAuthentic"] == false).length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Counterfeit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: warningColor,
                                size: 24,
                              ),
                              Text(
                                "${scanResults.where((r) => r["isAuthentic"] == null).length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Authentication Results
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Authentication Results",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${scanResults.length} results",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...scanResults.map((result) {
                    Color statusColor = _getAuthenticationColor(result["isAuthentic"] as bool?);
                    String statusText = _getAuthenticationStatus(result["isAuthentic"] as bool?);
                    IconData statusIcon = _getAuthenticationIcon(result["isAuthentic"] as bool?);
                    bool? isAuthentic = result["isAuthentic"] as bool?;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            statusText,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${(result["confidence"] as double).toStringAsFixed(1)}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${result["productName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "by ${result["manufacturer"]}",
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
                          
                          // Product Details
                          if (showAdvancedInfo)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  if ("${result["batchNumber"]}" != "INVALID")
                                    Row(
                                      children: [
                                        Text(
                                          "Batch:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${result["batchNumber"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontFamily: 'monospace',
                                          ),
                                        ),
                                      ],
                                    ),
                                  if ("${result["manufacturingDate"]}" != "Unknown")
                                    Row(
                                      children: [
                                        Text(
                                          "Manufactured:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${result["manufacturingDate"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (result["certificate"] != null)
                                    Row(
                                      children: [
                                        Text(
                                          "Certificate:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${result["certificate"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          
                          // Warnings
                          if ((result["warnings"] as List).isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Warnings:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                ...(result["warnings"] as List).map((warning) {
                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          size: 12,
                                          color: dangerColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "$warning",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          
                          // Verification Time
                          Text(
                            "Verified: ${result["verifiedAt"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          // Action Buttons  
                          Row(
                            children: [
                              if (isAuthentic == null) ...[
                                Expanded(
                                  child: QButton(
                                    label: "Manual Verify",
                                    size: bs.sm,
                                    onPressed: () => _requestManualVerification("${result["id"]}"),
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ] else if (isAuthentic == false) ...[
                                Expanded(
                                  child: QButton(
                                    label: "Report Fake",
                                    size: bs.sm,
                                    onPressed: () => _reportFake("${result["id"]}"),
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ] else ...[
                                Expanded(
                                  child: QButton(
                                    label: "View Certificate",
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Certificate details will be displayed");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Authentication result shared");
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
