import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/core/widgets/app_button.dart';
import 'package:maw3ed/core/widgets/text_field_widget.dart';
import 'package:maw3ed/features/add_event/presentation/cubits/add_event_cubit/add_event_cubit.dart';
import 'package:maw3ed/generated/l10n.dart';

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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          S.of(context).addEvent,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).title,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                label: S.of(context).eventTitle,
                validator: (value) => null,
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                S.of(context).description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFieldWidget(
                maxLines: 4,
                fieldController: _descriptionController,
                fieldFocusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) => _descriptionFocusNode.unfocus(),
                hint: "",
                label: S.of(context).eventDescription,
                validator: (value) => null,
              ),
              SizedBox(height: size.height * 0.03),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: Text(S.of(context).eventDate),
                trailing: TextButton(
                  onPressed: _selectDate,
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : S.of(context).selectDate,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(S.of(context).eventTime),
                trailing: TextButton(
                  onPressed: _selectTime,
                  child: Text(
                    selectedTime != null
                        ? '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                        : S.of(context).selectTime,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                S.of(context).location,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                        : S.of(context).selectLocation,
                  ),
                  trailing: TextButton(
                    onPressed: () async {
                      final result = await Navigator.of(context)
                          .pushNamed(AppRoutes.selectLocationRoute);
                      if (result != null && result is LatLng) {
                        setState(() => location = result);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              BlocConsumer<AddEventCubit, AddEventState>(
                listener: (context, state) {
                  if (state is AddEventFailure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[900],
                          duration: const Duration(seconds: 3),
                        ),
                      );
                  } else if (state is AddEventSuccess) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                         SnackBar(
                          content: Text(
                            S.of(context).eventAddedSuccessfully,
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 1),
                        ),
                      );

                    Future.delayed(const Duration(seconds: 1), () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.homeRoute);
                      }
                    });
                  }
                },
                builder: (context, state) {
                  if (state is AddEventLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  return AppButton(
                    title: S.of(context).addEvent,
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _descriptionController.text.isEmpty ||
                          selectedDate == null ||
                          selectedTime == null ||
                          location == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:  Text(S.of(context).fillAllFields),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.orange[900],
                          ),
                        );
                        return;
                      }

                      context.read<AddEventCubit>().addEvent(
                            _titleController.text,
                            _descriptionController.text,
                            selectedDate,
                            selectedTime,
                            location,
                            context
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  Future<void> _selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() => selectedTime = pickedTime);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
