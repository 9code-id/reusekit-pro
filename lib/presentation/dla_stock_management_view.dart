import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaStockManagementView extends StatefulWidget {
  const DlaStockManagementView({super.key});

  @override
  State<DlaStockManagementView> createState() => _DlaStockManagementViewState();
}

class _DlaStockManagementViewState extends State<DlaStockManagementView> {
  String selectedOperation = "stock_in";
  String selectedWarehouse = "jakarta";
  String selectedProduct = "";
  String quantity = "";
  String notes = "";
  String batchNumber = "";
  String expiryDate = "";
  
  final List<Map<String, dynamic>> operationTypes = [
    {"label": "Stock In", "value": "stock_in"},
    {"label": "Stock Out", "value": "stock_out"},
    {"label": "Stock Transfer", "value": "stock_transfer"},
    {"label": "Stock Adjustment", "value": "stock_adjustment"},
  ];

  final List<Map<String, dynamic>> warehouseOptions = [
    {"label": "Jakarta Main", "value": "jakarta"},
    {"label": "Bandung Hub", "value": "bandung"},
    {"label": "Surabaya Center", "value": "surabaya"},
    {"label": "Medan Branch", "value": "medan"},
  ];

  final List<Map<String, dynamic>> productOptions = [
    {"label": "Samsung Galaxy S24 - SGS24-128-BLK", "value": "INV-001"},
    {"label": "Nike Air Max 270 - NAM270-42-WHT", "value": "INV-002"},
    {"label": "Instant Coffee Premium - ICP-250G-REG", "value": "INV-003"},
    {"label": "Programming Book Collection - PBC-SET-ENG", "value": "INV-004"},
    {"label": "Garden Tools Set - GTS-PRO-5PC", "value": "INV-005"},
  ];

  final List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN-001",
      "type": "stock_in",
      "product": "Samsung Galaxy S24",
      "sku": "SGS24-128-BLK",
      "quantity": 50,
      "warehouse": "Jakarta Main",
      "user": "John Smith",
      "timestamp": "2024-01-15 14:30:00",
      "notes": "New shipment from supplier",
      "batchNumber": "BATCH-001",
      "status": "completed",
    },
    {
      "id": "TXN-002",
      "type": "stock_out",
      "product": "Nike Air Max 270",
      "sku": "NAM270-42-WHT",
      "quantity": 25,
      "warehouse": "Bandung Hub",
      "user": "Sarah Johnson",
      "timestamp": "2024-01-15 13:45:00",
      "notes": "Customer order fulfillment",
      "batchNumber": "BATCH-002",
      "status": "completed",
    },
    {
      "id": "TXN-003",
      "type": "stock_transfer",
      "product": "Instant Coffee Premium",
      "sku": "ICP-250G-REG",
      "quantity": 100,
      "warehouse": "Jakarta Main → Surabaya Center",
      "user": "Mike Wilson",
      "timestamp": "2024-01-15 12:20:00",
      "notes": "Inter-warehouse transfer",
      "batchNumber": "BATCH-003",
      "status": "in_transit",
    },
    {
      "id": "TXN-004",
      "type": "stock_adjustment",
      "product": "Programming Book Collection",
      "sku": "PBC-SET-ENG",
      "quantity": -5,
      "warehouse": "Jakarta Main",
      "user": "Lisa Brown",
      "timestamp": "2024-01-15 11:15:00",
      "notes": "Damaged items removal",
      "batchNumber": "BATCH-004",
      "status": "completed",
    },
  ];

  Color _getOperationColor(String type) {
    switch (type) {
      case "stock_in":
        return successColor;
      case "stock_out":
        return infoColor;
      case "stock_transfer":
        return warningColor;
      case "stock_adjustment":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getOperationIcon(String type) {
    switch (type) {
      case "stock_in":
        return Icons.input;
      case "stock_out":
        return Icons.output;
      case "stock_transfer":
        return Icons.swap_horiz;
      case "stock_adjustment":
        return Icons.tune;
      default:
        return Icons.inventory;
    }
  }

  String _getOperationLabel(String type) {
    switch (type) {
      case "stock_in":
        return "Stock In";
      case "stock_out":
        return "Stock Out";
      case "stock_transfer":
        return "Transfer";
      case "stock_adjustment":
        return "Adjustment";
      default:
        return "Unknown";
    }
  }

  Color _getTransactionStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_transit":
        return infoColor;
      case "pending":
        return warningColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOperationSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Stock Operation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: operationTypes.map((operation) {
              bool isSelected = selectedOperation == operation["value"];
              Color operationColor = _getOperationColor(operation["value"]);
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedOperation = operation["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? operationColor.withAlpha(20) : disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? operationColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _getOperationIcon(operation["value"]),
                          color: isSelected ? operationColor : disabledBoldColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${operation["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? operationColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStockForm() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Transaction Details",
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
                child: QDropdownField(
                  label: "Warehouse",
                  items: warehouseOptions,
                  value: selectedWarehouse,
                  onChanged: (value, label) {
                    selectedWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Product",
                  items: productOptions,
                  value: selectedProduct,
                  onChanged: (value, label) {
                    selectedProduct = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: quantity,
                  onChanged: (value) {
                    quantity = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Batch Number",
                  value: batchNumber,
                  hint: "Enter batch number",
                  onChanged: (value) {
                    batchNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (selectedOperation == "stock_in")
            QDatePicker(
              label: "Expiry Date (Optional)",
              value: expiryDate.isNotEmpty ? DateTime.parse(expiryDate) : DateTime.now(),
              onChanged: (value) {
                expiryDate = value.toString().split(' ')[0];
                setState(() {});
              },
            ),
          QTextField(
            label: "Notes",
            value: notes,
            hint: "Add transaction notes",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Process ${_getOperationLabel(selectedOperation)}",
              size: bs.md,
              onPressed: () {
                if (selectedProduct.isEmpty || quantity.isEmpty) {
                  se("Please fill in all required fields");
                  return;
                }
                ss("${_getOperationLabel(selectedOperation)} processed successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Actions",
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.qr_code_scanner, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "Scan Barcode",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.file_upload, color: infoColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "Bulk Import",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.history, color: warningColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "View History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
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
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  si("View all transactions");
                },
              ),
            ],
          ),
          ...recentTransactions.take(3).map((transaction) {
            Color operationColor = _getOperationColor(transaction["type"]);
            Color statusColor = _getTransactionStatusColor(transaction["status"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: operationColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: operationColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getOperationIcon(transaction["type"]),
                        color: operationColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${transaction["id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${transaction["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${transaction["product"]} (${transaction["sku"]})",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Qty: ${transaction["quantity"]} | ${transaction["warehouse"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${transaction["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  if (transaction["notes"].toString().isNotEmpty)
                    Text(
                      "${transaction["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Management"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              si("Open barcode scanner");
            },
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("More stock management options");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOperationSelector(),
            _buildStockForm(),
            _buildQuickActions(),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }
}
