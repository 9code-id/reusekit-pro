import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosSupplierOrdersView extends StatefulWidget {
  const PosSupplierOrdersView({super.key});

  @override
  State<PosSupplierOrdersView> createState() => _PosSupplierOrdersViewState();
}

class _PosSupplierOrdersViewState extends State<PosSupplierOrdersView> {
  int currentTab = 0;
  bool loading = false;
  String searchQuery = "";
  String selectedSupplier = "";
  String selectedStatus = "";
  String selectedDateRange = "";

  // Form variables for new order
  String supplierName = "";
  String orderType = "Regular";
  String deliveryDate = "";
  String paymentTerms = "Net 30";
  String notes = "";
  List<Map<String, dynamic>> orderItems = [];

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> ordersData = [
    {
      "id": "SO001",
      "supplierName": "ABC Electronics",
      "supplierContact": "+62 812 3456 7890",
      "orderDate": "2024-01-10T10:00:00Z",
      "deliveryDate": "2024-01-15T00:00:00Z",
      "status": "Pending",
      "orderType": "Regular",
      "paymentTerms": "Net 30",
      "items": [
        {"product": "iPhone 15 Pro", "quantity": 50, "unitPrice": 15000000.0, "total": 750000000.0},
        {"product": "Samsung S24", "quantity": 30, "unitPrice": 12000000.0, "total": 360000000.0},
      ],
      "subtotal": 1110000000.0,
      "tax": 111000000.0,
      "discount": 55500000.0,
      "totalAmount": 1165500000.0,
      "notes": "Bulk order for new store opening",
      "createdBy": "John Doe",
    },
    {
      "id": "SO002",
      "supplierName": "XYZ Distributors",
      "supplierContact": "+62 813 9876 5432",
      "orderDate": "2024-01-08T14:30:00Z",
      "deliveryDate": "2024-01-12T00:00:00Z",
      "status": "Confirmed",
      "orderType": "Urgent",
      "paymentTerms": "Net 15",
      "items": [
        {"product": "MacBook Air M2", "quantity": 20, "unitPrice": 18000000.0, "total": 360000000.0},
        {"product": "iPad Pro", "quantity": 15, "unitPrice": 14000000.0, "total": 210000000.0},
      ],
      "subtotal": 570000000.0,
      "tax": 57000000.0,
      "discount": 28500000.0,
      "totalAmount": 598500000.0,
      "notes": "Express delivery required",
      "createdBy": "Jane Smith",
    },
    {
      "id": "SO003",
      "supplierName": "Tech Solutions",
      "supplierContact": "+62 814 1122 3344",
      "orderDate": "2024-01-05T09:15:00Z",
      "deliveryDate": "2024-01-10T00:00:00Z",
      "status": "Delivered",
      "orderType": "Regular",
      "paymentTerms": "Net 30",
      "items": [
        {"product": "AirPods Pro", "quantity": 100, "unitPrice": 3500000.0, "total": 350000000.0},
        {"product": "Apple Watch", "quantity": 50, "unitPrice": 5000000.0, "total": 250000000.0},
      ],
      "subtotal": 600000000.0,
      "tax": 60000000.0,
      "discount": 30000000.0,
      "totalAmount": 630000000.0,
      "notes": "Regular monthly stock replenishment",
      "createdBy": "Bob Johnson",
    },
    {
      "id": "SO004",
      "supplierName": "Mobile Hub",
      "supplierContact": "+62 815 5566 7788",
      "orderDate": "2024-01-12T16:45:00Z",
      "deliveryDate": "2024-01-18T00:00:00Z",
      "status": "Cancelled",
      "orderType": "Regular",
      "paymentTerms": "Net 30",
      "items": [
        {"product": "Xiaomi 14", "quantity": 40, "unitPrice": 8000000.0, "total": 320000000.0},
      ],
      "subtotal": 320000000.0,
      "tax": 32000000.0,
      "discount": 16000000.0,
      "totalAmount": 336000000.0,
      "notes": "Cancelled due to supplier availability",
      "createdBy": "Alice Brown",
    },
  ];

