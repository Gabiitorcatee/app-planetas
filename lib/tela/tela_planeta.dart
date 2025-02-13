import 'package:flutter/material.dart';
import 'package:myapp/controles/controle_planeta.dart';
import '../modelos/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final bool isInserir;
  final Planeta planeta;
  final Function() onFinalizado;

  const TelaPlaneta({
    super.key,
    required this.isInserir,
    required this.planeta,
    required this.onFinalizado,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {
  final _foreKey = GlobalKey<FormState>();

  final TextEditingController _nomeController =
      TextEditingController(); //faz gerenciamento do que está sendo digitado
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _distanciaDoSolController =
      TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  late Planeta _planeta;

  @override
  void initState() {
    _planeta = widget.planeta;
    _nomeController.text = _planeta.nome;
    _tamanhoController.text = _planeta.tamanho.toString();
    _distanciaDoSolController.text = _planeta.distanciaDoSol.toString();
    _descricaoController.text = _planeta.descricao ?? '';
    _apelidoController.text = _planeta.apelido ?? '';

    super.initState();
  }

//sempre que usar o controller precisa do dispose
  @override
  void dispose() {
    _nomeController.dispose();
    _tamanhoController.dispose();
    _distanciaDoSolController.dispose();
    _descricaoController.dispose();
    _apelidoController.dispose();
    super.dispose();
  }

//para adicionar um planeta
  Future<void> _inserirPlaneta() async {
    await _controlePlaneta.inserirPlaneta(_planeta);
  }

  Future<void> _alterarPlaneta() async {
    await _controlePlaneta.alterarPlaneta(_planeta);
  }

//salva os dados do planeta
  void _submitForm() {
    if (_foreKey.currentState!.validate()) {
      _foreKey.currentState!.save();
      if (widget.isInserir) {
        _inserirPlaneta();
      } else {
        _alterarPlaneta();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dados do planeta \n${_planeta.nome} foram ${widget.isInserir ? 'inseridos' : 'alterados'} salvos com sucesso!'),
        ),
      );
      //Depois de salvar ele volta para a tela pricipal
      Navigator.of(context).pop();
      widget.onFinalizado();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro de Planetas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            //define o tamanho e espaço do label
            horizontal: 35.0,
            vertical: 25.0),
        //Configurações do Formulário
        child: Form(
          key: _foreKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Planeta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  //Verifica se o campo está preenchido ou não
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Digite o nome do planeta (3 ou mais caracteres)';
                    }
                    return null;
                  },
                  //salva a informação no planeta
                  onSaved: (value) {
                    _planeta.nome = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _tamanhoController,
                  decoration: InputDecoration(
                    labelText: 'Tamanho do Planeta (ka)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o tamanho do planeta.';
                    }
                    final numero = double.tryParse(value);
                    if (numero == null) {
                      return 'Digite um número válido.';
                    }
                    if (numero == 0) {
                      return 'Digite um número maior que zero.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.tamanho = double.parse(value!);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: _distanciaDoSolController,
                    decoration: InputDecoration(
                      labelText: 'Distância do Sol',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                     if (value == null || value.isEmpty) {
                      return 'Digite a dintância do Sol.';
                    }
                    final numero = double.tryParse(value);
                    if (numero == null) {
                      return 'Digite um número válido.';
                    }
                    if (numero == 0) {
                      return 'Digite um número maior que zero.';
                    }
                    return null;
                  },
                    onSaved: (value) {
                      _planeta.distanciaDoSol = double.parse(value!);
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) {
                    _planeta.descricao = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _apelidoController,
                  decoration: InputDecoration(
                    labelText: 'Apelido',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) {
                    _planeta.apelido = value!;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Salvar'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
