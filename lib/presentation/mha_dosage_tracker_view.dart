import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaDosageTrackerView extends StatefulWidget {
  const MhaDosageTrackerView({super.key});

  @override
  State<MhaDosageTrackerView> createState() => _MhaDosageTrackerViewState();
}

class _MhaDosageTrackerViewState extends State<MhaDosageTrackerView> {
  int currentTab = 0;
  List<Map<String, dynamic>> dosageRecords = [
    {
      "id": 1,
      "medicationName": "Metformin",
      "dosage": "500mg",
      "frequency": "2x daily",
      "time": "08:00",
      "taken": true,
      "date": "2024-01-15",
      "notes": "Taken with breakfast",
      "sideEffects": "None",
      "effectiveness": 4.5,
    },
    {
      "id": 2,
      "medicationName": "Lisinopril",
      "dosage": "10mg",
      "frequency": "1x daily",
      "time": "20:00",
      "taken": false,
      "date": "2024-01-15",
      "notes": "Take before bed",
      "sideEffects": "Mild dizziness",
      "effectiveness": 4.0,
    },
    {
      "id": 3,
      "medicationName": "Vitamin D3",
      "dosage": "1000 IU",
      "frequency": "1x daily",
      "time": "12:00",
      "taken": true,
      "date": "2024-01-15",
      "notes": "Taken with lunch",
      "sideEffects": "None",
      "effectiveness": 3.5,
    },
  ];

  List<Map<String, dynamic>> adherenceData = [
    {
      "date": "Jan 8",
      "percentage": 95,
      "missedDoses": 1,
      "totalDoses": 20,
    },
    {
      "date": "Jan 9",
      "percentage": 100,
      "missedDoses": 0,
      "totalDoses": 20,
    },
    {
      "date": "Jan 10",
      "percentage": 85,
      "missedDoses": 3,
      "totalDoses": 20,
    },
    {
      "date": "Jan 11",
      "percentage": 90,
      "missedDoses": 2,
      "totalDoses": 20,
    },
    {
      "date": "Jan 12",
      "percentage": 100,
      "missedDoses": 0,
      "totalDoses": 20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dosage Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildHistoryTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTodayOverview(),
          _buildTodayMedications(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildTodayOverview() {
    int totalMeds = dosageRecords.length;
    int takenMeds = dosageRecords.where((record) => record["taken"] as bool).length;
    double adherenceRate = (takenMeds / totalMeds) * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Today's Progress",
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
              _buildProgressCard("Taken", "$takenMeds", "$totalMeds", successColor),
              SizedBox(width: spSm),
              _buildProgressCard("Missed", "${totalMeds - takenMeds}", "$totalMeds", dangerColor),
              SizedBox(width: spSm),
              _buildProgressCard("Adherence", "${adherenceRate.toInt()}%", "100%", primaryColor),
            ],
          ),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: adherenceRate / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: adherenceRate >= 80 ? successColor : adherenceRate >= 60 ? warningColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String value, String total, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              "of $total",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayMedications() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.medication,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Today's Medications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...dosageRecords.map((record) => _buildMedicationCard(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> record) {
    bool isTaken = record["taken"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isTaken ? successColor.withAlpha(20) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isTaken ? successColor : disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isTaken ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              isTaken ? Icons.check : Icons.medication,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${record["medicationName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${record["dosage"]} • ${record["frequency"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Time: ${record["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (!isTaken)
            QButton(
              label: "Take",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  record["taken"] = true;
                });
                ss("Medication marked as taken");
              },
            ),
          if (isTaken)
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 24,
            ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.flash_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
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
                child: QButton(
                  label: "Add Dose",
                  icon: Icons.add,
                  onPressed: () {
                    //navigateTo('AddDoseView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Side Effects",
                  icon: Icons.warning,
                  onPressed: () {
                    //navigateTo('SideEffectsView')
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Set Reminder",
                  icon: Icons.alarm,
                  onPressed: () {
                    //navigateTo('MedicationReminderView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Doctor Notes",
                  icon: Icons.note_add,
                  onPressed: () {
                    //navigateTo('DoctorNotesView')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryFilters(),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Filter History",
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
                child: QButton(
                  label: "Last 7 Days",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Last Month",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Custom",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.history,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Dosage History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...dosageRecords.map((record) => _buildHistoryCard(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> record) {
    bool isTaken = record["taken"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 40,
                decoration: BoxDecoration(
                  color: isTaken ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
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
                          "${record["medicationName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isTaken ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isTaken ? "Taken" : "Missed",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${record["dosage"]} • ${record["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${record["date"]}",
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
          if (record["notes"] != null && (record["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Notes: ${record["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAdherenceChart(),
          _buildEffectivenessAnalysis(),
          _buildSideEffectsSummary(),
        ],
      ),
    );
  }

  Widget _buildAdherenceChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Adherence Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: Column(
              children: adherenceData.map((data) {
                double percentage = (data["percentage"] as int).toDouble();
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          "${data["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: percentage >= 90 ? successColor : percentage >= 70 ? warningColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      SizedBox(
                        width: 40,
                        child: Text(
                          "${percentage.toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEffectivenessAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.assessment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Medication Effectiveness",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...dosageRecords.map((record) {
            double effectiveness = (record["effectiveness"] as num).toDouble();
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${record["medicationName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < effectiveness ? Icons.star : Icons.star_border,
                              color: warningColor,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${effectiveness.toStringAsFixed(1)}/5.0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSideEffectsSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.warning,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Side Effects Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...dosageRecords.map((record) {
            String sideEffects = record["sideEffects"] as String;
            Color statusColor = sideEffects.toLowerCase() == "none" ? successColor : warningColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: statusColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    sideEffects.toLowerCase() == "none" ? Icons.check_circle : Icons.warning,
                    color: statusColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${record["medicationName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          sideEffects,
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
