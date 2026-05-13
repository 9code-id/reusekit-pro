import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaOrganDonorView extends StatefulWidget {
  const HcaOrganDonorView({super.key});

  @override
  State<HcaOrganDonorView> createState() => _HcaOrganDonorViewState();
}

class _HcaOrganDonorViewState extends State<HcaOrganDonorView> {
  bool isOrganDonor = true;
  bool isTissueDonor = true;
  bool isEyeDonor = true;
  bool isWholeBodayDonation = false;
  String donorRegistryId = "DON123456789";
  String donorCardNumber = "DC987654321";
  DateTime registrationDate = DateTime(2023, 6, 15);
  String specialInstructions = "No specific restrictions. Contact family before proceeding with donation.";
  
  List<Map<String, dynamic>> organSelections = [
    {
      "organ": "Heart",
      "selected": true,
      "icon": Icons.favorite,
      "description": "Cardiac muscle and valves"
    },
    {
      "organ": "Kidneys",
      "selected": true,
      "icon": Icons.water_drop,
      "description": "Both kidneys for transplantation"
    },
    {
      "organ": "Liver",
      "selected": true,
      "icon": Icons.local_hospital,
      "description": "Liver tissue and cells"
    },
    {
      "organ": "Lungs",
      "selected": true,
      "icon": Icons.air,
      "description": "Lung tissue for transplantation"
    },
    {
      "organ": "Pancreas",
      "selected": false,
      "icon": Icons.medical_services,
      "description": "Pancreatic cells and tissue"
    },
    {
      "organ": "Small Intestine",
      "selected": false,
      "icon": Icons.settings,
      "description": "Intestinal tissue"
    },
  ];
  
  List<Map<String, dynamic>> tissueSelections = [
    {
      "tissue": "Corneas",
      "selected": true,
      "icon": Icons.visibility,
      "description": "Eye tissue for vision restoration"
    },
    {
      "tissue": "Skin",
      "selected": true,
      "icon": Icons.healing,
      "description": "Skin grafts for burn victims"
    },
    {
      "tissue": "Bone",
      "selected": true,
      "icon": Icons.construction,
      "description": "Bone tissue and marrow"
    },
    {
      "tissue": "Heart Valves",
      "selected": true,
      "icon": Icons.favorite_border,
      "description": "Cardiac valve tissue"
    },
    {
      "tissue": "Tendons",
      "selected": false,
      "icon": Icons.sports,
      "description": "Connective tissue"
    },
    {
      "tissue": "Cartilage",
      "selected": false,
      "icon": Icons.join_inner,
      "description": "Joint and cartilage tissue"
    },
  ];
  
