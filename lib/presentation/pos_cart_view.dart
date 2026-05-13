import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCartView extends StatefulWidget {
  const PosCartView({super.key});

  @override
  State<PosCartView> createState() => _PosCartViewState();
}

class _PosCartViewState extends State<PosCartView> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Premium Coffee Beans",
      "price": 24.99,
      "quantity": 2,
      "stock": 150,
      "barcode": "123456789012",
      "image": "https://picsum.photos/200/200?random=1&keyword=coffee",
      "category": "Food & Beverage",
      "discount": 0.0,
      "notes": "",
    },
    {
      "id": 2,
      "name": "Wireless Headphones",
      "price": 89.99,
      "quantity": 1,
      "stock": 75,
      "barcode": "123456789013",
      "image": "https://picsum.photos/200/200?random=2&keyword=headphones",
      "category": "Electronics",
      "discount": 5.0,
      "notes": "Customer requested black color",
    },
    {
      "id": 3,
      "name": "Cotton T-Shirt",
      "price": 19.99,
      "quantity": 3,
      "stock": 200,
      "barcode": "123456789014",
      "image": "https://picsum.photos/200/200?random=3&keyword=tshirt",
      "category": "Clothing",
      "discount": 0.0,
      "notes": "",
    },
    {
      "id": 4,
      "name": "Hand Sanitizer",
      "price": 5.99,
      "quantity": 2,
      "stock": 500,
      "barcode": "123456789015",
      "image": "https://picsum.photos/200/200?random=4&keyword=sanitizer",
      "category": "Health & Beauty",
      "discount": 0.0,
      "notes": "",
    },
    {
      "id": 5,
      "name": "Indoor Plant Pot",
      "price": 12.99,
      "quantity": 1,
      "stock": 80,
      "barcode": "123456789016",
      "image": "https://picsum.photos/200/200?random=5&keyword=plant",
      "category": "Home & Garden",
      "discount": 1.50,
      "notes": "",
    },
  ];

  String customerName = "";
  String customerPhone = "";
  String orderNotes = "";
  String discountCode = "";
  double globalDiscountAmount = 0.0;
  String globalDiscountType = "percentage";

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) {
      double itemTotal = (item["price"] as double) * (item["quantity"] as int);
      return sum + itemTotal - (item["discount"] as double);
    });
  }

  double get totalDiscount {
    double itemDiscounts = cartItems.fold(0.0, (sum, item) => sum + (item["discount"] as double));
    return itemDiscounts + globalDiscountAmount;
  }

  double get taxAmount {
    return (subtotal - globalDiscountAmount) * 0.085; // 8.5% tax
  }

  double get totalAmount {
    return subtotal + taxAmount - globalDiscountAmount;
  }

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + (item["quantity"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate back to product selection
              back();
            },
          ),
          QButton(
            icon: Icons.delete_outline,
            size: bs.sm,
            onPressed: _clearCart,
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Cart Items
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart Header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Cart Items",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$totalItems items",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cart Items List
                  Expanded(
                    child: cartItems.isEmpty ?
                      Container(
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 80,
                                color: disabledBoldColor,
                              ),
                              SizedBox(height: spMd),
                              Text(
                                "Your cart is empty",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Add products to get started",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spMd),
                              QButton(
                                label: "Browse Products",
                                size: bs.md,
                                onPressed: () => back(),
                              ),
                            ],
                          ),
                        ),
                      ) :
                      SingleChildScrollView(
                        child: Column(
                          children: cartItems.map((item) => _buildCartItem(item)).toList(),
                        ),
                      ),
                  ),

                  // Quick Actions
                  if (cartItems.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Save Cart",
                              size: bs.sm,
                              onPressed: _saveCart,
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Load Cart",
                              size: bs.sm,
                              onPressed: _loadCart,
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Print List",
                              size: bs.sm,
                              onPressed: _printCartList,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Right Panel - Order Details
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Order Summary Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Order Details
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spMd,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Customer Information
                        Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            QTextField(
                              label: "Customer Name",
                              value: customerName,
                              hint: "Enter customer name",
                              onChanged: (value) {
                                customerName = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: "Phone Number",
                              value: customerPhone,
                              hint: "+1 (555) 123-4567",
                              onChanged: (value) {
                                customerPhone = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),

                        // Global Discount
                        Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Apply Discount",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                Expanded(
                                  child: QTextField(
                                    label: "Discount Code",
                                    value: discountCode,
                                    hint: "Enter promo code",
                                    onChanged: (value) {
                                      discountCode = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                QButton(
                                  label: "Apply",
                                  size: bs.sm,
                                  onPressed: _applyGlobalDiscount,
                                ),
                              ],
                            ),
                            if (globalDiscountAmount > 0)
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: Colors.green[200]!),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.discount,
                                      color: Colors.green[600],
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "Discount: -\$${globalDiscountAmount.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _removeGlobalDiscount,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.green[600],
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),

                        // Order Notes
                        QMemoField(
                          label: "Order Notes",
                          value: orderNotes,
                          hint: "Add special instructions...",
                          onChanged: (value) {
                            orderNotes = value;
                            setState(() {});
                          },
                        ),

                        // Price Breakdown
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  Text("Subtotal ($totalItems items):"),
                                  Spacer(),
                                  Text("\$${subtotal.toStringAsFixed(2)}"),
                                ],
                              ),
                              if (totalDiscount > 0)
                                Row(
                                  children: [
                                    Text(
                                      "Total Discounts:",
                                      style: TextStyle(color: Colors.green[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "-\$${totalDiscount.toStringAsFixed(2)}",
                                      style: TextStyle(color: Colors.green[600]),
                                    ),
                                  ],
                                ),
                              Row(
                                children: [
                                  Text("Tax (8.5%):"),
                                  Spacer(),
                                  Text("\$${taxAmount.toStringAsFixed(2)}"),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${totalAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                if (cartItems.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Proceed to Checkout",
                            size: bs.md,
                            onPressed: _proceedToCheckout,
                          ),
                        ),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Hold Order",
                                size: bs.sm,
                                onPressed: _holdOrder,
                              ),
                            ),
                            Expanded(
                              child: QButton(
                                label: "Quote",
                                size: bs.sm,
                                onPressed: _generateQuote,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    double itemTotal = (item["price"] as double) * (item["quantity"] as int);
    double itemDiscount = item["discount"] as double;
    double finalTotal = itemTotal - itemDiscount;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          // Product Details
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${item["category"]} | ${item["barcode"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (item["notes"].toString().isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${item["notes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(2)} each",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    if (itemDiscount > 0) ...[
                      SizedBox(width: spSm),
                      Text(
                        "Save \$${itemDiscount.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            spacing: spXs,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _updateQuantity(item["id"], -1),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: Text(
                      "${item["quantity"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _updateQuantity(item["id"], 1),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              Text(
                "\$${finalTotal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              // Item Actions
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: spXs,
                children: [
                  GestureDetector(
                    onTap: () => _addItemDiscount(item),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.local_offer,
                        size: 16,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _addItemNote(item),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.note_add,
                        size: 16,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeItem(item["id"]),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateQuantity(int itemId, int change) {
    int index = cartItems.indexWhere((item) => item["id"] == itemId);
    if (index != -1) {
      int newQuantity = (cartItems[index]["quantity"] as int) + change;
      if (newQuantity > 0) {
        cartItems[index]["quantity"] = newQuantity;
        setState(() {});
      } else {
        _removeItem(itemId);
      }
    }
  }

  void _removeItem(int itemId) async {
    bool isConfirmed = await confirm("Remove this item from cart?");
    if (isConfirmed) {
      cartItems.removeWhere((item) => item["id"] == itemId);
      setState(() {});
      ss("Item removed from cart");
    }
  }

  void _addItemDiscount(Map<String, dynamic> item) {
    // This would typically open a discount dialog
    double currentDiscount = item["discount"] as double;
    double newDiscount = currentDiscount + 2.50; // Example: add \$2.50 discount
    
    int index = cartItems.indexWhere((i) => i["id"] == item["id"]);
    if (index != -1) {
      cartItems[index]["discount"] = newDiscount;
      setState(() {});
      ss("Item discount applied");
    }
  }

  void _addItemNote(Map<String, dynamic> item) {
    // This would typically open a note dialog
    int index = cartItems.indexWhere((i) => i["id"] == item["id"]);
    if (index != -1) {
      cartItems[index]["notes"] = "Special handling required";
      setState(() {});
      ss("Note added to item");
    }
  }

  void _applyGlobalDiscount() {
    if (discountCode.isNotEmpty) {
      if (discountCode.toLowerCase() == "save10") {
        globalDiscountAmount = subtotal * 0.10;
        globalDiscountType = "percentage";
        ss("10% discount applied to entire order!");
      } else if (discountCode.toLowerCase() == "welcome15") {
        globalDiscountAmount = 15.0;
        globalDiscountType = "fixed";
        ss("\$15 discount applied to order!");
      } else {
        se("Invalid discount code");
        return;
      }
      setState(() {});
    }
  }

  void _removeGlobalDiscount() {
    discountCode = "";
    globalDiscountAmount = 0.0;
    setState(() {});
    ss("Global discount removed");
  }

  void _clearCart() async {
    bool isConfirmed = await confirm("Clear all items from cart?");
    if (isConfirmed) {
      cartItems.clear();
      setState(() {});
      ss("Cart cleared");
    }
  }

  void _saveCart() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Cart saved successfully");
  }

  void _loadCart() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Cart loaded successfully");
  }

  void _printCartList() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Cart list printed");
  }

  void _proceedToCheckout() {
    if (cartItems.isEmpty) {
      se("Cart is empty");
      return;
    }
    // Navigate to checkout
    ss("Proceeding to checkout...");
  }

  void _holdOrder() async {
    bool isConfirmed = await confirm("Hold this order for later?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Order held successfully");
    }
  }

  void _generateQuote() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Quote generated and printed");
  }
}
