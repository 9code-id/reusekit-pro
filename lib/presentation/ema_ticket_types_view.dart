import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketTypesView extends StatefulWidget {
  const EmaTicketTypesView({super.key});

  @override
  State<EmaTicketTypesView> createState() => _EmaTicketTypesViewState();
}

class _EmaTicketTypesViewState extends State<EmaTicketTypesView> {
  String selectedEvent = "concert_2025";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> events = [
    {"label": "Grand Concert 2025", "value": "concert_2025"},
    {"label": "Broadway Musical Night", "value": "broadway_2025"},
    {"label": "Jazz Festival 2025", "value": "jazz_festival"},
    {"label": "Comedy Show Live", "value": "comedy_show"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "VIP", "value": "vip"},
    {"label": "Premium", "value": "premium"},
    {"label": "Regular", "value": "regular"},
    {"label": "Economy", "value": "economy"},
  ];

  List<Map<String, dynamic>> ticketTypes = [
    {
      "id": "vip_package",
      "name": "VIP Experience Package",
      "category": "vip",
      "description": "Complete VIP experience with premium seating, meet & greet, and exclusive merchandise",
      "price": 500.0,
      "originalPrice": 650.0,
      "available": 25,
      "total": 50,
      "features": [
        "Front row premium seating",
        "Meet & greet with artists",
        "Exclusive VIP lounge access",
        "Complimentary drinks & snacks",
        "Limited edition merchandise",
        "Priority entry",
        "Dedicated VIP parking"
      ],
      "color": primaryColor,
      "icon": Icons.star,
      "duration": "Full event + 2 hours",
      "inclusions": "All fees included",
      "transferable": true,
      "refundable": true,
      "eventId": "concert_2025",
    },
    {
      "id": "premium_seating",
      "name": "Premium Seating",
      "category": "premium",
      "description": "Premium seats with excellent view and enhanced comfort",
      "price": 280.0,
      "originalPrice": 320.0,
      "available": 120,
      "total": 200,
      "features": [
        "Premium section seating",
        "Enhanced legroom",
        "Premium sound quality",
        "Complimentary program",
        "Priority restroom access",
        "Fast entry lane"
      ],
      "color": successColor,
      "icon": Icons.event_seat,
      "duration": "Full event",
      "inclusions": "Service fees included",
      "transferable": true,
      "refundable": false,
      "eventId": "concert_2025",
    },
    {
      "id": "regular_admission",
      "name": "Regular Admission",
      "category": "regular",
      "description": "Standard seating with great view and comfortable experience",
      "price": 150.0,
      "originalPrice": 180.0,
      "available": 450,
      "total": 600,
      "features": [
        "Regular section seating",
        "Standard comfort",
        "Good view of stage",
        "Access to all facilities",
        "Event program included"
      ],
      "color": infoColor,
      "icon": Icons.confirmation_number,
      "duration": "Full event",
      "inclusions": "Base price only",
      "transferable": false,
      "refundable": false,
      "eventId": "concert_2025",
    },
    {
      "id": "economy_seats",
      "name": "Economy Seats",
      "category": "economy",
      "description": "Budget-friendly seating option with access to full event",
      "price": 80.0,
      "originalPrice": 100.0,
      "available": 300,
      "total": 500,
      "features": [
        "Economy section seating",
        "Full event access",
        "Basic facilities access",
        "Digital program access"
      ],
      "color": warningColor,
      "icon": Icons.weekend,
      "duration": "Full event",
      "inclusions": "Base price only",
      "transferable": false,
      "refundable": false,
      "eventId": "concert_2025",
    },
    {
      "id": "early_bird_special",
      "name": "Early Bird Special",
      "category": "premium",
      "description": "Limited time offer with premium benefits at discounted price",
      "price": 220.0,
      "originalPrice": 280.0,
      "available": 50,
      "total": 100,
      "features": [
        "Premium section seating",
        "Early entry privilege",
        "Exclusive early bird merchandise",
        "Priority customer support",
        "Flexible date change option"
      ],
      "color": dangerColor,
      "icon": Icons.flash_on,
      "duration": "Full event",
      "inclusions": "Limited time offer",
      "transferable": true,
      "refundable": true,
      "eventId": "concert_2025",
      "isLimitedTime": true,
      "endDate": "2025-06-30",
    },
    {
      "id": "group_package",
      "name": "Group Package (4+ people)",
      "category": "regular",
      "description": "Special pricing for groups of 4 or more people",
      "price": 120.0,
      "originalPrice": 150.0,
      "available": 200,
      "total": 300,
      "features": [
        "Group seating arrangement",
        "Bulk discount pricing",
        "Group coordinator support",
        "Flexible payment options",
        "Group photo opportunity"
      ],
      "color": infoColor,
      "icon": Icons.groups,
      "duration": "Full event",
      "inclusions": "Minimum 4 tickets",
      "transferable": false,
      "refundable": false,
      "eventId": "concert_2025",
      "isGroupPackage": true,
      "minQuantity": 4,
    },
  ];

