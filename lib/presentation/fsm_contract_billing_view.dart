import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmContractBillingView extends StatefulWidget {
  const FsmContractBillingView({super.key});

  @override
  State<FsmContractBillingView> createState() => _FsmContractBillingViewState();
}

class _FsmContractBillingViewState extends State<FsmContractBillingView> {
  String selectedContract = "CNT-001";
  String billingType = "Fixed Rate";
  String billingFrequency = "Monthly";
  bool autoInvoicing = true;
  bool sendReminders = true;
  int reminderDays = 7;
  String contractStatus = "Active";

  List<Map<String, dynamic>> contracts = [
    {
      "id": "CNT-001",
      "client": "ABC Corporation",
      "type": "Maintenance",
      "value": 50000.00,
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "status": "Active",
      "billingType": "Fixed Rate",
      "frequency": "Monthly",
      "nextBilling": "2024-02-01",
      "totalBilled": 8333.33,
      "remainingValue": 41666.67,
    },
    {
      "id": "CNT-002",
      "client": "XYZ Industries",
      "type": "Support",
      "value": 120000.00,
      "startDate": "2023-06-01",
      "endDate": "2025-05-31",
      "status": "Active",
      "billingType": "Milestone",
      "frequency": "Per Milestone",
      "nextBilling": "2024-03-15",
      "totalBilled": 60000.00,
      "remainingValue": 60000.00,
    },
    {
      "id": "CNT-003",
      "client": "Tech Solutions",
      "type": "Development",
      "value": 75000.00,
      "startDate": "2024-01-15",
      "endDate": "2024-06-15",
      "status": "Active",
      "billingType": "Hourly Rate",
      "frequency": "Bi-weekly",
      "nextBilling": "2024-02-01",
      "totalBilled": 12500.00,
      "remainingValue": 62500.00,
    },
  ];

