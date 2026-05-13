import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaQuoteDetailView extends StatefulWidget {
  const CmaQuoteDetailView({super.key});

  @override
  State<CmaQuoteDetailView> createState() => _CmaQuoteDetailViewState();
}

class _CmaQuoteDetailViewState extends State<CmaQuoteDetailView> {
  int currentTab = 0;
  
  Map<String, dynamic> quoteData = {
    "id": "QT001",
    "number": "QUO-2024-001",
    "customer": "Tech Solutions Inc",
    "email": "contact@techsolutions.com",
    "phone": "+1 234 567 8900",
    "address": "123 Business Ave, Tech City, TC 12345",
    "amount": 12500.0,
    "tax": 1250.0,
    "discount": 0.0,
    "total": 13750.0,
    "status": "sent",
    "priority": "high",
    "validUntil": "2024-02-15",
    "createdDate": "2024-01-15",
    "lastModified": "2024-01-15 14:30",
    "assignedTo": "John Smith",
    "assignedEmail": "john@company.com",
    "createdBy": "John Smith",
    "items": [
      {
        "id": "ITM001",
        "name": "CRM Pro License",
        "description": "Professional CRM license with advanced features",
        "quantity": 5,
        "price": 2000.0,
        "discount": 0.0,
        "total": 10000.0,
        "category": "Software"
      },
      {
        "id": "ITM002", 
        "name": "Setup & Training",
        "description": "Complete setup and user training package",
        "quantity": 1,
        "price": 2500.0,
        "discount": 0.0,
        "total": 2500.0,
        "category": "Service"
      }
    ],
    "notes": "Enterprise package with training included. Customer requires implementation within 30 days.",
    "terms": "Net 30 days payment terms. 50% deposit required before implementation.",
    "internalNotes": "High priority client. Potential for additional licenses in Q2."
  };

  List<Map<String, dynamic>> activities = [
    {
      "id": "ACT001",
      "type": "created",
      "title": "Quote Created",
      "description": "Quote QUO-2024-001 created for Tech Solutions Inc",
      "timestamp": "2024-01-15 10:30",
      "user": "John Smith",
      "details": "Initial quote created with 2 line items totaling \$13,750"
    },
    {
      "id": "ACT002",
      "type": "sent",
      "title": "Quote Sent",
      "description": "Quote sent to contact@techsolutions.com",
      "timestamp": "2024-01-15 11:15",
      "user": "John Smith",
      "details": "Quote PDF generated and sent via email"
    },
    {
      "id": "ACT003",
      "type": "viewed",
      "title": "Quote Viewed",
      "description": "Customer viewed the quote online",
      "timestamp": "2024-01-16 09:22",
      "user": "System",
      "details": "Quote viewed by customer IP: 192.168.1.100"
    },
    {
      "id": "ACT004",
      "type": "comment",
      "title": "Internal Comment Added",
      "description": "Added internal note about implementation timeline",
      "timestamp": "2024-01-16 14:45",
      "user": "John Smith",
      "details": "Customer wants to start implementation by Feb 1st"
    }
  ];

