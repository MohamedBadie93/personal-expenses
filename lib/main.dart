import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses2/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';
import './models/transaction.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(
  //[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PersonalExpenses2',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        buttonColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 15.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Milk', amount: 5, date: DateTime.now()),
    Transaction(
        id: 't3',
        title: 'Milk1',
        amount: 7,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't4',
        title: 'Milk2',
        amount: 8,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: 't5', title: 'Milk3', amount: 5, date: DateTime.now()),
    Transaction(id: 't6', title: 'Milk4', amount: 5, date: DateTime.now()),
    Transaction(id: 't7', title: 'Milk5', amount: 5, date: DateTime.now()),
  ];

  bool _showChart = false;

  void _addTransaction(
      String enteredTitle, double enteredAmount, DateTime pickedDate) {
    // instialize new transaction
    var newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        date: pickedDate);
    // add it to transactions list

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext bCtx) {
        return GestureDetector(
          child: NewTransaction(_addTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandScapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListwidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chart'),
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) * // status bar
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListwidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListwidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListwidget
    ];
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('PersonalExpenses2'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            startAddNewTransaction(context);
          },
        )
      ],
    );

    final txListwidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(_userTransactions, _removeTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandScape)
              ..._buildLandScapeContent(mediaQuery, appBar, txListwidget),
            if (!_isLandScape)
              ..._buildPortraitContent(mediaQuery, appBar, txListwidget),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
