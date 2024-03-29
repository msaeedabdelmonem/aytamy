import 'package:aytamy/generated/l10n.dart';
import 'package:aytamy/screens/home/add_pay_dialog_view.dart';
import 'package:aytamy/screens/home/provider/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../../app/route.dart';
import '../../common/stats_widgets.dart';
import 'being_bailed_list_view.dart';
import 'most_recent_list_view.dart';
import 'search_list_view.dart';

class HomeScreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenViewState();
  }
}

class HomeScreenViewState extends State with SingleTickerProviderStateMixin {
  TabController _tabController;
  HomeModel _homeModel;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _homeModel = Provider.of<HomeModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        getMainView(),
      ],
    );
  }

  Widget getSearchView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/icons/add.png",
          height: 30,
          color: Colors.red,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .8,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(6.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff4f4f4f), width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xff4f4f4f), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              hintText: S.current.orphanSearch,
              hintStyle: TextStyle(
                color: Color(0xff4f4f4f),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff4f4f4f),
              ),
            ),
            onChanged: (value) {
              showLoading(context);
              Provider.of<HomeModel>(context, listen: false).getSearchResult(
                  value.toString().toLowerCase(), onSucess: () {
                dismissLoading();
              }, onError: (error) {
                dismissLoading();
              });
              if (value.isEmpty) {
                _homeModel.clearSearch();
              }
            },
          ),
        ),
      ],
    );
  }

  getMainView() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            getSearchView(),
            Container(
              child: TabBar(
                unselectedLabelColor: Color(0xff9e9e9e),
                labelColor: Colors.red,
                indicatorColor: Colors.red,
                unselectedLabelStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'helvetica'),
                tabs: [
                  Tab(
                      child: Row(
                    children: [
                      new Container(
                        width: 32,
                        height: 21.333328247070312,
                        child: new Icon(Icons.people),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(S.current.mostRecent,
                          style: TextStyle(
                            fontFamily: 'GESSTwo',
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  )),
                  Tab(
                    child: Row(
                      children: [
                        new Container(
                          width: 32,
                          height: 21.333328247070312,
                          child: new Image.asset(
                            "assets/icons/right.png",
                            height: 30,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(S.current.beingBailed,
                            style: TextStyle(
                              fontFamily: 'GESSTwo',
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ],
                onTap: (index) {
                  _homeModel.clearSearch();
                },
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              decoration: BoxDecoration(
                  //This is for background color
                  color: Colors.white.withOpacity(0.0),
                  //This is for bottom border that is needed
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.8))),
            ),
            Consumer<HomeModel>(builder: (context, homeModel, child) {
              return Container(
                  height: 250,
                  child: _homeModel.SearchUsers.isNotEmpty
                      ? SearchListView()
                      : TabBarView(
                          children: [
                            MostRecentListView(),
                            BeingBailedListView()
                          ],
                          controller: _tabController,
                        ));
            }),
            SizedBox(
              height: 28,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 48,
              decoration: new BoxDecoration(
                  color: Color(0xffdb0011),
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                child: Center(
                  child: new Text("اكفل",
                      style: TextStyle(
                        fontFamily: 'GESSTwo',
                        color: Color(0xffffffff),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
                onTap: () {
                  addPayDialogView(context: context);
                },
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.CLOTHES_SCREEN);
                  },
                  child: Column(
                    children: [
                      new Container(
                        width: 69.240234375,
                        height: 69.24017333984375,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage("assets/images/T-Shirt copy.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                          border: new Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      new Text("بنك الملابس",
                          style: TextStyle(
                            fontFamily: 'GESSTwo',
                            color: Color(0xffdb0011),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.15000000190734863,
                          ))
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.FOOD_SCREEN);
                  },
                  child: Column(
                    children: [
                      new Container(
                        width: 69.240234375,
                        height: 69.24017333984375,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage(
                                "assets/images/medical-stethoscope-white-surface.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                          border: new Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      new Text("بنك العلاج",
                          style: TextStyle(
                            fontFamily: 'GESSTwo',
                            color: Color(0xffdb0011),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.15000000190734863,
                          ))
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.TREATEMENT_SCREEN);
                  },
                  child: Column(
                    children: [
                      new Container(
                        width: 69.240234375,
                        height: 69.24017333984375,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage(
                                "assets/images/fresh-tomatoes-bowl copy.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                          border: new Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      new Text("بنك الطعام",
                          style: TextStyle(
                            fontFamily: 'GESSTwo',
                            color: Color(0xffdb0011),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.15000000190734863,
                          ))
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.all(8),
              decoration: new BoxDecoration(
                  color: Color(0xfff5f6f7),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text("فريق ايتام",
                      style: TextStyle(
                        fontFamily: 'GESSTwo',
                        color: Color(0xffdb0916),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.16071428775787353,
                      )),
                  new Text(
                      "منصة ايتام تربط الايتام مع الكفيل ليضمن كفالة بدون وسيط ايضا يمكنك متابعتنا على منصات التواصل الاجتماعي (فيسبوك ، تويتر ، انستجرام ، واتساب) لمتابعتنا.",
                      style: TextStyle(
                        fontFamily: 'GESSTwo',
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
