import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);

  String txt;
  String title = 'welcome';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

//  _MyHomePageState ibj = new _MyHomePageState();
//  _MyHomePageState homepageState = new _MyHomePageState();

  void _incrementCounter(context) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DraggableKeyboard(this);
        }));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            TextField(
              controller: _controller,
            ),
          ],
        ),
      ),
      floatingActionButton: 
      // Hero(
      //     tag: "keyboard",
      //     child: 
          FloatingActionButton(
            onPressed: () {
              _incrementCounter(context);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DraggableKeyboard extends StatefulWidget {
  _MyHomePageState homePage;
  DraggableKeyboard(this.homePage);

  @override
  _DraggableKeyboardState createState() => _DraggableKeyboardState(homePage);
}

class _DraggableKeyboardState extends State<DraggableKeyboard> {
  _MyHomePageState homePage;
  _DraggableKeyboardState(this.homePage);

  double width = 100.0, height = 100.0;
  Offset position;

  @override
  void initState() {
    super.initState();
    position = Offset(460.0, height + 50);
  }

  bool shiftKeyPress = false;
  bool spCharKeyPress = false;
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    final exitKeyboard = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        )
      ],
    );
    Widget _keyButton(BuildContext context, String key, String spChar) {
      return Expanded(
        child: Card(
          color: Colors.white,
          child: Center(
            child: IconButton(
              icon: Text(
                spCharKeyPress == true
                    ? spChar
                    : (shiftKeyPress == false ? key : key.toLowerCase()),
                // shiftKeyPress == false ? key : key.toLowerCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () {
                print("key pressed!!");
                homePage._controller.text += '$key';
              },
            ),
          ),
        ),
      );
    }

    final qwerty = Row(
      children: <Widget>[
        _keyButton(context, 'Q', '1'),
        _keyButton(context, 'W', '2'),
        _keyButton(context, 'E', '3'),
        _keyButton(context, 'R', '4'),
        _keyButton(context, 'T', '5'),
        _keyButton(context, 'Y', '6'),
        _keyButton(context, 'U', '7'),
        _keyButton(context, 'I', '8'),
        _keyButton(context, 'O', '9'),
        _keyButton(context, 'P', '0'),
        Flexible(
          flex: 1,
          child: Container(
            child: Card(
              color: Colors.white70,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.backspace),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        )
      ],
    );
    final asdfg = Row(
      children: <Widget>[
        _keyButton(context, 'A', '±'),
        _keyButton(context, 'S', '!'),
        _keyButton(context, 'D', '@'),
        _keyButton(context, 'F', '#'),
        _keyButton(context, 'G', '\$'),
        _keyButton(context, 'H', '%'),
        _keyButton(context, 'J', '^'),
        _keyButton(context, 'K', '&'),
        _keyButton(context, 'L', '*'),
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            child: Card(
              color: Colors.blue,
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ),
          flex: 2,
        ),
      ],
    );
    final zxcv = Row(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            child: Card(
              color: shiftKeyPress == false ? Colors.white70 : Colors.blue,
              child: IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  //shift key
                  setState(() {
                    shiftKeyPress == false
                        ? shiftKeyPress = true
                        : shiftKeyPress = false;
                  });
                },
              ),
            ),
          ),
          flex: 1,
        ),
        _keyButton(context, 'Z', '('),
        _keyButton(context, 'X', ')'),
        _keyButton(context, 'C', '-'),
        _keyButton(context, 'V', '+'),
        _keyButton(context, 'B', '='),
        _keyButton(context, 'N', '-'),
        _keyButton(context, 'M', '{'),
        _keyButton(context, ',', '}'),
        _keyButton(context, '.', '['),
        _keyButton(context, '/', ']'),
      ],
    );
    final space = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Card(
              color: spCharKeyPress == false ? Colors.white70 : Colors.blue,
              child: IconButton(
                icon: Text(
                  ".?123",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    shiftKeyPress = false;
                    spCharKeyPress == false
                        ? spCharKeyPress = true
                        : spCharKeyPress = false;
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Card(
              color: Colors.white70,
              child: IconButton(
                icon: Icon(Icons.keyboard_voice),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            child: Card(
              color: Colors.white,
              child: IconButton(
                icon: Icon(Icons.space_bar),
                onPressed: () {},
              ),
            ),
          ),
          flex: 4,
        ),
        Expanded(
          child: Container(
            child: Card(
              color: Colors.white70,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Card(
              color: Colors.white70,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
    final _keyboard = Column(
      children: <Widget>[exitKeyboard, qwerty, asdfg, zxcv, space],
    );
    // timeDilation = 3.0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.all(5),
        // color: Colors.red,
        child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Positioned(
              left: position.dx,
              top: position.dy - height,
              child: Draggable(
                maxSimultaneousDrags: 1,

                child:
                    // Hero(
                    //   tag: 'keyboard',
                    //   child:
                    Container(
                  width: deviceWidth * 50 / 100,

                  // height: deviceHeight * 50 / 100,
                  child: Card(
                    color: Colors.white30,
                    child: _keyboard,
                  ),
                ),
                // ),
                feedback:
                    // Hero(
                    //   tag: 'keyboard',
                    //   child:
                    Container(
                  width: deviceWidth * 50 / 100,
                  // height: deviceHeight * 50 / 100,
                  child: Card(
                    color: Colors.white30,
                    child: _keyboard,
                  ),
                ),
                // ),
                childWhenDragging: Container(),
                onDraggableCanceled: (Velocity velocity, Offset offset) {
                  setState(() => position = offset);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
