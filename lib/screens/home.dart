import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackmytech/colors.dart';
import 'package:trackmytech/screens/ai_consultant.dart';
import 'package:trackmytech/screens/qr_code.dart';

import 'map_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Padding(padding: const EdgeInsets.all(10.0),
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(child:Padding(padding: const EdgeInsets.only(bottom: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center
            ,children:[
              Image.asset(
                'assets/logo.png',
                scale: 1.1,
              )
            ]
        ),) ),
      ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRScanScreen()),
        );
      },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              fixedSize: const Size(235, 50)),
          child: Text(style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),"Прогрес на уред")),
      const SizedBox(height: 10,),
      ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapSearchScreen()),
        );
      },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              fixedSize: const Size(235, 50)),
          child: Text(style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),"Пронајди сервис")),
      const SizedBox(height: 10,),
      ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AIConsultantScreen()),
        );
      },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              fixedSize: const Size(235, 50)),
          child: Text(style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),"AI консуслтант")),
    ],),)
     );
  }

}