  List<Map<String, dynamic>> donationFacts = [
    {
      "title": "One Donor Can Save 8 Lives",
      "description": "Through organ donation, one person can save up to 8 lives and enhance the lives of up to 75 others through tissue donation.",
      "icon": Icons.favorite,
      "color": dangerColor
    },
    {
      "title": "22 People Die Daily",
      "description": "On average, 22 people die each day waiting for transplants due to the shortage of donated organs.",
      "icon": Icons.schedule,
      "color": warningColor
    },
    {
      "title": "100,000+ Waiting",
      "description": "More than 100,000 Americans are currently on the national organ transplant waiting list.",
      "icon": Icons.people,
      "color": infoColor
    },
    {
      "title": "Age No Barrier",
      "description": "There's no age limit for organ donation. Medical professionals determine suitability at the time of death.",
      "icon": Icons.accessibility,
      "color": successColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organ Donor Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareDonorCard();
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printDonorCard();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDonorStatus(),
            _buildDonorCard(),
            _buildOrganSelection(),
            _buildTissueSelection(),
            _buildSpecialInstructions(),
            _buildDonationFacts(),
            _buildRegistrationInfo(),
            _buildLegalInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isOrganDonor 
              ? [successColor, successColor.withAlpha(180)]
              : [disabledBoldColor, disabledBoldColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  isOrganDonor ? Icons.volunteer_activism : Icons.block,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOrganDonor ? "Registered Organ Donor" : "Not Registered",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isOrganDonor 
                          ? "You are helping save lives through organ donation"
                          : "Consider registering to help save lives",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isOrganDonor) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Register as Organ Donor",
                size: bs.md,
                onPressed: () {
                  _registerAsDonor();
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDonorCard() {
    if (!isOrganDonor) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_membership,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Donor Card",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "ORGAN DONOR",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Registry ID: $donorRegistryId",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
                Text(
                  "Card Number: $donorCardNumber",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildDonorBadge("ORGANS", isOrganDonor),
                    SizedBox(width: spXs),
                    _buildDonorBadge("TISSUE", isTissueDonor),
                    SizedBox(width: spXs),
                    _buildDonorBadge("EYES", isEyeDonor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorBadge(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(100),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isActive ? primaryColor : Colors.white,
        ),
      ),
    );
  }

  Widget _buildOrganSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Organ Donation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Organ Donor",
            items: [
              {
                "label": "I consent to organ donation",
                "value": true,
                "checked": isOrganDonor,
              }
            ],
            value: [
              if (isOrganDonor)
                {
                  "label": "I consent to organ donation",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                isOrganDonor = values.isNotEmpty;
              });
            },
          ),
          if (isOrganDonor) ...[
            Text(
              "Select organs for donation:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            ...organSelections.map((organ) => _buildOrganSelectionItem(organ)),
          ],
        ],
      ),
    );
  }

  Widget _buildOrganSelectionItem(Map<String, dynamic> organ) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: organ["selected"] ? successColor.withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: organ["selected"] ? successColor.withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                organ["selected"] = !organ["selected"];
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: organ["selected"] ? successColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(
                organ["selected"] ? Icons.check : Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            organ["icon"],
            color: organ["selected"] ? successColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${organ["organ"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: organ["selected"] ? successColor : disabledBoldColor,
                  ),
                ),
                Text(
                  "${organ["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTissueSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.healing,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Tissue Donation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Tissue Donor",
            items: [
              {
                "label": "I consent to tissue donation",
                "value": true,
                "checked": isTissueDonor,
              }
            ],
            value: [
              if (isTissueDonor)
                {
                  "label": "I consent to tissue donation",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                isTissueDonor = values.isNotEmpty;
              });
            },
          ),
          if (isTissueDonor) ...[
            Text(
              "Select tissues for donation:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            ...tissueSelections.map((tissue) => _buildTissueSelectionItem(tissue)),
          ],
          SizedBox(height: spSm),
          QSwitch(
            label: "Whole Body Donation",
            items: [
              {
                "label": "I consent to whole body donation for medical research",
                "value": true,
                "checked": isWholeBodayDonation,
              }
            ],
            value: [
              if (isWholeBodayDonation)
                {
                  "label": "I consent to whole body donation for medical research",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                isWholeBodayDonation = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTissueSelectionItem(Map<String, dynamic> tissue) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: tissue["selected"] ? infoColor.withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: tissue["selected"] ? infoColor.withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                tissue["selected"] = !tissue["selected"];
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: tissue["selected"] ? infoColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(
                tissue["selected"] ? Icons.check : Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            tissue["icon"],
            color: tissue["selected"] ? infoColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tissue["tissue"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: tissue["selected"] ? infoColor : disabledBoldColor,
                  ),
                ),
                Text(
                  "${tissue["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialInstructions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Special Instructions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Instructions for Medical Personnel",
            value: specialInstructions,
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDonationFacts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Donation Facts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: donationFacts.map((fact) => _buildFactCard(fact)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFactCard(Map<String, dynamic> fact) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: (fact["color"] as Color).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: (fact["color"] as Color).withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            fact["icon"],
            color: fact["color"] as Color,
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            "${fact["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: fact["color"] as Color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${fact["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationInfo() {
    if (!isOrganDonor) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.assignment,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Registration Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Registry ID",
                  value: donorRegistryId,
                  onChanged: (value) {
                    donorRegistryId = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Card Number",
                  value: donorCardNumber,
                  onChanged: (value) {
                    donorCardNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Registration Date",
            value: registrationDate,
            onChanged: (value) {
              registrationDate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegalInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Legal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "• You can change your donation preferences at any time\n"
            "• Family members cannot override your donation decision\n"
            "• Medical care is never compromised for registered donors\n"
            "• Religious and cultural considerations are respected\n"
            "• Your decision is confidential and secure",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Update Preferences",
                  size: bs.md,
                  onPressed: () {
                    ss("Donor preferences updated");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Download Certificate",
                  size: bs.md,
                  onPressed: () {
                    _downloadCertificate();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _registerAsDonor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.volunteer_activism, color: successColor),
            SizedBox(width: spSm),
            Text("Register as Organ Donor"),
          ],
        ),
        content: Text(
          "By registering as an organ donor, you're making a decision that could save up to 8 lives. "
          "Are you sure you want to register?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Register",
            color: successColor,
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                isOrganDonor = true;
                registrationDate = DateTime.now();
              });
              ss("Successfully registered as organ donor");
            },
          ),
        ],
      ),
    );
  }

  void _shareDonorCard() {
    ss("Donor card shared successfully");
  }

  void _printDonorCard() {
    ss("Donor card sent to printer");
  }

  void _downloadCertificate() {
    ss("Donor certificate downloaded");
  }
}
