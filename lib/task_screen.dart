import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  final DateTime selectedDay;
  final Function(Map<String, dynamic>) onSave;

  TaskScreen({required this.selectedDay, required this.onSave});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedTimeID = ''; // Deklarasi variabel _selectedTimeID
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isAllDayEvent = false;
  bool _hasReminder = false;
  bool _isRecurring = false;
  bool _isGeneralEvent = false;
  DateTime _selectedDate = DateTime.now();
  String _reminderOption = 'Tidak ada pengingat';
  String _NewReminderOption = 'Tambah pengingat lainnya';
  String _recurrenceOption = 'Tidak ada perulangan';
  String _categoryOption = 'Acara umum';
  TextEditingController _customReminderController = TextEditingController();
  String _customReminderUnit = 'menit';



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara Baru', style: TextStyle(color: Colors.white)),
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
              controller: _locationController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Lokasi',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 165, 0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 215, 0)),
                ),
                prefixIcon: Icon(Icons.location_on, color: Colors.orange),
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
                  Icon(Icons.access_time,
                      color: Colors
                          .white), // Icon yang Anda pilih (Icon.clock diganti dengan Icons.access_time)
                  SizedBox(width: 8), // Jarak antara ikon dan teks
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
                      ' ${_getMonthName(_selectedDate.month)} ${_selectedDate.day}  ${_getDayName(_selectedDate.weekday)}', // Menampilkan tanggal dan nama bulan
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Text(
                      '${_selectedTime.format(context)}', // Menampilkan waktu yang dipilih
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
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
                      ' ${_getMonthName(_selectedDate.month)} ${_selectedDate.day}  ${_getDayName(_selectedDate.weekday)}', // Menampilkan tanggal dan nama bulan
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Text(
                      '${_selectedTime.format(context)}', // Menampilkan waktu yang dipilih
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
                        value: 'Khusus',
                        groupValue: _reminderOption,
                        onChanged: (String? value) {
                          setState(() {
                            _reminderOption = value!;
                          });
                        },
                      ),
                      Text('Khusus', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () {
                    _showCustomReminderDialog(context);
                  },
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
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
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
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Khusus',
                        groupValue: _recurrenceOption,
                        onChanged: (String? value) {
                          setState(() {
                            _recurrenceOption = value!;
                          });
                        },
                      ),
                      Text('Khusus', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () {
                    _showCustomRecurrenceDialog(context);
                  },
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
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectCategory(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kategori Acara', style: TextStyle(color: Colors.white)),
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
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Hari Libur',
                        groupValue: _categoryOption,
                        onChanged: (String? value) {
                          setState(() {
                            _categoryOption = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      Text('Hari Libur', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Tambah kategori acara baru',
                        groupValue: _categoryOption,
                        onChanged: (String? value) {
                          setState(() {
                            _categoryOption = value!;
                          });
                        },
                      ),
                      Text('Tambah kategori acara baru',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () {
                    _showCustomCategoryDialog(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Radio<String>(
                        value: 'Kelola Kategori acara',
                        groupValue: _categoryOption,
                        onChanged: (String? value) {
                          setState(() {
                            _categoryOption = value!;
                          });
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryTaskScreen()),
                          );
                        },
                      ),
                      Text('Kelola Kategori acara',
                          style: TextStyle(color: Colors.white)),
                    ],
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
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showCustomReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text('Pengingat Khusus', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _customReminderController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nilai',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              DropdownButton<String>(
                value: _customReminderUnit,
                dropdownColor: Colors.black,
                onChanged: (String? newValue) {
                  setState(() {
                    _customReminderUnit = newValue!;
                  });
                },
                items: <String>['menit', 'jam', 'hari']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
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

  void _showCustomRecurrenceDialog(BuildContext context) {
    // Implement your custom recurrence dialog here
  }

  void _showCustomCategoryDialog(BuildContext context) {
    // Implement your custom category dialog here
  }

  void _saveTask() {
    final String title = _titleController.text;
    final String location = _locationController.text;
    final String description = _descriptionController.text;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Judul tidak boleh kosong')),
      );
      return;
    }

    final newEvent = {
      'date': widget.selectedDay,
      'title': title,
      'location': location,
      'description': description,
      'time': _selectedTime,
      'isAllDayEvent': _isAllDayEvent,
      'hasReminder': _hasReminder,
      'reminderOption': _reminderOption,
      'isRecurring': _isRecurring,
      'recurrenceOption': _recurrenceOption,
      'isGeneralEvent': _isGeneralEvent,
      'categoryOption': _categoryOption,
    };

    widget.onSave(newEvent);
    Navigator.pop(context);
  }
}

class CategoryTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Kategori Acara',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Color.fromARGB(255, 32, 32, 32),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Kategori',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            _buildCategoryItem('Acara Umum', Colors.blue),
            SizedBox(height: 8),
            _buildCategoryItem('Hari Libur', Colors.red),
            SizedBox(height: 8),
            _buildCategoryItem('Kategori Baru', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String categoryName, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle category item tap
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 8),
          Text(
            categoryName,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
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
