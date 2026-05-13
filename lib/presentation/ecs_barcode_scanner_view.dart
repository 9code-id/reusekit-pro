import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsBarcodeScannerView extends StatefulWidget {
  const EcsBarcodeScannerView({super.key});

  @override
  State<EcsBarcodeScannerView> createState() => _EcsBarcodeScannerViewState();
}

class _EcsBarcodeScannerViewState extends State<EcsBarcodeScannerView> {
  bool isScanning = false;
  bool flashOn = false;
  String scannedCode = "";
  String scanResult = "";
  
  List<Map<String, dynamic>> scanHistory = [
    {
      "id": 1,
      "code": "123456789012",
      "product_name": "iPhone 15 Pro Max",
      "product_image": "https://picsum.photos/80/80?random=1&keyword=phone",
      "price": 1199.0,
      "brand": "Apple",
      "category": "Electronics",
      "scanned_at": "2025-06-15T10:30:00Z",
      "is_available": true,
      "stock_level": "in_stock"
    },
    {
      "id": 2,
      "code": "987654321098",
      "product_name": "Nike Air Max 270",
      "product_image": "https://picsum.photos/80/80?random=2&keyword=shoes",
      "price": 129.99,
      "brand": "Nike",
      "category": "Fashion",
      "scanned_at": "2025-06-15T09:15:00Z",
      "is_available": true,
      "stock_level": "low_stock"
    },
    {
      "id": 3,
      "code": "456789123456",
      "product_name": "Samsung Galaxy Watch",
      "product_image": "https://picsum.photos/80/80?random=3&keyword=watch",
      "price": 299.0,
      "brand": "Samsung",
      "category": "Electronics",
      "scanned_at": "2025-06-15T08:45:00Z",
      "is_available": false,
      "stock_level": "out_of_stock"
    },
    {
      "id": 4,
      "code": "789123456789",
      "product_name": "AirPods Pro 2nd Gen",
      "product_image": "https://picsum.photos/80/80?random=4&keyword=headphones",
      "price": 249.0,
      "brand": "Apple",
      "category": "Electronics",
      "scanned_at": "2025-06-14T16:20:00Z",
      "is_available": true,
      "stock_level": "in_stock"
    }
  ];

  void _startScanning() {
    setState(() {
      isScanning = true;
      scanResult = "";
    });
    
    // Simulate scanning process
    Future.delayed(Duration(seconds: 2), () {
      if (mounted && isScanning) {
        _simulateSuccessfulScan();
      }
    });
  }

  void _stopScanning() {
    setState(() {
      isScanning = false;
    });
  }

  void _simulateSuccessfulScan() {
    // Simulate a random barcode scan
    List<String> sampleCodes = [
      "123456789012",
      "987654321098", 
      "555666777888",
      "111222333444"
    ];
    
    String randomCode = sampleCodes[(DateTime.now().millisecond % sampleCodes.length)];
    
    setState(() {
      isScanning = false;
      scannedCode = randomCode;
      scanResult = "Product found!";
    });
    
    _showScanResult(randomCode);
  }

  void _showScanResult(String code) {
    // Find product in history or create new one
    Map<String, dynamic>? product = scanHistory
        .where((item) => item["code"] == code)
        .isNotEmpty 
        ? scanHistory.firstWhere((item) => item["code"] == code)
        : null;
    
    if (product == null) {
      // Create new product for demonstration
      product = {
        "id": scanHistory.length + 1,
        "code": code,
        "product_name": "Unknown Product",
        "product_image": "https://picsum.photos/80/80?random=${scanHistory.length + 1}&keyword=product",
        "price": 99.99,
        "brand": "Unknown",
        "category": "General",
        "scanned_at": DateTime.now().toIso8601String(),
        "is_available": true,
        "stock_level": "in_stock"
      };
      
      setState(() {
        scanHistory.insert(0, product!);
      });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildProductResultSheet(product!),
    );
  }

  Widget _buildProductResultSheet(Map<String, dynamic> product) {
    bool isAvailable = product["is_available"] as bool;
    String stockLevel = product["stock_level"];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spMd),
            
