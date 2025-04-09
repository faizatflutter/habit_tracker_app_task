import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_colors.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_constants.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:intl/intl.dart';

class AddHabitBottomSheet extends StatefulWidget {
  final void Function(String name, String frequency, DateTime startDate)? onSubmit;

  const AddHabitBottomSheet({super.key, this.onSubmit});

  @override
  State<AddHabitBottomSheet> createState() => _AddHabitBottomSheetState();
}

class _AddHabitBottomSheetState extends State<AddHabitBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _frequency = 'daily';
  DateTime _startDate = DateTime.now();

  String _formatDate(DateTime date) => DateFormat.yMMMMd().format(date);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        left: 20,
        right: 20,
        bottom: 32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.addHabitTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppStrings.habitName,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
              ),
              validator: (value) => value == null || value.isEmpty ? AppStrings.habitNameValidation : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _frequency,
              decoration: InputDecoration(
                labelText: AppStrings.frequency,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
              ),
              items: [
                DropdownMenuItem(value: 'daily', child: Text(AppStrings.daily)),
                DropdownMenuItem(value: 'weekly', child: Text(AppStrings.weekly)),
              ],
              onChanged: (value) {
                setState(() => _frequency = value!);
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() => _startDate = picked);
                }
              },
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppStyles.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppStrings.startDate}: ${_formatDate(_startDate)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.calendar_today_rounded, color: AppStyles.buttonColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit?.call(
                      _nameController.text.trim(),
                      _frequency,
                      _startDate,
                    );
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
                child: const Text(AppStrings.submit, style: TextStyle(color: AppStyles.whiteColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
