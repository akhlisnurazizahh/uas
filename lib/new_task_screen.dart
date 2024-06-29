import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskScreen extends StatefulWidget {
  final DateTime selectedDay;
  final Function(Map<String, dynamic>) onSave;

  NewTaskScreen({required this.selectedDay, required this.onSave});

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedTimeID = '';
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isAllDayEvent = false;
  bool _hasReminder = false;
  bool _isRecurring = false;
  bool _isGeneralEvent = false;
  late DateTime _selectedDate = DateTime.now();
  String _reminderOption = 'Tidak ada pengingat';
  String _NewReminderOption = 'Tambah pengingat lainnya';
  String _recurrenceOption = 'Tidak ada perulangan';
  String _categoryOption = 'Acara umum';
  TextEditingController _customReminderController = TextEditingController();
  String _customReminderUnit = 'menit';
  
 
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDay; // Initialize _selectedDate with widget.selectedDay
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas Baru', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.checkmark_alt),
            onPressed: () {
              _saveTask();
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 32, 32, 32),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Judul',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(235, 146, 12, 1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 248, 180, 78)),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 140, 0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 180, 0)),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Sepanjang Hari',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: _isAllDayEvent,
              onChanged: (bool? value) {
                setState(() {
                  _isAllDayEvent = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.orange,
              checkColor: Colors.white,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Text(
                      ' ${_getMonthName(_selectedDate.month)} ${_selectedDate.day}  ${_getDayName(_selectedDate.weekday)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Text(
                      '${_selectedTime.format(context)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            _buildDivider(),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.notifications, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    _reminderOption,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onTap: () {
                _selectReminder(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  SizedBox(width: 8.0),
                  Text(
                    _NewReminderOption,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              onTap: () {
                _selectReminder(context);
              },
            ),
            _buildDivider(),
            ListTile(
              title: Row(
                children: [
                  Icon(CupertinoIcons.goforward, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    _recurrenceOption,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onTap: () {
                _selectRecurrence(context);
              },
            ),
            _buildDivider(),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.category, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    _categoryOption,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onTap: () {
                _selectCategory(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        // Format waktu ke dalam format 24 jam (ID)
        _selectedTimeID = '${_selectedTime.hour}.${_selectedTime.minute}';
      });
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }

  Future<void> _selectReminder(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pengingat', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Tidak ada pengingat',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Tidak ada pengingat',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Waktu mulai',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Waktu mulai',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '1 menit sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('1 menit sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '5 menit sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('5 menit sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '10 menit sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('10 menit sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '15 menit sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('15 menit sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '30 menit sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('30 menit sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '45 menit sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('45 menit sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '1 jam sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('1 jam sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '2 jam sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('2 jam sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '4 jam sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('4 jam sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '1 hari sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('1 hari sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '2 hari sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('2 hari sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: '1 minggu sebelumnya',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('1 minggu sebelumnya',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: _NewReminderOption,
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                          Navigator.pop(context);
                          _showCustomReminderDialog();
                        },
                      ),
                      Text(_NewReminderOption,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomReminderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Tambah Pengingat Lainnya',
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _customReminderController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Jumlah',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _customReminderUnit,
                  items: <String>[
                    'menit',
                    'jam',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _customReminderUnit = value!;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Unit',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Simpan', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _reminderOption =
                      '${_customReminderController.text} $_customReminderUnit sebelumnya';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectRecurrence(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Perulangan', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Tidak ada perulangan',
                        groupValue: _recurrenceOption,
                        onChanged: (String? value) {
                          setState(() {
                            _recurrenceOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Tidak ada perulangan',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Harian',
                        groupValue: _recurrenceOption,
                        onChanged: (String? value) {
                          setState(() {
                            _recurrenceOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Harian', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Mingguan',
                        groupValue: _recurrenceOption,
                        onChanged: (String? value) {
                          setState(() {
                            _recurrenceOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Mingguan', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Bulanan',
                        groupValue: _recurrenceOption,
                        onChanged: (String? value) {
                          setState(() {
                            _recurrenceOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Bulanan', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Tahunan',
                        groupValue: _recurrenceOption,
                        onChanged: (String? value) {
                          setState(() {
                            _recurrenceOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Tahunan', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectCategory(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kategori', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Acara umum',
                        groupValue: _categoryOption,
                        onChanged: (String? value) {
                          setState(() {
                            _categoryOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Acara umum', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                // Add more categories as needed
              ],
            ),
          ),
        );
      },
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return "(Sen)";
      case 2:
        return "(sel)";
      case 3:
        return "Rabu";
      case 4:
        return "(Kam)";
      case 5:
        return "(Jum)";
      case 6:
        return "(Sab)";
      case 7:
        return "(Min)";
      default:
        return "";
    }
  }
   void _saveTask() {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    DateTime selectedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    String reminder = _reminderOption;
    String recurrence = _recurrenceOption;

    // Package up your task details into a map or object
    Map<String, dynamic> taskDetails = {
      'title': title,
      'description': description,
      'dateTime': selectedDateTime,
      'reminder': reminder,
      'recurrence': recurrence,
    };

    // Call the onSave callback provided by the parent widget
    widget.onSave(taskDetails);

    // Close the screen
    Navigator.pop(context);
  }

}
