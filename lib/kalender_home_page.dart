import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';
import 'events_details_screen.dart';
import 'new_setting_screen.dart';
import 'new_task_screen.dart';
import 'task_screen.dart';

class KalenderHomePage extends StatefulWidget {
  @override
  _KalenderHomePageState createState() => _KalenderHomePageState();
}

class _KalenderHomePageState extends State<KalenderHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
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
          _buildGridViewPopupMenu(),
          PopupMenuButton<String>(
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
                  value: 'Buka Tanggal',
                  child: Text('Buka Tanggal',
                      style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Cetak',
                  child: Text('Cetak', style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Tambahkan hari libur',
                  child: Text('Tambahkan hari libur',
                      style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Tambahkan ulang tahun kontak',
                  child: Text('Tambahkan ulang tahun kontak',
                      style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Tambahkan hari jadi kontak',
                  child: Text('Tambahkan hari jadi kontak',
                      style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Impor acara ke berkas .ics',
                  child: Text('Ekspor acara dari berkas .ics',
                      style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Ekspor acara ke berkas .ics',
                  child: Text('Ekspor acara dari berkas .ics',
                      style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Pengaturan',
                  child:
                      Text('Pengaturan', style: TextStyle(color: Colors.white)),
                ),
              ];
            },
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: Color.fromARGB(255, 32, 32, 32),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      body: Column(
        children: [
          if (!_isSearching || _searchResults.isEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  locale: 'id_ID',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.week: 'Week',
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay ?? selectedDay;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
                          selectedDay: selectedDay,
                          events: _events[selectedDay] ?? [],
                          onSave: _addEvent,
                        ),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    return _events[day] ?? [];
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: true,
                    markersMaxCount: 1,
                    todayDecoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    weekendTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    holidayTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    todayTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    selectedTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    outsideTextStyle:
                        TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  daysOfWeekHeight: 50,
                  rowHeight: 70,
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          child: _buildEventMarker(events),
                        );
                      }
                      return null;
                    },
                    defaultBuilder: (context, date, _) {
                      if (_events[date] != null && _events[date]!.isNotEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${date.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                              if (_events[date] != null &&
                                  _events[date]!.isNotEmpty) ...[
                                Text(
                                  _events[date]![0]['title'],
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 12,
                                    backgroundColor:
                                        Color.fromARGB(117, 241, 150, 45),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              ...(_events[_selectedDay] ?? [])
                                  .map((event) => ListTile(
                                        title: Text(
                                          event[
                                              'title'], // Accessing the 'title' from the event map
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          event['datetime']
                                              .toString(), // Accessing the 'datetime' from the event map
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                            ],
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          if (_isSearching && _searchResults.isNotEmpty) _buildSearchResults(),
        ],
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
              DateTime selectedDay = _selectedDay ?? DateTime.now();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskScreen(
                    selectedDay: selectedDay,
                    onSave: (newEvent) {
                      _addEvent(newEvent);
                      setState(() {});
                    },
                  ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add_box),
            backgroundColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 18),
            onTap: () {
              DateTime selectedDay = _selectedDay ?? DateTime.now();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewTaskScreen(
                    selectedDay: selectedDay,
                    onSave: (newEvent) {
                      _addEvent(newEvent);
                      setState(() {});
                    },
                  ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
    );
  }

  PopupMenuButton<String> _buildGridViewPopupMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'weekly_view',
            child: RadioListTile<CalendarFormat>(
              title: Text('Tampilan Minggu',
                  style: TextStyle(color: Colors.white)),
              value: CalendarFormat.week,
              groupValue: _calendarFormat,
              onChanged: (CalendarFormat? value) {
                setState(() {
                  _calendarFormat = value!;
                });
                Navigator.pop(context); // Close the PopupMenu
              },
            ),
          ),
          PopupMenuItem<String>(
            value: 'monthly_view',
            child: RadioListTile<CalendarFormat>(
              title:
                  Text('Tampilan Bulan', style: TextStyle(color: Colors.white)),
              value: CalendarFormat.month,
              groupValue: _calendarFormat,
              onChanged: (CalendarFormat? value) {
                setState(() {
                  _calendarFormat = value!;
                });
                Navigator.pop(context); // Close the PopupMenu
              },
            ),
          ),
        ];
      },
      icon: Icon(Icons.grid_view_rounded, color: Colors.white),
      color: Color.fromARGB(255, 32, 32, 32),
      onSelected: (String value) {
        // Handle grid view selection if needed
      },
    );
  }

  void _addEvent(Map<String, dynamic> newEvent) {
    setState(() {
      DateTime date = newEvent['date'];
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(newEvent);
    });
  }

  Widget _buildEventMarker(List events) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          events.length.toString(),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
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

    final results =
        _events.values.expand((eventList) => eventList).where((event) {
      final titleLower = event['title'].toLowerCase();
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final event = _searchResults[index];
          final date = event['date'] as DateTime;
          final formattedDate =
              "${date.month}/${date.day} ${_getDayName(date.weekday)}";
          return ListTile(
            title: Text(
              '${_getMonthName(date.month)}',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  event['title'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      backgroundColor: Colors.black54),
                ),
                Text(
                  '${event['time'].format(context)} - ${event['location']}',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsScreen(
                    selectedDay: event['date'],
                    events: [event],
                    onSave: (newEvent) {
                      _addEvent(newEvent);
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "Januari";
      case 2:
        return "Februari";
      case 3:
        return "Maret";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "Juni";
      case 7:
        return "Juli";
      case 8:
        return "Agustus";
      case 9:
        return "September";
      case 10:
        return "Oktober";
      case 11:
        return "November";
      case 12:
        return "Desember";
      default:
        return "";
    }
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return "Senin";
      case 2:
        return "Selasa";
      case 3:
        return "Rabu";
      case 4:
        return "Kamis";
      case 5:
        return "Jumat";
      case 6:
        return "Sabtu";
      case 7:
        return "Minggu";
      default:
        return "";
    }
  }
}
