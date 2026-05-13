import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmInvoicingView extends StatefulWidget {
  const FsmInvoicingView({super.key});

  @override
  State<FsmInvoicingView> createState() => _FsmInvoicingViewState();
}

class _FsmInvoicingViewState extends State<FsmInvoicingView> {
  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "jobId": "JOB-001",
      "clientName": "Acme Manufacturing Corp",
      "clientEmail": "billing@acme-mfg.com",
      "serviceDate": "2024-06-15",
      "issueDate": "2024-06-16",
      "dueDate": "2024-07-16",
      "amount": 2850.0,
      "tax": 285.0,
      "total": 3135.0,
      "status": "Sent",
      "paymentStatus": "Pending",
      "technician": "John Smith",
      "serviceType": "Preventive Maintenance",
      "equipmentServiced": "Industrial Generator Model X200",
      "workDescription": "Quarterly oil change, filter replacement, and system inspection",
      "laborHours": 4.5,
      "laborRate": 125.0,
      "materialsCost": 287.50,
      "travelCost": 45.0,
      "lastPaymentReminder": "2024-06-20",
      "reminderCount": 1
    },
    {
      "id": "INV-2024-002",
      "jobId": "JOB-002",
      "clientName": "TechFlow Solutions",
      "clientEmail": "accounts@techflow.com",
      "serviceDate": "2024-06-12",
      "issueDate": "2024-06-13",
      "dueDate": "2024-07-13",
      "amount": 4200.0,
      "tax": 420.0,
      "total": 4620.0,
      "status": "Paid",
      "paymentStatus": "Paid",
      "technician": "Sarah Johnson",
      "serviceType": "Emergency Repair",
      "equipmentServiced": "HVAC System Pro Series 500",
      "workDescription": "Emergency compressor replacement and system rebalancing",
      "laborHours": 6.0,
      "laborRate": 150.0,
      "materialsCost": 3300.0,
      "travelCost": 0.0,
      "lastPaymentReminder": null,
      "reminderCount": 0
    },
    {
      "id": "INV-2024-003",
      "jobId": "JOB-003",
      "clientName": "SafeGuard Industries",
      "clientEmail": "finance@safeguard.com",
      "serviceDate": "2024-06-10",
      "issueDate": "2024-06-11",
      "dueDate": "2024-07-11",
      "amount": 750.0,
      "tax": 75.0,
      "total": 825.0,
      "status": "Sent",
      "paymentStatus": "Overdue",
      "technician": "Mike Wilson",
      "serviceType": "Inspection",
      "equipmentServiced": "Fire Safety System v3.1",
      "workDescription": "Monthly safety system inspection and sensor calibration",
      "laborHours": 2.0,
      "laborRate": 125.0,
      "materialsCost": 500.0,
      "travelCost": 0.0,
      "lastPaymentReminder": "2024-06-18",
      "reminderCount": 2
    },
    {
      "id": "INV-2024-004",
      "jobId": "JOB-004",
      "clientName": "ProMotion Systems",
      "clientEmail": "billing@promotion.com",
      "serviceDate": "2024-06-08",
      "issueDate": "2024-06-09",
      "dueDate": "2024-07-09",
      "amount": 1650.0,
      "tax": 165.0,
      "total": 1815.0,
      "status": "Draft",
      "paymentStatus": "Not Sent",
      "technician": "David Brown",
      "serviceType": "Corrective Maintenance",
      "equipmentServiced": "Conveyor Belt System MK4",
      "workDescription": "Belt tension adjustment and motor alignment",
      "laborHours": 8.0,
      "laborRate": 125.0,
      "materialsCost": 650.0,
      "travelCost": 0.0,
      "lastPaymentReminder": null,
      "reminderCount": 0
    },
    {
      "id": "INV-2024-005",
      "jobId": "JOB-005",
      "clientName": "Vista Security Corp",
      "clientEmail": "ap@vistasecurity.com",
      "serviceDate": "2024-06-05",
      "issueDate": "2024-06-06",
      "dueDate": "2024-07-06",
      "amount": 890.0,
      "tax": 89.0,
      "total": 979.0,
      "status": "Sent",
      "paymentStatus": "Partial",
      "technician": "Lisa Chen",
      "serviceType": "Software Update",
      "equipmentServiced": "Security Camera Network HD",
      "workDescription": "Firmware update and analytics configuration for 12 cameras",
      "laborHours": 3.0,
      "laborRate": 125.0,
      "materialsCost": 515.0,
      "travelCost": 0.0,
      "lastPaymentReminder": "2024-06-15",
      "reminderCount": 1
    }
  ];

  List<Map<String, dynamic>> filteredInvoices = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPaymentStatus = "All";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> paymentStatusItems = [
    {"label": "All", "value": "All"},
    {"label": "Not Sent", "value": "Not Sent"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Partial", "value": "Partial"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  @override
  void initState() {
    super.initState();
    filteredInvoices = invoices;
  }

  void _filterInvoices() {
    filteredInvoices = invoices.where((invoice) {
      bool matchesSearch = invoice["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          invoice["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          invoice["technician"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || invoice["status"] == selectedStatus;
      bool matchesPaymentStatus = selectedPaymentStatus == "All" || invoice["paymentStatus"] == selectedPaymentStatus;
      
      return matchesSearch && matchesStatus && matchesPaymentStatus;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft":
        return disabledColor;
      case "Sent":
        return infoColor;
      case "Paid":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPaymentStatusColor(String paymentStatus) {
    switch (paymentStatus) {
      case "Not Sent":
        return disabledColor;
      case "Pending":
        return warningColor;
      case "Partial":
        return infoColor;
      case "Paid":
        return successColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    double total = invoice["total"] as double;
    String paymentStatus = invoice["paymentStatus"];
    bool isOverdue = paymentStatus == "Overdue";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPaymentStatusColor(paymentStatus),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${invoice["clientName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${total.currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPaymentStatusColor(paymentStatus).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      paymentStatus,
                      style: TextStyle(
                        fontSize: 10,
                        color: _getPaymentStatusColor(paymentStatus),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.build,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${invoice["serviceType"]} - ${invoice["equipmentServiced"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${invoice["workDescription"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Service Date", "${invoice["serviceDate"]}", Icons.calendar_today),
              ),
              Expanded(
                child: _buildInfoItem("Due Date", "${invoice["dueDate"]}", Icons.event),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Technician", "${invoice["technician"]}", Icons.person),
              ),
              Expanded(
                child: _buildInfoItem("Status", "${invoice["status"]}", Icons.info),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildAmountItem("Labor", (invoice["laborHours"] as double) * (invoice["laborRate"] as double)),
                    ),
                    Expanded(
                      child: _buildAmountItem("Materials", invoice["materialsCost"] as double),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: _buildAmountItem("Travel", invoice["travelCost"] as double),
                    ),
                    Expanded(
                      child: _buildAmountItem("Tax", invoice["tax"] as double),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: successColor.withAlpha(50),
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "\$${total.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isOverdue) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "OVERDUE - ${invoice["reminderCount"]} reminders sent",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View PDF",
                  size: bs.sm,
                  onPressed: () {
                    // View invoice PDF
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (invoice["status"] == "Draft") ...[
                Expanded(
                  child: QButton(
                    label: "Send Invoice",
                    size: bs.sm,
                    onPressed: () {
                      // Send invoice
                    },
                  ),
                ),
              ] else if (paymentStatus == "Pending" || paymentStatus == "Overdue") ...[
                Expanded(
                  child: QButton(
                    label: "Send Reminder",
                    size: bs.sm,
                    onPressed: () {
                      // Send payment reminder
                    },
                  ),
                ),
              ] else if (paymentStatus == "Partial") ...[
                Expanded(
                  child: QButton(
                    label: "Record Payment",
                    size: bs.sm,
                    onPressed: () {
                      // Record payment
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Edit Invoice",
                    size: bs.sm,
                    onPressed: () {
                      // Edit invoice
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountItem(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 12,
            color: successColor,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    int totalInvoices = invoices.length;
    double totalAmount = invoices.fold(0.0, (sum, inv) => sum + (inv["total"] as double));
    int overdueInvoices = invoices.where((inv) => inv["paymentStatus"] == "Overdue").length;
    int paidInvoices = invoices.where((inv) => inv["paymentStatus"] == "Paid").length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Invoices", "$totalInvoices", Icons.receipt, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Total Amount", "\$${totalAmount.currency}", Icons.attach_money, successColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Paid", "$paidInvoices", Icons.check_circle, successColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Overdue", "$overdueInvoices", Icons.warning, dangerColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoicing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create invoice
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to invoice analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Invoices",
                    value: searchQuery,
                    hint: "Search by client, invoice ID, or technician...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterInvoices();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      _filterInvoices();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Payment Status",
                    items: paymentStatusItems,
                    value: selectedPaymentStatus,
                    onChanged: (value, label) {
                      selectedPaymentStatus = value;
                      _filterInvoices();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invoices (${filteredInvoices.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Export All",
                  size: bs.sm,
                  onPressed: () {
                    // Export invoices
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),
            ...filteredInvoices.map((invoice) => _buildInvoiceCard(invoice)).toList(),
          ],
        ),
      ),
    );
  }
}
