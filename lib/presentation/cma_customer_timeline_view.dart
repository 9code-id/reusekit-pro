import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerTimelineView extends StatefulWidget {
  const CmaCustomerTimelineView({super.key});

  @override
  State<CmaCustomerTimelineView> createState() => _CmaCustomerTimelineViewState();
}

class _CmaCustomerTimelineViewState extends State<CmaCustomerTimelineView> {
  String selectedCustomer = "customer_001";
  String selectedTimeframe = "30d";
  bool showOnlyMajorEvents = false;

  List<Map<String, dynamic>> customers = [
    {"label": "Tech Solutions Inc.", "value": "customer_001"},
    {"label": "Global Manufacturing Ltd.", "value": "customer_002"},
    {"label": "Retail Chain Corp", "value": "customer_003"},
    {"label": "Healthcare Partners", "value": "customer_004"},
    {"label": "Financial Services Group", "value": "customer_005"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "Last 6 Months", "value": "6m"},
    {"label": "Last Year", "value": "1y"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> timelineEvents = [
    {
      "id": "1",
      "customerId": "customer_001",
      "type": "milestone",
      "title": "Contract Renewed",
      "description": "3-year enterprise contract renewed with 25% increase in value",
      "timestamp": "2024-12-15T10:00:00Z",
      "importance": "high",
      "amount": 750000.0,
      "performedBy": "Account Manager",
      "relatedTo": "Contract #CNT-2024-015",
      "outcome": "positive",
    },
    {
      "id": "2",
      "customerId": "customer_001",
      "type": "order",
      "title": "Large Order Placed",
      "description": "Ordered additional 50 enterprise licenses for Q1 2025 rollout",
      "timestamp": "2024-12-14T14:30:00Z",
      "importance": "medium",
      "amount": 125000.0,
      "performedBy": "Procurement Team",
      "relatedTo": "Order #ORD-2024-1214",
      "outcome": "positive",
    },
    {
      "id": "3",
      "customerId": "customer_001",
      "type": "communication",
      "title": "Quarterly Business Review",
      "description": "Comprehensive review of service performance and future planning",
      "timestamp": "2024-12-12T15:00:00Z",
      "importance": "high",
      "amount": 0.0,
      "performedBy": "Senior Account Manager",
      "relatedTo": "QBR Q4 2024",
      "outcome": "positive",
    },
    {
      "id": "4",
      "customerId": "customer_001",
      "type": "issue",
      "title": "Critical System Outage",
      "description": "Production system downtime resolved within 2 hours",
      "timestamp": "2024-12-10T08:30:00Z",
      "importance": "high",
      "amount": 0.0,
      "performedBy": "Technical Support",
      "relatedTo": "Incident #INC-2024-0892",
      "outcome": "resolved",
    },
    {
      "id": "5",
      "customerId": "customer_001",
      "type": "payment",
      "title": "Payment Received",
      "description": "Invoice payment received on time with early payment discount",
      "timestamp": "2024-12-08T11:20:00Z",
      "importance": "medium",
      "amount": 85000.0,
      "performedBy": "Finance Department",
      "relatedTo": "Invoice #INV-2024-1205",
      "outcome": "positive",
    },
    {
      "id": "6",
      "customerId": "customer_001",
      "type": "meeting",
      "title": "Strategic Planning Session",
      "description": "Discussed 2025 digital transformation roadmap and requirements",
      "timestamp": "2024-12-05T16:00:00Z",
      "importance": "high",
      "amount": 0.0,
      "performedBy": "Solutions Architect",
      "relatedTo": "Project Planning",
      "outcome": "positive",
    },
    {
      "id": "7",
      "customerId": "customer_001",
      "type": "communication",
      "title": "Training Session Completed",
      "description": "Staff training on new features and best practices",
      "timestamp": "2024-12-03T10:00:00Z",
      "importance": "medium",
      "amount": 0.0,
      "performedBy": "Training Team",
      "relatedTo": "Training Program",
      "outcome": "positive",
    },
    {
      "id": "8",
      "customerId": "customer_001",
      "type": "upgrade",
      "title": "System Upgrade Completed",
      "description": "Successfully upgraded to latest version with enhanced security",
      "timestamp": "2024-11-28T09:00:00Z",
      "importance": "high",
      "amount": 15000.0,
      "performedBy": "Implementation Team",
      "relatedTo": "Upgrade Project",
      "outcome": "positive",
    },
    {
      "id": "9",
      "customerId": "customer_001",
      "type": "milestone",
      "title": "Customer Onboarding Anniversary",
      "description": "Celebrating 5 years of successful partnership",
      "timestamp": "2024-11-15T00:00:00Z",
      "importance": "high",
      "amount": 0.0,
      "performedBy": "Account Team",
      "relatedTo": "Partnership Milestone",
      "outcome": "positive",
    },
    {
      "id": "10",
      "customerId": "customer_001",
      "type": "issue",
      "title": "Service Complaint",
      "description": "Customer reported slow response times, escalated and resolved",
      "timestamp": "2024-11-10T13:45:00Z",
      "importance": "medium",
      "amount": 0.0,
      "performedBy": "Customer Success",
      "relatedTo": "Case #CS-2024-0156",
      "outcome": "resolved",
    },
  ];

  List<Map<String, dynamic>> get filteredTimeline {
    List<Map<String, dynamic>> filtered = timelineEvents.where((event) => 
      event["customerId"] == selectedCustomer
    ).toList();

    if (showOnlyMajorEvents) {
      filtered = filtered.where((event) => event["importance"] == "high").toList();
    }

    if (selectedTimeframe != "all") {
      DateTime now = DateTime.now();
      DateTime filterDate;
      
      switch (selectedTimeframe) {
        case "7d":
          filterDate = now.subtract(Duration(days: 7));
          break;
        case "30d":
          filterDate = now.subtract(Duration(days: 30));
          break;
        case "90d":
          filterDate = now.subtract(Duration(days: 90));
          break;
        case "6m":
          filterDate = now.subtract(Duration(days: 180));
          break;
        case "1y":
          filterDate = now.subtract(Duration(days: 365));
          break;
        default:
          filterDate = DateTime(2000);
      }
      
      filtered = filtered.where((event) {
        DateTime eventDate = DateTime.parse(event["timestamp"]);
        return eventDate.isAfter(filterDate);
      }).toList();
    }
    
    return filtered..sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case "milestone": return successColor;
      case "order": return primaryColor;
      case "payment": return infoColor;
      case "communication": return secondaryColor;
      case "meeting": return warningColor;
      case "issue": return dangerColor;
      case "upgrade": return primaryColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getEventTypeIcon(String type) {
    switch (type) {
      case "milestone": return Icons.flag;
      case "order": return Icons.shopping_cart;
      case "payment": return Icons.payment;
      case "communication": return Icons.message;
      case "meeting": return Icons.meeting_room;
      case "issue": return Icons.warning;
      case "upgrade": return Icons.upgrade;
      default: return Icons.event;
    }
  }

  String _getEventTypeLabel(String type) {
    switch (type) {
      case "milestone": return "Milestone";
      case "order": return "Order";
      case "payment": return "Payment";
      case "communication": return "Communication";
      case "meeting": return "Meeting";
      case "issue": return "Issue";
      case "upgrade": return "Upgrade";
      default: return "Event";
    }
  }

  Color _getImportanceColor(String importance) {
    switch (importance) {
      case "high": return dangerColor;
      case "medium": return warningColor;
      case "low": return infoColor;
      default: return disabledBoldColor;
    }
  }

  Color _getOutcomeColor(String outcome) {
    switch (outcome) {
      case "positive": return successColor;
      case "negative": return dangerColor;
      case "resolved": return infoColor;
      case "pending": return warningColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> timeline = filteredTimeline;
    Map<String, DateTime> dateGroups = {};
    
    // Group events by date
    for (var event in timeline) {
      DateTime eventDate = DateTime.parse(event["timestamp"]);
      String dateKey = "${eventDate.year}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}";
      dateGroups[dateKey] = eventDate;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Timeline"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Visualize customer journey with chronological timeline of key events and interactions",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QDropdownField(
                    label: "Select Customer",
                    items: customers,
                    value: selectedCustomer,
                    onChanged: (value, label) {
                      selectedCustomer = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframes,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QSwitch(
              label: "Display Options",
              items: [
                {
                  "label": "Show only major events",
                  "value": true,
                  "checked": showOnlyMajorEvents,
                }
              ],
              value: [
                if (showOnlyMajorEvents)
                  {
                    "label": "Show only major events",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  showOnlyMajorEvents = values.isNotEmpty;
                });
              },
            ),

            QHorizontalScroll(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${timeline.length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Events",
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${timeline.where((e) => e["importance"] == "high").length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Major Events",
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${((timeline.where((e) => (e["amount"] as double) > 0).map((e) => e["amount"] as double).fold(0.0, (a, b) => a + b)) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Value",
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

            // Timeline visualization
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: timeline.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> event = entry.value;
                  bool isLast = index == timeline.length - 1;
                  
                  Color typeColor = _getEventTypeColor(event["type"]);
                  Color importanceColor = _getImportanceColor(event["importance"]);
                  Color outcomeColor = _getOutcomeColor(event["outcome"]);
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline line and dot
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: typeColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              _getEventTypeIcon(event["type"]),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 60,
                              color: disabledColor.withAlpha(100),
                            ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      
                      // Event content
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: typeColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(color: typeColor.withAlpha(100)),
                                    ),
                                    child: Text(
                                      _getEventTypeLabel(event["type"]),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: typeColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: importanceColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["importance"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: importanceColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${DateTime.parse(event["timestamp"]).dMMMy} ${TimeOfDay.fromDateTime(DateTime.parse(event["timestamp"])).kkmm}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),

                              Row(
                                children: [
                                  if ((event["amount"] as double) > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "\$${(event["amount"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: outcomeColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${event["outcome"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: outcomeColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${event["performedBy"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (event["relatedTo"] != null) ...[
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.link,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${event["relatedTo"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            if (timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.timeline_outlined,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No timeline events found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or select a different timeframe",
                      textAlign: TextAlign.center,
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
      ),
    );
  }
}
