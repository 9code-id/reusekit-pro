import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaInvoiceGenerationView extends StatefulWidget {
  const HhaInvoiceGenerationView({super.key});

  @override
  State<HhaInvoiceGenerationView> createState() => _HhaInvoiceGenerationViewState();
}

class _HhaInvoiceGenerationViewState extends State<HhaInvoiceGenerationView> {
  int currentTab = 0;
  
  // Form fields
  String guestName = "";
  String roomNumber = "";
  String invoiceType = "";
  String description = "";
  String amount = "";
  String taxRate = "10";
  String discountAmount = "";
  String searchQuery = "";
  String filterStatus = "";
  String filterType = "";
  
  // Sample invoice data
  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "guestName": "John Smith",
      "roomNumber": "101",
      "type": "Room Charges",
      "date": "2024-01-15",
      "dueDate": "2024-01-16",
      "amount": 250.00,
      "taxAmount": 25.00,
      "totalAmount": 275.00,
      "status": "Paid",
      "items": [
        {"description": "Room Rent (1 night)", "amount": 200.00},
        {"description": "Room Service", "amount": 30.00},
        {"description": "Minibar", "amount": 20.00},
      ],
      "paymentMethod": "Credit Card",
      "paidAt": "2024-01-15 14:30"
    },
    {
      "id": "INV-2024-002",
      "guestName": "Sarah Johnson",
      "roomNumber": "205",
      "type": "Restaurant",
      "date": "2024-01-14",
      "dueDate": "2024-01-15",
      "amount": 85.00,
      "taxAmount": 8.50,
      "totalAmount": 93.50,
      "status": "Pending",
      "items": [
        {"description": "Dinner for 2", "amount": 65.00},
        {"description": "Wine Bottle", "amount": 20.00},
      ],
      "paymentMethod": "",
      "paidAt": ""
    },
    {
      "id": "INV-2024-003",
      "guestName": "Michael Brown",
      "roomNumber": "304",
      "type": "Spa Services",
      "date": "2024-01-13",
      "dueDate": "2024-01-14",
      "amount": 150.00,
      "taxAmount": 15.00,
      "totalAmount": 165.00,
      "status": "Overdue",
      "items": [
        {"description": "Massage Therapy", "amount": 100.00},
        {"description": "Facial Treatment", "amount": 50.00},
      ],
      "paymentMethod": "",
      "paidAt": ""
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "name": "Room Charges Invoice",
      "type": "Room Charges",
      "defaultItems": [
        {"description": "Room Rent", "amount": 0.0},
        {"description": "Room Service", "amount": 0.0},
      ],
      "taxRate": 10.0,
      "isActive": true
    },
    {
      "id": "2",
      "name": "Restaurant Bill",
      "type": "Restaurant",
      "defaultItems": [
        {"description": "Food & Beverages", "amount": 0.0},
        {"description": "Service Charge", "amount": 0.0},
      ],
      "taxRate": 10.0,
      "isActive": true
    },
    {
      "id": "3",
      "name": "Spa Services Invoice",
      "type": "Spa Services",
      "defaultItems": [
        {"description": "Treatment", "amount": 0.0},
        {"description": "Additional Services", "amount": 0.0},
      ],
      "taxRate": 15.0,
      "isActive": true
    },
  ];

  List<Map<String, dynamic>> get filteredInvoices {
    var filtered = invoices.where((invoice) {
      final matchesSearch = searchQuery.isEmpty ||
          (invoice["guestName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (invoice["roomNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (invoice["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = filterStatus.isEmpty || invoice["status"] == filterStatus;
      final matchesType = filterType.isEmpty || invoice["type"] == filterType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return successColor;
      case 'pending':
        return warningColor;
      case 'overdue':
        return dangerColor;
      case 'cancelled':
        return disabledColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalPaidAmount {
    return invoices
        .where((invoice) => invoice["status"] == "Paid")
        .fold(0.0, (sum, invoice) => sum + (invoice["totalAmount"] as double));
  }

  double get totalPendingAmount {
    return invoices
        .where((invoice) => invoice["status"] == "Pending")
        .fold(0.0, (sum, invoice) => sum + (invoice["totalAmount"] as double));
  }

  double get totalOverdueAmount {
    return invoices
        .where((invoice) => invoice["status"] == "Overdue")
        .fold(0.0, (sum, invoice) => sum + (invoice["totalAmount"] as double));
  }

  Widget _buildCreateInvoiceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
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
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt_long, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Invoices",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${invoices.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
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
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pending_actions, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalPendingAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
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
          SizedBox(height: spLg),
          
          // Invoice Form
          Text(
            "Generate New Invoice",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Guest Name",
                  value: guestName,
                  hint: "Enter guest name",
                  onChanged: (value) {
                    guestName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Room Number",
                  value: roomNumber,
                  hint: "Enter room number",
                  onChanged: (value) {
                    roomNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Invoice Type",
            value: invoiceType,
            items: [
              {"label": "Room Charges", "value": "Room Charges"},
              {"label": "Restaurant", "value": "Restaurant"},
              {"label": "Spa Services", "value": "Spa Services"},
              {"label": "Event Services", "value": "Event Services"},
              {"label": "Transportation", "value": "Transportation"},
              {"label": "Other Services", "value": "Other Services"},
            ],
            onChanged: (value, label) {
              invoiceType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Description",
            value: description,
            hint: "Enter service description",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Amount (\$)",
                  value: amount,
                  onChanged: (value) {
                    amount = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Tax Rate (%)",
                  value: taxRate,
                  onChanged: (value) {
                    taxRate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          QNumberField(
            label: "Discount Amount (\$)",
            value: discountAmount,
            hint: "Enter discount amount (optional)",
            onChanged: (value) {
              discountAmount = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          
          // Invoice Preview
          if (amount.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invoice Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal:", style: TextStyle(fontSize: 14)),
                      Text("\$${amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  if (taxRate.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax (${taxRate}%):", style: TextStyle(fontSize: 14)),
                        Text(
                          "\$${((double.tryParse(amount) ?? 0) * (double.tryParse(taxRate) ?? 0) / 100).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                  ],
                  
                  if (discountAmount.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount:", style: TextStyle(fontSize: 14, color: successColor)),
                        Text(
                          "-\$${discountAmount}",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: successColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                  ],
                  
                  Divider(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${_calculateTotal()}",
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
            ),
            SizedBox(height: spLg),
          ],
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Invoice",
                  onPressed: () {
                    ss("Invoice generated successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save as Template",
                  onPressed: () {
                    si("Invoice template saved");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateTotal() {
    double subtotal = double.tryParse(amount) ?? 0.0;
    double tax = subtotal * (double.tryParse(taxRate) ?? 0.0) / 100;
    double discount = double.tryParse(discountAmount) ?? 0.0;
    return (subtotal + tax - discount).toStringAsFixed(2);
  }

  Widget _buildInvoiceListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Invoices",
                  value: searchQuery,
                  hint: "Search by guest name, room, or invoice ID",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  value: filterStatus,
                  items: [
                    {"label": "All Status", "value": ""},
                    {"label": "Paid", "value": "Paid"},
                    {"label": "Pending", "value": "Pending"},
                    {"label": "Overdue", "value": "Overdue"},
                    {"label": "Cancelled", "value": "Cancelled"},
                  ],
                  onChanged: (value, label) {
                    filterStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Type",
                  value: filterType,
                  items: [
                    {"label": "All Types", "value": ""},
                    {"label": "Room Charges", "value": "Room Charges"},
                    {"label": "Restaurant", "value": "Restaurant"},
                    {"label": "Spa Services", "value": "Spa Services"},
                    {"label": "Event Services", "value": "Event Services"},
                  ],
                  onChanged: (value, label) {
                    filterType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          
          // Invoices List
          Text(
            "Invoices (${filteredInvoices.length})",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...filteredInvoices.map((invoice) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${invoice["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(invoice["status"] as String).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${invoice["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(invoice["status"] as String),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${invoice["guestName"]}",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.hotel, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Room ${invoice["roomNumber"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.category, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${invoice["type"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${invoice["date"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      ...(invoice["items"] as List).map((item) => Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${item["description"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Text(
                              "\$${(item["amount"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                      Divider(height: spSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${(invoice["totalAmount"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        si("Viewing invoice ${invoice["id"]}");
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Print",
                      size: bs.sm,
                      onPressed: () {
                        si("Printing invoice ${invoice["id"]}");
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Email",
                      size: bs.sm,
                      onPressed: () {
                        si("Emailing invoice ${invoice["id"]}");
                      },
                    ),
                    Spacer(),
                    if (invoice["status"] != "Paid")
                      QButton(
                        label: "Mark Paid",
                        size: bs.sm,
                        onPressed: () {
                          invoice["status"] = "Paid";
                          invoice["paidAt"] = DateTime.now().toString();
                          setState(() {});
                          ss("Invoice marked as paid");
                        },
                      ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invoice Templates",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...templates.map((template) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: (template["isActive"] as bool ? successColor : disabledColor).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        template["isActive"] as bool ? "Active" : "Inactive",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: template["isActive"] as bool ? successColor : disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Text(
                  "Type: ${template["type"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                
                Text(
                  "Tax Rate: ${template["taxRate"]}%",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                Text(
                  "Default Items:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                
                ...(template["defaultItems"] as List).map((item) => Padding(
                  padding: EdgeInsets.only(left: spMd, bottom: spXs),
                  child: Text(
                    "• ${item["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                )).toList(),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    QButton(
                      label: "Use Template",
                      size: bs.sm,
                      onPressed: () {
                        invoiceType = template["type"] as String;
                        taxRate = (template["taxRate"] as double).toString();
                        setState(() {});
                        currentTab = 0;
                        setState(() {});
                        si("Template applied");
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Edit",
                      size: bs.sm,
                      onPressed: () {
                        si("Editing template ${template["name"]}");
                      },
                    ),
                    Spacer(),
                    QButton(
                      label: template["isActive"] as bool ? "Deactivate" : "Activate",
                      size: bs.sm,
                      onPressed: () {
                        template["isActive"] = !(template["isActive"] as bool);
                        setState(() {});
                        ss("Template status updated");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Invoice Generation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Create Invoice", icon: Icon(Icons.add)),
        Tab(text: "Invoice List", icon: Icon(Icons.list_alt)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
      ],
      tabChildren: [
        _buildCreateInvoiceTab(),
        _buildInvoiceListTab(),
        _buildTemplatesTab(),
      ],
    );
  }
}