  List<Map<String, dynamic>> billingHistory = [
    {
      "invoiceId": "INV-2024-001",
      "contractId": "CNT-001",
      "amount": 4166.67,
      "billDate": "2024-01-01",
      "dueDate": "2024-01-31",
      "paidDate": "2024-01-28",
      "status": "Paid",
      "description": "January 2024 - Maintenance Services",
    },
    {
      "invoiceId": "INV-2024-002",
      "contractId": "CNT-002",
      "amount": 20000.00,
      "billDate": "2024-01-15",
      "dueDate": "2024-02-15",
      "paidDate": null,
      "status": "Pending",
      "description": "Milestone 3 - System Integration",
    },
    {
      "invoiceId": "INV-2024-003",
      "contractId": "CNT-003",
      "amount": 6250.00,
      "billDate": "2024-01-15",
      "dueDate": "2024-02-01",
      "paidDate": "2024-01-30",
      "status": "Paid",
      "description": "Bi-weekly Development - 125 hours",
    },
    {
      "invoiceId": "INV-2024-004",
      "contractId": "CNT-001",
      "amount": 4166.66,
      "billDate": "2024-02-01",
      "dueDate": "2024-03-01",
      "paidDate": null,
      "status": "Overdue",
      "description": "February 2024 - Maintenance Services",
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "id": "MS-001",
      "contractId": "CNT-002",
      "name": "Requirements Analysis",
      "amount": 20000.00,
      "dueDate": "2024-01-15",
      "status": "Completed",
      "billingStatus": "Billed",
    },
    {
      "id": "MS-002",
      "contractId": "CNT-002",
      "name": "System Design",
      "amount": 25000.00,
      "dueDate": "2024-02-15",
      "status": "Completed",
      "billingStatus": "Billed",
    },
    {
      "id": "MS-003",
      "contractId": "CNT-002",
      "name": "Development Phase 1",
      "amount": 35000.00,
      "dueDate": "2024-03-15",
      "status": "In Progress",
      "billingStatus": "Pending",
    },
    {
      "id": "MS-004",
      "contractId": "CNT-002",
      "name": "Testing & Deployment",
      "amount": 40000.00,
      "dueDate": "2024-04-30",
      "status": "Not Started",
      "billingStatus": "Not Due",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contract Billing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new contract
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Billing settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildContractOverview(),
            _buildBillingSettings(),
            _buildMilestones(),
            _buildBillingHistory(),
            _buildBillingActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildContractOverview() {
    final contract = contracts.firstWhere((c) => c["id"] == selectedContract);
    
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
            "Contract Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Contract",
            items: contracts.map((c) => {
              "label": "${c["id"]} - ${c["client"]}",
              "value": c["id"],
            }).toList(),
            value: selectedContract,
            onChanged: (value, label) {
              selectedContract = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildContractDetailRow("Client:", "${contract["client"]}"),
                _buildContractDetailRow("Contract Type:", "${contract["type"]}"),
                _buildContractDetailRow("Total Value:", "\$${((contract["value"] as num).toDouble()).currency}"),
                _buildContractDetailRow("Billing Type:", "${contract["billingType"]}"),
                _buildContractDetailRow("Frequency:", "${contract["frequency"]}"),
                _buildContractDetailRow("Next Billing:", "${contract["nextBilling"]}"),
                _buildContractDetailRow("Total Billed:", "\$${((contract["totalBilled"] as num).toDouble()).currency}"),
                _buildContractDetailRow("Remaining:", "\$${((contract["remainingValue"] as num).toDouble()).currency}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBillingSettings() {
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
            "Billing Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Auto Invoicing",
                "value": true,
                "checked": autoInvoicing,
              }
            ],
            value: [
              if (autoInvoicing)
                {
                  "label": "Auto Invoicing",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                autoInvoicing = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Send Payment Reminders",
                "value": true,
                "checked": sendReminders,
              }
            ],
            value: [
              if (sendReminders)
                {
                  "label": "Send Payment Reminders",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                sendReminders = values.isNotEmpty;
              });
            },
          ),
          if (sendReminders) ...[
            QNumberField(
              label: "Reminder Days Before Due",
              value: reminderDays.toString(),
              onChanged: (value) {
                reminderDays = int.tryParse(value) ?? 7;
                setState(() {});
              },
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Settings",
                  size: bs.sm,
                  onPressed: _saveBillingSettings,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Invoice",
                  size: bs.sm,
                  onPressed: _generateInvoice,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestones() {
    final contractMilestones = milestones.where((m) => m["contractId"] == selectedContract).toList();
    
    if (contractMilestones.isEmpty) return SizedBox();

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
            "Contract Milestones",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...contractMilestones.map((milestone) => _buildMilestoneItem(milestone)),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(Map<String, dynamic> milestone) {
    Color statusColor;
    Color billingColor;
    
    switch (milestone["status"]) {
      case "Completed":
        statusColor = successColor;
        break;
      case "In Progress":
        statusColor = warningColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }

    switch (milestone["billingStatus"]) {
      case "Billed":
        billingColor = successColor;
        break;
      case "Pending":
        billingColor = warningColor;
        break;
      default:
        billingColor = disabledBoldColor;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.flag,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${milestone["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Due: ${milestone["dueDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${milestone["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: billingColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${milestone["billingStatus"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "\$${((milestone["amount"] as num).toDouble()).currency}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingHistory() {
    final contractHistory = billingHistory.where((h) => h["contractId"] == selectedContract).toList();

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Billing History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View all billing history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...contractHistory.take(4).map((invoice) => _buildInvoiceItem(invoice)),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(Map<String, dynamic> invoice) {
    Color statusColor;
    IconData statusIcon;
    
    switch (invoice["status"]) {
      case "Paid":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Pending":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      case "Overdue":
        statusColor = dangerColor;
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.receipt;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${invoice["invoiceId"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${invoice["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((invoice["amount"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${invoice["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingActions() {
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
            children: [
              Expanded(
                child: QButton(
                  label: "Create Invoice",
                  size: bs.sm,
                  onPressed: _createInvoice,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Send Reminder",
                  size: bs.sm,
                  onPressed: _sendReminder,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Contract",
                  size: bs.sm,
                  onPressed: _viewContract,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Payment Report",
                  size: bs.sm,
                  onPressed: _generateReport,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveBillingSettings() {
    ss("Billing settings saved successfully!");
  }

  void _generateInvoice() {
    ss("Invoice generated successfully!");
  }

  void _createInvoice() {
    ss("New invoice created!");
  }

  void _sendReminder() {
    si("Payment reminder sent!");
  }

  void _viewContract() {
    // Navigate to contract details
  }

  void _generateReport() {
    // Generate payment report
  }
}
