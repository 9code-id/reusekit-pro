import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaCheckoutView extends StatefulWidget {
  const SpaCheckoutView({super.key});

  @override
  State<SpaCheckoutView> createState() => _SpaCheckoutViewState();
}

class _SpaCheckoutViewState extends State<SpaCheckoutView> {
  final formKey = GlobalKey<FormState>();
  
  // Contact Information
  String firstName = "Emma";
  String lastName = "Wilson";
  String email = "emma.wilson@email.com";
  String phone = "+1 234 567 8900";
  
  // Address Information
  String address = "123 Main Street";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  
  // Payment Information
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  String selectedPaymentMethod = "card";
  
  // Billing
  bool sameAsContact = true;
  String billingAddress = "";
  String billingCity = "";
  String billingState = "";
  String billingZipCode = "";
  
  // Special Requests
  String specialRequests = "";
  bool newsletterSubscription = false;
  bool termsAccepted = false;
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.payment,
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_android,
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.g_mobiledata,
    },
  ];

  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Luxury Facial Treatment",
      "category": "Facial",
      "price": 120.0,
      "originalPrice": 150.0,
      "quantity": 1,
      "duration": "90 min",
      "selectedDate": "2024-03-25",
      "selectedTime": "14:00",
      "package": "Premium Package",
      "therapist": "Sarah Johnson",
    },
    {
      "id": 2,
      "name": "Hot Stone Massage",
      "category": "Massage",
      "price": 180.0,
      "originalPrice": 200.0,
      "quantity": 1,
      "duration": "75 min",
      "selectedDate": "2024-03-26",
      "selectedTime": "16:00",
      "package": "Standard Package",
      "therapist": "Michael Chen",
    },
  ];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get discount {
    return cartItems.fold(0.0, (sum, item) {
      final originalPrice = item["originalPrice"] as double;
      final currentPrice = item["price"] as double;
      final quantity = item["quantity"] as int;
      return sum + ((originalPrice - currentPrice) * quantity);
    });
  }

  double get tax {
    return subtotal * 0.08; // 8% tax
  }

  double get serviceFee {
    return 5.0; // Fixed service fee
  }

  double get total {
    return subtotal + tax + serviceFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              _buildOrderSummary(),
              
              SizedBox(height: spMd),
              
              // Contact Information
              _buildContactInformation(),
              
              SizedBox(height: spMd),
              
              // Payment Method
              _buildPaymentMethod(),
              
              SizedBox(height: spMd),
              
              // Billing Address
              _buildBillingAddress(),
              
              SizedBox(height: spMd),
              
              // Special Requests
              _buildSpecialRequests(),
              
              SizedBox(height: spMd),
              
              // Terms and Newsletter
              _buildTermsAndNewsletter(),
              
              SizedBox(height: spXl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
                  "Total Amount",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$${total.currency}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Complete Booking",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate() && termsAccepted) {
                    _processPayment();
                  } else if (!termsAccepted) {
                    se("Please accept the terms and conditions");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
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
          
          Column(
            children: cartItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
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
                        Text(
                          "\$${(item["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Text(
                          "${item["package"]} • ${item["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Qty: ${item["quantity"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${item["selectedDate"]} at ${item["selectedTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
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
                  ],
                ),
              );
            }).toList(),
          ),
          
          Divider(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("\$${subtotal.currency}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          
          if (discount > 0)
            Padding(
              padding: EdgeInsets.only(top: spXs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
                  Text("-\$${discount.currency}", style: TextStyle(fontSize: 14, color: successColor, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          
          SizedBox(height: spXs),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax (8%)", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("\$${tax.currency}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Service Fee", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
              Text("\$${serviceFee.currency}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
    return Container(
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
            "Contact Information",
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
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
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
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
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
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Column(
            children: paymentMethods.map((method) {
              final isSelected = selectedPaymentMethod == method["id"];
              
              return GestureDetector(
                onTap: () {
                  selectedPaymentMethod = method["id"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: method["id"],
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          selectedPaymentMethod = value!;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                      Icon(
                        method["icon"] as IconData,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        method["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          if (selectedPaymentMethod == "card")
            Column(
              children: [
                QTextField(
                  label: "Card Holder Name",
                  value: cardHolderName,
                  validator: Validator.required,
                  onChanged: (value) {
                    cardHolderName = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                QTextField(
                  label: "Card Number",
                  value: cardNumber,
                  validator: Validator.required,
                  onChanged: (value) {
                    cardNumber = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "MM/YY",
                        value: expiryDate,
                        validator: Validator.required,
                        onChanged: (value) {
                          expiryDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "CVV",
                        value: cvv,
                        validator: Validator.required,
                        onChanged: (value) {
                          cvv = value;
                          setState(() {});
                        },
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

  Widget _buildBillingAddress() {
    return Container(
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
            "Billing Address",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            items: [
              {
                "label": "Same as contact information",
                "value": true,
                "checked": sameAsContact,
              }
            ],
            value: [
              if (sameAsContact)
                {
                  "label": "Same as contact information",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              sameAsContact = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          if (!sameAsContact)
            Column(
              children: [
                SizedBox(height: spSm),
                
                QTextField(
                  label: "Street Address",
                  value: billingAddress,
                  validator: Validator.required,
                  onChanged: (value) {
                    billingAddress = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "City",
                        value: billingCity,
                        validator: Validator.required,
                        onChanged: (value) {
                          billingCity = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "State",
                        value: billingState,
                        validator: Validator.required,
                        onChanged: (value) {
                          billingState = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                QTextField(
                  label: "ZIP Code",
                  value: billingZipCode,
                  validator: Validator.required,
                  onChanged: (value) {
                    billingZipCode = value;
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return Container(
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
            "Special Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Any special requests or preferences?",
            value: specialRequests,
            hint: "Please let us know about any allergies, preferences, or special requirements...",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndNewsletter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QSwitch(
            items: [
              {
                "label": "Subscribe to newsletter for spa updates and offers",
                "value": true,
                "checked": newsletterSubscription,
              }
            ],
            value: [
              if (newsletterSubscription)
                {
                  "label": "Subscribe to newsletter for spa updates and offers",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              newsletterSubscription = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            items: [
              {
                "label": "I accept the Terms & Conditions and Privacy Policy",
                "value": true,
                "checked": termsAccepted,
              }
            ],
            value: [
              if (termsAccepted)
                {
                  "label": "I accept the Terms & Conditions and Privacy Policy",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              termsAccepted = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    showLoading();
    
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    // Navigate to confirmation
    ss("Payment processed successfully!");
  }
}
