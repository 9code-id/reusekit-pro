import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSupplierDetailsView extends StatefulWidget {
  const IwmSupplierDetailsView({super.key});

  @override
  State<IwmSupplierDetailsView> createState() => _IwmSupplierDetailsViewState();
}

class _IwmSupplierDetailsViewState extends State<IwmSupplierDetailsView> {
  int selectedTab = 0;
  bool isEditMode = false;
  
  // Supplier Details
  Map<String, dynamic> supplier = {
    "id": "SUP-001",
    "name": "Global Materials Inc.",
    "category": "Raw Materials",
    "contact": "John Smith",
    "email": "john@globalmaterials.com",
    "phone": "+1-555-0123",
    "address": "123 Industrial Ave, Detroit, MI 48201",
    "country": "USA",
    "region": "North America",
    "status": "Active",
    "rating": 4.8,
    "totalOrders": 145,
    "totalValue": 2450000.0,
    "lastOrder": "2024-01-10",
    "joinDate": "2022-03-15",
    "performanceScore": 94,
    "onTimeDelivery": 96,
    "qualityScore": 92,
    "certifications": ["ISO 9001", "ISO 14001", "OHSAS 18001"],
    "paymentTerms": "Net 30",
    "creditLimit": 500000.0,
    "logo": "https://picsum.photos/100/100?random=1&keyword=company",
    "website": "www.globalmaterials.com",
    "establishedYear": "1995",
    "employees": "500-1000",
    "annualRevenue": "50M-100M",
    "primaryProducts": ["Steel", "Aluminum", "Copper", "Plastics"],
    "languages": ["English", "Spanish"],
    "timezone": "EST (GMT-5)",
    "bankDetails": {
      "bank": "Chase Bank",
      "account": "****1234",
      "routing": "****5678"
    },
    "emergencyContact": {
      "name": "Sarah Wilson",
      "phone": "+1-555-0124",
      "email": "sarah@globalmaterials.com"
    },
    "socialMedia": {
      "linkedin": "linkedin.com/company/global-materials",
      "twitter": "@globalmaterials"
    }
  };

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "PO-2024-001",
      "date": "2024-01-10",
      "amount": 45000.0,
      "status": "Delivered",
      "items": 15,
      "deliveryDate": "2024-01-15"
    },
    {
      "id": "PO-2024-002",
      "date": "2024-01-08",
      "amount": 32000.0,
      "status": "In Transit",
      "items": 12,
      "deliveryDate": "2024-01-12"
    },
    {
      "id": "PO-2023-089",
      "date": "2023-12-28",
      "amount": 67000.0,
      "status": "Delivered",
      "items": 23,
      "deliveryDate": "2024-01-03"
    },
    {
      "id": "PO-2023-088",
      "date": "2023-12-25",
      "amount": 28000.0,
      "status": "Delivered",
      "items": 8,
      "deliveryDate": "2023-12-30"
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "name": "Business License",
      "type": "License",
      "uploadDate": "2022-03-15",
      "status": "Valid",
      "expiryDate": "2025-03-15",
      "size": "2.3 MB"
    },
    {
      "name": "ISO 9001 Certificate",
      "type": "Certification",
      "uploadDate": "2023-06-20",
      "status": "Valid",
      "expiryDate": "2026-06-20",
      "size": "1.8 MB"
    },
    {
      "name": "Insurance Certificate",
      "type": "Insurance",
      "uploadDate": "2024-01-01",
      "status": "Valid",
      "expiryDate": "2024-12-31",
      "size": "1.2 MB"
    },
    {
      "name": "Tax Certificate",
      "type": "Tax",
      "uploadDate": "2023-12-15",
      "status": "Valid",
      "expiryDate": "2024-12-15",
      "size": "890 KB"
    },
  ];

  List<Map<String, dynamic>> contacts = [
    {
      "name": "John Smith",
      "position": "Sales Manager",
      "email": "john@globalmaterials.com",
      "phone": "+1-555-0123",
      "department": "Sales",
      "isPrimary": true
    },
    {
      "name": "Sarah Wilson",
      "position": "Operations Director",
      "email": "sarah@globalmaterials.com",
      "phone": "+1-555-0124",
      "department": "Operations",
      "isPrimary": false
    },
    {
      "name": "Mike Johnson",
      "position": "Quality Manager",
      "email": "mike@globalmaterials.com",
      "phone": "+1-555-0125",
      "department": "Quality",
      "isPrimary": false
    },
  ];

  List<Map<String, dynamic>> performanceHistory = [
    {"month": "Jan 2024", "onTime": 98, "quality": 95, "rating": 4.8},
    {"month": "Dec 2023", "onTime": 94, "quality": 90, "rating": 4.6},
    {"month": "Nov 2023", "onTime": 96, "quality": 88, "rating": 4.5},
    {"month": "Oct 2023", "onTime": 92, "quality": 91, "rating": 4.7},
    {"month": "Sep 2023", "onTime": 89, "quality": 86, "rating": 4.4},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${supplier["name"]}",
      actions: [
        GestureDetector(
          onTap: () {
            isEditMode = !isEditMode;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(spXs),
            child: Icon(
              isEditMode ? Icons.check : Icons.edit,
              color: primaryColor,
            ),
          ),
        ),
      ],
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
        Tab(text: "Contacts", icon: Icon(Icons.people)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildOrdersTab(),
        _buildDocumentsTab(),
        _buildContactsTab(),
        _buildPerformanceTab(),
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
          _buildSupplierHeader(),
          _buildKeyMetrics(),
          _buildBasicInformation(),
          _buildBusinessInformation(),
          _buildFinancialInformation(),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderSummary(),
          _buildRecentOrdersList(),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDocumentActions(),
          _buildDocumentsList(),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactActions(),
          _buildContactsList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceOverview(),
          _buildPerformanceHistory(),
          _buildPerformanceChart(),
        ],
      ),
    );
  }

  Widget _buildSupplierHeader() {
    Color statusColor = _getStatusColor(supplier["status"]);
    
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
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("${supplier["logo"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${supplier["name"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${supplier["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${supplier["category"]} • ${supplier["region"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Member since ${supplier["joinDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "${supplier["rating"]} Rating",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(color: disabledColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${supplier["totalOrders"]} Orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
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

  Widget _buildKeyMetrics() {
    List<Map<String, dynamic>> metrics = [
      {
        "title": "Total Value",
        "value": "\$${((supplier["totalValue"] as double) / 1000000).toStringAsFixed(1)}M",
        "subtitle": "Lifetime",
        "icon": Icons.monetization_on,
        "color": successColor
      },
      {
        "title": "Performance",
        "value": "${supplier["performanceScore"]}%",
        "subtitle": "Score",
        "icon": Icons.trending_up,
        "color": primaryColor
      },
      {
        "title": "On-Time Delivery",
        "value": "${supplier["onTimeDelivery"]}%",
        "subtitle": "Average",
        "icon": Icons.delivery_dining,
        "color": infoColor
      },
      {
        "title": "Quality Score",
        "value": "${supplier["qualityScore"]}%",
        "subtitle": "Average",
        "icon": Icons.verified,
        "color": warningColor
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Key Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: metrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
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
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${metric["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformation() {
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
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (isEditMode)
                QButton(
                  label: "Save",
                  size: bs.sm,
                  onPressed: () {},
                ),
            ],
          ),
          _buildInfoRow("Company Name", supplier["name"], isEditable: isEditMode),
          _buildInfoRow("Category", supplier["category"], isEditable: isEditMode),
          _buildInfoRow("Website", supplier["website"], isEditable: isEditMode),
          _buildInfoRow("Phone", supplier["phone"], isEditable: isEditMode),
          _buildInfoRow("Email", supplier["email"], isEditable: isEditMode),
          _buildInfoRow("Address", supplier["address"], isEditable: isEditMode),
          _buildInfoRow("Country", supplier["country"], isEditable: isEditMode),
          _buildInfoRow("Timezone", supplier["timezone"], isEditable: isEditMode),
        ],
      ),
    );
  }

  Widget _buildBusinessInformation() {
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
            "Business Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("Established", supplier["establishedYear"]),
          _buildInfoRow("Employees", supplier["employees"]),
          _buildInfoRow("Annual Revenue", supplier["annualRevenue"]),
          _buildInfoRow("Primary Products", (supplier["primaryProducts"] as List).join(", ")),
          _buildInfoRow("Languages", (supplier["languages"] as List).join(", ")),
          _buildInfoRow("Certifications", (supplier["certifications"] as List).join(", ")),
        ],
      ),
    );
  }

  Widget _buildFinancialInformation() {
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
            "Financial Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("Payment Terms", supplier["paymentTerms"]),
          _buildInfoRow("Credit Limit", "\$${((supplier["creditLimit"] as double).toDouble()).currency}"),
          _buildInfoRow("Bank", supplier["bankDetails"]["bank"]),
          _buildInfoRow("Account", supplier["bankDetails"]["account"]),
          _buildInfoRow("Routing", supplier["bankDetails"]["routing"]),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isEditable = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: isEditable
              ? QTextField(
                  value: value,
                  onChanged: (newValue) {
                    setState(() {});
                  },
                )
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
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
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Total Orders", "${supplier["totalOrders"]}", primaryColor),
              ),
              Expanded(
                child: _buildSummaryItem("Total Value", "\$${((supplier["totalValue"] as double) / 1000000).toStringAsFixed(1)}M", successColor),
              ),
              Expanded(
                child: _buildSummaryItem("Avg Order", "\$${((supplier["totalValue"] as double) / (supplier["totalOrders"] as int) / 1000).toStringAsFixed(0)}K", infoColor),
              ),
              Expanded(
                child: _buildSummaryItem("Last Order", "${supplier["lastOrder"]}", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentOrdersList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Orders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...recentOrders.map((order) => _buildOrderCard(order)),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getOrderStatusColor(order["status"]);
    
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Date: ${order["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${order["status"]}",
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
                      "\$${((order["amount"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${order["items"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Delivery",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${order["deliveryDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "View",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentActions() {
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
            "Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "Upload",
            icon: Icons.upload_file,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsList() {
    return Column(
      spacing: spSm,
      children: documents.map((document) => _buildDocumentCard(document)).toList(),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    Color statusColor = document["status"] == "Valid" ? successColor : dangerColor;
    IconData typeIcon = _getDocumentIcon(document["type"]);
    
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
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
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
                  "${document["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${document["type"]} • ${document["size"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Expires: ${document["expiryDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${document["status"]}",
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.download,
              color: primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactActions() {
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
            "Contacts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "Add Contact",
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return Column(
      spacing: spSm,
      children: contacts.map((contact) => _buildContactCard(contact)).toList(),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${contact["name"]}".substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
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
                      "${contact["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (contact["isPrimary"])
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "PRIMARY",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${contact["position"]} • ${contact["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${contact["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${contact["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.email,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.phone,
                    color: successColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
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
            "Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceItem("Overall Score", "${supplier["performanceScore"]}%", primaryColor),
              ),
              Expanded(
                child: _buildPerformanceItem("On-Time Delivery", "${supplier["onTimeDelivery"]}%", successColor),
              ),
              Expanded(
                child: _buildPerformanceItem("Quality Score", "${supplier["qualityScore"]}%", infoColor),
              ),
              Expanded(
                child: _buildPerformanceItem("Rating", "★ ${supplier["rating"]}", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceHistory() {
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
            "Performance History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...performanceHistory.map((history) => _buildHistoryItem(history)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "${history["month"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${history["onTime"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "On-Time",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${history["quality"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Quality",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${history["rating"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildPerformanceChart() {
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
            "Performance Trends",
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
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Performance Trend Chart",
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'pending':
        return warningColor;
      case 'suspended':
      case 'inactive':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getOrderStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return successColor;
      case 'in transit':
        return infoColor;
      case 'processing':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getDocumentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'license':
        return Icons.verified_user;
      case 'certification':
        return Icons.verified;
      case 'insurance':
        return Icons.security;
      case 'tax':
        return Icons.receipt;
      default:
        return Icons.description;
    }
  }
}
