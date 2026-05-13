import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart6View extends StatefulWidget {
  @override
  State<GrlCart6View> createState() => _GrlCart6ViewState();
}

class _GrlCart6ViewState extends State<GrlCart6View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Smartphone Pro Max",
      "brand": "TechBrand",
      "price": 1299.99,
      "originalPrice": 1399.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=1&keyword=phone",
      "storage": "256GB",
      "color": "Space Gray",
      "warranty": "2 Years",
      "features": ["5G", "Wireless Charging", "Face ID"],
      "inStock": true,
    },
    {
      "id": 2,
      "name": "Wireless Earbuds Pro",
      "brand": "AudioTech",
      "price": 249.99,
      "originalPrice": 299.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=2&keyword=earbuds",
      "storage": "",
      "color": "White",
      "warranty": "1 Year",
      "features": ["Noise Cancelling", "Water Resistant"],
      "inStock": true,
    },
    {
      "id": 3,
      "name": "Smart Watch Series 8",
      "brand": "WearTech",
      "price": 399.99,
      "originalPrice": 449.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=3&keyword=watch",
      "storage": "32GB",
      "color": "Midnight",
      "warranty": "1 Year",
      "features": ["GPS", "Health Monitoring", "Water Proof"],
      "inStock": false,
    },
  ];

  List<Map<String, dynamic>> accessories = [
    {
      "id": 4,
      "name": "Wireless Charger",
      "price": 49.99,
      "image": "https://picsum.photos/80/80?random=4&keyword=charger",
      "compatible": "Smartphone Pro Max",
    },
    {
      "id": 5,
      "name": "Phone Case",
      "price": 29.99,
      "image": "https://picsum.photos/80/80?random=5&keyword=case",
      "compatible": "Smartphone Pro Max",
    },
    {
      "id": 6,
      "name": "Screen Protector",
      "price": 19.99,
      "image": "https://picsum.photos/80/80?random=6&keyword=screen",
      "compatible": "Smartphone Pro Max",
    },
  ];

  String selectedWarranty = "standard";
  List<Map<String, dynamic>> warrantyOptions = [
    {
      "id": "standard",
      "name": "Standard Warranty",
      "description": "Included with purchase",
      "price": 0.0,
      "duration": "1-2 Years",
    },
    {
      "id": "extended",
      "name": "Extended Warranty",
      "description": "Additional 2 years coverage",
      "price": 199.99,
      "duration": "3-4 Years Total",
    },
    {
      "id": "premium",
      "name": "Premium Care",
      "description": "Accidental damage + extended",
      "price": 299.99,
      "duration": "3-4 Years + Accidents",
    },
  ];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get warrantyPrice {
    final selected = warrantyOptions.firstWhere((w) => w["id"] == selectedWarranty);
    return selected["price"] as double;
  }

  double get tax {
    return (subtotal + warrantyPrice) * 0.08;
  }

  double get total {
    return subtotal + warrantyPrice + tax;
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

  void _addAccessory(Map<String, dynamic> accessory) {
    cartItems.add({
      "id": accessory["id"],
      "name": accessory["name"],
      "brand": "Accessory",
      "price": accessory["price"],
      "originalPrice": accessory["price"],
      "quantity": 1,
      "image": accessory["image"],
      "storage": "",
      "color": "Default",
      "warranty": "1 Year",
      "features": ["Compatible"],
      "inStock": true,
    });
    accessories.removeWhere((acc) => acc["id"] == accessory["id"]);
    setState(() {});
    ss("${accessory["name"]} added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tech Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              //navigateTo('compare')
            },
          ),
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: () {
              //navigateTo('support')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTechCartHeader(),
            _buildCartItems(),
            _buildWarrantyOptions(),
            if (accessories.isNotEmpty) _buildAccessories(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildCheckoutBar(),
    );
  }

  Widget _buildTechCartHeader() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tech Shopping Cart",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${cartItems.length} premium devices",
                  style: TextStyle(
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Text(
                  "Warranty",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: List.generate(cartItems.length, (index) {
          final item = cartItems[index];
          return _buildCartItem(item, index);
        }),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${item["image"]}",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (!(item["inStock"] as bool))
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Out of Stock",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item["brand"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
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
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        if ((item["storage"] as String).isNotEmpty)
                          _buildSpecChip("${item["storage"]}"),
                        SizedBox(width: spSm),
                        _buildSpecChip("${item["color"]}"),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 14,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${item["warranty"]} Warranty",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 18,
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
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  size: 16,
                  color: infoColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Features: ${(item["features"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
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

  Widget _buildWarrantyOptions() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Protection Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...List.generate(warrantyOptions.length, (index) {
            final option = warrantyOptions[index];
            final isSelected = selectedWarranty == option["id"];
            
            return GestureDetector(
              onTap: () {
                selectedWarranty = option["id"] as String;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? primaryColor : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${option["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? primaryColor : Colors.black,
                            ),
                          ),
                          Text(
                            "${option["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${option["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      (option["price"] as double) == 0
                          ? "FREE"
                          : "+\$${((option["price"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (option["price"] as double) == 0
                            ? successColor
                            : (isSelected ? primaryColor : Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAccessories() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Accessories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(accessories.length, (index) {
              final accessory = accessories[index];
              return _buildAccessoryItem(accessory);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessoryItem(Map<String, dynamic> accessory) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${accessory["image"]}",
              width: double.infinity,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${accessory["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "For ${accessory["compatible"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${((accessory["price"] as double)).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => _addAccessory(accessory),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
          if (warrantyPrice > 0)
            _buildSummaryRow("Protection Plan", "\$${warrantyPrice.currency}"),
          _buildSummaryRow("Tax", "\$${tax.currency}"),
          _buildSummaryRow("Shipping", "FREE", color: successColor),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total", 
            "\$${total.currency}",
            isTotal: true,
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Free express shipping on tech orders over \$500",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
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
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
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
        child: QButton(
          label: "Secure Checkout • \$${total.currency}",
          onPressed: () {
            //navigateTo('checkout')
          },
        ),
      ),
    );
  }
}
