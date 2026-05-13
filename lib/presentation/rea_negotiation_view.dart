import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaNegotiationView extends StatefulWidget {
  const ReaNegotiationView({super.key});

  @override
  State<ReaNegotiationView> createState() => _ReaNegotiationViewState();
}

class _ReaNegotiationViewState extends State<ReaNegotiationView> {
  String selectedTab = "Active";
  double counterOffer = 2200000.0;
  String negotiationMessage = "";
  
  List<Map<String, dynamic>> negotiations = [
    {
      "id": "NEG001",
      "property_title": "Luxury 3BHK Apartment",
      "property_location": "Downtown Paradise, Mumbai",
      "original_price": 2500000.0,
      "your_offer": 2200000.0,
      "seller_counter": 2350000.0,
      "current_offer": 2300000.0,
      "status": "Active",
      "last_updated": "2 hours ago",
      "messages_count": 8,
      "property_image": "https://picsum.photos/120/120?random=501&keyword=apartment",
      "seller_name": "Rajesh Kumar",
      "negotiation_started": "2024-01-15",
      "deadline": "2024-01-25",
      "savings": 200000.0,
    },
    {
      "id": "NEG002", 
      "property_title": "Modern 2BHK Villa",
      "property_location": "Green Valley, Pune",
      "original_price": 1800000.0,
      "your_offer": 1650000.0,
      "seller_counter": null,
      "current_offer": 1650000.0,
      "status": "Pending",
      "last_updated": "1 day ago",
      "messages_count": 3,
      "property_image": "https://picsum.photos/120/120?random=502&keyword=villa",
      "seller_name": "Priya Sharma",
      "negotiation_started": "2024-01-18",
      "deadline": "2024-01-28",
      "savings": 150000.0,
    },
    {
      "id": "NEG003",
      "property_title": "Commercial Office Space",
      "property_location": "Business District, Bangalore",
      "original_price": 5500000.0,
      "your_offer": 5200000.0,
      "seller_counter": 5400000.0,
      "current_offer": 5300000.0,
      "status": "Accepted",
      "last_updated": "3 days ago",
      "messages_count": 12,
      "property_image": "https://picsum.photos/120/120?random=503&keyword=office",
      "seller_name": "Amit Patel",
      "negotiation_started": "2024-01-10",
      "deadline": "2024-01-20",
      "savings": 200000.0,
    },
    {
      "id": "NEG004",
      "property_title": "Luxury Penthouse",
      "property_location": "Skyline Heights, Delhi",
      "original_price": 8500000.0,
      "your_offer": 8000000.0,
      "seller_counter": null,
      "current_offer": 8000000.0,
      "status": "Rejected",
      "last_updated": "5 days ago",
      "messages_count": 4,
      "property_image": "https://picsum.photos/120/120?random=504&keyword=penthouse",
      "seller_name": "Neha Gupta",
      "negotiation_started": "2024-01-12",
      "deadline": "2024-01-22",
      "savings": 0.0,
    },
  ];