  List<Map<String, dynamic>> supplierOptions = [
    {"label": "All Suppliers", "value": ""},
    {"label": "ABC Electronics", "value": "ABC Electronics"},
    {"label": "XYZ Distributors", "value": "XYZ Distributors"},
    {"label": "Tech Solutions", "value": "Tech Solutions"},
    {"label": "Mobile Hub", "value": "Mobile Hub"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Pending", "value": "Pending"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "All Time", "value": ""},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  List<Map<String, dynamic>> orderTypeOptions = [
    {"label": "Regular", "value": "Regular"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "Bulk", "value": "Bulk"},
  ];

  List<Map<String, dynamic>> paymentTermsOptions = [
    {"label": "Net 15", "value": "Net 15"},
    {"label": "Net 30", "value": "Net 30"},
    {"label": "Net 45", "value": "Net 45"},
    {"label": "Cash on Delivery", "value": "COD"},
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return ordersData.where((order) {
      final matchesSearch = searchQuery.isEmpty ||
          "${order["supplierName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesSupplier = selectedSupplier.isEmpty ||
          order["supplierName"] == selectedSupplier;
      
      final matchesStatus = selectedStatus.isEmpty ||
          order["status"] == selectedStatus;
      
      return matchesSearch && matchesSupplier && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Confirmed":
        return infoColor;
      case "Delivered":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getOrderTypeColor(String orderType) {
    switch (orderType) {
      case "Regular":
        return primaryColor;
      case "Urgent":
        return dangerColor;
      case "Bulk":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOrdersOverview() {
    final totalOrders = ordersData.length;
    final pendingOrders = ordersData.where((o) => o["status"] == "Pending").length;
    final confirmedOrders = ordersData.where((o) => o["status"] == "Confirmed").length;
    final deliveredOrders = ordersData.where((o) => o["status"] == "Delivered").length;
    final totalValue = ordersData.fold(0.0, (sum, o) => sum + (o["totalAmount"] as double));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Supplier Orders Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Total Orders",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$totalOrders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.pending,
                            color: warningColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$pendingOrders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: infoColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Confirmed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$confirmedOrders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.local_shipping,
                            color: successColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Delivered",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$deliveredOrders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: successColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Total Order Value",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Rp ${totalValue.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Supplier Orders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QTextField(
                label: "Search orders...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Supplier",
                      items: supplierOptions,
                      value: selectedSupplier,
                      onChanged: (value, label) {
                        selectedSupplier = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ...filteredOrders.map((order) => Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(
                width: 4,
                color: _getStatusColor("${order["status"]}"),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${order["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${order["supplierName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${order["supplierContact"]}",
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
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${order["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${order["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${order["status"]}"),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getOrderTypeColor("${order["orderType"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${order["orderType"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getOrderTypeColor("${order["orderType"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Order Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(order["orderDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Delivery Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(order["deliveryDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Items Count",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(order["items"] as List).length} items",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Payment Terms",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${order["paymentTerms"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Rp ${(order["subtotal"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Tax",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Rp ${(order["tax"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Rp ${(order["discount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Rp ${(order["totalAmount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
              if ("${order["notes"]}".isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${order["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Created by: ${order["createdBy"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        si("Viewing order details");
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: order["status"] == "Pending" ? "Confirm" : "Track",
                      size: bs.sm,
                      onPressed: () {
                        if (order["status"] == "Pending") {
                          ss("Order confirmed successfully");
                        } else {
                          si("Tracking order status");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildCreateOrderForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Text(
              "Create New Supplier Order",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QTextField(
              label: "Supplier Name",
              value: supplierName,
              validator: Validator.required,
              onChanged: (value) {
                supplierName = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Order Type",
              items: orderTypeOptions,
              value: orderType,
              onChanged: (value, label) {
                orderType = value;
                setState(() {});
              },
            ),
            QDatePicker(
              label: "Expected Delivery Date",
              value: deliveryDate.isNotEmpty ? DateTime.parse(deliveryDate) : DateTime.now().add(Duration(days: 7)),
              onChanged: (value) {
                deliveryDate = value.toIso8601String();
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Payment Terms",
              items: paymentTermsOptions,
              value: paymentTerms,
              onChanged: (value, label) {
                paymentTerms = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Order Notes",
              value: notes,
              hint: "Additional notes or requirements",
              onChanged: (value) {
                notes = value;
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order Items",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Add order items after creating the order",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Order",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    loading = true;
                    setState(() {});
                    
                    await Future.delayed(Duration(seconds: 2));
                    
                    // Add to orders data
                    ordersData.insert(0, {
                      "id": "SO${(ordersData.length + 1).toString().padLeft(3, '0')}",
                      "supplierName": supplierName,
                      "supplierContact": "+62 812 0000 0000",
                      "orderDate": DateTime.now().toIso8601String(),
                      "deliveryDate": deliveryDate,
                      "status": "Pending",
                      "orderType": orderType,
                      "paymentTerms": paymentTerms,
                      "items": [],
                      "subtotal": 0.0,
                      "tax": 0.0,
                      "discount": 0.0,
                      "totalAmount": 0.0,
                      "notes": notes,
                      "createdBy": "Current User",
                    });
                    
                    // Reset form
                    supplierName = "";
                    orderType = "Regular";
                    deliveryDate = "";
                    paymentTerms = "Net 30";
                    notes = "";
                    
                    loading = false;
                    setState(() {});
                    
                    ss("Supplier order created successfully");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Supplier Orders",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Orders", icon: Icon(Icons.receipt_long)),
        Tab(text: "Create", icon: Icon(Icons.add_shopping_cart)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOrdersOverview(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOrdersList(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCreateOrderForm(),
        ),
      ],
    );
  }
}
