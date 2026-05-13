import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaEstimateView extends StatefulWidget {
  const AbaEstimateView({super.key});

  @override
  State<AbaEstimateView> createState() => _AbaEstimateViewState();
}

class _AbaEstimateViewState extends State<AbaEstimateView> {
  // Client Information
  String clientName = "";
  String patientName = "";
  String patientAge = "";
  String diagnosis = "";
  String insuranceProvider = "";
  String insuranceCoverage = "80";
  
  // Assessment Information
  String assessmentType = "comprehensive";
  String assessmentHours = "4";
  String assessmentRate = "120.00";
  
  // Service Information
  List<Map<String, dynamic>> services = [
    {
      "name": "",
      "description": "",
      "hours_per_week": 0,
      "weeks": 0,
      "rate_per_hour": 0.0,
      "total_hours": 0,
      "total_cost": 0.0,
    }
  ];
  
  // Additional Services
  bool includeParentTraining = false;
  String parentTrainingHours = "2";
  String parentTrainingRate = "150.00";
  
  bool includeSocialSkills = false;
  String socialSkillsHours = "3";
  String socialSkillsRate = "130.00";
  
  bool includeConsultation = false;
  String consultationHours = "1";
  String consultationRate = "180.00";
  
  // Estimate Details
  String estimateValidDays = "30";
  String notes = "";
  
  List<Map<String, dynamic>> assessmentOptions = [
    {"label": "Comprehensive Assessment", "value": "comprehensive"},
    {"label": "Behavioral Assessment", "value": "behavioral"},
    {"label": "Functional Assessment", "value": "functional"},
    {"label": "Diagnostic Assessment", "value": "diagnostic"},
  ];
  
  List<Map<String, dynamic>> insuranceOptions = [
    {"label": "Blue Cross Blue Shield", "value": "bcbs"},
    {"label": "Aetna", "value": "aetna"},
    {"label": "Cigna", "value": "cigna"},
    {"label": "UnitedHealth", "value": "united"},
    {"label": "Medicaid", "value": "medicaid"},
    {"label": "Other", "value": "other"},
  ];

  double get assessmentCost {
    double hours = double.tryParse(assessmentHours) ?? 0;
    double rate = double.tryParse(assessmentRate) ?? 0;
    return hours * rate;
  }
  
  double get servicesCost {
    return services.fold(0.0, (sum, service) {
      int hoursPerWeek = service["hours_per_week"] ?? 0;
      int weeks = service["weeks"] ?? 0;
      double rate = service["rate_per_hour"] ?? 0.0;
      return sum + (hoursPerWeek * weeks * rate);
    });
  }
  
  double get additionalServicesCost {
    double cost = 0.0;
    
    if (includeParentTraining) {
      double hours = double.tryParse(parentTrainingHours) ?? 0;
      double rate = double.tryParse(parentTrainingRate) ?? 0;
      cost += hours * rate;
    }
    
    if (includeSocialSkills) {
      double hours = double.tryParse(socialSkillsHours) ?? 0;
      double rate = double.tryParse(socialSkillsRate) ?? 0;
      cost += hours * rate;
    }
    
    if (includeConsultation) {
      double hours = double.tryParse(consultationHours) ?? 0;
      double rate = double.tryParse(consultationRate) ?? 0;
      cost += hours * rate;
    }
    
    return cost;
  }
  
  double get subtotal {
    return assessmentCost + servicesCost + additionalServicesCost;
  }
  
  double get insuranceAmount {
    double coverage = double.tryParse(insuranceCoverage) ?? 0;
    return subtotal * (coverage / 100);
  }
  
  double get estimatedCopay {
    return subtotal - insuranceAmount;
  }

  void _addService() {
    services.add({
      "name": "",
      "description": "",
      "hours_per_week": 0,
      "weeks": 0,
      "rate_per_hour": 0.0,
      "total_hours": 0,
      "total_cost": 0.0,
    });
    setState(() {});
  }
  
  void _removeService(int index) {
    if (services.length > 1) {
      services.removeAt(index);
      setState(() {});
    }
  }
  
