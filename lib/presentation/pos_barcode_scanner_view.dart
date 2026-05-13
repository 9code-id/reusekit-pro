import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosBarcodeScannerView extends StatefulWidget {
  const PosBarcodeScannerView({super.key});

  @override
  State<PosBarcodeScannerView> createState() => _PosBarcodeScannerViewState();
}

class _PosBarcodeScannerViewState extends State<PosBarcodeScannerView> {
  String scannedBarcode = "";
  String manualBarcode = "";
  bool isScanning = false;
  bool isCameraActive = true;
  bool continuousScanning = false;
  bool playSound = true;
  bool vibrate = true;
  Map<String, dynamic>? foundProduct;
  List<Map<String, dynamic>> scanHistory = [];
  int successfulScans = 0;
  int failedScans = 0;

  final List<Map<String, dynamic>> recentScans = [
    {
      "barcode": "123456789012",
      "product": "Premium Coffee Beans",
      "price": 24.99,
      "timestamp": "14:35:22",
      "status": "success",
    },
    {
      "barcode": "123456789013",
      "product": "Wireless Headphones",
      "price": 89.99,
      "timestamp": "14:33:15",
      "status": "success",
    },
    {
      "barcode": "123456789999",
      "product": "Unknown Product",
      "price": 0.0,
      "timestamp": "14:30:08",
      "status": "failed",
    },
    {
      "barcode": "123456789014",
      "product": "Cotton T-Shirt",
      "price": 19.99,
      "timestamp": "14:28:45",
      "status": "success",
    },
  ];

  final Map<String, Map<String, dynamic>> productDatabase = {
    "123456789012": {
      "id": 1,
      "name": "Premium Coffee Beans",
      "price": 24.99,
      "stock": 150,
      "category": "Food & Beverage",
      "image": "https://picsum.photos/200/200?random=1&keyword=coffee",
      "description": "Premium arabica coffee beans from Colombia",
    },
    "123456789013": {
      "id": 2,
      "name": "Wireless Headphones",
      "price": 89.99,
      "stock": 75,
      "category": "Electronics",
      "image": "https://picsum.photos/200/200?random=2&keyword=headphones",
      "description": "Bluetooth wireless headphones with noise cancellation",
    },
    "123456789014": {
      "id": 3,
      "name": "Cotton T-Shirt",
      "price": 19.99,
      "stock": 200,
      "category": "Clothing",
      "image": "https://picsum.photos/200/200?random=3&keyword=tshirt",
      "description": "100% cotton comfortable t-shirt",
    },
    "123456789015": {
      "id": 4,
      "name": "Hand Sanitizer",
      "price": 5.99,
      "stock": 500,
      "category": "Health & Beauty",
      "image": "https://picsum.photos/200/200?random=4&keyword=sanitizer",
      "description": "Alcohol-based hand sanitizer 70% alcohol",
    },
    "123456789016": {
      "id": 5,
      "name": "Indoor Plant Pot",
      "price": 12.99,
      "stock": 80,
      "category": "Home & Garden",
      "image": "https://picsum.photos/200/200?random=5&keyword=plant",
      "description": "Ceramic plant pot for indoor plants",
    },
  };

  @override
  void initState() {
    super.initState();
    scanHistory = List.from(recentScans);
    successfulScans = scanHistory.where((scan) => scan["status"] == "success").length;
    failedScans = scanHistory.where((scan) => scan["status"] == "failed").length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
        actions: [
          QButton(
            icon: isCameraActive ? Icons.videocam : Icons.videocam_off,
            size: bs.sm,
            onPressed: _toggleCamera,
          ),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: _showSettings,
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Camera and Scanner
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Camera View
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isScanning ? primaryColor : Colors.grey[300]!,
                        width: isScanning ? 3 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Camera Preview Placeholder
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: isCameraActive ? Colors.black : Colors.grey[800],
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: isCameraActive ? 
                            Stack(
                              children: [
                                // Scanner Overlay
                                Center(
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isScanning ? Colors.green : Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                  ),
                                ),
                                
                                // Scanning Line Animation
                                if (isScanning)
                                  Center(
                                    child: Container(
                                      width: 250,
                                      height: 2,
                                      color: Colors.green,
                                    ),
                                  ),

                                // Corner Guides
                                Positioned(
                                  top: 100,
                                  left: 100,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.white, width: 3),
                                        left: BorderSide(color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  right: 100,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.white, width: 3),
                                        right: BorderSide(color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 100,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white, width: 3),
                                        left: BorderSide(color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 100,
                                  right: 100,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white, width: 3),
                                        right: BorderSide(color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ) :
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.videocam_off,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: spMd),
                                  Text(
                                    "Camera is off",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),

                        // Status Overlay
                        if (isScanning)
                          Positioned(
                            top: spMd,
                            left: spMd,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(217),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Scanning...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Scanner Controls
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        // Scan Button
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: isScanning ? "Stop Scanning" : "Start Scanning",
                            size: bs.md,
                            onPressed: _toggleScanning,
                          ),
                        ),

                        // Manual Entry
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Enter Barcode Manually",
                                value: manualBarcode,
                                hint: "123456789012",
                                onChanged: (value) {
                                  manualBarcode = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            QButton(
                              label: "Search",
                              size: bs.sm,
                              onPressed: () => _searchBarcode(manualBarcode),
                            ),
                          ],
                        ),

