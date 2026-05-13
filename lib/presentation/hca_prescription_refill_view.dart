import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPrescriptionRefillView extends StatefulWidget {
  const HcaPrescriptionRefillView({super.key});

  @override
  State<HcaPrescriptionRefillView> createState() => _HcaPrescriptionRefillViewState();
}

class _HcaPrescriptionRefillViewState extends State<HcaPrescriptionRefillView> {
  String searchQuery = "";
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> prescriptions = [
    {
      "name": "Metformin",
      "dosage": "500mg",
      "frequency": "Twice daily",
      "remaining": 15,
      "totalPills": 60,
      "refillDate": "2025-06-25",
      "status": "active",
      "prescribedBy": "Dr. Smith",
      "category": "diabetes",
      "instructions": "Take with meals",
      "sideEffects": "Nausea, stomach upset",
      "cost": 25.50,
    },
    {
      "name": "Lisinopril",
      "dosage": "10mg",
      "frequency": "Once daily",
      "remaining": 8,
      "totalPills": 30,
      "refillDate": "2025-06-22",
      "status": "low",
      "prescribedBy": "Dr. Johnson",
      "category": "hypertension",
      "instructions": "Take in the morning",
      "sideEffects": "Dizziness, dry cough",
      "cost": 18.75,
    },
    {
      "name": "Atorvastatin",
      "dosage": "20mg",
      "frequency": "Once daily",
      "remaining": 25,
      "totalPills": 30,
      "refillDate": "2025-07-01",
      "status": "active",
      "prescribedBy": "Dr. Wilson",
      "category": "cholesterol",
      "instructions": "Take in the evening",
      "sideEffects": "Muscle pain, liver problems",
      "cost": 32.25,
    },
    {
      "name": "Omeprazole",
      "dosage": "40mg",
      "frequency": "Once daily",
      "remaining": 2,
      "totalPills": 30,
      "refillDate": "2025-06-20",
      "status": "critical",
      "prescribedBy": "Dr. Brown",
      "category": "gastric",
      "instructions": "Take before breakfast",
      "sideEffects": "Headache, stomach pain",
      "cost": 15.00,
    },
    {
      "name": "Aspirin",
      "dosage": "81mg",
      "frequency": "Once daily",
      "remaining": 45,
      "totalPills": 90,
      "refillDate": "2025-07-15",
      "status": "active",
      "prescribedBy": "Dr. Davis",
      "category": "cardiology",
      "instructions": "Take with food",
      "sideEffects": "Stomach irritation, bleeding",
      "cost": 8.50,
    },
  ];

  List<Map<String, dynamic>> get filteredPrescriptions {
    return prescriptions.where((prescription) {
      bool matchesSearch = prescription["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          prescription["prescribedBy"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" ||
                          prescription["status"] == selectedFilter ||
                          prescription["category"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "critical":
        return dangerColor;
      case "low":
        return warningColor;
      case "active":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription Refills"),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              // Set refill reminders
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search prescriptions",
                          value: searchQuery,
                          hint: "Search by name or doctor",
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  QCategoryPicker(
                    items: [
                      {"label": "All", "value": "all"},
                      {"label": "Critical", "value": "critical"},
                      {"label": "Low Stock", "value": "low"},
                      {"label": "Active", "value": "active"},
                      {"label": "Diabetes", "value": "diabetes"},
                      {"label": "Hypertension", "value": "hypertension"},
                    ],
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.medication,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${prescriptions.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Meds",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: dangerColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${prescriptions.where((p) => p["status"] == "critical" || p["status"] == "low").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Need Refill",
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

            // Prescriptions List
            ...filteredPrescriptions.map((prescription) {
              double percentage = (prescription["remaining"] as int) / (prescription["totalPills"] as int);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(prescription["status"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${prescription["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${prescription["dosage"]} - ${prescription["frequency"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(prescription["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${prescription["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(prescription["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pills Remaining",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${prescription["remaining"]} / ${prescription["totalPills"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: percentage,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getStatusColor(prescription["status"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Prescribed by: ${prescription["prescribedBy"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Next refill: ${prescription["refillDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Cost: \$${(prescription["cost"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Request Refill",
                            size: bs.sm,
                            onPressed: () {
                              // Request refill
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.info,
                          size: bs.sm,
                          onPressed: () {
                            _showPrescriptionDetails(prescription);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new prescription
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showPrescriptionDetails(Map<String, dynamic> prescription) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${prescription["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              // Dosage Info
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Dosage Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Strength: ${prescription["dosage"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Frequency: ${prescription["frequency"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Instructions: ${prescription["instructions"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Side Effects
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Possible Side Effects",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "${prescription["sideEffects"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Refill History
              Container(
                padding: EdgeInsets.all(spMd),
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
                      "Recent Refills",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...List.generate(3, (index) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Refilled on ${DateTime.now().subtract(Duration(days: 30 * (index + 1))).toString().split(' ')[0]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Text(
                              "\$${(prescription["cost"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
