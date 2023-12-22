import 'package:hive/hive.dart';
import 'package:notely_app/model/note_card_model.dart';

class NoteCardController {
  final Box<NoteCardModel> _noteBox = Hive.box('testBox');

  Future<List<NoteCardModel>> loadEvents() async {
    return _noteBox.values.toList();
  }

  Future<void> addEvent(NoteCardModel event) async {
    await _noteBox.add(event);
  }

  Future<void> deleteEvent(int index) async {
    await _noteBox.deleteAt(index);
  }

  Future<void> updateEvent(int index, NoteCardModel updatedNote) async {
    await _noteBox.putAt(index, updatedNote);
  }



}
