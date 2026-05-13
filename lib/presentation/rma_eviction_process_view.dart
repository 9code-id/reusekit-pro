import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaEvictionProcessView extends StatefulWidget {
  const RmaEvictionProcessView({super.key});

  @override
  State<RmaEvictionProcessView> createState() => _RmaEvictionProcessViewState();
}

class _RmaEvictionProcessViewState extends State<RmaEvictionProcessView> {
  final formKey = GlobalKey<FormState>();
  String selectedProperty = "";
  String tenantName = "";
  String evictionReason = "";
  String noticeDate = "";
  String courtDate = "";
  String evictionStatus = "notice_sent";
  String legalRepresentative = "";
  String notes = "";
  bool loading = false;

  List<Map<String, dynamic>> properties = [
    {"label": "Sunset Apartments Unit 1A", "value": "sunset_1a"},
    {"label": "Downtown Loft 205", "value": "downtown_205"},
    {"label": "Garden View Villa", "value": "garden_villa"},
    {"label": "Metro Plaza Suite 12", "value": "metro_12"},
  ];

  List<Map<String, dynamic>> reasonItems = [
    {"label": "Non-payment of Rent", "value": "non_payment"},
    {"label": "Lease Violation", "value": "lease_violation"},
    {"label": "Property Damage", "value": "property_damage"},
    {"label": "Illegal Activities", "value": "illegal_activities"},
    {"label": "Expired Lease", "value": "expired_lease"},
    {"label": "Owner Occupancy", "value": "owner_occupancy"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Notice Sent", "value": "notice_sent"},
    {"label": "Court Filing", "value": "court_filing"},
    {"label": "Court Hearing", "value": "court_hearing"},
    {"label": "Judgment Obtained", "value": "judgment_obtained"},
    {"label": "Sheriff Eviction", "value": "sheriff_eviction"},
    {"label": "Completed", "value": "completed"},
    {"label": "Dismissed", "value": "dismissed"},
  ];

  List<Map<String, dynamic>> evictions = [
    {
      "id": "EV001",
      "property": "Sunset Apartments Unit 1A",
      "tenant": "John Matthews",
      "reason": "non_payment",
      "noticeDate": "2024-05-01",
      "courtDate": "2024-06-15",
      "status": "court_hearing",
      "legalRep": "Smith & Associates Law",
      "daysOverdue": 45,
      "notes": "3 months rent unpaid"
    },
    {
      "id": "EV002",
      "property": "Downtown Loft 205",
      "tenant": "Maria Gonzalez",
      "reason": "lease_violation",
      "noticeDate": "2024-04-20",
      "courtDate": "2024-05-30",
      "status": "judgment_obtained",
      "legalRep": "Legal Aid Services",
      "daysOverdue": 60,
      "notes": "Unauthorized pets and subletting"
    },
    {
      "id": "EV003",
      "property": "Garden View Villa",
      "tenant": "Robert Johnson",
      "reason": "property_damage",
      "noticeDate": "2024-05-15",
      "courtDate": "2024-07-01",
      "status": "notice_sent",
      "legalRep": "Brown Legal Group",
      "daysOverdue": 15,
      "notes": "Significant damage to floors and walls"
    },
    {
      "id": "EV004",
      "property": "Metro Plaza Suite 12",
      "tenant": "Lisa Chen",
      "reason": "expired_lease",
      "noticeDate": "2024-03-01",
      "courtDate": "2024-04-15",
      "status": "completed",
      "legalRep": "Thompson Law Firm",
      "daysOverdue": 90,
      "notes": "Tenant moved out voluntarily"
    },
  ];

  List<Map<String, dynamic>> filteredEvictions = [];
  String searchQuery = "";
  String filterStatus = "";

  @override
  void initState() {
    super.initState();
    filteredEvictions = List.from(evictions);
    noticeDate = DateTime.now().toString().split(' ')[0];
    courtDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  }

  void _filterEvictions() {
    filteredEvictions = evictions.where((eviction) {
      bool matchesSearch = searchQuery.isEmpty ||
          (eviction["property"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (eviction["tenant"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (eviction["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = filterStatus.isEmpty || eviction["status"] == filterStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
    setState(() {});
  }

  void _addEviction() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 2));

      evictions.add({
        "id": "EV${(evictions.length + 1).toString().padLeft(3, '0')}",
        "property": properties.firstWhere((p) => p["value"] == selectedProperty)["label"],
        "tenant": tenantName,
        "reason": evictionReason,
        "noticeDate": noticeDate,
        "courtDate": courtDate,
        "status": evictionStatus,
        "legalRep": legalRepresentative,
        "daysOverdue": DateTime.now().difference(DateTime.parse(noticeDate)).inDays,
        "notes": notes,
      });

      _resetForm();
      _filterEvictions();
      loading = false;
      setState(() {});
      ss("Eviction case added successfully");
    }
  }

  void _resetForm() {
    selectedProperty = "";
    tenantName = "";
    evictionReason = "";
    noticeDate = DateTime.now().toString().split(' ')[0];
    courtDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
    evictionStatus = "notice_sent";
    legalRepresentative = "";
    notes = "";
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'notice_sent':
        return warningColor;
      case 'court_filing':
        return infoColor;
      case 'court_hearing':
        return primaryColor;
      case 'judgment_obtained':
        return successColor;
      case 'sheriff_eviction':
        return dangerColor;
      case 'completed':
        return successColor;
      case 'dismissed':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'notice_sent':
        return 'Notice Sent';
      case 'court_filing':
        return 'Court Filing';
      case 'court_hearing':
        return 'Court Hearing';
      case 'judgment_obtained':
        return 'Judgment Obtained';
      case 'sheriff_eviction':
        return 'Sheriff Eviction';
      case 'completed':
        return 'Completed';
      case 'dismissed':
        return 'Dismissed';
      default:
        return status;
    }
  }

  String _getReasonLabel(String reason) {
    switch (reason) {
      case 'non_payment':
        return 'Non-payment of Rent';
      case 'lease_violation':
        return 'Lease Violation';
      case 'property_damage':
        return 'Property Damage';
      case 'illegal_activities':
        return 'Illegal Activities';
      case 'expired_lease':
        return 'Expired Lease';
      case 'owner_occupancy':
        return 'Owner Occupancy';
      default:
        return reason;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eviction Process"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "New Eviction Case",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Form(
                        key: formKey,
                        child: Column(
                          spacing: spSm,
                          children: [
                            QDropdownField(
                              label: "Property",
                              items: properties,
                              value: selectedProperty,
                              validator: Validator.required,
                              onChanged: (value, label) {
                                selectedProperty = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: "Tenant Name",
                              value: tenantName,
                              validator: Validator.required,
                              onChanged: (value) {
                                tenantName = value;
                                setState(() {});
                              },
                            ),
                            QDropdownField(
                              label: "Eviction Reason",
                              items: reasonItems,
                              value: evictionReason,
                              validator: Validator.required,
                              onChanged: (value, label) {
                                evictionReason = value;
                                setState(() {});
                              },
                            ),
                            QDatePicker(
                              label: "Notice Date",
                              value: DateTime.parse(noticeDate),
                              onChanged: (value) {
                                noticeDate = value.toString().split(' ')[0];
                                setState(() {});
                              },
                            ),
                            QDatePicker(
                              label: "Court Date",
                              value: DateTime.parse(courtDate),
                              onChanged: (value) {
                                courtDate = value.toString().split(' ')[0];
                                setState(() {});
                              },
                            ),
                            QDropdownField(
                              label: "Status",
                              items: statusItems,
                              value: evictionStatus,
                              onChanged: (value, label) {
                                evictionStatus = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: "Legal Representative",
                              value: legalRepresentative,
                              onChanged: (value) {
                                legalRepresentative = value;
                                setState(() {});
                              },
                            ),
                            QMemoField(
                              label: "Notes",
                              value: notes,
                              onChanged: (value) {
                                notes = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              color: disabledBoldColor,
                              size: bs.md,
                              onPressed: () {
                                back();
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: loading ? "Adding..." : "Add Case",
                              size: bs.md,
                              onPressed: loading ? null : _addEviction,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.gavel,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active Cases",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${evictions.where((e) => e["status"] != "completed" && e["status"] != "dismissed").length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Court Hearings",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${evictions.where((e) => e["status"] == "court_hearing").length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${evictions.where((e) => e["status"] == "completed").length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filter Section
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
                        flex: 2,
                        child: QTextField(
                          label: "Search eviction cases...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            _filterEvictions();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter Status",
                          items: [
                            {"label": "All Status", "value": ""},
                            ...statusItems,
                          ],
                          value: filterStatus,
                          onChanged: (value, label) {
                            filterStatus = value;
                            _filterEvictions();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Eviction Cases List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Text(
                      "Eviction Cases (${filteredEvictions.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredEvictions.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final eviction = filteredEvictions[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 80,
                              decoration: BoxDecoration(
                                color: _getStatusColor(eviction["status"]),
                                borderRadius: BorderRadius.circular(radiusXs),
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
                                      Expanded(
                                        child: Text(
                                          "${eviction["property"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(eviction["status"]).withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getStatusLabel(eviction["status"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getStatusColor(eviction["status"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Tenant: ${eviction["tenant"]} • Case: ${eviction["id"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Reason: ${_getReasonLabel(eviction["reason"])}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                  if (eviction["legalRep"] != null && (eviction["legalRep"] as String).isNotEmpty)
                                    Text(
                                      "Legal Rep: ${eviction["legalRep"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Text(
                                        "Notice: ${DateTime.parse(eviction["noticeDate"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      if (eviction["courtDate"] != null)
                                        Text(
                                          " • Court: ${DateTime.parse(eviction["courtDate"]).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                  if ((eviction["daysOverdue"] as int) > 0)
                                    Text(
                                      "${eviction["daysOverdue"]} days overdue",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.more_vert,
                              color: primaryColor,
                              size: bs.sm,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    padding: EdgeInsets.all(spMd),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: disabledColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        Text(
                                          "Case Actions",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        Column(
                                          spacing: spSm,
                                          children: [
                                            QButton(
                                              label: "View Details",
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Viewing case details");
                                              },
                                            ),
                                            QButton(
                                              label: "Update Status",
                                              color: warningColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Updating case status");
                                              },
                                            ),
                                            QButton(
                                              label: "Schedule Court Date",
                                              color: infoColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Scheduling court date");
                                              },
                                            ),
                                            QButton(
                                              label: "Generate Documents",
                                              color: successColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Generating legal documents");
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
