import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class Ecs360ProductView extends StatefulWidget {
  const Ecs360ProductView({super.key});

  @override
  State<Ecs360ProductView> createState() => _Ecs360ProductViewState();
}

class _Ecs360ProductViewState extends State<Ecs360ProductView> {
  double currentAngle = 0.0;
  bool isAutoRotating = false;
  bool isZoomed = false;
  double zoomLevel = 1.0;
  String selectedProduct = "Luxury Watch";
  int currentImageIndex = 0;
  bool showHotspots = true;
  
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Luxury Watch",
      "price": 1299.0,
      "images": List.generate(36, (index) => 
        "https://picsum.photos/400/400?random=${index + 1}&keyword=watch"
      ),
      "hotspots": [
        {
          "x": 0.3,
          "y": 0.4,
          "title": "Crown",
          "description": "Precision-crafted crown for time adjustment"
        },
        {
          "x": 0.7,
          "y": 0.6,
          "title": "Crystal",
          "description": "Sapphire crystal with anti-reflective coating"
        },
        {
          "x": 0.5,
          "y": 0.8,
          "title": "Strap",
          "description": "Genuine leather strap with deployant clasp"
        },
      ],
    },
    {
      "id": 2,
      "name": "Gaming Chair",
      "price": 699.0,
      "images": List.generate(36, (index) => 
        "https://picsum.photos/400/400?random=${index + 37}&keyword=chair"
      ),
      "hotspots": [
        {
          "x": 0.5,
          "y": 0.3,
          "title": "Headrest",
          "description": "Adjustable ergonomic headrest"
        },
        {
          "x": 0.4,
          "y": 0.5,
          "title": "Armrest",
          "description": "4D adjustable armrests"
        },
        {
          "x": 0.5,
          "y": 0.7,
          "title": "Base",
          "description": "Reinforced aluminum base with smooth wheels"
        },
      ],
    },
    {
      "id": 3,
      "name": "Smartphone",
      "price": 999.0,
      "images": List.generate(36, (index) => 
        "https://picsum.photos/400/400?random=${index + 73}&keyword=phone"
      ),
      "hotspots": [
        {
          "x": 0.5,
          "y": 0.2,
          "title": "Camera",
          "description": "Triple camera system with AI enhancement"
        },
        {
          "x": 0.8,
          "y": 0.4,
          "title": "Volume",
          "description": "Volume buttons with haptic feedback"
        },
        {
          "x": 0.5,
          "y": 0.9,
          "title": "Charging Port",
          "description": "USB-C port with fast charging support"
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoRotation();
  }

  @override
  Widget build(BuildContext context) {
    var currentProduct = products.firstWhere(
      (p) => p["name"] == selectedProduct,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("360° Product View"),
        actions: [
          IconButton(
            icon: Icon(showHotspots ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              showHotspots = !showHotspots;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: _enterFullscreen,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductSelector(),
            SizedBox(height: spLg),
            _build360Viewer(currentProduct),
            SizedBox(height: spLg),
            _buildViewerControls(),
            SizedBox(height: spLg),
            _buildProductInfo(currentProduct),
            SizedBox(height: spLg),
            _buildHotspotDetails(currentProduct),
            SizedBox(height: spLg),
            _buildViewingTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Product",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: products.map((product) {
            bool isSelected = product["name"] == selectedProduct;
            return GestureDetector(
              onTap: () {
                selectedProduct = product["name"];
                currentAngle = 0.0;
                currentImageIndex = 0;
                setState(() {});
              },
              child: Container(
                width: 140,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusSm),
                      ),
                      child: Image.network(
                        "${(product["images"] as List)[0]}",
                        width: 140,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        children: [
                          Text(
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(product["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _build360Viewer(Map<String, dynamic> product) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowLg],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusLg),
        child: Stack(
          children: [
            // Main 360 Image
            GestureDetector(
              onPanUpdate: (details) {
                if (!isAutoRotating) {
                  double sensitivity = 2.0;
                  currentAngle += details.delta.dx * sensitivity;
                  if (currentAngle < 0) currentAngle += 360;
                  if (currentAngle >= 360) currentAngle -= 360;
                  
                  currentImageIndex = ((currentAngle / 10).round()) % 36;
                  setState(() {});
                }
              },
              onTap: () {
                isZoomed = !isZoomed;
                zoomLevel = isZoomed ? 2.0 : 1.0;
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(zoomLevel),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    "${(product["images"] as List)[currentImageIndex]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Hotspots
            if (showHotspots) ...[
              ...(product["hotspots"] as List).map((hotspot) {
                return Positioned(
                  left: (hotspot["x"] as double) * 400,
                  top: (hotspot["y"] as double) * 400,
                  child: GestureDetector(
                    onTap: () => _showHotspotDetails(hotspot),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.add,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
            
            // Rotation Indicator
            Positioned(
              top: spSm,
              right: spSm,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(180),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.threesixty,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${currentAngle.toInt()}°",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Zoom Indicator
            if (isZoomed) ...[
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.zoom_in,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${zoomLevel.toStringAsFixed(1)}x",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Auto Rotation Indicator
            if (isAutoRotating) ...[
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.rotate_right,
                        size: 16,
                        color: Colors.white,
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
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildViewerControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Viewer Controls",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          // Rotation Control
          Row(
            children: [
              Text(
                "Rotation:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Slider(
                  value: currentAngle,
                  min: 0,
                  max: 360,
                  divisions: 36,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    currentAngle = value;
                    currentImageIndex = ((value / 10).round()) % 36;
                    setState(() {});
                  },
                ),
              ),
              Text(
                "${currentAngle.toInt()}°",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Control Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isAutoRotating ? "Stop Auto" : "Auto Rotate",
                  size: bs.sm,
                  onPressed: _toggleAutoRotation,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset View",
                  size: bs.sm,
                  onPressed: _resetView,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(Map<String, dynamic> product) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "360° Views",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(product["images"] as List).length}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Interactive 360° product view with detailed hotspots and zoom functionality. Drag to rotate, tap to zoom, and explore all product features.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotspotDetails(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Features",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...(product["hotspots"] as List).map((hotspot) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${hotspot["title"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${hotspot["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildViewingTips() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: infoColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: infoColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Viewing Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildTipItem("Drag horizontally to rotate the product"),
          _buildTipItem("Tap to zoom in/out for detailed view"),
          _buildTipItem("Tap hotspots (+) to learn about features"),
          _buildTipItem("Use auto-rotate for hands-free viewing"),
          _buildTipItem("Toggle hotspot visibility with the eye icon"),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              color: infoColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                color: infoColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startAutoRotation() {
    if (isAutoRotating) return;
    
    isAutoRotating = true;
    _rotateTimer();
  }

  void _rotateTimer() async {
    while (isAutoRotating && mounted) {
      await Future.delayed(Duration(milliseconds: 100));
      if (isAutoRotating) {
        currentAngle += 2;
        if (currentAngle >= 360) currentAngle = 0;
        currentImageIndex = ((currentAngle / 10).round()) % 36;
        setState(() {});
      }
    }
  }

  void _toggleAutoRotation() {
    isAutoRotating = !isAutoRotating;
    if (isAutoRotating) {
      _rotateTimer();
    }
    setState(() {});
  }

  void _resetView() {
    currentAngle = 0.0;
    currentImageIndex = 0;
    isZoomed = false;
    zoomLevel = 1.0;
    setState(() {});
    si("View reset to default position");
  }

  void _enterFullscreen() {
    si("Entering fullscreen mode...");
    // Navigate to fullscreen 360 viewer
  }

  void _showHotspotDetails(Map<String, dynamic> hotspot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${hotspot["title"]}"),
        content: Text("${hotspot["description"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
