import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaOfferTrackingView extends StatefulWidget {
  const ReaOfferTrackingView({super.key});

  @override
  State<ReaOfferTrackingView> createState() => _ReaOfferTrackingViewState();
}

class _ReaOfferTrackingViewState extends State<ReaOfferTrackingView> {
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> offers = [
    {
      "id": "OFF001",
      "property_title": "Luxury 3BHK Apartment",
      "property_location": "Downtown Paradise, Mumbai",
      "property_image": "https://picsum.photos/120/120?random=501&keyword=apartment",
      "original_price": 2500000.0,
      "offer_amount": 2200000.0,
      "status": "Under Review",
      "submitted_date": "2024-01-20",
      "response_deadline": "2024-01-25",
      "seller_name": "Rajesh Kumar",
      "progress_percentage": 25,
      "last_activity": "Offer submitted",
      "last_updated": "2 hours ago",
      "timeline": [
        {
          "status": "Submitted",
          "date": "2024-01-20 10:30 AM",
          "description": "Offer submitted to seller",
          "completed": true,
        },
        {
          "status": "Under Review",
          "date": "2024-01-20 02:15 PM",
          "description": "Seller reviewing your offer",
          "completed": true,
        },
        {
          "status": "Response",
          "date": "Expected by 2024-01-25",
          "description": "Waiting for seller response",
          "completed": false,
        },
        {
          "status": "Negotiation",
          "date": "Pending",
          "description": "Potential negotiation phase",
          "completed": false,
        },
      ],
    },
    {
      "id": "OFF002",
      "property_title": "Modern 2BHK Villa",
      "property_location": "Green Valley, Pune",
      "property_image": "https://picsum.photos/120/120?random=502&keyword=villa",
      "original_price": 1800000.0,
      "offer_amount": 1650000.0,
      "status": "Accepted",
      "submitted_date": "2024-01-18",
      "response_deadline": "2024-01-23",
      "seller_name": "Priya Sharma",
      "progress_percentage": 100,
      "last_activity": "Offer accepted",
      "last_updated": "1 day ago",
      "timeline": [
        {
          "status": "Submitted",
          "date": "2024-01-18 09:00 AM",
          "description": "Offer submitted to seller",
          "completed": true,
        },
        {
          "status": "Under Review",
          "date": "2024-01-18 03:30 PM",
          "description": "Seller reviewed your offer",
          "completed": true,
        },
        {
          "status": "Accepted",
          "date": "2024-01-19 11:45 AM",
          "description": "Seller accepted your offer",
          "completed": true,
        },
      ],
    },
    {
      "id": "OFF003",
      "property_title": "Commercial Office Space",
      "property_location": "Business District, Bangalore",
      "property_image": "https://picsum.photos/120/120?random=503&keyword=office",
      "original_price": 5500000.0,
      "offer_amount": 5200000.0,
      "status": "Counter Offer",
      "submitted_date": "2024-01-15",
      "response_deadline": "2024-01-20",
      "seller_name": "Amit Patel",
      "progress_percentage": 75,
      "last_activity": "Seller made counter offer",
      "last_updated": "3 hours ago",
      "timeline": [
        {
          "status": "Submitted",
          "date": "2024-01-15 02:00 PM",
          "description": "Offer submitted to seller",
          "completed": true,
        },
        {
          "status": "Under Review",
          "date": "2024-01-15 04:45 PM",
          "description": "Seller reviewed your offer",
          "completed": true,
        },
        {
          "status": "Counter Offer",
          "date": "2024-01-16 10:30 AM",
          "description": "Seller made counter offer: ₹54L",
          "completed": true,
        },
        {
          "status": "Your Response",
          "date": "Pending",
          "description": "Awaiting your response to counter offer",
          "completed": false,
        },
      ],
    },
    {
      "id": "OFF004",
      "property_title": "Luxury Penthouse",
      "property_location": "Skyline Heights, Delhi",
      "property_image": "https://picsum.photos/120/120?random=504&keyword=penthouse",
      "original_price": 8500000.0,
      "offer_amount": 8000000.0,
      "status": "Rejected",
      "submitted_date": "2024-01-12",
      "response_deadline": "2024-01-17",
      "seller_name": "Neha Gupta",
      "progress_percentage": 50,
      "last_activity": "Offer rejected",
      "last_updated": "2 days ago",
      "timeline": [
        {
          "status": "Submitted",
          "date": "2024-01-12 11:00 AM",
          "description": "Offer submitted to seller",
          "completed": true,
        },
        {
          "status": "Under Review",
          "date": "2024-01-12 05:20 PM",
          "description": "Seller reviewed your offer",
          "completed": true,
        },
        {
          "status": "Rejected",
          "date": "2024-01-14 09:15 AM",
          "description": "Seller rejected your offer",
          "completed": true,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOffers = selectedFilter == "All" 
        ? offers 
        : offers.where((offer) => offer["status"] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing offer status...");
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Opening notifications...");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Under Review", "value": "Under Review"},
                {"label": "Counter Offer", "value": "Counter Offer"},
                {"label": "Accepted", "value": "Accepted"},
                {"label": "Rejected", "value": "Rejected"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),

          // Summary Stats
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
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
                        "${offers.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Offers",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${offers.where((o) => o["status"] == "Under Review").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${offers.where((o) => o["status"] == "Accepted").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Accepted",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${((offers.where((o) => o["status"] == "Accepted").fold(0.0, (sum, o) => sum + ((o["original_price"] as double) - (o["offer_amount"] as double)))) / 100000).toStringAsFixed(1)}L",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Saved",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Offers List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredOffers.length,
              itemBuilder: (context, index) {
                final offer = filteredOffers[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Header
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${offer["property_image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${offer["property_title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${offer["property_location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Offer ID: ${offer["id"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(offer["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${offer["status"]}",
                              style: TextStyle(
                                color: _getStatusColor(offer["status"]),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${offer["progress_percentage"]}%",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (offer["progress_percentage"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(offer["status"])),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Price Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Original Price:",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "₹${((offer["original_price"] as double) / 100000).toStringAsFixed(1)}L",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Your Offer:",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "₹${((offer["offer_amount"] as double) / 100000).toStringAsFixed(1)}L",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (offer["status"] == "Accepted") ...[
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "You Saved:",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "₹${(((offer["original_price"] as double) - (offer["offer_amount"] as double)) / 100000).toStringAsFixed(1)}L",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Last Activity & Timeline
                      Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${offer["last_activity"]} • ${offer["last_updated"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              _showOfferTimeline(offer);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View Timeline",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: primaryColor,
                                  size: 12,
                                ),
                              ],
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
                              label: "Contact Seller",
                              icon: Icons.chat,
                              size: bs.sm,
                              onPressed: () {
                                si("Opening chat with ${offer["seller_name"]}...");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (offer["status"] == "Counter Offer") ...[
                            Expanded(
                              child: QButton(
                                label: "Respond",
                                icon: Icons.reply,
                                size: bs.sm,
                                onPressed: () {
                                  _showCounterOfferResponse(offer);
                                },
                              ),
                            ),
                          ] else if (offer["status"] == "Under Review") ...[
                            Expanded(
                              child: QButton(
                                label: "Follow Up",
                                icon: Icons.notifications,
                                size: bs.sm,
                                onPressed: () {
                                  si("Sending follow-up reminder...");
                                },
                              ),
                            ),
                          ] else if (offer["status"] == "Accepted") ...[
                            Expanded(
                              child: QButton(
                                label: "Next Steps",
                                icon: Icons.arrow_forward,
                                size: bs.sm,
                                onPressed: () {
                                  si("Proceeding to documentation...");
                                },
                              ),
                            ),
                          ] else if (offer["status"] == "Rejected") ...[
                            Expanded(
                              child: QButton(
                                label: "New Offer",
                                icon: Icons.refresh,
                                size: bs.sm,
                                onPressed: () {
                                  si("Creating new offer...");
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Browse properties to make new offers");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Under Review":
        return warningColor;
      case "Counter Offer":
        return infoColor;
      case "Accepted":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showOfferTimeline(Map<String, dynamic> offer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Offer Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  itemCount: (offer["timeline"] as List).length,
                  itemBuilder: (context, index) {
                    final timeline = (offer["timeline"] as List)[index];
                    final isCompleted = timeline["completed"] as bool;
                    final isLast = index == (offer["timeline"] as List).length - 1;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                              child: Icon(
                                isCompleted ? Icons.check : Icons.schedule,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            if (!isLast) ...[
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${timeline["status"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${timeline["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${timeline["date"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              if (!isLast) SizedBox(height: spMd),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCounterOfferResponse(Map<String, dynamic> offer) {
    double newOfferAmount = 0.0;
    String responseMessage = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Respond to Counter Offer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Seller's counter offer: ₹${((offer["original_price"] as double) * 0.96 / 100000).toStringAsFixed(1)}L"),
            SizedBox(height: spMd),
            QNumberField(
              label: "Your Response (₹)",
              value: "",
              onChanged: (value) {
                newOfferAmount = double.tryParse(value) ?? 0.0;
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Message",
              value: responseMessage,
              hint: "Add a message with your response...",
              onChanged: (value) {
                responseMessage = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Accept Counter",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Counter offer accepted!");
            },
          ),
          QButton(
            label: "Counter Back",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Counter offer sent!");
            },
          ),
        ],
      ),
    );
  }
}
