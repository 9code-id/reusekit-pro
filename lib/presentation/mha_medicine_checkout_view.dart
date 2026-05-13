import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMedicineCheckoutView extends StatefulWidget {
  const MhaMedicineCheckoutView({super.key});

  @override
  State<MhaMedicineCheckoutView> createState() => _MhaMedicineCheckoutViewState();
}

class _MhaMedicineCheckoutViewState extends State<MhaMedicineCheckoutView> {
  bool loading = false;
  int selectedAddressIndex = 0;
  int selectedPaymentIndex = 0;
  String notes = "";
  bool agreeToTerms = false;
  bool prescriptionUploaded = false;
  
  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Paracetamol 500mg",
      "manufacturer": "GSK Pharmaceuticals",
      "image": "https://picsum.photos/60/60?random=1&keyword=medicine",
      "price": 25.50,
      "quantity": 2,
      "prescription": false,
    },
    {
      "id": 2,
      "name": "Amoxicillin 250mg",
      "manufacturer": "Cipla Limited",
      "image": "https://picsum.photos/60/60?random=2&keyword=medicine",
      "price": 45.00,
      "quantity": 1,
      "prescription": true,
    }
  ];
  
  List<Map<String, dynamic>> addresses = [
    {
      "id": 1,
      "type": "Home",
      "name": "John Doe",
      "phone": "+1 234 567 8900",
      "address": "123 Main Street, Apt 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "isDefault": true,
    },
    {
      "id": 2,
      "type": "Office",
      "name": "John Doe",
      "phone": "+1 234 567 8900",
      "address": "456 Business Ave, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "isDefault": false,
    }
  ];
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": 1,
      "type": "Credit Card",
      "name": "Visa ending in 1234",
      "icon": Icons.credit_card,
      "isDefault": true,
    },
    {
      "id": 2,
      "type": "PayPal",
      "name": "john.doe@email.com",
      "icon": Icons.account_balance_wallet,
      "isDefault": false,
    },
    {
      "id": 3,
      "type": "Cash on Delivery",
      "name": "Pay when you receive",
      "icon": Icons.money,
      "isDefault": false,
    }
  ];

  double get subtotal => orderItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get deliveryFee => 5.0;
  double get discount => subtotal * 0.15;
  double get total => subtotal + deliveryFee - discount;
  
  bool get hasPrescriptionMedicine => orderItems.any((item) => item["prescription"] as bool);

  void _uploadPrescription() {
    // Simulate prescription upload
    prescriptionUploaded = true;
    setState(() {});
    ss("Prescription uploaded successfully");
  }

  void _addNewAddress() {
    // ss('Next page'));
    ss("Navigate to add new address");
  }

  void _addNewPaymentMethod() {
    // ss('Next page'));
    ss("Navigate to add payment method");
  }

  void _placeOrder() async {
    if (hasPrescriptionMedicine && !prescriptionUploaded) {
      se("Please upload prescription for prescription medicines");
      return;
    }
    
    if (!agreeToTerms) {
      se("Please agree to terms and conditions");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Order placed successfully!");
    // ss('Next page'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: loading ? 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Processing your order...",
                style: TextStyle(
                  fontSize: fsH6,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ) :
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderSummary(),
                    SizedBox(height: spMd),
                    _buildDeliveryAddress(),
                    SizedBox(height: spMd),
                    if (hasPrescriptionMedicine) ...[
                      _buildPrescriptionUpload(),
                      SizedBox(height: spMd),
                    ],
                    _buildPaymentMethod(),
                    SizedBox(height: spMd),
                    _buildOrderNotes(),
                    SizedBox(height: spMd),
                    _buildPriceBreakdown(),
                    SizedBox(height: spMd),
                    _buildTermsAndConditions(),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
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
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...orderItems.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
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
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${item["manufacturer"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (item["prescription"] as bool)
                        Row(
                          children: [
                            Icon(Icons.medical_services, size: 12, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "Prescription",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Text(
                  "Qty: ${item["quantity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _addNewAddress,
                child: Text(
                  "Add New",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...addresses.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> address = entry.value;
            bool isSelected = selectedAddressIndex == index;
            
            return GestureDetector(
              onTap: () {
                selectedAddressIndex = index;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${address["type"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (address["isDefault"] as bool) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Default",
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
                          SizedBox(height: spXs),
                          Text(
                            "${address["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${address["address"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${address["city"]}, ${address["state"]} ${address["zipCode"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${address["phone"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPrescriptionUpload() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: prescriptionUploaded ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: prescriptionUploaded ? Colors.green[200]! : Colors.orange[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: prescriptionUploaded ? successColor : warningColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Prescription Required",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: prescriptionUploaded ? successColor : warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            prescriptionUploaded 
              ? "Prescription uploaded successfully. Our pharmacist will verify it before processing your order."
              : "Some items in your order require a prescription. Please upload a valid prescription to proceed.",
            style: TextStyle(
              color: prescriptionUploaded ? successColor : warningColor,
            ),
          ),
          SizedBox(height: spSm),
          if (!prescriptionUploaded)
            QButton(
              label: "Upload Prescription",
              size: bs.sm,
              icon: Icons.upload_file,
              onPressed: _uploadPrescription,
            )
          else
            Row(
              children: [
                Icon(Icons.check_circle, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Prescription Uploaded",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: _uploadPrescription,
                  child: Text(
                    "Upload New",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
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
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _addNewPaymentMethod,
                child: Text(
                  "Add New",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...paymentMethods.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> method = entry.value;
            bool isSelected = selectedPaymentIndex == index;
            
            return GestureDetector(
              onTap: () {
                selectedPaymentIndex = index;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      method["icon"] as IconData,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${method["type"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${method["name"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (method["isDefault"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Default",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderNotes() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note_add, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Order Notes (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Add special instructions",
            value: notes,
            hint: "Any special delivery instructions or notes for the pharmacist",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
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
            "Order Total",
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

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            agreeToTerms = !agreeToTerms;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: agreeToTerms ? primaryColor : Colors.transparent,
              border: Border.all(
                color: agreeToTerms ? primaryColor : Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              Icons.check,
              size: 16,
              color: agreeToTerms ? Colors.white : Colors.transparent,
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(text: "I agree to the "),
                TextSpan(
                  text: "Terms & Conditions",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: " of the pharmacy and understand that prescriptions will be verified before dispensing."),
              ],
            ),
          ),
        ),
      ],
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
                  "Including delivery & taxes",
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
            label: "Place Order",
            size: bs.md,
            onPressed: _placeOrder,
          ),
        ],
      ),
    );
  }
}
