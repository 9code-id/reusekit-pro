import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCanvasPrintsView extends StatefulWidget {
  const PpaCanvasPrintsView({super.key});

  @override
  State<PpaCanvasPrintsView> createState() => _PpaCanvasPrintsViewState();
}

class _PpaCanvasPrintsViewState extends State<PpaCanvasPrintsView> {
  String selectedSize = "16x20";
  String selectedFrame = "Gallery Wrap";
  String selectedFinish = "Matte";
  int quantity = 1;
  String selectedPhoto = "";
  
  List<Map<String, dynamic>> sizeOptions = [
    {"label": "8x10 inch", "value": "8x10"},
    {"label": "11x14 inch", "value": "11x14"},
    {"label": "16x20 inch", "value": "16x20"},
    {"label": "20x24 inch", "value": "20x24"},
    {"label": "24x30 inch", "value": "24x30"},
    {"label": "30x40 inch", "value": "30x40"},
    {"label": "Custom Size", "value": "Custom"},
  ];

  List<Map<String, dynamic>> frameOptions = [
    {"label": "Gallery Wrap", "value": "Gallery Wrap"},
    {"label": "Black Float Frame", "value": "Black Float Frame"},
    {"label": "White Float Frame", "value": "White Float Frame"},
    {"label": "Natural Wood Frame", "value": "Natural Wood Frame"},
    {"label": "Dark Wood Frame", "value": "Dark Wood Frame"},
    {"label": "No Frame", "value": "No Frame"},
  ];

  List<Map<String, dynamic>> finishOptions = [
    {"label": "Matte", "value": "Matte"},
    {"label": "Glossy", "value": "Glossy"},
    {"label": "Satin", "value": "Satin"},
    {"label": "Textured", "value": "Textured"},
  ];

  List<Map<String, dynamic>> canvasPrints = [
    {
      "id": "canvas_001",
      "title": "Sunset Beach",
      "size": "16x20",
      "frame": "Gallery Wrap",
      "finish": "Matte",
      "quantity": 1,
      "status": "Completed",
      "orderDate": "2024-06-16",
      "price": 89.99,
      "thumbnail": "https://picsum.photos/200/150?random=1&keyword=sunset",
    },
    {
      "id": "canvas_002",
      "title": "Mountain Landscape",
      "size": "24x30",
      "frame": "Black Float Frame",
      "finish": "Glossy",
      "quantity": 1,
      "status": "In Production",
      "orderDate": "2024-06-15",
      "price": 149.99,
      "thumbnail": "https://picsum.photos/200/150?random=2&keyword=mountain",
    },
    {
      "id": "canvas_003",
      "title": "Family Portrait",
      "size": "20x24",
      "frame": "Natural Wood Frame",
      "finish": "Satin",
      "quantity": 2,
      "status": "Shipped",
      "orderDate": "2024-06-14",
      "price": 239.98,
      "trackingNumber": "1Z999AA1234567890",
      "thumbnail": "https://picsum.photos/200/150?random=3&keyword=family",
    },
  ];

  List<Map<String, dynamic>> featuredGallery = [
    {
      "title": "Nature Photography",
      "description": "Stunning landscapes and wildlife",
      "images": [
        "https://picsum.photos/200/150?random=4&keyword=nature",
        "https://picsum.photos/200/150?random=5&keyword=landscape",
        "https://picsum.photos/200/150?random=6&keyword=wildlife",
      ],
    },
    {
      "title": "Portrait Collection",
      "description": "Professional portrait photography",
      "images": [
        "https://picsum.photos/200/150?random=7&keyword=portrait",
        "https://picsum.photos/200/150?random=8&keyword=people",
        "https://picsum.photos/200/150?random=9&keyword=model",
      ],
    },
    {
      "title": "Abstract Art",
      "description": "Modern abstract compositions",
      "images": [
        "https://picsum.photos/200/150?random=10&keyword=abstract",
        "https://picsum.photos/200/150?random=11&keyword=art",
        "https://picsum.photos/200/150?random=12&keyword=modern",
      ],
    },
  ];

