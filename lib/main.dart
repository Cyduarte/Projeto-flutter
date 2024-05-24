import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transferência PIX',
      theme: ThemeData(
        primaryColor: Color(0xFF40E0D0),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TransferScreen(),
        '/finalize': (context) => FinalizeTransferScreen(),
        '/receipt': (context) => TransferReceiptScreen(),
      },
    );
  }
}

class TransferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController cpfController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Transferência PIX'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Verifique se a chave PIX está digitada corretamente.',
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            SizedBox(height: 20),
            TextField(
              controller: cpfController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF/CNPJ ou chave PIX',
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text('Avançar'),
                onPressed: () {
                  String cpf = cpfController.text;
                  Navigator.pushNamed(context, '/finalize', arguments: cpf);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinalizeTransferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController valorController = TextEditingController();
    final String cpf = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Finalize sua transferência'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Selecione o Valor',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixText: 'R\$ ',
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text('Transferir'),
                onPressed: () {
                  String valor = valorController.text;
                  Navigator.pushNamed(
                    context,
                    '/receipt',
                    arguments: {'cpf': cpf, 'valor': valor},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String valor = arguments['valor'];
    final String cpf = arguments['cpf'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento por Pix'),
        backgroundColor: Colors.cyan[300],
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Pedido pago'),
              subtitle: Text('Pagamento por Pix'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Pagamento por Pix com confirmação automática'),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Valor: R\$ $valor',
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
          Text(
            'Chave Pix: R\$ $cpf.',
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Compartilhar'),
            onPressed: () {
              Share.share('Eu transferi R\$ $valor via Pix para a chave $cpf.');
            },
          ),
        ],
      ),
      backgroundColor: Colors.cyan[100],
    );
  }
}
