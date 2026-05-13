import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmIntegrationCenterView extends StatefulWidget {
  const EcmIntegrationCenterView({super.key});

  @override
  State<EcmIntegrationCenterView> createState() => _EcmIntegrationCenterViewState();
}

class _EcmIntegrationCenterViewState extends State<EcmIntegrationCenterView> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All Integrations", "value": "All"},
    {"label": "Payment Gateways", "value": "Payment"},
    {"label": "Shipping Services", "value": "Shipping"},
    {"label": "Marketing Tools", "value": "Marketing"},
    {"label": "Analytics", "value": "Analytics"},
    {"label": "Customer Support", "value": "Support"},
    {"label": "Inventory Management", "value": "Inventory"},
    {"label": "Social Media", "value": "Social"},
  ];

  List<Map<String, dynamic>> integrations = [
    {
      "name": "Stripe",
      "description": "Accept payments online with Stripe's secure payment processing",
      "category": "Payment",
      "status": "Connected",
      "icon": Icons.payment,
      "color": "#635BFF",
      "popularity": 95,
      "rating": 4.8,
      "reviews": 12450,
      "features": ["Credit Cards", "Digital Wallets", "Subscriptions", "International"],
      "setupTime": "5 minutes",
      "pricing": "2.9% + 30¢ per transaction",
    },
    {
      "name": "PayPal",
      "description": "Enable PayPal payments for your customers worldwide",
      "category": "Payment",
      "status": "Available",
      "icon": Icons.account_balance_wallet,
      "color": "#0070BA",
      "popularity": 88,
      "rating": 4.6,
      "reviews": 8750,
      "features": ["PayPal Checkout", "Express Checkout", "Buyer Protection"],
      "setupTime": "10 minutes",
      "pricing": "2.9% + fixed fee",
    },
    {
      "name": "FedEx",
      "description": "Fast and reliable shipping solutions with real-time tracking",
      "category": "Shipping",
      "status": "Connected",
      "icon": Icons.local_shipping,
      "color": "#4B0F87",
      "popularity": 82,
      "rating": 4.5,
      "reviews": 5680,
      "features": ["Express Delivery", "Ground Shipping", "International"],
      "setupTime": "15 minutes",
      "pricing": "Variable rates",
    },
    {
      "name": "Mailchimp",
      "description": "Email marketing automation and customer engagement platform",
      "category": "Marketing",
      "status": "Available",
      "icon": Icons.email,
      "color": "#FFE01B",
      "popularity": 78,
      "rating": 4.4,
      "reviews": 9200,
      "features": ["Email Campaigns", "Automation", "Analytics", "Templates"],
      "setupTime": "20 minutes",
      "pricing": "Free up to 2,000 contacts",
    },
    {
      "name": "Google Analytics",
      "description": "Track and analyze your e-commerce performance",
      "category": "Analytics",
      "status": "Connected",
      "icon": Icons.analytics,
      "color": "#EA4335",
      "popularity": 92,
      "rating": 4.7,
      "reviews": 15600,
      "features": ["Real-time Analytics", "Conversion Tracking", "Custom Reports"],
      "setupTime": "10 minutes",
      "pricing": "Free",
    },
    {
      "name": "Zendesk",
      "description": "Complete customer support and helpdesk solution",
      "category": "Support",
      "status": "Available",
      "icon": Icons.support_agent,
      "color": "#03363D",
      "popularity": 71,
      "rating": 4.3,
      "reviews": 4200,
      "features": ["Live Chat", "Ticket Management", "Knowledge Base"],
      "setupTime": "25 minutes",
      "pricing": "From \$19/month",
    },
    {
      "name": "Shopify Inventory",
      "description": "Advanced inventory management and stock tracking",
      "category": "Inventory",
      "status": "Available",
      "icon": Icons.inventory,
      "color": "#96BF48",
      "popularity": 65,
      "rating": 4.2,
      "reviews": 3150,
      "features": ["Stock Tracking", "Low Stock Alerts", "Multi-location"],
      "setupTime": "30 minutes",
      "pricing": "From \$29/month",
    },
    {
      "name": "Facebook Pixel",
      "description": "Track conversions and create targeted ads on Facebook",
      "category": "Social",
      "status": "Available",
      "icon": Icons.facebook,
      "color": "#1877F2",
      "popularity": 74,
      "rating": 4.1,
      "reviews": 6800,
      "features": ["Conversion Tracking", "Custom Audiences", "Retargeting"],
      "setupTime": "15 minutes",
      "pricing": "Free",
    },
  ];

  List<Map<String, dynamic>> get filteredIntegrations {
    return integrations.where((integration) {
      final matchesCategory = selectedCategory == "All" || integration["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          integration["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          integration["description"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Widget _buildIntegrationCard(Map<String, dynamic> integration) {
    final isConnected = integration["status"] == "Connected";
    final statusColor = isConnected ? successColor : primaryColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: isConnected ? Border.all(color: successColor.withAlpha(50)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(int.parse("0xFF${integration["color"].substring(1)}")).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  integration["icon"],
                  color: Color(int.parse("0xFF${integration["color"].substring(1)}")),
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${integration["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isConnected ? Icons.check_circle : Icons.add_circle,
                                color: statusColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${integration["status"]}",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${integration["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Rating and Reviews
          Row(
            children: [
              Icon(Icons.star, color: Color(0xFFFFB000), size: 14),
              SizedBox(width: spXs),
              Text(
                "${integration["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "(${(integration["reviews"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')})",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Popularity: ${integration["popularity"]}%",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Features
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (integration["features"] as List<String>).take(3).map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          
          // Details
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 12),
              SizedBox(width: spXs),
              Text(
                "Setup: ${integration["setupTime"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.attach_money, color: disabledBoldColor, size: 12),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${integration["pricing"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isConnected ? "Configure" : "Connect",
                  size: bs.sm,
                  onPressed: () {
                    if (isConnected) {
                      si("Opening ${integration["name"]} configuration...");
                    } else {
                      ss("Connecting to ${integration["name"]}...");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  si("Viewing ${integration["name"]} details and documentation");
                },
              ),
              if (isConnected) ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.settings,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening ${integration["name"]} settings");
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    final connectedCount = integrations.where((i) => i["status"] == "Connected").length;
    final availableCount = integrations.length - connectedCount;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$connectedCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Connected",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$availableCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Available",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${integrations.length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
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
        title: Text("Integration Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Request new integration feature");
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Integration help and documentation");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search integrations",
                        value: searchQuery,
                        hint: "Search by name or description",
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
                      onPressed: () {
                        si("Searching for: $searchQuery");
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                QHorizontalScroll(
                  children: categories.map((category) {
                    final isSelected = selectedCategory == category["value"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedCategory = category["value"];
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Text(
                          "${category["label"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  _buildStatsCard(),
                  SizedBox(height: spLg),
                  
                  // Results Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCategory == "All" 
                            ? "All Integrations"
                            : "$selectedCategory Integrations",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredIntegrations.length} results",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Integration Cards
                  if (filteredIntegrations.isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 60,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No integrations found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try adjusting your search or filter criteria",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...filteredIntegrations.map((integration) => _buildIntegrationCard(integration)).toList(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Sync all connected integrations");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.sync, color: Colors.white),
      ),
    );
  }
}
