import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaReceiptView extends StatefulWidget {
  const SpaReceiptView({super.key});

  @override
  State<SpaReceiptView> createState() => _SpaReceiptViewState();
}

class _SpaReceiptViewState extends State<SpaReceiptView> {
  String receiptNumber = "SPA-RCT-2024-0789";
  String orderNumber = "SPA-ORD-2024-001";
  DateTime purchaseDate = DateTime.now();
  String paymentMethod = "Credit Card";
  String transactionId = "TXN-456789123";
  String customerName = "Sarah Johnson";
  String customerEmail = "sarah@serenityspa.com";
  
  Map<String, dynamic> storeInfo = {
    "name": "Wellness Spa Supplies Co.",
    "address": "456 Business Park Drive",
    "city": "New York, NY 10001",
    "phone": "+1 (555) 234-5678",
    "email": "sales@wellnesssupplies.com",
    "website": "www.wellnesssupplies.com"
  };
  
  List<Map<String, dynamic>> purchasedItems = [
    {
      "name": "Premium Massage Oil Set",
      "sku": "PMO-001",
      "quantity": 5,
      "unitPrice": 89.99,
      "discount": 0.0,
      "image": "https://picsum.photos/60/60?random=101&keyword=oil"
    },
    {
      "name": "Organic Face Mask Collection",
      "sku": "OFM-002",
      "quantity": 12,
      "unitPrice": 149.99,
      "discount": 10.0,
      "image": "https://picsum.photos/60/60?random=102&keyword=mask"
    },
    {
      "name": "Aromatherapy Candle Set",
      "sku": "ACS-003",
      "quantity": 8,
      "unitPrice": 79.99,
      "discount": 5.0,
      "image": "https://picsum.photos/60/60?random=103&keyword=candle"
    },
    {
      "name": "Spa Towel Premium Pack",
      "sku": "STP-004",
      "quantity": 20,
      "unitPrice": 199.99,
      "discount": 15.0,
      "image": "https://picsum.photos/60/60?random=104&keyword=towel"
    },
  ];
  
  Map<String, dynamic> paymentDetails = {
    "cardType": "Visa",
    "cardLast4": "1234",
    "authCode": "AUTH123456",
    "processingFee": 2.95,
    "taxRate": 0.08,
    "shippingCost": 25.00,
    "handlingFee": 5.00
  };
  
  Map<String, dynamic> shippingInfo = {
    "method": "Express Delivery",
    "address": "123 Main Street, Downtown",
    "city": "New York, NY 10002",
    "trackingCode": "TRACK-789456123",
    "estimatedDelivery": "December 16, 2024"
  };

  @override
  Widget build(BuildContext context) {
    double subtotal = _calculateSubtotal();
    double totalDiscount = _calculateTotalDiscount();
    double tax = (subtotal - totalDiscount) * (paymentDetails["taxRate"] as double);
    double shipping = paymentDetails["shippingCost"] as double;
    double handling = paymentDetails["handlingFee"] as double;
    double processingFee = paymentDetails["processingFee"] as double;
    double grandTotal = subtotal - totalDiscount + tax + shipping + handling + processingFee;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt #${receiptNumber.split('-').last}"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadReceipt();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.print,
            size: bs.sm,
            onPressed: () {
              _printReceipt();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.email,
            size: bs.sm,
            onPressed: () {
              _emailReceipt();
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Receipt Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.receipt,
                          color: successColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PURCHASE RECEIPT",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              receiptNumber,
                              style: TextStyle(
                                fontSize: fsH6,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              purchaseDate.dMMMykkss,
                              style: TextStyle(
                                color: successColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "PAID",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Store Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Text(
                    "${storeInfo["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${storeInfo["address"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${storeInfo["city"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${storeInfo["phone"]} | ${storeInfo["email"]}",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${storeInfo["website"]}",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Customer Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
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
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        customerName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: infoColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        customerEmail,
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Order #${orderNumber.split('-').last}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Purchased Items
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items Purchased",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...purchasedItems.map((item) => _buildReceiptItem(item)).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Payment Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildSummaryRow("Subtotal", subtotal),
                  if (totalDiscount > 0)
                    _buildSummaryRow("Discount", -totalDiscount, color: dangerColor),
                  _buildSummaryRow("Tax (8%)", tax),
                  _buildSummaryRow("Shipping", shipping),
                  _buildSummaryRow("Handling Fee", handling),
                  _buildSummaryRow("Processing Fee", processingFee),
                  Divider(color: disabledOutlineBorderColor),
                  _buildSummaryRow("Total Amount", grandTotal, isTotal: true),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Payment Details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Payment Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${paymentDetails["cardType"]} ending in ${paymentDetails["cardLast4"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Transaction ID: $transactionId",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Auth Code: ${paymentDetails["authCode"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Payment processed on ${purchaseDate.dMMMy}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Shipping Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Shipping Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${shippingInfo["method"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Ship to: ${shippingInfo["address"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${shippingInfo["city"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Tracking: ${shippingInfo["trackingCode"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Expected: ${shippingInfo["estimatedDelivery"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Download PDF",
                          size: bs.md,
                          icon: Icons.download,
                          onPressed: () {
                            _downloadReceipt();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Print Receipt",
                          size: bs.md,
                          icon: Icons.print,
                          color: infoColor,
                          onPressed: () {
                            _printReceipt();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Email Receipt",
                          size: bs.md,
                          icon: Icons.email,
                          color: successColor,
                          onPressed: () {
                            _emailReceipt();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Track Order",
                          size: bs.md,
                          icon: Icons.track_changes,
                          color: warningColor,
                          onPressed: () {
                            _trackOrder();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Footer
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Text(
                    "Thank you for your business!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "For questions about this receipt, please contact our support team.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${storeInfo["phone"]} | ${storeInfo["email"]}",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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

  Widget _buildReceiptItem(Map<String, dynamic> item) {
    double unitPrice = item["unitPrice"];
    int quantity = item["quantity"];
    double discountPercent = item["discount"];
    double discountAmount = unitPrice * quantity * (discountPercent / 100);
    double total = (unitPrice * quantity) - discountAmount;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(50)),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "SKU: ${item["sku"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "$quantity × \$${unitPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (discountPercent > 0) ...[
                      SizedBox(width: spSm),
                      Text(
                        "(${discountPercent.toInt()}% off)",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (discountAmount > 0)
                Text(
                  "Saved \$${discountAmount.toStringAsFixed(2)}",
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
    );
  }

  Widget _buildSummaryRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: color ?? (isTotal ? primaryColor : disabledBoldColor),
              ),
            ),
          ),
          Text(
            "${amount < 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isTotal ? primaryColor : primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateSubtotal() {
    return purchasedItems.fold(0.0, (sum, item) {
      return sum + ((item["unitPrice"] as double) * (item["quantity"] as int));
    });
  }

  double _calculateTotalDiscount() {
    return purchasedItems.fold(0.0, (sum, item) {
      double unitPrice = item["unitPrice"];
      int quantity = item["quantity"];
      double discountPercent = item["discount"];
      return sum + (unitPrice * quantity * (discountPercent / 100));
    });
  }

  void _downloadReceipt() {
    ss("Downloading receipt PDF...");
  }

  void _printReceipt() {
    ss("Printing receipt...");
  }

  void _emailReceipt() {
    ss("Emailing receipt to $customerEmail...");
  }

  void _trackOrder() {
    ss("Opening order tracking...");
  }
}
