import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmApiManagementView extends StatefulWidget {
  const CrmApiManagementView({super.key});

  @override
  State<CrmApiManagementView> createState() => _CrmApiManagementViewState();
}

class _CrmApiManagementViewState extends State<CrmApiManagementView> {
  final formKey = GlobalKey<FormState>();
  String apiKeyName = "";
  String selectedPermissions = "Read Only";
  String apiEndpoint = "";
  String apiKey = "";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> permissionOptions = [
    {"label": "Read Only", "value": "read_only"},
    {"label": "Read & Write", "value": "read_write"},
    {"label": "Full Access", "value": "full_access"},
    {"label": "Custom", "value": "custom"},
  ];

  List<Map<String, dynamic>> apiKeys = [
    {
      "id": "1",
      "name": "Mobile App Integration",
      "key": "sk_live_51H7z2bKZvKU7k...",
      "permissions": "Read & Write",
      "status": "active",
      "created": "2024-11-15",
      "lastUsed": "2024-12-19 14:30",
      "requests": 15420,
      "usage": 78.5,
    },
    {
      "id": "2",
      "name": "Website Contact Forms",
      "key": "sk_live_51H8x3cLXvLV8m...",
      "permissions": "Read Only",
      "status": "active",
      "created": "2024-10-22",
      "lastUsed": "2024-12-19 13:45",
      "requests": 8760,
      "usage": 43.2,
    },
    {
      "id": "3",
      "name": "Third Party Analytics",
      "key": "sk_live_51H9y4dMYwMW9n...",
      "permissions": "Read Only",
      "status": "inactive",
      "created": "2024-09-08",
      "lastUsed": "2024-11-30 10:15",
      "requests": 2340,
      "usage": 12.8,
    },
    {
      "id": "4",
      "name": "Email Marketing Tool",
      "key": "sk_live_51H0z5eNZxNX0o...",
      "permissions": "Full Access",
      "status": "active",
      "created": "2024-12-01",
      "lastUsed": "2024-12-19 12:20",
      "requests": 25680,
      "usage": 91.3,
    },
  ];

  List<Map<String, dynamic>> endpoints = [
    {
      "method": "GET",
      "path": "/api/v1/contacts",
      "description": "Retrieve all contacts",
      "parameters": ["limit", "offset", "search"],
      "example": "curl -X GET 'https://api.yourcrm.com/v1/contacts' -H 'Authorization: Bearer YOUR_API_KEY'",
    },
    {
      "method": "POST",
      "path": "/api/v1/contacts",
      "description": "Create a new contact",
      "parameters": ["name", "email", "phone", "company"],
      "example": "curl -X POST 'https://api.yourcrm.com/v1/contacts' -H 'Authorization: Bearer YOUR_API_KEY' -d '{\"name\":\"John Doe\",\"email\":\"john@example.com\"}'",
    },
    {
      "method": "GET",
      "path": "/api/v1/deals",
      "description": "Retrieve all deals",
      "parameters": ["status", "stage", "contact_id"],
      "example": "curl -X GET 'https://api.yourcrm.com/v1/deals' -H 'Authorization: Bearer YOUR_API_KEY'",
    },
    {
      "method": "PUT",
      "path": "/api/v1/deals/{id}",
      "description": "Update a deal",
      "parameters": ["name", "value", "stage", "contact_id"],
      "example": "curl -X PUT 'https://api.yourcrm.com/v1/deals/123' -H 'Authorization: Bearer YOUR_API_KEY' -d '{\"stage\":\"closed_won\"}'",
    },
  ];

  int currentTab = 0;

