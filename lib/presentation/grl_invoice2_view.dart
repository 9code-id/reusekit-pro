import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice2View extends StatefulWidget {
  @override
  State<GrlInvoice2View> createState() => _GrlInvoice2ViewState();
}

class _GrlInvoice2ViewState extends State<GrlInvoice2View> {
  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "clientName": "TechStart Inc.",
      "amount": 4250.0,
      "date": "2024-01-15",
      "dueDate": "2024-02-15",
      "status": "Pending",
      "items": 4,
    },
    {
      "id": "INV-2024-002",
      "clientName": "Digital Solutions Ltd.",
      "amount": 1850.0,
      "date": "2024-01-12",
      "dueDate": "2024-02-12",
      "status": "Paid",
      "items": 2,
    },
    {
      "id": "INV-2024-003",
      "clientName": "Marketing Pro Agency",
      "amount": 3200.0,
      "date": "2024-01-10",
      "dueDate": "2024-02-10",
      "status": "Overdue",
      "items": 5,
    },
    {
      "id": "INV-2024-004",
      "clientName": "StartUp Innovations",
      "amount": 2750.0,
      "date": "2024-01-08",
      "dueDate": "2024-02-08",
      "status": "Draft",
      "items": 3,
    },
    {
      "id": "INV-2024-005",
      "clientName": "E-Commerce Solutions",
      "amount": 5400.0,
      "date": "2024-01-05",
      "dueDate": "2024-02-05",
      "status": "Paid",
      "items": 6,
    },
  ];

  String selectedFilter = "All";
  String searchQuery = "";

  List<String> filterOptions = ["All", "Pending", "Paid", "Overdue", "Draft"];

  List<Map<String, dynamic>> get filteredInvoices {
    var filtered = invoices;

    if (selectedFilter != "All") {
      filtered = filtered.where((invoice) => invoice["status"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((invoice) =>
          invoice["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          invoice["id"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  double get totalPending => invoices
      .where((invoice) => invoice["status"] == "Pending")
      .fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));

  double get totalPaid => invoices
      .where((invoice) => invoice["status"] == "Paid")
      .fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));

  double get totalOverdue => invoices
      .where((invoice) => invoice["status"] == "Overdue")
      .fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            _buildSummaryCards(),
            _buildSearchAndFilter(),
            _buildInvoicesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: _buildSummaryCard("Pending", totalPending, warningColor, Icons.access_time),
        ),
        Expanded(
          child: _buildSummaryCard("Paid", totalPaid, successColor, Icons.check_circle),
        ),
        Expanded(
          child: _buildSummaryCard("Overdue", totalOverdue, dangerColor, Icons.warning),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon) {
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
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
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
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search invoices...",
                      prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spSm,
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: DropdownButton<String>(
                  value: selectedFilter,
                  underline: SizedBox.shrink(),
                  items: filterOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedFilter = value!;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicesList() {
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
                Text(
                  "Invoices (${filteredInvoices.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.sort,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ],
            ),
          ),
          if (filteredInvoices.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: disabledColor,
                  ),
                  Text(
                    "No invoices found",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filter criteria",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          else
            ...List.generate(filteredInvoices.length, (index) {
              final invoice = filteredInvoices[index];
              return _buildInvoiceItem(invoice, index == filteredInvoices.length - 1);
            }),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(Map<String, dynamic> invoice, bool isLast) {
    Color statusColor = _getStatusColor(invoice["status"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${invoice["id"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${invoice["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${invoice["clientName"]}",
                  style: TextStyle(
                    fontSize: 15,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${(invoice["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Due: ${invoice["dueDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${invoice["items"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    Row(
                      spacing: spXs,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.visibility,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: successColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.share,
                              size: 16,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Draft":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
