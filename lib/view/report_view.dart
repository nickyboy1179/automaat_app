import 'dart:io';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/controller/report_controller.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportView extends StatefulWidget  {
  final Rental rental;
  const ReportView({super.key, required this.rental});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends State<ReportView> {
  final ReportController controller = ReportController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submitReport(BuildContext context, Rental rental) async {
    if (_formKey.currentState!.validate()) {
      String description = _descriptionController.text;
      bool success = await controller.submitReport(
          rental,
          description,
          _selectedImage!
      );

      if (!context.mounted) return;

      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
            'Schadeformulier verzonden'
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
            'Er is iets mis gegean, probeer het later nog eens.'
            ),
          ),
        );
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
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
            Center(
              child: Text(
                "Schadeformulier",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Beschrijving",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Voeg beschrijving van de schade toe.",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Voeg een beschrijving toe";
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            Text(
              "Voeg foto toe",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text("Foto nemen"),
                ),
                SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text("Kies foto uit gallerij"),
                ),
              ],
            ),
            SizedBox(height: 16),
            _selectedImage != null
                ? Center(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.file(_selectedImage!),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    child: Text("Foto verwijderen", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            )
                : Center(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text("Geen foto geselecteerd"),
                  SizedBox(height: 8),
                ],
              ),
            ),

            SizedBox(height: 48),
            ConfirmButton(
                text: "Schadeformulier inleveren",
                color: colorScheme.primary,
                onColor: colorScheme.onPrimary,
                onPressed: () {
                  _submitReport(context, rental);
                },
            ),
          ],
        ),
      ),
    );
  }
}
