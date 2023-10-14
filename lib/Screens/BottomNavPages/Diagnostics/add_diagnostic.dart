import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> options;

  Question(this.question, this.options);
}

class MultipleChoiceQuestion extends StatefulWidget {
  final Question question;
  final Function(List<String>) onSelect;

  const MultipleChoiceQuestion({
    Key? key,
    required this.question,
    required this.onSelect,
  }) : super(key: key);

  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  List<String> _selectedOptions = [];

  void _onOptionSelected(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
      widget.onSelect(_selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.question.options.map((option) {
              return Row(
                children: [
                  Checkbox(
                    value: _selectedOptions.contains(option),
                    onChanged: (_) => _onOptionSelected(option),
                  ),
                  Text(option),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  Map<String, List<String>> _answers = {};

  void _updateAnswer(String question, List<String> options) {
    setState(() {
      _answers[question] = options;
    });
  }

  List<String> _getDiagnosis() {
    // Lógica para determinar o diagnóstico com base nas respostas
    // Aqui, você pode substituir essa lógica com a sua própria implementação
    List<String> diagnosis = [];

    // Exemplo de diagnóstico com base nas respostas selecionadas
    bool isFemale1 = _answers['gênero']?.contains('Feminino') ?? false;
    bool isMale1 = _answers['gênero']?.contains('Masculino') ?? false;
    bool isGenreNotSelected1 = _answers['gênero']?.contains('Não Selecionado') ?? false;
    bool isMelanoderma1 = _answers['etnia']?.contains('Melanoderma') ?? false;
    bool isAsian1 = _answers['etnia']?.contains('Asiático') ?? false;
    bool isCaucasian1 = _answers['etnia']?.contains('Caucasiano') ?? false;
    bool isIndigenous1 = _answers['etnia']?.contains('Indígena') ?? false;
    bool isEtinyNotSelected1 = _answers['etnia']?.contains('Não Selecionado') ?? false;
    bool is0to101 = _answers['idade']?.contains('Entre 0 e 10 anos') ?? false;
    bool is11to251 = _answers['idade']?.contains('Entre 11 e 25 anos') ?? false;
    bool is26to501 = _answers['idade']?.contains('Entre 26 e 50 anos') ?? false;
    bool isOver601 = _answers['idade']?.contains('Mais de 60 anos') ?? false;
    bool isPainPresent1 = _answers['dor']?.contains('Não') ?? false;
    bool isParestesia1 = _answers['parestesia']?.contains('Não') ?? false;
    bool isBifosfonatos1 = _answers['bifosfonatos']?.contains('Não se aplica') ?? false;
    bool isMaxila1 = _answers['localização']?.contains('Maxila') ?? false;
    bool isMandibula1 = _answers['localização']?.contains('Mandíbula') ?? false;
    bool isMaxilaAndMandibula = _answers['localização']?.contains('Maxila e Mandíbula') ?? false;
    bool isIncisivos1 = _answers['localização_local']?.contains('Região dos incisivos') ?? false;
    bool isCaninos1 = _answers['localização_local']?.contains('Região dos caninos') ?? false;
    bool isPreMolares1 = _answers['localização_local']?.contains('Região de pré-molares') ?? false;
    bool isMolares1 = _answers['localização_local']?.contains('Região dos molares') ?? false;
    bool isMandibulaLocal1 = _answers['localização_local']?.contains('Região da mandíbula') ?? false;
    bool isOrigem1 = _answers['origem']?.contains('Central') ?? false;
    
    diagnosis.add(((isFemale1 || isMale1 || isGenreNotSelected1) && isOver601) ? 'Cisto Dentígero' : '');

    bool isAsian2 = _answers['etnia']?.contains('Asiático') ?? false;
    bool is26to502 = _answers['idade']?.contains('Entre 26 e 50 anos') ?? false;
    diagnosis.add((isAsian2 && is26to502) ? 'Diagnóstico B' : '');

    bool isCaucasian3 = _answers['etnia']?.contains('Caucasiano') ?? false;
    bool is11to253 = _answers['idade']?.contains('Entre 11 e 25 anos') ?? false;
    bool isMaxila3 = _answers['localização']?.contains('Maxila') ?? false;
    diagnosis.add((isCaucasian3 && is11to253 && isMaxila3) ? 'Diagnóstico C' : '');


    return diagnosis;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionnaire',
      home: Scaffold(
        appBar: AppBar(title: Text('Questionário')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MultipleChoiceQuestion(
                question: Question('Qual o gênero biológico do paciente?', ['Feminino', 'Masculino', 'Não selecionado']),
                onSelect: (options) => _updateAnswer('gênero', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual a etnia do paciente?', ['Melanoderma', 'Asiático', 'Caucasiano', 'Indígena', 'Não selecionado']),
                onSelect: (options) => _updateAnswer('etnia', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual a idade do paciente?', ['Entre 0 e 10 anos', 'Entre 11 e 25 anos', 'Entre 26 e 50 anos', 'Mais de 60 anos']),
                onSelect: (options) => _updateAnswer('idade', options),
              ),
              MultipleChoiceQuestion(
                question: Question('O paciente apresenta dor?', ['Sim', 'Não', 'Não informado']),
                onSelect: (options) => _updateAnswer('dor', options),
              ),
              MultipleChoiceQuestion(
                question: Question('O paciente apresenta parestesia?', ['Sim', 'Não', 'Não informado']),
                onSelect: (options) => _updateAnswer('parestesia', options),
              ),
              MultipleChoiceQuestion(
                question: Question('O paciente faz uso de Bisfosfonatos?', ['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('bisfosfonatos', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Onde a lesão está?', ['Maxila', 'Mandíbula', 'Maxila e Mandíbula']),
                onSelect: (options) => _updateAnswer('localizacao', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Onde a lesão está localizada?', ['Região de incisivos', 'Região de caninos', 'Região de pré-molares', 'Região de molares', 'Ramo da mandíbula', 'ATM', 'Seios Maxilares']),
                onSelect: (options) => _updateAnswer('localizacao_local', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual a origem da lesão?', ['Periférica', 'Central']),
                onSelect: (options) => _updateAnswer('origem', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Quantas lesões existem?', ['Uma', 'Duas', 'Três ou mais', 'Generalizado']),
                onSelect: (options) => _updateAnswer('quantidade', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão tem origem odontogênica?', ['Originaria de coroa', 'Originaria de raiz', 'Originaria de ápice', 'Elemento ausente', 'Não associada a dentes', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('odontogenica', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual o tamanho da lesão?', ['Menor que 2cm', 'Entre 2 e 3 cm', 'Maior que 3 cm']),
                onSelect: (options) => _updateAnswer('tamanho', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Existe expansão ou rompimento de corticais?', ['Sim', 'Não']),
                onSelect: (options) => _updateAnswer('expansao', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão é lobular?', ['Unilocular', 'Multilocular', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('lobular', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão é corticalizada?', ['Sim', 'Parcialmente corticalizada', 'Não corticalizada', 'Difusa', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('corticalizada', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Como é o interior da lesão?', ['Hiperdensa/Radiopaca', 'Hipodensa/Radiolúcida', 'Mista', 'Hipodensa/Radiolúcida com \nfocos hiperdensos/radiopacos']),
                onSelect: (options) => _updateAnswer('interior', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Existem reabsorção de raízes?', ['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('reabsorcao', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão causa impactação ou deslocamento de dentes?', ['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('impactacao', options),
              ),

              ElevatedButton(
                onPressed: () {
                  List<String> diagnosis = _getDiagnosis();
                  // Ação a ser realizada quando o botão for pressionado
                  // Por exemplo, exibir os diagnósticos
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Diagnóstico'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: diagnosis
                            .map((d) => Text('- $d', style: TextStyle(fontWeight: FontWeight.bold)))
                            .toList(),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Validar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Questionnaire());
}
