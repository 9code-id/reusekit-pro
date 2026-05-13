import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorDetailView extends StatefulWidget {
  const AbaVendorDetailView({super.key});

  @override
  State<AbaVendorDetailView> createState() => _AbaVendorDetailViewState();
}

class _AbaVendorDetailViewState extends State<AbaVendorDetailView> {
  int currentTab = 0;

  Map<String, dynamic> vendor = {
    "id": "V001",
    "name": "Office Supplies Plus",
    "category": "Office Supplies",
    "email": "contact@officesuppliesplus.com",
    "phone": "+1 (555) 123-4567",
    "address": "123 Business Ave, Suite 100",
    "city": "New York",
    "state": "NY",
    "zipCode": "10001",
    "country": "USA",
    "status": "Active",
    "totalSpent": 15420.50,
    "lastOrderDate": "2024-12-15",
    "paymentTerms": "Net 30",
    "taxId": "12-3456789",
    "contactPerson": "John Smith",
    "contactTitle": "Sales Manager",
    "contactPhone": "+1 (555) 123-4567",
    "contactEmail": "john.smith@officesuppliesplus.com",
    "rating": 4.8,
    "orderCount": 47,
    "joinDate": "2023-03-15",
    "website": "www.officesuppliesplus.com",
    "certifications": ["ISO 9001", "Green Certified"],
    "businessHours": "Mon-Fri: 8:00 AM - 6:00 PM",
    "alternateContact": {
      "name": "Lisa Johnson",
      "title": "Account Manager",
      "phone": "+1 (555) 123-4568",
      "email": "lisa.johnson@officesuppliesplus.com"
    },
    "notes": "Reliable supplier with competitive pricing. Excellent customer service and fast delivery.",
    "attachments": [
      {"name": "Contract_2024.pdf", "type": "pdf", "date": "2024-01-15"},
      {"name": "Insurance_Certificate.pdf", "type": "pdf", "date": "2024-01-20"},
      {"name": "W9_Form.pdf", "type": "pdf", "date": "2024-01-10"}
    ]
  };