                        // Scanner Settings
                        Row(
                          children: [
                            Expanded(
                              child: QSwitch(
                                items: [
                                  {
                                    "label": "Continuous Scanning",
                                    "value": true,
                                    "checked": continuousScanning,
                                  }
                                ],
                                value: continuousScanning ? [{"label": "Continuous Scanning", "value": true, "checked": true}] : [],
                                onChanged: (values, ids) {
                                  continuousScanning = values.isNotEmpty;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Statistics
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "Successful Scans",
                            "$successfulScans",
                            Icons.check_circle,
                            Colors.green,
                          ),
                        ),
                        Expanded(
                          child: _buildStatCard(
                            "Failed Scans",
                            "$failedScans",
                            Icons.error,
                            Colors.red,
                          ),
                        ),
                        Expanded(
                          child: _buildStatCard(
                            "Total Scans",
                            "${scanHistory.length}",
                            Icons.qr_code,
                            Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Panel - Results and History
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Results Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Scan Results",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Current Result
                if (foundProduct != null)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: _buildProductResult(foundProduct!),
                  ),

                // Scan History
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Scan History",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: _clearHistory,
                              child: Text(
                                "Clear All",
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: scanHistory.isEmpty ?
                          Container(
                            padding: EdgeInsets.all(spLg),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 60,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(height: spMd),
                                  Text(
                                    "No scan history",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) :
                          SingleChildScrollView(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              children: scanHistory.map((scan) => _buildHistoryItem(scan)).toList(),
                            ),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductResult(Map<String, dynamic> product) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green[600],
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Product Found",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${product["image"]}",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${product["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${(product["price"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Add to Cart",
                size: bs.sm,
                onPressed: () => _addToCart(product),
              ),
            ),
            Expanded(
              child: QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () => _viewProductDetails(product),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> scan) {
    bool isSuccess = scan["status"] == "success";
    Color statusColor = isSuccess ? Colors.green : Colors.red;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 3,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: statusColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${scan["barcode"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              Text(
                "${scan["timestamp"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${scan["product"]}",
            style: TextStyle(
              fontSize: 12,
              color: isSuccess ? primaryColor : Colors.red[600],
            ),
          ),
          if (isSuccess)
            Text(
              "\$${(scan["price"] as double).toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }

  void _toggleCamera() {
    isCameraActive = !isCameraActive;
    if (!isCameraActive) {
      isScanning = false;
    }
    setState(() {});
    ss(isCameraActive ? "Camera activated" : "Camera deactivated");
  }

  void _toggleScanning() {
    if (!isCameraActive) {
      se("Please activate camera first");
      return;
    }

    isScanning = !isScanning;
    setState(() {});

    if (isScanning) {
      ss("Scanning started");
      _simulateScanning();
    } else {
      ss("Scanning stopped");
    }
  }

  void _simulateScanning() async {
    if (!isScanning) return;

    await Future.delayed(Duration(seconds: 2));
    
    if (isScanning) {
      // Simulate finding a barcode
      List<String> barcodes = productDatabase.keys.toList();
      barcodes.add("123456789999"); // Add an unknown barcode for testing
      
      String randomBarcode = barcodes[DateTime.now().millisecond % barcodes.length];
      _searchBarcode(randomBarcode);
      
      if (!continuousScanning) {
        isScanning = false;
        setState(() {});
      } else {
        _simulateScanning(); // Continue scanning
      }
    }
  }

  void _searchBarcode(String barcode) {
    if (barcode.isEmpty) {
      se("Please enter a barcode");
      return;
    }

    scannedBarcode = barcode;
    
    if (productDatabase.containsKey(barcode)) {
      foundProduct = productDatabase[barcode];
      _addToScanHistory(barcode, foundProduct!["name"], foundProduct!["price"], "success");
      successfulScans++;
      
      if (playSound) {
        // Play success sound
      }
      if (vibrate) {
        // Vibrate device
      }
      
      ss("Product found: ${foundProduct!["name"]}");
    } else {
      foundProduct = null;
      _addToScanHistory(barcode, "Unknown Product", 0.0, "failed");
      failedScans++;
      
      se("Product not found");
    }
    
    manualBarcode = "";
    setState(() {});
  }

  void _addToScanHistory(String barcode, String productName, double price, String status) {
    Map<String, dynamic> scanEntry = {
      "barcode": barcode,
      "product": productName,
      "price": price,
      "timestamp": DateTime.now().toString().substring(11, 19),
      "status": status,
    };
    
    scanHistory.insert(0, scanEntry);
    if (scanHistory.length > 50) {
      scanHistory.removeLast();
    }
  }

  void _addToCart(Map<String, dynamic> product) {
    ss("${product["name"]} added to cart");
  }

  void _viewProductDetails(Map<String, dynamic> product) {
    ss("Viewing details for ${product["name"]}");
  }

  void _clearHistory() async {
    bool isConfirmed = await confirm("Clear all scan history?");
    if (isConfirmed) {
      scanHistory.clear();
      successfulScans = 0;
      failedScans = 0;
      setState(() {});
      ss("Scan history cleared");
    }
  }

  void _showSettings() {
    // This would typically open a settings dialog
    ss("Scanner settings opened");
  }
}
