import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator To Ange Ngi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool checkDot = false;
  double sans = 0;
  String fans = '0';
  String signx = '';

  void _incrementCounter(String num) {
    setState(() {
      if (!checkDot) {
        if (fans == '0' && num == '.') {
          fans = '0';
        } else if (fans == '0') fans = '';
        fans += num;
        if (num == '.') checkDot = true;
      } else {
        if (num != '.') fans += num;
      }
    });
  }

  void clearNum() {
    setState(() {
      fans = '0';
      sans = 0;
      signx = '';
      checkDot = false;
    });
  }

  void calculate(String sign) {
    setState(() {
      if(sans == 0 && signx != ''){
        signx = '';
      }
      if (signx != '') {
        getAns();
      }
      sans = double.parse(fans);
      signx = sign;
      fans = '0';
      checkDot = false;
    });
  }

  void getAns() {
    setState(() {
      if (signx == '+') {
        fans = (sans + double.parse(fans)).toStringAsFixed(5);
        sans = 0;
        signx = '';
      } else if (signx == '-') {
        fans = (sans - double.parse(fans)).toStringAsFixed(5);
        sans = 0;
        signx = '';
      } else if (signx == '*') {
        fans = (sans * double.parse(fans)).toStringAsFixed(5);
        sans = 0;
        signx = '';
      } else if (signx == '/') {
        fans = (sans / double.parse(fans)).toStringAsFixed(5);
        sans = 0;
        signx = '';
      }
      double check = double.parse(fans);
      if (check == check.toInt().toDouble()) {
        fans = double.parse(fans).toInt().toString();
      }
      // RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
      fans = check.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
      // if ()
      checkDot = false;
    });
  }

  setDel() {
    setState(() {
      fans = fans.substring(0, fans.length - 1);
      if (fans == '') fans = '0';
    });
  }

  getSans() {
    var res = '';
    if (sans == 0) {
      res = '';
    } else {
      res = sans.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")+ ' ' + signx + ' ';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        // width: 500 ,
        // alignment: Alignment.topRight,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.l,
          children: <Widget>[
            // Text('$sans $signx', textAlign: TextAlign.right),
            // Text('$fans',
            //     style: TextStyle(fontSize: 50), textAlign: TextAlign.right),
            buildAns(),
            numPad(),
          ],
        ),
      ),
    );
  }

  Widget buildAns() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xffdbdbdb),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(getSans()),
              Text(
                '$fans',
                style: TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget numPad() {
    return Container(
      color: Color(0xffdbdbdb),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              setBtn("7", onTap: () {
                _incrementCounter("7");
              }),
              setBtn("8", onTap: () {
                _incrementCounter("8");
              }),
              setBtn("9", onTap: () {
                _incrementCounter("9");
              }),
              setBtn("÷", onTap: () {
                calculate("/");
              }, color: Colors.orange)
            ],
          ),
          Row(
            children: <Widget>[
              setBtn("4", onTap: () {
                _incrementCounter("4");
              }),
              setBtn("5", onTap: () {
                _incrementCounter("5");
              }),
              setBtn("6", onTap: () {
                _incrementCounter("6");
              }),
              setBtn("x", onTap: () {
                calculate("*");
              }, color: Colors.orange)
            ],
          ),
          Row(
            children: <Widget>[
              setBtn("1", onTap: () {
                _incrementCounter("1");
              }),
              setBtn("2", onTap: () {
                _incrementCounter("2");
              }),
              setBtn("3", onTap: () {
                _incrementCounter("3");
              }),
              setBtn("+", onTap: () {
                calculate("+");
              }, color: Colors.orange)
            ],
          ),
          Row(
            children: <Widget>[
              setBtn("0", onTap: () {
                _incrementCounter("0");
              }),
              setBtn(".", onTap: () {
                _incrementCounter(".");
              }, color: Colors.grey),
              setBtn("C", onTap: () {
                clearNum();
              }, color: Colors.grey),
              setBtn("-", onTap: () {
                calculate("-");
              }, color: Colors.orange)
            ],
          ),
          Row(
            children: <Widget>[
              setBtn("=", onTap: () {
                getAns();
              }, width: 292, color: Colors.orangeAccent),
              setBtn("del", onTap: () {
                setDel();
              }, color: Colors.blueGrey)
            ],
          ),
        ],
      ),
    );
  }

  Widget setBtn(String show,
      {@required Function() onTap,
      double width = 96,
      Color color = Colors.white10}) {
    Widget res;
    res = Container(
      height: 80,
      width: width,
      margin: EdgeInsets.all(1),
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.blue,
          child: Container(
            height: 70,
            child: Center(
              child: Text(
                show,
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );

    return res;
  }
}
