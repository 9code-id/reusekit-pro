import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketRefundView extends StatefulWidget {
  const EmaTicketRefundView({super.key});

  @override
  State<EmaTicketRefundView> createState() => _EmaTicketRefundViewState();
}

class _EmaTicketRefundViewState extends State<EmaTicketRefundView> {
  int currentStep = 0;
  String refundReason = "";
  String additionalComments = "";
  bool agreeToPolicy = false;
  List<Map<String, dynamic>> selectedTickets = [];
  
  Map<String, dynamic> bookingData = {
    "booking_id": "EMA-2024-001567",
    "event": {
      "title": "Flutter Conference 2024",
      "date": "2024-07-15",
      "location": "Grand Convention Center",
      "image": "https://picsum.photos/300/200?random=1&keyword=conference"
    },
    "tickets": [
      {
        "id": "TKT-001-001",
        "type": "Regular",
        "holder": "John Doe",
        "price": 150.0,
        "refundable": true,
        "refund_amount": 135.0
      },
      {
        "id": "TKT-001-002",
        "type": "Regular", 
        "holder": "Jane Smith",
        "price": 150.0,
        "refundable": true,
        "refund_amount": 135.0
      },
      {
        "id": "TKT-002-001",
        "type": "VIP",
        "holder": "Mike Johnson",
        "price": 250.0,
        "refundable": true,
        "refund_amount": 225.0
      }
    ],
    "refund_policy": {
      "processing_fee": 15.0,
      "processing_time": "5-7 business days",
      "deadline": "2024-07-08",
      "terms": [
        "Refunds are processed within 5-7 business days",
        "A processing fee of \$15 per ticket applies", 
        "Refunds must be requested at least 7 days before the event",
        "Refunds will be issued to the original payment method",
        "Special access tickets may have different refund terms"
      ]
    }
  };

