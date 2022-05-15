import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';
import 'package:onboarding/my_notes.dart';
import 'constants.dart' as constants;
import 'package:onboarding/db/portal_database.dart';
import 'package:onboarding/models/notes_db.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _title = TextEditingController();
  late final _content = _quillController.document.toDelta();

  final QuillController _quillController = QuillController.basic();

  //save note to db
  Future addNote(BuildContext context) async {
    var json = jsonEncode(_content.toJson());

    var nowDate = DateFormat.yMEd().add_jms().format(DateTime.now()).toString();
    if (_title.text.isNotEmpty && !_quillController.document.isEmpty()) {
      Note note = Note(title: _title.text, content: json, createdAt: nowDate);

      PortalDatabase.instance.addNote(note).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Note Saved"),
          backgroundColor: Color.fromRGBO(117, 64, 237, 1),
        ));
        setState(() {
          PortalDatabase.instance.getNotes();
        });
        Navigator.popAndPushNamed(context, '/notes');
        // Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isWide = width > 300;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Note'),
          backgroundColor: constants.color,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                addNote(context);
              },
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _title,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: isWide
                        ? QuillToolbar.basic(
                            controller: _quillController,
                            showAlignmentButtons: false,
                            showCameraButton: false,
                            showCodeBlock: false,
                            showHeaderStyle: false,
                            showLink: false,
                            showQuote: false,
                            showDividers: true,
                            showImageButton: false,
                            showVideoButton: false,
                            showInlineCode: false,
                          )
                        : null,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: QuillEditor.basic(
                          controller: _quillController, readOnly: false),
                    ),
                  ),
                ])));
  }
}
