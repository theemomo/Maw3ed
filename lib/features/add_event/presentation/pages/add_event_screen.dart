import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/core/widgets/app_button.dart';
import 'package:maw3ed/core/widgets/text_field_widget.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  LatLng? location;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(title: const Text("Add Event")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFieldWidget(
                fieldController: _titleController,
                fieldFocusNode: _titleFocusNode,
                onFieldSubmitted: (value) {
                  _titleFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                hint: "",
                label: "Event Title",
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFieldWidget(
                maxLines: 4,
                fieldController: _descriptionController,
                fieldFocusNode: _descriptionFocusNode,
                onFieldSubmitted: (value) {
                  _descriptionFocusNode.unfocus();
                },
                hint: "",
                label: "Event Description",
                validator: (value) {
                  return null;
                },
              ),

              SizedBox(height: size.height * 0.03),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("Event Date"),
                trailing: TextButton(
                  onPressed: () {
                    _selectDate();
                  },
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : 'Select Date',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text("Event Time"),
                trailing: TextButton(
                  onPressed: _selectTime,
                  child: Text(
                    selectedTime != null
                        ? '${selectedTime!.hour}:${selectedTime!.minute}'
                        : 'Select Time',
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                "Location",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(Icons.location_on),

                  title: Text(
                    location != null
                        ? '${location!.latitude.toStringAsFixed(4)}, ${location!.longitude.toStringAsFixed(4)}'
                        : 'Select Location',
                  ),

                  trailing: TextButton(
                    onPressed: () async {
                      final result = await Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.selectLocationRoute);
                      if (result != null && result is LatLng) {
                        setState(() {
                          location = result;
                        });
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(title: 'Add Event', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    // You can safely use setState() for purely local UI changes that:
    // Don’t affect global or shared state
    // Don’t need to persist across screens
    // Are only temporary visual updates
    setState(() {
      selectedDate = pickedDate;
    });
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = pickedTime;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