  void _updateService(int index, String field, dynamic value) {
    services[index][field] = value;
    
    // Recalculate totals
    int hoursPerWeek = services[index]["hours_per_week"] ?? 0;
    int weeks = services[index]["weeks"] ?? 0;
    double rate = services[index]["rate_per_hour"] ?? 0.0;
    
    services[index]["total_hours"] = hoursPerWeek * weeks;
    services[index]["total_cost"] = hoursPerWeek * weeks * rate;
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ABA Service Estimate"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: _saveEstimate,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.send,
            size: bs.sm,
            onPressed: _sendEstimate,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildEstimateHeader(),
            _buildClientInformation(),
            _buildAssessmentSection(),
            _buildServicesSection(),
            _buildAdditionalServicesSection(),
            _buildEstimateDetailsSection(),
            _buildCostSummary(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimateHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calculate,
            color: primaryColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "ABA Service Estimate",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Create detailed estimates for ABA therapy services",
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
    );
  }

  Widget _buildClientInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Client Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Client Name",
                      value: clientName,
                      hint: "Parent/Guardian name",
                      onChanged: (value) {
                        clientName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Patient Name",
                      value: patientName,
                      hint: "Child's name",
                      onChanged: (value) {
                        patientName = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Patient Age",
                      value: patientAge,
                      hint: "Age in years",
                      onChanged: (value) {
                        patientAge = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Diagnosis",
                      value: diagnosis,
                      hint: "Primary diagnosis",
                      onChanged: (value) {
                        diagnosis = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Insurance Provider",
                      items: insuranceOptions,
                      value: insuranceProvider,
                      onChanged: (value, label) {
                        insuranceProvider = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Coverage %",
                      value: insuranceCoverage,
                      hint: "Insurance coverage percentage",
                      onChanged: (value) {
                        insuranceCoverage = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Assessment Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "\$${assessmentCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Assessment Type",
                items: assessmentOptions,
                value: assessmentType,
                onChanged: (value, label) {
                  assessmentType = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Hours Required",
                      value: assessmentHours,
                      hint: "Total assessment hours",
                      onChanged: (value) {
                        assessmentHours = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Rate per Hour (\$)",
                      value: assessmentRate,
                      hint: "Hourly rate for assessment",
                      onChanged: (value) {
                        assessmentRate = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ABA Therapy Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "\$${servicesCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spMd,
            children: services.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> service = entry.value;
              return _buildServiceCard(index, service);
            }).toList(),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Service",
              icon: Icons.add,
              size: bs.md,
              onPressed: _addService,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(int index, Map<String, dynamic> service) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Service ${index + 1}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (services.length > 1)
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () => _removeService(index),
                ),
            ],
          ),
          QTextField(
            label: "Service Name",
            value: service["name"] ?? "",
            hint: "e.g., Direct ABA Therapy",
            onChanged: (value) {
              _updateService(index, "name", value);
            },
          ),
          QTextField(
            label: "Description",
            value: service["description"] ?? "",
            hint: "Brief description of the service",
            onChanged: (value) {
              _updateService(index, "description", value);
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Hours/Week",
                  value: "${service["hours_per_week"] ?? 0}",
                  hint: "Hours per week",
                  onChanged: (value) {
                    _updateService(index, "hours_per_week", int.tryParse(value) ?? 0);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Weeks",
                  value: "${service["weeks"] ?? 0}",
                  hint: "Number of weeks",
                  onChanged: (value) {
                    _updateService(index, "weeks", int.tryParse(value) ?? 0);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Rate/Hour (\$)",
                  value: "${service["rate_per_hour"] ?? 0.0}",
                  hint: "Hourly rate",
                  onChanged: (value) {
                    _updateService(index, "rate_per_hour", double.tryParse(value) ?? 0.0);
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Hours: ${service["total_hours"] ?? 0}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Total Cost: \$${(service["total_cost"] ?? 0.0).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServicesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "\$${additionalServicesCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spMd,
            children: [
              _buildAdditionalServiceToggle(
                "Parent Training",
                "Training sessions for parents and caregivers",
                includeParentTraining,
                parentTrainingHours,
                parentTrainingRate,
                (value) {
                  includeParentTraining = value;
                  setState(() {});
                },
                (hours) {
                  parentTrainingHours = hours;
                  setState(() {});
                },
                (rate) {
                  parentTrainingRate = rate;
                  setState(() {});
                },
              ),
              _buildAdditionalServiceToggle(
                "Social Skills Training",
                "Specialized social skills development sessions",
                includeSocialSkills,
                socialSkillsHours,
                socialSkillsRate,
                (value) {
                  includeSocialSkills = value;
                  setState(() {});
                },
                (hours) {
                  socialSkillsHours = hours;
                  setState(() {});
                },
                (rate) {
                  socialSkillsRate = rate;
                  setState(() {});
                },
              ),
              _buildAdditionalServiceToggle(
                "Consultation Services",
                "Professional consultation and case management",
                includeConsultation,
                consultationHours,
                consultationRate,
                (value) {
                  includeConsultation = value;
                  setState(() {});
                },
                (hours) {
                  consultationHours = hours;
                  setState(() {});
                },
                (rate) {
                  consultationRate = rate;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServiceToggle(
    String title,
    String description,
    bool isIncluded,
    String hours,
    String rate,
    Function(bool) onToggle,
    Function(String) onHoursChanged,
    Function(String) onRateChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isIncluded ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isIncluded ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": title,
                      "value": true,
                      "checked": isIncluded,
                    }
                  ],
                  value: [
                    if (isIncluded)
                      {
                        "label": title,
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    onToggle(values.isNotEmpty);
                  },
                ),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          if (isIncluded)
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Hours",
                    value: hours,
                    hint: "Total hours",
                    onChanged: onHoursChanged,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Rate/Hour (\$)",
                    value: rate,
                    hint: "Hourly rate",
                    onChanged: onRateChanged,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildEstimateDetailsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Estimate Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Valid for (days)",
                value: estimateValidDays,
                hint: "Estimate validity period",
                onChanged: (value) {
                  estimateValidDays = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Notes",
                value: notes,
                hint: "Additional notes or special considerations",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(20), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Cost Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              _buildCostRow("Assessment Services", assessmentCost),
              _buildCostRow("ABA Therapy Services", servicesCost),
              _buildCostRow("Additional Services", additionalServicesCost),
              Divider(color: disabledColor),
              _buildCostRow("Subtotal", subtotal, isTotal: true),
              _buildCostRow("Insurance Coverage (${insuranceCoverage}%)", -insuranceAmount, isInsurance: true),
              Divider(color: primaryColor),
              _buildCostRow("Estimated Client Copay", estimatedCopay, isFinal: true),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "This is an estimate only. Final costs may vary based on insurance verification and actual services provided.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, double amount, {bool isTotal = false, bool isInsurance = false, bool isFinal = false}) {
    Color textColor = primaryColor;
    FontWeight fontWeight = FontWeight.normal;
    double fontSize = 14;
    
    if (isTotal) {
      fontWeight = FontWeight.w600;
      fontSize = 16;
    } else if (isInsurance) {
      textColor = successColor;
    } else if (isFinal) {
      textColor = primaryColor;
      fontWeight = FontWeight.bold;
      fontSize = 18;
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
        Text(
          "${amount < 0 ? '-' : ''}\$${amount.abs().currency}",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Generate PDF Estimate",
            icon: Icons.picture_as_pdf,
            size: bs.md,
            onPressed: _generatePDF,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save as Draft",
                icon: Icons.drafts,
                size: bs.md,
                onPressed: _saveAsDraft,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Convert to Quote",
                icon: Icons.request_quote,
                size: bs.md,
                onPressed: _convertToQuote,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveEstimate() {
    ss("Estimate saved successfully");
  }

  void _sendEstimate() {
    if (clientName.isEmpty || patientName.isEmpty) {
      se("Please fill in client information");
      return;
    }
    ss("Estimate sent to client");
  }

  void _generatePDF() {
    ss("PDF estimate generated");
  }

  void _saveAsDraft() {
    ss("Estimate saved as draft");
  }

  void _convertToQuote() {
    if (subtotal <= 0) {
      se("Please add services to create a quote");
      return;
    }
    ss("Estimate converted to formal quote");
  }
}
