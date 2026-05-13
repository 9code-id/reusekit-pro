import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice8View extends StatefulWidget {
  @override
  State<GrlInvoice8View> createState() => _GrlInvoice8ViewState();
}

class _GrlInvoice8ViewState extends State<GrlInvoice8View> {
  int currentTab = 0;

  Map<String, dynamic> invoiceData = {
    "number": "INV-2024-001",
    "client": "TechStart Inc.",
    "amount": 4250.0,
    "dueDate": "2024-02-15",
    "status": "Sent",
    "sentDate": "2024-01-15",
  };

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": "1",
      "name": "Invoice Reminder",
      "subject": "Payment Reminder - Invoice #{invoice_number}",
      "body": "Dear {client_name},\n\nThis is a friendly reminder that your invoice {invoice_number} for \${amount} is due on {due_date}.\n\nPlease process the payment at your earliest convenience.\n\nThank you for your business!\n\nBest regards,\n{company_name}",
      "isDefault": true,
    },
    {
      "id": "2",
      "name": "Overdue Notice",
      "subject": "Overdue Payment - Invoice #{invoice_number}",
      "body": "Dear {client_name},\n\nYour invoice {invoice_number} for \${amount} was due on {due_date} and is now overdue.\n\nPlease settle this payment immediately to avoid any late fees.\n\nIf you have already made the payment, please disregard this notice.\n\nBest regards,\n{company_name}",
      "isDefault": false,
    },
    {
      "id": "3",
      "name": "Thank You",
      "subject": "Payment Received - Invoice #{invoice_number}",
      "body": "Dear {client_name},\n\nThank you for your payment of \${amount} for invoice {invoice_number}.\n\nYour payment has been received and processed successfully.\n\nWe appreciate your business and look forward to working with you again.\n\nBest regards,\n{company_name}",
      "isDefault": false,
    },
  ];

  String selectedTemplate = "1";
  String customSubject = "";
  String customMessage = "";
  bool scheduleEmail = false;
  DateTime scheduledDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay scheduledTime = TimeOfDay(hour: 9, minute: 0);

  List<Map<String, dynamic>> deliveryHistory = [
    {
      "type": "email",
      "recipient": "contact@techstart.com",
      "subject": "Invoice INV-2024-001",
      "sentDate": "2024-01-15 10:30:00",
      "status": "Delivered",
      "opens": 3,
      "clicks": 1,
    },
    {
      "type": "reminder",
      "recipient": "contact@techstart.com",
      "subject": "Payment Reminder - Invoice INV-2024-001",
      "sentDate": "2024-01-25 09:00:00",
      "status": "Opened",
      "opens": 1,
      "clicks": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Send Invoice",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Send", icon: Icon(Icons.send)),
        Tab(text: "Templates", icon: Icon(Icons.edit_note)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildSendTab(),
        _buildTemplatesTab(),
        _buildHistoryTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildSendTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          _buildInvoicePreview(),
          _buildEmailComposer(),
          _buildDeliveryOptions(),
          _buildSendActions(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          _buildTemplatesList(),
          _buildTemplateEditor(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          _buildDeliveryStats(),
          _buildDeliveryHistory(),
        ],
      ),
    );
  }

  Widget _buildInvoicePreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Invoice Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Invoice: ${invoiceData["number"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${invoiceData["status"]}",
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Client: ${invoiceData["client"]}"),
                    Text(
                      "\$${(invoiceData["amount"] as double).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Due Date: ${invoiceData["dueDate"]}"),
                    Text("Sent: ${invoiceData["sentDate"]}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailComposer() {
    Map<String, dynamic> template = emailTemplates.firstWhere(
      (t) => t["id"] == selectedTemplate,
      orElse: () => emailTemplates.first,
    );

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.email,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Email Composer",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Email Template",
            items: emailTemplates.map((template) => {
              "label": template["name"],
              "value": template["id"],
            }).toList(),
            value: selectedTemplate,
            onChanged: (value, label) {
              selectedTemplate = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Subject",
            value: customSubject.isEmpty ? template["subject"] : customSubject,
            onChanged: (value) {
              customSubject = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Message",
            value: customMessage.isEmpty ? template["body"] : customMessage,
            onChanged: (value) {
              customMessage = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Available Variables:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "{client_name}, {invoice_number}, {amount}, {due_date}, {company_name}",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Delivery Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Schedule Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Switch(
                value: scheduleEmail,
                onChanged: (value) {
                  scheduleEmail = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
            ],
          ),
          if (scheduleEmail) ...[
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Schedule Date",
                    value: scheduledDate,
                    onChanged: (value) {
                      scheduledDate = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QTimePicker(
                    label: "Schedule Time",
                    value: scheduledTime,
                    onChanged: (value) {
                      scheduledTime = value!;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSendActions() {
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
                child: QButton(
                  label: "Preview Email",
                  size: bs.md,
                  icon: Icons.preview,
                  onPressed: _previewEmail,
                ),
              ),
              Expanded(
                child: QButton(
                  label: scheduleEmail ? "Schedule Send" : "Send Now",
                  size: bs.md,
                  icon: scheduleEmail ? Icons.schedule_send : Icons.send,
                  onPressed: _sendInvoice,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Send SMS",
                  size: bs.md,
                  icon: Icons.sms,
                  onPressed: _sendSMS,
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Print & Mail",
                  size: bs.md,
                  icon: Icons.print,
                  onPressed: _printAndMail,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "New Template",
                  size: bs.sm,
                  icon: Icons.add,
                  onPressed: _createTemplate,
                ),
              ],
            ),
          ),
          ...List.generate(emailTemplates.length, (index) {
            final template = emailTemplates[index];
            final isLast = index == emailTemplates.length - 1;
            
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
                  Icon(
                    template["isDefault"] ? Icons.star : Icons.edit_note,
                    color: template["isDefault"] ? warningColor : primaryColor,
                    size: 24,
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
                              "${template["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            if (template["isDefault"])
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Default",
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          "${template["subject"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: spXs,
                    children: [
                      GestureDetector(
                        onTap: () => _editTemplate(template),
                        child: Icon(
                          Icons.edit,
                          color: successColor,
                          size: 20,
                        ),
                      ),
                      if (!template["isDefault"])
                        GestureDetector(
                          onTap: () => _deleteTemplate(template),
                          child: Icon(
                            Icons.delete,
                            color: dangerColor,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTemplateEditor() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Template Editor",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Template Name",
            value: "",
            onChanged: (value) {},
          ),
          QTextField(
            label: "Subject",
            value: "",
            onChanged: (value) {},
          ),
          QMemoField(
            label: "Email Body",
            value: "",
            onChanged: (value) {},
          ),
          QButton(
            label: "Save Template",
            size: bs.md,
            icon: Icons.save,
            onPressed: _saveTemplate,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Emails Sent", "24", Icons.send, primaryColor),
        _buildStatCard("Delivered", "22", Icons.check_circle, successColor),
        _buildStatCard("Opens", "18", Icons.visibility, infoColor),
        _buildStatCard("Clicks", "8", Icons.mouse, warningColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
          Icon(icon, color: color, size: 32),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryHistory() {
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
                Icon(
                  Icons.history,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Delivery History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(deliveryHistory.length, (index) {
            final delivery = deliveryHistory[index];
            final isLast = index == deliveryHistory.length - 1;
            
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
                  Icon(
                    delivery["type"] == "email" ? Icons.email : Icons.notifications,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${delivery["subject"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "To: ${delivery["recipient"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Sent: ${delivery["sentDate"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${delivery["status"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "Opens: ${delivery["opens"]} | Clicks: ${delivery["clicks"]}",
                        style: TextStyle(
                          color: disabledColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _previewEmail() {
    si("Email preview opened");
  }

  void _sendInvoice() {
    if (scheduleEmail) {
      ss("Invoice scheduled for delivery on ${scheduledDate.toIso8601String().split('T')[0]} at ${scheduledTime.format(context)}");
    } else {
      ss("Invoice sent successfully");
    }
  }

  void _sendSMS() {
    si("SMS notification sent");
  }

  void _printAndMail() {
    si("Invoice prepared for printing and mailing");
  }

  void _createTemplate() {
    si("Create new template");
  }

  void _editTemplate(Map<String, dynamic> template) {
    si("Edit template: ${template["name"]}");
  }

  void _deleteTemplate(Map<String, dynamic> template) async {
    bool isConfirmed = await confirm("Delete this template?");
    if (isConfirmed) {
      emailTemplates.removeWhere((t) => t["id"] == template["id"]);
      setState(() {});
      ss("Template deleted");
    }
  }

  void _saveTemplate() {
    ss("Template saved successfully");
  }
}
