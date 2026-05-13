import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsDownloadInvoiceView extends StatefulWidget {
  const EcsDownloadInvoiceView({super.key});

  @override
  State<EcsDownloadInvoiceView> createState() => _EcsDownloadInvoiceViewState();
}

class _EcsDownloadInvoiceViewState extends State<EcsDownloadInvoiceView> {
  bool isDownloading = false;
  double downloadProgress = 0.0;
  
  List<Map<String, dynamic>> invoiceHistory = [
    {
      "invoiceNumber": "INV-2024-001234",
      "orderNumber": "ORD-2024-001234",
      "date": "2024-06-14",
      "amount": 321.96,
      "status": "Paid",
      "downloadable": true,
      "size": "245 KB"
    },
    {
      "invoiceNumber": "INV-2024-001233",
      "orderNumber": "ORD-2024-001233", 
      "date": "2024-06-10",
      "amount": 156.78,
      "status": "Paid",
      "downloadable": true,
      "size": "198 KB"
    },
    {
      "invoiceNumber": "INV-2024-001232",
      "orderNumber": "ORD-2024-001232",
      "date": "2024-06-05",
      "amount": 89.99,
      "status": "Paid", 
      "downloadable": true,
      "size": "156 KB"
    },
    {
      "invoiceNumber": "INV-2024-001231",
      "orderNumber": "ORD-2024-001231",
      "date": "2024-05-28",
      "amount": 234.50,
      "status": "Pending",
      "downloadable": false,
      "size": "0 KB"
    },
    {
      "invoiceNumber": "INV-2024-001230",
      "orderNumber": "ORD-2024-001230",
      "date": "2024-05-22",
      "amount": 567.89,
      "status": "Paid",
      "downloadable": true,
      "size": "312 KB"
    }
  ];

  String selectedFormat = "PDF";
  List<String> downloadFormats = ["PDF", "Excel", "Word"];
  
  List<String> selectedInvoices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Invoices"),
        actions: [
          IconButton(
            onPressed: selectedInvoices.isNotEmpty ? _downloadSelected : null,
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDownloadOptions(),
            SizedBox(height: spLg),
            if (isDownloading) _buildDownloadProgress(),
            if (isDownloading) SizedBox(height: spLg),
            _buildBulkActions(),
            SizedBox(height: spLg),
            _buildInvoiceList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadOptions() {
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
              Icon(Icons.settings, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Download Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "File Format",
            items: downloadFormats.map((format) => {
              "label": format,
              "value": format,
            }).toList(),
            value: selectedFormat,
            onChanged: (value, label) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "PDF format recommended for official records. Excel format for data analysis.",
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

  Widget _buildDownloadProgress() {
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
              Icon(Icons.download, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Downloading...",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          LinearProgressIndicator(
            value: downloadProgress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(downloadProgress * 100).toInt()}% completed",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${selectedInvoices.length} file(s)",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActions() {
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
              Icon(Icons.checklist, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Select All",
                  size: bs.sm,
                  onPressed: _selectAll,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Clear All",
                  size: bs.sm,
                  onPressed: _clearAll,
                ),
              ),
            ],
          ),
          if (selectedInvoices.isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: primaryColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "${selectedInvoices.length} invoice(s) selected",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInvoiceList() {
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
              Icon(Icons.receipt_long, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Available Invoices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...invoiceHistory.map((invoice) => _buildInvoiceItem(invoice)).toList(),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(Map<String, dynamic> invoice) {
    bool isSelected = selectedInvoices.contains(invoice["invoiceNumber"]);
    bool isDownloadable = invoice["downloadable"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(20) : null,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: isDownloadable ? () => _toggleSelection(invoice["invoiceNumber"]) : null,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: isDownloadable ? (isSelected ? primaryColor : disabledBoldColor) : disabledColor,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${invoice["invoiceNumber"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isDownloadable ? null : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: invoice["status"] == "Paid" ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${invoice["status"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXxs),
                Text(
                  "Order: ${invoice["orderNumber"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spXxs),
                Row(
                  children: [
                    Text(
                      "${invoice["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((invoice["amount"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${invoice["size"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isDownloadable)
            GestureDetector(
              onTap: () => _downloadSingle(invoice),
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.download,
                  color: primaryColor,
                  size: 16,
                ),
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(spXs),
              child: Icon(
                Icons.lock,
                color: disabledColor,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }

  void _toggleSelection(String invoiceNumber) {
    if (selectedInvoices.contains(invoiceNumber)) {
      selectedInvoices.remove(invoiceNumber);
    } else {
      selectedInvoices.add(invoiceNumber);
    }
    setState(() {});
  }

  void _selectAll() {
    selectedInvoices = invoiceHistory
        .where((invoice) => invoice["downloadable"] as bool)
        .map((invoice) => invoice["invoiceNumber"] as String)
        .toList();
    setState(() {});
  }

  void _clearAll() {
    selectedInvoices.clear();
    setState(() {});
  }

  void _downloadSingle(Map<String, dynamic> invoice) {
    _startDownload([invoice["invoiceNumber"]]);
  }

  void _downloadSelected() {
    if (selectedInvoices.isNotEmpty) {
      _startDownload(selectedInvoices);
    }
  }

  void _startDownload(List<String> invoiceNumbers) {
    isDownloading = true;
    downloadProgress = 0.0;
    setState(() {});

    // Simulate download progress
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      downloadProgress += 0.05;
      setState(() {});

      if (downloadProgress >= 1.0) {
        timer.cancel();
        isDownloading = false;
        downloadProgress = 0.0;
        selectedInvoices.clear();
        setState(() {});
        
        ss("${invoiceNumbers.length} invoice(s) downloaded as $selectedFormat");
      }
    });
  }
}
