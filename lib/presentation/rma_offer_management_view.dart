import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOfferManagementView extends StatefulWidget {
  const RmaOfferManagementView({super.key});

  @override
  State<RmaOfferManagementView> createState() => _RmaOfferManagementViewState();
}

class _RmaOfferManagementViewState extends State<RmaOfferManagementView> {
  String selectedFilter = "All";
  String selectedProperty = "All Properties";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> offers = [
    {
      "id": "1",
      "property": "Modern Downtown Condo",
      "address": "123 Main Street, Downtown",
      "listingPrice": 450000,
      "offerAmount": 425000,
      "buyer": "John Anderson",
      "buyerAgent": "Michael Davis",
      "submittedDate": "2024-11-10",
      "expirationDate": "2024-11-17",
      "status": "Pending",
      "earnestMoney": 10000,
      "financingType": "Conventional",
      "contingencies": ["Inspection", "Financing", "Appraisal"],
      "closingDate": "2024-12-15",
      "propertyImage": "https://picsum.photos/100/80?random=1&keyword=condo",
      "notes": "Buyer is pre-approved and ready to close quickly",
      "priority": "High"
    },
    {
      "id": "2",
      "property": "Luxury Family Home",
      "address": "456 Oak Avenue, Suburbs",
      "listingPrice": 750000,
      "offerAmount": 740000,
      "buyer": "Sarah Williams",
      "buyerAgent": "Jennifer Clark",
      "submittedDate": "2024-11-12",
      "expirationDate": "2024-11-19",
      "status": "Accepted",
      "earnestMoney": 15000,
      "financingType": "FHA",
      "contingencies": ["Inspection", "Appraisal"],
      "closingDate": "2024-12-20",
      "propertyImage": "https://picsum.photos/100/80?random=2&keyword=house",
      "notes": "Solid offer with excellent buyer qualifications",
      "priority": "Medium"
    },
    {
      "id": "3",
      "property": "Charming Townhouse",
      "address": "789 Pine Street, Midtown",
      "listingPrice": 525000,
      "offerAmount": 495000,
      "buyer": "Robert Kim",
      "buyerAgent": "David Thompson",
      "submittedDate": "2024-11-08",
      "expirationDate": "2024-11-15",
      "status": "Countered",
      "earnestMoney": 8000,
      "financingType": "Cash",
      "contingencies": ["Inspection"],
      "closingDate": "2024-12-01",
      "propertyImage": "https://picsum.photos/100/80?random=3&keyword=townhouse",
      "notes": "Cash offer but below asking price",
      "priority": "Medium"
    },
    {
      "id": "4",
      "property": "Waterfront Villa",
      "address": "321 Beach Road, Waterfront",
      "listingPrice": 1200000,
      "offerAmount": 1150000,
      "buyer": "Maria Garcia",
      "buyerAgent": "Lisa Rodriguez",
      "submittedDate": "2024-11-14",
      "expirationDate": "2024-11-21",
      "status": "Rejected",
      "earnestMoney": 25000,
      "financingType": "Jumbo",
      "contingencies": ["Inspection", "Financing", "Appraisal", "Sale of Current Home"],
      "closingDate": "2025-01-15",
      "propertyImage": "https://picsum.photos/100/80?random=4&keyword=villa",
      "notes": "Too many contingencies for seller's preference",
      "priority": "Low"
    },
    {
      "id": "5",
      "property": "Urban Loft Space",
      "address": "654 Industrial Way, Arts District",
      "listingPrice": 380000,
      "offerAmount": 385000,
      "buyer": "James Parker",
      "buyerAgent": "Emily Wilson",
      "submittedDate": "2024-11-13",
      "expirationDate": "2024-11-20",
      "status": "Under Review",
      "earnestMoney": 7500,
      "financingType": "Conventional",
      "contingencies": ["Inspection", "Financing"],
      "closingDate": "2024-12-10",
      "propertyImage": "https://picsum.photos/100/80?random=5&keyword=loft",
      "notes": "Above asking price, strong buyer profile",
      "priority": "High"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Accepted", "value": "Accepted"},
    {"label": "Countered", "value": "Countered"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Under Review", "value": "Under Review"}
  ];

  List<Map<String, dynamic>> propertyOptions = [
    {"label": "All Properties", "value": "All Properties"},
    {"label": "Modern Downtown Condo", "value": "Modern Downtown Condo"},
    {"label": "Luxury Family Home", "value": "Luxury Family Home"},
    {"label": "Charming Townhouse", "value": "Charming Townhouse"},
    {"label": "Waterfront Villa", "value": "Waterfront Villa"},
    {"label": "Urban Loft Space", "value": "Urban Loft Space"}
  ];

  List<Map<String, dynamic>> get filteredOffers {
    return offers.where((offer) {
      bool matchesFilter = selectedFilter == "All" || offer["status"] == selectedFilter;
      bool matchesProperty = selectedProperty == "All Properties" || offer["property"] == selectedProperty;
      bool matchesSearch = searchQuery.isEmpty || 
          offer["buyer"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          offer["property"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          offer["buyerAgent"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesProperty && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Accepted":
        return successColor;
      case "Countered":
        return infoColor;
      case "Rejected":
        return dangerColor;
      case "Under Review":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String getOfferDifference(int listingPrice, int offerAmount) {
    int difference = offerAmount - listingPrice;
    double percentage = (difference / listingPrice) * 100;
    String sign = difference >= 0 ? "+" : "";
    return "$sign${((difference).toDouble()).currency} (${sign}${percentage.toStringAsFixed(1)}%)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new offer
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search offers...",
                          value: searchQuery,
                          hint: "Buyer, property, or agent",
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
                          label: "Filter by Status",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Property",
                          items: propertyOptions,
                          value: selectedProperty,
                          onChanged: (value, label) {
                            selectedProperty = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Offer Statistics
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
                      children: [
                        Icon(
                          Icons.description,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredOffers.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Offers",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${offers.where((o) => o["status"] == "Accepted").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Accepted",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      children: [
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${offers.where((o) => o["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Urgent Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Urgent Actions Required",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "2 Expiring Soon",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: offers.where((offer) {
                      DateTime expiration = DateTime.parse(offer["expirationDate"]);
                      return expiration.difference(DateTime.now()).inDays <= 3;
                    }).map((offer) {
                      DateTime expiration = DateTime.parse(offer["expirationDate"]);
                      int daysLeft = expiration.difference(DateTime.now()).inDays;
                      
                      return Container(
                        width: 280,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: dangerColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                          color: dangerColor.withAlpha(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(offer["status"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${offer["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  daysLeft <= 0 ? "EXPIRED" : "${daysLeft}d left",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: daysLeft <= 0 ? dangerColor : warningColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${offer["property"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Buyer: ${offer["buyer"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Offer: \$${((offer["offerAmount"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "List: \$${((offer["listingPrice"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Take Action",
                                size: bs.sm,
                                onPressed: () {},
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

            // All Offers List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Offers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredOffers.length} offers",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredOffers.map((offer) {
                    DateTime expiration = DateTime.parse(offer["expirationDate"]);
                    int daysLeft = expiration.difference(DateTime.now()).inDays;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Property Image
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${offer["propertyImage"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Offer Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(offer["status"]),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${offer["status"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: getPriorityColor(offer["priority"]),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${offer["property"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Buyer: ${offer["buyer"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Agent: ${offer["buyerAgent"]}",
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
                          
                          // Offer Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Listing Price",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${((offer["listingPrice"] as int).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Offer Amount",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${((offer["offerAmount"] as int).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Difference: ${getOfferDifference(offer["listingPrice"], offer["offerAmount"])}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: offer["offerAmount"] >= offer["listingPrice"] ? successColor : dangerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Additional Details
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.attach_money, size: 14, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "Earnest: \$${((offer["earnestMoney"] as int).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.account_balance, size: 14, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "${offer["financingType"]} Financing",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "Closes: ${offer["closingDate"]}",
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                spacing: 4,
                                children: [
                                  Text(
                                    "Expires: ${offer["expirationDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: daysLeft <= 3 ? dangerColor : disabledBoldColor,
                                      fontWeight: daysLeft <= 3 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    daysLeft <= 0 ? "EXPIRED" : "${daysLeft} days left",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: daysLeft <= 0 ? dangerColor : (daysLeft <= 3 ? warningColor : successColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          // Contingencies
                          if ((offer["contingencies"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Contingencies:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: 4,
                                    children: (offer["contingencies"] as List).map((contingency) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: infoColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$contingency",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          if (offer["notes"] != null && offer["notes"].isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${offer["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              if (offer["status"] == "Pending" || offer["status"] == "Under Review") ...[
                                QButton(
                                  label: "Accept",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  label: "Counter",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.close,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ] else ...[
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.print,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