  List<Map<String, dynamic>> orderHistory = [
    {
      "id": "PO-2024-156",
      "date": "2024-12-15",
      "items": "Office supplies, Paper, Pens",
      "amount": 1250.00,
      "status": "Delivered",
      "dueDate": "2025-01-14",
      "paymentStatus": "Paid"
    },
    {
      "id": "PO-2024-142",
      "date": "2024-11-28",
      "items": "Printer cartridges, Notebooks",
      "amount": 890.50,
      "status": "Delivered",
      "dueDate": "2024-12-28",
      "paymentStatus": "Paid"
    },
    {
      "id": "PO-2024-128",
      "date": "2024-11-10",
      "items": "Desk organizers, Folders",
      "amount": 425.75,
      "status": "Delivered",
      "dueDate": "2024-12-10",
      "paymentStatus": "Paid"
    },
    {
      "id": "PO-2024-115",
      "date": "2024-10-22",
      "items": "Whiteboards, Markers",
      "amount": 2100.25,
      "status": "Delivered",
      "dueDate": "2024-11-21",
      "paymentStatus": "Paid"
    },
    {
      "id": "PO-2024-098",
      "date": "2024-09-15",
      "items": "Conference room supplies",
      "amount": 1680.00,
      "status": "Delivered",
      "dueDate": "2024-10-15",
      "paymentStatus": "Overdue"
    }
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "PAY-2024-089",
      "date": "2024-12-14",
      "amount": 1250.00,
      "method": "Bank Transfer",
      "status": "Completed",
      "reference": "PO-2024-156"
    },
    {
      "id": "PAY-2024-078",
      "date": "2024-11-27",
      "amount": 890.50,
      "method": "Check",
      "status": "Completed",
      "reference": "PO-2024-142"
    },
    {
      "id": "PAY-2024-065",
      "date": "2024-11-09",
      "amount": 425.75,
      "method": "Bank Transfer",
      "status": "Completed",
      "reference": "PO-2024-128"
    },
    {
      "id": "PAY-2024-052",
      "date": "2024-10-20",
      "amount": 2100.25,
      "method": "Bank Transfer",
      "status": "Completed",
      "reference": "PO-2024-115"
    }
  ];

  List<Map<String, dynamic>> documents = [
    {
      "name": "Master Service Agreement",
      "type": "Contract",
      "date": "2024-01-15",
      "size": "2.4 MB",
      "status": "Active"
    },
    {
      "name": "Insurance Certificate",
      "type": "Insurance",
      "date": "2024-01-20",
      "size": "1.2 MB",
      "status": "Valid"
    },
    {
      "name": "W9 Tax Form",
      "type": "Tax Document",
      "date": "2024-01-10",
      "size": "850 KB",
      "status": "Current"
    },
    {
      "name": "Product Catalog 2024",
      "type": "Catalog",
      "date": "2024-02-01",
      "size": "5.1 MB",
      "status": "Current"
    },
    {
      "name": "Price List - Q4 2024",
      "type": "Pricing",
      "date": "2024-10-01",
      "size": "680 KB",
      "status": "Current"
    }
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {"metric": "On-Time Delivery", "value": "96%", "trend": "up"},
    {"metric": "Quality Score", "value": "4.8/5", "trend": "stable"},
    {"metric": "Order Accuracy", "value": "98%", "trend": "up"},
    {"metric": "Response Time", "value": "2.1 hrs", "trend": "down"},
    {"metric": "Cost Competitiveness", "value": "85%", "trend": "stable"},
    {"metric": "Invoice Accuracy", "value": "99%", "trend": "up"}
  ];

  void _editVendor() {
    ss("Editing vendor information");
  }

  void _contactVendor() {
    ss("Contacting ${vendor["contactPerson"]} at ${vendor["email"]}");
  }

  void _createOrder() {
    ss("Creating new purchase order for ${vendor["name"]}");
  }

  void _toggleVendorStatus() async {
    String newStatus = vendor["status"] == "Active" ? "Inactive" : "Active";
    bool isConfirmed = await confirm("Are you sure you want to ${vendor["status"] == "Active" ? "deactivate" : "activate"} this vendor?");
    if (isConfirmed) {
      setState(() {
        vendor["status"] = newStatus;
      });
      ss("Vendor status updated to $newStatus");
    }
  }

  void _downloadDocument(Map<String, dynamic> document) {
    ss("Downloading ${document["name"]}");
  }

  void _uploadDocument() {
    ss("Opening document upload dialog");
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    ss("Viewing details for order ${order["id"]}");
  }

  void _viewPaymentDetails(Map<String, dynamic> payment) {
    ss("Viewing details for payment ${payment["id"]}");
  }

  Widget _buildOverviewTab() {
    Color statusColor = vendor["status"] == "Active" ? successColor : dangerColor;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Vendor Header
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
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${vendor["name"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${vendor["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${vendor["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Quick Stats
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Total Spent",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(vendor["totalSpent"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Total Orders",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${vendor["orderCount"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 18),
                              SizedBox(width: 4),
                              Text(
                                "${vendor["rating"]}/5.0",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit Vendor",
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: _editVendor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Contact",
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: _contactVendor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "New Order",
                        icon: Icons.add_shopping_cart,
                        size: bs.sm,
                        onPressed: _createOrder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Contact Information
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
                
                // Primary Contact
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Primary Contact",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${vendor["contactPerson"]} - ${vendor["contactTitle"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendor["contactEmail"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledColor,
                        ),
                      ),
                      Text(
                        "${vendor["contactPhone"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Alternate Contact
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Alternate Contact",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${vendor["alternateContact"]["name"]} - ${vendor["alternateContact"]["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendor["alternateContact"]["email"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledColor,
                        ),
                      ),
                      Text(
                        "${vendor["alternateContact"]["phone"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Address & Business Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Business Address",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${vendor["address"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendor["city"]}, ${vendor["state"]} ${vendor["zipCode"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendor["country"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Website: ${vendor["website"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Business Hours: ${vendor["businessHours"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Business Details
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
              spacing: spMd,
              children: [
                Text(
                  "Business Details",
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
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Tax ID",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          Text(
                            "${vendor["taxId"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Payment Terms",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          Text(
                            "${vendor["paymentTerms"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Join Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          Text(
                            "${vendor["joinDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Certifications
                Text(
                  "Certifications",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: (vendor["certifications"] as List).map((cert) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        cert,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Notes
                if (vendor["notes"] != null && (vendor["notes"] as String).isNotEmpty) ...[
                  Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${vendor["notes"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
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
                      "Total Orders",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${orderHistory.length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Average Order Value",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((orderHistory.fold(0.0, (sum, order) => sum + (order["amount"] as double)) / orderHistory.length).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Last Order",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${orderHistory.first["date"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Order History List
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
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Order History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "New Order",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: _createOrder,
                    ),
                  ],
                ),
                
                ...orderHistory.map((order) {
                  Color statusColor = order["status"] == "Delivered" 
                      ? successColor 
                      : order["status"] == "Pending"
                          ? warningColor
                          : infoColor;
                  
                  Color paymentColor = order["paymentStatus"] == "Paid"
                      ? successColor
                      : order["paymentStatus"] == "Overdue"
                          ? dangerColor
                          : warningColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
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
                                  Row(
                                    children: [
                                      Text(
                                        "${order["id"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
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
                                    ],
                                  ),
                                  Text(
                                    "${order["items"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Order Date: ${order["date"]} • Due: ${order["dueDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "\$${(order["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: paymentColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${order["paymentStatus"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: paymentColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewOrderDetails(order),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Upload Section
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
              spacing: spMd,
              children: [
                Text(
                  "Document Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Upload Document",
                        icon: Icons.upload_file,
                        size: bs.sm,
                        onPressed: _uploadDocument,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Download All",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => ss("Downloading all documents"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Documents List
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
              spacing: spMd,
              children: [
                Text(
                  "Documents (${documents.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...documents.map((document) {
                  IconData docIcon;
                  Color docColor;
                  
                  switch (document["type"] as String) {
                    case "Contract":
                      docIcon = Icons.description;
                      docColor = primaryColor;
                      break;
                    case "Insurance":
                      docIcon = Icons.security;
                      docColor = successColor;
                      break;
                    case "Tax Document":
                      docIcon = Icons.receipt;
                      docColor = warningColor;
                      break;
                    case "Catalog":
                      docIcon = Icons.menu_book;
                      docColor = infoColor;
                      break;
                    case "Pricing":
                      docIcon = Icons.attach_money;
                      docColor = successColor;
                      break;
                    default:
                      docIcon = Icons.insert_drive_file;
                      docColor = disabledBoldColor;
                  }

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: docColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            docIcon,
                            color: docColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${document["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${document["type"]} • ${document["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Uploaded: ${document["date"]} • Status: ${document["status"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () => _downloadDocument(document),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Metrics
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
              spacing: spMd,
              children: [
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: performanceMetrics.map((metric) {
                    Color trendColor = metric["trend"] == "up" 
                        ? successColor 
                        : metric["trend"] == "down" 
                            ? dangerColor 
                            : warningColor;
                    
                    IconData trendIcon = metric["trend"] == "up"
                        ? Icons.trending_up
                        : metric["trend"] == "down"
                            ? Icons.trending_down
                            : Icons.trending_flat;

                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${metric["metric"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Icon(
                                trendIcon,
                                color: trendColor,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Payment History
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
              spacing: spMd,
              children: [
                Text(
                  "Recent Payment History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...paymentHistory.take(5).map((payment) {
                  Color statusColor = payment["status"] == "Completed" 
                      ? successColor 
                      : payment["status"] == "Pending"
                          ? warningColor
                          : dangerColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.payment,
                            color: statusColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${payment["id"]} - ${payment["method"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Ref: ${payment["reference"]} • ${payment["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: spXs,
                          children: [
                            Text(
                              "\$${(payment["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${payment["status"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
                
                if (paymentHistory.length > 5)
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View All Payments",
                      size: bs.sm,
                      onPressed: () => ss("Viewing all payment history"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${vendor["name"]}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildOrderHistoryTab(),
        _buildDocumentsTab(),
        _buildPerformanceTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
