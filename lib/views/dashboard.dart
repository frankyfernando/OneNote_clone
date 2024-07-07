import 'package:flutter/material.dart';
import 'package:flutter_onenote/model/notes_model.dart';
import 'package:flutter_onenote/views/account.dart';
import 'package:flutter_onenote/views/halaman_screen.dart';
import 'package:flutter_onenote/provider/notes_provider.dart';
import 'package:flutter_onenote/views/login.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DashboardNote extends StatefulWidget {
  const DashboardNote({super.key});
  @override
  State<DashboardNote> createState() => _DashboardNoteState();
}

class _DashboardNoteState extends State<DashboardNote> {
  @override
  Widget build(BuildContext context) {
    final readNote = context.read<NoteData>();
    final watchNote = context.watch<NoteData>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        shadowColor: Colors.grey,
        elevation: 3,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => scaffoldKey.currentState!.openDrawer(),
                  child: const Account(),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'OneNote',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Text(
                    'Akun',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Account(),
              title: const Text('User'),
              subtitle: Text('${readNote.emailController.text}'),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 228, 227, 227),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  readNote.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false);
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'Keluar dari OneNote',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<NotesModel>>(
        stream: readNote.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print("${snapshot.error}");
            return Center(
              child: const Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }
          List<NotesModel> notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  readNote.titleController =
                      TextEditingController(text: notes[index].title);
                  readNote.deskripsiController =
                      TextEditingController(text: notes[index].deskripsi);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HalamanScreen(
                                metode: "update",
                                noteId: notes[index].id!,
                              )));
                  readNote.titleController = TextEditingController(text: '');
                  readNote.deskripsiController =
                      TextEditingController(text: '');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 1,
                        offset: const Offset(1, 0),
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, -1),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          notes[index].title ?? '-',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          notes[index].deskripsi ?? '-',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            watchNote.deleteNotes(notes[index].id!);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HalamanScreen(
                        metode: 'add',
                        noteId: "",
                      ),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.purple,
                    ),
                    Text(
                      'Halaman',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.create),
                  color: Colors.purple,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.purple,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_outlined),
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
