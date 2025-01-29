import 'package:flutter/material.dart';
import 'package:automaat_app/common/static_elements.dart';
import '../model/rest_model/car_model.dart';
import '../controller/rent_car_viewmodel.dart';

class RentCarView extends StatefulWidget {
  final Car car;

  const RentCarView({super.key, required this.car});

  @override
  RentCarViewSate createState() => RentCarViewSate();
}

class RentCarViewSate extends State<RentCarView> {
  DateTime? _startDate;
  DateTime? _endDate;
  late Car car;
  final RentCarViewmodel rentCarViewmodel = RentCarViewmodel();

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();

    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (pickedStartDate != null) {
      final DateTime? pickedEndDate = await showDatePicker(
        context: context,
        initialDate: pickedStartDate.add(const Duration(days: 1)),
        firstDate: pickedStartDate,
        lastDate: DateTime(2100),
      );

      if (pickedEndDate != null) {
        if (pickedEndDate.isBefore(pickedStartDate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('End date cannot be before start date.')),
          );
          return;
        }

        setState(() {
          _startDate = pickedStartDate;
          _endDate = pickedEndDate;
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
            _startDate == null
                ? 'Selecteer het ophaal- en inlevermoment'
                : 'Start: $_startDate \ninlever: $_endDate',
            style: TextStyle(
              fontSize: 22,
              color: SharedWidgets.accentColor,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _pickDateRange(context),
            style: SharedWidgets.automaatButtonStyle,
            child: const Text('Selecteer datum'),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: SharedWidgets.automaatConfirmButtonStyle,
            onPressed: () => {
              rentCarViewmodel.postRental(car, _startDate!, _endDate!, context),
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst),
              }
            },
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
}

