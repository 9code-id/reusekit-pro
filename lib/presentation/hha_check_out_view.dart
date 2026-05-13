import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaCheckOutView extends StatefulWidget {
  const HhaCheckOutView({super.key});

  @override
  State<HhaCheckOutView> createState() => _HhaCheckOutViewState();
}

class _HhaCheckOutViewState extends State<HhaCheckOutView> {
  int currentStep = 0;
  bool isLoading = false;
  String searchQuery = "";
  
  // Check-out form data
  Map<String, dynamic> checkOutData = {
    "roomNumber": "",
    "guestName": "",
    "checkOutTime": "",
    "roomInspected": false,
    "keyCardsReturned": false,
    "minibarChecked": false,
    "damageAssessed": false,
    "additionalCharges": 0.0,
    "feedbackCollected": false,
    "finalBillSettled": false,
    "specialNotes": "",
    "satisfactionRating": 0,
  };

  // Sample checked-in guests
  List<Map<String, dynamic>> checkedInGuests = [
    {
      "confirmationNumber": "HTL-2024-061501",
      "guestName": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234 567 8900",
      "checkInDate": "2024-06-12",
      "checkOutDate": "2024-06-15",
      "roomType": "Deluxe Suite",
      "roomNumber": "1205",
      "adults": 2,
      "children": 1,
      "status": "Checked-in",
      "totalAmount": 864.0,
      "paidAmount": 864.0,
      "remainingBalance": 0.0,
      "services": [
        {"name": "Room Service", "amount": 45.0, "date": "2024-06-13"},
        {"name": "Spa Package", "amount": 120.0, "date": "2024-06-13"},
        {"name": "Minibar", "amount": 28.0, "date": "2024-06-14"},
      ],
      "keyCardsIssued": 2,
      "parkingSpot": "A-15",
      "vipGuest": true,
      "loyaltyMember": "Gold",
      "expectedCheckOut": "11:00 AM",
      "lateCheckoutRequested": true,
      "lateCheckoutTime": "2:00 PM",
      "lateCheckoutFee": 50.0,
    },
    {
      "confirmationNumber": "HTL-2024-061502",
      "guestName": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 234 567 8901",
      "checkInDate": "2024-06-14",
      "checkOutDate": "2024-06-15",
      "roomType": "Standard Room",
      "roomNumber": "0807",
      "adults": 1,
      "children": 0,
      "status": "Checked-in",
      "totalAmount": 120.0,
      "paidAmount": 120.0,
      "remainingBalance": 0.0,
      "services": [
        {"name": "Laundry Service", "amount": 15.0, "date": "2024-06-14"},
      ],
      "keyCardsIssued": 1,
      "parkingSpot": null,
      "vipGuest": false,
      "loyaltyMember": null,
      "expectedCheckOut": "11:00 AM",
      "lateCheckoutRequested": false,
      "lateCheckoutTime": null,
      "lateCheckoutFee": 0.0,
    },
    {
      "confirmationNumber": "HTL-2024-061503",
      "guestName": "Michael Brown",
      "email": "m.brown@email.com",
      "phone": "+1 234 567 8902",
      "checkInDate": "2024-06-10",
      "checkOutDate": "2024-06-15",
      "roomType": "Presidential Suite",
      "roomNumber": "2001",
      "adults": 2,
      "children": 0,
      "status": "Checked-in",
      "totalAmount": 2500.0,
      "paidAmount": 2300.0,
      "remainingBalance": 200.0,
      "services": [
        {"name": "Private Butler", "amount": 150.0, "date": "2024-06-11"},
        {"name": "Fine Dining", "amount": 180.0, "date": "2024-06-12"},
        {"name": "Spa Premium Package", "amount": 250.0, "date": "2024-06-13"},
        {"name": "Minibar Premium", "amount": 85.0, "date": "2024-06-14"},
      ],
      "keyCardsIssued": 3,
      "parkingSpot": "VIP-1",
      "vipGuest": true,
      "loyaltyMember": "Platinum",
      "expectedCheckOut": "12:00 PM",
      "lateCheckoutRequested": false,
      "lateCheckoutTime": null,
      "lateCheckoutFee": 0.0,
    },
  ];

  List<Map<String, dynamic>> checkOutSteps = [
    {
      "title": "Find Guest",
      "description": "Search for guest by room number or name",
      "icon": Icons.search,
      "completed": false,
    },
    {
      "title": "Room Inspection",
      "description": "Inspect room condition and collect key cards",
      "icon": Icons.room_service,
      "completed": false,
    },
    {
      "title": "Bill Settlement",
      "description": "Review charges and settle final bill",
      "icon": Icons.receipt,
      "completed": false,
    },
    {
      "title": "Feedback & Complete",
      "description": "Collect feedback and complete check-out",
      "icon": Icons.star,
      "completed": false,
    },
  ];

