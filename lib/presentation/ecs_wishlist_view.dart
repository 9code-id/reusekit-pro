import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsWishlistView extends StatefulWidget {
  const EcsWishlistView({super.key});

  @override
  State<EcsWishlistView> createState() => _EcsWishlistViewState();
}

class _EcsWishlistViewState extends State<EcsWishlistView> {
  String selectedView = "grid"; // grid or list
  List<String> selectedItems = [];
  bool selectMode = false;
  
  List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "name": "Apple iPhone 15 Pro Max 256GB",
      "brand": "Apple",
      "price": 1199.99,
      "original_price": 1299.99,
      "rating": 4.8,
      "reviews_count": 2456,
      "image": "https://picsum.photos/300/300?random=1&keyword=iphone",
      "in_stock": true,
      "added_date": "2024-06-01",
      "discount_percentage": 8,
    },
    {
      "id": 2,
      "name": "Samsung Galaxy S24 Ultra 512GB",
      "brand": "Samsung",
      "price": 1099.99,
      "original_price": 1199.99,
      "rating": 4.7,
      "reviews_count": 1893,
      "image": "https://picsum.photos/300/300?random=2&keyword=samsung",
      "in_stock": true,
      "added_date": "2024-05-28",
      "discount_percentage": 8,
    },
    {
      "id": 3,
      "name": "MacBook Pro 16-inch M3 Pro",
      "brand": "Apple",
      "price": 2499.99,
      "original_price": 2699.99,
      "rating": 4.9,
      "reviews_count": 987,
      "image": "https://picsum.photos/300/300?random=3&keyword=macbook",
      "in_stock": false,
      "added_date": "2024-05-25",
      "discount_percentage": 7,
    },
    {
      "id": 4,
      "name": "Sony WH-1000XM5 Headphones",
      "brand": "Sony",
      "price": 329.99,
      "original_price": 399.99,
      "rating": 4.8,
      "reviews_count": 1234,
      "image": "https://picsum.photos/300/300?random=4&keyword=headphones",
      "in_stock": true,
      "added_date": "2024-05-20",
      "discount_percentage": 18,
    },
    {
      "id": 5,
      "name": "iPad Air 11-inch M2 Wi-Fi 256GB",
      "brand": "Apple",
      "price": 749.99,
      "original_price": 799.99,
      "rating": 4.6,
      "reviews_count": 756,
      "image": "https://picsum.photos/300/300?random=5&keyword=ipad",
      "in_stock": true,
      "added_date": "2024-05-15",
      "discount_percentage": 6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
        actions: [
          if (wishlistItems.isNotEmpty) ...[
            IconButton(
              icon: Icon(selectedView == "grid" ? Icons.view_list : Icons.grid_view),
              onPressed: () {
                selectedView = selectedView == "grid" ? "list" : "grid";
                setState(() {});
              },
            ),
            IconButton(
              icon: Icon(selectMode ? Icons.close : Icons.checklist),
              onPressed: () {
                selectMode = !selectMode;
                selectedItems.clear();
                setState(() {});
              },
            ),
          ],
        ],
      ),
      body: wishlistItems.isEmpty 
        ? _buildEmptyWishlist()
        : Column(
        children: [
          // Statistics Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${wishlistItems.length} items in wishlist",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.savings,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Save \$${_calculateTotalSavings().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Select Mode Actions
          if (selectMode && selectedItems.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26),
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "${selectedItems.length} selected",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => _moveToCart(),
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
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Add to Cart",
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
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _removeSelected(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Remove",
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

          // Items List
          Expanded(
            child: selectedView == "grid" 
              ? _buildGridView() 
              : _buildListView(),
          ),
        ],
      ),
      bottomNavigationBar: wishlistItems.isNotEmpty && !selectMode
        ? Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add All to Cart",
                    icon: Icons.add_shopping_cart,
                    size: bs.md,
                    onPressed: () => _addAllToCart(),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.share,
                  size: bs.md,
                  onPressed: () => _shareWishlist(),
                ),
              ],
            ),
          )
        : null,
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "Your Wishlist is Empty",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Save items you love so you don't lose them. Start browsing and add your favorites here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Start Shopping",
              icon: Icons.shopping_bag,
              size: bs.md,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 160,
        children: wishlistItems.map((item) {
          return _buildGridItem(item);
        }).toList(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final item = wishlistItems[index];
        return _buildListItem(item);
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    final itemId = "${item["id"]}";
    final isSelected = selectedItems.contains(itemId);
    
    return GestureDetector(
      onTap: selectMode 
        ? () => _toggleSelection(itemId)
        : () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: selectMode && isSelected
            ? Border.all(color: primaryColor, width: 2)
            : null,
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
                    "${item["image"]}",
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),

                // Discount Badge
                if ((item["discount_percentage"] as int) > 0)
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "-${item["discount_percentage"]}%",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // Selection Checkbox or Remove Button
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: selectMode
                    ? Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      )
                    : GestureDetector(
                        onTap: () => _removeFromWishlist(item),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 16,
                            color: dangerColor,
                          ),
                        ),
                      ),
                ),

                // Stock Status
                if (!(item["in_stock"] as bool))
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: disabledBoldColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Out of Stock",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
                  Text(
                    "${item["brand"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  Text(
                    "${item["name"]}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),

                  // Price
                  Row(
                    children: [
                      Text(
                        "\$${(item["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if ((item["original_price"] as double) > (item["price"] as double)) ...[
                        SizedBox(width: spXs),
                        Text(
                          "\$${(item["original_price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: spXs),

                  // Add to Cart Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add to Cart",
                      icon: Icons.add_shopping_cart,
                      size: bs.sm,
                      onPressed: (item["in_stock"] as bool) 
                        ? () => _addToCart(item) 
                        : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> item) {
    final itemId = "${item["id"]}";
    final isSelected = selectedItems.contains(itemId);
    
    return GestureDetector(
      onTap: selectMode 
        ? () => _toggleSelection(itemId)
        : () {},
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: selectMode && isSelected
            ? Border.all(color: primaryColor, width: 2)
            : null,
        ),
        child: Row(
          children: [
            // Selection Checkbox
            if (selectMode) ...[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
              SizedBox(width: spMd),
            ],

            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${item["image"]}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                
                if ((item["discount_percentage"] as int) > 0)
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "-${item["discount_percentage"]}%",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: spMd),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item["brand"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  Text(
                    "${item["name"]}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),

                  // Price
                  Row(
                    children: [
                      Text(
                        "\$${(item["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if ((item["original_price"] as double) > (item["price"] as double)) ...[
                        SizedBox(width: spXs),
                        Text(
                          "\$${(item["original_price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Stock Status
                  if (!(item["in_stock"] as bool))
                    Container(
                      margin: EdgeInsets.only(top: spXs),
                      child: Text(
                        "Out of Stock",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Actions
            if (!selectMode)
              Column(
                children: [
                  QButton(
                    icon: Icons.add_shopping_cart,
                    size: bs.sm,
                    onPressed: (item["in_stock"] as bool) 
                      ? () => _addToCart(item) 
                      : null,
                  ),
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () => _removeFromWishlist(item),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 16,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalSavings() {
    return wishlistItems.fold(0.0, (total, item) {
      return total + ((item["original_price"] as double) - (item["price"] as double));
    });
  }

  void _toggleSelection(String itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
    }
    setState(() {});
  }

  void _addToCart(Map<String, dynamic> item) {
    ss("${item["name"]} added to cart");
  }

  void _addAllToCart() {
    final inStockItems = wishlistItems.where((item) => item["in_stock"] as bool).length;
    ss("$inStockItems items added to cart");
  }

  void _moveToCart() {
    ss("${selectedItems.length} items moved to cart");
    selectedItems.clear();
    selectMode = false;
    setState(() {});
  }

  void _removeFromWishlist(Map<String, dynamic> item) {
    wishlistItems.remove(item);
    setState(() {});
    ss("${item["name"]} removed from wishlist");
  }

  void _removeSelected() {
    wishlistItems.removeWhere((item) => selectedItems.contains("${item["id"]}"));
    selectedItems.clear();
    selectMode = false;
    setState(() {});
    ss("Selected items removed from wishlist");
  }

  void _shareWishlist() {
    ss("Wishlist shared");
  }
}
