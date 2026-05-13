import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaReceiptView extends StatefulWidget {
  const FdaReceiptView({super.key});

  @override
  State<FdaReceiptView> createState() => _FdaReceiptViewState();
}

class _FdaReceiptViewState extends State<FdaReceiptView> {
  Map<String, dynamic> orderDetails = {
    "id": "FDA-2024-001234",
    "orderNumber": "ORDER#12345",
    "date": "2024-06-14",
    "time": "2:30 PM",
    "status": "Delivered",
    "restaurant": {
      "name": "Tony's Pizzeria",
      "address": "456 Food Street, Culinary District",
      "phone": "+1 (555) 123-4567",
      "logo": "https://picsum.photos/60/60?random=100&keyword=restaurant"
    },
    "customer": {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "+1 (555) 987-6543",
      "address": "123 Main Street, Apt 4B\nNew York, NY 10001"
    },
    "driver": {
      "name": "Mike Johnson",
      "phone": "+1 (555) 456-7890",
      "vehicle": "Honda Civic - ABC 123"
    },
    "deliveryTime": "45 minutes",
    "orderType": "Delivery",
    "paymentMethod": "Visa ending in 4242",
    "transactionId": "TXN789456123"
  };

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Margherita Pizza",
      "size": "Large",
      "quantity": 2,
      "unitPrice": 12.99,
      "totalPrice": 25.98,
      "customizations": ["Extra Cheese", "Thin Crust"],
      "specialInstructions": "Please make it extra crispy"
    },
    {
      "name": "Chicken Caesar Salad",
      "size": "Regular",
      "quantity": 1,
      "unitPrice": 8.99,
      "totalPrice": 8.99,
      "customizations": ["No Croutons", "Extra Dressing"],
      "specialInstructions": ""
    },
    {
      "name": "Chocolate Brownie",
      "size": "Regular",
      "quantity": 1,
      "unitPrice": 4.99,
      "totalPrice": 4.99,
      "customizations": ["With Ice Cream"],
      "specialInstructions": ""
    }
  ];

  Map<String, dynamic> billing = {
    "subtotal": 39.96,
    "deliveryFee": 2.99,
    "serviceFee": 1.50,
    "tax": 3.60,
    "promoDiscount": 5.00,
    "total": 43.05,
    "paid": 43.05,
    "change": 0.00
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              _shareReceipt();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadReceipt();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowLg],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${orderDetails["restaurant"]["logo"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${orderDetails["restaurant"]["name"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${orderDetails["restaurant"]["address"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Phone: ${orderDetails["restaurant"]["phone"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Receipt Header
              Column(
                children: [
                  Text(
                    "RECEIPT",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: primaryColor,
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Order Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Order Number:", "${orderDetails["orderNumber"]}"),
                  _buildInfoRow("Order ID:", "${orderDetails["id"]}"),
                  _buildInfoRow("Date:", "${orderDetails["date"]} at ${orderDetails["time"]}"),
                  _buildInfoRow("Order Type:", "${orderDetails["orderType"]}"),
                  _buildInfoRow("Status:", "${orderDetails["status"]}", valueColor: successColor),
                  _buildInfoRow("Delivery Time:", "${orderDetails["deliveryTime"]}"),
                ],
              ),

              SizedBox(height: spMd),
              _buildDivider(),

              // Customer Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Customer Information"),
                  _buildInfoRow("Name:", "${orderDetails["customer"]["name"]}"),
                  _buildInfoRow("Email:", "${orderDetails["customer"]["email"]}"),
                  _buildInfoRow("Phone:", "${orderDetails["customer"]["phone"]}"),
                  _buildInfoRow("Address:", "${orderDetails["customer"]["address"]}"),
                ],
              ),

              SizedBox(height: spMd),
              _buildDivider(),

              // Driver Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Delivery Information"),
                  _buildInfoRow("Driver:", "${orderDetails["driver"]["name"]}"),
                  _buildInfoRow("Driver Phone:", "${orderDetails["driver"]["phone"]}"),
                  _buildInfoRow("Vehicle:", "${orderDetails["driver"]["vehicle"]}"),
                ],
              ),

              SizedBox(height: spMd),
              _buildDivider(),

              // Order Items
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Order Items"),
                  SizedBox(height: spSm),
                  ...orderItems.map((item) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["name"]} (${item["size"]})",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(item["totalPrice"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Qty: ${item["quantity"]} × \$${(item["unitPrice"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ((item["customizations"] as List).isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Text(
                              "• ${(item["customizations"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          if ("${item["specialInstructions"]}".isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Text(
                              "• Special: ${item["specialInstructions"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          if (orderItems.indexOf(item) < orderItems.length - 1)
                            Container(
                              margin: EdgeInsets.only(top: spSm),
                              height: 1,
                              color: disabledOutlineBorderColor,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),

              SizedBox(height: spMd),
              _buildDivider(),

              // Bill Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Bill Summary"),
                  SizedBox(height: spSm),
                  _buildBillRow("Subtotal", billing["subtotal"]),
                  _buildBillRow("Delivery Fee", billing["deliveryFee"]),
                  _buildBillRow("Service Fee", billing["serviceFee"]),
                  _buildBillRow("Tax (9%)", billing["tax"]),
                  _buildBillRow("Promo Discount", -billing["promoDiscount"], color: successColor),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: spSm),
                    height: 2,
                    color: primaryColor,
                  ),
                  _buildBillRow("Total Amount", billing["total"], isTotal: true),
                  _buildBillRow("Amount Paid", billing["paid"]),
                  if (billing["change"] > 0)
                    _buildBillRow("Change", billing["change"], color: successColor),
                ],
              ),

              SizedBox(height: spMd),
              _buildDivider(),

              // Payment Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Payment Information"),
                  _buildInfoRow("Payment Method:", "${orderDetails["paymentMethod"]}"),
                  _buildInfoRow("Transaction ID:", "${orderDetails["transactionId"]}"),
                  _buildInfoRow("Payment Status:", "Completed", valueColor: successColor),
                ],
              ),

              SizedBox(height: spLg),

              // Footer
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: disabledOutlineBorderColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Thank you for choosing ${orderDetails["restaurant"]["name"]}!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "We hope you enjoyed your meal",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Generated on: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} at ${TimeOfDay.now().format(context)}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Download PDF",
                icon: Icons.picture_as_pdf,
                onPressed: () {
                  _downloadReceipt();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Share Receipt",
                icon: Icons.share,
                onPressed: () {
                  _shareReceipt();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fsH6,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: valueColor ?? Colors.black,
                fontWeight: valueColor != null ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? Colors.black : disabledBoldColor),
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: disabledOutlineBorderColor,
    );
  }

  void _shareReceipt() {
    // Implement share functionality
    ss("Receipt shared successfully");
  }

  void _downloadReceipt() async {
    showLoading();
    
    // Simulate download
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Receipt downloaded to Downloads folder");
  }
}