  List<Map<String, dynamic>> get filteredApiKeys {
    return apiKeys.where((key) {
      bool matchesSearch = searchQuery.isEmpty ||
          (key["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = !showActiveOnly || key["status"] == "active";
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return dangerColor;
      case "limited":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUsageColor(double usage) {
    if (usage >= 90) return dangerColor;
    if (usage >= 70) return warningColor;
    return successColor;
  }

  Color _getMethodColor(String method) {
    switch (method) {
      case "GET":
        return successColor;
      case "POST":
        return infoColor;
      case "PUT":
        return warningColor;
      case "DELETE":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _generateApiKey() {
    if (formKey.currentState!.validate()) {
      String newKey = "sk_live_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}...";
      apiKeys.add({
        "id": "${apiKeys.length + 1}",
        "name": apiKeyName,
        "key": newKey,
        "permissions": selectedPermissions,
        "status": "active",
        "created": "2024-12-19",
        "lastUsed": null,
        "requests": 0,
        "usage": 0.0,
      });
      setState(() {});
      ss("API key generated successfully");
      apiKeyName = "";
      currentTab = 0;
    }
  }

  void _revokeApiKey(String id) async {
    bool isConfirmed = await confirm("Are you sure you want to revoke this API key?");
    if (isConfirmed) {
      int index = apiKeys.indexWhere((k) => k["id"] == id);
      if (index != -1) {
        apiKeys[index]["status"] = "inactive";
        setState(() {});
        sw("API key has been revoked");
      }
    }
  }

  void _reactivateApiKey(String id) {
    int index = apiKeys.indexWhere((k) => k["id"] == id);
    if (index != -1) {
      apiKeys[index]["status"] = "active";
      setState(() {});
      ss("API key has been reactivated");
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.vpn_key, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total API Keys",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${apiKeys.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Active Keys",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${apiKeys.where((k) => k["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.api, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "API Requests",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "52.2K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Usage Rate",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "76.8%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "API Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Base URL: https://api.yourcrm.com",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "API Version: v1",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Rate Limit: 1000 requests per hour",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Authentication: Bearer Token",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApiKeysTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search API Keys",
                  value: searchQuery,
                  hint: "Search by name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  currentTab = 3;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Active Only",
                      "value": true,
                      "checked": showActiveOnly,
                    }
                  ],
                  value: [
                    if (showActiveOnly)
                      {
                        "label": "Show Active Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showActiveOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "API Keys (${filteredApiKeys.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: filteredApiKeys.map((apiKeyData) {
                    bool isActive = apiKeyData["status"] == "active";
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: !isActive 
                            ? Border.all(color: dangerColor.withAlpha(30))
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${apiKeyData["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${apiKeyData["key"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'monospace',
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(apiKeyData["status"] as String).withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${apiKeyData["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(apiKeyData["status"] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${apiKeyData["permissions"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Created: ${apiKeyData["created"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${apiKeyData["requests"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Requests",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${(apiKeyData["usage"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _getUsageColor(apiKeyData["usage"] as double),
                                      ),
                                    ),
                                    Text(
                                      "Usage",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (apiKeyData["lastUsed"] != null)
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Recently",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "Last Used",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Never",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "Last Used",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (isActive)
                                QButton(
                                  label: "Revoke",
                                  size: bs.sm,
                                  onPressed: () => _revokeApiKey(apiKeyData["id"] as String),
                                )
                              else
                                QButton(
                                  label: "Reactivate",
                                  size: bs.sm,
                                  onPressed: () => _reactivateApiKey(apiKeyData["id"] as String),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.api, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "API Documentation",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Use our REST API to integrate with your applications. All requests require authentication via API key.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Endpoints",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: endpoints.map((endpoint) {
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
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getMethodColor(endpoint["method"] as String).withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${endpoint["method"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _getMethodColor(endpoint["method"] as String),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${endpoint["path"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${endpoint["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Parameters:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (endpoint["parameters"] as List<String>).map((param) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  param,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Example:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${endpoint["example"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: Colors.green.shade300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "API Key Name",
              value: apiKeyName,
              hint: "Enter descriptive name for this API key",
              validator: Validator.required,
              onChanged: (value) {
                apiKeyName = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Permissions",
              items: permissionOptions,
              value: selectedPermissions,
              onChanged: (value, label) {
                selectedPermissions = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Security Notice",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Store API keys securely and never expose them in client-side code\n• Use the minimum required permissions for your use case\n• Regularly rotate API keys for better security\n• Monitor API usage for suspicious activity",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Permission Levels",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Read Only: View contacts, deals, and reports\n• Read & Write: Create and update records\n• Full Access: All operations including deletions\n• Custom: Specific endpoint permissions",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Generate API Key",
                size: bs.md,
                onPressed: _generateApiKey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "API Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "API Keys", icon: Icon(Icons.vpn_key)),
        Tab(text: "Docs", icon: Icon(Icons.description)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildApiKeysTab(),
        _buildDocumentationTab(),
        _buildCreateTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
