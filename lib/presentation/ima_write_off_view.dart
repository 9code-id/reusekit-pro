import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaWriteOffView extends StatefulWidget {
  const ImaWriteOffView({super.key});

  @override
  State<ImaWriteOffView> createState() => _ImaWriteOffViewState();
}

class _ImaWriteOffViewState extends State<ImaWriteOffView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedReason = "";
  String selectedFacility = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Pending Approval", "value": "pending"},
    {"label": "Under Review", "value": "reviewing"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "All Reasons", "value": ""},
    {"label": "Obsolescence", "value": "obsolescence"},
    {"label": "Damage", "value": "damage"},
    {"label": "Expiration", "value": "expiration"},
    {"label": "Theft/Loss", "value": "theft_loss"},
    {"label": "Quality Issues", "value": "quality"},
    {"label": "Overstocking", "value": "overstocking"},
    {"label": "Accounting Adjustment", "value": "accounting"},
  ];

  List<Map<String, dynamic>> facilityOptions = [
    {"label": "All Facilities", "value": ""},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "North Distribution", "value": "north"},
    {"label": "South Distribution", "value": "south"},
    {"label": "East Regional", "value": "east"},
    {"label": "West Regional", "value": "west"},
  ];

  List<Map<String, dynamic>> writeOffData = [
    {
      "id": "WO001",
      "write_off_number": "WO-2024-001",
      "product_name": "iPhone 12 Pro",
      "product_code": "IP12P-128",
      "sku": "ELEC-IP12P-001",
      "category": "Electronics",
      "quantity": 5,
      "unit_cost": 999.0,
      "total_value": 4995.0,
      "reason": "damage",
      "detailed_reason": "Water damage from roof leak incident",
      "status": "reviewing",
      "facility": "main",
      "requested_by": "John Smith",
      "reviewed_by": "Sarah Wilson",
      "approved_by": null,
      "requested_date": "2024-06-15T10:30:00Z",
      "review_date": "2024-06-16T09:00:00Z",
      "approval_date": null,
      "completion_date": null,
      "reference_document": "INC-2024-001",
      "accounting_code": "ACC-WO-DAMAGE",
      "tax_impact": 649.35,
      "insurance_claim": true,
      "disposal_method": "Professional Disposal",
      "disposal_cost": 50.0,
      "images": ["https://picsum.photos/400/300?random=1", "https://picsum.photos/400/300?random=2"],
      "notes": "Devices completely non-functional after water exposure",
      "priority": "High",
      "financial_impact": "Major",
      "requires_audit": true,
      "location": "Warehouse A, Section 2",
      "created_at": "2024-06-15T10:30:00Z",
    },
    {
      "id": "WO002",
      "write_off_number": "WO-2024-002",
      "product_name": "Organic Food Bundle",
      "product_code": "ORG-FB-MIX",
      "sku": "FOOD-ORG-FB-002",
      "category": "Food & Beverage",
      "quantity": 100,
      "unit_cost": 25.0,
      "total_value": 2500.0,
      "reason": "expiration",
      "detailed_reason": "Products reached expiration date before sale",
      "status": "approved",
      "facility": "north",
      "requested_by": "Mike Johnson",
      "reviewed_by": "Emily Davis",
      "approved_by": "David Brown",
      "requested_date": "2024-06-12T14:20:00Z",
      "review_date": "2024-06-13T11:00:00Z",
      "approval_date": "2024-06-14T09:30:00Z",
      "completion_date": null,
      "reference_document": "EXP-2024-002",
      "accounting_code": "ACC-WO-EXPIRY",
      "tax_impact": 325.0,
      "insurance_claim": false,
      "disposal_method": "Donation to Food Bank",
      "disposal_cost": 0.0,
      "images": ["https://picsum.photos/400/300?random=3"],
      "notes": "Expired organic products, still suitable for donation",
      "priority": "Medium",
      "financial_impact": "Moderate",
      "requires_audit": false,
      "location": "Cold Storage Unit 1",
      "created_at": "2024-06-12T14:20:00Z",
    },
    {
      "id": "WO003",
      "write_off_number": "WO-2024-003",
      "product_name": "Vintage Furniture Set",
      "product_code": "VF-SET-001",
      "sku": "FUR-VF-SET-003",
      "category": "Furniture",
      "quantity": 3,
      "unit_cost": 800.0,
      "total_value": 2400.0,
      "reason": "obsolescence",
      "detailed_reason": "Style no longer in demand, stored for 2+ years",
      "status": "completed",
      "facility": "south",
      "requested_by": "Lisa Chen",
      "reviewed_by": "Tom Wilson",
      "approved_by": "Anna Martinez",
      "requested_date": "2024-06-10T11:15:00Z",
      "review_date": "2024-06-11T10:00:00Z",
      "approval_date": "2024-06-12T14:00:00Z",
      "completion_date": "2024-06-14T16:30:00Z",
      "reference_document": "OBS-2024-001",
      "accounting_code": "ACC-WO-OBSOLETE",
      "tax_impact": 312.0,
      "insurance_claim": false,
      "disposal_method": "Auction Sale",
      "disposal_cost": 150.0,
      "images": ["https://picsum.photos/400/300?random=4", "https://picsum.photos/400/300?random=5"],
      "notes": "Successfully sold at auction for 30% of original value",
      "priority": "Low",
      "financial_impact": "Moderate",
      "requires_audit": true,
      "location": "Furniture Showroom B",
      "created_at": "2024-06-10T11:15:00Z",
    },
    {
      "id": "WO004",
      "write_off_number": "WO-2024-004",
      "product_name": "Computer Components",
      "product_code": "COMP-MIX-24",
      "sku": "ELEC-COMP-004",
      "category": "Electronics",
      "quantity": 25,
      "unit_cost": 120.0,
      "total_value": 3000.0,
      "reason": "theft_loss",
      "detailed_reason": "Items missing during inventory count, suspected theft",
      "status": "pending",
      "facility": "east",
      "requested_by": "Robert Garcia",
      "reviewed_by": null,
      "approved_by": null,
      "requested_date": "2024-06-16T09:45:00Z",
      "review_date": null,
      "approval_date": null,
      "completion_date": null,
      "reference_document": "SEC-2024-003",
      "accounting_code": "ACC-WO-THEFT",
      "tax_impact": 390.0,
      "insurance_claim": true,
      "disposal_method": "N/A - Missing Items",
      "disposal_cost": 0.0,
      "images": [],
      "notes": "Security investigation ongoing, police report filed",
      "priority": "High",
      "financial_impact": "Major",
      "requires_audit": true,
      "location": "Electronics Storage Area",
      "created_at": "2024-06-16T09:45:00Z",
    },
    {
      "id": "WO005",
      "write_off_number": "WO-2024-005",
      "product_name": "Textile Samples",
      "product_code": "TEX-SAMP-2024",
      "sku": "TEX-SAMP-005",
      "category": "Textiles",
      "quantity": 50,
      "unit_cost": 15.0,
      "total_value": 750.0,
      "reason": "quality",
      "detailed_reason": "Failed quality control, color bleeding issues",
      "status": "rejected",
      "facility": "west",
      "requested_by": "Jennifer Wilson",
      "reviewed_by": "Michael Brown",
      "approved_by": null,
      "requested_date": "2024-06-13T13:00:00Z",
      "review_date": "2024-06-15T10:30:00Z",
      "approval_date": null,
      "completion_date": null,
      "reference_document": "QC-2024-008",
      "accounting_code": "ACC-WO-QUALITY",
      "tax_impact": 97.5,
      "insurance_claim": false,
      "disposal_method": "Return to Supplier",
      "disposal_cost": 0.0,
      "images": ["https://picsum.photos/400/300?random=6"],
      "notes": "Reviewer determined items can be returned to supplier for credit",
      "priority": "Low",
      "financial_impact": "Minor",
      "requires_audit": false,
      "location": "Quality Control Area",
      "created_at": "2024-06-13T13:00:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredWriteOffs {
    return writeOffData.where((writeOff) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${writeOff["product_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${writeOff["write_off_number"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${writeOff["product_code"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${writeOff["sku"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || writeOff["status"] == selectedStatus;
      bool matchesReason = selectedReason.isEmpty || writeOff["reason"] == selectedReason;
      bool matchesFacility = selectedFacility.isEmpty || writeOff["facility"] == selectedFacility;
      
      return matchesSearch && matchesStatus && matchesReason && matchesFacility;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending": return warningColor;
      case "reviewing": return infoColor;
      case "approved": return successColor;
      case "rejected": return dangerColor;
      case "completed": return successColor;
      case "cancelled": return disabledBoldColor;
      default: return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "Minor": return successColor;
      case "Moderate": return warningColor;
      case "Major": return dangerColor;
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
      case "pending": return "Pending Approval";
      case "reviewing": return "Under Review";
      case "approved": return "Approved";
      case "rejected": return "Rejected";
      case "completed": return "Completed";
      case "cancelled": return "Cancelled";
      default: return status;
    }
  }

  String _formatReason(String reason) {
    switch (reason) {
      case "obsolescence": return "Obsolescence";
      case "damage": return "Damage";
      case "expiration": return "Expiration";
      case "theft_loss": return "Theft/Loss";
      case "quality": return "Quality Issues";
      case "overstocking": return "Overstocking";
      case "accounting": return "Accounting Adjustment";
      default: return reason;
    }
  }

  Map<String, dynamic> _getOverviewStats() {
    int totalWriteOffs = writeOffData.length;
    int pending = writeOffData.where((w) => w["status"] == "pending").length;
    int reviewing = writeOffData.where((w) => w["status"] == "reviewing").length;
    int approved = writeOffData.where((w) => w["status"] == "approved").length;
    int completed = writeOffData.where((w) => w["status"] == "completed").length;

    double totalValue = writeOffData.fold(0.0, (sum, item) => sum + (item["total_value"] as double));
    double taxImpact = writeOffData.fold(0.0, (sum, item) => sum + (item["tax_impact"] as double));
    double disposalCosts = writeOffData.fold(0.0, (sum, item) => sum + (item["disposal_cost"] as double));
    int insuranceClaims = writeOffData.where((w) => w["insurance_claim"] == true).length;

    return {
      "total_write_offs": totalWriteOffs,
      "pending": pending,
      "reviewing": reviewing,
      "approved": approved,
      "completed": completed,
      "total_value": totalValue,
      "tax_impact": taxImpact,
      "disposal_costs": disposalCosts,
      "insurance_claims": insuranceClaims,
      "net_loss": totalValue + disposalCosts,
    };
  }

  void _showWriteOffDetails(Map<String, dynamic> writeOff) {
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
                      "Write-Off Details",
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
                      _buildDetailRow("Write-Off ID", "${writeOff["id"]}"),
                      _buildDetailRow("Write-Off Number", "${writeOff["write_off_number"]}"),
                      _buildDetailRow("Product", "${writeOff["product_name"]}"),
                      _buildDetailRow("Product Code", "${writeOff["product_code"]}"),
                      _buildDetailRow("SKU", "${writeOff["sku"]}"),
                      _buildDetailRow("Category", "${writeOff["category"]}"),
                      _buildDetailRow("Quantity", "${writeOff["quantity"]} units"),
                      _buildDetailRow("Unit Cost", "\$${(writeOff["unit_cost"] as double).currency}"),
                      _buildDetailRow("Total Value", "\$${(writeOff["total_value"] as double).currency}"),
                      _buildDetailRow("Reason", _formatReason("${writeOff["reason"]}")),
                      _buildDetailRow("Status", _formatStatus("${writeOff["status"]}")),
                      _buildDetailRow("Facility", "${writeOff["facility"]}".toUpperCase()),
                      _buildDetailRow("Location", "${writeOff["location"]}"),
                      _buildDetailRow("Priority", "${writeOff["priority"]}"),
                      _buildDetailRow("Financial Impact", "${writeOff["financial_impact"]}"),
                      _buildDetailRow("Requested By", "${writeOff["requested_by"]}"),
                      if (writeOff["reviewed_by"] != null)
                        _buildDetailRow("Reviewed By", "${writeOff["reviewed_by"]}"),
                      if (writeOff["approved_by"] != null)
                        _buildDetailRow("Approved By", "${writeOff["approved_by"]}"),
                      _buildDetailRow("Reference Document", "${writeOff["reference_document"]}"),
                      _buildDetailRow("Accounting Code", "${writeOff["accounting_code"]}"),
                      _buildDetailRow("Tax Impact", "\$${(writeOff["tax_impact"] as double).currency}"),
                      _buildDetailRow("Insurance Claim", writeOff["insurance_claim"] == true ? "Yes" : "No"),
                      _buildDetailRow("Disposal Method", "${writeOff["disposal_method"]}"),
                      if ((writeOff["disposal_cost"] as double) > 0)
                        _buildDetailRow("Disposal Cost", "\$${(writeOff["disposal_cost"] as double).currency}"),
                      _buildDetailRow("Requires Audit", writeOff["requires_audit"] == true ? "Yes" : "No"),
                      _buildDetailRow("Requested Date", DateTime.parse(writeOff["requested_date"]).dMMMy),
                      if (writeOff["review_date"] != null)
                        _buildDetailRow("Review Date", DateTime.parse(writeOff["review_date"]).dMMMy),
                      if (writeOff["approval_date"] != null)
                        _buildDetailRow("Approval Date", DateTime.parse(writeOff["approval_date"]).dMMMy),
                      if (writeOff["completion_date"] != null)
                        _buildDetailRow("Completion Date", DateTime.parse(writeOff["completion_date"]).dMMMy),
                      
                      SizedBox(height: spMd),
                      Text(
                        "Detailed Reason",
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
                        child: Text("${writeOff["detailed_reason"]}"),
                      ),

                      if ("${writeOff["notes"]}".isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Additional Notes",
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
                          child: Text("${writeOff["notes"]}"),
                        ),
                      ],

                      if ((writeOff["images"] as List).isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Supporting Evidence",
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
                            itemCount: (writeOff["images"] as List).length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 120,
                                margin: EdgeInsets.only(right: spSm),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${(writeOff["images"] as List)[index]}"),
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
                  if (writeOff["status"] == "pending") ...[
                    Expanded(
                      child: QButton(
                        label: "Start Review",
                        onPressed: () => _startReview(writeOff),
                      ),
                    ),
                  ] else if (writeOff["status"] == "reviewing") ...[
                    Expanded(
                      child: QButton(
                        label: "Approve",
                        onPressed: () => _approveWriteOff(writeOff),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reject",
                        color: dangerColor,
                        onPressed: () => _rejectWriteOff(writeOff),
                      ),
                    ),
                  ] else if (writeOff["status"] == "approved") ...[
                    Expanded(
                      child: QButton(
                        label: "Mark as Completed",
                        onPressed: () => _completeWriteOff(writeOff),
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

  void _startReview(Map<String, dynamic> writeOff) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    writeOff["status"] = "reviewing";
    writeOff["review_date"] = DateTime.now().toIso8601String();
    writeOff["reviewed_by"] = "Current User";
    setState(() {});
    
    ss("Review started successfully");
  }

  void _approveWriteOff(Map<String, dynamic> writeOff) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    writeOff["status"] = "approved";
    writeOff["approval_date"] = DateTime.now().toIso8601String();
    writeOff["approved_by"] = "Current User";
    setState(() {});
    
    ss("Write-off has been approved");
  }

  void _rejectWriteOff(Map<String, dynamic> writeOff) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    writeOff["status"] = "rejected";
    setState(() {});
    
    sw("Write-off has been rejected");
  }

  void _completeWriteOff(Map<String, dynamic> writeOff) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    writeOff["status"] = "completed";
    writeOff["completion_date"] = DateTime.now().toIso8601String();
    setState(() {});
    
    ss("Write-off has been completed");
  }

  Widget _buildOverviewTab() {
    final stats = _getOverviewStats();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Write-Off Overview",
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
              _buildStatCard("Total Write-Offs", "${stats["total_write_offs"]}", Icons.list_alt, primaryColor),
              _buildStatCard("Pending", "${stats["pending"]}", Icons.pending, warningColor),
              _buildStatCard("Under Review", "${stats["reviewing"]}", Icons.rate_review, infoColor),
              _buildStatCard("Approved", "${stats["approved"]}", Icons.check_circle, successColor),
              _buildStatCard("Completed", "${stats["completed"]}", Icons.done_all, successColor),
              _buildStatCard("Insurance Claims", "${stats["insurance_claims"]}", Icons.security, primaryColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildValueCard("Total Value", "\$${(stats["total_value"] as double).currency}", Icons.attach_money, dangerColor),
              _buildValueCard("Tax Impact", "\$${(stats["tax_impact"] as double).currency}", Icons.receipt, warningColor),
              _buildValueCard("Disposal Costs", "\$${(stats["disposal_costs"] as double).currency}", Icons.delete, disabledBoldColor),
              _buildValueCard("Net Loss", "\$${(stats["net_loss"] as double).currency}", Icons.trending_down, dangerColor),
            ],
          ),
          
          SizedBox(height: spLg),
          Text(
            "Recent Write-Off Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...writeOffData.take(3).map((writeOff) => _buildWriteOffCard(writeOff)),
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
                label: "Search write-offs...",
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
                      label: "Reason",
                      items: reasonOptions,
                      value: selectedReason,
                      onChanged: (value, label) {
                        selectedReason = value;
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
            itemCount: filteredWriteOffs.length,
            itemBuilder: (context, index) {
              return _buildWriteOffCard(filteredWriteOffs[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final completedWriteOffs = writeOffData.where((w) => 
      w["status"] == "completed" || w["status"] == "rejected" || w["status"] == "cancelled"
    ).toList();
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: completedWriteOffs.length,
      itemBuilder: (context, index) {
        return _buildWriteOffCard(completedWriteOffs[index]);
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

  Widget _buildWriteOffCard(Map<String, dynamic> writeOff) {
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
            color: _getImpactColor("${writeOff["financial_impact"]}"),
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
                      "${writeOff["product_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${writeOff["write_off_number"]} • ${writeOff["product_code"]}",
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
                  color: _getPriorityColor("${writeOff["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${writeOff["priority"]} Priority",
                  style: TextStyle(
                    color: _getPriorityColor("${writeOff["priority"]}"),
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
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${writeOff["category"]} - ${_formatReason("${writeOff["reason"]}")}",
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
                "${writeOff["facility"]}".toUpperCase() + " - ${writeOff["location"]}",
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
                "${writeOff["quantity"]} units",
                style: TextStyle(color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "\$${(writeOff["total_value"] as double).currency}",
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
                  color: _getStatusColor("${writeOff["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _formatStatus("${writeOff["status"]}"),
                  style: TextStyle(
                    color: _getStatusColor("${writeOff["status"]}"),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getImpactColor("${writeOff["financial_impact"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${writeOff["financial_impact"]} Impact",
                  style: TextStyle(
                    color: _getImpactColor("${writeOff["financial_impact"]}"),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Spacer(),
              if (writeOff["insurance_claim"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Insurance",
                    style: TextStyle(
                      color: primaryColor,
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
                "Requested: ${DateTime.parse(writeOff["requested_date"]).dMMMy}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              Text(
                "${writeOff["reference_document"]}",
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
              onPressed: () => _showWriteOffDetails(writeOff),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Write-Off Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Write-Offs", icon: Icon(Icons.list_alt)),
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
