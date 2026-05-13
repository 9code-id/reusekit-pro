import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMedicineCartView extends StatefulWidget {
  const MhaMedicineCartView({super.key});

  @override
  State<MhaMedicineCartView> createState() => _MhaMedicineCartViewState();
}

class _MhaMedicineCartViewState extends State<MhaMedicineCartView> {
  bool loading = false;
  String promoCode = "";
  bool fastDelivery = false;
  
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Paracetamol 500mg",
      "manufacturer": "GSK Pharmaceuticals",
      "image": "https://picsum.photos/80/80?random=1&keyword=medicine",
      "price": 25.50,
      "originalPrice": 30.00,
      "quantity": 2,
      "prescription": false,
      "inStock": true,
      "discount": 15,
      "expiryDate": "2025-12-15",
      "description": "Pain relief and fever reducer"
    },
    {
      "id": 2,
      "name": "Amoxicillin 250mg",
      "manufacturer": "Cipla Limited",
      "image": "https://picsum.photos/80/80?random=2&keyword=medicine",
      "price": 45.00,
      "originalPrice": 50.00,
      "quantity": 1,
      "prescription": true,
      "inStock": true,
      "discount": 10,
      "expiryDate": "2025-10-20",
      "description": "Antibiotic for bacterial infections"
    },
    {
      "id": 3,
      "name": "Vitamin D3 Tablets",
      "manufacturer": "Sun Pharma",
      "image": "https://picsum.photos/80/80?random=3&keyword=vitamin",
      "price": 18.75,
      "originalPrice": 25.00,
      "quantity": 3,
      "prescription": false,
      "inStock": false,
      "discount": 25,
      "expiryDate": "2026-03-10",
      "description": "Bone health supplement"
    }
  ];

  List<Map<String, dynamic>> promoCodes = [
    {
      "code": "HEALTH20",
      "discount": 20,
      "minOrder": 100.0,
      "description": "20% off on orders above \$100"
    },
    {
      "code": "NEWUSER",
      "discount": 15,
      "minOrder": 50.0,
      "description": "15% off for new users"
    },
    {
      "code": "FASTDEL",
      "discount": 10,
      "minOrder": 75.0,
      "description": "10% off + free fast delivery"
    }
  ];

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get deliveryFee => fastDelivery ? 15.0 : 5.0;
  double get discount => subtotal * 0.15; // Applied promo discount
  double get total => subtotal + deliveryFee - discount;

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(index);
      return;
    }
    
    cartItems[index]["quantity"] = newQuantity;
    setState(() {});
    ss("Quantity updated");
  }

  void _removeItem(int index) {
    cartItems.removeAt(index);
    setState(() {});
    ss("Item removed from cart");
  }

  void _applyPromoCode() {
    if (promoCode.isEmpty) {
      se("Please enter a promo code");
      return;
    }
    
    var validPromo = promoCodes.firstWhere(
      (promo) => promo["code"] == promoCode.toUpperCase(),
      orElse: () => {},
    );
    
    if (validPromo.isEmpty) {
      se("Invalid promo code");
      return;
    }
    
    if (subtotal < (validPromo["minOrder"] as double)) {
      se("Minimum order value not met");
      return;
    }
    
    ss("Promo code applied successfully!");
    setState(() {});
  }

  void _proceedToCheckout() async {
    if (cartItems.isEmpty) {
      se("Your cart is empty");
      return;
    }
    
    bool hasOutOfStock = cartItems.any((item) => !(item["inStock"] as bool));
    if (hasOutOfStock) {
      se("Some items are out of stock");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Proceeding to checkout");
    // ss('Next page'));
  }

  void _showPromoCodeOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Promo Codes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...promoCodes.map((promo) => GestureDetector(
              onTap: () {
                promoCode = promo["code"];
                setState(() {});
                Navigator.pop(context);
                _applyPromoCode();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${promo["code"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${promo["discount"]}% OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${promo["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
            SizedBox(height: spSm),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ss("Cart refreshed");
            },
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) :
        cartItems.isEmpty ?
          _buildEmptyCart() :
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDeliveryOptions(),
                      SizedBox(height: spMd),
                      _buildCartItems(),
                      SizedBox(height: spMd),
                      _buildPromoCodeSection(),
                      SizedBox(height: spMd),
                      _buildPriceBreakdown(),
                    ],
                  ),
                ),
              ),
              _buildBottomBar(),
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
              size: 100,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "Your cart is empty",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Add medicines to your cart to get started",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Browse Medicines",
              size: bs.md,
              onPressed: () {
                back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    fastDelivery = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: !fastDelivery ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: !fastDelivery ? primaryColor : Colors.grey[300]!,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: !fastDelivery ? Colors.white : disabledBoldColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Standard",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !fastDelivery ? Colors.white : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "3-5 days • \$5.00",
                          style: TextStyle(
                            fontSize: 12,
                            color: !fastDelivery ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    fastDelivery = true;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: fastDelivery ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: fastDelivery ? primaryColor : Colors.grey[300]!,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.bolt,
                          color: fastDelivery ? Colors.white : disabledBoldColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Fast",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: fastDelivery ? Colors.white : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "1-2 days • \$15.00",
                          style: TextStyle(
                            fontSize: 12,
                            color: fastDelivery ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cart Items (${cartItems.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...cartItems.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> item = entry.value;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [shadowSm],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusXs),
                    image: DecorationImage(
                      image: NetworkImage("${item["image"]}"),
                      fit: BoxFit.cover,
                    ),
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
                              "${item["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                            ),
                          ),
                          if (!(item["inStock"] as bool))
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Out of Stock",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${item["manufacturer"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      if (item["prescription"] as bool) ...[
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.medical_services, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "Prescription Required",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "\$${((item["price"] as double)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: fsH6,
                            ),
                          ),
                          SizedBox(width: spXs),
                          if ((item["originalPrice"] as double) > (item["price"] as double))
                            Text(
                              "\$${((item["originalPrice"] as double)).toStringAsFixed(2)}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          if ((item["discount"] as int) > 0) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["discount"]}% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => _updateQuantity(index, (item["quantity"] as int) - 1),
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    child: Icon(Icons.remove, size: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  child: Text(
                                    "${item["quantity"]}",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _updateQuantity(index, (item["quantity"] as int) + 1),
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    child: Icon(Icons.add, size: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => _removeItem(index),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                color: dangerColor,
                                size: 20,
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
        }).toList(),
      ],
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer, color: successColor),
              SizedBox(width: spXs),
              Text(
                "Promo Code",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _showPromoCodeOptions,
                child: Text(
                  "View Available",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter promo code",
                  value: promoCode,
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
                onPressed: _applyPromoCode,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal"),
              Text("\$${subtotal.toStringAsFixed(2)}"),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delivery Fee"),
              Text("\$${deliveryFee.toStringAsFixed(2)}"),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Discount", style: TextStyle(color: successColor)),
              Text("-\$${discount.toStringAsFixed(2)}", style: TextStyle(color: successColor)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fsH6,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fsH6,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total: \$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${cartItems.length} items in cart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          QButton(
            label: "Proceed to Checkout",
            size: bs.md,
            onPressed: _proceedToCheckout,
          ),
        ],
      ),
    );
  }
}
