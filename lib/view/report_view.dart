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
            Text(
              "Attach a Picture",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text("Take Photo"),
                ),
                SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text("Choose from Gallery"),
                ),
              ],
            ),

            SizedBox(height: 16),
            _selectedImage != null
                ? Column(
              children: [
                Image.file(_selectedImage!, height: 150),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                  child: Text("Remove Image", style: TextStyle(color: Colors.red)),
                ),
              ],
            )
                : Text("No image selected"),
            SizedBox(height: 16),
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
