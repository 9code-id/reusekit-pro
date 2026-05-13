import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmIntegrationSetupView extends StatefulWidget {
  const IwmIntegrationSetupView({super.key});

  @override
  State<IwmIntegrationSetupView> createState() => _IwmIntegrationSetupViewState();
}

class _IwmIntegrationSetupViewState extends State<IwmIntegrationSetupView> {
  int selectedTab = 0;
  String selectedIntegration = "all";
  
  // API Configuration
  String apiUrl = "https://api.inventorymanagement.com";
  String apiKey = "";
  String webhookUrl = "";
  bool enableApiLogging = true;
  int rateLimitPerHour = 1000;
  
  // Database Configuration
  String dbHost = "localhost";
  String dbPort = "5432";
  String dbName = "inventory_db";
  String dbUsername = "admin";
  String dbPassword = "";
  bool enableSslConnection = true;
  
  // Cloud Storage
  String storageProvider = "aws";
  String bucketName = "";
  String accessKey = "";
  String secretKey = "";
  String region = "us-east-1";
  
  List<Map<String, dynamic>> integrationFilters = [
    {"label": "All Integrations", "value": "all"},
    {"label": "Active Only", "value": "active"},
    {"label": "Inactive Only", "value": "inactive"},
    {"label": "Failed", "value": "failed"},
  ];
  
  List<Map<String, dynamic>> storageProviders = [
    {"label": "Amazon S3", "value": "aws"},
    {"label": "Google Cloud Storage", "value": "gcp"},
    {"label": "Azure Blob Storage", "value": "azure"},
    {"label": "Local Storage", "value": "local"},
  ];
  
  List<Map<String, dynamic>> availableIntegrations = [
    {
      "name": "Shopify",
      "type": "E-commerce",
      "icon": Icons.shopping_cart,
      "status": "Active",
      "connected": true,
      "lastSync": "2024-01-15 10:30 AM",
      "description": "Sync products and orders with Shopify store",
      "config": {
        "store_url": "mystore.myshopify.com",
        "api_key": "•••••••••••••••••",
        "webhook_url": "https://webhook.example.com/shopify",
      }
    },
    {
      "name": "WooCommerce",
      "type": "E-commerce",
      "icon": Icons.store,
      "status": "Active",
      "connected": true,
      "lastSync": "2024-01-15 09:45 AM",
      "description": "WordPress WooCommerce integration",
      "config": {
        "site_url": "mystore.com",
        "consumer_key": "•••••••••••••••••",
        "consumer_secret": "•••••••••••••••••",
      }
    },
    {
      "name": "Amazon FBA",
      "type": "Fulfillment",
      "icon": Icons.local_shipping,
      "status": "Inactive",
      "connected": false,
      "lastSync": "Never",
      "description": "Amazon Fulfillment by Amazon integration",
      "config": {
        "seller_id": "",
        "marketplace_id": "",
        "access_token": "",
      }
    },
    {
      "name": "QuickBooks",
      "type": "Accounting",
      "icon": Icons.calculate,
      "status": "Active",
      "connected": true,
      "lastSync": "2024-01-15 08:15 AM",
      "description": "Accounting and financial data synchronization",
      "config": {
        "company_id": "•••••••••••••••••",
        "client_id": "•••••••••••••••••",
        "client_secret": "•••••••••••••••••",
      }
    },
    {
      "name": "Stripe",
      "type": "Payment",
      "icon": Icons.payment,
      "status": "Active",
      "connected": true,
      "lastSync": "2024-01-15 11:00 AM",
      "description": "Payment processing integration",
      "config": {
        "publishable_key": "•••••••••••••••••",
        "secret_key": "•••••••••••••••••",
        "webhook_secret": "•••••••••••••••••",
      }
    },
    {
      "name": "Mailchimp",
      "type": "Marketing",
      "icon": Icons.email,
      "status": "Failed",
      "connected": false,
      "lastSync": "2024-01-14 03:20 PM",
      "description": "Email marketing and customer lists",
      "config": {
        "api_key": "•••••••••••••••••",
        "server_prefix": "us10",
        "list_id": "",
      }
    },
  ];
  