  List<Map<String, dynamic>> negotiationMessages = [
    {
      "id": "MSG001",
      "sender": "You",
      "message": "I'm interested in this property. Would you consider ₹22 Lakhs?",
      "timestamp": "2024-01-20 10:30 AM",
      "offer_amount": 2200000.0,
      "type": "offer",
    },
    {
      "id": "MSG002",
      "sender": "Rajesh Kumar",
      "message": "Thank you for your interest. The property is priced considering its premium location and amenities. I can consider ₹23.5 Lakhs.",
      "timestamp": "2024-01-20 02:15 PM",
      "offer_amount": 2350000.0,
      "type": "counter_offer",
    },
    {
      "id": "MSG003",
      "sender": "You", 
      "message": "I understand the value, but my budget is limited. Can we meet at ₹23 Lakhs?",
      "timestamp": "2024-01-20 04:45 PM",
      "offer_amount": 2300000.0,
      "type": "counter_offer",
    },
    {
      "id": "MSG004",
      "sender": "Rajesh Kumar",
      "message": "Let me discuss with the owner and get back to you by tomorrow.",
      "timestamp": "2024-01-20 06:20 PM",
      "offer_amount": null,
      "type": "message",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Negotiations"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showNegotiationTips();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selector
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Active", "value": "Active"},
                {"label": "Pending", "value": "Pending"},
                {"label": "Accepted", "value": "Accepted"},
                {"label": "Rejected", "value": "Rejected"},
              ],
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          // Negotiations Summary
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
                        "${negotiations.where((n) => n["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Active",
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
                        "${negotiations.where((n) => n["status"] == "Accepted").length}",
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
                        "₹${((negotiations.where((n) => n["status"] == "Accepted").fold(0.0, (sum, n) => sum + (n["savings"] as double))) / 100000).toStringAsFixed(1)}L",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Saved",
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

          // Negotiations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: negotiations.where((n) => n["status"] == selectedTab).length,
              itemBuilder: (context, index) {
                final negotiation = negotiations.where((n) => n["status"] == selectedTab).toList()[index];
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
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${negotiation["property_image"]}"),
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
                                  "${negotiation["property_title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${negotiation["property_location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "With ${negotiation["seller_name"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(negotiation["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${negotiation["status"]}",
                              style: TextStyle(
                                color: _getStatusColor(negotiation["status"]),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                                  "₹${((negotiation["original_price"] as double) / 100000).toStringAsFixed(1)}L",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Current Offer:",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "₹${((negotiation["current_offer"] as double) / 100000).toStringAsFixed(1)}L",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if ((negotiation["savings"] as double) > 0) ...[
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Potential Savings:",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "₹${((negotiation["savings"] as double) / 100000).toStringAsFixed(1)}L",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${negotiation["messages_count"]} messages",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.schedule,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${negotiation["last_updated"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          if (negotiation["status"] == "Active") ...[
                            QButton(
                              label: "Chat",
                              icon: Icons.chat,
                              size: bs.sm,
                              onPressed: () {
                                _openNegotiationChat(negotiation);
                              },
                            ),
                          ] else if (negotiation["status"] == "Pending") ...[
                            QButton(
                              label: "Follow Up",
                              icon: Icons.notifications,
                              size: bs.sm,
                              onPressed: () {
                                si("Sending follow-up reminder...");
                              },
                            ),
                          ] else if (negotiation["status"] == "Accepted") ...[
                            QButton(
                              label: "Proceed",
                              icon: Icons.arrow_forward,
                              size: bs.sm,
                              onPressed: () {
                                si("Proceeding to documentation...");
                              },
                            ),
                          ] else if (negotiation["status"] == "Rejected") ...[
                            QButton(
                              label: "New Offer",
                              icon: Icons.refresh,
                              size: bs.sm,
                              onPressed: () {
                                _makeNewOffer(negotiation);
                              },
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
          si("Browse properties to start negotiation");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return primaryColor;
      case "Pending":
        return warningColor;
      case "Accepted":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _openNegotiationChat(Map<String, dynamic> negotiation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
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
                        "Negotiation Chat",
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
                  itemCount: negotiationMessages.length,
                  itemBuilder: (context, index) {
                    final message = negotiationMessages[index];
                    final isYou = message["sender"] == "You";
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      child: Row(
                        mainAxisAlignment: isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isYou ? primaryColor : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${message["message"]}",
                                  style: TextStyle(
                                    color: isYou ? Colors.white : primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                                if (message["offer_amount"] != null) ...[
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: (isYou ? Colors.white : primaryColor).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Offer: ₹${((message["offer_amount"] as double) / 100000).toStringAsFixed(1)}L",
                                      style: TextStyle(
                                        color: isYou ? primaryColor : Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                                SizedBox(height: spXs),
                                Text(
                                  "${message["timestamp"]}",
                                  style: TextStyle(
                                    color: (isYou ? Colors.white : disabledBoldColor).withAlpha(180),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QNumberField(
                      label: "Counter Offer Amount (₹)",
                      value: counterOffer.toString(),
                      onChanged: (value) {
                        counterOffer = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Message",
                      value: negotiationMessage,
                      hint: "Add a message with your offer...",
                      onChanged: (value) {
                        negotiationMessage = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Counter Offer",
                        icon: Icons.send,
                        size: bs.md,
                        onPressed: () {
                          showLoading();
                          Future.delayed(Duration(seconds: 2), () {
                            hideLoading();
                            ss("Counter offer sent successfully!");
                            back();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _makeNewOffer(Map<String, dynamic> negotiation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Make New Offer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Current asking price: ₹${((negotiation["original_price"] as double) / 100000).toStringAsFixed(1)}L"),
            SizedBox(height: spMd),
            QNumberField(
              label: "Your New Offer (₹)",
              value: "",
              onChanged: (value) {
                counterOffer = double.tryParse(value) ?? 0.0;
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
            label: "Submit",
            size: bs.sm,
            onPressed: () {
              back();
              ss("New offer submitted successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Negotiations"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Filter options will be implemented here"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showNegotiationTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Negotiation Tips"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Research market prices before making an offer"),
            Text("• Be polite and professional in all communications"),
            Text("• Consider property condition and location"),
            Text("• Leave room for counter-offers"),
            Text("• Set a maximum budget and stick to it"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
