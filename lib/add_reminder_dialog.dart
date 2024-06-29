import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddReminderDialog extends StatefulWidget {
  final DateTime selectedDay;
  final Function(String title, DateTime dateTime) onSave;

  AddReminderDialog({required this.selectedDay, required this.onSave});

  @override
  _AddReminderDialogState createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  TextEditingController _eventController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Pengingat'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _eventController,
            decoration: InputDecoration(hintText: 'Masukkan acara atau tugas'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2010),
                lastDate: DateTime(2030),
              );
              if (pickedDate != null) {
                _selectedDate = pickedDate;
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                    _selectedDate = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                  });
                }
              }
            },
            child: Text('Pilih Tanggal dan Waktu'),
          ),
          if (_selectedDate != null)
            Text('Tanggal dan waktu terpilih: ${DateFormat.yMMMd().add_jm().format(_selectedDate!)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            if (_eventController.text.isEmpty || _selectedDate == null) return;
            widget.onSave(_eventController.text, _selectedDate!);
            Navigator.pop(context);
          },
          child: Text('Simpan'),
        ),
      ],
    );
  }
}
