import 'package:flutter/material.dart';
import 'package:payflow/modules/extract_page/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final pages = [
    MeusBoletosPage(),
    ExtractPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
              height: 152,
              color: AppColors.primary,
              child: Center(
                child: ListTile(
                  title: Text.rich(
                    TextSpan(
                        text: "Olá, ",
                        style: TextStyles.titleRegular,
                        children: [
                          TextSpan(
                              text: "Pikachu",
                              style: TextStyles.titleBoldBackground)
                        ]),
                  ),
                  subtitle: Text("Mantenha suas contas em dia",
                      style: TextStyles.captionShape),
                  trailing: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              )),
          preferredSize: Size.fromHeight(152)),
      body: pages[controller.currentPage],
      bottomNavigationBar: Container(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    controller.setPage(0);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.home,
                    color: controller.currentPage == 0 ? AppColors.primary : AppColors.body,
                  )),
              GestureDetector(
                onTap: () {
                //  Navigator.pushNamed(context, "/barcode_scanner");
                  Navigator.pushNamed(context, "/insert_boleto");
                },
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.setPage(1);
                    setState(() {});
                  },
                  icon:
                      Icon(Icons.description_outlined, 
                      color: controller.currentPage == 1 ? AppColors.primary : AppColors.body)),
            ],
          )),
    );
  }
}
