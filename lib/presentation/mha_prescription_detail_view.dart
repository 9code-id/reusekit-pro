import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPrescriptionDetailView extends StatefulWidget {
  const MhaPrescriptionDetailView({super.key});

  @override
  State<MhaPrescriptionDetailView> createState() => _MhaPrescriptionDetailViewState();
}

class _MhaPrescriptionDetailViewState extends State<MhaPrescriptionDetailView> {
  Map<String, dynamic> prescription = {
    "id": 1,
    "prescriptionNumber": "RX-2024-001",
    "qrCode": "https://picsum.photos/200/200?random=1&keyword=qr",
    "doctorName": "Dr. Sarah Johnson",
    "doctorSpecialty": "General Medicine",
    "doctorLicense": "MD-12345-2020",
    "clinicName": "HealthCare Medical Center",
    "clinicAddress": "123 Medical Street, Health City, HC 12345",
    "clinicPhone": "+1 (555) 123-4567",
    "patientName": "John Doe",
    "patientAge": 32,
    "patientGender": "Male",
    "patientId": "P-2024-567",
    "issuedDate": "December 10, 2024",
    "validUntil": "January 10, 2025",
    "status": "active",
    "diagnosis": "Upper respiratory tract infection with mild fever",
    "symptoms": "Cough, fever, headache, fatigue",
    "vitalSigns": {
      "temperature": "101.2°F",
      "bloodPressure": "120/80 mmHg",
      "heartRate": "78 bpm",
      "weight": "70 kg"
    },
    "notes": "Patient advised to maintain hydration and rest. Follow up if symptoms persist beyond 7 days.",
    "followUpDate": "December 17, 2024",
    "totalMedicines": 3,
    "pharmacyFilled": "MedPlus Pharmacy",
    "fillDate": "December 10, 2024",
    "pharmacistName": "Dr. Mark Wilson",
    "medicines": [
      {
        "id": 1,
        "name": "Paracetamol",
        "strength": "500mg",
        "form": "Tablet",
        "dosage": "1 tablet twice daily",
        "duration": "5 days",
        "instructions": "Take after meals with plenty of water",
        "quantity": 10,
        "price": 5.50,
        "manufacturer": "PharmaCorp",
        "batchNumber": "PC2024-001",
        "expiryDate": "Dec 2026",
        "filled": true,
        "filledDate": "Dec 10, 2024",
        "remainingDoses": 8
      },
      {
        "id": 2,
        "name": "Cetirizine",
        "strength": "10mg",
        "form": "Tablet",
        "dosage": "1 tablet once daily",
        "duration": "7 days",
        "instructions": "Take before bedtime. May cause drowsiness",
        "quantity": 7,
        "price": 8.25,
        "manufacturer": "MediPharm",
        "batchNumber": "MP2024-002",
        "expiryDate": "Nov 2025",
        "filled": true,
        "filledDate": "Dec 10, 2024",
        "remainingDoses": 6
      },
      {
        "id": 3,
        "name": "Vitamin D3",
        "strength": "1000IU",
        "form": "Capsule",
        "dosage": "1 capsule daily",
        "duration": "30 days",
        "instructions": "Take with breakfast for better absorption",
        "quantity": 30,
        "price": 12.75,
        "manufacturer": "VitaHealth",
        "batchNumber": "VH2024-003",
        "expiryDate": "Mar 2026",
        "filled": false,
        "filledDate": null,
        "remainingDoses": 30
      }
    ]
  };