  Map<String, dynamic>? selectedGuest;

  List<Map<String, dynamic>> get filteredGuests {
    return checkedInGuests.where((guest) {
      return searchQuery.isEmpty ||
          guest["roomNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          guest["guestName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          guest["confirmationNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'checked-in':
        return primaryColor;
      case 'checking-out':
        return warningColor;
      case 'checked-out':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getLoyaltyColor(String? level) {
    switch (level?.toLowerCase()) {
      case 'platinum':
        return Color(0xFF9C88FF);
      case 'gold':
        return Color(0xFFFFD700);
      case 'silver':
        return Color(0xFFC0C0C0);
      default:
        return disabledColor;
    }
  }

  Widget _buildSearchStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Find Guest for Check-out",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Search by room number, guest name, or confirmation number.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Search guests...",
          value: searchQuery,
          hint: "Room number, name, or confirmation",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        if (filteredGuests.isNotEmpty) ...[
          Text(
            "Checked-in Guests (${filteredGuests.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: filteredGuests.map((guest) {
              bool isSelected = selectedGuest?["confirmationNumber"] == guest["confirmationNumber"];
              bool isLateCheckout = guest["lateCheckoutRequested"] == true;
              bool isPastCheckout = DateTime.now().hour > 11;
              
              return GestureDetector(
                onTap: () {
                  selectedGuest = guest;
                  checkOutData["roomNumber"] = guest["roomNumber"];
                  checkOutData["guestName"] = guest["guestName"];
                  checkOutData["checkOutTime"] = "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}";
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${guest["guestName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Room ${guest["roomNumber"]} • ${guest["roomType"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Conf: ${guest["confirmationNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(guest["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${guest["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(guest["status"]),
                                  ),
                                ),
                              ),
                              if (guest["vipGuest"] == true) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "VIP",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              if (guest["loyaltyMember"] != null) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getLoyaltyColor(guest["loyaltyMember"]),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${guest["loyaltyMember"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Stay: ${DateTime.parse(guest["checkInDate"]).dMMMy} - ${DateTime.parse(guest["checkOutDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${guest["adults"]} Adult(s)${(guest["children"] as int) > 0 ? ', ${guest["children"]} Child(ren)' : ''}",
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
                                isLateCheckout 
                                  ? "Late checkout: ${guest["lateCheckoutTime"]}"
                                  : "Expected: ${guest["expectedCheckOut"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isLateCheckout ? warningColor : disabledBoldColor,
                                  fontWeight: isLateCheckout ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                              if (isPastCheckout && !isLateCheckout) ...[
                                Text(
                                  "OVERDUE",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      
                      if ((guest["remainingBalance"] as double) > 0) ...[
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "Outstanding Balance: \$${(guest["remainingBalance"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                      if ((guest["services"] as List).isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.room_service, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "${(guest["services"] as List).length} additional service(s)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ] else if (searchQuery.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(Icons.search_off, size: 48, color: infoColor),
                SizedBox(height: spSm),
                Text(
                  "No guests found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Try searching with a different room number, name, or confirmation number.",
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
      ],
    );
  }

  Widget _buildRoomInspectionStep() {
    if (selectedGuest == null) return Container();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Room Inspection & Key Cards",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Inspect room condition and collect key cards from guest.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Guest & Room Info
        Container(
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
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Icon(
                      Icons.person,
                      size: 25,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedGuest!["guestName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Room ${selectedGuest!["roomNumber"]} • ${selectedGuest!["roomType"]}",
                          style: TextStyle(
                            fontSize: 14,
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
                        "Check-out: ${checkOutData["checkOutTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${selectedGuest!["keyCardsIssued"]} key cards issued",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Inspection Checklist
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Room Inspection Checklist",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "All key cards returned (${selectedGuest!["keyCardsIssued"]} cards)",
                    "value": "key_cards",
                    "checked": checkOutData["keyCardsReturned"],
                  }
                ],
                value: checkOutData["keyCardsReturned"] ? [{"label": "All key cards returned (${selectedGuest!["keyCardsIssued"]} cards)", "value": "key_cards", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkOutData["keyCardsReturned"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Room condition inspected",
                    "value": "room_inspected",
                    "checked": checkOutData["roomInspected"],
                  }
                ],
                value: checkOutData["roomInspected"] ? [{"label": "Room condition inspected", "value": "room_inspected", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkOutData["roomInspected"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Minibar/amenities checked",
                    "value": "minibar_checked",
                    "checked": checkOutData["minibarChecked"],
                  }
                ],
                value: checkOutData["minibarChecked"] ? [{"label": "Minibar/amenities checked", "value": "minibar_checked", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkOutData["minibarChecked"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "No damage or missing items",
                    "value": "damage_assessed",
                    "checked": checkOutData["damageAssessed"],
                  }
                ],
                value: checkOutData["damageAssessed"] ? [{"label": "No damage or missing items", "value": "damage_assessed", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkOutData["damageAssessed"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Additional Notes
        QMemoField(
          label: "Inspection Notes",
          value: checkOutData["specialNotes"],
          hint: "Any observations about room condition, missing items, damage, etc.",
          onChanged: (value) {
            checkOutData["specialNotes"] = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBillSettlementStep() {
    if (selectedGuest == null) return Container();
    
    double additionalCharges = 0.0;
    if (selectedGuest!["services"] != null) {
      for (var service in selectedGuest!["services"] as List) {
        additionalCharges += (service["amount"] as double);
      }
    }
    
    if (selectedGuest!["lateCheckoutRequested"] == true) {
      additionalCharges += (selectedGuest!["lateCheckoutFee"] as double);
    }
    
    double totalAmount = (selectedGuest!["totalAmount"] as double) + additionalCharges;
    double remainingBalance = totalAmount - (selectedGuest!["paidAmount"] as double);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Final Bill Settlement",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Review all charges and settle the final bill.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Bill Summary
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Final Bill Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              // Room Charges
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Room Charges",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "\$${(selectedGuest!["totalAmount"] as double).currency}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              
              // Additional Services
              if ((selectedGuest!["services"] as List).isNotEmpty) ...[
                SizedBox(height: spXs),
                Text(
                  "Additional Services:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                ...(selectedGuest!["services"] as List).map((service) {
                  return Padding(
                    padding: EdgeInsets.only(left: spSm, top: spXs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${service["name"]} (${DateTime.parse(service["date"]).dMMMy})",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                        Text(
                          "\$${(service["amount"] as double).currency}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ],
                    ),
                  );
                }),
              ],
              
              // Late Checkout Fee
              if (selectedGuest!["lateCheckoutRequested"] == true) ...[
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Late checkout fee",
                      style: TextStyle(fontSize: 14, color: warningColor),
                    ),
                    Text(
                      "\$${(selectedGuest!["lateCheckoutFee"] as double).currency}",
                      style: TextStyle(fontSize: 14, color: warningColor),
                    ),
                  ],
                ),
              ],
              
              if (additionalCharges > 0) ...[
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Additional Charges",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "\$${additionalCharges.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ],
              
              Divider(height: spMd),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${totalAmount.currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spXs),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount Paid",
                    style: TextStyle(fontSize: 14, color: successColor),
                  ),
                  Text(
                    "\$${(selectedGuest!["paidAmount"] as double).currency}",
                    style: TextStyle(fontSize: 14, color: successColor),
                  ),
                ],
              ),
              
              if (remainingBalance > 0) ...[
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Outstanding Balance",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "\$${remainingBalance.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(height: spXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(fontSize: 14, color: successColor),
                    ),
                    Text(
                      "PAID IN FULL",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Payment Settlement
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Settlement",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": remainingBalance > 0 ? "Outstanding balance collected" : "Bill reviewed and confirmed",
                    "value": "bill_settled",
                    "checked": checkOutData["finalBillSettled"],
                  }
                ],
                value: checkOutData["finalBillSettled"] ? [{"label": remainingBalance > 0 ? "Outstanding balance collected" : "Bill reviewed and confirmed", "value": "bill_settled", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkOutData["finalBillSettled"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              if (remainingBalance > 0 && !checkOutData["finalBillSettled"]) ...[
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Process Payment (\$${remainingBalance.currency})",
                        size: bs.sm,
                        onPressed: () => _processOutstandingPayment(remainingBalance),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackStep() {
    if (selectedGuest == null) return Container();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Guest Feedback & Complete Check-out",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Collect guest feedback and complete the check-out process.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Guest Satisfaction
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Guest Satisfaction Rating",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              Text(
                "How satisfied was the guest with their stay?",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  int rating = index + 1;
                  bool isSelected = checkOutData["satisfactionRating"] == rating;
                  
                  return GestureDetector(
                    onTap: () {
                      checkOutData["satisfactionRating"] = rating;
                      setState(() {});
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star,
                        color: isSelected ? Colors.white : disabledColor,
                        size: 24,
                      ),
                    ),
                  );
                }),
              ),
              
              SizedBox(height: spSm),
              
              if (checkOutData["satisfactionRating"] > 0) ...[
                Text(
                  _getSatisfactionText(checkOutData["satisfactionRating"]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getSatisfactionColor(checkOutData["satisfactionRating"]),
                  ),
                ),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Feedback Collection
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Additional Feedback",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "Guest feedback collected",
                    "value": "feedback_collected",
                    "checked": checkOutData["feedbackCollected"],
                  }
                ],
                value: checkOutData["feedbackCollected"] ? [{"label": "Guest feedback collected", "value": "feedback_collected", "checked": true}] : [],
                onChanged: (values, ids) {
                  checkOutData["feedbackCollected"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Guest Comments",
                value: checkOutData["specialNotes"],
                hint: "Any specific feedback, compliments, or concerns from the guest...",
                onChanged: (value) {
                  checkOutData["specialNotes"] = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Thank You Message
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor, successColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.hotel,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: spSm),
              Text(
                "Thank You for Staying With Us!",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "We hope ${selectedGuest!["guestName"]} had a wonderful stay.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              if (selectedGuest!["loyaltyMember"] != null) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${selectedGuest!["loyaltyMember"]} Member - Thank you for your loyalty!",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _getSatisfactionText(int rating) {
    switch (rating) {
      case 1:
        return "Very Dissatisfied";
      case 2:
        return "Dissatisfied";
      case 3:
        return "Neutral";
      case 4:
        return "Satisfied";
      case 5:
        return "Very Satisfied";
      default:
        return "";
    }
  }

  Color _getSatisfactionColor(int rating) {
    switch (rating) {
      case 1:
        return dangerColor;
      case 2:
        return warningColor;
      case 3:
        return infoColor;
      case 4:
        return successColor;
      case 5:
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: checkOutSteps.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> step = entry.value;
          bool isActive = index == currentStep;
          bool isCompleted = step["completed"] || index < currentStep;
          
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor : (isActive ? primaryColor : disabledColor),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : step["icon"],
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${step["title"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? successColor : (isActive ? primaryColor : disabledBoldColor),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildSearchStep();
      case 1:
        return _buildRoomInspectionStep();
      case 2:
        return _buildBillSettlementStep();
      case 3:
        return _buildFeedbackStep();
      default:
        return Container();
    }
  }

  bool _canProceedToNextStep() {
    switch (currentStep) {
      case 0:
        return selectedGuest != null;
      case 1:
        return checkOutData["keyCardsReturned"] && 
               checkOutData["roomInspected"] && 
               checkOutData["minibarChecked"] && 
               checkOutData["damageAssessed"];
      case 2:
        return checkOutData["finalBillSettled"];
      case 3:
        return checkOutData["feedbackCollected"] && checkOutData["satisfactionRating"] > 0;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_canProceedToNextStep() && currentStep < checkOutSteps.length - 1) {
      checkOutSteps[currentStep]["completed"] = true;
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _processOutstandingPayment(double amount) async {
    setState(() {
      isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
      checkOutData["finalBillSettled"] = true;
      selectedGuest!["paidAmount"] = selectedGuest!["totalAmount"];
      selectedGuest!["remainingBalance"] = 0.0;
    });
    
    ss("Payment of \$${amount.currency} processed successfully!");
  }

  void _completeCheckOut() async {
    if (!_canProceedToNextStep()) {
      se("Please complete all required steps before finishing check-out.");
      return;
    }
    
    bool isConfirmed = await confirm("Complete check-out for ${selectedGuest!["guestName"]}?");
    if (!isConfirmed) return;
    
    setState(() {
      isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
      selectedGuest!["status"] = "Checked-out";
      checkOutSteps[currentStep]["completed"] = true;
    });
    
    ss("Check-out completed successfully! Thank you ${selectedGuest!["guestName"]}!");
    
    // Reset for next guest
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentStep = 0;
        selectedGuest = null;
        checkOutData = {
          "roomNumber": "",
          "guestName": "",
          "checkOutTime": "",
          "roomInspected": false,
          "keyCardsReturned": false,
          "minibarChecked": false,
          "damageAssessed": false,
          "additionalCharges": 0.0,
          "feedbackCollected": false,
          "finalBillSettled": false,
          "specialNotes": "",
          "satisfactionRating": 0,
        };
        for (var step in checkOutSteps) {
          step["completed"] = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Processing...",
                style: TextStyle(
                  fontSize: fsH6,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Check-out"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                searchQuery = "";
                selectedGuest = null;
                currentStep = 0;
                for (var step in checkOutSteps) {
                  step["completed"] = false;
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildStepIndicator(),
            SizedBox(height: spMd),
            _buildCurrentStepContent(),
            SizedBox(height: spMd),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: _previousStep,
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Expanded(
                  child: QButton(
                    label: currentStep == checkOutSteps.length - 1 ? "Complete Check-out" : "Next",
                    size: bs.md,
                    onPressed: currentStep == checkOutSteps.length - 1 ? _completeCheckOut : (_canProceedToNextStep() ? _nextStep : null),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
