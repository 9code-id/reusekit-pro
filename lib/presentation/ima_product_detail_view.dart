import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaProductDetailView extends StatefulWidget {
  const ImaProductDetailView({super.key});

  @override
  State<ImaProductDetailView> createState() => _ImaProductDetailViewState();
}

class _ImaProductDetailViewState extends State<ImaProductDetailView> {
  int currentImageIndex = 0;
  int selectedVariantIndex = 0;
  
  Map<String, dynamic> product = {
    "id": "PRD001",
    "name": "iPhone 14 Pro Max",
    "sku": "IP14PM-256GB-PURPLE",
    "brand": "Apple",
    "category": "Electronics",
    "subcategory": "Smartphones",
    "description": "The iPhone 14 Pro Max features a 6.7-inch Super Retina XDR display with ProMotion technology. Powered by the A16 Bionic chip, it delivers incredible performance and efficiency. The Pro camera system includes a 48MP Main camera with 2x Telephoto capabilities.",
    "shortDescription": "Latest iPhone with advanced Pro camera system and A16 Bionic chip",
    "price": 1199.99,
    "comparePrice": 1299.99,
    "costPrice": 899.99,
    "stock": 45,
    "reserved": 12,
    "sold": 234,
    "status": "Active",
    "weight": 240.0,
    "dimensions": "160.7 x 77.6 x 7.85 mm",
    "rating": 4.8,
    "reviewCount": 1247,
    "createdAt": "2024-01-15",
    "updatedAt": "2024-01-15",
    "tags": ["smartphone", "apple", "pro", "premium", "5g"],
    "barcode": "123456789012",
    "supplier": "Apple Inc.",
    "warranty": "1 Year Limited Warranty",
    "images": [
      "https://picsum.photos/400/400?random=1&keyword=phone",
      "https://picsum.photos/400/400?random=2&keyword=phone",
      "https://picsum.photos/400/400?random=3&keyword=phone",
      "https://picsum.photos/400/400?random=4&keyword=phone",
      "https://picsum.photos/400/400?random=5&keyword=phone",
    ],
  };

  List<Map<String, dynamic>> variants = [
    {
      "id": "VAR001",
      "name": "256GB Deep Purple",
      "sku": "IP14PM-256GB-PURPLE",
      "price": 1199.99,
      "stock": 45,
      "attributes": {"storage": "256GB", "color": "Deep Purple"},
    },
    {
      "id": "VAR002", 
      "name": "256GB Space Black",
      "sku": "IP14PM-256GB-BLACK",
      "price": 1199.99,
      "stock": 32,
      "attributes": {"storage": "256GB", "color": "Space Black"},
    },
    {
      "id": "VAR003",
      "name": "512GB Deep Purple", 
      "sku": "IP14PM-512GB-PURPLE",
      "price": 1399.99,
      "stock": 18,
      "attributes": {"storage": "512GB", "color": "Deep Purple"},
    },
    {
      "id": "VAR004",
      "name": "1TB Gold",
      "sku": "IP14PM-1TB-GOLD", 
      "price": 1599.99,
      "stock": 8,
      "attributes": {"storage": "1TB", "color": "Gold"},
    },
  ];

  List<Map<String, dynamic>> specifications = [
    {"label": "Display", "value": "6.7-inch Super Retina XDR"},
    {"label": "Chip", "value": "A16 Bionic"},
    {"label": "Camera", "value": "Pro camera system (48MP, 12MP, 12MP)"},
    {"label": "Video Recording", "value": "4K at 24 fps, 25 fps, 30 fps, or 60 fps"},
    {"label": "Battery Life", "value": "Up to 29 hours video playback"},
    {"label": "Operating System", "value": "iOS 16"},
    {"label": "Connectivity", "value": "5G, Wi-Fi 6, Bluetooth 5.3"},
    {"label": "Water Resistance", "value": "IP68"},
    {"label": "Materials", "value": "Stainless steel frame, Ceramic Shield front"},
  ];

  List<Map<String, dynamic>> stockHistory = [
    {"date": "2024-01-15", "action": "Stock Added", "quantity": 50, "total": 95},
    {"date": "2024-01-14", "action": "Sale", "quantity": -15, "total": 45},
    {"date": "2024-01-13", "action": "Stock Added", "quantity": 30, "total": 60},
    {"date": "2024-01-12", "action": "Sale", "quantity": -8, "total": 30},
    {"date": "2024-01-11", "action": "Initial Stock", "quantity": 38, "total": 38},
  ];

