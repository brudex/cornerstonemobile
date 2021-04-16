import 'package:flutter/material.dart';

class Bible extends StatefulWidget {
  @override
  _BibleState createState() => _BibleState();
}

class _BibleState extends State<Bible> {
  String _currentSelectedBook;
  String _currentSelectedChapter;
  String _currentSelectedVerse;
  String _currentSelectedVersion;

  var _books = [
    "Genesis",
    "Exodus",
    "Leviticus",
    "Numbers",
  ];

  var _chapters = [
    "1",
    "2",
    "3",
    "4",
  ];

  var _verses = [
    "1",
    "2",
    "3",
    "4",
  ];

  var _version = [
    "KJV",
    "NIV",
    "MSG",
    "AMP",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
          title: Text(
            'The Bible',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 3.0, right: 3, bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(_books[0]),
                                value: _currentSelectedBook,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedBook = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _books.map((String value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(_chapters[0]),
                                value: _currentSelectedChapter,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedChapter = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _chapters.map((String value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(_verses[0]),
                                value: _currentSelectedVerse,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedVerse = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _verses.map((String value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(_version[0]),
                                value: _currentSelectedVersion,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedVersion = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _version.map((String value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        '1• In the beginning God created the heaven and the earth \n \n'
                        '2• And the earth was without form, and void; and darkness was upon the face of the deep.'
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
