import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart1View extends StatefulWidget {
  @override
  State<GrlCart1View> createState() => _GrlCart1ViewState();
}

class _GrlCart1ViewState extends State<GrlCart1View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Premium Headphones",
      "price": 299.99,
      "originalPrice": 399.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "color": "Black",
      "size": "One Size",
      "inStock": true,
    },
    {
      "id": 2,
      "name": "Wireless Speaker",
      "price": 149.99,
      "originalPrice": 199.99,
      "quantity": 2,
      "image": "https://picsum.photos/80/80?random=2&keyword=speaker",
      "color": "Blue",
      "size": "Medium",
      "inStock": true,
    },
    {
      "id": 3,
      "name": "Smart Watch",
      "price": 249.99,
      "originalPrice": 299.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=3&keyword=watch",
      "color": "Silver",
      "size": "42mm",
      "inStock": false,
    },
  ];

  String promoCode = "";
  double deliveryFee = 15.99;
  double discount = 0.0;
  bool freeDelivery = false;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get total {
    return subtotal + (freeDelivery ? 0 : deliveryFee) - discount;
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(index);
      return;
    }
    cartItems[index]["quantity"] = newQuantity;
    setState(() {});
  }

  void _removeItem(int index) {
    cartItems.removeAt(index);
    setState(() {});
    ss("Item removed from cart");
  }

  void _applyPromoCode() {
    if (promoCode.toLowerCase() == "save20") {
      discount = subtotal * 0.2;
      ss("Promo code applied! 20% discount");
    } else if (promoCode.toLowerCase() == "freedel") {
      freeDelivery = true;
      ss("Free delivery applied!");
    } else {
      se("Invalid promo code");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: () async {
                bool isConfirmed = await confirm("Clear all items from cart?");
                if (isConfirmed) {
                  cartItems.clear();
                  setState(() {});
                  ss("Cart cleared");
                }
              },
              child: Text(
                "Clear All",
                style: TextStyle(
                  color: dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: cartItems.isNotEmpty ? _buildCheckoutBar() : null,
    );
  }

  Widget _buildEmptyCart() {
    return Center(
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
            "Your cart is empty",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Add some items to get started",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            width: 200,
            child: QButton(
              label: "Start Shopping",
              onPressed: () {
                //navigateTo('shop')
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Items (${cartItems.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...List.generate(cartItems.length, (index) {
            final item = cartItems[index];
            return _buildCartItem(item, index);
          }),
          SizedBox(height: spLg),
          _buildPromoCodeSection(),
          SizedBox(height: spLg),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _removeItem(index),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Color: ${item["color"]} • Size: ${item["size"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                if (!(item["inStock"] as bool))
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Out of Stock",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "In Stock",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${((item["price"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if ((item["originalPrice"] as double) > (item["price"] as double))
                          Text(
                            "\$${((item["originalPrice"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    _buildQuantitySelector(item, index),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) - 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.remove,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "${item["quantity"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) + 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.add,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter promo code",
                  value: promoCode,
                  hint: "e.g. SAVE20, FREEDEL",
                  onChanged: (value) {
                    promoCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: promoCode.isNotEmpty ? _applyPromoCode : null,
              ),
            ],
          ),
          if (discount > 0 || freeDelivery)
            Container(
              margin: EdgeInsets.only(top: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    discount > 0 
                        ? "20% discount applied"
                        : "Free delivery applied",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Subtotal", "\$${subtotal.currency}"),
          _buildSummaryRow(
            "Delivery", 
            freeDelivery ? "Free" : "\$${deliveryFee.currency}",
            color: freeDelivery ? successColor : null,
          ),
          if (discount > 0)
            _buildSummaryRow(
              "Discount", 
              "-\$${discount.currency}",
              color: successColor,
            ),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total", 
            "\$${total.currency}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${total.currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Proceed to Checkout",
                onPressed: () {
                  //navigateTo('checkout')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
