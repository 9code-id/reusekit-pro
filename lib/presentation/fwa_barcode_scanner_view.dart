import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBarcodeScannerView extends StatefulWidget {
  const FwaBarcodeScannerView({super.key});

  @override
  State<FwaBarcodeScannerView> createState() => _FwaBarcodeScannerViewState();
}

class _FwaBarcodeScannerViewState extends State<FwaBarcodeScannerView> {
  bool isScanning = false;
  bool flashEnabled = false;
  String scannedCode = "";
  String scanResult = "";
  String selectedAction = "Add to Food Diary";

  List<Map<String, dynamic>> scanActions = [
    {"label": "Add to Food Diary", "value": "Add to Food Diary"},
    {"label": "Add to Grocery List", "value": "Add to Grocery List"},
    {"label": "Check Nutrition Info", "value": "Check Nutrition Info"},
    {"label": "Compare Products", "value": "Compare Products"},
  ];

  List<Map<String, dynamic>> recentScans = [
    {
      "id": 1,
      "barcode": "012345678901",
      "productName": "Greek Yogurt Plain",
      "brand": "Chobani",
      "category": "Dairy",
      "calories": 100,
      "protein": 18,
      "carbs": 6,
      "fat": 0,
      "scanTime": DateTime.now().subtract(Duration(minutes: 5)),
      "image": "https://picsum.photos/60/60?random=1&keyword=yogurt",
      "action": "Added to Food Diary",
    },
    {
      "id": 2,
      "barcode": "123456789012",
      "productName": "Organic Bananas",
      "brand": "Dole",
      "category": "Fruits",
      "calories": 105,
      "protein": 1,
      "carbs": 27,
      "fat": 0,
      "scanTime": DateTime.now().subtract(Duration(hours: 2)),
      "image": "https://picsum.photos/60/60?random=2&keyword=banana",
      "action": "Added to Grocery List",
    },
    {
      "id": 3,
      "barcode": "234567890123",
      "productName": "Whey Protein Powder",
      "brand": "Optimum Nutrition",
      "category": "Supplements",
      "calories": 120,
      "protein": 24,
      "carbs": 3,
      "fat": 1,
      "scanTime": DateTime.now().subtract(Duration(days: 1)),
      "image": "https://picsum.photos/60/60?random=3&keyword=protein",
      "action": "Checked Nutrition",
    },
    {
      "id": 4,
      "barcode": "345678901234",
      "productName": "Whole Wheat Bread",
      "brand": "Dave's Killer Bread",
      "category": "Grains",
      "calories": 110,
      "protein": 5,
      "carbs": 22,
      "fat": 2,
      "scanTime": DateTime.now().subtract(Duration(days: 2)),
      "image": "https://picsum.photos/60/60?random=4&keyword=bread",
      "action": "Added to Food Diary",
    },
  ];

  Map<String, dynamic>? currentProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
        actions: [
          IconButton(
            onPressed: () {
              flashEnabled = !flashEnabled;
              setState(() {});
            },
            icon: Icon(flashEnabled ? Icons.flash_on : Icons.flash_off),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Camera Preview/Scanner
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  // Camera preview simulation
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black54,
                          Colors.black87,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spMd,
                        children: [
                          if (!isScanning) ...[
                            Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                              size: 80,
                            ),
                            Text(
                              "Position barcode within the frame",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            QButton(
                              label: "Start Scanning",
                              size: bs.sm,
                              onPressed: () {
                                isScanning = true;
                                _simulateScan();
                                setState(() {});
                              },
                            ),
                          ] else ...[
                            Container(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                strokeWidth: 3,
                              ),
                            ),
                            Text(
                              "Scanning...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Scanning overlay
                  if (isScanning)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Flash indicator
                  if (flashEnabled)
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(Icons.flash_on, color: Colors.white, size: 16),
                      ),
                    ),
                ],
              ),
            ),

            // Scan Action Selector
            QDropdownField(
              label: "Scan Action",
              items: scanActions,
              value: selectedAction,
              onChanged: (value, label) {
                selectedAction = value;
                setState(() {});
              },
            ),

            // Current Scan Result
            if (currentProduct != null) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: successColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Product Found!",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${currentProduct!["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${currentProduct!["productName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${currentProduct!["brand"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${currentProduct!["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Nutrition Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Text(
                            "Nutrition per serving",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildNutrientInfo("Calories", "${currentProduct!["calories"]}", "kcal")),
                              Expanded(child: _buildNutrientInfo("Protein", "${currentProduct!["protein"]}", "g")),
                              Expanded(child: _buildNutrientInfo("Carbs", "${currentProduct!["carbs"]}", "g")),
                              Expanded(child: _buildNutrientInfo("Fat", "${currentProduct!["fat"]}", "g")),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: selectedAction,
                            size: bs.sm,
                            onPressed: () {
                              _executeAction();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.info,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.close,
                          size: bs.sm,
                          onPressed: () {
                            currentProduct = null;
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    // Barcode Display
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.qr_code, color: Colors.white, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${currentProduct!["barcode"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Manual Entry Option
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.edit, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Manual Entry",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Can't find the barcode? Enter the product details manually.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Enter barcode or product name",
                          value: scannedCode,
                          onChanged: (value) {
                            scannedCode = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Search",
                        size: bs.sm,
                        onPressed: () {
                          if (scannedCode.isNotEmpty) {
                            _simulateProductLookup();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Scans
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Scans",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentScans.take(3).map((scan) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${scan["image"]}",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${scan["productName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${scan["brand"]} • ${scan["action"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(scan["scanTime"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.refresh,
                            size: bs.sm,
                            onPressed: () {
                              currentProduct = scan;
                              setState(() {});
                            },
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

  Widget _buildNutrientInfo(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          "$value$unit",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _simulateScan() {
    Future.delayed(Duration(seconds: 2), () {
      isScanning = false;
      currentProduct = {
        "barcode": "987654321098",
        "productName": "Almond Butter",
        "brand": "Justin's",
        "category": "Pantry",
        "calories": 190,
        "protein": 7,
        "carbs": 8,
        "fat": 18,
        "image": "https://picsum.photos/60/60?random=10&keyword=almond",
      };
      setState(() {});
    });
  }

  void _simulateProductLookup() {
    currentProduct = {
      "barcode": scannedCode,
      "productName": "Custom Product",
      "brand": "Generic",
      "category": "Other",
      "calories": 150,
      "protein": 5,
      "carbs": 20,
      "fat": 6,
      "image": "https://picsum.photos/60/60?random=11&keyword=food",
    };
    setState(() {});
  }

  void _executeAction() {
    ss("Product ${selectedAction.toLowerCase()} successfully!");
    currentProduct = null;
    setState(() {});
  }
}