  List<Map<String, dynamic>> syncLogs = [
    {
      "integration": "Shopify",
      "status": "Success",
      "message": "Synced 25 products successfully",
      "timestamp": "2024-01-15 10:30 AM",
      "duration": "2.5s"
    },
    {
      "integration": "QuickBooks",
      "status": "Success",
      "message": "Updated financial records",
      "timestamp": "2024-01-15 08:15 AM",
      "duration": "1.8s"
    },
    {
      "integration": "Mailchimp",
      "status": "Failed",
      "message": "Authentication failed - invalid API key",
      "timestamp": "2024-01-14 03:20 PM",
      "duration": "0.5s"
    },
    {
      "integration": "WooCommerce",
      "status": "Warning",
      "message": "Partial sync - 3 products failed to update",
      "timestamp": "2024-01-15 09:45 AM",
      "duration": "4.2s"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Integration Setup",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Integrations", icon: Icon(Icons.hub)),
        Tab(text: "API Config", icon: Icon(Icons.api)),
        Tab(text: "Database", icon: Icon(Icons.storage)),
        Tab(text: "Cloud Storage", icon: Icon(Icons.cloud)),
      ],
      tabChildren: [
        _buildIntegrationsTab(),
        _buildApiConfigTab(),
        _buildDatabaseTab(),
        _buildCloudStorageTab(),
      ],
    );
  }

  Widget _buildIntegrationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntegrationFilters(),
          _buildIntegrationsList(),
          _buildSyncLogs(),
        ],
      ),
    );
  }

  Widget _buildApiConfigTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApiConfiguration(),
          _buildApiSettings(),
          _buildApiTestSection(),
        ],
      ),
    );
  }

  Widget _buildDatabaseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDatabaseConfiguration(),
          _buildConnectionSettings(),
          _buildDatabaseTestSection(),
        ],
      ),
    );
  }

  Widget _buildCloudStorageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStorageConfiguration(),
          _buildStorageSettings(),
          _buildStorageTestSection(),
        ],
      ),
    );
  }

  Widget _buildIntegrationFilters() {
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
            child: QDropdownField(
              label: "Filter Integrations",
              items: integrationFilters,
              value: selectedIntegration,
              onChanged: (value, label) {
                selectedIntegration = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            label: "Add Integration",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Integrations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...availableIntegrations.map((integration) => _buildIntegrationCard(integration)),
      ],
    );
  }

  Widget _buildIntegrationCard(Map<String, dynamic> integration) {
    Color statusColor = _getStatusColor(integration["status"]);
    
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  integration["icon"],
                  color: statusColor,
                  size: 20,
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
                          "${integration["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${integration["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${integration["description"]}",
                      style: TextStyle(
                        fontSize: 12,
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
                  "${integration["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
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
                      "Last Sync: ${integration["lastSync"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  QButton(
                    icon: Icons.settings,
                    size: bs.sm,
                    onPressed: () {
                      _showIntegrationConfig(integration);
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: integration["connected"] ? Icons.sync : Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      if (integration["connected"]) {
                        _syncIntegration(integration["name"]);
                      } else {
                        _connectIntegration(integration["name"]);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSyncLogs() {
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
                "Recent Sync Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
          ...syncLogs.map((log) => _buildSyncLogItem(log)),
        ],
      ),
    );
  }

  Widget _buildSyncLogItem(Map<String, dynamic> log) {
    Color statusColor = _getStatusColor(log["status"]);
    
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
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
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
                      "${log["integration"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${log["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${log["message"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${log["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Duration: ${log["duration"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
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

  Widget _buildApiConfiguration() {
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
            "API Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "API Base URL",
            value: apiUrl,
            onChanged: (value) {
              apiUrl = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "API Key",
            value: apiKey,
            onChanged: (value) {
              apiKey = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Webhook URL",
            value: webhookUrl,
            onChanged: (value) {
              webhookUrl = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApiSettings() {
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
            "API Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable API Logging",
                "value": true,
                "checked": enableApiLogging,
              }
            ],
            value: [
              if (enableApiLogging)
                {
                  "label": "Enable API Logging",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              enableApiLogging = values.isNotEmpty;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Rate Limit (requests/hour)",
            value: rateLimitPerHour.toString(),
            onChanged: (value) {
              rateLimitPerHour = int.tryParse(value) ?? 1000;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApiTestSection() {
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
            "API Test",
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
                  label: "Test Connection",
                  size: bs.md,
                  onPressed: () {
                    _testApiConnection();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate API Key",
                  size: bs.md,
                  onPressed: () {
                    _generateApiKey();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatabaseConfiguration() {
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
            "Database Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Host",
                  value: dbHost,
                  onChanged: (value) {
                    dbHost = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Port",
                  value: dbPort,
                  onChanged: (value) {
                    dbPort = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Database Name",
            value: dbName,
            onChanged: (value) {
              dbName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Username",
                  value: dbUsername,
                  onChanged: (value) {
                    dbUsername = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Password",
                  value: dbPassword,
                  obscureText: true,
                  onChanged: (value) {
                    dbPassword = value;
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

  Widget _buildConnectionSettings() {
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
            "Connection Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enable SSL Connection",
                "value": true,
                "checked": enableSslConnection,
              }
            ],
            value: [
              if (enableSslConnection)
                {
                  "label": "Enable SSL Connection",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              enableSslConnection = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDatabaseTestSection() {
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
            "Database Test",
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
                  label: "Test Connection",
                  size: bs.md,
                  onPressed: () {
                    _testDatabaseConnection();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Initialize Schema",
                  size: bs.md,
                  onPressed: () {
                    _initializeSchema();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStorageConfiguration() {
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
            "Cloud Storage Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Storage Provider",
            items: storageProviders,
            value: storageProvider,
            onChanged: (value, label) {
              storageProvider = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Bucket Name",
            value: bucketName,
            onChanged: (value) {
              bucketName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Access Key",
                  value: accessKey,
                  onChanged: (value) {
                    accessKey = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Secret Key",
                  value: secretKey,
                  obscureText: true,
                  onChanged: (value) {
                    secretKey = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Region",
            value: region,
            onChanged: (value) {
              region = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStorageSettings() {
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
            "Storage Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("Total Storage", "1.2 TB"),
          _buildInfoRow("Used Storage", "850 GB"),
          _buildInfoRow("Available Storage", "350 GB"),
          _buildInfoRow("Files Stored", "12,456"),
        ],
      ),
    );
  }

  Widget _buildStorageTestSection() {
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
            "Storage Test",
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
                  label: "Test Connection",
                  size: bs.md,
                  onPressed: () {
                    _testStorageConnection();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Upload Test File",
                  size: bs.md,
                  onPressed: () {
                    _uploadTestFile();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'success':
        return successColor;
      case 'inactive':
      case 'failed':
        return dangerColor;
      case 'warning':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showIntegrationConfig(Map<String, dynamic> integration) {
    // Navigate to integration configuration
  }

  void _syncIntegration(String integrationName) {
    ss("Syncing $integrationName...");
  }

  void _connectIntegration(String integrationName) {
    ss("Connecting to $integrationName...");
  }

  void _testApiConnection() {
    ss("Testing API connection...");
  }

  void _generateApiKey() {
    ss("New API key generated successfully");
  }

  void _testDatabaseConnection() {
    ss("Testing database connection...");
  }

  void _initializeSchema() {
    ss("Database schema initialized successfully");
  }

  void _testStorageConnection() {
    ss("Testing cloud storage connection...");
  }

  void _uploadTestFile() {
    ss("Test file uploaded successfully");
  }
}
