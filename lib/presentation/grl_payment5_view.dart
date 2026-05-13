import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment5View extends StatefulWidget {
  @override
  State<GrlPayment5View> createState() => _GrlPayment5ViewState();
}

class _GrlPayment5ViewState extends State<GrlPayment5View> {
  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "client": "Acme Corporation",
      "amount": 2500.00,
      "date": "2024-06-15",
      "dueDate": "2024-07-15",
      "status": "paid",
      "description": "Web Development Services"
    },
    {
      "id": "INV-2024-002",
      "client": "Tech Solutions Ltd",
      "amount": 1850.00,
      "date": "2024-06-20",
      "dueDate": "2024-07-20",
      "status": "pending",
      "description": "Mobile App Development"
    },
    {
      "id": "INV-2024-003",
      "client": "StartupXYZ",
      "amount": 750.00,
      "date": "2024-06-18",
      "dueDate": "2024-07-18",
      "status": "overdue",
      "description": "UI/UX Design Consultation"
    },
    {
      "id": "INV-2024-004",
      "client": "Global Enterprises",
      "amount": 3200.00,
      "date": "2024-06-10",
      "dueDate": "2024-07-10",
      "status": "draft",
      "description": "E-commerce Platform Development"
    },
    {
      "id": "INV-2024-005",
      "client": "Digital Agency",
      "amount": 1200.00,
      "date": "2024-06-22",
      "dueDate": "2024-07-22",
      "status": "sent",
      "description": "SEO Optimization Services"
    },
  ];

  String filterStatus = "all";
  String searchQuery = "";
  bool showCreateInvoice = false;
  String clientName = "";
  String invoiceDescription = "";
  String invoiceAmount = "";
  String selectedDueDate = DateTime.now().add(Duration(days: 30)).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showCreateInvoice = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: showCreateInvoice ? _buildCreateInvoiceForm() : _buildInvoicesList(),
      floatingActionButton: !showCreateInvoice ? FloatingActionButton(
        onPressed: () {
          showCreateInvoice = true;
          setState(() {});
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }

  Widget _buildInvoicesList() {
    List<Map<String, dynamic>> filteredInvoices = invoices.where((invoice) {
      bool matchesStatus = filterStatus == "all" || invoice["status"] == filterStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          invoice["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          invoice["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();

    return Column(
      children: [
        _buildStatsOverview(),
        _buildSearchAndFilter(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: filteredInvoices.map((invoice) {
                return _buildInvoiceCard(invoice);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsOverview() {
    double totalPaid = invoices.where((inv) => inv["status"] == "paid")
        .fold(0.0, (sum, inv) => sum + (inv["amount"] as double));
    double totalPending = invoices.where((inv) => inv["status"] == "pending" || inv["status"] == "sent")
        .fold(0.0, (sum, inv) => sum + (inv["amount"] as double));
    double totalOverdue = invoices.where((inv) => inv["status"] == "overdue")
        .fold(0.0, (sum, inv) => sum + (inv["amount"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _buildStatCard("Paid", totalPaid, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Pending", totalPending, warningColor),
              SizedBox(width: spSm),
              _buildStatCard("Overdue", totalOverdue, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, double amount, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Invoices",
            value: searchQuery,
            hint: "Search by client name or invoice ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          QHorizontalScroll(
            children: [
              _buildFilterChip("All", "all"),
              _buildFilterChip("Draft", "draft"),
              _buildFilterChip("Sent", "sent"),
              _buildFilterChip("Pending", "pending"),
              _buildFilterChip("Paid", "paid"),
              _buildFilterChip("Overdue", "overdue"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String title, String value) {
    bool isSelected = filterStatus == value;
    return GestureDetector(
      onTap: () {
        filterStatus = value;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    Color statusColor;
    IconData statusIcon;
    
    switch (invoice["status"]) {
      case "paid":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "pending":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      case "overdue":
        statusColor = dangerColor;
        statusIcon = Icons.error;
        break;
      case "sent":
        statusColor = infoColor;
        statusIcon = Icons.send;
        break;
      case "draft":
        statusColor = disabledBoldColor;
        statusIcon = Icons.edit;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                  children: [
                    Text(
                      "${invoice["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${invoice["client"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${invoice["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${invoice["description"]}",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(invoice["amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Due Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(invoice["dueDate"]).dMMMy}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showInvoiceActions(invoice);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateInvoiceForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Create New Invoice",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  showCreateInvoice = false;
                  _clearForm();
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Invoice Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QTextField(
                  label: "Client Name",
                  value: clientName,
                  hint: "Enter client name",
                  onChanged: (value) {
                    clientName = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Description",
                  value: invoiceDescription,
                  hint: "Describe the services or products",
                  onChanged: (value) {
                    invoiceDescription = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Amount (\$)",
                  value: invoiceAmount,
                  onChanged: (value) {
                    invoiceAmount = value;
                    setState(() {});
                  },
                ),
                QDatePicker(
                  label: "Due Date",
                  value: DateTime.parse(selectedDueDate),
                  onChanged: (value) {
                    selectedDueDate = value.toString();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "The invoice will be automatically assigned an ID and sent to the client's email address.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  color: disabledBoldColor,
                  onPressed: _canCreateInvoice() ? () {
                    _createInvoice("draft");
                  } : null,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Send Invoice",
                  onPressed: _canCreateInvoice() ? () {
                    _createInvoice("sent");
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _canCreateInvoice() {
    return clientName.isNotEmpty && 
           invoiceDescription.isNotEmpty && 
           invoiceAmount.isNotEmpty;
  }

  void _createInvoice(String status) {
    showLoading();
    
    // Simulate invoice creation
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      
      String newId = "INV-2024-${(invoices.length + 1).toString().padLeft(3, '0')}";
      
      invoices.insert(0, {
        "id": newId,
        "client": clientName,
        "amount": double.tryParse(invoiceAmount) ?? 0.0,
        "date": DateTime.now().toString(),
        "dueDate": selectedDueDate,
        "status": status,
        "description": invoiceDescription
      });
      
      showCreateInvoice = false;
      _clearForm();
      
      if (status == "sent") {
        ss("Invoice sent successfully!");
      } else {
        ss("Invoice saved as draft!");
      }
      
      setState(() {});
    });
  }

  void _clearForm() {
    clientName = "";
    invoiceDescription = "";
    invoiceAmount = "";
    selectedDueDate = DateTime.now().add(Duration(days: 30)).toString();
  }

  void _showInvoiceActions(Map<String, dynamic> invoice) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Invoice Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(
                "View Details",
                Icons.visibility,
                () {
                  Navigator.pop(context);
                  si("View invoice details");
                },
              ),
              _buildActionItem(
                "Send Reminder",
                Icons.email,
                invoice["status"] == "pending" || invoice["status"] == "overdue" ? () {
                  Navigator.pop(context);
                  _sendReminder(invoice);
                } : null,
              ),
              _buildActionItem(
                "Mark as Paid",
                Icons.check_circle,
                invoice["status"] != "paid" ? () {
                  Navigator.pop(context);
                  _markAsPaid(invoice);
                } : null,
              ),
              _buildActionItem(
                "Download PDF",
                Icons.download,
                () {
                  Navigator.pop(context);
                  si("Downloading PDF...");
                },
              ),
              _buildActionItem(
                "Delete Invoice",
                Icons.delete,
                () {
                  Navigator.pop(context);
                  _deleteInvoice(invoice);
                },
                color: dangerColor,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback? onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? (onTap != null ? primaryColor : disabledBoldColor),
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                color: color ?? (onTap != null ? Colors.black : disabledBoldColor),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendReminder(Map<String, dynamic> invoice) {
    ss("Reminder sent to ${invoice["client"]}");
  }

  void _markAsPaid(Map<String, dynamic> invoice) {
    int index = invoices.indexWhere((inv) => inv["id"] == invoice["id"]);
    if (index != -1) {
      invoices[index]["status"] = "paid";
      ss("Invoice marked as paid!");
      setState(() {});
    }
  }

  void _deleteInvoice(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this invoice?");
    if (isConfirmed) {
      invoices.removeWhere((inv) => inv["id"] == invoice["id"]);
      ss("Invoice deleted successfully!");
      setState(() {});
    }
  }
}
