import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorBillsView extends StatefulWidget {
  const AbaVendorBillsView({super.key});

  @override
  State<AbaVendorBillsView> createState() => _AbaVendorBillsViewState();
}

class _AbaVendorBillsViewState extends State<AbaVendorBillsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedVendor = "All";
  bool loading = false;

  List<Map<String, dynamic>> bills = [
    {
      "id": "BILL-001",
      "billNumber": "INV-2024-001",
      "vendorName": "Tech Solutions Ltd",
      "vendorId": "VEN-001",
      "issueDate": "2024-01-15",
      "dueDate": "2024-01-30",
      "amount": 15000.00,
      "paidAmount": 15000.00,
      "balanceAmount": 0.00,
      "status": "Paid",
      "category": "Technology",
      "description": "Software License Renewal",
      "paymentTerms": "Net 30",
      "taxAmount": 1500.00,
      "subtotal": 13500.00,
      "items": [
        {"description": "Software License", "quantity": 1, "unitPrice": 13500.00, "total": 13500.00}
      ]
    },
    {
      "id": "BILL-002",
      "billNumber": "INV-2024-002",
      "vendorName": "Global Supplies Inc",
      "vendorId": "VEN-002",
      "issueDate": "2024-01-10",
      "dueDate": "2024-01-25",
      "amount": 8500.00,
      "paidAmount": 0.00,
      "balanceAmount": 8500.00,
      "status": "Overdue",
      "category": "Supplies",
      "description": "Office Supplies Order",
      "paymentTerms": "Net 15",
      "taxAmount": 850.00,
      "subtotal": 7650.00,
      "items": [
        {"description": "Office Chairs", "quantity": 10, "unitPrice": 450.00, "total": 4500.00},
        {"description": "Desk Supplies", "quantity": 1, "unitPrice": 3150.00, "total": 3150.00}
      ]
    },
    {
      "id": "BILL-003",
      "billNumber": "INV-2024-003",
      "vendorName": "Manufacturing Corp",
      "vendorId": "VEN-003",
      "issueDate": "2024-01-20",
      "dueDate": "2024-02-20",
      "amount": 25000.00,
      "paidAmount": 0.00,
      "balanceAmount": 25000.00,
      "status": "Pending",
      "category": "Manufacturing",
      "description": "Equipment Purchase",
      "paymentTerms": "Net 30",
      "taxAmount": 2500.00,
      "subtotal": 22500.00,
      "items": [
        {"description": "Manufacturing Equipment", "quantity": 1, "unitPrice": 22500.00, "total": 22500.00}
      ]
    },
    {
      "id": "BILL-004",
      "billNumber": "INV-2024-004",
      "vendorName": "Logistics Partners",
      "vendorId": "VEN-004",
      "issueDate": "2024-01-12",
      "dueDate": "2024-01-19",
      "amount": 12750.00,
      "paidAmount": 12750.00,
      "balanceAmount": 0.00,
      "status": "Paid",
      "category": "Logistics",
      "description": "Shipping and Logistics",
      "paymentTerms": "Net 7",
      "taxAmount": 1275.00,
      "subtotal": 11475.00,
      "items": [
        {"description": "Shipping Services", "quantity": 1, "unitPrice": 11475.00, "total": 11475.00}
      ]
    },
    {
      "id": "BILL-005",
      "billNumber": "INV-2024-005",
      "vendorName": "Service Providers LLC",
      "vendorId": "VEN-005",
      "issueDate": "2024-01-18",
      "dueDate": "2024-02-17",
      "amount": 6200.00,
      "paidAmount": 3100.00,
      "balanceAmount": 3100.00,
      "status": "Partial",
      "category": "Services",
      "description": "Consulting Services",
      "paymentTerms": "Net 30",
      "taxAmount": 620.00,
      "subtotal": 5580.00,
      "items": [
        {"description": "Business Consulting", "quantity": 40, "unitPrice": 139.50, "total": 5580.00}
      ]
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Partial", "value": "Partial"}
  ];

  List<Map<String, dynamic>> vendorFilters = [
    {"label": "All", "value": "All"},
    {"label": "Tech Solutions Ltd", "value": "Tech Solutions Ltd"},
    {"label": "Global Supplies Inc", "value": "Global Supplies Inc"},
    {"label": "Manufacturing Corp", "value": "Manufacturing Corp"},
    {"label": "Logistics Partners", "value": "Logistics Partners"},
    {"label": "Service Providers LLC", "value": "Service Providers LLC"}
  ];

  List<Map<String, dynamic>> get filteredBills {
    return bills.where((bill) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${bill["billNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${bill["vendorName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${bill["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || bill["status"] == selectedStatus;
      bool matchesVendor = selectedVendor == "All" || bill["vendorName"] == selectedVendor;
      
      return matchesSearch && matchesStatus && matchesVendor;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Partial":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalAmount {
    return filteredBills.fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
  }

  double get paidAmount {
    return filteredBills.fold(0.0, (sum, bill) => sum + (bill["paidAmount"] as double));
  }

  double get balanceAmount {
    return filteredBills.fold(0.0, (sum, bill) => sum + (bill["balanceAmount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Bills"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo AddBillView
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export bills
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                        child: QTextField(
                          label: "Search bills...",
                          value: searchQuery,
                          hint: "Bill number, vendor, or description",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.filter_list,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters,
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
                          label: "Vendor",
                          items: vendorFilters,
                          value: selectedVendor,
                          onChanged: (value, label) {
                            selectedVendor = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Bills",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${paidAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Paid",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${balanceAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Balance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bills List
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (filteredBills.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No bills found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredBills.map((bill) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${bill["billNumber"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${bill["vendorName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${bill["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${bill["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${bill["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Amount Section
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "\$${(bill["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            if ((bill["paidAmount"] as double) > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Paid Amount",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(bill["paidAmount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            if ((bill["balanceAmount"] as double) > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Balance Due",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(bill["balanceAmount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      // Bill Details
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Issue: ${DateTime.parse("${bill["issueDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Due: ${DateTime.parse("${bill["dueDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: bill["status"] == "Overdue" ? dangerColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${bill["description"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Terms: ${bill["paymentTerms"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Bill Items Summary
                      if (bill["items"] != null && (bill["items"] as List).isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Items (${(bill["items"] as List).length})",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(bill["items"] as List).take(2).map((item) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${item["quantity"]} x \$${(item["unitPrice"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              if ((bill["items"] as List).length > 2)
                                Text(
                                  "... and ${(bill["items"] as List).length - 2} more items",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo BillDetailView
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          if (bill["status"] == "Pending" || bill["status"] == "Partial")
                            Expanded(
                              child: QButton(
                                label: "Pay Bill",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo PayBillView
                                },
                              ),
                            ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more options
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
