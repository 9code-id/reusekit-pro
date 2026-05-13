import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaBillsView extends StatefulWidget {
  const MhaBillsView({super.key});

  @override
  State<MhaBillsView> createState() => _MhaBillsViewState();
}

class _MhaBillsViewState extends State<MhaBillsView> {
  List<Map<String, dynamic>> bills = [
    {
      "id": "BILL001",
      "date": "2024-03-20",
      "dueDate": "2024-04-05",
      "provider": "City General Hospital",
      "service": "Emergency Room Visit",
      "amount": 1250.00,
      "status": "Pending",
      "insuranceCovered": 1000.00,
      "patientResponsibility": 250.00,
      "billType": "Hospital",
      "description": "Emergency treatment and diagnostic tests",
    },
    {
      "id": "BILL002",
      "date": "2024-03-18",
      "dueDate": "2024-04-02",
      "provider": "Dr. Sarah Wilson",
      "service": "Specialist Consultation",
      "amount": 350.00,
      "status": "Overdue",
      "insuranceCovered": 280.00,
      "patientResponsibility": 70.00,
      "billType": "Doctor",
      "description": "Cardiology consultation and follow-up",
    },
    {
      "id": "BILL003",
      "date": "2024-03-15",
      "dueDate": "2024-03-30",
      "provider": "HealthLab Central",
      "service": "Laboratory Tests",
      "amount": 180.50,
      "status": "Paid",
      "insuranceCovered": 144.40,
      "patientResponsibility": 36.10,
      "billType": "Lab",
      "description": "Complete blood panel and lipid profile",
    },
    {
      "id": "BILL004",
      "date": "2024-03-12",
      "dueDate": "2024-03-27",
      "provider": "MediPharm Pharmacy",
      "service": "Prescription Medications",
      "amount": 95.75,
      "status": "Pending",
      "insuranceCovered": 76.60,
      "patientResponsibility": 19.15,
      "billType": "Pharmacy",
      "description": "Monthly prescription refills",
    },
    {
      "id": "BILL005",
      "date": "2024-03-10",
      "dueDate": "2024-03-25",
      "provider": "Bright Smile Dental",
      "service": "Dental Procedure",
      "amount": 450.00,
      "status": "Pending",
      "insuranceCovered": 225.00,
      "patientResponsibility": 225.00,
      "billType": "Dental",
      "description": "Root canal treatment and crown",
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Pending", "Paid", "Overdue"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBills = bills.where((bill) {
      if (selectedFilter == "All") return true;
      return bill["status"] == selectedFilter;
    }).toList();

    double totalAmount = bills.fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double totalPending = bills.where((b) => b["status"] == "Pending" || b["status"] == "Overdue")
        .fold(0.0, (sum, bill) => sum + (bill["patientResponsibility"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Bills"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
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
                          "Total Bills",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${totalAmount.currency}",
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
                          "Amount Due",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${totalPending.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Pay All Due",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Set Auto-Pay",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

            // Bills List
            Text(
              "Your Bills",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredBills.map((bill) {
              Color statusColor = bill["status"] == "Paid" 
                  ? successColor 
                  : bill["status"] == "Pending" 
                      ? warningColor 
                      : dangerColor;

              IconData billIcon = bill["billType"] == "Hospital"
                  ? Icons.local_hospital
                  : bill["billType"] == "Doctor"
                      ? Icons.person
                      : bill["billType"] == "Lab"
                          ? Icons.science
                          : bill["billType"] == "Pharmacy"
                              ? Icons.medication
                              : Icons.medical_services;

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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            billIcon,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${bill["service"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${bill["provider"]}",
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
                                "${bill["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                            Text(
                              "Bill #${bill["id"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: spXs,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(bill["amount"] as double).currency}",
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
                                  spacing: spXs,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Your Responsibility",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(bill["patientResponsibility"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: bill["status"] == "Paid" ? successColor : dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.security,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Insurance covers \$${(bill["insuranceCovered"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                          "Bill Date: ${DateTime.parse(bill["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: bill["status"] == "Overdue" ? dangerColor : warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${DateTime.parse(bill["dueDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: bill["status"] == "Overdue" ? dangerColor : warningColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    if (bill["description"] != null)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.description,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${bill["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (bill["status"] != "Paid")
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Pay Now",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.payment,
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
                      )
                    else
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
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),

            // Add New Bill Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add Manual Bill Entry",
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
