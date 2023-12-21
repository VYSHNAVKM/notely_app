import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notely_app/controller/note_card_controller.dart';
import 'package:notely_app/model/note_card_model.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';
import 'package:notely_app/view/home_screen/widgets/note_card/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteCardController _noteController = NoteCardController();
  late List<NoteCardModel> _notes = [];
  int existingNoteIndex = -1;
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  Color selectedColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _noteController.loadEvents();
    setState(() {
      _notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: _notes.isEmpty
          ? Center(
              child: Text('Empty notes',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 43, 22, 22),
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final dateFormatter = DateFormat('dd-MM-yyyy');
                      final note = _notes[index];
                      final date = dateFormatter.format(note.date.toLocal());
                      return NoteCard(
                        onEditPressed: () {
                          existingNoteIndex = index;
                          _addOrEditNote(context, existingNote: note);
                        },
                        onDeletePressed: () async {
                          await _noteController.deleteEvent(index);
                          _loadNotes();
                        },
                        category: note.category,
                        title: note.title,
                        description: note.description,
                        date: date,
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primarycolorlight,
          onPressed: () {
            existingNoteIndex = -1;
            _addOrEditNote(context);
          },
          child: Icon(
            Icons.add,
            color: primarycolordark,
            size: 40,
          )),
    );
  }

  void _addOrEditNote(BuildContext ctx, {NoteCardModel? existingNote}) async {
    final isEditing = existingNote != null;
    final newNote = isEditing
        ? NoteCardModel.copy(existingNote)
        : NoteCardModel(
            category: '',
            title: '',
            description: '',
            date: DateTime.now(),
          );

    _categoryController.text = newNote.category;
    _titleController.text = newNote.title;
    _descriptionController.text = newNote.description;
    final dateFormatter = DateFormat('dd-MM-yyyy');
    _dateController.text =
        isEditing ? dateFormatter.format(newNote.date.toLocal()) : '';

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: primarycolordark,
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          isEditing ? 'Edit Note' : 'Add a New Note',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Category',
                          labelStyle: subtextdark),
                      controller: _categoryController,
                      onChanged: (value) {
                        newNote.category = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                          labelStyle: subtextdark),
                      controller: _titleController,
                      onChanged: (value) {
                        newNote.title = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: subtextdark),
                      controller: _descriptionController,
                      onChanged: (value) {
                        newNote.description = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: newNote.date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            newNote.date = selectedDate.toUtc();
                            _dateController.text =
                                dateFormatter.format(newNote.date.toLocal());
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date (dd-MM-yyyy)',
                              labelStyle: subtextdark),
                          controller: _dateController,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey)),
                          onPressed: () async {
                            if (_titleController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty) {
                              if (isEditing) {
                                await _noteController.updateEvent(
                                    existingNoteIndex, newNote);
                              } else {
                                await _noteController.addEvent(newNote);
                              }
                              _loadNotes();
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: Colors.grey,
                                      content: Center(
                                          child: Text(
                                        "Please add full details",
                                        style: TextStyle(fontSize: 18),
                                      ))));
                            }
                          },
                          child: Text(
                            isEditing ? 'Save' : 'Add',
                            style: subtextdark,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: subtextdark,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
