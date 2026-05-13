import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice3View extends StatefulWidget {
  @override
  State<GrlInvoice3View> createState() => _GrlInvoice3ViewState();
}

class _GrlInvoice3ViewState extends State<GrlInvoice3View> {
  final formKey = GlobalKey<FormState>();
  
  String clientName = "";
  String clientEmail = "";
  String clientPhone = "";
  String clientAddress = "";
  String invoiceNumber = "INV-2024-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
  String invoiceDate = DateTime.now().toIso8601String().split('T')[0];
  String dueDate = DateTime.now().add(Duration(days: 30)).toIso8601String().split('T')[0];
  String notes = "";
  double taxRate = 10.0;
  
  List<Map<String, dynamic>> items = [
    {
      "description": "",
      "quantity": 1,
      "price": 0.0,
      "total": 0.0,
    },
  ];

  List<Map<String, dynamic>> clientSuggestions = [
    {
      "name": "TechStart Inc.",
      "email": "contact@techstart.com",
      "phone": "+1 (555) 987-6543",
      "address": "789 Innovation Drive, San Francisco, CA 94105",
    },
    {
      "name": "Digital Solutions Ltd.",
      "email": "info@digitalsol.com",
      "phone": "+1 (555) 456-7890",
      "address": "456 Business Ave, New York, NY 10001",
    },
    {
      "name": "Marketing Pro Agency",
      "email": "hello@marketingpro.com",
      "phone": "+1 (555) 123-4567",
      "address": "123 Marketing Street, Los Angeles, CA 90210",
    },
  ];

  double get subtotal => items.fold(0.0, (sum, item) => sum + (item["total"] as double));
  double get taxAmount => subtotal * (taxRate / 100);
  double get totalAmount => subtotal + taxAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Invoice"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveInvoice,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              _buildInvoiceHeader(),
              _buildClientSection(),
              _buildInvoiceDetails(),
              _buildItemsSection(),
              _buildTotalsSection(),
              _buildNotesSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(
            Icons.receipt_long,
            color: primaryColor,
            size: 32,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "New Invoice",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Create a professional invoice",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Client Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Select Client",
                size: bs.sm,
                onPressed: _showClientSelector,
              ),
            ],
          ),
          QTextField(
            label: "Client Name",
            value: clientName,
            validator: Validator.required,
            onChanged: (value) {
              clientName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: clientEmail,
            validator: Validator.email,
            onChanged: (value) {
              clientEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: clientPhone,
            onChanged: (value) {
              clientPhone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Address",
            value: clientAddress,
            onChanged: (value) {
              clientAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Invoice Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Invoice Number",
                  value: invoiceNumber,
                  validator: Validator.required,
                  onChanged: (value) {
                    invoiceNumber = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Tax Rate (%)",
                  value: taxRate.toString(),
                  onChanged: (value) {
                    taxRate = double.tryParse(value) ?? 0.0;
                    _calculateTotals();
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Invoice Date",
                  value: DateTime.parse(invoiceDate),
                  onChanged: (value) {
                    invoiceDate = value.toIso8601String().split('T')[0];
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDatePicker(
                  label: "Due Date",
                  value: DateTime.parse(dueDate),
                  onChanged: (value) {
                    dueDate = value.toIso8601String().split('T')[0];
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invoice Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Item",
                size: bs.sm,
                icon: Icons.add,
                onPressed: _addItem,
              ),
            ],
          ),
          ...List.generate(items.length, (index) {
            return _buildItemRow(index);
          }),
        ],
      ),
    );
  }

  Widget _buildItemRow(int index) {
    final item = items[index];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item ${index + 1}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              if (items.length > 1)
                GestureDetector(
                  onTap: () => _removeItem(index),
                  child: Icon(
                    Icons.delete,
                    color: dangerColor,
                    size: 20,
                  ),
                ),
            ],
          ),
          QTextField(
            label: "Description",
            value: item["description"],
            validator: Validator.required,
            onChanged: (value) {
              items[index]["description"] = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: item["quantity"].toString(),
                  onChanged: (value) {
                    items[index]["quantity"] = int.tryParse(value) ?? 1;
                    _calculateItemTotal(index);
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Price (\$)",
                  value: item["price"].toString(),
                  onChanged: (value) {
                    items[index]["price"] = double.tryParse(value) ?? 0.0;
                    _calculateItemTotal(index);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(item["total"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Invoice Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal:", style: TextStyle(fontSize: 16)),
              Text(
                "\$${subtotal.currency}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax (${taxRate.toStringAsFixed(1)}%):", style: TextStyle(fontSize: 16)),
              Text(
                "\$${taxAmount.currency}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalAmount.currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Payment terms, delivery instructions, etc.",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Save Draft",
            size: bs.md,
            onPressed: _saveDraft,
          ),
        ),
        Expanded(
          child: QButton(
            label: "Create Invoice",
            size: bs.md,
            onPressed: _saveInvoice,
          ),
        ),
      ],
    );
  }

  void _showClientSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Select Client",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...clientSuggestions.map((client) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: InkWell(
                    onTap: () {
                      clientName = client["name"];
                      clientEmail = client["email"];
                      clientPhone = client["phone"];
                      clientAddress = client["address"];
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${client["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${client["email"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _addItem() {
    items.add({
      "description": "",
      "quantity": 1,
      "price": 0.0,
      "total": 0.0,
    });
    setState(() {});
  }

  void _removeItem(int index) {
    if (items.length > 1) {
      items.removeAt(index);
      _calculateTotals();
    }
  }

  void _calculateItemTotal(int index) {
    final item = items[index];
    item["total"] = (item["quantity"] as int) * (item["price"] as double);
    setState(() {});
  }

  void _calculateTotals() {
    setState(() {});
  }

  void _saveDraft() {
    ss("Invoice saved as draft");
  }

  void _saveInvoice() {
    if (formKey.currentState!.validate()) {
      ss("Invoice created successfully");
    }
  }
}
