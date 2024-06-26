import 'package:flutter/material.dart';
import 'package:flutter_onenote/account.dart';
import 'package:flutter_onenote/halaman_screen.dart';
import 'package:flutter_onenote/login.dart';

// ignore: must_be_immutable
class DashboardNote extends StatefulWidget {
  const DashboardNote({super.key});
  @override
  State<DashboardNote> createState() => _DashboardNoteState();
}

class _DashboardNoteState extends State<DashboardNote> {
  List<Map<String, String>> notes = [];
  dynamic title;
  dynamic deskripsi;
  void changedata(Map<String, String> result) {
    setState(() {
      notes.add(result);
    });
  }

  // fungsi update note
  void updateNote(int index, String title, String deskripsi) {
    if (index == 0 && index < notes.length) {
      notes[index]['title'] = title;
      notes[index]['deskripsi'] = deskripsi;
    }
  }

  //fungsi mengirim data dari file dashboard ke halaman screen
  void kirimData(int index) async {
    Map<String, String> result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanScreen(
          titleInit: notes[index]['title'],
          deskripsiInit: notes[index]['deskripsi'],
        ),
      ),
    );
    updateNote(index, result['title']!, result['deskripsi']!);
    setState(() {});
  }

  // fungsi delete note
  void deleteNote(int index) {
    if (index == 0 && index < notes.length) {
      notes.removeAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const ListTile(
              leading: Account(),
              title: Text('Admin'),
              subtitle: Text('admin@gmail.com'),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 228, 227, 227),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false),
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
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          title = notes[index]['title'];
          deskripsi = notes[index]['deskripsi'];
          return GestureDetector(
            onTap: () {
              kirimData(index);
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
                      title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      deskripsi,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteNote(index);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ),
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
                onTap: () async {
                  Map<String, String> result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HalamanScreen(),
                    ),
                  );
                  changedata(result);
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
