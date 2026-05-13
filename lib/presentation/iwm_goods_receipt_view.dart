import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmGoodsReceiptView extends StatefulWidget {
  const IwmGoodsReceiptView({super.key});

  @override
  State<IwmGoodsReceiptView> createState() => _IwmGoodsReceiptViewState();
}

class _IwmGoodsReceiptViewState extends State<IwmGoodsReceiptView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedType = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Rejected", "value": "rejected"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Purchase Order", "value": "purchase_order"},
    {"label": "Return", "value": "return"},
    {"label": "Transfer", "value": "transfer"},
    {"label": "Production", "value": "production"},
  ];
  
  List<Map<String, dynamic>> goodsReceipts = [
    {
      "id": "GR-2024-0001",
      "poNumber": "PO-2024-0001",
      "supplier": "ABC Manufacturing",
      "receiptDate": "2024-01-15",
      "expectedDate": "2024-01-14",
      "status": "Completed",
      "type": "Purchase Order",
      "totalItems": 15,
      "receivedItems": 15,
      "totalValue": 25000.0,
      "warehouse": "Main Warehouse",
      "receivedBy": "John Smith",
      "notes": "All items received in good condition"
    },
    {
      "id": "GR-2024-0002",
      "poNumber": "PO-2024-0002",
      "supplier": "XYZ Components",
      "receiptDate": "2024-01-14",
      "expectedDate": "2024-01-14",
      "status": "In Progress",
      "type": "Purchase Order",
      "totalItems": 8,
      "receivedItems": 5,
      "totalValue": 18500.0,
      "warehouse": "Secondary Warehouse",
      "receivedBy": "Sarah Johnson",
      "notes": "Partial receipt, remaining items expected tomorrow"
    },
    {
      "id": "GR-2024-0003",
      "poNumber": "RTN-2024-0003",
      "supplier": "Tech Solutions Ltd",
      "receiptDate": "2024-01-13",
      "expectedDate": "2024-01-13",
      "status": "Pending",
      "type": "Return",
      "totalItems": 3,
      "receivedItems": 0,
      "totalValue": 1200.0,
      "warehouse": "Returns Warehouse",
      "receivedBy": "",
      "notes": "Return merchandise waiting for processing"
    },
    {
      "id": "GR-2024-0004",
      "poNumber": "TR-2024-0004",
      "supplier": "Internal Transfer",
      "receiptDate": "2024-01-12",
      "expectedDate": "2024-01-12",
      "status": "On Hold",
      "type": "Transfer",
      "totalItems": 22,
      "receivedItems": 18,
      "totalValue": 8900.0,
      "warehouse": "Distribution Center",
      "receivedBy": "Mike Davis",
      "notes": "Discrepancy found, waiting for investigation"
    },
  ];
  
  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Receipts",
      "value": 248,
      "subtitle": "This Month",
      "icon": Icons.inbox,
      "color": primaryColor
    },
    {
      "title": "Pending",
      "value": 12,
      "subtitle": "Need Processing",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "In Progress",
      "value": 8,
      "subtitle": "Being Processed",
      "icon": Icons.hourglass_empty,
      "color": infoColor
    },
    {
      "title": "Total Value",
      "value": 1850000,
      "subtitle": "USD Received",
      "icon": Icons.attach_money,
      "color": successColor,
      "isAmount": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Goods Receipt",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Receipts", icon: Icon(Icons.inbox)),
        Tab(text: "Process", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReceiptsTab(),
        _buildProcessTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryStats(),
          _buildQuickActions(),
          _buildRecentReceipts(),
        ],
      ),
    );
  }

  Widget _buildReceiptsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildReceiptsList(),
        ],
      ),
    );
  }

  Widget _buildProcessTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProcessingQueue(),
          _buildProcessingTools(),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Receipt Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: summaryStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            stat["isAmount"] == true 
                ? "\$${((stat["value"] as int).toDouble() / 1000).toStringAsFixed(0)}K"
                : "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  label: "New Receipt",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Scan Barcode",
                  icon: Icons.qr_code_scanner,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                child: QTextField(
                  label: "Search Receipts",
                  value: searchQuery,
                  hint: "Receipt ID, PO Number...",
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
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
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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

  Widget _buildReceiptsList() {
    return Column(
      spacing: spSm,
      children: goodsReceipts.map((receipt) => _buildReceiptCard(receipt)).toList(),
    );
  }

  Widget _buildRecentReceipts() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Receipts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...goodsReceipts.take(3).map((receipt) => _buildReceiptCard(receipt)),
        ],
      ),
    );
  }

  Widget _buildReceiptCard(Map<String, dynamic> receipt) {
    Color statusColor = _getStatusColor(receipt["status"]);
    Color typeColor = _getTypeColor(receipt["type"]);
    double progress = (receipt["receivedItems"] as int) / (receipt["totalItems"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
                  children: [
                    Text(
                      "${receipt["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "PO: ${receipt["poNumber"]} • ${receipt["supplier"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${receipt["type"]}",
                      style: TextStyle(
                        color: typeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${receipt["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (progress > 0 && progress < 1) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${receipt["receivedItems"]}/${receipt["totalItems"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Value: \$${((receipt["totalValue"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Warehouse: ${receipt["warehouse"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if ((receipt["receivedBy"] as String).isNotEmpty)
                      Text(
                        "Received by: ${receipt["receivedBy"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              QButton(
                label: "Process",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          if ((receipt["notes"] as String).isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.notes, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${receipt["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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

  Widget _buildProcessingQueue() {
    List<Map<String, dynamic>> queueItems = goodsReceipts.where((r) => 
      r["status"] == "Pending" || r["status"] == "In Progress").toList();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Processing Queue",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${queueItems.length} items",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...queueItems.map((item) => _buildQueueItem(item)),
        ],
      ),
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: _getStatusColor(item["status"]),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${item["supplier"]} • ${item["totalItems"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Process",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingTools() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Processing Tools",
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
              _buildToolCard("Batch Process", Icons.batch_prediction, "Process multiple receipts"),
              _buildToolCard("Quality Check", Icons.verified, "Verify item quality"),
              _buildToolCard("Print Labels", Icons.print, "Generate location labels"),
              _buildToolCard("Generate Report", Icons.report, "Create receipt report"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(String title, IconData icon, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, size: 32, color: primaryColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'in progress':
        return infoColor;
      case 'completed':
        return successColor;
      case 'on hold':
        return primaryColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'purchase order':
        return primaryColor;
      case 'return':
        return warningColor;
      case 'transfer':
        return infoColor;
      case 'production':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
