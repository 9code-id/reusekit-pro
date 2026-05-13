import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPaymentRemindersView extends StatefulWidget {
  const AbaPaymentRemindersView({super.key});

  @override
  State<AbaPaymentRemindersView> createState() => _AbaPaymentRemindersViewState();
}

class _AbaPaymentRemindersViewState extends State<AbaPaymentRemindersView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedUrgency = "All";
  bool loading = false;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Acknowledged", "value": "Acknowledged"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Invoice", "value": "Invoice"},
    {"label": "Subscription", "value": "Subscription"},
    {"label": "Overdue Payment", "value": "Overdue"},
    {"label": "Final Notice", "value": "Final"},
  ];

  List<Map<String, dynamic>> urgencyItems = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> reminders = [
    {
      "id": "REM001",
      "customer_name": "ABC Company Ltd",
      "customer_email": "billing@abccompany.com",
      "amount": 2450.00,
      "type": "Invoice",
      "invoice_number": "INV-2024-001",
      "due_date": "2024-01-20",
      "days_overdue": 5,
      "status": "Overdue",
      "urgency": "High",
      "last_sent": "2024-01-18",
      "attempts": 3,
      "next_reminder": "2024-01-22",
    },
    {
      "id": "REM002",
      "customer_name": "Tech Solutions Inc",
      "customer_email": "accounts@techsolutions.com",
      "amount": 890.50,
      "type": "Subscription",
      "invoice_number": "SUB-2024-045",
      "due_date": "2024-01-25",
      "days_overdue": 0,
      "status": "Pending",
      "urgency": "Medium",
      "last_sent": null,
      "attempts": 0,
      "next_reminder": "2024-01-23",
    },
    {
      "id": "REM003",
      "customer_name": "Global Enterprises",
      "customer_email": "finance@globalent.com",
      "amount": 5200.00,
      "type": "Final",
      "invoice_number": "INV-2024-089",
      "due_date": "2024-01-15",
      "days_overdue": 10,
      "status": "Sent",
      "urgency": "Critical",
      "last_sent": "2024-01-19",
      "attempts": 5,
      "next_reminder": "2024-01-21",
    },
    {
      "id": "REM004",
      "customer_name": "StartUp Hub",
      "customer_email": "billing@startuphub.com",
      "amount": 150.00,
      "type": "Invoice",
      "invoice_number": "INV-2024-156",
      "due_date": "2024-01-28",
      "days_overdue": 0,
      "status": "Acknowledged",
      "urgency": "Low",
      "last_sent": "2024-01-16",
      "attempts": 1,
      "next_reminder": "2024-01-26",
    },
    {
      "id": "REM005",
      "customer_name": "Marketing Pro",
      "customer_email": "admin@marketingpro.com",
      "amount": 750.00,
      "type": "Overdue",
      "invoice_number": "INV-2024-203",
      "due_date": "2024-01-12",
      "days_overdue": 13,
      "status": "Paid",
      "urgency": "Low",
      "last_sent": "2024-01-20",
      "attempts": 2,
      "next_reminder": null,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Sent":
        return infoColor;
      case "Acknowledged":
        return secondaryColor;
      case "Paid":
        return successColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reminder Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Total Reminders", "247", primaryColor),
              ),
              Expanded(
                child: _buildSummaryItem("Pending", "45", warningColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Overdue", "18", dangerColor),
              ),
              Expanded(
                child: _buildSummaryItem("Amount Due", "\$89,450", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
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
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Reminders",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search reminders...",
            value: searchQuery,
            hint: "Customer name, invoice number, or email",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
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
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Urgency",
            items: urgencyItems,
            value: selectedUrgency,
            onChanged: (value, label) {
              selectedUrgency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getUrgencyColor(reminder["urgency"]),
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
                      "${reminder["customer_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${reminder["invoice_number"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(reminder["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(reminder["status"]).withAlpha(100),
                  ),
                ),
                child: Text(
                  "${reminder["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(reminder["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
                      "\$${(reminder["amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
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
                      "${reminder["due_date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: (reminder["days_overdue"] as int) > 0 ? dangerColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getUrgencyColor(reminder["urgency"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${reminder["urgency"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getUrgencyColor(reminder["urgency"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          if ((reminder["days_overdue"] as int) > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${reminder["days_overdue"]} days overdue",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.send,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Attempts: ${reminder["attempts"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (reminder["next_reminder"] != null)
                Text(
                  "Next: ${reminder["next_reminder"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Send Reminder",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Invoice",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Reminders"),
        actions: [
          QButton(
            icon: Icons.schedule_send,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(),
                  SizedBox(height: spMd),
                  _buildFilterSection(),
                  SizedBox(height: spMd),
                  Text(
                    "Payment Reminders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...reminders.map((reminder) => _buildReminderCard(reminder)).toList(),
                ],
              ),
            ),
    );
  }
}
