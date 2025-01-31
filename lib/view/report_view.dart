import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/view/take_picture_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ReportView extends StatefulWidget  {
  final Rental rental;
  const ReportView({super.key, required this.rental});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends State<ReportView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      String description = _descriptionController.text;

    }
  }

  @override
  Widget build(BuildContext context) {
    Rental rental = widget.rental;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter report details...",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a description";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ConfirmButton(
                text: "Foto maken",
                color: colorScheme.primary,
                onColor: colorScheme.onPrimary,
                onPressed: () async {
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;

                  if (!context.mounted) return;

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TakePictureView(camera: firstCamera))
                  );
                }
            ),
            SizedBox(height: 16),
            ConfirmButton(
                text: "Schadeformulier inleveren",
                color: colorScheme.primary,
                onColor: colorScheme.onPrimary,
                onPressed: _submitReport
            ),
          ],
        ),
      ),
    );
  }
}
