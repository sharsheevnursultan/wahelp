import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic myController = TextEditingController(text: '');

  get adText => 'https://taplink.cc/nomaddev';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    myBanner.load();
    super.initState();
  }

  final BannerAd myBanner = BannerAd(
      size: (AdSize.mediumRectangle),
      adUnitId: 'ca-app-pub-2550588570628296/6873796817',
      listener: BannerAdListener(),
      request: AdRequest());


  dynamic myColor = 0xFF25D366;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quick Chat for WhatsApp',
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Color(myColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 20),
            // ),
            Container(
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(fontSize: 20),
                onSubmitted: (value) {
                  setState(() {
                    myController.text = value;
                  });
                },
                controller: myController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(myColor),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(width: 2, color: Color(myColor)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'In international format',
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(myColor),
                    minimumSize: const Size.fromHeight(50), // foreground
                  ),
                  onPressed: () {
                    launch(
                        '${'https://wa.me/' + myController.text}?text=$adText');
                    setState(() {});
                  },
                  child: const Text(
                    'CHAT',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
