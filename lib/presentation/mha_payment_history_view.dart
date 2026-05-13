import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPaymentHistoryView extends StatefulWidget {
  const MhaPaymentHistoryView({super.key});

  @override
  State<MhaPaymentHistoryView> createState() => _MhaPaymentHistoryViewState();
}

class _MhaPaymentHistoryViewState extends State<MhaPaymentHistoryView> {
  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "PAY001",
      "date": "2024-03-15",
      "type": "Doctor Consultation",
      "provider": "Dr. Sarah Wilson",
      "amount": 150.00,
      "status": "Paid",
      "method": "Credit Card",
      "cardLast4": "4567",
      "description": "General Consultation Fee",
    },
    {
      "id": "PAY002", 
      "date": "2024-03-10",
      "type": "Lab Test",
      "provider": "HealthLab Central",
      "amount": 85.50,
      "status": "Paid",
      "method": "Insurance",
      "coverage": "80%",
      "description": "Blood Work Panel",
    },
    {
      "id": "PAY003",
      "date": "2024-03-08",
      "type": "Prescription",
      "provider": "MediPharm Pharmacy",
      "amount": 32.75,
      "status": "Paid",
      "method": "Debit Card",
      "cardLast4": "8901",
      "description": "Antibiotics & Supplements",
    },
    {
      "id": "PAY004",
      "date": "2024-03-05",
      "type": "Specialist Visit",
      "provider": "Dr. Michael Chen - Cardiologist",
      "amount": 250.00,
      "status": "Pending",
      "method": "Insurance Claim",
      "coverage": "90%",
      "description": "Cardiology Follow-up",
    },
    {
      "id": "PAY005",
      "date": "2024-02-28",
      "type": "Emergency Visit",
      "provider": "City General Hospital",
      "amount": 450.00,
      "status": "Paid",
      "method": "Credit Card",
      "cardLast4": "2345",
      "description": "Emergency Room Treatment",
    },
    {
      "id": "PAY006",
      "date": "2024-02-25",
      "type": "Dental Cleaning",
      "provider": "Bright Smile Dental",
      "amount": 120.00,
      "status": "Paid",
      "method": "Cash",
      "cardLast4": "",
      "description": "Routine Dental Cleaning",
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Paid", "Pending", "Overdue"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPayments = paymentHistory.where((payment) {
      if (selectedFilter == "All") return true;
      return payment["status"] == selectedFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Spent",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((paymentHistory.where((p) => p["status"] == "Paid").map((p) => p["amount"] as double).fold(0.0, (sum, amount) => sum + amount))).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((paymentHistory.where((p) => p["status"] == "Pending").map((p) => p["amount"] as double).fold(0.0, (sum, amount) => sum + amount))).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filter Options
            QCategoryPicker(
              label: "Filter by Status",
              items: filterOptions.map((filter) => {
                "label": filter,
                "value": filter,
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Payment History List
            Text(
              "Recent Payments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredPayments.map((payment) {
              Color statusColor = payment["status"] == "Paid" 
                  ? successColor 
                  : payment["status"] == "Pending" 
                      ? warningColor 
                      : dangerColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${payment["type"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${payment["provider"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(payment["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${payment["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse(payment["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "ID: ${payment["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                payment["method"] == "Credit Card" || payment["method"] == "Debit Card"
                                    ? Icons.credit_card
                                    : payment["method"] == "Insurance"
                                        ? Icons.security
                                        : Icons.account_balance_wallet,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${payment["method"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              if (payment["cardLast4"] != null && payment["cardLast4"] != "")
                                Text(
                                  " •••• ${payment["cardLast4"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              if (payment["coverage"] != null)
                                Text(
                                  " (${payment["coverage"]} covered)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                          if (payment["description"] != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${payment["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Receipt",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Load More Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Payments",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
