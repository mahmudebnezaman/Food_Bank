// Define some sample restaurant names
import 'dart:math';

import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/modal/store.dart';

final List<String> restaurantNames = [
  "Spice & Rice",
  "Hungry Hearts",
  "Noodles & More",
  "Pizza Paradise",
  "Coffee Corner",
  "Sweet Treats",
  "Fresh Fish",
  "Curry Kingdom",
  "Healthy Bites",
  "Sizzling Wok",
  "Mom's Kitchen",
  "Crusty Baguette",
  "Flaming Grill",
  "Laughing Panda",
];

final List<String> bangladeshDistricts = [
  "Barguna",
  "Barisal",
  "Bhola",
  "Jhalokati",
  "Patuakhali",
  "Pirojpur",
  "Bandarban",
  "Brahmanbaria",
  "Chandpur",
  "Chittagong",
  "Comilla",
  "Cox's Bazar",
  "Feni",
  "Khagrachhari",
  "Lakshmipur",
  "Noakhali",
  "Rangamati",
  "Dhaka",
  "Faridpur",
  "Gazipur",
  "Gopalganj",
  "Kishoreganj",
  "Manikganj",
  "Munshiganj",
  "Narayanganj",
  "Narail",
  "Rajbari",
  "Shariatpur",
  "Tangail",
  "Dinajpur",
  "Gaibandha",
  "Kurigram",
  "Lalmonirhat",
  "Nilphamari",
  "Panchagarh",
  "Rangpur",
  "Sherpur",
  "Thakurgaon",
  "Bagerhat",
  "Chuadanga",
  "Jessore",
  "Jhenaidah",
  "Khulna",
  "Magura",
  "Narail",
  "Satkhira",
  "Bogra",
  "Chapainawabganj",
  "Joypurhat",
  "Naogaon",
  "Pabna",
  "Rajshahi",
  "Sirajganj",
  "Jamalpur",
  "Mymensingh",
  "Netrakona",
  "Sherpur",
  "Tangail",
  "Sylhet",
  "Sunamganj",
  "Habiganj",
  "Moulvibazar",
  "Manipur",
  "Gazipur",
  "Narsingdi",
  "Kushtia",
];

final List<String> restaurantImages = [
  foodImage1,
  foodImage2,
  foodImage3,
  foodImage4,
  foodImage5,
  foodImage6,
  foodImage7,
  foodImage8,
  foodImage9,
  foodImage10,
  foodImage11,
  foodImage12,
  foodImage13,
  foodImage14,
];

int getIndex() {
  final random = Random();
  return random.nextInt(restaurantNames.length);
}
// List to store all district data
Map<String, List> storeDetails = {};

// Loop through all 64 districts (replace with actual district names)
void storeNames(){
  for (var i in bangladeshDistricts) {
    final districtName = "$i District";
    final districtStores = [];
    final numberOfStores = Random().nextInt(6) * 2 + 4;
    for (var j = 0; j < numberOfStores; j++) {
      final index = getIndex();
      districtStores.add(
        Store(storeName: restaurantNames[index],
          address: i,
          storeBanner: restaurantImages[index],
        ),
      );
    }
    storeDetails[districtName] = districtStores;
  }
}
