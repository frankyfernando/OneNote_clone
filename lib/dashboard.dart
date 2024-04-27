import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_onenote/account.dart';

class DashboardNote extends StatefulWidget {
  const DashboardNote({super.key});

  @override
  State<DashboardNote> createState() => _DashboardNoteState();
}

class _DashboardNoteState extends State<DashboardNote> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  child: Account(),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OneNote',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
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
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    'Akun',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Account(),
              title: Text('Admin'),
              subtitle: Text('admin@gamil.com'),
            ),
            Divider(
              thickness: 1,
              color: Color.fromARGB(255, 228, 227, 227),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.purple,
              ),
              title: Text(
                'Keluar dari OneNote',
                style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),

              ),
            )
          ],
        ),
      ),
      
    );
  }
}
