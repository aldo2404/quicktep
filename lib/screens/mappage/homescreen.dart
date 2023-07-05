import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:quicktep/screens/attendancelog.dart';
//import 'package:google_maps_webservice/geolocation.dart';
//import 'package:lottie/lottie.dart' as lottie;
//import 'package:quicktep/layoutproperty/constant.dart';
import 'package:quicktep/screens/mappage/mapservice.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pickupAreaController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final destinationAreaController = TextEditingController();
  Completer<GoogleMapController> googleController = Completer();

  String entryTime = '';
  String exitTime = '';
  static const LatLng sourceLocation = LatLng(12.99703, 80.20952);
  static const LatLng destination =
      LatLng(12.99136543671901, 80.20549468090519);

  LatLng currentPostion = sourceLocation;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  String _draggedAddress = "";
  late LatLng draggedLatlng;

  CameraPosition? _cameraPosition;

  List<String> entryDateTime = [];
  List<String> exitDateTime = [];
  String currentDate = '';

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylineSets = <Polyline>{};
  final Set<Polygon> _polygonSets = <Polygon>{};

  List<LatLng> polygonLatLng = <LatLng>[
    const LatLng(12.99697058276742, 80.20958519380235),
    const LatLng(12.997077082707348, 80.20959458153388),
    const LatLng(12.997098644039328, 80.20942426126204),
    const LatLng(12.996982343499225, 80.2094014624855),
    const LatLng(12.99697058276742, 80.20958519380235),
  ];

  int _polygonIdCounter = 1;
  bool userCheckInSelecter = false;
  bool? firstEntry;
  bool isInSelectedArea = false;

  String currentDateTime =
      DateFormat('MM-dd-yyyy hh:mm a').format(DateTime.now()).toString();

  StreamSubscription<Position>? streamSubscriptionForCurrentLocation;

  List<String> image = [
    'assets/images/motorbike_icon.png',
    'assets/images/auto_icon.png',
    'assets/images/auto_icon.png',
    'assets/images/auto_icon.png',
    'assets/images/motorbike_icon.png',
    'assets/images/motorbike_icon.png'
  ];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latLang = <LatLng>[
    const LatLng(12.99230, 80.20149),
    const LatLng(12.99530, 80.28129),
    const LatLng(12.99230, 80.20149),
    const LatLng(12.39230, 80.20149),
    const LatLng(12.92250, 80.10149),
    const LatLng(12.49230, 80.20149),
  ];

  @override
  void initState() {
    createMarker();
    _dateTimeController.text = '';
    _init();
    super.initState();
  }

  _init() {
    draggedLatlng = sourceLocation;
    _cameraPosition = const CameraPosition(target: sourceLocation, zoom: 20);
    getUserLocation();
    loadData();
  }

  void createMarker() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/google_Pin1.png')
        .then((icon) {
      customIcon = icon;
      setState(() {});
    });
  }

  // Widget _getCustomPin() {
  //   return Center(
  //     child: Container(
  //       width: 150,
  //       child: lottie.Lottie.asset("assets/images/pin.json"),
  //     ),
  //   );
  // }

  loadData() {
    for (int i = 0; i < image.length; i++) {
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latLang[i],
          infoWindow: InfoWindow(title: 'infomodel:$i')));
      setState(() {});
    }
  }

  void getPolyPoints() async {
    final String polygonIdVal = 'polygon_ $_polygonIdCounter';
    _polygonIdCounter++;

    _polygonSets.add(
      Polygon(
          polygonId: PolygonId(polygonIdVal),
          points: polygonLatLng,
          strokeWidth: 1,
          strokeColor: Colors.blue,
          geodesic: true,
          fillColor: Colors.blue.shade200.withOpacity(0.2)),
    );
  }

  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      _draggedAddress = addresStr;
      pickupAreaController.text = _draggedAddress;
    });
  }

  Future getUserLocation() async {
    GoogleMapController mapController = await googleController.future;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPostion = LatLng(position.latitude, position.longitude);

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPostion, zoom: 20)));

    startLocationMonitoring();
  }

  void startMonitoring() {
    // Create a polygon area.
    //var polygonArea = polygonLatLng;
    Geolocator.getPositionStream();

    // Start monitoring the polygon area.
    // Geolocator.getServiceStatusStream(polygonArea, onEnter: () {
    //   // Do something when the user enters the polygon area.
    // }, onExit: () {
    //   // Do something when the user exits the polygon area.
    // });
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.deepPurple.shade100,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
                child: Container(
                  //padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: GoogleMap(
                    onTap: (point) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        // polygonLatLng.add(point);
                        // getPolyPoints();
                      });
                    },
                    onLongPress: (point) {
                      setState(() {
                        polygonLatLng.remove(point);
                        getPolyPoints();
                      });
                    },
                    onCameraMove: (cameraPosition) {
                      draggedLatlng = cameraPosition.target;
                    },
                    onCameraIdle: () {
                      _getAddress(draggedLatlng);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      //googleController = controller;
                      if (!googleController.isCompleted) {
                        googleController.complete(controller);
                      }
                    },
                    myLocationEnabled: false,
                    compassEnabled: true,
                    trafficEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _cameraPosition!,
                    polygons: {
                      Polygon(
                          polygonId: const PolygonId('poly'),
                          points: polygonLatLng,
                          strokeColor: Colors.blue,
                          strokeWidth: 1,
                          fillColor: Colors.blue.withOpacity(0.1))
                    },
                    //_polygonSets,

                    // circles: {
                    //   Circle(
                    //       circleId: const CircleId('1'),
                    //       center: sourceLocation,
                    //       radius: 8,
                    //       strokeColor: Colors.blue,
                    //       strokeWidth: 1,
                    //       fillColor: Colors.blue.shade100.withOpacity(0.2)),
                    // },
                    // polylines: {
                    //   Polyline(
                    //     polylineId: const PolylineId('polyline'),
                    //     color: primaryColor,
                    //     width: 6,
                    //     points: polylineCoordinates,
                    //   )
                    // },
                    markers: {
                      Marker(
                        markerId: const MarkerId("source"),
                        position: currentPostion,
                        draggable: true,
                        onDragEnd: (value) {
                          //checkUpdatedLocation(value);
                        },
                        icon: customIcon,
                      ),
                      const Marker(
                          markerId: MarkerId("destination"),
                          position: destination),
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber.shade200,
                        radius: 25,
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.person)),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 95,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text(
                              'thinQ24 Pvt.Ltd',
                              style: TextStyle(fontSize: 22),
                            ),
                            subtitle: TextField(
                              controller: _dateTimeController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 180,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: userCheckInSelecter
                        ? const Text(
                            "Check In",
                            style:
                                TextStyle(fontSize: 22, color: Colors.purple),
                          )
                        : const Text(
                            "Check Out",
                            style:
                                TextStyle(fontSize: 22, color: Colors.purple),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AttendanceLogScreen()));
                  },
                  child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                        child: Text(
                      'Attendance Log',
                      style: TextStyle(fontSize: 22, color: Colors.purple),
                    )),
                  ),
                ),
              )
            ],
          ),

          //_getCustomPin(),
          Align(
            alignment: const Alignment(0.1, -0.9),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade200,
                      radius: 25,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.menu)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        borderRadius: BorderRadius.circular(25)),
                    width: 260,
                    child: TextField(
                      onTap: () {
                        pickupAreaController.clear();
                      },
                      controller: pickupAreaController,
                      decoration: InputDecoration(
                        suffixIcon: SizedBox(
                          width: 40,
                          child: IconButton(
                              onPressed: () async {
                                var place = await LocationService()
                                    .getPlace(pickupAreaController.text);
                                _goToPlace(place);
                              },
                              icon: const Icon(Icons.search_outlined)),
                        ),
                        fillColor: Colors.amber.shade300,
                        contentPadding:
                            const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                        hintText: 'Enter your location',
                        border: const OutlineInputBorder(
                            //borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
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

  Future startLocationMonitoring() async {
    final preferences = await SharedPreferences.getInstance();
    bool islocationEnabled = await Geolocator.isLocationServiceEnabled();
    List<map_tool.LatLng> convatedPolygonPoints = polygonLatLng
        .map((point) => map_tool.LatLng(point.latitude, point.longitude))
        .toList();

    if (islocationEnabled) {
      streamSubscriptionForCurrentLocation =
          Geolocator.getPositionStream().listen((Position position) async {
        double lat = position.latitude;
        double lng = position.longitude;

        map_tool.LatLng userLocation =
            map_tool.LatLng(position.latitude, position.longitude);

        bool isInsidePolygon = map_tool.PolygonUtil.containsLocation(
            userLocation, convatedPolygonPoints, false);

        setState(() {
          currentPostion = LatLng(lat, lng);
          currentDate = DateFormat('yMMMMd').format(DateTime.now()).toString();
        });

        if (isInsidePolygon) {
          print('user check-in $currentPostion');
          setState(() {
            userCheckInSelecter = true;
            entryTime = currentDateTime;
            _dateTimeController.text = 'Entered: $entryTime';
            entryDateTime.add(entryTime);
          });
        } else {
          print('user check-out $currentPostion');
          setState(() {
            userCheckInSelecter = false;
            exitTime = currentDateTime;
            _dateTimeController.text = 'Exit: $exitTime';
            exitDateTime.add(exitTime);
          });
        }

        await preferences.setString('currentDate', currentDate);
        await preferences.setStringList('entryTime', entryDateTime);
        await preferences.setStringList('exitTime', exitDateTime);
      });
      return true;
    }
  }

  Future<void> _goToPlace(
    Map<String, dynamic> place,
  ) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await googleController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }
}
