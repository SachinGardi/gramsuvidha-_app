import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gramsuvidha/blocs/application_bloc.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:gramsuvidha/view/activityform.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

String address = '';

String location = "Search Location";

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // String location = "Search Location";
  String googleApikey = "AIzaSyBQ6AVl92dee-iIN0NQ8LfXiBrL7emvSnI";

  // late Stream locationSubscription;
  // late Stream<Place> stream;
  ///go to that place
  // Future<void> _goToPlace(Place place) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   if(!mounted) return;
  //   final applicationBloc =
  //   Provider.of<ApplicationBloc>(context, listen: false);
  //   controller
  //       .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       tilt: 35,
  //       target: LatLng(
  //           place.geometry.location.lat, place.geometry.location.lng),
  //       zoom: 18.8)));
  //     applicationBloc.myMarkers = [];
  //     applicationBloc.currentAddress = await placemarkFromCoordinates(
  //         place.geometry.location.lat, place.geometry.location.lng);
  //     applicationBloc.place = applicationBloc.currentAddress![0];
  //     applicationBloc.address =
  //     '${applicationBloc.place?.street}, '
  //         '${applicationBloc.place!.name} '
  //         ',${applicationBloc.place!.thoroughfare}, '
  //         '${applicationBloc.place!.subLocality}, '
  //         '${applicationBloc.place!.locality}, '
  //         '${applicationBloc.place!.administrativeArea},'
  //         '${applicationBloc.place!.postalCode}, '
  //         '${applicationBloc.place!.country}';
  //     if(applicationBloc.address.isNotEmpty){
  //       applicationBloc.myMarkers.add(
  //         Marker(
  //             markerId: MarkerId(place.toString()),
  //             position: LatLng(
  //                 place.geometry.location.lat, place.geometry.location.lng),
  //             infoWindow: InfoWindow(
  //               title: applicationBloc.address,
  //             )),
  //       );
  //     }
  //
  //
  //
  //
  // }

  @override
  void initState() {
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.resetValues();
    if (applicationBloc.address == '') {
      applicationBloc.setCurrentLocation();
    }
    /* var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
       stream = applicationBloc.selectedLocation.stream;*/
    // locationSubscription = applicationBloc.selectedLocation.stream.asBroadcastStream();

    /* if(locationSubscription.isBroadcast){
        locationSubscription.listen((place) {
          _goToPlace(place);
        });
      }*/
    /* stream.listen((place) {
        _goToPlace(place);
      });*/

    super.initState();
  }

