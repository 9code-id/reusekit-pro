import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaTransferView extends StatefulWidget {
  const ImaTransferView({super.key});

  @override
  State<ImaTransferView> createState() => _ImaTransferViewState();
}

class _ImaTransferViewState extends State<ImaTransferView> {
  String selectedStatus = "All";
  String searchQuery = "";
  String selectedProduct = "";
  String selectedLocation = "";
  String selectedType = "";
  bool showTransferForm = false;
  String transferType = "Internal";
  String fromLocation = "";
  String toLocation = "";
  String selectedProductToTransfer = "";
  String quantity = "";
  String priority = "Normal";
  String transferReason = "";
  String notes = "";

  List<Map<String, dynamic>> transfers = [
    {
      "id": "TRF-001",
      "product": "Premium Laptop",
      "from_location": "Main Warehouse - A1-01",
      "to_location": "Retail Store - R1-05",
      "quantity": 25,
      "requested_by": "John Smith",
      "status": "Pending",
      "priority": "High",
      "created_date": "2024-06-15",
      "expected_date": "2024-06-17",
      "type": "Internal",
      "transfer_reason": "Stock Replenishment",
      "unit_value": 999.99,
      "total_value": 24999.75,
      "progress": 0,
    },
    {
      "id": "TRF-002",
      "product": "Wireless Mouse",
      "from_location": "Warehouse B - B2-15",
      "to_location": "Distribution Center",
      "quantity": 150,
      "requested_by": "Sarah Wilson",
      "status": "In Transit",
      "priority": "Normal",
      "created_date": "2024-06-14",
      "expected_date": "2024-06-16",
      "type": "Inter-facility",
      "transfer_reason": "Redistribution",
      "unit_value": 29.99,
      "total_value": 4498.50,
      "progress": 65,
    },
    {
      "id": "TRF-003",
      "product": "Gaming Keyboard",
      "from_location": "Main Warehouse - A2-10",
      "to_location": "Online Fulfillment",
      "quantity": 80,
      "requested_by": "Mike Johnson",
      "status": "Completed",
      "priority": "Low",
      "created_date": "2024-06-12",
      "expected_date": "2024-06-14",
      "type": "Internal",
      "transfer_reason": "Channel Allocation",
      "unit_value": 79.99,
      "total_value": 6399.20,
      "progress": 100,
    },
    {
      "id": "TRF-004",
      "product": "Smartphone Case",
      "from_location": "Warehouse C - C1-08",
      "to_location": "Retail Store - R2-12",
      "quantity": 200,
      "requested_by": "Emily Davis",
      "status": "Cancelled",
      "priority": "Normal",
      "created_date": "2024-06-13",
      "expected_date": "2024-06-15",
      "type": "Internal",
      "transfer_reason": "Promotional Campaign",
      "unit_value": 19.99,
      "total_value": 3998.00,
      "progress": 0,
    },
    {
      "id": "TRF-005",
      "product": "External Hard Drive",
      "from_location": "Distribution Center",
      "to_location": "Main Warehouse - A3-05",
      "quantity": 45,
      "requested_by": "David Lee",
      "status": "In Transit",
      "priority": "High",
      "created_date": "2024-06-16",
      "expected_date": "2024-06-18",
      "type": "Return",
      "transfer_reason": "Quality Issues",
      "unit_value": 129.99,
      "total_value": 5849.55,
      "progress": 30,
    },
  ];

  List<String> statusOptions = ["All", "Pending", "In Transit", "Completed", "Cancelled"];
  List<String> typeOptions = ["All", "Internal", "Inter-facility", "Return"];
  List<String> priorityOptions = ["Normal", "High", "Low"];
  List<String> transferReasons = [
    "Stock Replenishment",
    "Redistribution", 
    "Channel Allocation",
    "Promotional Campaign",
    "Quality Issues",
    "Seasonal Adjustment",
    "Customer Request",
    "Emergency Transfer"
  ];

