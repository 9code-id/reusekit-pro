import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSpecialOffersView extends StatefulWidget {
  const FmaSpecialOffersView({super.key});

  @override
  State<FmaSpecialOffersView> createState() => _FmaSpecialOffersViewState();
}

class _FmaSpecialOffersViewState extends State<FmaSpecialOffersView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Draft", "value": "Draft"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Percentage", "value": "Percentage"},
    {"label": "Fixed Amount", "value": "Fixed Amount"},
    {"label": "Buy One Get One", "value": "BOGO"},
    {"label": "Happy Hour", "value": "Happy Hour"},
  ];

  List<Map<String, dynamic>> offers = [
    {
      "id": "1",
      "title": "Weekend Special",
      "description": "20% off all main courses",
      "type": "Percentage",
      "value": 20,
      "status": "Active",
      "startDate": "2024-06-15",
      "endDate": "2024-07-15",
      "minOrder": 25.0,
      "maxDiscount": 50.0,
      "usageCount": 234,
      "usageLimit": 500,
      "categories": ["Main Course"],
      "image": "https://picsum.photos/300/200?random=1&keyword=food",
    },
    {
      "id": "2",
      "title": "Happy Hour Drinks",
      "description": "Buy 2 get 1 free on selected beverages",
      "type": "BOGO",
      "value": 1,
      "status": "Active",
      "startDate": "2024-06-01",
      "endDate": "2024-12-31",
      "minOrder": 0.0,
      "maxDiscount": 15.0,
      "usageCount": 156,
      "usageLimit": 1000,
      "categories": ["Beverages"],
      "image": "https://picsum.photos/300/200?random=2&keyword=drinks",
    },
    {
      "id": "3",
      "title": "Student Discount",
      "description": "\$5 off orders above \$30",
      "type": "Fixed Amount",
      "value": 5,
      "status": "Active",
      "startDate": "2024-06-01",
      "endDate": "2024-08-31",
      "minOrder": 30.0,
      "maxDiscount": 5.0,
      "usageCount": 89,
      "usageLimit": 200,
      "categories": ["All"],
      "image": "https://picsum.photos/300/200?random=3&keyword=student",
    },
    {
      "id": "4",
      "title": "Family Combo",
      "description": "25% off family meals for 4+",
      "type": "Percentage",
      "value": 25,
      "status": "Scheduled",
      "startDate": "2024-07-01",
      "endDate": "2024-07-31",
      "minOrder": 60.0,
      "maxDiscount": 75.0,
      "usageCount": 0,
      "usageLimit": 100,
      "categories": ["Family Meal"],
      "image": "https://picsum.photos/300/200?random=4&keyword=family",
    },
    {
      "id": "5",
      "title": "First Time Customer",
      "description": "15% off first order",
      "type": "Percentage",
      "value": 15,
      "status": "Expired",
      "startDate": "2024-05-01",
      "endDate": "2024-05-31",
      "minOrder": 20.0,
      "maxDiscount": 30.0,
      "usageCount": 567,
      "usageLimit": 1000,
      "categories": ["All"],
      "image": "https://picsum.photos/300/200?random=5&keyword=welcome",
    },
  ];

  String newOfferTitle = "";
  String newOfferDescription = "";
  String newOfferType = "Percentage";
  String newOfferValue = "";
  String newOfferStartDate = "";
  String newOfferEndDate = "";
  String newOfferMinOrder = "";
  String newOfferMaxDiscount = "";
  String newOfferUsageLimit = "";

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Expired":
        return disabledBoldColor;
      case "Draft":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusXs),
                  image: DecorationImage(
                    image: NetworkImage("${offer["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${offer["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${offer["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${offer["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${offer["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor("${offer["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_offer,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${offer["type"]}: ${offer["type"] == "Percentage" ? "${offer["value"]}%" : "\$${offer["value"]}"}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Used: ${offer["usageCount"]}/${offer["usageLimit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valid Until",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${offer["endDate"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
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
                      "Min Order",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(offer["minOrder"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit offer
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateOfferTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Offer Title",
            value: newOfferTitle,
            hint: "Enter offer title",
            onChanged: (value) {
              newOfferTitle = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Description",
            value: newOfferDescription,
            hint: "Describe your offer",
            onChanged: (value) {
              newOfferDescription = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Offer Type",
            items: [
              {"label": "Percentage Discount", "value": "Percentage"},
              {"label": "Fixed Amount Off", "value": "Fixed Amount"},
              {"label": "Buy One Get One", "value": "BOGO"},
              {"label": "Happy Hour", "value": "Happy Hour"},
            ],
            value: newOfferType,
            onChanged: (value, label) {
              newOfferType = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: newOfferType == "Percentage" ? "Discount Percentage" : "Discount Amount",
            value: newOfferValue,
            hint: newOfferType == "Percentage" ? "Enter percentage (1-100)" : "Enter amount",
            onChanged: (value) {
              newOfferValue = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Start Date",
                  value: newOfferStartDate.isNotEmpty ? DateTime.parse(newOfferStartDate) : DateTime.now(),
                  onChanged: (value) {
                    newOfferStartDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "End Date",
                  value: newOfferEndDate.isNotEmpty ? DateTime.parse(newOfferEndDate) : DateTime.now().add(Duration(days: 30)),
                  onChanged: (value) {
                    newOfferEndDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Minimum Order Amount",
                  value: newOfferMinOrder,
                  hint: "0.00",
                  onChanged: (value) {
                    newOfferMinOrder = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Usage Limit",
                  value: newOfferUsageLimit,
                  hint: "100",
                  onChanged: (value) {
                    newOfferUsageLimit = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Offer",
              size: bs.md,
              onPressed: () {
                // Create offer
                ss("Special offer created successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Special Offers",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "All Offers", icon: Icon(Icons.list)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Create Offer", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        // Active Offers Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 32),
                          SizedBox(height: spXs),
                          Text(
                            "3",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Active Offers",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.monetization_on, color: primaryColor, size: 32),
                          SizedBox(height: spXs),
                          Text(
                            "\$2,450",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Savings Given",
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
              SizedBox(height: spMd),
              Text(
                "Currently Active",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...offers.where((offer) => offer["status"] == "Active").map((offer) => _buildOfferCard(offer)),
            ],
          ),
        ),

        // All Offers Tab
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.white,
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search offers...",
                          value: searchQuery,
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
                          // Search
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeItems,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: offers.map((offer) => _buildOfferCard(offer)).toList(),
                ),
              ),
            ),
          ],
        ),

        // Analytics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Performance Metrics
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.redeem, color: warningColor, size: 28),
                          SizedBox(height: spXs),
                          Text(
                            "479",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Redemptions",
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.people, color: infoColor, size: 28),
                          SizedBox(height: spXs),
                          Text(
                            "234",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Unique Users",
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

              // Top Performing Offers
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Performing Offers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...offers.take(3).map((offer) => Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${offer["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${offer["title"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${offer["usageCount"]} uses",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${((offer["usageCount"] as int) / (offer["usageLimit"] as int) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              // Revenue Impact
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Revenue Impact",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$12,450",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Revenue Generated",
                                textAlign: TextAlign.center,
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
                                "\$2,450",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Discounts Given",
                                textAlign: TextAlign.center,
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
                  ],
                ),
              ),
            ],
          ),
        ),

        // Create Offer Tab
        _buildCreateOfferTab(),
      ],
    );
  }
}
