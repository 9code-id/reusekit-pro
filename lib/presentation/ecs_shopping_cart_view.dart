import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsShoppingCartView extends StatefulWidget {
  const EcsShoppingCartView({super.key});

  @override
  State<EcsShoppingCartView> createState() => _EcsShoppingCartViewState();
}

class _EcsShoppingCartViewState extends State<EcsShoppingCartView> {
  List<String> selectedItems = [];
  bool selectMode = false;
  String promoCode = "";
  bool promoApplied = false;
  double promoDiscount = 0.0;
  
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Apple iPhone 15 Pro Max 256GB",
      "brand": "Apple",
      "price": 1199.99,
      "original_price": 1299.99,
      "quantity": 1,
      "image": "https://picsum.photos/300/300?random=1&keyword=iphone",
      "in_stock": true,
      "color": "Natural Titanium",
      "storage": "256GB",
      "max_quantity": 5,
    },
    {
      "id": 2,
      "name": "Sony WH-1000XM5 Headphones",
      "brand": "Sony",
      "price": 329.99,
      "original_price": 399.99,
      "quantity": 2,
      "image": "https://picsum.photos/300/300?random=4&keyword=headphones",
      "in_stock": true,
      "color": "Black",
      "max_quantity": 10,
    },
    {
      "id": 3,
      "name": "iPad Air 11-inch M2 Wi-Fi 256GB",
      "brand": "Apple",
      "price": 749.99,
      "original_price": 799.99,
      "quantity": 1,
      "image": "https://picsum.photos/300/300?random=5&keyword=ipad",
      "in_stock": false,
      "color": "Space Gray",
      "storage": "256GB",
      "max_quantity": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          if (cartItems.isNotEmpty) ...[
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
      body: cartItems.isEmpty 
        ? _buildEmptyCart()
        : Column(
        children: [
          // Cart Statistics
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
                  "${cartItems.length} items in cart",
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
                      "You save \$${_calculateTotalSavings().toStringAsFixed(2)}",
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
                    onTap: () => _moveToWishlist(),
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
                            Icons.favorite,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Move to Wishlist",
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

          // Cart Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return _buildCartItem(item);
              },
            ),
          ),

          // Promo Code Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Promo Code",
                        value: promoCode,
                        hint: "Enter promo code",
                        onChanged: (value) {
                          promoCode = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: promoApplied ? "Applied" : "Apply",
                      icon: promoApplied ? Icons.check : Icons.local_offer,
                      size: bs.sm,
                      onPressed: promoApplied ? null : () => _applyPromoCode(),
                    ),
                  ],
                ),
                
                if (promoApplied) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Promo code applied! You saved \$${promoDiscount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _removePromoCode(),
                          child: Icon(
                            Icons.close,
                            color: successColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Order Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal:"),
                    Text(
                      "\$${_calculateSubtotal().toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                if (promoApplied) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Promo Discount:",
                        style: TextStyle(color: successColor),
                      ),
                      Text(
                        "-\$${promoDiscount.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                ],
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping:"),
                    Text(
                      "FREE",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Divider(),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${_calculateTotal().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                QButton(
                  label: "Proceed to Checkout",
                  icon: Icons.arrow_forward,
                  size: bs.md,
                  onPressed: _hasInStockItems() ? () => _proceedToCheckout() : null,
                ),
                
                if (!_hasInStockItems()) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Some items are out of stock. Remove them to continue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "Your Cart is Empty",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Looks like you haven't added anything to your cart yet. Start shopping to add items here!",
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

  Widget _buildCartItem(Map<String, dynamic> item) {
    final itemId = "${item["id"]}";
    final isSelected = selectedItems.contains(itemId);
    final inStock = item["in_stock"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: selectMode && isSelected
          ? Border.all(color: primaryColor, width: 2)
          : !inStock
            ? Border.all(color: dangerColor.withAlpha(77), width: 1)
            : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Selection Checkbox
              if (selectMode) ...[
                GestureDetector(
                  onTap: () => _toggleSelection(itemId),
                  child: Container(
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
                  
                  if (!inStock)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "OUT OF\nSTOCK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
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

                    // Variants
                    if (item.containsKey("color")) ...[
                      Text(
                        "Color: ${item["color"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                    if (item.containsKey("storage")) ...[
                      Text(
                        "Storage: ${item["storage"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],

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
                  ],
                ),
              ),

              // Remove Button
              if (!selectMode)
                GestureDetector(
                  onTap: () => _removeFromCart(item),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(26),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      size: 16,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: spMd),

          // Quantity and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity Controls
              Row(
                children: [
                  GestureDetector(
                    onTap: inStock && (item["quantity"] as int) > 1 
                      ? () => _updateQuantity(item, (item["quantity"] as int) - 1)
                      : null,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: inStock && (item["quantity"] as int) > 1 
                          ? primaryColor 
                          : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  
                  Container(
                    width: 60,
                    child: Text(
                      "${item["quantity"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: inStock && (item["quantity"] as int) < (item["max_quantity"] as int)
                      ? () => _updateQuantity(item, (item["quantity"] as int) + 1)
                      : null,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: inStock && (item["quantity"] as int) < (item["max_quantity"] as int)
                          ? primaryColor 
                          : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),

              // Move to Wishlist
              if (!selectMode)
                GestureDetector(
                  onTap: () => _moveItemToWishlist(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Move to Wishlist",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateSubtotal() {
    return cartItems.fold(0.0, (total, item) {
      return total + ((item["price"] as double) * (item["quantity"] as int));
    });
  }

  double _calculateTotalSavings() {
    return cartItems.fold(0.0, (total, item) {
      final originalPrice = item["original_price"] as double;
      final currentPrice = item["price"] as double;
      final quantity = item["quantity"] as int;
      return total + ((originalPrice - currentPrice) * quantity);
    });
  }

  double _calculateTotal() {
    return _calculateSubtotal() - promoDiscount;
  }

  bool _hasInStockItems() {
    return cartItems.any((item) => item["in_stock"] as bool);
  }

  void _toggleSelection(String itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
    }
    setState(() {});
  }

  void _updateQuantity(Map<String, dynamic> item, int newQuantity) {
    item["quantity"] = newQuantity;
    setState(() {});
  }

  void _removeFromCart(Map<String, dynamic> item) {
    cartItems.remove(item);
    setState(() {});
    ss("${item["name"]} removed from cart");
  }

  void _moveItemToWishlist(Map<String, dynamic> item) {
    cartItems.remove(item);
    setState(() {});
    ss("${item["name"]} moved to wishlist");
  }

  void _moveToWishlist() {
    cartItems.removeWhere((item) => selectedItems.contains("${item["id"]}"));
    selectedItems.clear();
    selectMode = false;
    setState(() {});
    ss("Selected items moved to wishlist");
  }

  void _removeSelected() {
    cartItems.removeWhere((item) => selectedItems.contains("${item["id"]}"));
    selectedItems.clear();
    selectMode = false;
    setState(() {});
    ss("Selected items removed from cart");
  }

  void _applyPromoCode() {
    if (promoCode.trim().isNotEmpty) {
      // Simulate promo code validation
      promoApplied = true;
      promoDiscount = 50.0; // Example discount
      setState(() {});
      ss("Promo code applied successfully!");
    }
  }

  void _removePromoCode() {
    promoApplied = false;
    promoDiscount = 0.0;
    promoCode = "";
    setState(() {});
    ss("Promo code removed");
  }

  void _proceedToCheckout() {
    // Navigate to checkout
    ss("Proceeding to checkout...");
  }
}
