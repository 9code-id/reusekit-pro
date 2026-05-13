import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRentalConfirmationView extends StatefulWidget {
  const TtaRentalConfirmationView({super.key});

  @override
  State<TtaRentalConfirmationView> createState() => _TtaRentalConfirmationViewState();
}

class _TtaRentalConfirmationViewState extends State<TtaRentalConfirmationView> {
  Map<String, dynamic> rentalBooking = {
    "confirmationNumber": "RC-2024-789012",
    "status": "confirmed",
    "vehicleType": "Sedan",
    "vehicleBrand": "Toyota Camry",
    "pickupLocation": "Barcelona Airport",
    "dropoffLocation": "Hotel Barcelona Center",
    "pickupDate": "2024-06-20",
    "pickupTime": "14:30",
    "dropoffDate": "2024-06-25",
    "dropoffTime": "12:00",
    "totalDays": 5,
    "dailyRate": 45.00,
    "totalAmount": 267.50,
    "insurance": 35.00,
    "taxes": 22.50,
    "finalAmount": 325.00,
    "driverName": "John Smith",
    "driverLicense": "DL123456789",
    "contactNumber": "+1-555-0123",
    "email": "john.smith@email.com",
    "paymentMethod": "Credit Card ****1234"
  };

  List<Map<String, dynamic>> additionalServices = [
    {
      "service": "GPS Navigation",
      "price": 5.00,
      "selected": true,
    },
    {
      "service": "Child Seat",
      "price": 8.00,
      "selected": true,
    },
    {
      "service": "Additional Driver",
      "price": 12.00,
      "selected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmed"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Confirmation details shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfirmationHeader(),
            SizedBox(height: spLg),
            _buildBookingDetails(),
            SizedBox(height: spLg),
            _buildVehicleInfo(),
            SizedBox(height: spLg),
            _buildPickupDropoffInfo(),
            SizedBox(height: spLg),
            _buildAdditionalServices(),
            SizedBox(height: spLg),
            _buildPricingBreakdown(),
            SizedBox(height: spLg),
            _buildDriverInfo(),
            SizedBox(height: spLg),
            _buildImportantNotes(),
            SizedBox(height: spLg),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 64,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "Booking Confirmed!",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Confirmation #${rentalBooking["confirmationNumber"]}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(230),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
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
          Text(
            "Booking Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Status", "${rentalBooking["status"]}", Icons.info),
              ),
              Expanded(
                child: _buildDetailItem("Duration", "${rentalBooking["totalDays"]} days", Icons.calendar_today),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Daily Rate", "\$${(rentalBooking["dailyRate"] as double).currency}", Icons.attach_money),
              ),
              Expanded(
                child: _buildDetailItem("Total Amount", "\$${(rentalBooking["finalAmount"] as double).currency}", Icons.payment),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfo() {
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
          Text(
            "Vehicle Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.directions_car,
                  size: 32,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rentalBooking["vehicleBrand"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${rentalBooking["vehicleType"]} • Automatic",
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
        ],
      ),
    );
  }

  Widget _buildPickupDropoffInfo() {
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
          Text(
            "Pickup & Drop-off",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildLocationTimeItem(
            "Pickup",
            "${rentalBooking["pickupLocation"]}",
            "${rentalBooking["pickupDate"]} at ${rentalBooking["pickupTime"]}",
            Icons.location_on,
            successColor,
          ),
          SizedBox(height: spMd),
          _buildLocationTimeItem(
            "Drop-off",
            "${rentalBooking["dropoffLocation"]}",
            "${rentalBooking["dropoffDate"]} at ${rentalBooking["dropoffTime"]}",
            Icons.location_off,
            dangerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTimeItem(String type, String location, String dateTime, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(51),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                location,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                dateTime,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalServices() {
    List<Map<String, dynamic>> selectedServices = additionalServices.where((service) => service["selected"] == true).toList();
    
    if (selectedServices.isEmpty) return SizedBox.shrink();

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
          Text(
            "Additional Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...selectedServices.map((service) => Padding(
            padding: EdgeInsets.only(bottom: spSm),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${service["service"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "+\$${(service["price"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPricingBreakdown() {
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
          Text(
            "Pricing Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildPriceItem("Rental (${rentalBooking["totalDays"]} days)", "\$${(rentalBooking["totalAmount"] as double).currency}"),
          _buildPriceItem("Insurance", "\$${(rentalBooking["insurance"] as double).currency}"),
          _buildPriceItem("Taxes & Fees", "\$${(rentalBooking["taxes"] as double).currency}"),
          Divider(),
          _buildPriceItem("Total Amount", "\$${(rentalBooking["finalAmount"] as double).currency}", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceItem(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? primaryColor : primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
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
          Text(
            "Driver Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildDetailItem("Name", "${rentalBooking["driverName"]}", Icons.person),
          SizedBox(height: spSm),
          _buildDetailItem("License", "${rentalBooking["driverLicense"]}", Icons.credit_card),
          SizedBox(height: spSm),
          _buildDetailItem("Contact", "${rentalBooking["contactNumber"]}", Icons.phone),
          SizedBox(height: spSm),
          _buildDetailItem("Email", "${rentalBooking["email"]}", Icons.email),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryColor,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNotes() {
    List<String> notes = [
      "Please bring your valid driver's license and credit card",
      "Arrive at pickup location 15 minutes early",
      "Check vehicle for damages before accepting",
      "Keep this confirmation for your records",
      "Contact us if you need to modify your booking"
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Important Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...notes.map((note) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: warningColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    note,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Download Confirmation",
            icon: Icons.download,
            onPressed: () {
              ss("Confirmation downloaded");
            },
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Modify Booking",
                icon: Icons.edit,
                onPressed: () {
                  // Navigate to modify booking
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Contact Support",
                icon: Icons.support_agent,
                onPressed: () {
                  // Navigate to support
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
