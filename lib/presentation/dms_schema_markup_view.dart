import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSchemaMarkupView extends StatefulWidget {
  const DmsSchemaMarkupView({super.key});

  @override
  State<DmsSchemaMarkupView> createState() => _DmsSchemaMarkupViewState();
}

class _DmsSchemaMarkupViewState extends State<DmsSchemaMarkupView> {
  String selectedSchemaType = "all_types";
  String selectedStatus = "all_status";
  int selectedFilter = 0;

  List<Map<String, dynamic>> schemaTypeOptions = [
    {"label": "All Types", "value": "all_types"},
    {"label": "Article", "value": "article"},
    {"label": "Product", "value": "product"},
    {"label": "Organization", "value": "organization"},
    {"label": "Local Business", "value": "local_business"},
    {"label": "FAQ", "value": "faq"},
    {"label": "How-to", "value": "how_to"},
    {"label": "Recipe", "value": "recipe"},
    {"label": "Event", "value": "event"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all_status"},
    {"label": "Missing", "value": "missing"},
    {"label": "Invalid", "value": "invalid"},
    {"label": "Valid", "value": "valid"},
    {"label": "Warning", "value": "warning"},
  ];

  List<Map<String, dynamic>> schemaData = [
    {
      "url": "/blog/digital-marketing-guide",
      "title": "Complete Digital Marketing Guide 2024",
      "page_type": "blog_post",
      "recommended_schemas": ["Article", "How-to", "FAQ"],
      "current_schemas": [
        {
          "type": "Article",
          "status": "valid",
          "properties": ["headline", "author", "datePublished", "image"],
          "missing_properties": [],
          "errors": [],
          "rich_results": ["Article rich result eligible"],
        }
      ],
      "missing_schemas": [
        {
          "type": "How-to",
          "importance": "high",
          "reason": "Content contains step-by-step instructions",
          "properties": ["name", "description", "step", "totalTime"],
        },
        {
          "type": "FAQ",
          "importance": "medium",
          "reason": "Content has Q&A sections",
          "properties": ["question", "acceptedAnswer"],
        }
      ],
      "priority": "medium",
      "search_visibility": 78,
      "click_through_rate": 3.2,
      "potential_improvement": "+25% CTR",
    },
    {
      "url": "/products/marketing-software",
      "title": "Marketing Automation Software Suite",
      "page_type": "product",
      "recommended_schemas": ["Product", "SoftwareApplication", "AggregateRating"],
      "current_schemas": [],
      "missing_schemas": [
        {
          "type": "Product",
          "importance": "critical",
          "reason": "Essential for e-commerce visibility",
          "properties": ["name", "description", "price", "availability", "brand"],
        },
        {
          "type": "AggregateRating",
          "importance": "high",
          "reason": "Shows star ratings in search results",
          "properties": ["ratingValue", "reviewCount", "bestRating"],
        },
        {
          "type": "SoftwareApplication",
          "importance": "medium",
          "reason": "Specific to software products",
          "properties": ["applicationCategory", "operatingSystem", "price"],
        }
      ],
      "priority": "critical",
      "search_visibility": 45,
      "click_through_rate": 1.8,
      "potential_improvement": "+150% CTR",
    },
    {
      "url": "/services/seo-optimization",
      "title": "Professional SEO Optimization Services",
      "page_type": "service",
      "recommended_schemas": ["Service", "LocalBusiness", "AggregateRating"],
      "current_schemas": [
        {
          "type": "Organization",
          "status": "warning",
          "properties": ["name", "url", "logo"],
          "missing_properties": ["address", "telephone", "sameAs"],
          "errors": ["Missing contact information"],
          "rich_results": ["Limited organization display"],
        }
      ],
      "missing_schemas": [
        {
          "type": "Service",
          "importance": "high",
          "reason": "Improves service-based search visibility",
          "properties": ["name", "description", "provider", "areaServed"],
        },
        {
          "type": "LocalBusiness",
          "importance": "high",
          "reason": "Essential for local SEO",
          "properties": ["address", "telephone", "openingHours", "geo"],
        }
      ],
      "priority": "high",
      "search_visibility": 62,
      "click_through_rate": 2.4,
      "potential_improvement": "+45% CTR",
    },
    {
      "url": "/about-us",
      "title": "About Our Digital Marketing Agency",
      "page_type": "about",
      "recommended_schemas": ["Organization", "LocalBusiness"],
      "current_schemas": [],
      "missing_schemas": [
        {
          "type": "Organization",
          "importance": "critical",
          "reason": "Establishes business entity in search",
          "properties": ["name", "url", "logo", "address", "telephone", "sameAs"],
        },
        {
          "type": "LocalBusiness",
          "importance": "high",
          "reason": "Critical for local search presence",
          "properties": ["address", "telephone", "openingHours", "geo", "priceRange"],
        }
      ],
      "priority": "critical",
      "search_visibility": 35,
      "click_through_rate": 1.2,
      "potential_improvement": "+200% CTR",
    },
    {
      "url": "/blog/email-marketing-tips",
      "title": "10 Email Marketing Tips That Actually Work",
      "page_type": "blog_post",
      "recommended_schemas": ["Article", "How-to"],
      "current_schemas": [
        {
          "type": "Article",
          "status": "invalid",
          "properties": ["headline", "author"],
          "missing_properties": ["datePublished", "image", "publisher"],
          "errors": ["Missing required datePublished property", "Missing image property"],
          "rich_results": ["Not eligible for rich results"],
        }
      ],
      "missing_schemas": [
        {
          "type": "How-to",
          "importance": "medium",
          "reason": "Content provides actionable tips",
          "properties": ["name", "description", "step", "tool", "supply"],
        }
      ],
      "priority": "high",
      "search_visibility": 58,
      "click_through_rate": 2.1,
      "potential_improvement": "+60% CTR",
    },
    {
      "url": "/events/marketing-webinar",
      "title": "Advanced Marketing Strategies Webinar",
      "page_type": "event",
      "recommended_schemas": ["Event"],
      "current_schemas": [
        {
          "type": "Event",
          "status": "valid",
          "properties": ["name", "startDate", "location", "description", "organizer"],
          "missing_properties": [],
          "errors": [],
          "rich_results": ["Event rich snippet eligible"],
        }
      ],
      "missing_schemas": [],
      "priority": "low",
      "search_visibility": 85,
      "click_through_rate": 4.5,
      "potential_improvement": "+5% CTR",
    },
  ];

  List<Map<String, dynamic>> get filteredSchemas {
    List<Map<String, dynamic>> filtered = schemaData;

    if (selectedSchemaType != "all_types") {
      filtered = filtered.where((item) {
        // Check if any recommended or current schema matches the selected type
        bool hasRecommended = (item["recommended_schemas"] as List).any((schema) => 
            schema.toString().toLowerCase() == selectedSchemaType.toLowerCase());
        bool hasCurrent = (item["current_schemas"] as List).any((schema) => 
            (schema as Map)["type"].toString().toLowerCase() == selectedSchemaType.toLowerCase());
        return hasRecommended || hasCurrent;
      }).toList();
    }

    if (selectedStatus != "all_status") {
      filtered = filtered.where((item) {
        switch (selectedStatus) {
          case "missing":
            return (item["current_schemas"] as List).isEmpty || (item["missing_schemas"] as List).isNotEmpty;
          case "invalid":
            return (item["current_schemas"] as List).any((schema) => 
                (schema as Map)["status"] == "invalid");
          case "valid":
            return (item["current_schemas"] as List).any((schema) => 
                (schema as Map)["status"] == "valid");
          case "warning":
            return (item["current_schemas"] as List).any((schema) => 
                (schema as Map)["status"] == "warning");
          default:
            return true;
        }
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["priority"] == "critical").toList();
        break;
      case 2: // Missing Schemas
        filtered = filtered.where((item) => (item["missing_schemas"] as List).isNotEmpty).toList();
        break;
      case 3: // Valid Schemas
        filtered = filtered.where((item) => 
            (item["current_schemas"] as List).any((schema) => 
                (schema as Map)["status"] == "valid")).toList();
        break;
    }

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSchemaStatusColor(String status) {
    switch (status) {
      case "valid":
        return successColor;
      case "warning":
        return warningColor;
      case "invalid":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImportanceColor(String importance) {
    switch (importance) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schema Markup"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              // Auto-generate schema markup
            },
          ),
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              // Schema validator
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export schema report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Schema Type",
                    items: schemaTypeOptions,
                    value: selectedSchemaType,
                    onChanged: (value, label) {
                      selectedSchemaType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
              ],
            ),
            SizedBox(height: spMd),

            // Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Pages", "value": 0},
                {"label": "Critical", "value": 1},
                {"label": "Missing Schemas", "value": 2},
                {"label": "Valid Schemas", "value": 3},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Summary Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Pages",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${schemaData.length}",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Missing Schemas",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${schemaData.where((s) => (s["missing_schemas"] as List).isNotEmpty).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Valid Schemas",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${schemaData.where((s) => (s["current_schemas"] as List).any((cs) => (cs as Map)["status"] == "valid")).length}",
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
            SizedBox(height: spMd),

            // Schema Analysis
            Text(
              "Schema Markup Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredSchemas.map((schemaItem) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(schemaItem["priority"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${schemaItem["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${schemaItem["url"]}",
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
                            color: _getPriorityColor(schemaItem["priority"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${schemaItem["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(schemaItem["priority"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Performance Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Search Visibility",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${schemaItem["search_visibility"]}%",
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
                                "CTR",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${schemaItem["click_through_rate"]}%",
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
                                "Potential",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${schemaItem["potential_improvement"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Current Schemas
                    if ((schemaItem["current_schemas"] as List).isNotEmpty) ...[
                      Text(
                        "Current Schema Markup:",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(schemaItem["current_schemas"] as List).map((schema) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getSchemaStatusColor(schema["status"] as String).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getSchemaStatusColor(schema["status"] as String).withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${schema["type"]} Schema",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getSchemaStatusColor(schema["status"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${schema["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getSchemaStatusColor(schema["status"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if ((schema["missing_properties"] as List).isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Text(
                                  "Missing: ${(schema["missing_properties"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                              if ((schema["errors"] as List).isNotEmpty) ...[
                                SizedBox(height: spXs),
                                ...(schema["errors"] as List).map((error) {
                                  return Text(
                                    "⚠ $error",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: dangerColor,
                                    ),
                                  );
                                }).toList(),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: spSm),
                    ],

                    // Missing Schemas
                    if ((schemaItem["missing_schemas"] as List).isNotEmpty) ...[
                      Text(
                        "Recommended Schema Markup:",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(schemaItem["missing_schemas"] as List).map((missing) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getImportanceColor(missing["importance"] as String).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getImportanceColor(missing["importance"] as String).withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${missing["type"]} Schema",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getImportanceColor(missing["importance"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${missing["importance"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getImportanceColor(missing["importance"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${missing["reason"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                "Properties: ${(missing["properties"] as List).join(", ")}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: spSm),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Generate Schema",
                            size: bs.sm,
                            onPressed: () {
                              // Generate schema markup
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.code,
                          size: bs.sm,
                          onPressed: () {
                            // View schema code
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.preview,
                          size: bs.sm,
                          onPressed: () {
                            // Test schema markup
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
