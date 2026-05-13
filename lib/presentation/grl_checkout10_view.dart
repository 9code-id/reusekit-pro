import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout10View extends StatefulWidget {
  @override
  State<GrlCheckout10View> createState() => _GrlCheckout10ViewState();
}

class _GrlCheckout10ViewState extends State<GrlCheckout10View> {
  final formKey = GlobalKey<FormState>();
  
  // Multi-Vendor Checkout State
  Map<String, List<Map<String, dynamic>>> vendorGroups = {
    "TechWorld Electronics": [
      {
        "name": "Gaming Laptop Pro",
        "price": 1299.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=1&keyword=laptop",
        "category": "Electronics",
        "shipping": 0.0,
        "vendor": "TechWorld Electronics",
        "estimatedDelivery": "2-3 business days"
      },
      {
        "name": "Wireless Mouse Elite",
        "price": 79.99,
        "quantity": 2,
        "image": "https://picsum.photos/80/80?random=2&keyword=mouse",
        "category": "Electronics",
        "shipping": 0.0,
        "vendor": "TechWorld Electronics",
        "estimatedDelivery": "2-3 business days"
      }
    ],
    "Fashion Forward": [
      {
        "name": "Designer Handbag",
        "price": 299.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=3&keyword=handbag",
        "category": "Fashion",
        "shipping": 15.00,
        "vendor": "Fashion Forward",
        "estimatedDelivery": "5-7 business days"
      },
      {
        "name": "Premium Leather Belt",
        "price": 89.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=4&keyword=belt",
        "category": "Fashion",
        "shipping": 0.0,
        "vendor": "Fashion Forward",
        "estimatedDelivery": "5-7 business days"
      }
    ],
    "Home & Garden Co": [
      {
        "name": "Smart Home Security Camera",
        "price": 199.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=5&keyword=camera",
        "category": "Home & Garden",
        "shipping": 25.00,
        "vendor": "Home & Garden Co",
        "estimatedDelivery": "3-5 business days"
      }
    ]
  };
  
  // Shipping Addresses per Vendor
  Map<String, Map<String, dynamic>> shippingAddresses = {};
  
  // Payment Methods per Vendor
  Map<String, String> vendorPaymentMethods = {};
  
  // Form Fields
  String email = "john.doe@example.com";
  String firstName = "John";
  String lastName = "Doe";
  String phone = "+1 (555) 123-4567";
  
