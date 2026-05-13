import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsReminderSettingsView extends StatefulWidget {
  const BrsReminderSettingsView({super.key});

  @override
  State<BrsReminderSettingsView> createState() => _BrsReminderSettingsViewState();
}

class _BrsReminderSettingsViewState extends State<BrsReminderSettingsView> {
  bool appointmentReminders = true;
  bool promotionReminders = false;
  bool specialOfferReminders = true;
  bool birthdayReminders = true;
  bool loyaltyReminders = false;
  
  String appointmentReminderTime = "1_hour";
  String promotionReminderFreq = "weekly";
  String specialOfferReminderTime = "immediately";
  
  List<Map<String, dynamic>> timeOptions = [
    {"label": "15 minutes before", "value": "15_min"},
    {"label": "30 minutes before", "value": "30_min"},
    {"label": "1 hour before", "value": "1_hour"},
    {"label": "2 hours before", "value": "2_hour"},
    {"label": "1 day before", "value": "1_day"},
  ];
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Immediately", "value": "immediately"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder Settings"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              _saveSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Appointment Reminders"),
            _buildAppointmentReminderSection(),
            
            _buildSectionHeader("Marketing Reminders"),
            _buildMarketingReminderSection(),
            
            _buildSectionHeader("Special Occasions"),
            _buildSpecialOccasionSection(),
            
            _buildSectionHeader("Quick Actions"),
            _buildQuickActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fsH6,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildAppointmentReminderSection() {
    return Container(
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable appointment reminders",
                      "value": true,
                      "checked": appointmentReminders,
                    }
                  ],
                  value: [
                    if (appointmentReminders)
                      {
                        "label": "Enable appointment reminders",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    appointmentReminders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (appointmentReminders) ...[
            QDropdownField(
              label: "Default Reminder Time",
              items: timeOptions,
              value: appointmentReminderTime,
              onChanged: (value, label) {
                appointmentReminderTime = value;
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(51),
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
                      "You'll receive a notification and email reminder at your selected time before each appointment.",
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
        ],
      ),
    );
  }

  Widget _buildMarketingReminderSection() {
    return Container(
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Promotion notifications",
                      "value": true,
                      "checked": promotionReminders,
                    }
                  ],
                  value: [
                    if (promotionReminders)
                      {
                        "label": "Promotion notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    promotionReminders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (promotionReminders) ...[
            QDropdownField(
              label: "Promotion Frequency",
              items: frequencyOptions,
              value: promotionReminderFreq,
              onChanged: (value, label) {
                promotionReminderFreq = value;
                setState(() {});
              },
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Special offer alerts",
                      "value": true,
                      "checked": specialOfferReminders,
                    }
                  ],
                  value: [
                    if (specialOfferReminders)
                      {
                        "label": "Special offer alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    specialOfferReminders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (specialOfferReminders) ...[
            QDropdownField(
              label: "Special Offer Timing",
              items: frequencyOptions,
              value: specialOfferReminderTime,
              onChanged: (value, label) {
                specialOfferReminderTime = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpecialOccasionSection() {
    return Container(
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Birthday reminders",
                      "value": true,
                      "checked": birthdayReminders,
                    }
                  ],
                  value: [
                    if (birthdayReminders)
                      {
                        "label": "Birthday reminders",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    birthdayReminders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Loyalty program updates",
                      "value": true,
                      "checked": loyaltyReminders,
                    }
                  ],
                  value: [
                    if (loyaltyReminders)
                      {
                        "label": "Loyalty program updates",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    loyaltyReminders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.cake,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Get special birthday discounts and personalized offers on your special day!",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
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

  Widget _buildQuickActionsSection() {
    return Container(
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
                child: QButton(
                  label: "Enable All",
                  size: bs.sm,
                  onPressed: () {
                    _enableAllReminders();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Disable All",
                  size: bs.sm,
                  onPressed: () {
                    _disableAllReminders();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Reset to Default",
                  size: bs.sm,
                  onPressed: () {
                    _resetToDefault();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Test Reminder",
                  size: bs.sm,
                  onPressed: () {
                    _sendTestReminder();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _enableAllReminders() {
    appointmentReminders = true;
    promotionReminders = true;
    specialOfferReminders = true;
    birthdayReminders = true;
    loyaltyReminders = true;
    setState(() {});
    ss("All reminders enabled");
  }

  void _disableAllReminders() {
    appointmentReminders = false;
    promotionReminders = false;
    specialOfferReminders = false;
    birthdayReminders = false;
    loyaltyReminders = false;
    setState(() {});
    ss("All reminders disabled");
  }

  void _resetToDefault() {
    appointmentReminders = true;
    promotionReminders = false;
    specialOfferReminders = true;
    birthdayReminders = true;
    loyaltyReminders = false;
    appointmentReminderTime = "1_hour";
    promotionReminderFreq = "weekly";
    specialOfferReminderTime = "immediately";
    setState(() {});
    ss("Settings reset to default");
  }

  void _sendTestReminder() {
    ss("Test reminder sent to your device");
  }

  void _saveSettings() {
    // Save reminder settings
    ss("Reminder settings saved successfully");
  }
}
