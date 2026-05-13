import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsArTryOnView extends StatefulWidget {
  const EcsArTryOnView({super.key});

  @override
  State<EcsArTryOnView> createState() => _EcsArTryOnViewState();
}

class _EcsArTryOnViewState extends State<EcsArTryOnView> {
  bool isRecording = false;
  String selectedProduct = "";
  String selectedColor = "Black";
  String selectedSize = "M";
  bool isLoading = false;
  double confidence = 85.5;
  
  final List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "Classic T-Shirt",
      "price": 29.99,
      "image": "https://picsum.photos/400/600?random=1&keyword=tshirt",
      "colors": ["Black", "White", "Navy", "Gray"],
      "sizes": ["XS", "S", "M", "L", "XL"],
      "category": "Shirts",
    },
    {
      "id": "2", 
      "name": "Denim Jacket",
      "price": 89.99,
      "image": "https://picsum.photos/400/600?random=2&keyword=jacket",
      "colors": ["Blue", "Black", "Gray"],
      "sizes": ["S", "M", "L", "XL"],
      "category": "Jackets",
    },
    {
      "id": "3",
      "name": "Casual Sneakers",
      "price": 79.99,
      "image": "https://picsum.photos/400/600?random=3&keyword=shoes",
      "colors": ["White", "Black", "Red", "Blue"],
      "sizes": ["7", "8", "9", "10", "11"],
      "category": "Shoes",
    },
  ];

  final List<Map<String, dynamic>> recommendations = [
    {
      "name": "Cotton Hoodie",
      "price": 59.99,
      "image": "https://picsum.photos/300/400?random=4&keyword=hoodie",
      "rating": 4.8,
    },
    {
      "name": "Sport Shorts",
      "price": 34.99,
      "image": "https://picsum.photos/300/400?random=5&keyword=shorts",
      "rating": 4.6,
    },
    {
      "name": "Baseball Cap",
      "price": 24.99,
      "image": "https://picsum.photos/300/400?random=6&keyword=cap",
      "rating": 4.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR Try-On"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AR Camera View
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor, width: 2),
              ),
              child: Stack(
                children: [
                  // Camera Preview Placeholder
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/400/600?random=100&keyword=person"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // AR Overlay
                  if (selectedProduct.isNotEmpty)
                    Center(
                      child: Container(
                        width: 200,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusMd),
                          child: Image.network(
                            "${products.firstWhere((p) => p["id"] == selectedProduct)["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  
                  // Controls Overlay
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    right: spMd,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Switch Camera
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.cameraswitch, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                        
                        // Capture/Record Button
                        GestureDetector(
                          onTap: () {
                            isRecording = !isRecording;
                            setState(() {});
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: isRecording ? dangerColor : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor, width: 3),
                            ),
                            child: Icon(
                              isRecording ? Icons.stop : Icons.camera_alt,
                              color: isRecording ? Colors.white : primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                        
                        // Gallery
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.photo_library, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Confidence Score
                  if (selectedProduct.isNotEmpty)
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${confidence.toStringAsFixed(1)}% Match",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Product Selection
            Text(
              "Select Product to Try",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: List.generate(products.length, (index) {
                final product = products[index];
                final isSelected = selectedProduct == product["id"];
                
                return GestureDetector(
                  onTap: () {
                    selectedProduct = product["id"];
                    selectedColor = (product["colors"] as List)[0];
                    selectedSize = (product["sizes"] as List)[0];
                    setState(() {});
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          child: Image.network(
                            "${product["image"]}",
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Text(
                                "\$${(product["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            
            SizedBox(height: spLg),
            
            // Customization Options
            if (selectedProduct.isNotEmpty) ...[
              Text(
                "Customize Your Try-On",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Color Selection
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: (products.firstWhere((p) => p["id"] == selectedProduct)["colors"] as List)
                          .map<Widget>((color) {
                        final isSelected = selectedColor == color;
                        
                        return GestureDetector(
                          onTap: () {
                            selectedColor = color;
                            setState(() {});
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: _getColorFromName(color),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                width: isSelected ? 3 : 1,
                              ),
                            ),
                            child: isSelected
                                ? Icon(Icons.check, color: Colors.white, size: 20)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spSm),
              
              // Size Selection
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: (products.firstWhere((p) => p["id"] == selectedProduct)["sizes"] as List)
                          .map<Widget>((size) {
                        final isSelected = selectedSize == size;
                        
                        return GestureDetector(
                          onTap: () {
                            selectedSize = size;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              "$size",
                              style: TextStyle(
                                color: isSelected ? Colors.white : primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Add to Cart",
                      size: bs.md,
                      onPressed: () {
                        ss("Product added to cart successfully!");
                      },
                    ),
                  ),
                  
                  SizedBox(width: spSm),
                  
                  Expanded(
                    child: QButton(
                      label: "Share Try-On",
                      size: bs.md,
                      onPressed: () {
                        _shareToSocial();
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spLg),
            ],
            
            // Related Products
            Text(
              "Perfect Matches",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: List.generate(recommendations.length, (index) {
                final item = recommendations[index];
                
                return Container(
                  width: 150,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        child: Image.network(
                          "${item["image"]}",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "\$${(item["price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'navy':
        return Colors.indigo;
      case 'gray':
        return Colors.grey;
      default:
        return primaryColor;
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("How to Use AR Try-On"),
        content: Text(
          "1. Select a product to try on\n"
          "2. Position yourself in front of the camera\n"
          "3. The product will appear overlaid on your image\n"
          "4. Customize color and size options\n"
          "5. Capture or record your try-on experience\n"
          "6. Share with friends or add to cart",
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("AR Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.hd),
              title: Text("HD Quality"),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: Icon(Icons.flash_on),
              title: Text("Flash"),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: Icon(Icons.grid_on),
              title: Text("Grid Lines"),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _shareToSocial() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Share Your Try-On",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton("Instagram", Icons.camera_alt, primaryColor),
                _buildSocialButton("Facebook", Icons.facebook, Colors.blue),
                _buildSocialButton("Twitter", Icons.send, Colors.lightBlue),
                _buildSocialButton("WhatsApp", Icons.message, successColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String platform, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ss("Shared to $platform successfully!");
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          
          SizedBox(height: spXs),
          
          Text(
            platform,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
