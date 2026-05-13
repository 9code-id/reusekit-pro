import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProductListView extends StatefulWidget {
  const EcsProductListView({super.key});

  @override
  State<EcsProductListView> createState() => _EcsProductListViewState();
}

class _EcsProductListViewState extends State<EcsProductListView> {
  String selectedCategory = "All";
  String sortBy = "Popular";
  bool isGridView = true;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Home", "value": "home"},
    {"label": "Sports", "value": "sports"},
    {"label": "Beauty", "value": "beauty"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Headphones",
      "price": 299.99,
      "originalPrice": 399.99,
      "discount": 25,
      "rating": 4.5,
      "reviews": 1245,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "category": "electronics",
      "brand": "TechSound",
      "isWishlisted": false,
      "inStock": true,
      "fastDelivery": true,
    },
    {
      "id": 2,
      "name": "Premium Cotton T-Shirt",
      "price": 29.99,
      "originalPrice": 39.99,
      "discount": 25,
      "rating": 4.3,
      "reviews": 892,
      "image": "https://picsum.photos/300/300?random=2&keyword=tshirt",
      "category": "fashion",
      "brand": "StyleCo",
      "isWishlisted": true,
      "inStock": true,
      "fastDelivery": false,
    },
    {
      "id": 3,
      "name": "Smart Home Security Camera",
      "price": 149.99,
      "originalPrice": 199.99,
      "discount": 25,
      "rating": 4.7,
      "reviews": 567,
      "image": "https://picsum.photos/300/300?random=3&keyword=camera",
      "category": "home",
      "brand": "SecureHome",
      "isWishlisted": false,
      "inStock": true,
      "fastDelivery": true,
    },
    {
      "id": 4,
      "name": "Running Shoes Pro",
      "price": 129.99,
      "originalPrice": 159.99,
      "discount": 19,
      "rating": 4.6,
      "reviews": 2341,
      "image": "https://picsum.photos/300/300?random=4&keyword=shoes",
      "category": "sports",
      "brand": "RunFast",
      "isWishlisted": false,
      "inStock": false,
      "fastDelivery": false,
    },
    {
      "id": 5,
      "name": "Luxury Skincare Set",
      "price": 89.99,
      "originalPrice": 119.99,
      "discount": 25,
      "rating": 4.4,
      "reviews": 678,
      "image": "https://picsum.photos/300/300?random=5&keyword=skincare",
      "category": "beauty",
      "brand": "GlowCare",
      "isWishlisted": true,
      "inStock": true,
      "fastDelivery": true,
    },
    {
      "id": 6,
      "name": "Gaming Mechanical Keyboard",
      "price": 179.99,
      "originalPrice": 229.99,
      "discount": 22,
      "rating": 4.8,
      "reviews": 1876,
      "image": "https://picsum.photos/300/300?random=6&keyword=keyboard",
      "category": "electronics",
      "brand": "GameTech",
      "isWishlisted": false,
      "inStock": true,
      "fastDelivery": true,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == "All") return products;
    return products.where((product) => product["category"] == selectedCategory.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = label;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Sort and Filter Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sort, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Sort: $sortBy",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.filter_alt, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Results Count
            Text(
              "${filteredProducts.length} Products Found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Products Grid/List
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredProducts.map((product) {
                  return _buildProductCard(product);
                }).toList(),
              )
            else
              Column(
                children: filteredProducts.map((product) {
                  return _buildProductListItem(product);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount Badge
              if ((product["discount"] as int) > 0)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${product["discount"]}% OFF",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              
              // Wishlist Button
              Positioned(
                top: spXs,
                right: spXs,
                child: GestureDetector(
                  onTap: () {
                    product["isWishlisted"] = !(product["isWishlisted"] as bool);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      (product["isWishlisted"] as bool) ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: (product["isWishlisted"] as bool) ? dangerColor : disabledBoldColor,
                    ),
                  ),
                ),
              ),
              
              // Stock Status
              if (!(product["inStock"] as bool))
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Out of Stock",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
                Text(
                  "${product["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                SizedBox(height: 2),
                
                // Product Name
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spXs),
                
                // Rating and Reviews
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: 2),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                // Price
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if ((product["discount"] as int) > 0) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(product["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                
                SizedBox(height: spXs),
                
                // Fast Delivery Badge
                if (product["fastDelivery"] as bool)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Fast Delivery",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: successColor,
                      ),
                    ),
                  ),
                
                SizedBox(height: spSm),
                
                // Add to Cart Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: (product["inStock"] as bool) ? "Add to Cart" : "Notify Me",
                    size: bs.sm,
                    onPressed: (product["inStock"] as bool) ? () {
                      ss("Added to cart successfully");
                    } : () {
                      si("You'll be notified when available");
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

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${product["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount Badge
              if ((product["discount"] as int) > 0)
                Positioned(
                  top: 2,
                  left: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${product["discount"]}%",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(width: spSm),
          
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand and Wishlist
                Row(
                  children: [
                    Text(
                      "${product["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        product["isWishlisted"] = !(product["isWishlisted"] as bool);
                        setState(() {});
                      },
                      child: Icon(
                        (product["isWishlisted"] as bool) ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: (product["isWishlisted"] as bool) ? dangerColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 2),
                
                // Product Name
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spXs),
                
                // Rating and Reviews
                Row(
                  children: [
                    Icon(Icons.star, size: 12, color: warningColor),
                    SizedBox(width: 2),
                    Text(
                      "${product["rating"]} (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                // Price and Status
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if ((product["discount"] as int) > 0) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(product["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                    Spacer(),
                    if (!(product["inStock"] as bool))
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Out of Stock",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: dangerColor,
                          ),
                        ),
                      )
                    else if (product["fastDelivery"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Fast Delivery",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: successColor,
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
    );
  }
}
