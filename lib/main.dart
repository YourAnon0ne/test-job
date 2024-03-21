import 'package:flutter/material.dart';
import 'package:jobtest/provider/screen_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: ChangeNotifierProvider<TextFieldModel>(
        create: (context) => TextFieldModel(),
        child: AppBody(),
      ),
    );
  }
}

class AppBody extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TextFieldModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Напишите что-то',
                errorText:
                    model.text.isEmpty ? 'Поле не может быть пустым' : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final model =
                      Provider.of<TextFieldModel>(context, listen: false);
                  model.updateText(_controller.text);

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Entered Text'),
                      content: Text(model.text),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Отобразить текст на экране'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                model.clearText();
                _controller.clear();
              },
              child: Text('Очистить поле'),
            ),
          ],
        ),
      ),
    );
  }
}
