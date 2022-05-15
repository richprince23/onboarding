import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:onboarding/read_note.dart';
import 'package:path/path.dart';

import 'db/portal_database.dart';
import 'models/notes_db.dart';
import 'constants.dart' as constants;

class MyNotes extends StatefulWidget {
  MyNotes({Key? key}) : super(key: key);
  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> with RouteAware {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  late List<Note> notes;
  bool isLoading = false;
  //get all notes
  Future getNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await PortalDatabase.instance.getNotes();

    setState(() {
      isLoading = false;
    });
  }

//get one note
  Future getNote(int id) async {
    setState(() {
      isLoading = true;
    });

    await PortalDatabase.instance.getNote(id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Notes'),
        backgroundColor: constants.color,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.popAndPushNamed(context, '/add-note');
              Navigator.pushNamed(context, '/add-note');
              didPopNext();
              didPop();
              didPush();
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : buildNotes()),
    );
  }

  Widget buildNotes() {
    return FutureBuilder(
      future: PortalDatabase.instance.getNotes(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GFListTile(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 1),
                // onLongPress: ,
                icon: IconButton(
                    onPressed: () async {
                      //delete note here
                      await PortalDatabase.instance
                          .deleteNote(snapshot.data[index].id)
                          .then((value) {
                        setState(() {
                          snapshot.data!.removeAt(index);
                        });
                      });
                    },
                    icon: const Icon(Icons.delete)),
                color: ThemeData.light().secondaryHeaderColor,
                titleText: Text(snapshot.data[index].title).data,
                subTitle: Text(snapshot.data[index].createdAt),
                onTap: () async {
                  // Navigator.pushNamed(context, '/read-note',
                  //     arguments: snapshot.data[index].id!);
                  print(snapshot.data[index].id);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReadOnlyPage(
                              noteID: snapshot.data[index].id!,
                              title: snapshot.data[index].title.toString(),
                              content: snapshot.data[index].content
                                  .toString()))).then((value) {});
                },
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
        // return const Center(child: Text("No Notes added"));
      },
    );
  }
}
