import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Color backgroundColor = Color(0xFF2d2d39);

class TransactionDetails {
  final String item;
  final String companyName;
  final int ammount;
  final bool income;
  final IconData icon;

  TransactionDetails({
    @required this.item,
    @required this.ammount,
    @required this.companyName,
    @required this.income,
    @required this.icon,
  });
}

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 200);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  double mainBorderRadius = 0;
  Brightness statusIconColor = Brightness.dark;

  List<TransactionDetails> todayTransactionsList = [
    new TransactionDetails(
      item: 'Macbook Pro 15"',
      companyName: 'Apple',
      ammount: 2499,
      income: false,
      icon: Icons.computer,
    ),
    new TransactionDetails(
      item: 'Incoming Transfer',
      companyName: 'Upwork',
      ammount: 499,
      income: true,
      icon: Icons.transit_enterexit,
    ),
  ];

  List<TransactionDetails> yesterdayTransactionsList = [
    new TransactionDetails(
      item: 'Beats Headphone 2th Gen',
      companyName: 'Apple',
      ammount: 199,
      income: false,
      icon: Icons.headset,
    ),
    new TransactionDetails(
      item: 'Cake',
      companyName: 'StarBucks',
      ammount: 19,
      income: false,
      icon: Icons.cake,
    ),
    new TransactionDetails(
      item: 'Money Transfer',
      companyName: 'eSewa',
      ammount: 499,
      income: true,
      icon: Icons.transit_enterexit,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget menuItem({
    IconData iconData,
    String title,
    bool active: false,
  }) {
    return SizedBox(
      width: 0.5 * screenWidth,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Icon(
                iconData,
                color: (active) ? Colors.white : Colors.grey,
                size: 22,
              ),
            ),
            Expanded(
              flex: 14,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "$title",
                  style: TextStyle(
                    color: (active) ? Colors.white : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 40),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        width: 0.3 * screenWidth,
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 10,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            SizedBox(
                              height: 0.3 * screenWidth,
                              width: 0.3 * screenWidth,
                              child: Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('assets/dp.jpg')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Text(
                              'Bibash Adhikari',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'San Franciso, CA',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      menuItem(
                        title: "Dashboard",
                        iconData: Icons.account_balance_wallet,
                        active: true,
                      ),
                      menuItem(
                        title: "Messages",
                        iconData: Icons.chat_bubble_outline,
                      ),
                      menuItem(
                        title: "Utility Bills",
                        iconData: Icons.receipt,
                      ),
                      menuItem(
                        title: "Funds Transfer",
                        iconData: Icons.swap_horiz,
                      ),
                      menuItem(
                        title: "Branches",
                        iconData: Icons.developer_board,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                menuItem(
                  title: "Logout",
                  iconData: Icons.exit_to_app,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment(-1, 1),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: IconButton(
                  highlightColor: Colors.red,
                  splashColor: Colors.greenAccent,
                  icon: Icon(
                    Icons.home,
                    color: Color(0xffa1a5b5),
                  ),
                  iconSize: 28,
                  onPressed: () {},
                )),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.swap_horiz,
                  color: Color(0xffa1a5b5),
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.show_chart,
                  color: Color(0xffa1a5b5),
                ),
                iconSize: 28,
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.notifications_none,
                  color: Color(0xffa1a5b5),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.person_outline,
                  color: Color(0xffa1a5b5),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget creditCard({
    String amount,
    String cardNumber,
    String cardHolder,
    String expiringDate,
    String bankEnding,
    Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            children: <Widget>[
              Text(
                'Current Balance',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                '\$$amount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '**** **** **** $cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  letterSpacing: 1.3,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Card Holder',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '$cardHolder',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Expires',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '$expiringDate',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 25,
            top: 25,
            child: SizedBox(
              // width: 90,
              child: Row(
                children: <Widget>[
                  Text(
                    'Bank',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$bankEnding',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: Container(
              child: Icon(
                Icons.credit_card,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionList(
    List<TransactionDetails> transactionList,
    String strDate, {
    bool lastElement: false,
  }) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          child: Text(
            '$strDate',
            style: TextStyle(
              color: Color(0xffadb2be),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 10, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            TransactionDetails _transaction = transactionList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      _transaction.icon,
                    ),
                  ],
                ),
                title: Text(
                  "${_transaction.item}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "${_transaction.companyName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  (_transaction.income)
                      ? "+${_transaction.ammount} \$"
                      : " -${_transaction.ammount} \$",
                  style: TextStyle(
                    fontSize: 18,
                    color: (_transaction.income) ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
          itemCount: transactionList.length,
        ),
      ],
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      width: screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.circular(mainBorderRadius),
          animationDuration: duration,
          color: Color(0xfff4faff),
          child: SafeArea(
              child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 50,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.drag_handle,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isCollapsed) {
                                      mainBorderRadius = 30;
                                      statusIconColor = Brightness.light;
                                      _controller.forward();
                                    } else {
                                      _controller.reverse();
                                      mainBorderRadius = 0;
                                      statusIconColor = Brightness.dark;
                                    }
                                    isCollapsed = !isCollapsed;
                                  });
                                },
                              ),
                              Text(
                                "My Cards",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xff1c7bfd),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: (MediaQuery.of(context).size.width - 30) *
                              (8 / 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: PageView(
                            controller: PageController(viewportFraction: 0.9),
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true,
                            children: <Widget>[
                              creditCard(
                                amount: '12565.23',
                                cardHolder: 'Bibash Adhikari',
                                cardNumber: '4545',
                                expiringDate: '02/21',
                                bankEnding: 'X',
                                backgroundColor: Colors.deepOrangeAccent,
                              ),
                              creditCard(
                                amount: '1778.23',
                                cardHolder: 'Ram Adhikari',
                                cardNumber: '5045',
                                expiringDate: '02/21',
                                bankEnding: 'Y',
                                backgroundColor: Colors.blueAccent,
                              ),
                              creditCard(
                                amount: '15689556.23',
                                cardHolder: 'Bibash Adhikari',
                                cardNumber: '0545',
                                expiringDate: '02/21',
                                bankEnding: 'PAGAL',
                                backgroundColor: Colors.redAccent,
                              ),
                              creditCard(
                                amount: '1203456.23',
                                cardHolder: 'Bibash Adhikari',
                                cardNumber: '5405',
                                expiringDate: '02/21',
                                bankEnding: 'ONE',
                                backgroundColor: Colors.greenAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 16,
                            left: 16,
                            right: 16,
                          ),
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shrinkWrap: true,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Transactions",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      color: Color(0xffa4a6b8),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              transactionList(todayTransactionsList, 'Today'),
                              transactionList(
                                  yesterdayTransactionsList, 'Yesterday',
                                  lastElement: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomBar(),
            ],
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusIconColor,
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xff343442),
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }
}
