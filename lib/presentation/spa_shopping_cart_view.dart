import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaShoppingCartView extends StatefulWidget {
  const SpaShoppingCartView({super.key});

  @override
  State<SpaShoppingCartView> createState() => _SpaShoppingCartViewState();
}

class _SpaShoppingCartViewState extends State<SpaShoppingCartView> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Luxury Facial Treatment",
      "category": "Facial",
      "price": 120.0,
      "originalPrice": 150.0,
      "image": "https://picsum.photos/100/100?random=1&keyword=spa",
      "quantity": 1,
      "duration": "90 min",
      "selectedDate": "2024-03-25",
      "selectedTime": "14:00",
      "package": "Premium Package",
      "therapist": "Sarah Johnson",
      "discount": 20,
    },
    {
      "id": 2,
      "name": "Hot Stone Massage",
      "category": "Massage",
      "price": 180.0,
      "originalPrice": 200.0,
      "image": "https://picsum.photos/100/100?random=2&keyword=massage",
      "quantity": 1,
      "duration": "75 min",
      "selectedDate": "2024-03-26",
      "selectedTime": "16:00",
      "package": "Standard Package",
      "therapist": "Michael Chen",
      "discount": 10,
    },
    {
      "id": 3,
      "name": "Aromatherapy Body Wrap",
      "category": "Body",
      "price": 95.0,
      "originalPrice": 110.0,
      "image": "https://picsum.photos/100/100?random=3&keyword=aromatherapy",
      "quantity": 2,
      "duration": "60 min",
      "selectedDate": "2024-03-27",
      "selectedTime": "10:00",
      "package": "Basic Package",
      "therapist": "Emma Wilson",
      "discount": 15,
    },
  ];

  String promoCode = "";
  double promoDiscount = 0.0;
  bool isPromoApplied = false;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get totalDiscount {
    double itemDiscounts = cartItems.fold(0.0, (sum, item) {
      final originalPrice = item["originalPrice"] as double;
      final currentPrice = item["price"] as double;
      final quantity = item["quantity"] as int;
      return sum + ((originalPrice - currentPrice) * quantity);
    });
    return itemDiscounts + promoDiscount;
  }

  double get tax {
    return subtotal * 0.08; // 8% tax
  }

  double get total {
    return subtotal + tax - promoDiscount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                _showClearCartDialog();
              },
            ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: cartItems.isEmpty 
          ? null 
          : Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowLg],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: \$${total.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${cartItems.length} items",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Proceed to Checkout",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to checkout
                      },
                    ),
                  ),
                ],
              ),
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
              size: 120,
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
              "Add some spa services to get started",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Browse Services",
              size: bs.md,
              onPressed: () {
                // Navigate to product list
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart Items
          Column(
            children: cartItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Image
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            image: DecorationImage(
                              image: NetworkImage("${item["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Service Details
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
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _removeItem(item["id"] as int);
                                    },
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
                                "${item["package"]} • ${item["duration"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["therapist"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              Row(
                                children: [
                                  if ((item["originalPrice"] as double) > (item["price"] as double))
                                    Text(
                                      "\$${(item["originalPrice"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  if ((item["originalPrice"] as double) > (item["price"] as double))
                                    SizedBox(width: spXs),
                                  Text(
                                    "\$${(item["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  
                                  // Quantity Controls
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: disabledOutlineBorderColor),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if ((item["quantity"] as int) > 1) {
                                              item["quantity"] = (item["quantity"] as int) - 1;
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(spXs),
                                            child: Icon(
                                              Icons.remove,
                                              size: 16,
                                              color: (item["quantity"] as int) > 1 
                                                  ? primaryColor 
                                                  : disabledColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          child: Text(
                                            "${item["quantity"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            item["quantity"] = (item["quantity"] as int) + 1;
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(spXs),
                                            child: Icon(
                                              Icons.add,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Appointment Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${item["selectedDate"]} at ${item["selectedTime"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _editAppointment(item);
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
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
            }).toList(),
          ),
          
          // Promo Code Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Promo Code",
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
                      label: isPromoApplied ? "Applied" : "Apply",
                      size: bs.sm,
                      onPressed: isPromoApplied ? null : () {
                        _applyPromoCode();
                      },
                    ),
                  ],
                ),
                
                if (isPromoApplied)
                  Padding(
                    padding: EdgeInsets.only(top: spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Promo code applied! \$${promoDiscount.currency} off",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Order Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary",
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
                    Text(
                      "Subtotal",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${subtotal.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                if (totalDiscount > 0)
                  Padding(
                    padding: EdgeInsets.only(top: spXs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "-\$${totalDiscount.currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                SizedBox(height: spXs),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tax (8%)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${tax.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                Divider(color: disabledOutlineBorderColor),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${total.currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spXl),
        ],
      ),
    );
  }

  void _removeItem(int itemId) {
    setState(() {
      cartItems.removeWhere((item) => item["id"] == itemId);
    });
    ss("Service removed from cart");
  }

  void _showClearCartDialog() async {
    bool isConfirmed = await confirm("Are you sure you want to clear your cart?");
    if (isConfirmed) {
      setState(() {
        cartItems.clear();
      });
      ss("Cart cleared");
    }
  }

  void _applyPromoCode() {
    if (promoCode.toLowerCase() == "spa20") {
      promoDiscount = subtotal * 0.20;
      isPromoApplied = true;
      setState(() {});
      ss("Promo code applied successfully!");
    } else if (promoCode.toLowerCase() == "welcome10") {
      promoDiscount = 10.0;
      isPromoApplied = true;
      setState(() {});
      ss("Welcome discount applied!");
    } else {
      se("Invalid promo code");
    }
  }

  void _editAppointment(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusXl),
              topRight: Radius.circular(radiusXl),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "Reschedule Appointment",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                QDatePicker(
                  label: "Select Date",
                  value: DateTime.parse(item["selectedDate"]),
                  onChanged: (date) {
                    item["selectedDate"] = date.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spMd),
                
                QTimePicker(
                  label: "Select Time",
                  value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${item["selectedTime"]}:00")),
                  onChanged: (time) {
                    item["selectedTime"] = time!.kkmm;
                    setState(() {});
                  },
                ),
                
                Spacer(),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Appointment",
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Appointment updated successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
