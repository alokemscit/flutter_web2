import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  final colors = <Color>[Colors.indigo, Colors.blue, Colors.orange, Colors.red];

  double _size = 250.0;

  bool _large = true;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedSize(
              curve: Curves.easeIn,
              //  vsync: this,
              duration: Duration(seconds: 1),
              child: LeftDrawer(size: _size)),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.black87),
                          onPressed: () {
                            _updateSize();
                          },
                        ),
                        // FlatButton(
                        //   child: Text(
                        //     'Dashboard',
                        //     style: const TextStyle(color: Colors.black87),
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // FlatButton(
                        //   child: Text(
                        //     'User',
                        //     style: const TextStyle(color: Colors.black87),
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // FlatButton(
                        //   child: Text(
                        //     'Settings',
                        //     style: const TextStyle(color: Colors.black87),
                        //   ),
                        //   onPressed: () {},
                        // ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.brightness_3, color: Colors.black87),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.notification_important,
                              color: Colors.black87),
                          onPressed: () {},
                        ),
                        CircleAvatar(),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            'Home / Admin / Dashboard',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            _container(0),
                            _container(1),
                            _container(2),
                            _container(3),
                          ],
                        ),
                        Container(
                          height: 400,
                          color: Color(0xFFE7E7E7),
                          padding: const EdgeInsets.all(16),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Traffic',
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _container(int index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Color(0xFFE7E7E7),
        child: Card(
          color: Color(0xFFE7E7E7),
          child: Container(
            color: colors[index],
            width: 250,
            height: 140,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      '9.823',
                      style: TextStyle(fontSize: 24),
                    )),
                    Icon(Icons.more_vert),
                  ],
                ),
                Text('Members online')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeftDrawer extends StatelessWidget {
  LeftDrawer({
    // Key key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: size,
        color: const Color(0xFF2C3C56),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              color: Color(0xFF223047),
              child: Text('CORE UI'),
            ),
            //   _tile('Dashboard'),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 30),
                child: Text('THEME',
                    style: TextStyle(
                      color: Colors.white54,
                    ))),
            //  _tile('Colors'),
            // _tile('Typography'),
            // _tile('Base'),
            // _tile('Buttons'),
          ],
        ),
      ),
    );
  }
}
