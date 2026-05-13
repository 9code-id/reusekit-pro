import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaQrScannerView extends StatefulWidget {
  const BfaQrScannerView({super.key});

  @override
  State<BfaQrScannerView> createState() => _BfaQrScannerViewState();
}

class _BfaQrScannerViewState extends State<BfaQrScannerView> {
  bool isScanning = true;
  bool flashEnabled = false;
  String scannedData = "";
  
  List<Map<String, dynamic>> recentScans = [
    {
      "type": "Payment",
      "amount": 25000.0,
      "merchant": "Coffee Shop",
      "date": "2024-06-15 10:30",
      "status": "Success"
    },
    {
      "type": "Transfer", 
      "amount": 150000.0,
      "recipient": "John Doe",
      "date": "2024-06-14 16:45",
      "status": "Success"
    },
    {
      "type": "Payment",
      "amount": 75000.0,
      "merchant": "Restaurant",
      "date": "2024-06-14 12:15",
      "status": "Success"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "QR Scanner",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(flashEnabled ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              flashEnabled = !flashEnabled;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Scanner Area
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      color: Colors.black.withAlpha(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          size: 100,
                          color: Colors.white.withAlpha(200),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Position QR code within the frame",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Corner brackets
                  Positioned(
                    top: spMd,
                    left: spMd,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white, width: 3),
                          left: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white, width: 3),
                          right: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white, width: 3),
                          left: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spMd,
                    right: spMd,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white, width: 3),
                          right: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Controls Section
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.photo_library, color: Colors.white),
                        onPressed: () {
                          // Select from gallery
                        },
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isScanning ? Icons.pause : Icons.play_arrow,
                          color: primaryColor,
                          size: 40,
                        ),
                        onPressed: () {
                          isScanning = !isScanning;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      isScanning ? "Pause" : "Scan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.history, color: Colors.white),
                        onPressed: () {
                          _showRecentScans();
                        },
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bottom Info
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Supported: Payment QR, Transfer QR, Merchant QR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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

  void _showRecentScans() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Recent Scans",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Expanded(
              child: ListView.builder(
                itemCount: recentScans.length,
                itemBuilder: (context, index) {
                  final scan = recentScans[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            scan["type"] == "Payment" ? Icons.payment : Icons.send,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${scan["type"]} - ${scan["merchant"] ?? scan["recipient"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${((scan["amount"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${scan["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${scan["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