            // Product info
            Row(
              children: [
                // Product image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("${product["product_image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                
                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product["product_name"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${product["brand"]} • ${product["category"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "\$${(product["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: isAvailable 
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isAvailable 
                                    ? successColor.withAlpha(50)
                                    : dangerColor.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              isAvailable ? "Available" : "Out of Stock",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isAvailable ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Barcode info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.qr_code, color: disabledBoldColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Barcode",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${product["code"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Copy to clipboard simulation
                      ss("Barcode copied to clipboard");
                    },
                    child: Icon(Icons.copy, color: primaryColor, size: 20),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add to Cart",
                    size: bs.sm,
                    onPressed: isAvailable ? () {
                      Navigator.pop(context);
                      ss("${product["product_name"]} added to cart");
                    } : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Viewing product details");
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFlash() {
    setState(() {
      flashOn = !flashOn;
    });
    si(flashOn ? "Flash turned on" : "Flash turned off");
  }

  void _clearHistory() async {
    bool confirmed = await confirm("Are you sure you want to clear scan history?");
    if (confirmed) {
      setState(() {
        scanHistory.clear();
      });
      ss("Scan history cleared");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
        actions: [
          QButton(
            icon: Icons.history,
            size: bs.sm,
            onPressed: () {
              _showScanHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Camera Preview Area
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(radiusLg),
                ),
              ),
              child: Stack(
                children: [
                  // Simulated camera view
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey[800]!,
                            Colors.grey[900]!,
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(radiusLg),
                        ),
                      ),
                      child: isScanning
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Scanning animation line
                                      Positioned.fill(
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 1500),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                primaryColor.withAlpha(100),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.qr_code_scanner,
                                              color: primaryColor,
                                              size: 48,
                                            ),
                                            SizedBox(height: spSm),
                                            Text(
                                              "Scanning...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spMd),
                                Text(
                                  "Position barcode within the frame",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white.withAlpha(100),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.qr_code,
                                          color: Colors.white.withAlpha(150),
                                          size: 64,
                                        ),
                                        SizedBox(height: spSm),
                                        Text(
                                          "Tap to scan",
                                          style: TextStyle(
                                            color: Colors.white.withAlpha(200),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (scanResult.isNotEmpty) ...[
                                  SizedBox(height: spMd),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spMd,
                                      vertical: spSm,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          scanResult,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                    ),
                  ),
                  
                  // Flash button
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: GestureDetector(
                      onTap: _toggleFlash,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: flashOn 
                              ? warningColor.withAlpha(200)
                              : Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          flashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Controls Section
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Scan Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isScanning ? "Stop Scanning" : "Start Scanning",
                      icon: isScanning ? Icons.stop : Icons.qr_code_scanner,
                      size: bs.md,
                      onPressed: isScanning ? _stopScanning : _startScanning,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Manual Entry
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Manual Entry",
                          value: scannedCode,
                          hint: "Enter barcode manually",
                          onChanged: (value) {
                            scannedCode = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: scannedCode.isNotEmpty ? () {
                          _showScanResult(scannedCode);
                        } : null,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showScanHistory(),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: infoColor.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: infoColor,
                                  size: 28,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "History",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${scanHistory.length}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            si("Opening gallery to scan from image");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: primaryColor.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.photo,
                                  color: primaryColor,
                                  size: 28,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Scan image",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: GestureDetector(
                          onTap: scanHistory.isNotEmpty ? _clearHistory : null,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: scanHistory.isNotEmpty
                                  ? dangerColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: scanHistory.isNotEmpty
                                    ? dangerColor.withAlpha(50)
                                    : disabledColor.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.clear_all,
                                  color: scanHistory.isNotEmpty
                                      ? dangerColor
                                      : disabledColor,
                                  size: 28,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Clear",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: scanHistory.isNotEmpty
                                        ? dangerColor
                                        : disabledColor,
                                  ),
                                ),
                                Text(
                                  "History",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showScanHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Text(
                    "Scan History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  if (scanHistory.isNotEmpty)
                    GestureDetector(
                      onTap: _clearHistory,
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontSize: 14,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // History List
            Expanded(
              child: scanHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No scan history",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Start scanning to see your history",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      itemCount: scanHistory.length,
                      itemBuilder: (context, index) {
                        final item = scanHistory[index];
                        bool isAvailable = item["is_available"] as bool;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            children: [
                              // Product image
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${item["product_image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              
                              // Product info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["product_name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${(item["price"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isAvailable 
                                                ? successColor.withAlpha(20)
                                                : dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            isAvailable ? "Available" : "Out of Stock",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: isAvailable ? successColor : dangerColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${DateTime.parse(item["scanned_at"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Action button
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  _showScanResult(item["code"]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: primaryColor,
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
