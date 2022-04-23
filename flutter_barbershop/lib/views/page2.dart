// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? myIcon;
  Set<Marker> _markers = Set();

  @override
  void initState() {
    _determinePosition();
    getimage();
    // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  }

  getimage() async {
    // String imgurl =
    //     "https://library.kissclipart.com/20180918/agw/kissclipart-circle-clipart-logo-brand-38e95245c161fecd.png";

    // Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
    //     .buffer
    //     .asUint8List();
    // BitmapDescriptor? icon = BitmapDescriptor.fromBytes(bytes);
    BitmapDescriptor? icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2), 'assets/images/LOGO.png');
    setState(() {
      myIcon = icon;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng latLng) {
            _markers.add(Marker(
              markerId: MarkerId('mark'),
              position: latLng,
              infoWindow: InfoWindow(
                //popup info
                title: 'Marker Title Second ',
                snippet: 'My Custom Subtitle',
              ),
              // icon: myIcon!,
            ));
            setState(() {});
          },
          markers: Set<Marker>.of(_markers),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onPressed: _goToTheLake,
        child: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    _markers.add(Marker(
      markerId: MarkerId('Locatine'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(
        //popup info
        title: 'MyLo',
        // snippet: 'My Custom Subtitle',
      ),
      icon: myIcon!,
    ));

    setState(() {});

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          // bearing: 192.8334901395799,
          target: LatLng(position.latitude, position.longitude),
          // tilt: 59.440717697143555,
          zoom: 15,
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
