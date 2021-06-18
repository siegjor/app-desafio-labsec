import 'package:flutter/material.dart';
import 'package:labsec_app/components/card_box.dart';
import 'package:labsec_app/components/go_back_button.dart';
import 'package:labsec_app/components/imagem_logo.dart';
import 'package:labsec_app/components/text/info_text.dart';
import 'package:labsec_app/components/text/normal_text.dart';
import 'package:labsec_app/components/text/success_text.dart';
import 'package:labsec_app/messages/generate_new_key_messages.dart';
import 'package:labsec_app/providers/generate_key_provider.dart';
import 'package:labsec_app/styles/custom_colors.dart';
import 'package:provider/provider.dart';

class GenerateNewKeyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GenerateNewKeyScreenState();
  }
}

class GenerateNewKeyScreenState extends State<GenerateNewKeyScreen> {
  int? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(genNewMsg['title']),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ImagemLogo(),
            CardBox(
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  NormalText(genNewMsg['key_size']),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 16.0, left: 16.0),
                    child: Container(
                      child: DropdownButton<int>(
                        value: _chosenValue,
                        underline: Container(),
                        isExpanded: true,
                        hint: NormalText(genNewMsg['choose_value']),
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        items: <int>[512, 1024, 2048]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value bits'),
                          );
                        }).toList(),
                        onChanged: (int? value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Consumer<GenerateKeyProvider>(
                      builder: (context, genKeyProvider, child) {
                    if (!genKeyProvider.validators['wasGenerated']) {
                      return ListTile(
                        horizontalTitleGap: 2,
                        leading: Icon(
                          Icons.info_outline,
                          color: myColors.primary,
                        ),
                        title: InfoText(genNewMsg['gen_new_key']),
                      );
                    } else {
                      genKeyProvider.validators['wasGenerated'] = false;
                      return ListTile(
                        horizontalTitleGap: 2,
                        leading: Icon(
                          Icons.check,
                          color: myColors.success,
                        ),
                        title: SuccessText(genNewMsg['gen_success']),
                      );
                    }
                  }),
                ],
              ),
            ),
            Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _generateNewPair(),
                    child: Text(genNewMsg['button_text']),
                  ),
                  GoBackButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generateNewPair() {
    final int? _bitLength = _chosenValue;
    if (_bitLength != null) {
      Provider.of<GenerateKeyProvider>(context, listen: false)
          .generateRSAKeyPair(_bitLength);
      Provider.of<GenerateKeyProvider>(context, listen: false)
          .validators['wasGenerated'] = true;
    }
  }
}
