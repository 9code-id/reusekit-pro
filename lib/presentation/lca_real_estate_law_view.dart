import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaRealEstateLawView extends StatefulWidget {
  const LcaRealEstateLawView({Key? key}) : super(key: key);

  @override
  State<LcaRealEstateLawView> createState() => _LcaRealEstateLawViewState();
}

class _LcaRealEstateLawViewState extends State<LcaRealEstateLawView> {
  String selectedPropertyType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "All Properties", "value": "all", "count": 56},
    {"label": "Residential", "value": "residential", "count": 24},
    {"label": "Commercial", "value": "commercial", "count": 18},
    {"label": "Industrial", "value": "industrial", "count": 8},
    {"label": "Land Development", "value": "land", "count": 6},
  ];

  List<Map<String, dynamic>> realEstateCases = [
    {
      "id": "RE-2024-001",
      "title": "Riverside Commercial Complex Sale",
      "client": "Riverside Holdings LLC",
      "property_type": "commercial",
      "transaction_type": "sale",
      "status": "in_progress",
      "priority": "high",
      "property_value": 2500000.0,
      "commission": 75000.0,
      "attorney": "Sarah Johnson, Esq.",
      "property_address": "123 Business District, Downtown",
      "closing_date": "2024-08-15",
      "square_footage": 15000,
      "zoning": "Commercial B2",
      "financing": "Commercial Loan",
      "title_company": "Metro Title Services",
      "inspection_status": "completed",
      "environmental_clearance": true,
    },
    {
      "id": "RE-2024-002",
      "title": "Suburban Family Home Purchase",
      "client": "Michael & Lisa Chen",
      "property_type": "residential",
      "transaction_type": "purchase",
      "status": "pending_review",
      "priority": "medium",
      "property_value": 450000.0,
      "commission": 13500.0,
      "attorney": "David Wilson, Esq.",
      "property_address": "456 Maple Street, Suburbia",
      "closing_date": "2024-07-22",
      "square_footage": 2800,
      "zoning": "Residential R1",
      "financing": "Conventional Mortgage",
      "title_company": "Suburban Title Co.",
      "inspection_status": "scheduled",
      "environmental_clearance": false,
    },
    {
      "id": "RE-2024-003",
      "title": "Industrial Warehouse Lease",
      "client": "LogiTech Distribution",
      "property_type": "industrial",
      "transaction_type": "lease",
      "status": "closed",
      "priority": "low",
      "property_value": 850000.0,
      "commission": 25500.0,
      "attorney": "Emily Rodriguez, Esq.",
      "property_address": "789 Industrial Park, North Zone",
      "closing_date": "2024-06-10",
      "square_footage": 50000,
      "zoning": "Industrial I3",
      "financing": "N/A",
      "title_company": "Industrial Title Group",
      "inspection_status": "completed",
      "environmental_clearance": true,
    },
    {
      "id": "RE-2024-004",
      "title": "Downtown Land Development",
      "client": "Urban Development Partners",
      "property_type": "land",
      "transaction_type": "development",
      "status": "litigation",
      "priority": "critical",
      "property_value": 5200000.0,
      "commission": 156000.0,
      "attorney": "Dr. Michael Chen, Esq.",
      "property_address": "Urban Plaza Development Site",
      "closing_date": "2024-12-30",
      "square_footage": 100000,
      "zoning": "Mixed Use MU1",
      "financing": "Development Loan",
      "title_company": "Capital Title Holdings",
      "inspection_status": "pending",
      "environmental_clearance": false,
    },
    {
      "id": "RE-2024-005",
      "title": "Luxury Condo Refinancing",
      "client": "Patricia Williams",
      "property_type": "residential",
      "transaction_type": "refinance",
      "status": "approved",
      "priority": "medium",
      "property_value": 750000.0,
      "commission": 22500.0,
      "attorney": "Sarah Johnson, Esq.",
      "property_address": "Penthouse 42A, Luxury Towers",
      "closing_date": "2024-07-05",
      "square_footage": 3500,
      "zoning": "High Density Residential",
      "financing": "Jumbo Refinance",
      "title_company": "Premier Title Services",
      "inspection_status": "waived",
      "environmental_clearance": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Estate Law"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewProperty(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.map,
            size: bs.sm,
            onPressed: () => _showPropertyMap(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildRealEstateOverview(),
                  _buildSearchAndFilter(),
                  _buildPropertyTypeFilter(),
                  _buildTransactionMetrics(),
                  _buildRealEstateCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildRealEstateOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.home_work, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Real Estate Portfolio",
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
              _buildOverviewCard("Total Value", "\$9.75M", Icons.attach_money, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "32", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "18", Icons.schedule, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Closed", "6", Icons.check_circle, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
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

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: QTextField(
              label: "Search properties...",
              value: searchQuery,
              hint: "Search by address, client, or case ID",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showAdvancedFilters(),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypeFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter by Property Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: propertyTypes.map((propertyType) {
              bool isSelected = selectedPropertyType == propertyType["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedPropertyType = propertyType["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "${propertyType["label"]} (${propertyType["count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Transaction Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("Avg. Property Value", "\$1.35M", Icons.home),
              SizedBox(width: spSm),
              _buildMetricCard("Total Commission", "\$293K", Icons.account_balance),
              SizedBox(width: spSm),
              _buildMetricCard("Avg. Closing Time", "45 days", Icons.access_time),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: successColor, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
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

  Widget _buildRealEstateCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Real Estate Cases (${filteredCases.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredCases.map((caseData) => _buildRealEstateCaseCard(caseData)),
      ],
    );
  }

  Widget _buildRealEstateCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor(caseData["status"]);
    Color typeColor = _getTypeColor(caseData["property_type"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: typeColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${caseData["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${caseData["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${caseData["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getPropertyIcon(caseData["property_type"]), color: typeColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${caseData["property_type"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: typeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["transaction_type"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${caseData["client"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${caseData["property_address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Value: \$${((caseData["property_value"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "${caseData["square_footage"]} sq ft",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.description, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["zoning"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Closing: ${caseData["closing_date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (caseData["inspection_status"] != "waived")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _getInspectionStatusColor(caseData["inspection_status"]).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: _getInspectionStatusColor(caseData["inspection_status"]).withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getInspectionIcon(caseData["inspection_status"]), 
                    color: _getInspectionStatusColor(caseData["inspection_status"]), 
                    size: 16
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Inspection: ${caseData["inspection_status"]}".replaceAll("_", " ").toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getInspectionStatusColor(caseData["inspection_status"]),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (caseData["environmental_clearance"] == true)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "ENV CLEARED",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Attorney: ${caseData["attorney"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewProperty(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editProperty(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showPropertyOptions(caseData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = realEstateCases;

    if (selectedPropertyType != "all") {
      filtered = filtered.where((c) => c["property_type"] == selectedPropertyType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["property_address"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'closed':
      case 'approved':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending_review':
        return infoColor;
      case 'litigation':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'residential':
        return primaryColor;
      case 'commercial':
        return successColor;
      case 'industrial':
        return warningColor;
      case 'land':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getPropertyIcon(String type) {
    switch (type.toLowerCase()) {
      case 'residential':
        return Icons.home;
      case 'commercial':
        return Icons.business;
      case 'industrial':
        return Icons.factory;
      case 'land':
        return Icons.landscape;
      default:
        return Icons.location_city;
    }
  }

  Color _getInspectionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'scheduled':
        return warningColor;
      case 'pending':
        return infoColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getInspectionIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'scheduled':
        return Icons.schedule;
      case 'pending':
        return Icons.hourglass_bottom;
      case 'failed':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _addNewProperty() {
    ss("Add new property case");
  }

  void _showPropertyMap() {
    ss("Show property map");
  }

  void _showAdvancedFilters() {
    ss("Advanced filters");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewProperty(String caseId) {
    ss("Viewing property $caseId");
  }

  void _editProperty(String caseId) {
    ss("Editing property $caseId");
  }

  void _showPropertyOptions(Map<String, dynamic> caseData) {
    ss("Property options for ${caseData["id"]}");
  }
}
