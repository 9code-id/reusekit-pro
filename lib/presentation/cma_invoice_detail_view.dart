import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaInvoiceDetailView extends StatefulWidget {
  const CmaInvoiceDetailView({super.key});

  @override
  State<CmaInvoiceDetailView> createState() => _CmaInvoiceDetailViewState();
}

class _CmaInvoiceDetailViewState extends State<CmaInvoiceDetailView> {
  Map<String, dynamic> invoice = {
    "id": "INV-2024-001",
    "customerName": "Acme Corporation",
    "customerEmail": "billing@acmecorp.com",
    "customerPhone": "+1 (555) 123-4567",
    "customerAddress": "123 Business Ave\nSuite 100\nNew York, NY 10001",
    "amount": 2500.00,
    "dueDate": "2024-07-15",
    "issueDate": "2024-06-15",
    "status": "Sent",
    "paymentTerms": "Net 30",
    "notes": "Thank you for your business. Payment is due within 30 days.",
    "items": [
      {
        "description": "Website Development",
        "quantity": 1,
        "unitPrice": 1500.00,
        "total": 1500.00,
      },
      {
        "description": "SEO Optimization",
        "quantity": 3,
        "unitPrice": 200.00,
        "total": 600.00,
      },
      {
        "description": "Hosting Setup",
        "quantity": 1,
        "unitPrice": 400.00,
        "total": 400.00,
      },
    ],
    "subtotal": 2500.00,
    "tax": 0.00,
    "discount": 0.00,
    "total": 2500.00,
  };

