import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmShippingLabelsView extends StatefulWidget {
  const IwmShippingLabelsView({super.key});

  @override
  State<IwmShippingLabelsView> createState() => _IwmShippingLabelsViewState();
}

class _IwmShippingLabelsViewState extends State<IwmShippingLabelsView> {
  int selectedTab = 0;
  String selectedCarrier = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool isGenerating = false;

  List<Map<String, dynamic>> carrierItems = [
    {"label": "All Carriers", "value": "all"},
    {"label": "FedEx", "value": "fedex"},
    {"label": "UPS", "value": "ups"},
    {"label": "DHL", "value": "dhl"},
    {"label": "USPS", "value": "usps"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Generated", "value": "generated"},
    {"label": "Printed", "value": "printed"},
    {"label": "Used", "value": "used"},
    {"label": "Void", "value": "void"},
  ];

  List<Map<String, dynamic>> labelStats = [
    {
      "title": "Total Labels",
      "value": 1247,
      "subtitle": "This Month",
      "icon": Icons.label,
      "color": primaryColor
    },
    {
      "title": "Generated Today",
      "value": 89,
      "subtitle": "+12% from yesterday",
      "icon": Icons.add_circle,
      "color": successColor
    },
    {
      "title": "Printed",
      "value": 82,
      "subtitle": "92% printed",
      "icon": Icons.print,
      "color": infoColor
    },
    {
      "title": "Cost Saved",
      "value": 3250,
      "subtitle": "vs Retail Rates",
      "icon": Icons.savings,
      "color": warningColor
    },
  ];

  List<Map<String, dynamic>> shippingLabels = [
    {
      "id": "SL-2024-001234",
      "orderId": "ORD-789012",
      "carrier": "FedEx",
      "service": "Ground",
      "recipient": "John Smith",
      "address": "123 Main St, New York, NY 10001",
      "weight": 2.5,
      "cost": 12.45,
      "trackingNumber": "1234567890123456",
      "status": "Generated",
      "createdAt": "2024-01-20 09:30",
      "dimensions": "12x8x6",
      "packageType": "Box"
    },
    {
      "id": "SL-2024-001233",
      "orderId": "ORD-789011",
      "carrier": "UPS",
      "service": "Next Day Air",
      "recipient": "Sarah Johnson",
      "address": "456 Oak Ave, Los Angeles, CA 90210",
      "weight": 1.8,
      "cost": 24.99,
      "trackingNumber": "1Z999AA1234567890",
      "status": "Printed",
      "createdAt": "2024-01-20 08:15",
      "dimensions": "10x6x4",
      "packageType": "Envelope"
    },
    {
      "id": "SL-2024-001232",
      "orderId": "ORD-789010",
      "carrier": "DHL",
      "service": "Express",
      "recipient": "Mike Chen",
      "address": "789 Pine St, Chicago, IL 60601",
      "weight": 3.2,
      "cost": 18.75,
      "trackingNumber": "DHL123456789",
      "status": "Used",
      "createdAt": "2024-01-19 16:45",
      "dimensions": "14x10x8",
      "packageType": "Box"
    },
  ];

  List<Map<String, dynamic>> labelTemplates = [
    {
      "name": "Standard Package",
      "size": "4x6 inches",
      "format": "PDF",
      "usage": 1250,
      "lastUsed": "2024-01-20",
      "isDefault": true
    },
    {
      "name": "Express Envelope",
      "size": "4x6 inches",
      "format": "ZPL",
      "usage": 450,
      "lastUsed": "2024-01-19",
      "isDefault": false
    },
    {
      "name": "International",
      "size": "6x8 inches",
      "format": "PDF",
      "usage": 125,
      "lastUsed": "2024-01-18",
      "isDefault": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shipping Labels",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Labels", icon: Icon(Icons.label)),
        Tab(text: "Templates", icon: Icon(Icons.file_copy)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildLabelsTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildLabelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(),
          _buildQuickActions(),
          _buildLabelsList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTemplateHeader(),
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabelStats(),
          _buildUsageChart(),
          _buildCostAnalysis(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
          QTextField(
            label: "Search labels",
            value: searchQuery,
            hint: "Search by ID, order, or tracking number",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Carrier",
                  items: carrierItems,
                  value: selectedCarrier,
                  onChanged: (value, label) {
                    selectedCarrier = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
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
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Generate Label",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () => _showGenerateLabelDialog(),
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.print,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLabelsList() {
    return Column(
      spacing: spSm,
      children: shippingLabels.map((label) => _buildLabelCard(label)).toList(),
    );
  }

  Widget _buildLabelCard(Map<String, dynamic> label) {
    Color statusColor = _getStatusColor(label["status"]);
    
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${label["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${label["orderId"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${label["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${label["carrier"]} ${label["service"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(label["cost"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${label["recipient"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${label["address"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Tracking: ${label["trackingNumber"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${label["weight"]} lbs • ${label["dimensions"]}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              QButton(
                label: "Print",
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "Label Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "New Template",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
    return Column(
      spacing: spSm,
      children: labelTemplates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.file_copy,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (template["isDefault"]) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Default",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${template["size"]} • ${template["format"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Used ${template["usage"]} times • Last: ${template["lastUsed"]}",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLabelStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Label Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: labelStats.map((stat) => _buildStatCard(stat)).toList(),
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
            "${stat["value"]}",
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

  Widget _buildUsageChart() {
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
            "Daily Label Generation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Usage Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostAnalysis() {
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
            "Cost Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$3,250",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Saved",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$8,450",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showGenerateLabelDialog() {
    // Generate label dialog implementation
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'generated':
        return infoColor;
      case 'printed':
        return warningColor;
      case 'used':
        return successColor;
      case 'void':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
