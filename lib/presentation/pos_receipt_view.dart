import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosReceiptView extends StatefulWidget {
  const PosReceiptView({super.key});

  @override
  State<PosReceiptView> createState() => _PosReceiptViewState();
}

class _PosReceiptViewState extends State<PosReceiptView> {
  final Map<String, dynamic> storeInfo = {
    "name": "Coffee & More",
    "address": "123 Main Street",
    "city": "New York, NY 10001",
    "phone": "(555) 123-4567",
    "email": "info@coffeeandmore.com",
    "website": "www.coffeeandmore.com",
    "tax_id": "12-3456789",
  };

  final Map<String, dynamic> transactionInfo = {
    "transaction_id": "TXN-2024-001234",
    "date": DateTime.now(),
    "cashier": "Sarah Johnson",
    "register": "POS-01",
    "payment_method": "Credit Card",  
    "card_type": "Visa •••• 4532",
    "approval_code": "AUTH123456",
  };

  final List<Map<String, dynamic>> orderItems = [
    {
      "name": "Espresso",
      "quantity": 2,
      "price": 3.50,
      "total": 7.00,
      "tax_rate": 8.5,
    },
    {
      "name": "Croissant",
      "quantity": 1,
      "price": 4.25,
      "total": 4.25,
      "tax_rate": 8.5,
    },
    {
      "name": "Latte",
      "quantity": 1,
      "price": 4.75,
      "total": 4.75,
      "tax_rate": 8.5,
    },
    {
      "name": "Blueberry Muffin",
      "quantity": 3,
      "price": 3.95,
      "total": 11.85,
      "tax_rate": 8.5,
    },
    {
      "name": "Green Tea",
      "quantity": 1,
      "price": 2.50,
      "total": 2.50,
      "tax_rate": 8.5,
    },
  ];

  final Map<String, dynamic> totals = {
    "subtotal": 30.35,
    "discount": 0.00,
    "tax_amount": 2.58,
    "tip": 4.50,
    "processing_fee": 0.92,
    "total": 38.35,
    "amount_paid": 40.00,
    "change": 1.65,
  };

  final Map<String, dynamic> customerInfo = {
    "name": "John Doe",
    "email": "john.doe@email.com",
    "phone": "+1 (555) 123-4567",
    "loyalty_member": true,
    "loyalty_points_earned": 38,
    "loyalty_points_balance": 245,
  };

  bool showTaxBreakdown = false;
  String receiptFormat = "standard";
  
  final List<Map<String, dynamic>> receiptFormats = [
    {"label": "Standard Receipt", "value": "standard"},
    {"label": "Detailed Receipt", "value": "detailed"},
    {"label": "Minimal Receipt", "value": "minimal"},
  ];

  void _printReceipt() async {
    showLoading();
    
    // Simulate printing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Receipt printed successfully");
  }

  void _shareReceipt() async {
    si("Receipt sharing options");
    //navigateTo('share_receipt')
  }

  void _emailReceipt() async {
    //navigateTo('email_receipt')
  }

  void _downloadReceipt() async {
    showLoading();
    
    // Simulate download
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("Receipt downloaded to device");
  }

  Widget _buildReceiptHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "${storeInfo["name"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          
          Text(
            "${storeInfo["address"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          Text(
            "${storeInfo["city"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          Text(
            "Phone: ${storeInfo["phone"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          
          if (receiptFormat == "detailed") ...[
            Text(
              "Email: ${storeInfo["email"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            
            Text(
              "${storeInfo["website"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${transactionInfo["transaction_id"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${(transactionInfo["date"] as DateTime).dMMMykkss}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          if (receiptFormat == "detailed") ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cashier:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${transactionInfo["cashier"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Register:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${transactionInfo["register"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spXs),
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        spacing: spXs,
        children: [
          ...List.generate(orderItems.length, (index) {
            final item = orderItems[index];
            
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["quantity"]}x",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    
                    Text(
                      "\$${(item["total"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                if (receiptFormat == "detailed")
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "@\$${(item["price"] as double).currency} each",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Tax: ${item["tax_rate"]}%",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
          
          SizedBox(height: spSm),
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTotals() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${(totals["subtotal"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          if ((totals["discount"] as double) > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "-\$${(totals["discount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${(totals["tax_amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          if ((totals["tip"] as double) > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tip:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${(totals["tip"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          
          if (receiptFormat == "detailed" && (totals["processing_fee"] as double) > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Processing Fee:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${(totals["processing_fee"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(vertical: spXs),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${(totals["total"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${transactionInfo["payment_method"]} (${transactionInfo["card_type"]}):",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${(totals["amount_paid"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          if ((totals["change"] as double) > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CHANGE:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "\$${(totals["change"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          
          if (receiptFormat == "detailed")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Approval Code:",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${transactionInfo["approval_code"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    if (!customerInfo["loyalty_member"] as bool) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
          SizedBox(height: spXs),
          
          Text(
            "LOYALTY MEMBER",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "${customerInfo["name"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Points Earned:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "+${customerInfo["loyalty_points_earned"]} pts",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Points Balance:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${customerInfo["loyalty_points_balance"]} pts",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            height: 1,
            color: disabledOutlineBorderColor,
          ),
          SizedBox(height: spSm),
          
          Text(
            "Thank you for your business!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          if (receiptFormat == "detailed") ...[
            SizedBox(height: spXs),
            Text(
              "Visit us again soon",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            
            Text(
              "Follow us @coffeeandmore",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          Text(
            "Tax ID: ${storeInfo["tax_id"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareReceipt,
          ),
        ],
      ),
      body: Column(
        children: [
          // Receipt Format Selector
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Receipt Format",
              items: receiptFormats,
              value: receiptFormat,
              onChanged: (value, label) {
                receiptFormat = value;
                setState(() {});
              },
            ),
          ),
          
          // Receipt Preview
          Expanded(
            child: Container(
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildReceiptHeader(),
                    _buildTransactionInfo(),
                    _buildOrderItems(),
                    _buildTotals(),
                    _buildCustomerInfo(),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
          
          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                QButton(
                  label: "Print",
                  icon: Icons.print,
                  color: primaryColor,
                  size: bs.md,
                  onPressed: _printReceipt,
                ),
                
                QButton(
                  label: "Email",
                  icon: Icons.email,
                  color: infoColor,
                  size: bs.md,
                  onPressed: _emailReceipt,
                ),
                
                QButton(
                  label: "Download",
                  icon: Icons.download,
                  color: successColor,
                  size: bs.md,
                  onPressed: _downloadReceipt,
                ),
                
                QButton(
                  label: "Share",
                  icon: Icons.share,
                  color: warningColor,
                  size: bs.md,
                  onPressed: _shareReceipt,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
