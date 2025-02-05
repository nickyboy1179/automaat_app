import 'package:automaat_app/component/car_list_item.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/controller/rent_car_viewmodel.dart';
import 'package:intl/intl.dart';

class RentCarView extends StatefulWidget {
  final Car car;

  const RentCarView({super.key, required this.car});

  @override
  RentCarViewSate createState() => RentCarViewSate();
}

class RentCarViewSate extends State<RentCarView> {
  late Car car;
  final RentCarViewmodel rentCarViewmodel = RentCarViewmodel();
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    car = widget.car;
    DateTime now = DateTime.now();
    _startDate = now;
    _endDate = now;
  }

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate = newSelectedDate.start;
        _endDate = newSelectedDate.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

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
                color: colorScheme.primary,
              ),
            ),
            CarListItem(
              car: car,
              color: colorScheme.surface,
              onColor: colorScheme.onSurface,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            Text(
              _startDate.day == _endDate.day
                  ? 'Selecteer het ophaal- en inleverdatum'
                  : 'Ophaaldatum: ${DateFormat('dd-MM-yyyy').format(_startDate)} \nInleverdatum: ${DateFormat('dd-MM-yyyy').format(_endDate)}',
              style: TextStyle(
                fontSize: 22,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            ConfirmButton(
              text: "Selecteer datums",
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
              onPressed: () async {
                final DateTimeRange? dateTimeRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(3000),
                  currentDate: DateTime.now(),
                  initialDateRange:
                      DateTimeRange(start: _startDate, end: _endDate),
                );
                if (dateTimeRange != null) {
                  setState(() {
                    _selectDateRange(dateTimeRange);
                  });
                }
              },
            ),
            const SizedBox(height: 40),
            ConfirmButton(
              text: "Bevestig reservering",
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
              onPressed: () => {
                rentCarViewmodel.postRental(car, _startDate, _endDate, context),
                if (context.mounted)
                  {
                    Navigator.of(context).popUntil((route) => route.isFirst),
                  }
              },
            ),
          ],
        ));
  }
}
