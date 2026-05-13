import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEstimateBuilderView extends StatefulWidget {
  const FsmEstimateBuilderView({super.key});

  @override
  State<FsmEstimateBuilderView> createState() => _FsmEstimateBuilderViewState();
}

class _FsmEstimateBuilderViewState extends State<FsmEstimateBuilderView> {
  String clientName = "";
  String clientEmail = "";
  String clientPhone = "";
  String equipmentType = "";
  String serviceType = "";
  String workDescription = "";
  double laborHours = 0.0;
  double laborRate = 125.0;
  double materialsCost = 0.0;
  double travelCost = 0.0;
  double taxRate = 10.0;
  bool includeWarranty = false;
  String warrantyPeriod = "90 days";
  String estimateNotes = "";

  List<Map<String, dynamic>> lineItems = [];
  
  List<Map<String, dynamic>> serviceTypes = [
    {"label": "Preventive Maintenance", "value": "Preventive Maintenance"},
    {"label": "Corrective Maintenance", "value": "Corrective Maintenance"},
    {"label": "Emergency Repair", "value": "Emergency Repair"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Inspection", "value": "Inspection"},
    {"label": "Software Update", "value": "Software Update"},
  ];

  List<Map<String, dynamic>> equipmentTypes = [
    {"label": "HVAC Systems", "value": "HVAC Systems"},
    {"label": "Industrial Generators", "value": "Industrial Generators"},
    {"label": "Fire Safety Systems", "value": "Fire Safety Systems"},
    {"label": "Conveyor Systems", "value": "Conveyor Systems"},
    {"label": "Security Systems", "value": "Security Systems"},
    {"label": "Manufacturing Equipment", "value": "Manufacturing Equipment"},
  ];

  List<Map<String, dynamic>> warrantyPeriods = [
    {"label": "30 days", "value": "30 days"},
    {"label": "60 days", "value": "60 days"},
    {"label": "90 days", "value": "90 days"},
    {"label": "6 months", "value": "6 months"},
    {"label": "1 year", "value": "1 year"},
  ];

  List<Map<String, dynamic>> recentEstimates = [
    {
      "id": "EST-2024-001",
      "clientName": "Acme Manufacturing",
      "serviceType": "Preventive Maintenance",
      "total": 2850.0,
      "status": "Sent",
      "createdDate": "2024-06-18"
    },
    {
      "id": "EST-2024-002",
      "clientName": "TechFlow Solutions",
      "serviceType": "Emergency Repair",
      "total": 4200.0,
      "status": "Accepted",
      "createdDate": "2024-06-17"
    },
    {
      "id": "EST-2024-003",
      "clientName": "SafeGuard Industries",
      "serviceType": "Inspection",
      "total": 750.0,
      "status": "Draft",
      "createdDate": "2024-06-16"
    }
  ];

  double get subtotal => (laborHours * laborRate) + materialsCost + travelCost;
  double get taxAmount => subtotal * (taxRate / 100);
  double get grandTotal => subtotal + taxAmount;

  void _addLineItem() {
    setState(() {
      lineItems.add({
        "description": "",
        "quantity": 1.0,
        "rate": 0.0,
        "amount": 0.0,
      });
    });
  }

  void _removeLineItem(int index) {
    setState(() {
      lineItems.removeAt(index);
    });
  }

  void _updateLineItem(int index, String field, dynamic value) {
    setState(() {
      lineItems[index][field] = value;
      if (field == "quantity" || field == "rate") {
        double quantity = lineItems[index]["quantity"] as double;
        double rate = lineItems[index]["rate"] as double;
        lineItems[index]["amount"] = quantity * rate;
      }
    });
  }

  void _generateEstimate() {
    if (clientName.isEmpty || serviceType.isEmpty) {
      se("Please fill in required fields");
      return;
    }
    
    ss("Estimate generated successfully!");
    // Navigate to estimate preview or save
  }

  void _saveAsDraft() {
    if (clientName.isEmpty) {
      se("Please enter client name");
      return;
    }
    
    ss("Estimate saved as draft");
  }

  Widget _buildClientInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Client Name *",
            value: clientName,
            hint: "Enter client company name",
            onChanged: (value) {
              clientName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Client Email",
            value: clientEmail,
            hint: "client@company.com",
            onChanged: (value) {
              clientEmail = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Client Phone",
            value: clientPhone,
            hint: "+1 (555) 123-4567",
            onChanged: (value) {
              clientPhone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Equipment Type",
                  items: equipmentTypes,
                  value: equipmentType,
                  onChanged: (value, label) {
                    equipmentType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Service Type *",
                  items: serviceTypes,
                  value: serviceType,
                  onChanged: (value, label) {
                    serviceType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Work Description",
            value: workDescription,
            hint: "Describe the work to be performed...",
            onChanged: (value) {
              workDescription = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pricing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Line Item",
                size: bs.sm,
                onPressed: _addLineItem,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Labor Hours",
                  value: laborHours.toString(),
                  onChanged: (value) {
                    laborHours = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Labor Rate (\$/hour)",
                  value: laborRate.toString(),
                  onChanged: (value) {
                    laborRate = double.tryParse(value) ?? 125.0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Materials Cost (\$)",
                  value: materialsCost.toString(),
                  onChanged: (value) {
                    materialsCost = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Travel Cost (\$)",
                  value: travelCost.toString(),
                  onChanged: (value) {
                    travelCost = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (lineItems.isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "Additional Line Items",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            ...lineItems.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: QTextField(
                            label: "Description",
                            value: item["description"],
                            hint: "Item description",
                            onChanged: (value) {
                              _updateLineItem(index, "description", value);
                            },
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: QNumberField(
                            label: "Qty",
                            value: item["quantity"].toString(),
                            onChanged: (value) {
                              _updateLineItem(index, "quantity", double.tryParse(value) ?? 1.0);
                            },
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: QNumberField(
                            label: "Rate",
                            value: item["rate"].toString(),
                            onChanged: (value) {
                              _updateLineItem(index, "rate", double.tryParse(value) ?? 0.0);
                            },
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () => _removeLineItem(index),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.delete,
                              size: 16,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Amount: \$${(item["amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          SizedBox(height: spSm),
          QNumberField(
            label: "Tax Rate (%)",
            value: taxRate.toString(),
            onChanged: (value) {
              taxRate = double.tryParse(value) ?? 10.0;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    double lineItemsTotal = lineItems.fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double finalSubtotal = subtotal + lineItemsTotal;
    double finalTax = finalSubtotal * (taxRate / 100);
    double finalTotal = finalSubtotal + finalTax;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Estimate Total",
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
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildTotalRow("Labor (${laborHours}h × \$${laborRate.currency})", laborHours * laborRate),
                _buildTotalRow("Materials", materialsCost),
                _buildTotalRow("Travel", travelCost),
                if (lineItemsTotal > 0)
                  _buildTotalRow("Additional Items", lineItemsTotal),
                Container(
                  height: 1,
                  color: successColor.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: spXs),
                ),
                _buildTotalRow("Subtotal", finalSubtotal),
                _buildTotalRow("Tax (${taxRate.toStringAsFixed(1)}%)", finalTax),
                Container(
                  height: 2,
                  color: successColor.withAlpha(100),
                  margin: EdgeInsets.symmetric(vertical: spXs),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "\$${finalTotal.currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: successColor,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWarrantySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Warranty & Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Include Warranty",
                "value": true,
                "checked": includeWarranty,
              }
            ],
            value: [if (includeWarranty) {"label": "Include Warranty", "value": true, "checked": true}],
            onChanged: (values, ids) {
              includeWarranty = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (includeWarranty) ...[
            SizedBox(height: spSm),
            QDropdownField(
              label: "Warranty Period",
              items: warrantyPeriods,
              value: warrantyPeriod,
              onChanged: (value, label) {
                warrantyPeriod = value;
                setState(() {});
              },
            ),
          ],
          SizedBox(height: spSm),
          QMemoField(
            label: "Additional Notes",
            value: estimateNotes,
            hint: "Any additional terms, conditions, or notes...",
            onChanged: (value) {
              estimateNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentEstimates() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Estimates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...recentEstimates.map((estimate) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${estimate["id"]} - ${estimate["clientName"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${estimate["serviceType"]} • ${estimate["createdDate"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${(estimate["total"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estimate Builder"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to estimate history
            },
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Show help
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildClientInfoSection(),
            SizedBox(height: spMd),
            _buildServiceDetailsSection(),
            SizedBox(height: spMd),
            _buildPricingSection(),
            SizedBox(height: spMd),
            _buildTotalSection(),
            SizedBox(height: spMd),
            _buildWarrantySection(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Draft",
                    size: bs.md,
                    onPressed: _saveAsDraft,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate Estimate",
                    size: bs.md,
                    onPressed: _generateEstimate,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            _buildRecentEstimates(),
          ],
        ),
      ),
    );
  }
}