  List<Map<String, dynamic>> relatedProducts = [
    {
      "name": "iPhone 14 Pro",
      "price": 999.99,
      "image": "https://picsum.photos/120/120?random=6&keyword=phone",
    },
    {
      "name": "AirPods Pro 3rd Gen",
      "price": 249.99, 
      "image": "https://picsum.photos/120/120?random=7&keyword=headphones",
    },
    {
      "name": "iPhone 14 Case",
      "price": 49.99,
      "image": "https://picsum.photos/120/120?random=8&keyword=case",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit product
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareProduct();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreActions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images
            _buildImageGallery(),
            
            // Product Info
            _buildProductInfo(),
            
            // Variants
            _buildVariants(),
            
            // Stock Information
            _buildStockInfo(),
            
            // Specifications
            _buildSpecifications(),
            
            // Stock History
            _buildStockHistory(),
            
            // Related Products
            _buildRelatedProducts(),
            
            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 300,
      child: Column(
        children: [
          // Main Image
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Image.network(
                  "${(product["images"] as List)[currentImageIndex]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Image Thumbnails
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: (product["images"] as List).length,
              itemBuilder: (context, index) {
                bool isSelected = index == currentImageIndex;
                return GestureDetector(
                  onTap: () {
                    currentImageIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${(product["images"] as List)[index]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Title and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
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
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${product["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),

          // SKU and Barcode
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "SKU: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${product["sku"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Barcode: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${product["barcode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Price Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selling Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(product["price"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if ((product["comparePrice"] as double) > (product["price"] as double))
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Compare Price",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(product["comparePrice"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cost Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(product["costPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Rating and Reviews
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < (product["rating"] as double).floor()
                        ? Icons.star
                        : Icons.star_border,
                    size: 20,
                    color: warningColor,
                  );
                }),
              ),
              SizedBox(width: spSm),
              Text(
                "${product["rating"]} (${product["reviewCount"]} reviews)",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          // Description
          Text(
            "Description",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${product["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),

          // Tags
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (product["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#${tag}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVariants() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Product Variants",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...variants.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> variant = entry.value;
            bool isSelected = index == selectedVariantIndex;

            return GestureDetector(
              onTap: () {
                selectedVariantIndex = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${variant["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "SKU: ${variant["sku"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${(variant["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Stock: ${variant["stock"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: (variant["stock"] as int) > 10 
                                ? successColor 
                                : (variant["stock"] as int) > 0 
                                    ? warningColor 
                                    : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStockInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Stock Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStockCard("Available Stock", "${product["stock"]}", successColor, Icons.inventory),
              _buildStockCard("Reserved", "${product["reserved"]}", warningColor, Icons.lock),
              _buildStockCard("Total Sold", "${product["sold"]}", infoColor, Icons.shopping_cart),
              _buildStockCard("Profit Margin", "${(((product["price"] as double) - (product["costPrice"] as double)) / (product["price"] as double) * 100).toStringAsFixed(1)}%", primaryColor, Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifications() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Specifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...specifications.map((spec) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${spec["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${spec["value"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStockHistory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Stock History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // View full history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ...stockHistory.map((history) {
            bool isPositive = (history["quantity"] as int) > 0;
            Color actionColor = isPositive ? successColor : dangerColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: actionColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: actionColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    isPositive ? Icons.add_circle : Icons.remove_circle,
                    color: actionColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${history["action"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${history["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${isPositive ? '+' : ''}${history["quantity"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: actionColor,
                        ),
                      ),
                      Text(
                        "Total: ${history["total"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Related Products",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: relatedProducts.map((related) {
              return Container(
                width: 150,
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${related["image"]}",
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${related["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(related["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Product",
                  icon: Icons.edit,
                  size: bs.md,
                  onPressed: () {
                    // Navigate to edit
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Stock",
                  icon: Icons.inventory,
                  size: bs.md,
                  onPressed: () {
                    _updateStock();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Duplicate",
                  icon: Icons.copy,
                  size: bs.sm,
                  onPressed: () {
                    _duplicateProduct();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Archive",
                  icon: Icons.archive,
                  size: bs.sm,
                  onPressed: () {
                    _archiveProduct();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _shareProduct() {
    ss("Product link copied to clipboard!");
  }

  void _showMoreActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.qr_code),
                title: Text("Generate QR Code"),
                onTap: () {
                  Navigator.pop(context);
                  _generateQR();
                },
              ),
              ListTile(
                leading: Icon(Icons.print),
                title: Text("Print Barcode"),
                onTap: () {
                  Navigator.pop(context);
                  _printBarcode();
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text("View Analytics"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to analytics
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateStock() {
    si("Stock update feature coming soon!");
  }

  void _duplicateProduct() {
    ss("Product duplicated successfully!");
  }

  void _archiveProduct() async {
    bool isConfirmed = await confirm("Are you sure you want to archive this product?");
    if (isConfirmed) {
      ss("Product archived successfully!");
    }
  }

  void _generateQR() {
    ss("QR code generated successfully!");
  }

  void _printBarcode() {
    ss("Barcode sent to printer!");
  }
}
