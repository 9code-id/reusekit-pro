import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosProductImagesView extends StatefulWidget {
  const PosProductImagesView({super.key});

  @override
  State<PosProductImagesView> createState() => _PosProductImagesViewState();
}

class _PosProductImagesViewState extends State<PosProductImagesView> {
  String selectedProductId = "prod_001";
  List<String> productImages = [];
  String newImageUrl = "";
  bool loading = false;

  List<Map<String, dynamic>> products = [
    {
      "id": "prod_001",
      "name": "Wireless Headphones",
      "sku": "WH-001",
      "images": [
        "https://picsum.photos/300/300?random=1&keyword=headphones",
        "https://picsum.photos/300/300?random=2&keyword=headphones",
        "https://picsum.photos/300/300?random=3&keyword=headphones",
      ]
    },
    {
      "id": "prod_002",
      "name": "Bluetooth Speaker",
      "sku": "BS-002",
      "images": [
        "https://picsum.photos/300/300?random=4&keyword=speaker",
        "https://picsum.photos/300/300?random=5&keyword=speaker",
      ]
    },
    {
      "id": "prod_003",
      "name": "Smart Watch",
      "sku": "SW-003",
      "images": [
        "https://picsum.photos/300/300?random=6&keyword=watch",
      ]
    },
    {
      "id": "prod_004",
      "name": "Phone Case",
      "sku": "PC-004",
      "images": []
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadProductImages();
  }

  void _loadProductImages() {
    final product = products.firstWhere((p) => p["id"] == selectedProductId);
    productImages = List<String>.from(product["images"] as List);
  }

  void _addImage() async {
    if (newImageUrl.isNotEmpty) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(milliseconds: 800));

      productImages.add(newImageUrl);
      newImageUrl = "";
      loading = false;
      setState(() {});

      ss("Image added successfully");
    }
  }

  void _deleteImage(int index) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this image?");
    if (isConfirmed) {
      productImages.removeAt(index);
      setState(() {});
      ss("Image deleted successfully");
    }
  }

  void _reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = productImages.removeAt(oldIndex);
    productImages.insert(newIndex, item);
    setState(() {});
    si("Images reordered successfully");
  }

  void _setAsPrimary(int index) {
    final primaryImage = productImages.removeAt(index);
    productImages.insert(0, primaryImage);
    setState(() {});
    ss("Set as primary image");
  }

  Widget _buildProductSelector() {
    return QDropdownField(
      label: "Select Product",
      items: products.map((product) => {
        "label": "${product["name"]} (${product["sku"]})",
        "value": product["id"],
      }).toList(),
      value: selectedProductId,
      onChanged: (value, label) {
        selectedProductId = value;
        _loadProductImages();
        setState(() {});
      },
    );
  }

  Widget _buildImageGrid() {
    if (productImages.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: disabledColor,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                size: 48,
                color: disabledBoldColor,
              ),
              SizedBox(height: spSm),
              Text(
                "No images uploaded",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ResponsiveGridView(
      minItemWidth: 200,
      children: List.generate(productImages.length, (index) {
        final imageUrl = productImages[index];
        final isPrimary = index == 0;
        
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: isPrimary ? primaryColor : disabledOutlineBorderColor,
              width: isPrimary ? 2 : 1,
            ),
            boxShadow: [shadowSm],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiusMd),
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: disabledColor,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: disabledBoldColor,
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isPrimary)
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "PRIMARY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isPrimary)
                        Container(
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () => _setAsPrimary(index),
                            iconSize: 18,
                            constraints: BoxConstraints.tightFor(width: 32, height: 32),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () => _deleteImage(index),
                          iconSize: 18,
                          constraints: BoxConstraints.tightFor(width: 32, height: 32),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAddImageForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add New Image",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Image URL",
            value: newImageUrl,
            hint: "Enter image URL or upload from device",
            onChanged: (value) {
              newImageUrl = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: loading ? "Adding..." : "Add Image",
                  onPressed: loading ? null : _addImage,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Upload File",
                icon: Icons.upload,
                size: bs.sm,
                onPressed: () {
                  si("File upload feature coming soon");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageStats() {
    final selectedProduct = products.firstWhere((p) => p["id"] == selectedProductId);
    
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.image,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${productImages.length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Images",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  productImages.isNotEmpty ? "1" : "0",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Primary Image",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.inventory,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${selectedProduct["sku"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Product SKU",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Images"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Drag and drop images to reorder them");
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
            _buildProductSelector(),
            _buildImageStats(),
            _buildAddImageForm(),
            Text(
              "Product Images (${productImages.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            _buildImageGrid(),
          ],
        ),
      ),
    );
  }
}