  List<Map<String, dynamic>> paymentHistory = [
    {
      "date": "2024-06-20",
      "amount": 500.00,
      "method": "Bank Transfer",
      "status": "Completed",
      "reference": "TXN-20240620-001",
    },
    {
      "date": "2024-06-25",
      "amount": 1000.00,
      "method": "Credit Card",
      "status": "Completed",
      "reference": "TXN-20240625-002",
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "date": "2024-06-15",
      "action": "Invoice Created",
      "description": "Invoice INV-2024-001 was created",
      "user": "Admin User",
    },
    {
      "date": "2024-06-15",
      "action": "Invoice Sent",
      "description": "Invoice sent to billing@acmecorp.com",
      "user": "System",
    },
    {
      "date": "2024-06-20",
      "action": "Payment Received",
      "description": "Partial payment of \$500.00 received",
      "user": "System",
    },
    {
      "date": "2024-06-25",
      "action": "Payment Received",
      "description": "Payment of \$1,000.00 received",
      "user": "System",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Sent":
        return infoColor;
      case "Overdue":
        return dangerColor;
      case "Draft":
        return warningColor;
      case "Cancelled":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Qty: ${item["quantity"]} × \$${(item["unitPrice"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              "\$${(item["total"] as double).currency}",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> payment) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.payment,
              color: successColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${(payment["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${payment["method"]} • ${payment["date"]}",
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
              color: successColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${payment["status"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["action"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["date"]} • ${activity["user"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showActionMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              "Invoice Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Column(
              spacing: spSm,
              children: [
                _buildActionTile(
                  icon: Icons.edit,
                  label: "Edit Invoice",
                  onTap: () {
                    back();
                    ss("Edit invoice functionality");
                  },
                ),
                _buildActionTile(
                  icon: Icons.send,
                  label: "Send Invoice",
                  onTap: () {
                    back();
                    ss("Invoice sent successfully");
                  },
                ),
                _buildActionTile(
                  icon: Icons.download,
                  label: "Download PDF",
                  onTap: () {
                    back();
                    ss("Invoice downloaded");
                  },
                ),
                _buildActionTile(
                  icon: Icons.print,
                  label: "Print Invoice",
                  onTap: () {
                    back();
                    ss("Invoice printed");
                  },
                ),
                _buildActionTile(
                  icon: Icons.payment,
                  label: "Record Payment",
                  onTap: () {
                    back();
                    _showRecordPaymentDialog();
                  },
                ),
                _buildActionTile(
                  icon: Icons.copy,
                  label: "Duplicate Invoice",
                  onTap: () {
                    back();
                    ss("Invoice duplicated");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(13),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color ?? primaryColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordPaymentDialog() {
    String paymentAmount = "";
    String paymentMethod = "Bank Transfer";
    DateTime paymentDate = DateTime.now();
    String paymentReference = "";

    List<Map<String, dynamic>> paymentMethods = [
      {"label": "Bank Transfer", "value": "Bank Transfer"},
      {"label": "Credit Card", "value": "Credit Card"},
      {"label": "Cash", "value": "Cash"},
      {"label": "Check", "value": "Check"},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Record Payment"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QNumberField(
                label: "Payment Amount (\$)",
                value: paymentAmount,
                validator: Validator.required,
                onChanged: (value) {
                  paymentAmount = value;
                },
              ),
              QDropdownField(
                label: "Payment Method",
                items: paymentMethods,
                value: paymentMethod,
                onChanged: (value, label) {
                  paymentMethod = value;
                },
              ),
              QDatePicker(
                label: "Payment Date",
                value: paymentDate,
                onChanged: (value) {
                  paymentDate = value;
                },
              ),
              QTextField(
                label: "Reference Number",
                value: paymentReference,
                hint: "Optional reference number",
                onChanged: (value) {
                  paymentReference = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (paymentAmount.isNotEmpty) {
                back();
                ss("Payment recorded successfully");
              }
            },
            child: Text("Record Payment"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${invoice["id"]}"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showActionMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Invoice Header
            _buildInfoCard(
              "Invoice Details",
              [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${invoice["id"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Issue Date: ${invoice["issueDate"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Due Date: ${invoice["dueDate"]}",
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
                        color: _getStatusColor("${invoice["status"]}").withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${invoice["status"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${invoice["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$${(invoice["total"] as double).currency}",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Customer Information
            _buildInfoCard(
              "Customer Information",
              [
                Text(
                  "${invoice["customerName"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${invoice["customerEmail"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${invoice["customerPhone"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${invoice["customerAddress"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Invoice Items
            _buildInfoCard(
              "Invoice Items",
              [
                ...(invoice["items"] as List).map((item) => _buildInvoiceItem(item)),
                Divider(),
                Row(
                  children: [
                    Expanded(child: Text("Subtotal:", style: TextStyle(color: disabledBoldColor))),
                    Text(
                      "\$${(invoice["subtotal"] as double).currency}",
                      style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
                    ),
                  ],
                ),
                if ((invoice["discount"] as double) > 0)
                  Row(
                    children: [
                      Expanded(child: Text("Discount:", style: TextStyle(color: disabledBoldColor))),
                      Text(
                        "-\$${(invoice["discount"] as double).currency}",
                        style: TextStyle(fontWeight: FontWeight.w600, color: dangerColor),
                      ),
                    ],
                  ),
                if ((invoice["tax"] as double) > 0)
                  Row(
                    children: [
                      Expanded(child: Text("Tax:", style: TextStyle(color: disabledBoldColor))),
                      Text(
                        "\$${(invoice["tax"] as double).currency}",
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                    ],
                  ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "\$${(invoice["total"] as double).currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Payment History
            if (paymentHistory.isNotEmpty)
              _buildInfoCard(
                "Payment History",
                [
                  ...paymentHistory.map((payment) => _buildPaymentItem(payment)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Paid:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${paymentHistory.fold(0.0, (sum, payment) => sum + (payment["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            // Activity Timeline
            _buildInfoCard(
              "Activity Timeline",
              activities.map((activity) => _buildActivityItem(activity)).toList(),
            ),

            // Notes
            if (invoice["notes"] != null && "${invoice["notes"]}".isNotEmpty)
              _buildInfoCard(
                "Notes",
                [
                  Text(
                    "${invoice["notes"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Invoice",
                    size: bs.md,
                    onPressed: () {
                      ss("Invoice sent successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Record Payment",
                    size: bs.md,
                    onPressed: _showRecordPaymentDialog,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