  List<Map<String, dynamic>> attachments = [
    {
      "id": "ATT001",
      "name": "Quote_QUO-2024-001.pdf",
      "type": "pdf",
      "size": "2.1 MB",
      "uploadDate": "2024-01-15 11:15",
      "uploadedBy": "John Smith"
    },
    {
      "id": "ATT002",
      "name": "Product_Specifications.docx",
      "type": "document",
      "size": "856 KB",
      "uploadDate": "2024-01-15 10:45",
      "uploadedBy": "John Smith"
    },
    {
      "id": "ATT003",
      "name": "Implementation_Timeline.xlsx",
      "type": "spreadsheet",
      "size": "124 KB",
      "uploadDate": "2024-01-16 09:30",
      "uploadedBy": "John Smith"
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "sent":
        return infoColor;
      case "draft":
        return warningColor;
      case "expired":
        return dangerColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "created":
        return Icons.note_add;
      case "sent":
        return Icons.send;
      case "viewed":
        return Icons.visibility;
      case "comment":
        return Icons.comment;
      case "updated":
        return Icons.edit;
      default:
        return Icons.history;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "document":
        return Icons.description;
      case "spreadsheet":
        return Icons.table_chart;
      case "image":
        return Icons.image;
      default:
        return Icons.attach_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${quoteData["number"]}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Items", icon: Icon(Icons.list)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
        Tab(text: "Attachments", icon: Icon(Icons.attach_file)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildItemsTab(),
        _buildActivitiesTab(),
        _buildAttachmentsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildQuoteHeader(),
          _buildCustomerInfo(),
          _buildQuoteSummary(),
          _buildQuoteActions(),
        ],
      ),
    );
  }

  Widget _buildQuoteHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${quoteData["number"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${quoteData["customer"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(quoteData["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${quoteData["status"].toString().toUpperCase()}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(quoteData["status"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(quoteData["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${quoteData["priority"].toString().toUpperCase()} PRIORITY",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor(quoteData["priority"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Created Date",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${quoteData["createdDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Valid Until",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${quoteData["validUntil"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
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
                      "Assigned To",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${quoteData["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
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
          Row(
            children: [
              Icon(Icons.business, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    _buildInfoRow("Company", "${quoteData["customer"]}"),
                    _buildInfoRow("Email", "${quoteData["email"]}"),
                    _buildInfoRow("Phone", "${quoteData["phone"]}"),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${quoteData["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteSummary() {
    return Container(
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
          Row(
            children: [
              Icon(Icons.receipt, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Quote Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Subtotal",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "\$${(quoteData["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Tax",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "\$${(quoteData["tax"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if ((quoteData["discount"] as double) > 0) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  "-\$${(quoteData["discount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ],
          Divider(),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${(quoteData["total"] as double).currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          if (quoteData["notes"].toString().isNotEmpty) ...[
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
                  Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${quoteData["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuoteActions() {
    return Container(
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
            "Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Divider(),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionButton("Edit Quote", Icons.edit, primaryColor, () {
                si("Edit quote functionality");
              }),
              _buildActionButton("Send Quote", Icons.send, infoColor, () {
                si("Send quote functionality");
              }),
              _buildActionButton("Duplicate", Icons.copy, warningColor, () {
                si("Duplicate quote functionality");
              }),
              _buildActionButton("Convert to Order", Icons.shopping_cart, successColor, () {
                si("Convert to order functionality");
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: QButton(
        label: label,
        icon: icon,
        size: bs.sm,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.list, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Quote Items (${(quoteData["items"] as List).length})",
                    style: TextStyle(
                      fontSize: fsH6,  
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    si("Add new item functionality");
                  },
                ),
              ],
            ),
          ),
          ...(quoteData["items"] as List).map((item) => _buildItemCard(item)),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${item["quantity"]}",
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
                      "Unit Price",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${(item["price"] as double).currency}",
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
                      "Total",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${(item["total"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("Edit item: ${item["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Quote Activity Timeline",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    si("Add activity log functionality");
                  },
                ),
              ],
            ),
          ),
          ...activities.map((activity) => _buildActivityCard(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getActivityIcon(activity["type"]),
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (activity["details"].toString().isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${activity["details"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
                Text(
                  "${activity["user"]} • ${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 10,
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

  Widget _buildAttachmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.attach_file, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Quote Attachments (${attachments.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    si("Upload attachment functionality");
                  },
                ),
              ],
            ),
          ),
          ...attachments.map((attachment) => _buildAttachmentCard(attachment)),
        ],
      ),
    );
  }

  Widget _buildAttachmentCard(Map<String, dynamic> attachment) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getFileIcon(attachment["type"]),
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attachment["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${attachment["size"]} • Uploaded by ${attachment["uploadedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${attachment["uploadDate"]}",
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
            onPressed: () {
              si("Download attachment: ${attachment["name"]}");
            },
          ),
        ],
      ),
    );
  }
}
