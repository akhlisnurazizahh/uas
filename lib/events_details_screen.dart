import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'new_setting_screen.dart';
import 'new_task_screen.dart';
import 'task_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final DateTime selectedDay;
  final List<Map<String, dynamic>> events;
  final Function(Map<String, dynamic>) onSave;

  EventDetailsScreen({
    required this.selectedDay,
    required this.events,
    required this.onSave,
  });

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}





String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  final format = DateFormat.jm(); // menggunakan package intl
  return format.format(dt);
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
 late DateTime _currentDay; // D
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _currentDay = widget.selectedDay; // Initialize _currentDay with selectedDay
  }

  void _goToNextDay() {
    setState(() {
      _currentDay = _currentDay.add(Duration(days: 1));
    });
  }

  void _goToPreviousDay() {
    setState(() {
      _currentDay = _currentDay.subtract(Duration(days: 1));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Telusuri...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _searchEvents(value);
                },
              )
            : Text(
                'Kalender',
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Colors.orange,
         iconTheme: IconThemeData(color: Colors.white),
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                    _searchResults.clear();
                  });
                },
              )
            : null,
        actions: [
          if (_isSearching)
            IconButton(
              icon: Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchResults.clear();
                });
              },
            )
          else
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          _buildPopupMenu(),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      body:
      _searchResults.isNotEmpty
          ? ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final event = _searchResults[index];
                return ListTile(
                  title: Text(event['title'], style: TextStyle(color: Colors.white)),
                  subtitle: Text('${formatTimeOfDay(event['time'])} - ${event['location']}', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          selectedDay: widget.selectedDay,
                          onSave: (newEvent) {
                            widget.onSave(newEvent);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : ListView.builder(
              itemCount: widget.events.length,
              itemBuilder: (context, index) {
                final event = widget.events[index];
                return ListTile(
                  title: Text(event['title'], style: TextStyle(color: Colors.white)),
                  subtitle: Text('${formatTimeOfDay(event['time'])} - ${event['location']}', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          selectedDay: widget.selectedDay,
                          onSave: (newEvent) {
                            widget.onSave(newEvent);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        icon: Icons.add,
        activeIcon: Icons.close,
        overlayColor: Colors.grey.withOpacity(0.9),
        children: [
          SpeedDialChild(
            child: Icon(Icons.event),
            backgroundColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskScreen(
                    selectedDay: widget.selectedDay,
                    onSave: (newEvent) {
                      widget.onSave(newEvent);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add_box),
            backgroundColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewTaskScreen(
                    selectedDay: widget.selectedDay,
                    onSave: (newEvent) {
                      widget.onSave(newEvent);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _searchEvents(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final results = widget.events.where((event) {
      final titleLower = event['title'].toLowerCase();
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
                case 'Buka Tanggal':
                  // Add print logic
                  break;
                case 'Cetak':
                  // Add print logic
                  break;
                case 'Tambahkan hari libur':
                  // Add add holiday logic
                  break;
                case 'Tambahkan ulang tahun kontak':
                  // Add add contact birthday logic
                  break;
                case 'Tambahkan hari jadi kontak':
                  // Add add contact anniversary logic
                  break;
                case 'Impor Acara dari berkas .ics':
                  // Add import .ics logic
                  break;
                case 'Ekspor acara ke berkas .ics':
                  // Add export .ics logic
                  break;
                case 'Pengaturan':

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewSettingScreen(),
              ),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Open Date',
            child: Text('Open Date', style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Print',
            child: Text('Print', style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Add Holiday',
            child: Text('Add Holiday', style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Add Contact Birthday',
            child: Text('Add Contact Birthday',
                style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Add Contact Anniversary',
            child: Text('Add Contact Anniversary',
                style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Import Events from .ics File',
            child: Text('Export Events from .ics File',
                style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Export Events to .ics File',
            child: Text('Export Events to .ics File',
                style: TextStyle(color: Colors.white)),
          ),
          PopupMenuItem<String>(
            value: 'Settings',
            child: Text('Settings', style: TextStyle(color: Colors.white)),
          ),
        ];
      },
      icon: Icon(Icons.more_vert, color: Colors.white),
      color: Color.fromARGB(255, 32, 32, 32),
    );
  }
}
