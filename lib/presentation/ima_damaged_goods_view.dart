import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaDamagedGoodsView extends StatefulWidget {
  const ImaDamagedGoodsView({super.key});

  @override
  State<ImaDamagedGoodsView> createState() => _ImaDamagedGoodsViewState();
}

class _ImaDamagedGoodsViewState extends State<ImaDamagedGoodsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedCategory = "";
  String selectedFacility = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Reported", "value": "reported"},
    {"label": "Under Investigation", "value": "investigating"},
    {"label": "Assessed", "value": "assessed"},
    {"label": "Repair Approved", "value": "repair_approved"},
    {"label": "Disposal Approved", "value": "disposal_approved"},
    {"label": "Repaired", "value": "repaired"},
    {"label": "Disposed", "value": "disposed"},
    {"label": "Insurance Claimed", "value": "insurance_claimed"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Furniture", "value": "furniture"},
    {"label": "Machinery", "value": "machinery"},
    {"label": "Perishables", "value": "perishables"},
    {"label": "Textiles", "value": "textiles"},
    {"label": "Raw Materials", "value": "raw_materials"},
  ];

  List<Map<String, dynamic>> facilityOptions = [
    {"label": "All Facilities", "value": ""},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "North Distribution", "value": "north"},
    {"label": "South Distribution", "value": "south"},
    {"label": "East Regional", "value": "east"},
    {"label": "West Regional", "value": "west"},
  ];

  List<Map<String, dynamic>> damagedGoodsData = [
    {
      "id": "DG001",
      "product_name": "Samsung 65 QLED TV",
      "product_code": "SAM65Q-2024",
      "sku": "TV-SAM-65Q-001",
      "category": "electronics",
      "quantity_damaged": 3,
      "original_quantity": 5,
      "status": "investigating",
      "facility": "main",
      "damage_type": "Physical Damage",
      "damage_cause": "Forklift Accident",
      "damage_severity": "Major",
      "reported_by": "John Smith",
      "assessed_by": "Sarah Wilson",
      "reported_date": "2024-06-15T09:30:00Z",
      "assessment_date": "2024-06-16T14:00:00Z",
      "unit_cost": 1200.0,
      "total_loss": 3600.0,
      "salvage_value": 600.0,
      "insurance_eligible": true,
      "repair_cost_estimate": 800.0,
      "disposal_required": false,
      "incident_reference": "INC-2024-001",
      "images": ["https://picsum.photos/400/300?random=1", "https://picsum.photos/400/300?random=2"],
      "notes": "Screens cracked during warehouse operations, frames intact",
      "priority": "High",
      "location": "Aisle A-12, Shelf 3",
      "created_at": "2024-06-15T09:30:00Z",
    },
    {
      "id": "DG002",
      "product_name": "Office Desk Set",
      "product_code": "OFC-DSK-PRO",
      "sku": "FUR-OFC-DSK-002",
      "category": "furniture",
      "quantity_damaged": 5,
      "original_quantity": 20,
      "status": "disposal_approved",
      "facility": "north",
      "damage_type": "Water Damage",
      "damage_cause": "Roof Leak",
      "damage_severity": "Severe",
      "reported_by": "Mike Johnson",
      "assessed_by": "Emily Davis",
      "reported_date": "2024-06-12T11:45:00Z",
      "assessment_date": "2024-06-13T10:00:00Z",
      "unit_cost": 450.0,
      "total_loss": 2250.0,
      "salvage_value": 0.0,
      "insurance_eligible": true,
      "repair_cost_estimate": 0.0,
      "disposal_required": true,
      "incident_reference": "INC-2024-002",
      "images": ["https://picsum.photos/400/300?random=3", "https://picsum.photos/400/300?random=4"],
      "notes": "Extensive water damage, wood warping, metal corrosion",
      "priority": "Medium",
      "location": "Section B, Row 5-8",
      "created_at": "2024-06-12T11:45:00Z",
    },
    {
      "id": "DG003",
      "product_name": "Industrial Printer",
      "product_code": "HP-IP-5000",
      "sku": "MAC-HP-IP-003",
      "category": "machinery",
      "quantity_damaged": 1,
      "original_quantity": 1,
      "status": "repaired",
      "facility": "south",
      "damage_type": "Mechanical Failure",
      "damage_cause": "Normal Wear",
      "damage_severity": "Minor",
      "reported_by": "Lisa Chen",
      "assessed_by": "David Brown",
      "reported_date": "2024-06-10T14:20:00Z",
      "assessment_date": "2024-06-11T09:15:00Z",
      "unit_cost": 3500.0,
      "total_loss": 0.0,
      "salvage_value": 3200.0,
      "insurance_eligible": false,
      "repair_cost_estimate": 300.0,
      "disposal_required": false,
      "incident_reference": "INC-2024-003",
      "images": ["https://picsum.photos/400/300?random=5"],
      "notes": "Paper feed mechanism jammed, replaced with new parts",
      "priority": "Low",
      "location": "Production Floor A",
      "created_at": "2024-06-10T14:20:00Z",
    },
    {
      "id": "DG004",
      "product_name": "Fresh Produce Batch",
      "product_code": "FRP-MIX-024",
      "sku": "PER-FRP-MIX-004",
      "category": "perishables",
      "quantity_damaged": 50,
      "original_quantity": 100,
      "status": "disposed",
      "facility": "east",
      "damage_type": "Spoilage",
      "damage_cause": "Temperature Control Failure",
      "damage_severity": "Total Loss",
      "reported_by": "Robert Garcia",
      "assessed_by": "Anna Martinez",
      "reported_date": "2024-06-14T06:00:00Z",
      "assessment_date": "2024-06-14T08:30:00Z",
      "unit_cost": 25.0,
      "total_loss": 1250.0,
      "salvage_value": 0.0,
      "insurance_eligible": true,
      "repair_cost_estimate": 0.0,
      "disposal_required": true,
      "incident_reference": "INC-2024-004",
      "images": ["https://picsum.photos/400/300?random=6", "https://picsum.photos/400/300?random=7"],
      "notes": "Refrigeration unit failed overnight, all produce spoiled",
      "priority": "High",
      "location": "Cold Storage Unit 2",
      "created_at": "2024-06-14T06:00:00Z",
    },
    {
      "id": "DG005",
      "product_name": "Cotton Fabric Rolls",
      "product_code": "CTN-FB-100",
      "sku": "TEX-CTN-FB-005",
      "category": "textiles",
      "quantity_damaged": 15,
      "original_quantity": 30,
      "status": "reported",
      "facility": "west",
      "damage_type": "Chemical Contamination",
      "damage_cause": "Spill Incident",
      "damage_severity": "Moderate",
      "reported_by": "Jennifer Wilson",
      "assessed_by": null,
      "reported_date": "2024-06-16T13:15:00Z",
      "assessment_date": null,
      "unit_cost": 80.0,
      "total_loss": 1200.0,
      "salvage_value": 300.0,
      "insurance_eligible": true,
      "repair_cost_estimate": 0.0,
      "disposal_required": true,
      "incident_reference": "INC-2024-005",
      "images": ["https://picsum.photos/400/300?random=8"],
      "notes": "Chemical spill from adjacent storage, fabric contaminated",
      "priority": "Medium",
      "location": "Textile Storage Area C",
      "created_at": "2024-06-16T13:15:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredDamagedGoods {
    return damagedGoodsData.where((goods) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${goods["product_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${goods["product_code"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${goods["sku"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${goods["incident_reference"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || goods["status"] == selectedStatus;
      bool matchesCategory = selectedCategory.isEmpty || goods["category"] == selectedCategory;
      bool matchesFacility = selectedFacility.isEmpty || goods["facility"] == selectedFacility;
      
      return matchesSearch && matchesStatus && matchesCategory && matchesFacility;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "reported": return warningColor;
      case "investigating": return infoColor;
      case "assessed": return primaryColor;
      case "repair_approved": return infoColor;
      case "disposal_approved": return warningColor;
      case "repaired": return successColor;
      case "disposed": return disabledBoldColor;
      case "insurance_claimed": return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Minor": return successColor;
      case "Moderate": return warningColor;
      case "Major": return dangerColor;
      case "Severe": return dangerColor;
      case "Total Loss": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledBoldColor;
    }
  }

  String _formatStatus(String status) {
    switch (status) {
      case "reported": return "Reported";
      case "investigating": return "Under Investigation";
      case "assessed": return "Assessed";
      case "repair_approved": return "Repair Approved";
      case "disposal_approved": return "Disposal Approved";
      case "repaired": return "Repaired";
      case "disposed": return "Disposed";
      case "insurance_claimed": return "Insurance Claimed";
      default: return status;
    }
  }

  Map<String, dynamic> _getOverviewStats() {
    int totalDamaged = damagedGoodsData.length;
    int reported = damagedGoodsData.where((g) => g["status"] == "reported").length;
    int investigating = damagedGoodsData.where((g) => g["status"] == "investigating").length;
    int repaired = damagedGoodsData.where((g) => g["status"] == "repaired").length;
    int disposed = damagedGoodsData.where((g) => g["status"] == "disposed").length;

    double totalLoss = damagedGoodsData.fold(0.0, (sum, item) => sum + (item["total_loss"] as double));
    double salvageValue = damagedGoodsData.fold(0.0, (sum, item) => sum + (item["salvage_value"] as double));
    double repairCosts = damagedGoodsData.fold(0.0, (sum, item) => sum + (item["repair_cost_estimate"] as double));
    int insuranceEligible = damagedGoodsData.where((g) => g["insurance_eligible"] == true).length;

    return {
      "total_damaged": totalDamaged,
      "reported": reported,
      "investigating": investigating,
      "repaired": repaired,
      "disposed": disposed,
      "total_loss": totalLoss,
      "salvage_value": salvageValue,
      "repair_costs": repairCosts,
      "insurance_eligible": insuranceEligible,
      "net_loss": totalLoss - salvageValue,
    };
  }

  void _showDamageDetails(Map<String, dynamic> damage) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Damaged Goods Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Damage ID", "${damage["id"]}"),
                      _buildDetailRow("Product", "${damage["product_name"]}"),
                      _buildDetailRow("Product Code", "${damage["product_code"]}"),
                      _buildDetailRow("SKU", "${damage["sku"]}"),
                      _buildDetailRow("Category", "${damage["category"]}".toUpperCase()),
                      _buildDetailRow("Quantity Damaged", "${damage["quantity_damaged"]} of ${damage["original_quantity"]} units"),
                      _buildDetailRow("Status", _formatStatus("${damage["status"]}")),
                      _buildDetailRow("Facility", "${damage["facility"]}".toUpperCase()),
                      _buildDetailRow("Location", "${damage["location"]}"),
                      _buildDetailRow("Damage Type", "${damage["damage_type"]}"),
                      _buildDetailRow("Damage Cause", "${damage["damage_cause"]}"),
                      _buildDetailRow("Severity", "${damage["damage_severity"]}"),
                      _buildDetailRow("Priority", "${damage["priority"]}"),
                      _buildDetailRow("Reported By", "${damage["reported_by"]}"),
                      if (damage["assessed_by"] != null)
                        _buildDetailRow("Assessed By", "${damage["assessed_by"]}"),
                      _buildDetailRow("Incident Reference", "${damage["incident_reference"]}"),
                      _buildDetailRow("Unit Cost", "\$${(damage["unit_cost"] as double).currency}"),
                      _buildDetailRow("Total Loss", "\$${(damage["total_loss"] as double).currency}"),
                      _buildDetailRow("Salvage Value", "\$${(damage["salvage_value"] as double).currency}"),
                      if ((damage["repair_cost_estimate"] as double) > 0)
                        _buildDetailRow("Repair Estimate", "\$${(damage["repair_cost_estimate"] as double).currency}"),
                      _buildDetailRow("Insurance Eligible", damage["insurance_eligible"] == true ? "Yes" : "No"),
                      _buildDetailRow("Disposal Required", damage["disposal_required"] == true ? "Yes" : "No"),
                      _buildDetailRow("Reported Date", DateTime.parse(damage["reported_date"]).dMMMy),
                      if (damage["assessment_date"] != null)
                        _buildDetailRow("Assessment Date", DateTime.parse(damage["assessment_date"]).dMMMy),
                      
                      SizedBox(height: spMd),
                      Text(
                        "Damage Notes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text("${damage["notes"]}"),
                      ),

                      if ((damage["images"] as List).isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Damage Evidence",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (damage["images"] as List).length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 120,
                                margin: EdgeInsets.only(right: spSm),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${(damage["images"] as List)[index]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  if (damage["status"] == "reported") ...[
                    Expanded(
                      child: QButton(
                        label: "Start Investigation",
                        onPressed: () => _startInvestigation(damage),
                      ),
                    ),
                  ] else if (damage["status"] == "investigating") ...[
                    Expanded(
                      child: QButton(
                        label: "Complete Assessment",
                        onPressed: () => _completeAssessment(damage),
                      ),
                    ),
                  ] else if (damage["status"] == "assessed") ...[
                    Expanded(
                      child: QButton(
                        label: "Approve Repair",
                        onPressed: () => _approveRepair(damage),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Approve Disposal",
                        color: warningColor,
                        onPressed: () => _approveDisposal(damage),
                      ),
                    ),
                  ] else if (damage["status"] == "repair_approved") ...[
                    Expanded(
                      child: QButton(
                        label: "Mark as Repaired",
                        onPressed: () => _markRepaired(damage),
                      ),
                    ),
                  ] else if (damage["status"] == "disposal_approved") ...[
                    Expanded(
                      child: QButton(
                        label: "Mark as Disposed",
                        color: disabledBoldColor,
                        onPressed: () => _markDisposed(damage),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _startInvestigation(Map<String, dynamic> damage) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    damage["status"] = "investigating";
    setState(() {});
    
    ss("Investigation started successfully");
  }

  void _completeAssessment(Map<String, dynamic> damage) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    damage["status"] = "assessed";
    damage["assessment_date"] = DateTime.now().toIso8601String();
    damage["assessed_by"] = "Current User";
    setState(() {});
    
    ss("Assessment completed successfully");
  }

  void _approveRepair(Map<String, dynamic> damage) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    damage["status"] = "repair_approved";
    setState(() {});
    
    ss("Repair has been approved");
  }

  void _approveDisposal(Map<String, dynamic> damage) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    damage["status"] = "disposal_approved";
    setState(() {});
    
    sw("Disposal has been approved");
  }

  void _markRepaired(Map<String, dynamic> damage) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    damage["status"] = "repaired";
    damage["total_loss"] = 0.0;
    setState(() {});
    
    ss("Item marked as repaired successfully");
  }

  void _markDisposed(Map<String, dynamic> damage) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    damage["status"] = "disposed";
    damage["salvage_value"] = 0.0;
    setState(() {});
    
    si("Item marked as disposed");
  }

  Widget _buildOverviewTab() {
    final stats = _getOverviewStats();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Damaged Goods Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Damaged", "${stats["total_damaged"]}", Icons.warning, dangerColor),
              _buildStatCard("Reported", "${stats["reported"]}", Icons.report_problem, warningColor),
              _buildStatCard("Investigating", "${stats["investigating"]}", Icons.search, infoColor),
              _buildStatCard("Repaired", "${stats["repaired"]}", Icons.build, successColor),
              _buildStatCard("Disposed", "${stats["disposed"]}", Icons.delete, disabledBoldColor),
              _buildStatCard("Insurance Eligible", "${stats["insurance_eligible"]}", Icons.security, primaryColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildValueCard("Total Loss", "\$${(stats["total_loss"] as double).currency}", Icons.trending_down, dangerColor),
              _buildValueCard("Salvage Value", "\$${(stats["salvage_value"] as double).currency}", Icons.trending_up, successColor),
              _buildValueCard("Repair Costs", "\$${(stats["repair_costs"] as double).currency}", Icons.build, warningColor),
              _buildValueCard("Net Loss", "\$${(stats["net_loss"] as double).currency}", Icons.calculate, dangerColor),
            ],
          ),
          
          SizedBox(height: spLg),
          Text(
            "Recent Damage Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...damagedGoodsData.take(3).map((damage) => _buildDamageCard(damage)),
        ],
      ),
    );
  }

  Widget _buildAllTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              QTextField(
                label: "Search damaged goods...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
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
                      label: "Category",
                      items: categoryOptions,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Facility",
                items: facilityOptions,
                value: selectedFacility,
                onChanged: (value, label) {
                  selectedFacility = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredDamagedGoods.length,
            itemBuilder: (context, index) {
              return _buildDamageCard(filteredDamagedGoods[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final completedDamage = damagedGoodsData.where((d) => 
      d["status"] == "repaired" || d["status"] == "disposed" || d["status"] == "insurance_claimed"
    ).toList();
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: completedDamage.length,
      itemBuilder: (context, index) {
        return _buildDamageCard(completedDamage[index]);
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDamageCard(Map<String, dynamic> damage) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getSeverityColor("${damage["damage_severity"]}"),
          ),
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
                      "${damage["product_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${damage["product_code"]} • ${damage["sku"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${damage["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${damage["priority"]} Priority",
                  style: TextStyle(
                    color: _getPriorityColor("${damage["priority"]}"),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(Icons.warning, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${damage["damage_type"]} - ${damage["damage_severity"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${damage["facility"]}".toUpperCase() + " - ${damage["location"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${damage["quantity_damaged"]} of ${damage["original_quantity"]} units",
                style: TextStyle(color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Loss: \$${(damage["total_loss"] as double).currency}",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${damage["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _formatStatus("${damage["status"]}"),
                  style: TextStyle(
                    color: _getStatusColor("${damage["status"]}"),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Spacer(),
              if (damage["insurance_eligible"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Insurance Eligible",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Reported: ${DateTime.parse(damage["reported_date"]).dMMMy}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              Text(
                "${damage["incident_reference"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () => _showDamageDetails(damage),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Damaged Goods",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Damage", icon: Icon(Icons.warning)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAllTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