  List<Map<String, dynamic>> getFilteredTicketTypes() {
    return ticketTypes.where((ticket) {
      bool matchesEvent = ticket["eventId"] == selectedEvent;
      bool matchesCategory = selectedCategory == "all" || ticket["category"] == selectedCategory;
      return matchesEvent && matchesCategory;
    }).toList();
  }

  double getDiscountPercentage(double price, double originalPrice) {
    return ((originalPrice - price) / originalPrice * 100);
  }

  @override
  Widget build(BuildContext context) {
    final filteredTickets = getFilteredTicketTypes();

    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Types"),
        actions: [
          QButton(
            icon: Icons.compare,
            size: bs.sm,
            onPressed: () {
              //navigateTo('TicketComparisonView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Event",
                    items: events,
                    value: selectedEvent,
                    onChanged: (value, label) {
                      selectedEvent = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Event Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    events.firstWhere((e) => e["value"] == selectedEvent)["label"],
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.event, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "July 15, 2025 • 7:30 PM",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Madison Square Garden, New York",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Ticket Types Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Available Ticket Types",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${filteredTickets.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Types Available",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${filteredTickets.fold(0, (sum, ticket) => sum + (ticket["available"] as int))}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Tickets Available",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "\$${filteredTickets.map((t) => t["price"] as double).reduce((a, b) => a < b ? a : b).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Starting From",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Ticket Types List
            Text(
              "Choose Your Ticket Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...filteredTickets.map((ticket) {
              double availabilityRate = (ticket["available"] as int) / (ticket["total"] as int);
              double discount = getDiscountPercentage(ticket["price"] as double, ticket["originalPrice"] as double);
              bool isLowAvailability = availabilityRate < 0.2;
              bool hasDiscount = discount > 0;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isLowAvailability ? dangerColor : disabledOutlineBorderColor,
                    width: isLowAvailability ? 2 : 1,
                  ),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    // Header with badges
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (ticket["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: ticket["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  ticket["icon"],
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${ticket["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${ticket["description"]}",
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

                          // Badges
                          Row(
                            spacing: spXs,
                            children: [
                              if (hasDiscount) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "${discount.toInt()}% OFF",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              if (ticket["isLimitedTime"] == true) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "LIMITED TIME",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              if (ticket["isGroupPackage"] == true) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "GROUP DEAL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              if (isLowAvailability) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "ALMOST SOLD OUT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        spacing: spMd,
                        children: [
                          // Price and Availability
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      spacing: spXs,
                                      children: [
                                        Text(
                                          "\$${(ticket["price"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: fsH4,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (hasDiscount) ...[
                                          Text(
                                            "\$${(ticket["originalPrice"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      "${ticket["inclusions"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${ticket["available"]} of ${ticket["total"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isLowAvailability ? dangerColor : successColor,
                                    ),
                                  ),
                                  Text(
                                    "available",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Availability Bar
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 1 - availabilityRate,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isLowAvailability ? dangerColor : 
                                         availabilityRate < 0.5 ? warningColor : successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),

                          // Features
                          Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Includes:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              ...(ticket["features"] as List).take(3).map((feature) {
                                return Row(
                                  spacing: spXs,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: successColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "$feature",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              if ((ticket["features"] as List).length > 3) ...[
                                Text(
                                  "and ${(ticket["features"] as List).length - 3} more...",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),

                          // Ticket Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Duration: ${ticket["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      ticket["transferable"] ? Icons.swap_horiz : Icons.block,
                                      size: 16,
                                      color: ticket["transferable"] ? successColor : dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      ticket["transferable"] ? "Transferable" : "Non-transferable",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      ticket["refundable"] ? Icons.currency_exchange : Icons.block,
                                      size: 16,
                                      color: ticket["refundable"] ? successColor : dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      ticket["refundable"] ? "Refundable" : "Non-refundable",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Actions
                          Row(
                            spacing: spSm,
                            children: [
                              Expanded(
                                child: QButton(
                                  label: ticket["available"] == 0 ? "Sold Out" : "Select Tickets",
                                  size: bs.sm,
                                  onPressed: ticket["available"] == 0 ? null : () {
                                    //navigateTo('EmaTicketPricingView')
                                  },
                                ),
                              ),
                              QButton(
                                icon: Icons.info,
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('TicketDetailsView')
                                },
                              ),
                              QButton(
                                icon: Icons.favorite_border,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Added to wishlist");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
