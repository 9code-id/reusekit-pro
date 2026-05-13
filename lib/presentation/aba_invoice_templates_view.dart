import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaInvoiceTemplatesView extends StatefulWidget {
  const AbaInvoiceTemplatesView({super.key});

  @override
  State<AbaInvoiceTemplatesView> createState() => _AbaInvoiceTemplatesViewState();
}

class _AbaInvoiceTemplatesViewState extends State<AbaInvoiceTemplatesView> {
  String searchQuery = "";
  String selectedCategory = "all";

  List<Map<String, dynamic>> templates = [
    {
      "id": "template_001",
      "name": "Standard Service Invoice",
      "description": "Basic template for service-based invoicing with hourly rates",
      "category": "service",
      "preview": "https://picsum.photos/300/400?random=1&keyword=invoice",
      "usageCount": 45,
      "lastUsed": "2024-12-10",
      "isDefault": true,
      "fields": [
        {"name": "Service Description", "type": "text", "required": true},
        {"name": "Hours Worked", "type": "number", "required": true},
        {"name": "Hourly Rate", "type": "currency", "required": true}
      ],
      "taxRate": 8.5,
      "paymentTerms": "Net 30",
      "createdDate": "2024-01-15"
    },
    {
      "id": "template_002",
      "name": "Product Sales Invoice",
      "description": "Template for product sales with quantity and unit pricing",
      "category": "product",
      "preview": "https://picsum.photos/300/400?random=2&keyword=invoice",
      "usageCount": 32,
      "lastUsed": "2024-12-08",
      "isDefault": false,
      "fields": [
        {"name": "Product Name", "type": "text", "required": true},
        {"name": "Quantity", "type": "number", "required": true},
        {"name": "Unit Price", "type": "currency", "required": true},
        {"name": "SKU", "type": "text", "required": false}
      ],
      "taxRate": 8.5,
      "paymentTerms": "Net 15",
      "createdDate": "2024-02-20"
    },
    {
      "id": "template_003",
      "name": "Consulting Invoice",
      "description": "Professional consulting services with project phases",
      "category": "consulting",
      "preview": "https://picsum.photos/300/400?random=3&keyword=invoice",
      "usageCount": 28,
      "lastUsed": "2024-12-12",
      "isDefault": false,
      "fields": [
        {"name": "Project Phase", "type": "text", "required": true},
        {"name": "Deliverables", "type": "text", "required": true},
        {"name": "Consultant Rate", "type": "currency", "required": true},
        {"name": "Timeline", "type": "text", "required": false}
      ],
      "taxRate": 10.0,
      "paymentTerms": "Net 30",
      "createdDate": "2024-03-10"
    },
    {
      "id": "template_004",
      "name": "Subscription Invoice",
      "description": "Recurring subscription billing template",
      "category": "subscription",
      "preview": "https://picsum.photos/300/400?random=4&keyword=invoice",
      "usageCount": 67,
      "lastUsed": "2024-12-14",
      "isDefault": false,
      "fields": [
        {"name": "Subscription Plan", "type": "text", "required": true},
        {"name": "Billing Period", "type": "text", "required": true},
        {"name": "Monthly Rate", "type": "currency", "required": true},
        {"name": "Users/Seats", "type": "number", "required": false}
      ],
      "taxRate": 8.5,
      "paymentTerms": "Due on Receipt",
      "createdDate": "2024-04-05"
    },
    {
      "id": "template_005",
      "name": "Freelance Creative Work",
      "description": "Template for creative services like design, writing, photography",
      "category": "creative",
      "preview": "https://picsum.photos/300/400?random=5&keyword=invoice",
      "usageCount": 19,
      "lastUsed": "2024-12-05",
      "isDefault": false,
      "fields": [
        {"name": "Creative Service", "type": "text", "required": true},
        {"name": "Project Scope", "type": "text", "required": true},
        {"name": "Fixed Rate", "type": "currency", "required": true},
        {"name": "Revision Rounds", "type": "number", "required": false}
      ],
      "taxRate": 7.5,
      "paymentTerms": "50% upfront, 50% on completion",
      "createdDate": "2024-05-12"
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Service", "value": "service"},
    {"label": "Product", "value": "product"},
    {"label": "Consulting", "value": "consulting"},
    {"label": "Subscription", "value": "subscription"},
    {"label": "Creative", "value": "creative"},
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return templates.where((template) {
      bool matchesSearch = searchQuery.isEmpty || 
          "${template["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${template["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || template["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'service': return primaryColor;
      case 'product': return successColor;
      case 'consulting': return warningColor;
      case 'subscription': return infoColor;
      case 'creative': return secondaryColor;
      default: return disabledBoldColor;
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    // Increment usage count
    template["usageCount"] = (template["usageCount"] as int) + 1;
    template["lastUsed"] = DateTime.now().toIso8601String().split('T')[0];
    setState(() {});
    
    ss("Template '${template["name"]}' loaded for new invoice");
    // Navigate to create invoice with template
  }

  void _duplicateTemplate(Map<String, dynamic> template) {
    Map<String, dynamic> duplicated = Map.from(template);
    duplicated["id"] = "template_${DateTime.now().millisecondsSinceEpoch}";
    duplicated["name"] = "${template["name"]} (Copy)";
    duplicated["usageCount"] = 0;
    duplicated["lastUsed"] = null;
    duplicated["isDefault"] = false;
    duplicated["createdDate"] = DateTime.now().toIso8601String().split('T')[0];
    
    templates.insert(0, duplicated);
    setState(() {});
    ss("Template duplicated successfully");
  }

  void _deleteTemplate(Map<String, dynamic> template) async {
    if (template["isDefault"] == true) {
      se("Cannot delete default template");
      return;
    }
    
    bool isConfirmed = await confirm("Are you sure you want to delete this template?");
    if (isConfirmed) {
      templates.remove(template);
      setState(() {});
      se("Template deleted");
    }
  }

  void _setAsDefault(Map<String, dynamic> template) {
    // Remove default status from all templates
    for (var temp in templates) {
      temp["isDefault"] = false;
    }
    
    // Set this template as default
    template["isDefault"] = true;
    setState(() {});
    ss("Template set as default");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new template
              ss("Create new template");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Templates imported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
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
                    label: "Search Templates",
                    value: searchQuery,
                    hint: "Search by name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Filter by Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Templates Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${templates.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Templates",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                          "${templates.where((t) => t["isDefault"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Default Template",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                          "${templates.fold(0, (sum, t) => sum + (t["usageCount"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Total Usage",
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
            ),

            // Templates Grid
            if (filteredTemplates.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.description,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No templates found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or create a new template",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 280,
                children: filteredTemplates.map((template) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: template["isDefault"] == true ? Border.all(
                        color: successColor,
                        width: 2,
                      ) : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Template Preview
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          child: Stack(
                            children: [
                              Container(
                                height: 120,
                                width: double.infinity,
                                child: Image.network(
                                  "${template["preview"]}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: disabledColor.withAlpha(30),
                                      child: Center(
                                        child: Icon(
                                          Icons.description,
                                          size: 40,
                                          color: disabledColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (template["isDefault"] == true) ...[
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "DEFAULT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              Positioned(
                                bottom: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor("${template["category"]}").withAlpha(200),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${template["category"]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Template Details
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${template["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Template Stats
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${template["usageCount"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Used",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: disabledOutlineBorderColor,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${template["taxRate"]}%",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: warningColor,
                                            ),
                                          ),
                                          Text(
                                            "Tax Rate",
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

                              // Payment Terms
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${template["paymentTerms"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              if (template["lastUsed"] != null) ...[
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Last used: ${DateTime.parse("${template["lastUsed"]}").dMMMy}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Use Template",
                                      size: bs.sm,
                                      onPressed: () => _useTemplate(template),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                          padding: EdgeInsets.all(spMd),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: spSm,
                                            children: [
                                              Text(
                                                "Template Actions",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.edit),
                                                title: Text("Edit Template"),
                                                onTap: () {
                                                  back();
                                                  ss("Edit template");
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.copy),
                                                title: Text("Duplicate Template"),
                                                onTap: () {
                                                  back();
                                                  _duplicateTemplate(template);
                                                },
                                              ),
                                              if (template["isDefault"] != true) ...[
                                                ListTile(
                                                  leading: Icon(Icons.star),
                                                  title: Text("Set as Default"),
                                                  onTap: () {
                                                    back();
                                                    _setAsDefault(template);
                                                  },
                                                ),
                                              ],
                                              ListTile(
                                                leading: Icon(Icons.download),
                                                title: Text("Export Template"),
                                                onTap: () {
                                                  back();
                                                  ss("Template exported");
                                                },
                                              ),
                                              if (template["isDefault"] != true) ...[
                                                ListTile(
                                                  leading: Icon(Icons.delete, color: dangerColor),
                                                  title: Text("Delete Template", style: TextStyle(color: dangerColor)),
                                                  onTap: () {
                                                    back();
                                                    _deleteTemplate(template);
                                                  },
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.more_vert,
                                      color: disabledBoldColor,
                                      size: 20,
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
                }).toList(),
              ),
            ],

            // Quick Actions
            Container(
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
                          label: "Create Template",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Create new template");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Import Template",
                          icon: Icons.upload,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("Import template");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
