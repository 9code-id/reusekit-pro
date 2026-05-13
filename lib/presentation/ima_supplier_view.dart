
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaSupplierView extends StatefulWidget {
  const ImaSupplierView({super.key});

  @override
  State<ImaSupplierView> createState() => _ImaSupplierViewState();
}

class _ImaSupplierViewState extends State<ImaSupplierView> {
  String supplierId = "SUP001";
  String supplierName = "Tech Solutions Ltd";
  String contactPerson = "John Anderson";
  String email = "john@techsolutions.com";
  String phone = "+1-555-0123";
  String address = "123 Tech Street, Silicon Valley, CA 94043";
  String website = "https://techsolutions.com";
  String taxId = "TAX123456789";
  String paymentTerms = "30";
  double creditLimit = 50000.0;
  bool isActive = true;
  bool isPreferred = false;
  String category = "Electronics";
  String notes = "Reliable supplier with excellent quality products and timely delivery.";
  
  List<Map<String, dynamic>> supplierProducts = [
    {
      "productId": "PRD001",
      "productName": "iPhone 14 Pro Max",
      "sku": "TECH-001",
      "supplierPrice": 850.0,
      "minimumOrder": 10,
      "leadTime": "5-7 days",
      "availability": "In Stock",
      "lastOrderDate": "2024-03-15",
    },
    {
      "productId": "PRD002",
      "productName": "MacBook Air M2",
      "sku": "TECH-002",
      "supplierPrice": 1200.0,
      "minimumOrder": 5,
      "leadTime": "7-10 days",
      "availability": "Limited Stock",
      "lastOrderDate": "2024-03-10",
    },
    {
      "productId": "PRD003",
      "productName": "iPad Pro 11\"",
      "sku": "TECH-003",
      "supplierPrice": 750.0,
      "minimumOrder": 8,
      "leadTime": "3-5 days",
      "availability": "Out of Stock",
      "lastOrderDate": "2024-03-05",
    },
  ];

  List<Map<String, dynamic>> recentOrders = [
    {
      "orderId": "PO-2024-001",
      "orderDate": "2024-03-15",
      "totalAmount": 8500.0,
      "status": "Delivered",
      "itemCount": 10,
    },
    {
      "orderId": "PO-2024-002",
      "orderDate": "2024-03-10",
      "totalAmount": 6000.0,
      "status": "In Transit",
      "itemCount": 5,
    },
    {
      "orderId": "PO-2024-003",
      "orderDate": "2024-03-05",
      "totalAmount": 6000.0,
      "status": "Processing",
      "itemCount": 8,
    },
  ];

  List<Map<String, dynamic>> paymentTermsOptions = [
    {"label": "15 Days", "value": "15"},
    {"label": "30 Days", "value": "30"},
    {"label": "45 Days", "value": "45"},
    {"label": "60 Days", "value": "60"},
    {"label": "90 Days", "value": "90"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Garden", "value": "Home & Garden"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Books", "value": "Books"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editSupplier();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Supplier Header Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.business,
                          size: 32,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    supplierName,
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (isPreferred)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Preferred",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              "ID: $supplierId",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: (isActive ? successColor : dangerColor).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                isActive ? "Active" : "Inactive",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? successColor : dangerColor,
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

            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      _buildInfoRow("Contact Person", contactPerson, Icons.person),
                      _buildInfoRow("Email", email, Icons.email),
                      _buildInfoRow("Phone", phone, Icons.phone),
                      _buildInfoRow("Website", website, Icons.language),
                      _buildInfoRow("Address", address, Icons.location_on),
                    ],
                  ),
                ],
              ),
            ),

            // Business Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Business Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildBusinessCard("Category", category, Icons.category, infoColor),
                      _buildBusinessCard("Tax ID", taxId, Icons.receipt, warningColor),
                      _buildBusinessCard("Payment Terms", "$paymentTerms Days", Icons.schedule, primaryColor),
                      _buildBusinessCard("Credit Limit", "\$${creditLimit.currency}", Icons.credit_card, successColor),
                    ],
                  ),
                ],
              ),
            ),

            // Supplier Products
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Supplier Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          _viewAllProducts();
                        },
                      ),
                    ],
                  ),
                  ...supplierProducts.map((product) => _buildProductCard(product)).toList(),
                ],
              ),
            ),

            // Recent Orders
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Orders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          _viewAllOrders();
                        },
                      ),
                    ],
                  ),
                  ...recentOrders.map((order) => _buildOrderCard(order)).toList(),
                ],
              ),
            ),

            // Notes Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      notes,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Order",
                          size: bs.md,
                          onPressed: () {
                            _createOrder();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Contact Supplier",
                          size: bs.md,
                          onPressed: () {
                            _contactSupplier();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Analytics",
                          size: bs.md,
                          onPressed: () {
                            _viewAnalytics();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          size: bs.md,
                          onPressed: () {
                            _generateReport();
                          },
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
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: disabledBoldColor,
        ),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    Color availabilityColor = successColor;
    if (product["availability"] == "Limited Stock") {
      availabilityColor = warningColor;
    } else if (product["availability"] == "Out of Stock") {
      availabilityColor = dangerColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${product["productName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: availabilityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${product["availability"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: availabilityColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "SKU: ${product["sku"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "\$${(product["supplierPrice"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Min Order: ${product["minimumOrder"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Lead Time: ${product["leadTime"]}",
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
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = primaryColor;
    switch (order["status"]) {
      case "Delivered":
        statusColor = successColor;
        break;
      case "In Transit":
        statusColor = infoColor;
        break;
      case "Processing":
        statusColor = warningColor;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${order["orderId"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${order["orderDate"]} • ${order["itemCount"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${order["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${(order["totalAmount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Edit Supplier"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.copy, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Duplicate Supplier"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.download, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Export Data"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Delete Supplier"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editSupplier() {
    si("Edit supplier feature coming soon!");
  }

  void _viewAllProducts() {
    si("View all products feature coming soon!");
  }

  void _viewAllOrders() {
    si("View all orders feature coming soon!");
  }

  void _createOrder() {
    si("Create order feature coming soon!");
  }

  void _contactSupplier() {
    si("Contact supplier feature coming soon!");
  }

  void _viewAnalytics() {
    si("View analytics feature coming soon!");
  }

  void _generateReport() {
    si("Generate report feature coming soon!");
  }
}
