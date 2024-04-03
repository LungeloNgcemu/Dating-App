import 'package:flutter/material.dart';
import 'components/topbar.dart';
import 'components/avatar.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int currentPage = 0;
  late TabController tabController;
  final List<Widget> pages = [
    PageHome(),
    Locations(),
    Page3(),
    Page4(),
    Page5()
  ];

  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    final Color unselectedColor = colors[currentPage].computeLuminance() < 0.5
        ? Colors.black
        : Colors.white;
    final Color unselectedColorReverse =
        colors[currentPage].computeLuminance() < 0.5
            ? Colors.white
            : Colors.black;

    return Scaffold(
      body: BottomBar(
        clip: Clip.none,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            TabBar(
              indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              controller: tabController,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: currentPage <= 4
                        ? colors[currentPage]
                        : unselectedColor,
                    width: 4,
                  ),
                  insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
              tabs: [
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.home,
                    color: currentPage == 1 ? colors[0] : unselectedColor,
                  )),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Icon(
                      Icons.location_on_rounded,
                      color: currentPage == 2 ? colors[1] : unselectedColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: currentPage == 3 ? colors[3] : unselectedColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Icon(
                      Icons.message_outlined,
                      color: currentPage == 4 ? colors[2] : unselectedColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 40,
                  child: Center(
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: currentPage == 5 ? colors[4] : unselectedColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        fit: StackFit.expand,
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: unselectedColor,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(500),
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
        showIcon: true,
        width: MediaQuery.of(context).size.width * 0.8,
        barColor: colors[currentPage].computeLuminance() > 0.5
            ? Colors.black
            : Colors.white,
        start: 2,
        end: 0,
        offset: 10,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 30,
        iconWidth: 30,
        reverse: false,
        hideOnScroll: true,
        scrollOpposite: false,
        onBottomBarHidden: () {},
        onBottomBarShown: () {},
        body: (context, controller) => TabBarView(
          controller: tabController,
          // dragStartBehavior: DragStartBehavior.,
          physics: const BouncingScrollPhysics(),
          children: pages,
        ),
      ),
    );
  }
}

class PageHome extends StatelessWidget {
  const PageHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const TopBar(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              AvatarProfile(),
              AvatarProfile(),
              AvatarProfile(),
              AvatarProfile(),
              AvatarProfile(),
              AvatarProfile(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: h * 0.7,
            width: h * 0.54,
            decoration: BoxDecoration(
              color: Colors.deepPurple[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.018),
                  child: Container(
                    height: h * 0.52,
                    width: h * 0.41,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: LoveBox(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: h * .03, horizontal: h * 0.048),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TripleButton(
                        h: h,
                        icon: Icons.clear,
                        color: Colors.white,
                      ),
                      TripleButton(
                        h: h,
                        icon: Icons.favorite,
                        color: Colors.blueAccent,
                      ),
                      // TripleButton(
                      //   h: h,
                      //   icon: Icons.star,
                      //   color: Colors.yellow,
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoveBox extends StatefulWidget {
  const LoveBox({super.key});

  @override
  State<LoveBox> createState() => _LoveBoxState();
}

class _LoveBoxState extends State<LoveBox> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: h * 0.3,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Simantha Smith',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          Text("Durban KwaZulu Natal"),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              textAlign: TextAlign.center,
              'Im very Shy but i really love good company, and have an interest in traveling the world',
              //softWrap: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'Interest',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  //softWrap: true,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Text(
              'Im very Shy but i really love good company, and have an interest in traveling the world',
              //softWrap: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  "Simantha's Info",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  //softWrap: true,
                ),
              ],
            ),
          ),
          Info(
            a: 'Age',
            b: '22 Years',
          ),
          Info(
            a: 'Height',
            b: '172 cm',
          ),
          Info(
            a: 'Speaks',
            b: 'English',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
              child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // Number of columns
                    mainAxisSpacing: 8.0,
                    // Space between items along the main axis
                    crossAxisSpacing: 8.0,
                    // Space between items along the cross axis
                    childAspectRatio:
                        1.0, // Ratio between the width and height of each child
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  Info({
    this.a,
    this.b,
    super.key,
  });

  String? a;
  String? b;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(a ?? ''),
          Text(b ?? ''),
        ],
      ),
    );
  }
}

class TripleButton extends StatelessWidget {
  TripleButton({
    super.key,
    required this.h,
    this.icon,
    this.color,
  });

  final double h;
  IconData? icon;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: h * 0.095,
        color: color,
        shape: CircleBorder(),
        child: Icon(
          weight: 10.0,
          icon,
          size: 30.0,
        ),
        onPressed: () {});
  }
}

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(-29.8587, 31.0218),
        initialZoom: 12,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
