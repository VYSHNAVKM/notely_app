import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:notely_app/features/home/provider/note_card_controller.dart';
import 'package:notely_app/features/home/model/note_card_model.dart';
import 'package:notely_app/features/home/utils/color_constant.dart';
import 'package:notely_app/features/home/utils/textstyle_constant.dart';
import 'package:notely_app/features/home/widgets/drawer_screens/privacypolicy.dart';
import 'package:notely_app/features/home/widgets/drawer_screens/support.dart';
import 'package:notely_app/features/home/widgets/drawer_screens/terms_and_conditions.dart';
import 'package:notely_app/features/home/widgets/note_card/note_card.dart';
import 'package:notely_app/features/home/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  Color selectedColor = Colors.grey;
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    context.read<NoteCardController>().loadEvents();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerWatch = context.watch<NoteCardController>();
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Text(
          'NOTELY',
          style: maintextdark,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
            },
            icon: Icon(
              Icons.search,
              size: 30,
              color: primarycolordark,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: bgcolor,
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Text(
                  'NOTELY',
                  style: maintextdark,
                ),
              )),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: primarycolordark,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Terms and Conditions', style: subtextdark),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndConditionScreen(),
                      ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.mail_outline_outlined,
                      color: primarycolordark,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Support', style: subtextdark),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupportScreen(),
                      ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.privacy_tip_outlined,
                      color: primarycolordark,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Privacy Policy', style: subtextdark),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
      body: Consumer<NoteCardController>(
        builder: (context, value, child) {
          return isloading
              ? Center(
                  child: CircularProgressIndicator(
                  color: primarycolordark,
                ))
              : value.notes.isEmpty
                  ? Center(child: Lottie.asset('assets/animation/empty.json'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.notes.length,
                            itemBuilder: (context, index) {
                              final dateFormatter = DateFormat('dd-MM-yyyy');
                              final note = value.notes[index];
                              final date =
                                  dateFormatter.format(note.date.toLocal());
                              return NoteCard(
                                onEditPressed: () {
                                  value.existingNoteIndex = index;
                                  _addOrEditNote(context, existingNote: note);
                                },
                                onDeletePressed: () async {
                                  await value.deleteEvent(index);
                                  value.loadEvents();
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
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: bgcolor,
          elevation: 15,
          splashColor: primarycolordark,
          onPressed: () {
            providerWatch.existingNoteIndex = -1;
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
    var providerRead = context.read<NoteCardController>();
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
            backgroundColor: bgcolor,
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
                    AppBar(
                      backgroundColor: bgcolor,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: primarycolordark,
                          )),
                      centerTitle: true,
                      title: Text(isEditing ? 'Edit Note' : 'Add Note',
                          style: maintextdark),
                    ),
                    SizedBox(
                      height: 70,
                    ),
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
                            if (_categoryController.text.isNotEmpty &&
                                _titleController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty) {
                              newNote.category = _categoryController.text;
                              newNote.title = _titleController.text;
                              newNote.description = _descriptionController.text;
                              if (isEditing) {
                                await providerRead.updateEvent(
                                    providerRead.existingNoteIndex, newNote);
                              } else {
                                await providerRead.addEvent(newNote);
                              }
                              providerRead.loadEvents();
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.grey,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  backgroundColor: primarycolorlight,
                                  content: Center(
                                    child: Text(
                                      "Please add full details ❗",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              );
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
