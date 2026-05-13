import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPurchaseOrdersView extends StatefulWidget {
  const AbaPurchaseOrdersView({super.key});

  @override
  State<AbaPurchaseOrdersView> createState() => _AbaPurchaseOrdersViewState();
}

class _AbaPurchaseOrdersViewState extends State<AbaPurchaseOrdersView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  bool loading = false;

  List<Map<String, dynamic>> purchaseOrders = [
    {
      "id": "PO-001",
      "poNumber": "PO-2024-001",
      "vendorName": "Tech Solutions Ltd",
      "vendorId": "VEN-001",
      "requestedBy": "John Manager",
      "department": "IT Department",
      "orderDate": "2024-01-15",
      "expectedDelivery": "2024-01-30",
      "actualDelivery": "2024-01-28",
      "status": "Delivered",
      "priority": "High",
      "totalAmount": 15000.00,
      "currency": "USD",
      "description": "Software licenses and hardware equipment",
      "approvedBy": "CEO",
      "approvalDate": "2024-01-16",
      "items": [
        {"description": "Software License", "quantity": 5, "unitPrice": 2000.00, "total": 10000.00},
        {"description": "Hardware Equipment", "quantity": 1, "unitPrice": 5000.00, "total": 5000.00}
      ],
      "deliveryAddress": "Main Office, 123 Business St",
      "notes": "Urgent delivery required for project launch",
      "attachments": 2
    },
    {
      "id": "PO-002",
      "poNumber": "PO-2024-002",
      "vendorName": "Global Supplies Inc",
      "vendorId": "VEN-002",
      "requestedBy": "Sarah Finance",
      "department": "Administration",
      "orderDate": "2024-01-18",
      "expectedDelivery": "2024-02-05",
      "actualDelivery": null,
      "status": "In Transit",
      "priority": "Medium",
      "totalAmount": 8500.00,
      "currency": "USD",
      "description": "Office supplies and furniture",
      "approvedBy": "Finance Manager",
      "approvalDate": "2024-01-19",
      "items": [
        {"description": "Office Chairs", "quantity": 10, "unitPrice": 450.00, "total": 4500.00},
        {"description": "Desk Supplies", "quantity": 1, "unitPrice": 4000.00, "total": 4000.00}
      ],
      "deliveryAddress": "Main Office, 123 Business St",
      "notes": "Schedule delivery during business hours",
      "attachments": 3
    },
    {
      "id": "PO-003",
      "poNumber": "PO-2024-003",
      "vendorName": "Manufacturing Corp",
      "vendorId": "VEN-003",
      "requestedBy": "Mike Director",
      "department": "Production",
      "orderDate": "2024-01-20",
      "expectedDelivery": "2024-02-20",
      "actualDelivery": null,
      "status": "Pending Approval",
      "priority": "High",
      "totalAmount": 25000.00,
      "currency": "USD",
      "description": "Manufacturing equipment upgrade",
      "approvedBy": null,
      "approvalDate": null,
      "items": [
        {"description": "Manufacturing Equipment", "quantity": 1, "unitPrice": 22000.00, "total": 22000.00},
        {"description": "Installation Service", "quantity": 1, "unitPrice": 3000.00, "total": 3000.00}
      ],
      "deliveryAddress": "Production Facility, 456 Industry Ave",
      "notes": "Requires special handling and installation",
      "attachments": 5
    },
    {
      "id": "PO-004",
      "poNumber": "PO-2024-004",
      "vendorName": "Logistics Partners",
      "vendorId": "VEN-004",
      "requestedBy": "Emily Operations",
      "department": "Operations",
      "orderDate": "2024-01-12",
      "expectedDelivery": "2024-01-25",
      "actualDelivery": null,
      "status": "Approved",
      "priority": "Medium",
      "totalAmount": 12750.00,
      "currency": "USD",
      "description": "Logistics and transportation services",
      "approvedBy": "Operations Manager",
      "approvalDate": "2024-01-13",
      "items": [
        {"description": "Monthly Transport Service", "quantity": 12, "unitPrice": 1062.50, "total": 12750.00}
      ],
      "deliveryAddress": "Multiple Locations",
      "notes": "Service contract for entire year",
      "attachments": 4
    },
    {
      "id": "PO-005",
      "poNumber": "PO-2024-005",
      "vendorName": "Service Providers LLC",
      "vendorId": "VEN-005",
      "requestedBy": "David Success",
      "department": "Business Development",
      "orderDate": "2024-01-22",
      "expectedDelivery": "2024-02-15",
      "actualDelivery": null,
      "status": "Cancelled",
      "priority": "Low",
      "totalAmount": 6200.00,
      "currency": "USD",
      "description": "Business consulting services",
      "approvedBy": "BD Manager",
      "approvalDate": "2024-01-23",
      "items": [
        {"description": "Consulting Hours", "quantity": 40, "unitPrice": 155.00, "total": 6200.00}
      ],
      "deliveryAddress": "Main Office Conference Room",
      "notes": "Cancelled due to budget constraints",
      "attachments": 1
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "Approved", "value": "Approved"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"}
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"}
  ];

  List<Map<String, dynamic>> get filteredPOs {
    return purchaseOrders.where((po) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${po["poNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${po["vendorName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${po["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || po["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || po["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Approved":
        return infoColor;
      case "In Transit":
        return warningColor;
      case "Pending Approval":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalAmount {
    return filteredPOs.fold(0.0, (sum, po) => sum + (po["totalAmount"] as double));
  }

  int get pendingApproval {
    return filteredPOs.where((po) => po["status"] == "Pending Approval").length;
  }

  int get inTransit {
    return filteredPOs.where((po) => po["status"] == "In Transit").length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo CreatePurchaseOrderView
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export purchase orders
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
                          label: "Search purchase orders...",
                          value: searchQuery,
                          hint: "PO number, vendor, or description",
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
                          label: "Priority",
                          items: priorityFilters,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
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
                          "Total Value",
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
                          "$pendingApproval",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
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
                          "$inTransit",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "In Transit",
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

            // Purchase Orders List
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (filteredPOs.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No purchase orders found",
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
              ...filteredPOs.map((po) {
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
                      // PO Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${po["poNumber"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${po["vendorName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${po["priority"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${po["priority"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _getPriorityColor("${po["priority"]}"),
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${po["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${po["status"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${po["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        "${po["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Amount
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
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
                              "\$${(po["totalAmount"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Order Details
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
                                  Icons.person,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Requested by: ${po["requestedBy"]} (${po["department"]})",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Order Date: ${DateTime.parse("${po["orderDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Expected: ${DateTime.parse("${po["expectedDelivery"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (po["actualDelivery"] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Delivered: ${DateTime.parse("${po["actualDelivery"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (po["approvedBy"] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Approved by: ${po["approvedBy"]} on ${DateTime.parse("${po["approvalDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      // Items Summary
                      if (po["items"] != null && (po["items"] as List).isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Items (${(po["items"] as List).length})",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(po["items"] as List).take(2).map((item) {
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
                                          fontWeight: FontWeight.w500,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              if ((po["items"] as List).length > 2)
                                Text(
                                  "... and ${(po["items"] as List).length - 2} more items",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),

                      // Notes
                      if (po["notes"] != null && "${po["notes"]}".isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.note,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${po["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
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
                                // navigateTo PurchaseOrderDetailView
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          if (po["status"] == "Pending Approval")
                            Expanded(
                              child: QButton(
                                label: "Approve",
                                size: bs.sm,
                                onPressed: () {
                                  // Approve purchase order
                                },
                              ),
                            ),
                          if (po["status"] == "Approved" || po["status"] == "In Transit")
                            Expanded(
                              child: QButton(
                                label: "Track",
                                size: bs.sm,
                                onPressed: () {
                                  // Track order
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
