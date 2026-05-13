import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPaymentScheduleView extends StatefulWidget {
  const ReaPaymentScheduleView({Key? key}) : super(key: key);

  @override
  State<ReaPaymentScheduleView> createState() => _ReaPaymentScheduleViewState();
}

class _ReaPaymentScheduleViewState extends State<ReaPaymentScheduleView> {
  String selectedProperty = "Luxury Villa - Downtown";
  String paymentType = "construction";
  
  List<Map<String, dynamic>> properties = [
    {
      "id": "1",
      "name": "Luxury Villa - Downtown",
      "type": "Villa",
      "totalAmount": 2500000.0,
      "paidAmount": 750000.0,
    },
    {
      "id": "2", 
      "name": "Modern Apartment - City Center",
      "type": "Apartment",
      "totalAmount": 1800000.0,
      "paidAmount": 540000.0,
    },
    {
      "id": "3",
      "name": "Family House - Suburbs",
      "type": "House", 
      "totalAmount": 1200000.0,
      "paidAmount": 360000.0,
    },
  ];

  List<Map<String, dynamic>> constructionPayments = [
    {
      "phase": "Booking Amount",
      "percentage": 10,
      "amount": 250000.0,
      "dueDate": "2024-01-15",
      "status": "paid",
      "paidDate": "2024-01-10",
      "description": "Initial booking amount to secure the property"
    },
    {
      "phase": "Foundation",
      "percentage": 20,
      "amount": 500000.0,
      "dueDate": "2024-03-15",
      "status": "paid",
      "paidDate": "2024-03-12",
      "description": "Foundation and basement construction"
    },
    {
      "phase": "Structure",
      "percentage": 25,
      "amount": 625000.0,
      "dueDate": "2024-06-15",
      "status": "overdue",
      "daysOverdue": 15,
      "description": "Main structure and framework"
    },
    {
      "phase": "Roofing",
      "percentage": 15,
      "amount": 375000.0,
      "dueDate": "2024-08-15",
      "status": "upcoming",
      "description": "Roofing and waterproofing"
    },
    {
      "phase": "Finishing",
      "percentage": 20,
      "amount": 500000.0,
      "dueDate": "2024-10-15", 
      "status": "upcoming",
      "description": "Interior finishing and fixtures"
    },
    {
      "phase": "Final Payment",
      "percentage": 10,
      "amount": 250000.0,
      "dueDate": "2024-12-15",
      "status": "upcoming",
      "description": "Final handover payment"
    },
  ];