  List<Map<String, dynamic>> refundReasons = [
    {"value": "schedule_conflict", "label": "Schedule Conflict"},
    {"value": "health_issues", "label": "Health Issues"},
    {"value": "travel_restrictions", "label": "Travel Restrictions"},
    {"value": "event_concerns", "label": "Event Concerns"},
    {"value": "financial_reasons", "label": "Financial Reasons"},
    {"value": "other", "label": "Other"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Refund"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: _buildStepContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Row(
        children: [
          _buildStepIndicator(0, "Policy", Icons.policy),
          Expanded(child: _buildStepConnector(0)),
          _buildStepIndicator(1, "Select", Icons.confirmation_number),
          Expanded(child: _buildStepConnector(1)),
          _buildStepIndicator(2, "Reason", Icons.comment),
          Expanded(child: _buildStepConnector(2)),
          _buildStepIndicator(3, "Confirm", Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, IconData icon) {
    final isActive = currentStep == step;
    final isCompleted = currentStep > step;
    
    Color color;
    if (isCompleted) {
      color = successColor;
    } else if (isActive) {
      color = primaryColor;
    } else {
      color = disabledBoldColor;
    }

    return Column(
      spacing: spXs,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withAlpha(isCompleted || isActive ? 255 : 50),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: isCompleted || isActive ? Colors.white : color,
            size: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(int step) {
    final isCompleted = currentStep > step;
    
    return Container(
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: spSm),
      decoration: BoxDecoration(
        color: isCompleted ? successColor : disabledColor,
        borderRadius: BorderRadius.circular(radiusXs),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPolicyStep();
      case 1:
        return _buildSelectTicketsStep();
      case 2:
        return _buildReasonStep();
      case 3:
        return _buildConfirmationStep();
      default:
        return _buildPolicyStep();
    }
  }

  Widget _buildPolicyStep() {
    final policy = bookingData["refund_policy"] as Map<String, dynamic>;
    final deadline = DateTime.parse("${policy["deadline"]}");
    final daysLeft = deadline.difference(DateTime.now()).inDays;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: daysLeft > 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: daysLeft > 0 ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  daysLeft > 0 ? Icons.schedule : Icons.warning,
                  color: daysLeft > 0 ? successColor : dangerColor,
                  size: 48,
                ),
                Text(
                  daysLeft > 0 ? "Refund Available" : "Refund Deadline Passed",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: daysLeft > 0 ? successColor : dangerColor,
                  ),
                ),
                Text(
                  daysLeft > 0 
                    ? "You have $daysLeft day(s) left to request a refund"
                    : "The refund deadline was ${deadline.dMMMy}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: daysLeft > 0 ? successColor : dangerColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Refund Policy",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPolicyDetailRow(Icons.access_time, "Processing Time", "${policy["processing_time"]}"),
                _buildPolicyDetailRow(Icons.attach_money, "Processing Fee", "\$${((policy["processing_fee"] as double)).currency} per ticket"),
                _buildPolicyDetailRow(Icons.calendar_today, "Deadline", "${deadline.dMMMy}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...(policy["terms"] as List).map((term) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$term",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: agreeToPolicy,
                onChanged: daysLeft > 0 ? (value) {
                  agreeToPolicy = value ?? false;
                  setState(() {});
                } : null,
                activeColor: primaryColor,
              ),
              Expanded(
                child: Text(
                  "I have read and agree to the refund policy and terms & conditions",
                  style: TextStyle(
                    fontSize: 14,
                    color: daysLeft > 0 ? disabledBoldColor : disabledColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: primaryColor),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectTicketsStep() {
    final event = bookingData["event"] as Map<String, dynamic>;
    final tickets = bookingData["tickets"] as List;
    final processingFee = (bookingData["refund_policy"]["processing_fee"] as double);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Select tickets for refund. Processing fee of \$${processingFee.currency} applies per ticket.",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Event Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${event["image"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(event["date"]).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${event["location"]}",
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
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Select Tickets for Refund",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...tickets.map((ticket) {
                  final isSelected = selectedTickets.any((t) => t["id"] == ticket["id"]);
                  
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedTickets.removeWhere((t) => t["id"] == ticket["id"]);
                      } else {
                        selectedTickets.add(ticket);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledBoldColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: isSelected
                                ? Icon(Icons.check, color: Colors.white, size: 14)
                                : null,
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
                                      "${ticket["type"]} Ticket",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Original: \$${((ticket["price"] as double)).currency}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          "Refund: \$${((ticket["refund_amount"] as double)).currency}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Holder: ${ticket["holder"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Processing fee: \$${processingFee.currency}",
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          if (selectedTickets.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor),
                      SizedBox(width: spSm),
                      Text(
                        "Refund Summary",
                        style: TextStyle(
                          color: successColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("${selectedTickets.length} ticket(s) selected"),
                      Spacer(),
                      Text(
                        "Total refund: \$${selectedTickets.fold(0.0, (sum, ticket) => sum + (ticket["refund_amount"] as double)).currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
  }

  Widget _buildReasonStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.help_outline, color: warningColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Please help us understand why you're requesting a refund. This information helps us improve our services.",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Reason for Refund",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QDropdownField(
                  label: "Select Reason",
                  items: refundReasons,
                  value: refundReason,
                  onChanged: (value, label) {
                    refundReason = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Additional Comments (Optional)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Please provide any additional details that might help us process your refund...",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      additionalComments = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Refund Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...selectedTickets.map((ticket) => Row(
                  children: [
                    Text("${ticket["type"]} - ${ticket["holder"]}"),
                    Spacer(),
                    Text(
                      "\$${((ticket["refund_amount"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                )),
                Divider(),
                Row(
                  children: [
                    Text(
                      "Total Refund:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "\$${selectedTickets.fold(0.0, (sum, ticket) => sum + (ticket["refund_amount"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: successColor,
                        fontSize: 16,
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
  }

  Widget _buildConfirmationStep() {
    final selectedReason = refundReasons.firstWhere(
      (reason) => reason["value"] == refundReason,
      orElse: () => {"label": ""},
    );
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(Icons.money_off, color: warningColor, size: 48),
                Text(
                  "Confirm Refund Request",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Please review your refund request. Once submitted, this action cannot be cancelled.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Refund Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow("Reason", "${selectedReason["label"]}"),
                _buildDetailRow("Tickets", "${selectedTickets.length} ticket(s)"),
                _buildDetailRow("Total Refund", "\$${selectedTickets.fold(0.0, (sum, ticket) => sum + (ticket["refund_amount"] as double)).currency}"),
                _buildDetailRow("Processing Time", "${bookingData["refund_policy"]["processing_time"]}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Tickets for Refund",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...selectedTickets.map((ticket) => Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.confirmation_number, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${ticket["type"]} Ticket",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Holder: ${ticket["holder"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((ticket["refund_amount"] as double)).currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          if (additionalComments.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Additional Comments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      additionalComments,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    final deadline = DateTime.parse("${bookingData["refund_policy"]["deadline"]}");
    final daysLeft = deadline.difference(DateTime.now()).inDays;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Back",
                size: bs.md,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          Expanded(
            flex: 2,
            child: QButton(
              label: _getNextButtonLabel(),
              size: bs.md,
              onPressed: _canProceed() && daysLeft > 0 ? _handleNext : null,
            ),
          ),
        ],
      ),
    );
  }

  String _getNextButtonLabel() {
    switch (currentStep) {
      case 0:
        return "Continue";
      case 1:
        return "Continue";
      case 2:
        return "Review Request";
      case 3:
        return "Submit Refund Request";
      default:
        return "Continue";
    }
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return agreeToPolicy;
      case 1:
        return selectedTickets.isNotEmpty;
      case 2:
        return refundReason.isNotEmpty;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < 3) {
      currentStep++;
      setState(() {});
    } else {
      _submitRefundRequest();
    }
  }

  void _submitRefundRequest() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 64,
            ),
            Text(
              "Refund Request Submitted!",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              "Your refund request has been submitted successfully. You will receive an email confirmation and updates on the processing status.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Done",
                size: bs.md,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
