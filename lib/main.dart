import 'package:flutter/material.dart';
import 'package:jobtest/provider/screen_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<TextInputModel>(
      create: (_) => TextInputModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: TextInputPage(),
    );
  }
}

class TextInputPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  TextInputPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<TextInputModel>(
              builder: (context, model, child) {
                return TextField(
                  controller: _textController,
                  onChanged: (text) => model.validateTextField(text),
                  decoration: InputDecoration(
                    labelText: 'Напишите что-то',
                    errorText:
                        model.isTextFieldValid ? null : 'Напишите что-то',
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Consumer<TextInputModel>(
              builder: (context, model, child) {
                return ElevatedButton(
                  onPressed: model.isTextFieldValid
                      ? () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Написанный текст'),
                              content: Text(_textController.text),
                              actions: [
                                TextButton(
                                  child: const Text('Назад'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                          model.updateDisplayText(_textController.text);
                        }
                      : null,
                  child: const Text('Отобразить написанное'),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Consumer<TextInputModel>(
              builder: (context, model, child) {
                return ElevatedButton(
                  onPressed: () {
                    model.clearTextField();
                    _textController.clear();
                  },
                  child: const Text('Очистить поле'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
