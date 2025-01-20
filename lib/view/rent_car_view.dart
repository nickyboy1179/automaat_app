import 'package:flutter/material.dart';
import 'package:automaat_app/common/shared_widgets.dart';
import '../model/rest_model/car_model.dart';

class RentCarView extends StatefulWidget {
  final Car car;

  const RentCarView({super.key, required this.car});

  @override
  RentCarViewSate createState() => RentCarViewSate();
}

class RentCarViewSate extends State<RentCarView> {
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  late Car car;

  Future<void> _pickDateTime(BuildContext context, DateTime? selectedDate) async {
    final now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final bool isToday = pickedDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day));
      final TimeOfDay initialTime = isToday
          ? TimeOfDay(hour: now.hour, minute: 0)
          : const TimeOfDay(hour: 8, minute: 0);

      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          0,
        );

        if (selectedDateTime.isBefore(now)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a date and time in the future.')),
          );
          return;
        }

        if (_endDateTime != null && selectedDateTime.isAfter(_endDateTime!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('End time cannot be earlier than start time.')),
          );
          return;
        }

        setState(() {
          if (selectedDate == _startDateTime) {
            _startDateTime = selectedDateTime;
          } else {
            _endDateTime = selectedDateTime;
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    car = widget.car;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserveren"),
      ),
      body: Column(
        children: [
          Text(
            "Geselecteerde auto:",
            style: TextStyle(
              fontSize: 22,
              color: SharedWidgets.accentColor,
            ),
          ),
          SharedWidgets.carCard(car, context),
          const SizedBox(height: 20),
          Text(
            _startDateTime == null
                ? 'Selecteer het ophaalmoment'
                : 'Start: $_startDateTime',
            style: TextStyle(
              fontSize: 22,
              color: SharedWidgets.accentColor,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _pickDateTime(context, _startDateTime),
            style: SharedWidgets.automaatButtonStyle,
            child: const Text('Selecteer ophaalmoment'),
          ),
          const SizedBox(height: 20),
          Text(
            _endDateTime == null
                ? 'Selecteer het inlevermoment'
                : 'Eind: $_endDateTime',
            style: TextStyle(
              fontSize: 22,
              color: SharedWidgets.accentColor,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _pickDateTime(context, _endDateTime),
            style: SharedWidgets.automaatButtonStyle,
            child: const Text('Selecteer inlevermoment'),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: SharedWidgets.automaatConfirmButtonStyle,
            onPressed: () => submitRental,
            child: Text(
              "Bevestigen",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )
    );
  }

  void submitRental() {

  }
}

