import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaGroupOrderView extends StatefulWidget {
  const FdaGroupOrderView({super.key});

  @override
  State<FdaGroupOrderView> createState() => _FdaGroupOrderViewState();
}

class _FdaGroupOrderViewState extends State<FdaGroupOrderView> {
  String groupOrderCode = "GO2024001";
  String groupName = "Office Lunch Group";
  String organizerName = "Sarah Johnson";
  bool isOrganizer = true;
  double deliveryFee = 5.99;
  double minOrderAmount = 50.00;
  String deadline = "12:30 PM";
  String deliveryTime = "01:00 PM";
  
  Map<String, dynamic> orderSummary = {
    "totalParticipants": 5,
    "totalItems": 12,
    "subtotal": 78.45,
    "deliveryFee": 5.99,
    "serviceFee": 2.50,
    "total": 86.94,
    "amountPerPerson": 17.39,
  };

  List<Map<String, dynamic>> participants = [
    {
      "name": "Sarah Johnson",
      "isOrganizer": true,
      "status": "confirmed",
      "items": 3,
      "amount": 24.50,
      "paid": true,
    },
    {
      "name": "Mike Chen",
      "isOrganizer": false,
      "status": "confirmed",
      "items": 2,
      "amount": 18.99,
      "paid": true,
    },
    {
      "name": "Emily Davis",
      "isOrganizer": false,
      "status": "confirmed",
      "items": 2,
      "amount": 15.47,
      "paid": false,
    },
    {
      "name": "James Wilson",
      "isOrganizer": false,
      "status": "pending",
      "items": 3,
      "amount": 19.49,
      "paid": false,
    },
    {
      "name": "Lisa Zhang",
      "isOrganizer": false,
      "status": "confirmed",
      "items": 2,
      "amount": 16.95,
      "paid": true,
    },
  ];

  List<Map<String, dynamic>> groupItems = [
    {
      "name": "Margherita Pizza",
      "restaurant": "Tony's Pizzeria",
      "price": 14.99,
      "quantity": 2,
      "orderedBy": "Sarah Johnson",
    },
    {
      "name": "Caesar Salad",
      "restaurant": "Tony's Pizzeria",
      "price": 8.99,
      "quantity": 1,
      "orderedBy": "Mike Chen",
    },
    {
      "name": "Chicken Sandwich",
      "restaurant": "Corner Deli",
      "price": 12.50,
      "quantity": 3,
      "orderedBy": "Emily Davis",
    },
    {
      "name": "Sushi Combo",
      "restaurant": "Sakura Sushi",
      "price": 18.99,
      "quantity": 2,
      "orderedBy": "James Wilson",
    },
    {
      "name": "Thai Green Curry",
      "restaurant": "Thai Garden",
      "price": 15.49,
      "quantity": 1,
      "orderedBy": "Lisa Zhang",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Order"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareGroupOrder,
          ),
          if (isOrganizer)
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: _groupSettings,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildGroupHeader(),
            _buildOrderProgress(),
            _buildParticipants(),
            _buildGroupItems(),
            _buildOrderSummary(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupHeader() {
    return Container(
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.group,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Code: $groupOrderCode",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (isOrganizer)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Organizer",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Organizer", organizerName, Icons.person),
              ),
              Expanded(
                child: _buildInfoItem("Deadline", deadline, Icons.schedule),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Delivery", deliveryTime, Icons.delivery_dining),
              ),
              Expanded(
                child: _buildInfoItem("Min Order", "\$${minOrderAmount.toStringAsFixed(2)}", Icons.shopping_cart),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderProgress() {
    double progress = (orderSummary["subtotal"] as double) / minOrderAmount;
    double remaining = minOrderAmount - (orderSummary["subtotal"] as double);
    
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Order Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Text(
                "\$${((orderSummary["subtotal"] as double)).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                " / \$${minOrderAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (remaining > 0)
                Text(
                  "\$${remaining.toStringAsFixed(2)} remaining",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              else
                Text(
                  "Minimum reached!",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress > 1 ? 1 : progress,
              child: Container(
                decoration: BoxDecoration(
                  color: progress >= 1 ? successColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipants() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Participants (${participants.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: _inviteParticipant,
              ),
            ],
          ),
          Divider(color: disabledColor),
          ...participants.map((participant) => _buildParticipantCard(participant)),
        ],
      ),
    );
  }

  Widget _buildParticipantCard(Map<String, dynamic> participant) {
    String status = participant["status"];
    Color statusColor = status == "confirmed" ? successColor : 
                       status == "pending" ? warningColor : disabledBoldColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(50), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: statusColor,
            child: Text(
              "${participant["name"]}".substring(0, 1),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${participant["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    if (participant["isOrganizer"] == true)
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXxs),
                        ),
                        child: Text(
                          "HOST",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${participant["items"]} items • \$${((participant["amount"] as double)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            participant["paid"] == true ? Icons.check_circle : Icons.schedule,
            color: participant["paid"] == true ? successColor : warningColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItems() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Group Items (${groupItems.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Items",
                size: bs.sm,
                onPressed: _addItems,
              ),
            ],
          ),
          Divider(color: disabledColor),
          ...groupItems.map((item) => _buildGroupItem(item)),
        ],
      ),
    );
  }

  Widget _buildGroupItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${item["quantity"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${item["restaurant"]} • by ${item["orderedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.receipt,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          _buildSummaryRow("Subtotal", "\$${((orderSummary["subtotal"] as double)).toStringAsFixed(2)}"),
          _buildSummaryRow("Delivery Fee", "\$${((orderSummary["deliveryFee"] as double)).toStringAsFixed(2)}"),
          _buildSummaryRow("Service Fee", "\$${((orderSummary["serviceFee"] as double)).toStringAsFixed(2)}"),
          Divider(color: disabledColor),
          _buildSummaryRow("Total", "\$${((orderSummary["total"] as double)).toStringAsFixed(2)}", true),
          _buildSummaryRow("Per Person", "\$${((orderSummary["amountPerPerson"] as double)).toStringAsFixed(2)}", false, infoColor),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, [bool isBold = false, Color? color]) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? (isBold ? primaryColor : disabledBoldColor),
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: color ?? (isBold ? primaryColor : disabledBoldColor),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
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
          if (isOrganizer) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Finalize Group Order",
                size: bs.sm,
                onPressed: _finalizeOrder,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Reminder",
                    size: bs.sm,
                    onPressed: _sendReminder,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Extend Deadline",
                    size: bs.sm,
                    onPressed: _extendDeadline,
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add My Items",
                size: bs.sm,
                onPressed: _addItems,
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Leave Group",
                  size: bs.sm,
                  onPressed: _leaveGroup,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Code",
                  size: bs.sm,
                  onPressed: _shareGroupOrder,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _shareGroupOrder() {
    ss("Group order code $groupOrderCode shared!");
  }

  void _groupSettings() {
    ss("Opening group settings...");
  }

  void _inviteParticipant() {
    ss("Opening participant invitation...");
  }

  void _addItems() {
    ss("Opening restaurant selection for group order...");
  }

  void _finalizeOrder() {
    ss("Finalizing group order...");
  }

  void _sendReminder() {
    ss("Reminder sent to all participants!");
  }

  void _extendDeadline() {
    ss("Opening deadline extension form...");
  }

  void _leaveGroup() {
    ss("Leaving group order...");
  }
}
