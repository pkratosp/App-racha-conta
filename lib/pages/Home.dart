import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controlador dos inputs
  TextEditingController TXTtotalConta = TextEditingController();
  TextEditingController TXTquantidadePessoa = TextEditingController();

  double taxa = 0;
  double totalConta = 0;
  double totalPagar = 0;
  double comissao = 0;
  int qtdPessoas = 0;

  //chave do form
  final _formKey = GlobalKey<FormState>();

  void calcularConta(){

    setState(() {
      //receber os valores
      totalConta = double.parse(TXTtotalConta.text);
      qtdPessoas = int.parse(TXTquantidadePessoa.text);

      //calcular comissão
      comissao = (taxa * totalConta) / 100;


      //calcular o total por pessoa
      totalPagar = (totalConta + comissao) / qtdPessoas;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Total a pagar por Pessoa'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/carteira.png', width: 60),

                Text('O total da conta: R\$ $totalConta'),

                Text('A taxa do garçon: R\$ $comissao'),

                Text('Total por pessoa: R\$ $totalPagar')
              ],
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color(0xffFF6600)
                ),
              )
            ],
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Racha conta'),
        centerTitle: true,
        backgroundColor: Color(0xffFF6600),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,//chave do form
            child:  Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset('assets/icone_carteira.svg'),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: TXTtotalConta,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        labelText: 'Total da conta'
                    ),
                    style: TextStyle(
                        fontSize: 18
                    ),
                    validator: (valor){
                      if(valor == null || valor.isEmpty){
                        return "Campo obrigatório";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text(
                          'Taxa de serviço %:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    Slider(
                        value: taxa,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: 'Taxa $taxa%',
                        activeColor: Color(0xffFF6600),
                        inactiveColor: Colors.grey,
                        onChanged: (double valor){
                          setState(() {
                            taxa = valor;
                          });
                        }
                    )
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: TXTquantidadePessoa,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Quantidade de pessoa',
                    ),
                    style: TextStyle(
                        fontSize: 18
                    ),
                    validator: (valor){
                      if(valor == null || valor.isEmpty){
                        return "Campo obrigatório";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),

                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        calcularConta();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffFF6600),
                      onPrimary: Colors.white,
                    ),
                    child: Text('Calcular')
                )

              ],
            ),
          )
        )
      ),
    );
  }
}
