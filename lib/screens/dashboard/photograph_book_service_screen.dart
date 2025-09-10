import 'dart:io';

import 'package:aahwanam/routes/app_routes.dart';
import 'package:aahwanam/widgets/custom_book_service.dart';

import 'package:aahwanam/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../blocs/Photographer/photographer_bloc.dart';
import '../../blocs/Photographer/photographer_event.dart';
import '../../blocs/Photographer/photographer_state.dart';
import '../../services/proceedpay.dart';
import '../../widgets/custom_date_time_bottom_sheet.dart';

import 'package:share_plus/share_plus.dart';

class PhotographBookServiceScreen extends StatelessWidget {
  final String? imagePath;
  final String? price;
  final int? count;

  const PhotographBookServiceScreen({
    super.key,
    this.imagePath,
    this.price,
    this.count,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotographerBloc()..add(FetchPhotographers()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                size: 24, color: Color(0xFF1E535B)),
            onPressed: () => Navigator.pop(context),
            padding: const EdgeInsets.only(left: 4),
            splashRadius: 20,
            constraints: const BoxConstraints(),
          ),
          title: Text(
            "Book Service",
            style: TextFontStyle.textFontStyle(
              16,
              const Color(0xFF575959),
              FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Color.fromRGBO(30, 83, 91, 1),
              ),
              onPressed: ()  {




              },),
            // IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentOptionsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E535B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  "Proceed to pay",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<PhotographerBloc, PhotographerState>(
          builder: (context, state) {
            if (state is PhotographerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotographerLoaded) {
              return SingleChildScrollView(
                child: CustomBookService(
                  data: state.bookServiceDetails,
                  onChangeAddress: () => _showChangeAddress(context),
                ),
              );
            } else if (state is PhotographerError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Select a photographer"));
          },
        ),
      ),
    );
  }

}


void _showChangeAddress(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // important for full control
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5, // 👈 fixed height (60% of screen)
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(  // 👈 scrolling inside content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Address',
                style: TextFontStyle.textFontStyle(
                  18,
                  Colors.white,
                  FontWeight.w600,
                ),



              ),

          Text(
            'Change Address',
            style: TextFontStyle.textFontStyle(
              16,
              Color(0xFF575959),
              FontWeight.w600,
            )),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showAddNewAddress(context);
                  },
                  icon: Icon(Icons.add, color: Color(0xFF1E535B)),
                  label: Text(
                    'Add New Address',
                    style: TextFontStyle.textFontStyle(
                      12,
                      Color(0xFF1E535B),
                      FontWeight.w400,
                    ),


                  ),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    side: BorderSide(color: Color(0xFF1E535B)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Your saved address',
                style: TextFontStyle.textFontStyle(
                  15,
                  Color(0xFF575959),
                  FontWeight.w500,
                ),

              ),
              SizedBox(height: 16),

              /// Address Tiles
              _addressTile(
                title: 'Financial District',
                subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              SizedBox(height: 12),
              _addressTile(
                title: 'Madhapur',
                subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              SizedBox(height: 12),
              _addressTile(
                title: 'Hitech City',
                subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              ),
              // SizedBox(height: 12),
              // _addressTile(
              //   title: 'Gachibowli',
              //   subtitle: 'Lorem ipsum dolor sit amet, dolor consectetur adipiscing elit,',
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

Widget _addressTile({required String title, required String subtitle}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFF7F1), // light background
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextFontStyle.textFontStyle(
                  14,
                  Color(0xFF575959),
                  FontWeight.w500,
                ),

              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextFontStyle.textFontStyle(
                  13,
                  Color(0xFF757575),
                  FontWeight.w400,
                ),

              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: Size(45, 30),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            side: BorderSide(color: Color(0xFF1E535B)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            'Edit',
            style: TextFontStyle.textFontStyle(
              13,
              Color(0xFF1E535B),
              FontWeight.w500,
            ),
          )
        ),
      ],
    ),
  );
}


void _showAddNewAddress(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(

        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Address',
                  style: TextFontStyle.textFontStyle(
                    18,
                    Color(0xFF575959),
                    FontWeight.w500,
                  ),


                ),
                SizedBox(height: 16),
                _buildTextField(
                  hintText: 'Enter your Flat / House no / Building name ',
                  label: 'Flat / House no / Building name *',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Floor (Optional)',
                  label: 'Floor',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Enter your area / sector / locality',
                  label: 'Area / Sector / Locality *',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Enter landmark',
                  label: 'Landmark',
                ),
                SizedBox(height: 24),
                Text(
                  'Enter your details for seamless experience',
                  style: TextFontStyle.textFontStyle(
                    16,
                    Color(0xFF757575),
                    FontWeight.w400,
                  ),

                ),
                SizedBox(height: 16),
                _buildTextField(
                  hintText: 'Enter your name',
                  label: 'Name *',
                ),
                SizedBox(height: 12),
                _buildTextField(
                  hintText: 'Enter your mobile number',
                  label: 'Phone Number',
                  keyboardType: TextInputType.number,
                  isNumberField: true, // 👈 NEW for phone field
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close Add New Address
                      Future.delayed(Duration(milliseconds: 20), () {
                        Navigator.pop(context); // Close Change Address
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E535B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14), // 👈 Padding
                      minimumSize: Size(0, 0), // 👈 Not forcing full width
                    ),
                    child: Text(
                      'Save Address',
                      style: TextFontStyle.textFontStyle(
                        16,
                         Colors.white,
                        FontWeight.w400,
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Common textfield builder
/// Common textfield builder
Widget _buildTextField({
  required String hintText,
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool isNumberField = false,
  double width = 360,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextFontStyle.textFontStyle(
          13, // 👈 slightly smaller label font
          const Color(0xFF575959),
          FontWeight.w400,
        ),
      ),
      const SizedBox(height: 4), // 👈 less gap under label
      SizedBox(
        width: width,
        child: TextField(
          keyboardType: keyboardType,
          inputFormatters: isNumberField
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          style: TextFontStyle.textFontStyle(
            13, // 👈 smaller input font
            const Color(0xFF575959),
            FontWeight.w400,
          ),
          decoration: InputDecoration(
            isDense: true, // 👈 makes field more compact
            hintText: hintText,
            hintStyle: TextFontStyle.textFontStyle(
              14, // 👈 smaller hint font
              const Color(0xFF9E9E9E),
              FontWeight.w400,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // 👈 reduced padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSearchBar() {
  return SizedBox(
    height: 40,
    width: 200,
    child: TextField(
      style: TextFontStyle.textFontStyle(
        14,
        const Color(0xFF575959),
        FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Search here...',
        // Padding applied only to the left of the icon
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10), // 5 px from left edge
          child: const Icon(Icons.search, size: 20, color: Color(0xFF575959)),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 20,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0), // text padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
Future<void> shareAssetImage(String assetPath) async {
  try {
    // Load asset as byte data
    final byteData = await rootBundle.load(assetPath);

    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/shared_image.png');

    // Write asset data into the file
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Share the file
    await Share.shareXFiles([XFile(file.path)], text: 'Check this out!');
  } catch (e) {
    print('Error while sharing: $e');
  }
}

Widget _buildChargeRow(String label, String value, {bool isBold = false, Color? valueColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,

      style: TextFontStyle.textFontStyle(
        14,
        const Color(0xFF575959),
        FontWeight.w400,
      ),

      ),
      Text(
        value,
        style: TextFontStyle.textFontStyle(
          14,
          const Color(0xFF757575),
          FontWeight.w400,
        ),


      ),
    ],
  );
}