  List<Map<String, dynamic>> get filteredTransfers {
    return transfers.where((transfer) {
      bool matchesStatus = selectedStatus == "All" || transfer["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          transfer["product"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          transfer["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          transfer["from_location"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          transfer["to_location"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesProduct = selectedProduct.isEmpty || transfer["product"] == selectedProduct;
      bool matchesLocation = selectedLocation.isEmpty ||
          transfer["from_location"].contains(selectedLocation) ||
          transfer["to_location"].contains(selectedLocation);
      bool matchesType = selectedType == "All" || selectedType.isEmpty || transfer["type"] == selectedType;

      return matchesStatus && matchesSearch && matchesProduct && matchesLocation && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Transit":
        return infoColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Normal":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _showTransferDetails(Map<String, dynamic> transfer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.swap_horiz, color: primaryColor),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transfer Details",
                    style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${transfer["id"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(transfer["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: _getStatusColor(transfer["status"]).withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(transfer["status"]),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${transfer["status"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(transfer["status"]),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(transfer["priority"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${transfer["priority"]} Priority",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getPriorityColor(transfer["priority"]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              _buildDetailRow("Product", "${transfer["product"]}"),
              _buildDetailRow("From Location", "${transfer["from_location"]}"),
              _buildDetailRow("To Location", "${transfer["to_location"]}"),
              _buildDetailRow("Quantity", "${transfer["quantity"]} units"),
              _buildDetailRow("Transfer Type", "${transfer["type"]}"),
              _buildDetailRow("Transfer Reason", "${transfer["transfer_reason"]}"),
              _buildDetailRow("Requested By", "${transfer["requested_by"]}"),
              _buildDetailRow("Created Date", "${transfer["created_date"]}"),
              _buildDetailRow("Expected Date", "${transfer["expected_date"]}"),
              _buildDetailRow("Unit Value", "\$${((transfer["unit_value"] as double)).currency}"),
              _buildDetailRow("Total Value", "\$${((transfer["total_value"] as double)).currency}"),
              if (transfer["status"] == "In Transit") ...[
                SizedBox(height: spSm),
                Text(
                  "Transfer Progress",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (transfer["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                ),
                SizedBox(height: spXs),
                Text(
                  "${transfer["progress"]}% Complete",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          if (transfer["status"] == "Pending")
            QButton(
              label: "Process",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                // Process transfer logic
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showTransferForm() {
    setState(() {
      showTransferForm = true;
      transferType = "Internal";
      fromLocation = "";
      toLocation = "";
      selectedProductToTransfer = "";
      quantity = "";
      priority = "Normal";
      transferReason = "";
      notes = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showTransferForm) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Create Transfer"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                showTransferForm = false;
              });
            },
          ),
          actions: [
            QButton(
              label: "Save",
              size: bs.sm,
              onPressed: () {
                // Save transfer logic
                setState(() {
                  showTransferForm = false;
                });
                ss("Transfer request created successfully");
              },
            ),
            SizedBox(width: spMd),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Transfer Type",
                items: [
                  {"label": "Internal Transfer", "value": "Internal"},
                  {"label": "Inter-facility Transfer", "value": "Inter-facility"},
                  {"label": "Return Transfer", "value": "Return"},
                ],
                value: transferType,
                onChanged: (value, label) {
                  transferType = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Product",
                value: selectedProductToTransfer,
                hint: "Search and select product",
                onChanged: (value) {
                  selectedProductToTransfer = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "From Location",
                value: fromLocation,
                hint: "Select source location",
                onChanged: (value) {
                  fromLocation = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "To Location",
                value: toLocation,
                hint: "Select destination location",
                onChanged: (value) {
                  toLocation = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Quantity",
                value: quantity,
                hint: "Enter quantity to transfer",
                onChanged: (value) {
                  quantity = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Priority",
                items: priorityOptions.map((priority) => {
                  "label": priority,
                  "value": priority,
                }).toList(),
                value: priority,
                onChanged: (value, label) {
                  priority = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Transfer Reason",
                items: transferReasons.map((reason) => {
                  "label": reason,
                  "value": reason,
                }).toList(),
                value: transferReason,
                onChanged: (value, label) {
                  transferReason = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Additional Notes",
                value: notes,
                hint: "Add any additional instructions or comments",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Transfers"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _showTransferForm,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Transfers", "${transfers.length}", Icons.swap_horiz, primaryColor),
                _buildStatCard("Pending", "${transfers.where((t) => t["status"] == "Pending").length}", Icons.pending, warningColor),
                _buildStatCard("In Transit", "${transfers.where((t) => t["status"] == "In Transit").length}", Icons.local_shipping, infoColor),
                _buildStatCard("Completed", "${transfers.where((t) => t["status"] == "Completed").length}", Icons.check_circle, successColor),
              ],
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, size: 16, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Filters",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Search",
                    value: searchQuery,
                    hint: "Search by ID, product, or location",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions.map((status) => {
                            "label": status,
                            "value": status,
                          }).toList(),
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeOptions.map((type) => {
                            "label": type,
                            "value": type,
                          }).toList(),
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Transfer List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.list, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "Transfer Requests (${filteredTransfers.length})",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTransfers.length,
                    separatorBuilder: (context, index) => Divider(height: 1, color: disabledOutlineBorderColor),
                    itemBuilder: (context, index) {
                      final transfer = filteredTransfers[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getStatusColor(transfer["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.swap_horiz,
                                color: _getStatusColor(transfer["status"]),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${transfer["id"]}",
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(transfer["priority"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${transfer["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor(transfer["priority"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${transfer["product"]}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          "${transfer["from_location"]} → ${transfer["to_location"]}",
                                          style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(transfer["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${transfer["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(transfer["status"]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${transfer["quantity"]} units",
                                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${((transfer["total_value"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (transfer["status"] == "In Transit") ...[
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: (transfer["progress"] as int) / 100,
                                      backgroundColor: disabledColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                                    ),
                                    SizedBox(height: spXxs),
                                    Text(
                                      "${transfer["progress"]}% Complete",
                                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () => _showTransferDetails(transfer),
                              child: Icon(
                                Icons.chevron_right,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