  Map<String, double> sizePricing = {
    "8x10": 39.99,
    "11x14": 59.99,
    "16x20": 89.99,
    "20x24": 119.99,
    "24x30": 149.99,
    "30x40": 199.99,
    "Custom": 299.99,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canvas Prints"),
        actions: [
          IconButton(
            icon: Icon(Icons.palette),
            onPressed: () {
              _showColorCorrection();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              _showCart();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.brush,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium Canvas Prints",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Transform your photos into stunning wall art with museum-quality canvas prints",
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
            ),

            Text(
              "Featured Gallery",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: featuredGallery.map((gallery) {
                return _buildGalleryCard(gallery);
              }).toList(),
            ),

            Text(
              "Create Canvas Print",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Select Photo",
                          size: bs.md,
                          icon: Icons.photo_library,
                          onPressed: () {
                            _selectPhotoForCanvas();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      if (selectedPhoto.isNotEmpty) ...[
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/200/200?random=13&keyword=selected"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  QDropdownField(
                    label: "Canvas Size",
                    items: sizeOptions,
                    value: selectedSize,
                    onChanged: (value, label) {
                      selectedSize = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Frame Style",
                          items: frameOptions,
                          value: selectedFrame,
                          onChanged: (value, label) {
                            selectedFrame = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Finish",
                          items: finishOptions,
                          value: selectedFinish,
                          onChanged: (value, label) {
                            selectedFinish = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QNumberField(
                    label: "Quantity",
                    value: quantity.toString(),
                    onChanged: (value) {
                      quantity = int.tryParse(value) ?? 1;
                      setState(() {});
                    },
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Order Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "• Size: $selectedSize inches",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        Text(
                          "• Frame: $selectedFrame",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        Text(
                          "• Finish: $selectedFinish",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        Text(
                          "• Quantity: $quantity",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Total: \$${(_calculateCanvasPrice() * quantity).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Preview Canvas",
                    size: bs.md,
                    icon: Icons.visibility,
                    onPressed: () {
                      _previewCanvas();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Add to Cart",
                    size: bs.md,
                    icon: Icons.shopping_cart,
                    onPressed: () {
                      _addToCart();
                    },
                  ),
                ),
              ],
            ),

            Text(
              "My Canvas Orders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: canvasPrints.length,
              itemBuilder: (context, index) {
                final canvas = canvasPrints[index];
                return _buildCanvasOrderCard(canvas);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryCard(Map<String, dynamic> gallery) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            child: Row(
              children: (gallery["images"] as List).take(3).map((imageUrl) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        imageUrl.toString(),
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${gallery["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${gallery["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Explore",
                    size: bs.sm,
                    onPressed: () {
                      _exploreGallery(gallery["title"]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCanvasOrderCard(Map<String, dynamic> canvas) {
    Color statusColor = _getCanvasStatusColor(canvas["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${canvas["thumbnail"]}",
              width: 80,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${canvas["title"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${canvas["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${canvas["size"]} • ${canvas["frame"]} • ${canvas["finish"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Text(
                      "Qty: ${canvas["quantity"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Ordered: ${canvas["orderDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(canvas["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                if (canvas["trackingNumber"] != null) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: infoColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Tracking: ${canvas["trackingNumber"]}",
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    QButton(
                      label: "View",
                      size: bs.sm,
                      icon: Icons.visibility,
                      onPressed: () {
                        _viewCanvasOrder(canvas["id"]);
                      },
                    ),
                    SizedBox(width: spSm),
                    if (canvas["status"] == "Completed") ...[
                      QButton(
                        label: "Reorder",
                        size: bs.sm,
                        icon: Icons.repeat,
                        onPressed: () {
                          _reorderCanvas(canvas["id"]);
                        },
                      ),
                    ],
                    if (canvas["trackingNumber"] != null) ...[
                      QButton(
                        label: "Track",
                        size: bs.sm,
                        icon: Icons.track_changes,
                        onPressed: () {
                          _trackCanvasOrder(canvas["trackingNumber"]);
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCanvasStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Production":
        return warningColor;
      case "Shipped":
        return infoColor;
      case "Delivered":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  double _calculateCanvasPrice() {
    double basePrice = sizePricing[selectedSize] ?? 89.99;
    
    if (selectedFrame == "Black Float Frame" || selectedFrame == "White Float Frame") {
      basePrice += 20.0;
    } else if (selectedFrame == "Natural Wood Frame" || selectedFrame == "Dark Wood Frame") {
      basePrice += 35.0;
    }
    
    if (selectedFinish == "Glossy") {
      basePrice += 10.0;
    } else if (selectedFinish == "Textured") {
      basePrice += 15.0;
    }
    
    return basePrice;
  }

  void _selectPhotoForCanvas() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Photo"),
          content: Text("Photo selection interface would be implemented here."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Select",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  selectedPhoto = "selected_photo.jpg";
                });
                Navigator.pop(context);
                ss("Photo selected for canvas print");
              },
            ),
          ],
        );
      },
    );
  }

  void _previewCanvas() {
    if (selectedPhoto.isEmpty) {
      se("Please select a photo first");
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Canvas Preview"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/400/300?random=14&keyword=canvas"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Text("$selectedSize Canvas with $selectedFrame"),
              Text("$selectedFinish finish"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
            QButton(
              label: "Looks Good",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                _addToCart();
              },
            ),
          ],
        );
      },
    );
  }

  void _addToCart() {
    if (selectedPhoto.isEmpty) {
      se("Please select a photo first");
      return;
    }
    
    ss("Canvas print added to cart!");
  }

  void _showColorCorrection() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Color Correction"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Professional color correction ensures your canvas print looks exactly as intended."),
              SizedBox(height: spSm),
              QSwitch(
                label: "Auto Color Correction",
                items: [
                  {
                    "label": "Apply automatic color correction",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [
                  {
                    "label": "Apply automatic color correction",
                    "value": true,
                    "checked": true
                  }
                ],
                onChanged: (values, ids) {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Apply",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Color correction applied");
              },
            ),
          ],
        );
      },
    );
  }

  void _showCart() {
    si("Showing shopping cart");
  }

  void _exploreGallery(String galleryTitle) {
    si("Exploring $galleryTitle gallery");
  }

  void _viewCanvasOrder(String canvasId) {
    si("Viewing canvas order $canvasId");
  }

  void _reorderCanvas(String canvasId) {
    ss("Canvas reordered successfully");
  }

  void _trackCanvasOrder(String trackingNumber) {
    si("Tracking canvas order: $trackingNumber");
  }
}