/*  @override
  void dispose() {
     final applicationBloc = Provider.of<ApplicationBloc>(context,listen: false);
     applicationBloc.dispose();

    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            /*  applicationBloc.setCurrentLocation();
            applicationBloc.currentMapType = MapType.satellite;*/
            Get.off(() => ActivityForms());
          },
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: splashBackgroundColor.withOpacity(.8),
        title: const Text('Map'),
      ),
      body: Stack(
        children: [
          (applicationBloc.currentLocation == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  onTap: applicationBloc.handleTap,
                  markers: Set.from(applicationBloc.myMarkers),
                  buildingsEnabled: true,
                  trafficEnabled: true,
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  mapType: applicationBloc.currentMapType,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    tilt: 35,
                    target: (applicationBloc.newlatlang == null)
                        ? LatLng(applicationBloc.currentLocation!.latitude,
                            applicationBloc.currentLocation!.longitude)
                        : (applicationBloc.oldLatLong == null)
                            ? applicationBloc.newlatlang
                            : applicationBloc.oldLatLong,
                    zoom: 18.8,
                  ),
                  onMapCreated: (controller) {
                    applicationBloc.mapController = controller;
                  },
                  indoorViewEnabled: false,
                ),

          Positioned(
            top: context.mediaQueryWidth / 8,
            child: InkWell(
              onTap: () async {
                applicationBloc.getSearchPlaces(context);
                /* var place = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: googleApikey,
                    mode: Mode.overlay,
                    types: [],
                    strictbounds: false,
                    onError: (err) {
                      print(err);
                    });
                if (place != null) {
                  setState(() {
                    location = place.description!
                        .split(
                          ',',
                        )
                        .first
                        .toString();

                    // address = place.description.toString();
                  });

                  //form google_maps_webservice package
                  final plist = GoogleMapsPlaces(
                      apiKey: googleApikey,
                      apiHeaders: await const GoogleApiHeaders().getHeaders());
                  String placeid = place.placeId ?? "0";
                  print(placeid);
                  final detail = await plist.getDetailsByPlaceId(placeid);
                  final geometry = detail.result.geometry!;
                  final lat = geometry.location.lat;
                  final lang = geometry.location.lng;
                  var adressDetails = await placemarkFromCoordinates(lat, lang);
                  var pincode = adressDetails[0];

                  address =
                      '${place.description.toString()},${pincode.postalCode}';
                  newlatlang = LatLng(lat, lang);
                  print(newlatlang);
                  setState(() {
                    applicationBloc.myMarkers.clear();
                    applicationBloc.myMarkers.add(Marker(
                        markerId: MarkerId(
                          newlatlang.toString(),
                        ),
                        position: newlatlang));
                  });
                  _mapController?.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(

                          target: newlatlang, zoom: 18.8, tilt: 35)));
                }*/
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width - 40,
                    child: ListTile(
                      title: Center(
                          child: Text(location,
                              style: const TextStyle(fontSize: 18))),
                      trailing: const Icon(Icons.search),
                      dense: true,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///Place search field
          /*Padding(
            padding: EdgeInsets.only(
                top: context.mediaQueryWidth / 20,
                left: context.mediaQueryWidth / 8,
                right: context.mediaQueryWidth / 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black26)),
              height: context.mediaQueryWidth / 8,
              child: TextFormField(
                onChanged: (value) {
                  applicationBloc.searchPlaces(value);
                },
                controller: googleSearchController,
                decoration: InputDecoration(
                    hintText: 'Search Town/City',
                    hintStyle: const TextStyle(color: Colors.grey, height: 3),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: splashBackgroundColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none)),
              ),
            ),
          ),*/

          ///place Search result box
          /*  if (applicationBloc.searchResults.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: context.mediaQueryWidth / 5,
                  left: context.mediaQueryWidth / 8,
                  right: context.mediaQueryWidth / 8),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    backgroundBlendMode: BlendMode.darken),
                child: ListView.builder(
                  itemCount: applicationBloc.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        applicationBloc.searchResults[index].description,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        applicationBloc.setSelectedLocation(
                            applicationBloc.searchResults[index].placeId);
                      },
                    );
                  },
                ),
              ),
            ),*/

          ///change map type button
          Padding(
            padding: EdgeInsets.only(
                top: context.mediaQueryWidth / 40,
                left: context.mediaQueryWidth / 40),
            child: GestureDetector(
              onTap: applicationBloc.changeMapType,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(.1),
                          spreadRadius: 2)
                    ]),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.map,
                    size: 20,
                    color: splashBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: context.mediaQueryWidth / 0.64,
          //   ),
          //   child: Container(
          //       height: context.mediaQueryWidth / 5.5,
          //       width: double.infinity,
          //       decoration: const BoxDecoration(color: Colors.black87),
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 15),
          //         child: Row(
          //           children: [
          //             Expanded(
          //               flex: 4,
          //               child: applicationBloc.address == null
          //                   ? const Text('')
          //                   : Text(
          //                       applicationBloc.address,
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                       ),
          //                     ),
          //             ),
          //             Expanded(
          //                 flex: 1,
          //                 child: TextButton(
          //                     onPressed: () {
          //                       Get.back();
          //                     }, child: const Text('OK')))
          //           ],
          //         ),
          //       )),
          // )
          ///address box
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: EdgeInsets.only(bottom: context.mediaQueryWidth / 4),
                  child: Container(
                      color: Colors.black87,
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: (applicationBloc.oldLatLong == null ||
                                          (applicationBloc.oldLatLong !=
                                              applicationBloc.newlatlang))
                                      ? Text(
                                          applicationBloc.address,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      : Text(
                                          applicationBloc.newAddressValue,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () async {
                                      applicationBloc.setValueOnButtonTap();
                                      Get.back();
                                      // Get.off(()=>ActivityForms());
                                      applicationBloc.newAddressValue =
                                          applicationBloc.address;
                                    },
                                    child: const Text("OK",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18))),
                              ),
                            ],
                          ))))),
        ],
      ),
    );
  }
}
