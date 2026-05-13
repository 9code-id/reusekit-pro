import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice1View extends StatefulWidget {
  @override
  State<GrlInvoice1View> createState() => _GrlInvoice1ViewState();
}

class _GrlInvoice1ViewState extends State<GrlInvoice1View> {
  List<Map<String, dynamic>> invoiceItems = [
    {
      "name": "Website Design & Development",
      "description": "Complete responsive website with admin panel",
      "quantity": 1,
      "price": 2500.0,
      "total": 2500.0,
    },
    {
      "name": "Logo Design",
      "description": "Brand identity and logo creation",
      "quantity": 3,
      "price": 150.0,
      "total": 450.0,
    },
    {
      "name": "SEO Optimization",
      "description": "Search engine optimization for 6 months",
      "quantity": 1,
      "price": 800.0,
      "total": 800.0,
    },
    {
      "name": "Content Management",
      "description": "Content creation and management",
      "quantity": 5,
      "price": 100.0,
      "total": 500.0,
    },
  ];

  Map<String, dynamic> companyInfo = {
    "name": "DesignCorp Solutions",
    "address": "123 Business Street, Suite 456",
    "city": "New York, NY 10001",
    "phone": "+1 (555) 123-4567",
    "email": "billing@designcorp.com",
    "website": "www.designcorp.com",
  };

  Map<String, dynamic> clientInfo = {
    "name": "TechStart Inc.",
    "address": "789 Innovation Drive",
    "city": "San Francisco, CA 94105",
    "phone": "+1 (555) 987-6543",
    "email": "contact@techstart.com",
  };

  Map<String, dynamic> invoiceDetails = {
    "number": "INV-2024-001",
    "date": "2024-01-15",
    "dueDate": "2024-02-15",
    "status": "Pending",
  };

  double get subtotal => invoiceItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
  double get taxRate => 0.10;
  double get taxAmount => subtotal * taxRate;
  double get totalAmount => subtotal + taxAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            _buildInvoiceHeader(),
            _buildCompanyClientInfo(),
            _buildInvoiceItems(),
            _buildTotalSection(),
            _buildPaymentInfo(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "INVOICE",
                style: TextStyle(
                  fontSize: fsH1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${invoiceDetails["number"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${invoiceDetails["status"]}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyClientInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Expanded(
          child: _buildInfoCard("From", companyInfo),
        ),
        Expanded(
          child: _buildInfoCard("To", clientInfo),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, Map<String, dynamic> info) {
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
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${info["name"]}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(
            "${info["address"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            "${info["city"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          if (info["phone"] != null)
            Text(
              "${info["phone"]}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          Text(
            "${info["email"]}",
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItems() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Qty",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Price",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Total",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(invoiceItems.length, (index) {
            final item = invoiceItems[index];
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${item["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${item["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${item["quantity"]}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$${(item["price"] as double).currency}",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$${(item["total"] as double).currency}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal:",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "\$${subtotal.currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax (${(taxRate * 100).toInt()}%):",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "\$${taxAmount.currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalAmount.currency}",
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
    );
  }

  Widget _buildPaymentInfo() {
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
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Invoice Date:"),
              Text(
                "${invoiceDetails["date"]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Due Date:"),
              Text(
                "${invoiceDetails["dueDate"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Payment Terms:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Payment is due within 30 days of invoice date. Late payments may incur additional charges.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Download PDF",
            icon: Icons.download,
            size: bs.md,
            onPressed: () {},
          ),
        ),
        Expanded(
          child: QButton(
            label: "Send Email",
            icon: Icons.email,
            size: bs.md,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
