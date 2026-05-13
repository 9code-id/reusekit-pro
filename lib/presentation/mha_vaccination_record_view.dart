import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaVaccinationRecordView extends StatefulWidget {
  const MhaVaccinationRecordView({Key? key}) : super(key: key);

  @override
  State<MhaVaccinationRecordView> createState() => _MhaVaccinationRecordViewState();
}

class _MhaVaccinationRecordViewState extends State<MhaVaccinationRecordView> {
  String selectedFilter = "All";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Due Soon", "value": "Due Soon"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Upcoming", "value": "Upcoming"},
  ];

  List<Map<String, dynamic>> vaccinations = [
    {
      "id": "1",
      "name": "COVID-19 (Bivalent Booster)",
      "type": "mRNA Vaccine",
      "manufacturer": "Pfizer-BioNTech",
      "lastDate": DateTime.now().subtract(Duration(days: 180)),
      "nextDue": DateTime.now().add(Duration(days: 185)),
      "status": "Due Soon",
      "location": "Community Health Center",
      "provider": "Dr. Sarah Johnson",
      "lotNumber": "FK3127",
      "sideEffects": ["Mild arm soreness", "Fatigue for 1 day"],
      "notes": "Patient tolerated well. No adverse reactions.",
      "series": "Primary series complete + 2 boosters",
      "protection": "Reduces severe illness by 90%",
      "image": "https://picsum.photos/300/200?random=1&keyword=vaccine",
      "frequency": "Annual or as recommended",
      "importance": "Critical",
      "category": "Respiratory",
    },
    {
      "id": "2",
      "name": "Influenza (Seasonal)",
      "type": "Inactivated Vaccine",
      "manufacturer": "Sanofi Pasteur",
      "lastDate": DateTime.now().subtract(Duration(days: 330)),
      "nextDue": DateTime.now().add(Duration(days: 35)),
      "status": "Upcoming",
      "location": "Primary Care Office",
      "provider": "Dr. Michael Chen",
      "lotNumber": "FL2023",
      "sideEffects": ["None reported"],
      "notes": "Annual vaccination completed successfully.",
      "series": "Annual vaccination",
      "protection": "Reduces flu risk by 40-60%",
      "image": "https://picsum.photos/300/200?random=2&keyword=flu",
      "frequency": "Annually",
      "importance": "Recommended",
      "category": "Respiratory",
    },
    {
      "id": "3",
      "name": "Tdap (Tetanus, Diphtheria, Pertussis)",
      "type": "Combination Vaccine",
      "manufacturer": "GlaxoSmithKline",
      "lastDate": DateTime.now().subtract(Duration(days: 2190)), // 6 years ago
      "nextDue": DateTime.now().add(Duration(days: 1460)), // 4 years from now
      "status": "Completed",
      "location": "Urgent Care Clinic",
      "provider": "Dr. Emily Rodriguez",
      "lotNumber": "TD5891",
      "sideEffects": ["Mild injection site pain"],
      "notes": "Booster administered after minor cut injury.",
      "series": "Adult booster (every 10 years)",
      "protection": "Prevents tetanus, diphtheria, whooping cough",
      "image": "https://picsum.photos/300/200?random=3&keyword=tetanus",
      "frequency": "Every 10 years",
      "importance": "Essential",
      "category": "Bacterial",
    },
    {
      "id": "4",
      "name": "Hepatitis B",
      "type": "Recombinant Vaccine",
      "manufacturer": "Merck",
      "lastDate": DateTime.now().subtract(Duration(days: 7300)), // 20 years ago
      "nextDue": DateTime.now().subtract(Duration(days: 1825)), // 5 years overdue
      "status": "Overdue",
      "location": "Student Health Center",
      "provider": "Campus Health Services",
      "lotNumber": "HB1998",
      "sideEffects": ["None reported"],
      "notes": "3-dose series completed in college. Titer check recommended.",
      "series": "3-dose series (lifetime protection)",
      "protection": "Prevents hepatitis B infection",
      "image": "https://picsum.photos/300/200?random=4&keyword=hepatitis",
      "frequency": "Titer check every 10-15 years",
      "importance": "Essential",
      "category": "Viral",
    },
    {
      "id": "5",
      "name": "MMR (Measles, Mumps, Rubella)",
      "type": "Live Attenuated Vaccine",
      "manufacturer": "Merck",
      "lastDate": DateTime.now().subtract(Duration(days: 10950)), // 30 years ago
      "nextDue": null, // Lifetime protection
      "status": "Completed",
      "location": "Pediatric Clinic",
      "provider": "Dr. James Wilson",
      "lotNumber": "MMR1990",
      "sideEffects": ["Mild rash", "Low-grade fever"],
      "notes": "Childhood vaccination series completed. Immunity confirmed by titer.",
      "series": "2-dose series (lifetime protection)",
      "protection": "Prevents measles, mumps, rubella",
      "image": "https://picsum.photos/300/200?random=5&keyword=measles",
      "frequency": "Lifetime protection",
      "importance": "Essential",
      "category": "Viral",
    },
    {
      "id": "6",
      "name": "Shingles (Zoster)",
      "type": "Recombinant Vaccine",
      "manufacturer": "GlaxoSmithKline",
      "lastDate": null,
      "nextDue": DateTime.now().add(Duration(days: 1095)), // 3 years from now (age-based)
      "status": "Upcoming",
      "location": "To be scheduled",
      "provider": "To be determined",
      "lotNumber": null,
      "sideEffects": [],
      "notes": "Recommended starting at age 50. Schedule when eligible.",
      "series": "2-dose series",
      "protection": "Prevents shingles (herpes zoster)",
      "image": "https://picsum.photos/300/200?random=6&keyword=shingles",
      "frequency": "2 doses, 2-6 months apart",
      "importance": "Recommended",
      "category": "Viral",
    },
  ];

  List<Map<String, dynamic>> get filteredVaccinations {
    if (selectedFilter == "All") {
      return vaccinations;
    }
    return vaccinations.where((vax) => vax["status"] == selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Due Soon":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Upcoming":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImportanceColor(String importance) {
    switch (importance) {
      case "Critical":
        return dangerColor;
      case "Essential":
        return warningColor;
      case "Recommended":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildVaccinationCard(Map<String, dynamic> vaccination) {
    Color statusColor = _getStatusColor(vaccination["status"]);
    Color importanceColor = _getImportanceColor(vaccination["importance"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: vaccination["status"] == "Overdue" 
            ? Border.all(color: dangerColor, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vaccination Image and Status
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
            child: Stack(
              children: [
                Image.network(
                  "${vaccination["image"]}",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${vaccination["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: importanceColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${vaccination["importance"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${vaccination["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: spSm),

                // Vaccine Name
                Text(
                  "${vaccination["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spXs),

                // Type and Manufacturer
                Text(
                  "${vaccination["type"]} • ${vaccination["manufacturer"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: spMd),

                // Protection Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shield,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${vaccination["protection"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Date Information
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Vaccination",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            vaccination["lastDate"] != null 
                                ? "${(vaccination["lastDate"] as DateTime).dMMMy}"
                                : "Not yet received",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next Due",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            vaccination["nextDue"] != null 
                                ? "${(vaccination["nextDue"] as DateTime).dMMMy}"
                                : "Lifetime protection",
                            style: TextStyle(
                              fontSize: 14,
                              color: vaccination["status"] == "Overdue" ? dangerColor : primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Series and Frequency
                Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${vaccination["series"]} • ${vaccination["frequency"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),

                if (vaccination["lastDate"] != null) ...[
                  SizedBox(height: spMd),

                  // Last Vaccination Details
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Vaccination Details",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${vaccination["location"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${vaccination["provider"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (vaccination["lotNumber"] != null) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.tag,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Lot: ${vaccination["lotNumber"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],

                SizedBox(height: spMd),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: vaccination["status"] == "Overdue" || vaccination["status"] == "Due Soon"
                            ? "Schedule Now"
                            : "View Details",
                        size: bs.sm,
                        onPressed: () {
                          if (vaccination["status"] == "Overdue" || vaccination["status"] == "Due Soon") {
                            ss("Appointment scheduling for ${vaccination["name"]}");
                          } else {
                            // Navigate to detailed view
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.calendar_today,
                      size: bs.sm,
                      onPressed: () {
                        ss("Reminder set for ${vaccination["name"]}");
                      },
                    ),
                  ],
                ),

                if ((vaccination["sideEffects"] as List).isNotEmpty) ...[
                  SizedBox(height: spMd),

                  // Side Effects (if any from last vaccination)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 14,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Previous Side Effects:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        ...(vaccination["sideEffects"] as List).map((effect) => Text(
                          "• $effect",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        )).toList(),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccination Records"),
        actions: [
          IconButton(
            onPressed: () {
              // Add new vaccination record
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // Export vaccination record
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.vaccines,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vaccination Records",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Track your immunization history and upcoming vaccinations",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Vaccination Summary
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 32,
                              color: successColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${vaccinations.where((v) => v["status"] == "Completed").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Up to Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 32,
                              color: warningColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${vaccinations.where((v) => v["status"] == "Due Soon").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Due Soon",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.warning,
                              size: 32,
                              color: dangerColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${vaccinations.where((v) => v["status"] == "Overdue").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Filter
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.refresh,
                        size: bs.sm,
                        onPressed: () {
                          // Refresh vaccination data
                          loading = true;
                          setState(() {});
                          
                          Future.delayed(Duration(seconds: 1), () {
                            loading = false;
                            setState(() {});
                            ss("Vaccination records updated");
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Vaccinations List
                  if (filteredVaccinations.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.vaccines,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No vaccinations found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filter",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          "${filteredVaccinations.length} vaccination records found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 12,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "CDC Recommended",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    ...filteredVaccinations.map((vaccination) => _buildVaccinationCard(vaccination)).toList(),
                  ],
                ],
              ),
            ),
    );
  }
}
