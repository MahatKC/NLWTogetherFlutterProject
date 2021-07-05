import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

import 'insert_botelo_controller.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");

  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");

  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text(
                  "Preencha os dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputTextWidget(
                        validator: controller.validateName,
                        label: "Nome do boleto",
                        icon: Icons.description_outlined,
                        onChanged: (value) {
                          controller.onChange(name: value);
                        },
                      ),
                      InputTextWidget(
                        controller: dueDateInputTextController,
                        validator: controller.validateVencimento,
                        label: "Vencimento",
                        icon: FontAwesomeIcons.timesCircle,
                        onChanged: (value) {
                          controller.onChange(dueDate: value);
                        },
                      ),
                      InputTextWidget(
                        controller: moneyInputTextController,
                        label: "Valor",
                        validator: (_) => controller.validateValor(
                            moneyInputTextController.numberValue),
                        icon: FontAwesomeIcons.wallet,
                        onChanged: (value) {
                          controller.onChange(
                              value: moneyInputTextController.numberValue);
                        },
                      ),
                      InputTextWidget(
                        controller: barcodeInputTextController,
                        label: "Código",
                        icon: FontAwesomeIcons.barcode,
                        validator: controller.validateCodigo,
                        onChanged: (value) {
                          controller.onChange(barcode: value);
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
