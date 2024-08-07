import 'package:currency_converter_app_flutter/utils/general_utils.dart';
import 'package:currency_converter_app_flutter/view_model/converstion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final digits = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    digits.dispose();
  }

  GeneralUtils getcontroller = Get.put(GeneralUtils());
  String currentresult = '';
  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE7E7EE),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.09),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Currency Converter',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: const Color(0xff1F2261)),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Text(
                    'Check live rates, set rate alerts, receive',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: const Color(0xff808080)),
                  ),
                  SizedBox(
                    height: Get.height * 0.001,
                  ),
                  Text(
                    'notifications and more',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: const Color(0xff808080)),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    height: Get.height * 0.37,
                    width: Get.width * 0.885,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  top: Get.height * 0.02,
                                  bottom: Get.height * 0.02),
                              child: Text(
                                'Amount',
                                style: GoogleFonts.roboto(
                                    color: const Color(0xff989898),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.05),
                          child: Row(
                            children: [
                              Obx(() {
                                return Image(
                                    height: 45,
                                    width: 45,
                                    image: AssetImage(
                                        'images/${getcontroller.selectedcurrency.toString()}.png'));
                              }),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                              Obx(() {
                                return DropdownButton(
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: const Color(0xff26278D)),
                                    value: getcontroller.selectedcurrency.value,
                                    items: getcontroller.currencies
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    onChanged: (String? country) {
                                      getcontroller.selectedcurrency.value =
                                          country!;
                                    });
                              }),
                              SizedBox(
                                width: Get.width * 0.15,
                              ),
                              Container(
                                height: 45,
                                width: Get.width * 0.31,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xffEFEFEF)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  controller: digits,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Divider(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.4,
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (digits.text.isEmpty ||
                                      int.tryParse(digits.text) == null) {
                                    // Show error message or handle invalid input
                                  } else {
                                    int amount = int.parse(digits.text);
                                    ConverstionViewModel().fetchapiresult(
                                        getcontroller.selectedcurrency.value,
                                        getcontroller.selectedcurrencyB.value,
                                        amount);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff26278D)),
                                  child: const Center(
                                    child: Image(
                                        image: AssetImage('images/Group.png')),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        //2nd Column

                        //
                        FutureBuilder(
                            future: ConverstionViewModel().fetchapiresult(
                                getcontroller.selectedcurrency.value,
                                getcontroller.selectedcurrencyB.value,
                                digits.text.isEmpty ||
                                        int.tryParse(digits.text) == null
                                    ? 0
                                    : int.parse(digits.text)),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.05,
                                            top: Get.height * 0.02,
                                            bottom: Get.height * 0.02),
                                        child: Text(
                                          'Converted Amount',
                                          style: GoogleFonts.roboto(
                                              color: Color(0xff989898),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Get.width * 0.05),
                                    child: Row(
                                      children: [
                                        // Obx((){

                                        // })
                                        Obx(() {
                                          return Image(
                                              height: 45,
                                              width: 45,
                                              image: AssetImage(
                                                  'images/${getcontroller.selectedcurrencyB.toString()}.png'));
                                        }),

                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Obx(() {
                                          return DropdownButton(
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color:
                                                      const Color(0xff26278D)),
                                              value: getcontroller
                                                  .selectedcurrencyB.value,
                                              items: getcontroller
                                                  .currencies.value
                                                  .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value));
                                              }).toList(),
                                              onChanged: (String? value) {
                                                getcontroller.selectedcurrencyB
                                                    .value = value!;
                                                getcontroller
                                                    .setcountryflag(value);
                                              });
                                        }),

                                        SizedBox(
                                          width: Get.width * 0.15,
                                        ),

                                        Container(
                                          height: 45,
                                          width: Get.width * 0.31,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xffEFEFEF)),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                labelStyle: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                                label: Center(
                                                  child: Text(
                                                    snapshot.data == null
                                                        ? ''
                                                        : snapshot.data!
                                                            .conversionResult
                                                            .toString(),
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                border: InputBorder.none),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            enabled: false,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.width * 0.06,
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: ConverstionViewModel().fetchapiresult(
                          getcontroller.selectedcurrency.value,
                          getcontroller.selectedcurrencyB.value,
                          digits.text.isEmpty ||
                                  int.tryParse(digits.text) == null
                              ? 0
                              : int.parse(digits.text)),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.05, top: Get.height * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Indicative Exchange Rate',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Color(0xffA1A1A1)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot!.data == null
                                        ? ''
                                        : ' ${'1 '}${snapshot.data!.baseCode.toString()}${' = '}',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    snapshot.data == null
                                        ? ''
                                        : '${snapshot.data!.conversionRate} ${snapshot.data!.targetCode}',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