  // Default Address
  String address = "123 Main Street";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  
  // Payment Options
  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "PayPal", "value": "paypal"},
    {"label": "Apple Pay", "value": "apple_pay"},
    {"label": "Google Pay", "value": "google_pay"},
    {"label": "Bank Transfer", "value": "bank_transfer"}
  ];
  
  // Vendor Settings
  bool combineShipping = true;
  bool separatePayments = false;
  bool saveAddresses = true;
  
  // Additional Fields
  String orderNotes = "";
  bool marketingEmails = false;
  bool smsUpdates = true;
  
  double getTotalForVendor(String vendorName) {
    List<Map<String, dynamic>> items = vendorGroups[vendorName] ?? [];
    double itemsTotal = items.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
    double shippingTotal = items.fold(0.0, (sum, item) => 
        sum + (item["shipping"] as double));
    return itemsTotal + shippingTotal;
  }
  
  double get grandTotal {
    return vendorGroups.values.fold(0.0, (sum, items) {
      double itemsTotal = items.fold(0.0, (itemSum, item) => 
          itemSum + ((item["price"] as double) * (item["quantity"] as int)));
      double shippingTotal = items.fold(0.0, (shippingSum, item) => 
          shippingSum + (item["shipping"] as double));
      return sum + itemsTotal + shippingTotal;
    });
  }
  
  double get totalShipping {
    return vendorGroups.values.fold(0.0, (sum, items) {
      return sum + items.fold(0.0, (shippingSum, item) => 
          shippingSum + (item["shipping"] as double));
    });
  }
  
  int get totalItems {
    return vendorGroups.values.fold(0, (sum, items) {
      return sum + items.fold(0, (itemSum, item) => 
          itemSum + (item["quantity"] as int));
    });
  }
  
  void _initializeDefaults() {
    // Set default shipping addresses for all vendors
    for (String vendorName in vendorGroups.keys) {
      shippingAddresses[vendorName] = {
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country,
        "useDefault": true
      };
      vendorPaymentMethods[vendorName] = "credit_card";
    }
  }
  
  void _updateQuantity(String vendorName, int itemIndex, int newQuantity) {
    if (newQuantity > 0) {
      vendorGroups[vendorName]![itemIndex]["quantity"] = newQuantity;
    } else {
      vendorGroups[vendorName]!.removeAt(itemIndex);
      if (vendorGroups[vendorName]!.isEmpty) {
        vendorGroups.remove(vendorName);
        shippingAddresses.remove(vendorName);
        vendorPaymentMethods.remove(vendorName);
      }
    }
    setState(() {});
  }
  
  void _applyToAllVendors(String addressField, String value) {
    for (String vendorName in vendorGroups.keys) {
      if (shippingAddresses[vendorName] != null) {
        shippingAddresses[vendorName]![addressField] = value;
      }
    }
    setState(() {});
  }
  
  void _processMultiVendorCheckout() async {
    if (!formKey.currentState!.validate()) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    ss("Multi-vendor order placed successfully!");
    // Navigate to confirmation with multiple order numbers
  }
  
  @override
  void initState() {
    super.initState();
    _initializeDefaults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Vendor Checkout"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${vendorGroups.length} Vendors",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Multi-Vendor Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: infoColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Multiple Vendors",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Your order contains items from ${vendorGroups.length} different vendors. Items may be shipped separately.",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Customer Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Customer Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "First Name",
                            value: firstName,
                            validator: Validator.required,
                            onChanged: (value) {
                              firstName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Last Name",
                            value: lastName,
                            validator: Validator.required,
                            onChanged: (value) {
                              lastName = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Vendor Groups
              ...vendorGroups.entries.map((entry) {
                String vendorName = entry.key;
                List<Map<String, dynamic>> items = entry.value;
                double vendorTotal = getTotalForVendor(vendorName);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Vendor Header
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.store,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vendorName,
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Estimated delivery: ${items.isNotEmpty ? items[0]["estimatedDelivery"] : "N/A"}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "\$${vendorTotal.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Divider(),
                      
                      // Vendor Items
                      ...items.asMap().entries.map((itemEntry) {
                        int itemIndex = itemEntry.key;
                        Map<String, dynamic> item = itemEntry.value;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${item["image"]}",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${item["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if ((item["shipping"] as double) > 0)
                                      Text(
                                        "Shipping: \$${(item["shipping"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${(item["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _updateQuantity(vendorName, itemIndex, (item["quantity"] as int) - 1),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: disabledOutlineBorderColor),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Icon(Icons.remove, size: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${item["quantity"]}",
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _updateQuantity(vendorName, itemIndex, (item["quantity"] as int) + 1),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: disabledOutlineBorderColor),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Icon(Icons.add, size: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      
                      // Shipping Address for Vendor
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.local_shipping, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Shipping Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    bool useDefault = !(shippingAddresses[vendorName]?["useDefault"] ?? false);
                                    shippingAddresses[vendorName]!["useDefault"] = useDefault;
                                    setState(() {});
                                  },
                                  child: Text(
                                    shippingAddresses[vendorName]?["useDefault"] == true ? "Use Different" : "Use Default",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${shippingAddresses[vendorName]?["address"]}, ${shippingAddresses[vendorName]?["city"]}, ${shippingAddresses[vendorName]?["state"]} ${shippingAddresses[vendorName]?["zipCode"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Payment Method for Vendor
                      QDropdownField(
                        label: "Payment Method",
                        items: paymentMethods,
                        value: vendorPaymentMethods[vendorName],
                        onChanged: (value, label) {
                          vendorPaymentMethods[vendorName] = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
              
              // Multi-Vendor Settings
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Multi-Vendor Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Combine shipping when possible",
                          "value": "combine_shipping",
                          "checked": combineShipping,
                        }
                      ],
                      value: combineShipping ? [{"label": "Combine shipping when possible", "value": "combine_shipping", "checked": true}] : [],
                      onChanged: (values, ids) {
                        combineShipping = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Process payments separately",
                          "value": "separate_payments",
                          "checked": separatePayments,
                        }
                      ],
                      value: separatePayments ? [{"label": "Process payments separately", "value": "separate_payments", "checked": true}] : [],
                      onChanged: (values, ids) {
                        separatePayments = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Save addresses for future orders",
                          "value": "save_addresses",
                          "checked": saveAddresses,
                        }
                      ],
                      value: saveAddresses ? [{"label": "Save addresses for future orders", "value": "save_addresses", "checked": true}] : [],
                      onChanged: (values, ids) {
                        saveAddresses = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Additional Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Order Notes",
                      value: orderNotes,
                      hint: "Special instructions for all vendors...",
                      onChanged: (value) {
                        orderNotes = value;  
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Receive marketing emails",
                          "value": "marketing",
                          "checked": marketingEmails,
                        }
                      ],
                      value: marketingEmails ? [{"label": "Receive marketing emails", "value": "marketing", "checked": true}] : [],
                      onChanged: (values, ids) {
                        marketingEmails = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "SMS order updates",
                          "value": "sms",
                          "checked": smsUpdates,
                        }
                      ],
                      value: smsUpdates ? [{"label": "SMS order updates", "value": "sms", "checked": true}] : [],
                      onChanged: (values, ids) {
                        smsUpdates = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Order Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...vendorGroups.entries.map((entry) {
                      String vendorName = entry.key;
                      double vendorTotal = getTotalForVendor(vendorName);
                      
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vendorName,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "\$${vendorTotal.toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    }).toList(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Items (${totalItems})",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "\$${(grandTotal - totalShipping).toStringAsFixed(2)}",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipping",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "\$${totalShipping.toStringAsFixed(2)}",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${grandTotal.toStringAsFixed(2)}",
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vendorGroups.length} Vendors • ${totalItems} Items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${grandTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QButton(
                  label: "Place Order",
                  size: bs.md,
                  onPressed: _processMultiVendorCheckout,
                ),
              ],
            ),
            if (separatePayments)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "You will be charged separately by each vendor",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
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
}