  List<Map<String, dynamic>> loanPayments = [
    {
      "month": 1,
      "dueDate": "2024-07-01",
      "principalAmount": 8543.0,
      "interestAmount": 6250.0,
      "totalAmount": 14793.0,
      "remainingBalance": 991457.0,
      "status": "paid",
      "paidDate": "2024-06-28"
    },
    {
      "month": 2,
      "dueDate": "2024-08-01",
      "principalAmount": 8607.0,
      "interestAmount": 6186.0,
      "totalAmount": 14793.0,
      "remainingBalance": 982850.0,
      "status": "paid",
      "paidDate": "2024-07-30"
    },
    {
      "month": 3,
      "dueDate": "2024-09-01",
      "principalAmount": 8671.0,
      "interestAmount": 6122.0,
      "totalAmount": 14793.0,
      "remainingBalance": 974179.0,
      "status": "upcoming",
    },
    {
      "month": 4,
      "dueDate": "2024-10-01",
      "principalAmount": 8736.0,
      "interestAmount": 6057.0,
      "totalAmount": 14793.0,
      "remainingBalance": 965443.0,
      "status": "upcoming",
    },
    {
      "month": 5,
      "dueDate": "2024-11-01",
      "principalAmount": 8801.0,
      "interestAmount": 5992.0,
      "totalAmount": 14793.0,
      "remainingBalance": 956642.0,
      "status": "upcoming",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              // Navigate to calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Payment schedule downloaded");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Property Selection
            Container(
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
                  Text(
                    "Select Property",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Property",
                    items: properties.map((property) => {
                      "label": "${property["name"]}",
                      "value": "${property["name"]}",
                    }).toList(),
                    value: selectedProperty,
                    onChanged: (value, label) {
                      selectedProperty = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QCategoryPicker(
                          items: [
                            {
                              "label": "Construction",
                              "value": "construction",
                            },
                            {
                              "label": "Loan EMI",
                              "value": "loan",
                            },
                          ],
                          value: paymentType,
                          onChanged: (index, label, value, item) {
                            paymentType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payment Summary
            _buildPaymentSummary(),

            // Payment Schedule
            if (paymentType == "construction") 
              _buildConstructionSchedule()
            else 
              _buildLoanSchedule(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    Map<String, dynamic> property = properties.firstWhere(
      (p) => p["name"] == selectedProperty,
      orElse: () => properties[0],
    );

    double totalAmount = (property["totalAmount"] as num).toDouble();
    double paidAmount = (property["paidAmount"] as num).toDouble();
    double remainingAmount = totalAmount - paidAmount;
    double progressPercentage = (paidAmount / totalAmount) * 100;

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
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalAmount.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Paid Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${paidAmount.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Remaining",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${remainingAmount.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${progressPercentage.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: progressPercentage / 100,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConstructionSchedule() {
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
          Text(
            "Construction Payment Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...constructionPayments.map((payment) => _buildConstructionPaymentItem(payment)),
        ],
      ),
    );
  }

  Widget _buildConstructionPaymentItem(Map<String, dynamic> payment) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (payment["status"]) {
      case "paid":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        statusText = "Paid";
        break;
      case "overdue":
        statusColor = dangerColor;
        statusIcon = Icons.warning;
        statusText = "Overdue";
        break;
      default:
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        statusText = "Upcoming";
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${payment["phase"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 12,
                      color: statusColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${payment["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((payment["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "Percentage",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${payment["percentage"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "Due Date",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(payment["dueDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (payment["status"] == "paid")
            Container(
              margin: EdgeInsets.only(top: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 16,
                    color: successColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Paid on ${DateTime.parse(payment["paidDate"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          if (payment["status"] == "overdue")
            Container(
              margin: EdgeInsets.only(top: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Overdue by ${payment["daysOverdue"]} days",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Pay Now",
                    size: bs.sm,
                    onPressed: () {
                      // Handle payment
                    },
                  ),
                ],
              ),
            ),
          if (payment["status"] == "upcoming")
            Container(
              margin: EdgeInsets.only(top: spXs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  QButton(
                    label: "Set Reminder",
                    size: bs.sm,
                    onPressed: () {
                      ss("Payment reminder set");
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoanSchedule() {
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
          Text(
            "Loan EMI Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monthly EMI",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$14,793",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...loanPayments.map((payment) => _buildLoanPaymentItem(payment)),
          Container(
            margin: EdgeInsets.only(top: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QButton(
                  label: "View Full Schedule",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to full schedule
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanPaymentItem(Map<String, dynamic> payment) {
    Color statusColor = payment["status"] == "paid" ? successColor : warningColor;
    IconData statusIcon = payment["status"] == "paid" ? Icons.check_circle : Icons.schedule;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "EMI ${payment["month"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Icon(
                    statusIcon,
                    size: 16,
                    color: statusColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${payment["status"] == "paid" ? "Paid" : "Upcoming"}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "Principal",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((payment["principalAmount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "Interest",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((payment["interestAmount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      "Total EMI",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((payment["totalAmount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Due: ${DateTime.parse(payment["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Balance: \$${((payment["remainingBalance"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if (payment["status"] == "paid")
            Container(
              margin: EdgeInsets.only(top: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 14,
                    color: successColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Paid on ${DateTime.parse(payment["paidDate"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
