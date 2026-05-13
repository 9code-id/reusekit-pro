import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketTransferView extends StatefulWidget {
  const EmaTicketTransferView({super.key});

  @override
  State<EmaTicketTransferView> createState() => _EmaTicketTransferViewState();
}

class _EmaTicketTransferViewState extends State<EmaTicketTransferView> {
  int currentStep = 0;
  String recipientEmail = "";
  String recipientName = "";
  String recipientPhone = "";
  String transferMessage = "";
  bool agreeToTerms = false;
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
        "transferable": true
      },
      {
        "id": "TKT-001-002", 
        "type": "Regular",
        "holder": "Jane Smith",
        "price": 150.0,
        "transferable": true
      },
      {
        "id": "TKT-002-001",
        "type": "VIP",
        "holder": "Mike Johnson", 
        "price": 250.0,
        "transferable": true
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Tickets"),
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
          _buildStepIndicator(0, "Select", Icons.confirmation_number),
          Expanded(child: _buildStepConnector(0)),
          _buildStepIndicator(1, "Recipient", Icons.person),
          Expanded(child: _buildStepConnector(1)),
          _buildStepIndicator(2, "Confirm", Icons.check_circle),
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
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(isCompleted || isActive ? 255 : 50),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: isCompleted || isActive ? Colors.white : color,
            size: 20,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
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
        return _buildSelectTicketsStep();
      case 1:
        return _buildRecipientDetailsStep();
      case 2:
        return _buildConfirmationStep();
      default:
        return _buildSelectTicketsStep();
    }
  }

  Widget _buildSelectTicketsStep() {
    final event = bookingData["event"] as Map<String, dynamic>;
    final tickets = bookingData["tickets"] as List;
    
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
                    "Select the tickets you want to transfer. The recipient will receive new tickets with their name.",
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
                  "Select Tickets to Transfer",
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
                                    Text(
                                      "\$${((ticket["price"] as double)).currency}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Current holder: ${ticket["holder"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Ticket ID: ${ticket["id"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
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
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${selectedTickets.length} ticket(s) selected for transfer",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
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

  Widget _buildRecipientDetailsStep() {
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
                Icon(Icons.warning, color: warningColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Make sure the recipient's details are correct. This information cannot be changed after transfer.",
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
                  "Recipient Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QTextField(
                  label: "Recipient Name",
                  value: recipientName,
                  hint: "Enter full name as it should appear on ticket",
                  validator: Validator.required,
                  onChanged: (value) {
                    recipientName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Recipient Email",
                  value: recipientEmail,
                  hint: "Email address for ticket delivery",
                  validator: Validator.email,
                  onChanged: (value) {
                    recipientEmail = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Recipient Phone",
                  value: recipientPhone,
                  hint: "Phone number (optional)",
                  onChanged: (value) {
                    recipientPhone = value;
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
                  "Transfer Message (Optional)",
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
                      hintText: "Add a personal message for the recipient...",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      transferMessage = value;
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
                  "Transfer Summary",
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
                      "\$${((ticket["price"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                )),
                Divider(),
                Row(
                  children: [
                    Text(
                      "Total Value:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "\$${selectedTickets.fold(0.0, (sum, ticket) => sum + (ticket["price"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(Icons.swap_horiz, color: primaryColor, size: 48),
                Text(
                  "Ready to Transfer",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Please review all details before confirming the transfer. This action cannot be undone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
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
                  "Transfer Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow("Recipient Name", recipientName),
                _buildDetailRow("Recipient Email", recipientEmail),
                if (recipientPhone.isNotEmpty)
                  _buildDetailRow("Recipient Phone", recipientPhone),
                _buildDetailRow("Tickets", "${selectedTickets.length} ticket(s)"),
                _buildDetailRow("Total Value", "\$${selectedTickets.fold(0.0, (sum, ticket) => sum + (ticket["price"] as double)).currency}"),
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
                  "Tickets Being Transferred",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...selectedTickets.map((ticket) => Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.confirmation_number, color: primaryColor, size: 20),
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
                              "From: ${ticket["holder"]} → To: $recipientName",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((ticket["price"] as double)).currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          if (transferMessage.isNotEmpty)
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
                    "Transfer Message",
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
                      transferMessage,
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
          Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (value) {
                  agreeToTerms = value ?? false;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
              Expanded(
                child: Text(
                  "I understand that this transfer is final and cannot be reversed. The recipient will receive new tickets with their name.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
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
              onPressed: _canProceed() ? _handleNext : null,
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
        return "Review Transfer";
      case 2:
        return "Confirm Transfer";
      default:
        return "Continue";
    }
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedTickets.isNotEmpty;
      case 1:
        return recipientName.isNotEmpty && recipientEmail.isNotEmpty;
      case 2:
        return agreeToTerms;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < 2) {
      currentStep++;
      setState(() {});
    } else {
      _processTransfer();
    }
  }

  void _processTransfer() async {
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
              "Transfer Successful!",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              "The tickets have been successfully transferred to $recipientName. They will receive an email with their new tickets shortly.",
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