  List<Map<String, dynamic>> dosageHistory = [
    {
      "medicineId": 1,
      "medicineName": "Paracetamol 500mg",
      "takenDate": "Dec 12, 2024",
      "takenTime": "8:30 AM",
      "status": "taken",
      "notes": "Taken with breakfast"
    },
    {
      "medicineId": 1,
      "medicineName": "Paracetamol 500mg",
      "takenDate": "Dec 12, 2024",
      "takenTime": "8:30 PM",
      "status": "taken",
      "notes": "Taken with dinner"
    },
    {
      "medicineId": 2,
      "medicineName": "Cetirizine 10mg",
      "takenDate": "Dec 12, 2024",
      "takenTime": "10:00 PM",
      "status": "taken",
      "notes": "Taken before bed"
    },
    {
      "medicineId": 1,
      "medicineName": "Paracetamol 500mg",
      "takenDate": "Dec 11, 2024",
      "takenTime": "8:00 PM",
      "status": "missed",
      "notes": "Forgot to take evening dose"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _sharePrescription();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadPrescription();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prescription Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${prescription["prescriptionNumber"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusText(prescription["status"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${prescription["qrCode"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Issued Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${prescription["issuedDate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Valid Until",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${prescription["validUntil"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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

            SizedBox(height: spLg),

            // Doctor Information
            _buildSectionCard(
              "Doctor Information",
              Icons.person,
              [
                _buildInfoRow("Name", "${prescription["doctorName"]}"),
                _buildInfoRow("Specialty", "${prescription["doctorSpecialty"]}"),
                _buildInfoRow("License", "${prescription["doctorLicense"]}"),
                _buildInfoRow("Clinic", "${prescription["clinicName"]}"),
                _buildInfoRow("Address", "${prescription["clinicAddress"]}"),
                _buildInfoRow("Phone", "${prescription["clinicPhone"]}"),
              ],
            ),

            SizedBox(height: spMd),

            // Patient Information
            _buildSectionCard(
              "Patient Information",
              Icons.account_circle,
              [
                _buildInfoRow("Name", "${prescription["patientName"]}"),
                _buildInfoRow("Age", "${prescription["patientAge"]} years"),
                _buildInfoRow("Gender", "${prescription["patientGender"]}"),
                _buildInfoRow("Patient ID", "${prescription["patientId"]}"),
              ],
            ),

            SizedBox(height: spMd),

            // Medical Information
            _buildSectionCard(
              "Medical Information",
              Icons.medical_information,
              [
                _buildInfoRow("Diagnosis", "${prescription["diagnosis"]}"),
                _buildInfoRow("Symptoms", "${prescription["symptoms"]}"),
                if (prescription["notes"] != null)
                  _buildInfoRow("Doctor's Notes", "${prescription["notes"]}"),
                if (prescription["followUpDate"] != null)
                  _buildInfoRow("Follow-up Date", "${prescription["followUpDate"]}"),
              ],
            ),

            SizedBox(height: spMd),

            // Vital Signs
            if (prescription["vitalSigns"] != null)
              _buildSectionCard(
                "Vital Signs",
                Icons.monitor_heart,
                [
                  _buildInfoRow("Temperature", "${prescription["vitalSigns"]["temperature"]}"),
                  _buildInfoRow("Blood Pressure", "${prescription["vitalSigns"]["bloodPressure"]}"),
                  _buildInfoRow("Heart Rate", "${prescription["vitalSigns"]["heartRate"]}"),
                  _buildInfoRow("Weight", "${prescription["vitalSigns"]["weight"]}"),
                ],
              ),

            SizedBox(height: spMd),

            // Prescribed Medicines
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.medication, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Prescribed Medicines (${prescription["totalMedicines"]})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...(prescription["medicines"] as List).map((medicine) {
                    return _buildMedicineCard(medicine);
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Pharmacy Information
            if (prescription["pharmacyFilled"] != null)
              _buildSectionCard(
                "Pharmacy Information",
                Icons.local_pharmacy,
                [
                  _buildInfoRow("Pharmacy", "${prescription["pharmacyFilled"]}"),
                  _buildInfoRow("Fill Date", "${prescription["fillDate"]}"),
                  _buildInfoRow("Pharmacist", "${prescription["pharmacistName"]}"),
                ],
              ),

            SizedBox(height: spMd),

            // Dosage Tracking
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, color: infoColor),
                        SizedBox(width: spSm),
                        Text(
                          "Recent Dosage History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...dosageHistory.take(5).map((dose) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dose["status"] == "taken" 
                                ? successColor.withAlpha(50) 
                                : dangerColor.withAlpha(50),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              dose["status"] == "taken" ? Icons.check : Icons.close,
                              size: 16,
                              color: dose["status"] == "taken" ? successColor : dangerColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${dose["medicineName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${dose["takenDate"]} at ${dose["takenTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (dose["notes"] != null && dose["notes"].isNotEmpty)
                                  Text(
                                    "${dose["notes"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            dose["status"] == "taken" ? "Taken" : "Missed",
                            style: TextStyle(
                              fontSize: 12,
                              color: dose["status"] == "taken" ? successColor : dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Set Reminders",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to set reminders
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Order Medicine",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to order medicine
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            if (prescription["status"] != "expired")
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Contact Doctor",
                  size: bs.md,
                  onPressed: () {
                    // Contact doctor
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> medicine) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${medicine["name"]} ${medicine["strength"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${medicine["form"]} • ${medicine["manufacturer"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: medicine["filled"] 
                    ? successColor.withAlpha(50)
                    : warningColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  medicine["filled"] ? "Filled" : "Not Filled",
                  style: TextStyle(
                    fontSize: 10,
                    color: medicine["filled"] ? successColor : warningColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildMedicineInfoRow("Dosage", "${medicine["dosage"]}"),
                _buildMedicineInfoRow("Duration", "${medicine["duration"]}"),
                _buildMedicineInfoRow("Quantity", "${medicine["quantity"]}"),
                _buildMedicineInfoRow("Instructions", "${medicine["instructions"]}"),
                if (medicine["filled"]) ...[
                  _buildMedicineInfoRow("Batch No", "${medicine["batchNumber"]}"),
                  _buildMedicineInfoRow("Expiry", "${medicine["expiryDate"]}"),
                  _buildMedicineInfoRow("Price", "\$${(medicine["price"] as double).currency}"),
                  _buildMedicineInfoRow("Remaining", "${medicine["remainingDoses"]} doses"),
                ],
              ],
            ),
          ),
          
          if (!medicine["filled"]) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Order This Medicine",
                size: bs.sm,
                onPressed: () {
                  // Order specific medicine
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMedicineInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "partially_filled":
        return "Partially Filled";
      case "filled":
        return "Filled";
      case "expired":
        return "Expired";
      default:
        return "Unknown";
    }
  }

  void _sharePrescription() {
    // Share prescription
    ss("Prescription shared successfully");
  }

  void _downloadPrescription() {
    // Download prescription
    ss("Prescription downloaded successfully");
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.print, color: primaryColor),
                title: Text("Print Prescription"),
                onTap: () {
                  back();
                  // Print prescription
                },
              ),
              ListTile(
                leading: Icon(Icons.email, color: primaryColor),
                title: Text("Email to Doctor"),
                onTap: () {
                  back();
                  // Email to doctor
                },
              ),
              ListTile(
                leading: Icon(Icons.refresh, color: primaryColor),
                title: Text("Request Renewal"),
                onTap: () {
                  back();
                  // Request renewal
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: dangerColor),
                title: Text("Report Issue"),
                onTap: () {
                  back();
                  // Report issue
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
