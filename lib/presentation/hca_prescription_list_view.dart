import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPrescriptionListView extends StatefulWidget {
  const HcaPrescriptionListView({super.key});

  @override
  State<HcaPrescriptionListView> createState() => _HcaPrescriptionListViewState();
}

class _HcaPrescriptionListViewState extends State<HcaPrescriptionListView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedDoctor = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Completed", "value": "completed"},
    {"label": "Expired", "value": "expired"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> doctorOptions = [
    {"label": "All Doctors", "value": ""},
    {"label": "Dr. Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Dr. Michael Chen", "value": "michael_chen"},
    {"label": "Dr. Emily Rodriguez", "value": "emily_rodriguez"},
    {"label": "Dr. Jennifer Kim", "value": "jennifer_kim"},
  ];

  List<Map<String, dynamic>> prescriptions = [
    {
      "id": "1",
      "medicationName": "Lisinopril",
      "genericName": "ACE Inhibitor",
      "dosage": "10mg",
      "frequency": "Once daily",
      "duration": "90 days",
      "quantity": "90 tablets",
      "refillsRemaining": 2,
      "prescribedDate": "2024-01-15",
      "expiryDate": "2024-07-15",
      "status": "active",
      "doctor": "Dr. Sarah Johnson",
      "pharmacy": "Metropolitan Pharmacy",
      "indication": "High Blood Pressure",
      "instructions": "Take with or without food. Do not stop taking without consulting doctor.",
      "sideEffects": ["Dizziness", "Dry cough", "Hyperkalemia"],
      "interactions": ["NSAIDs", "Potassium supplements"],
      "cost": 25.50,
      "insurance": "Covered",
      "lastFilled": "2024-01-15",
      "nextRefill": "2024-02-14"
    },
    {
      "id": "2",
      "medicationName": "Metformin",
      "genericName": "Biguanide",
      "dosage": "500mg",
      "frequency": "Twice daily",
      "duration": "180 days",
      "quantity": "180 tablets",
      "refillsRemaining": 3,
      "prescribedDate": "2024-01-10",
      "expiryDate": "2024-10-10",
      "status": "active",
      "doctor": "Dr. Michael Chen",
      "pharmacy": "Heart & Wellness Pharmacy",
      "indication": "Type 2 Diabetes",
      "instructions": "Take with meals to reduce stomach upset. Monitor blood glucose regularly.",
      "sideEffects": ["Nausea", "Diarrhea", "Metallic taste"],
      "interactions": ["Alcohol", "Contrast dyes"],
      "cost": 15.75,
      "insurance": "Covered",
      "lastFilled": "2024-01-10",
      "nextRefill": "2024-02-09"
    },
    {
      "id": "3",
      "medicationName": "Simvastatin",
      "genericName": "HMG-CoA Reductase Inhibitor",
      "dosage": "20mg",
      "frequency": "Once daily (evening)",
      "duration": "365 days",
      "quantity": "365 tablets",
      "refillsRemaining": 5,
      "prescribedDate": "2024-01-05",
      "expiryDate": "2025-01-05",
      "status": "active",
      "doctor": "Dr. Sarah Johnson",
      "pharmacy": "Metropolitan Pharmacy",
      "indication": "High Cholesterol",
      "instructions": "Take in the evening with or without food. Avoid grapefruit juice.",
      "sideEffects": ["Muscle pain", "Liver problems", "Memory issues"],
      "interactions": ["Grapefruit juice", "Certain antibiotics"],
      "cost": 18.25,
      "insurance": "Covered",
      "lastFilled": "2024-01-05",
      "nextRefill": "2024-02-04"
    },
    {
      "id": "4",
      "medicationName": "Levothyroxine",
      "genericName": "Thyroid Hormone",
      "dosage": "75mcg",
      "frequency": "Once daily (morning)",
      "duration": "365 days",
      "quantity": "365 tablets",
      "refillsRemaining": 4,
      "prescribedDate": "2023-12-28",
      "expiryDate": "2024-12-28",
      "status": "active",
      "doctor": "Dr. Emily Rodriguez",
      "pharmacy": "Endocrine Care Pharmacy",
      "indication": "Hypothyroidism",
      "instructions": "Take on empty stomach, 30-60 minutes before breakfast. Do not take with calcium or iron.",
      "sideEffects": ["Heart palpitations", "Insomnia", "Weight loss"],
      "interactions": ["Calcium", "Iron", "Coffee"],
      "cost": 12.50,
      "insurance": "Covered",
      "lastFilled": "2023-12-28",
      "nextRefill": "2024-01-27"
    },
    {
      "id": "5",
      "medicationName": "Ibuprofen",
      "genericName": "NSAID",
      "dosage": "400mg",
      "frequency": "As needed",
      "duration": "30 days",
      "quantity": "60 tablets",
      "refillsRemaining": 0,
      "prescribedDate": "2023-12-20",
      "expiryDate": "2024-01-20",
      "status": "expired",
      "doctor": "Dr. Jennifer Kim",
      "pharmacy": "Quick Care Pharmacy",
      "indication": "Pain Relief",
      "instructions": "Take with food. Do not exceed 1200mg per day. Use for shortest duration possible.",
      "sideEffects": ["Stomach upset", "Dizziness", "Headache"],
      "interactions": ["Blood thinners", "ACE inhibitors"],
      "cost": 8.75,
      "insurance": "Not covered",
      "lastFilled": "2023-12-20",
      "nextRefill": "N/A"
    },
    {
      "id": "6",
      "medicationName": "Amoxicillin",
      "genericName": "Penicillin Antibiotic",
      "dosage": "500mg",
      "frequency": "Three times daily",
      "duration": "10 days",
      "quantity": "30 capsules",
      "refillsRemaining": 0,
      "prescribedDate": "2023-12-15",
      "expiryDate": "2023-12-25",
      "status": "completed",
      "doctor": "Dr. Sarah Johnson",
      "pharmacy": "Metropolitan Pharmacy",
      "indication": "Bacterial Infection",
      "instructions": "Take with or without food. Complete full course even if feeling better.",
      "sideEffects": ["Nausea", "Diarrhea", "Allergic reactions"],
      "interactions": ["Birth control pills", "Blood thinners"],
      "cost": 22.50,
      "insurance": "Covered",
      "lastFilled": "2023-12-15",
      "nextRefill": "N/A"
    }
  ];

  List<Map<String, dynamic>> get filteredPrescriptions {
    return prescriptions.where((prescription) {
      bool matchesSearch = searchQuery.isEmpty || 
          prescription["medicationName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          prescription["doctor"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          prescription["indication"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || 
          prescription["status"].toString().toLowerCase() == selectedStatus.toLowerCase();
      
      bool matchesDoctor = selectedDoctor.isEmpty || 
          prescription["doctor"].toString().toLowerCase().replaceAll(' ', '_').replaceAll('.', '') == selectedDoctor.toLowerCase();
      
      return matchesSearch && matchesStatus && matchesDoctor;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescriptions"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              ss("Scanning prescription QR code");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddPrescriptionDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildTabSection(),
          _buildSummarySection(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search medications, doctors...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: disabledColor,
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Doctor",
                  items: doctorOptions,
                  value: selectedDoctor,
                  onChanged: (value, label) {
                    selectedDoctor = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildTab("All", 0),
          _buildTab("Active", 1),
          _buildTab("Refills Due", 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    List<Map<String, dynamic>> displayPrescriptions = filteredPrescriptions;
    
    if (selectedTab == 1) {
      displayPrescriptions = filteredPrescriptions.where((p) => p["status"] == "active").toList();
    } else if (selectedTab == 2) {
      displayPrescriptions = filteredPrescriptions.where((p) => 
          p["status"] == "active" && DateTime.parse(p["nextRefill"]).isBefore(DateTime.now().add(Duration(days: 7)))).toList();
    }

    int activeCount = prescriptions.where((p) => p["status"] == "active").length;
    int expiredCount = prescriptions.where((p) => p["status"] == "expired").length;
    int refillsDue = prescriptions.where((p) => 
        p["status"] == "active" && DateTime.parse(p["nextRefill"]).isBefore(DateTime.now().add(Duration(days: 7)))).length;
    double totalCost = displayPrescriptions.fold(0.0, (sum, p) => sum + (p["cost"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 100,
        children: [
          _buildSummaryCard("Active", activeCount.toString(), Icons.medication, successColor),
          _buildSummaryCard("Refills Due", refillsDue.toString(), Icons.schedule, warningColor),
          _buildSummaryCard("Expired", expiredCount.toString(), Icons.error, dangerColor),
          _buildSummaryCard("Total Cost", "\$${totalCost.toStringAsFixed(2)}", Icons.attach_money, infoColor),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    List<Map<String, dynamic>> displayPrescriptions = filteredPrescriptions;
    
    if (selectedTab == 1) {
      displayPrescriptions = filteredPrescriptions.where((p) => p["status"] == "active").toList();
    } else if (selectedTab == 2) {
      displayPrescriptions = filteredPrescriptions.where((p) => 
          p["status"] == "active" && DateTime.parse(p["nextRefill"]).isBefore(DateTime.now().add(Duration(days: 7)))).toList();
    }

    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(spMd),
        children: [
          if (displayPrescriptions.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.medication,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No prescriptions found",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search criteria",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...displayPrescriptions.map((prescription) => _buildPrescriptionCard(prescription)).toList(),
        ],
      ),
    );
  }

  Widget _buildPrescriptionCard(Map<String, dynamic> prescription) {
    Color statusColor = prescription["status"] == "active" ? successColor : 
                       prescription["status"] == "expired" ? dangerColor :
                       prescription["status"] == "completed" ? infoColor : warningColor;
    
    bool isRefillDue = prescription["status"] == "active" && 
                      DateTime.parse(prescription["nextRefill"]).isBefore(DateTime.now().add(Duration(days: 7)));
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isRefillDue ? warningColor : statusColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.medication,
                    color: statusColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${prescription["medicationName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${prescription["genericName"]} • ${prescription["dosage"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      Text(
                        "${prescription["doctor"]}",
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${prescription["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isRefillDue)
                      Container(
                        margin: EdgeInsets.only(top: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "REFILL DUE",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_information,
                        color: primaryColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Indication:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${prescription["indication"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: infoColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Frequency:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${prescription["frequency"]}",
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
            SizedBox(height: spMd),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildInfoItem("Refills Left", "${prescription["refillsRemaining"]}", Icons.repeat, successColor),
                _buildInfoItem("Cost", "\$${(prescription["cost"] as double).toStringAsFixed(2)}", Icons.attach_money, infoColor),
                _buildInfoItem("Quantity", "${prescription["quantity"]}", Icons.inventory, primaryColor),
                _buildInfoItem("Expires", "${DateTime.parse(prescription["expiryDate"]).dMMMy}", Icons.event, warningColor),
              ],
            ),
            if (prescription["status"] == "active") ...[
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Next refill due: ${DateTime.parse(prescription["nextRefill"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _showPrescriptionDetails(prescription);
                    },
                  ),
                ),
                if (prescription["status"] == "active" && (prescription["refillsRemaining"] as int) > 0) ...[
                  SizedBox(width: spSm),
                  QButton(
                    label: "Refill",
                    size: bs.sm,
                    onPressed: () {
                      _showRefillDialog(prescription);
                    },
                  ),
                ],
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    ss("Sharing prescription");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPrescriptionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add Prescription",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Scan QR Code",
                      icon: Icons.qr_code_scanner,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Scanning prescription QR code");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Take Photo",
                      icon: Icons.camera_alt,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Taking photo of prescription");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Manual Entry",
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Opening manual entry form");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRefillDialog(Map<String, dynamic> prescription) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Refill Prescription",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${prescription["medicationName"]} ${prescription["dosage"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Pharmacy: ${prescription["pharmacy"]}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Refills remaining: ${prescription["refillsRemaining"]}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Cost: \$${(prescription["cost"] as double).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: spMd),
              Text(
                "Choose pickup method:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Pickup",
                      icon: Icons.store,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Refill ordered for pickup");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Delivery",
                      icon: Icons.delivery_dining,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Refill ordered for delivery");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrescriptionDetails(Map<String, dynamic> prescription) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${prescription["medicationName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Medication Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Generic Name: ${prescription["genericName"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                            Text(
                              "Dosage: ${prescription["dosage"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                            Text(
                              "Frequency: ${prescription["frequency"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                            Text(
                              "Duration: ${prescription["duration"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Instructions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${prescription["instructions"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Side Effects",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((prescription["sideEffects"] as List).map((effect) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${effect}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                      SizedBox(height: spMd),
                      Text(
                        "Drug Interactions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((prescription["interactions"] as List).map((interaction) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.dangerous,
                                color: dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${interaction}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                      SizedBox(height: spMd),
                      Text(
                        "Prescription Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Prescribed Date:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text("${DateTime.parse(prescription["prescribedDate"]).dMMMy}", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Expiry Date:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text("${DateTime.parse(prescription["expiryDate"]).dMMMy}", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Doctor:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text("${prescription["doctor"]}", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pharmacy:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text("${prescription["pharmacy"]}", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Insurance:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text("${prescription["insurance"]}", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (prescription["status"] == "active")
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Request Refill",
                          onPressed: () {
                            Navigator.pop(context);
                            _showRefillDialog(prescription);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Sharing prescription details");
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
