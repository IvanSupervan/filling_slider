import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:filling_slider/filling_slider.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filling Slider Demo',
      home: MyHomePage(title: 'Filling Slider Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Artboard? _riveArtboard;

  @override
  void initState() {
    rootBundle.load('assets/volume.riv').then(
      (data) {
        final file = RiveFile.import(data);
        setState(() => _riveArtboard = file.mainArtboard);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Vertical slider with Rive\'s animation'),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            FillingSlider(
                initialValue: 0.9,
                onChange: onChangeWithRive,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: _riveArtboard == null
                      ? Container()
                      : Rive(artboard: _riveArtboard!, fit: BoxFit.cover),
                )),
            Padding(padding: EdgeInsets.only(bottom: 40)),
            Text('Horizontal slider with icons and AnimationSwitcher'),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            FillingSlider(
                initialValue: 0.9,
                width: 150,
                height: 40,
                direction: FillingSliderDirection.horizontal,
                childBuilder: (ctx, value) => AnimatedSwitcher(
                      layoutBuilder: (Widget? currentChild,
                          List<Widget> previousChildren) {
                        return currentChild!;
                      },
                      duration: Duration(seconds: 1),
                      child: getIcon(value),
                    )),
          ],
        ),
      ),
    );
  }

  void onChangeWithRive(double newVal, double old) {
    List triggers = [1.0, 0.7, 0.3, 0.0];
    var start = 3;
    var end = 1;
    for (var i = 0; i < triggers.length - 1; i++) {
      if (newVal == 0) {
        end = 0;
      } else if (newVal <= triggers[i] && newVal >= triggers[i + 1]) {
        end = 3 - i;
      }
      if (old == 0) {
        start = 0;
      } else if (old <= triggers[i] && old >= triggers[i + 1]) {
        start = 3 - i;
      }
    }
    _riveArtboard!.addController(SimpleAnimation('$start-$end'));
  }

  Widget getIcon(double newVal) {
    return newVal > 0.5
        ? Icon(Icons.brightness_2_outlined, size: 20, key: ValueKey(1))
        : Icon(Icons.brightness_1_outlined, size: 20, key: ValueKey(2));
  }
}
