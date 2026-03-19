/*import 'package:flutter/material.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  int selectedIndex = 0;

  List<Map<String, String>> addresses = [
    {
      "name": "Ahmad Salem",
      "address": "14 El-Shaheed Street\nDowntown Cairo, Egypt"
    },
    {
      "name": "Ahmad Salem",
      "address": "28 Nile Corniche\nZamalek, Cairo, Egypt"
    },
    {
      "name": "Ahmad Salem",
      "address": "42 Salah Salem Road\nNasr City, Cairo, Egypt"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
       appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: const Icon(Icons.arrow_back, color: Colors.black),
      title: const Text(
        "Delivery Address",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Padding(
          padding: EdgeInsets.only(left: 72, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select or add a new address",
              style: TextStyle(
                color: Color(0xff8D6E63),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    ),
      body: Column(
        children: [


          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xffF3E8D5)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xffC9A46A)
                            : Colors.grey.shade300,
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: const Color(0xffC9A46A),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addresses[index]["name"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              addresses[index]["address"]!,
                              style: const TextStyle(
                                  color: Colors.grey, height: 1.4),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// Add New Address Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xffF3E8D5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xffC9A46A)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xffC9A46A),
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Add New Address",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Continue Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff6D4C41),
                    Color(0xff8D6E63),
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  "Continue to Payment",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_address_screens/add_newaddress.dart';
import 'add_address_screens/manager/add_address_apiservces.dart';
import 'add_address_screens/manager/add_address_cubit.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Color primaryBrown = const Color(0xff7B4F3E);
    Color lightBrown = const Color(0xffF6EFEA);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,),
        title: const Text(
          "Delivery Address",
          style: TextStyle(
            color: Color(0xff3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(left: 72, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select or add a new address",
                style: TextStyle(
                  color: Color(0xff8D6E63),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [



            Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xffCFAC59),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 8),

                const Text(
                  "Choose Address",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff3E2723)
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// Address 1
            addressCard(
              index: 0,
              name: "Ahmad Salem",
              address: "14 El-Shaheed Street\nDowntown Cairo, Egypt",
              isDefault: true,
              primaryBrown:  const Color(0xffc9a875),
              lightBrown: lightBrown,
            ),

            const SizedBox(height: 14),

            /// Address 2
            addressCard(
              index: 1,
              name: "Ahmad Salem",
              address: "28 Nile Corniche\nZamalek, Cairo, Egypt",
              primaryBrown:  const Color(0xffc9a875),
              lightBrown: lightBrown,
            ),

            const SizedBox(height: 18),

            /// Add address
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color:  const Color(0xffc9a875),
                    style: BorderStyle.solid
                ),
                color: lightBrown,
              ),

              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewAddressScreen(),
                       ),
                      //),
                    );
                  },
                  child: const Text(
                    "+  Add New Address",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6d4c41)
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Note
            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: lightBrown,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                children: const [

                  Icon(Icons.lightbulb_outline,
                      size: 18,
                      color: Colors.brown),

                  SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      "Make sure your address is correct to ensure smooth delivery",
                      style: TextStyle(fontSize: 13,color: Color(0xff6d4c41)),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Continue button
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff6B4A3A),
                    Color(0xff8B5E4A),
                    Color(0xffA47154),
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  "Continue to Review",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  Widget addressCard({
    required int index,
    required String name,
    required String address,
    bool isDefault = false,
    required Color primaryBrown,
    required Color lightBrown,
  }) {

    bool isSelected = selectedIndex == index;

    return GestureDetector(

      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },

      child: Container(

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: isSelected ? lightBrown : Colors.white,
          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: isSelected
                ?  const Color(0xffc9a875)
                : Colors.grey.shade300,
            width: 1.2,
          ),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Color(0xffc9a875)
                      : Colors.grey.shade400,
                ),
                color: isSelected
                    ?  const Color(0xffc9a875)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
                  : null,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,color: Color(0xff3E2723)
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    address,
                    style: const TextStyle(
                        color: Color(0XFF8D6A63),
                        fontSize: 13
                    ),
                  ),

                  if(isDefault)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4
                      ),

                      decoration: BoxDecoration(
                        color:  const Color(0xffc9a875),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: const Text(
                        "Default",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11
                        ),
                      ),
                    )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}