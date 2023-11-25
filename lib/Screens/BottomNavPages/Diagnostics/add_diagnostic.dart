import 'package:flutter/foundation.dart';
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
    required this.question, required this.onSelect, Key? key,
  }) : super(key: key);

  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Question>('question', question));
  }

}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  final List<String> _selectedOptions = <String>[];

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
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.question.question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.question.options.map((option) {
              return Row(
                children: <Widget>[
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
  const Questionnaire({super.key});

  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final Map<String, List<String>> _answers = <String, List<String>>{};

  void _updateAnswer(String question, List<String> options) {
    setState(() {
      _answers[question] = options;
    });
  }

  List<String> _getDiagnosis() {
    // Lógica para determinar o diagnóstico com base nas respostas
    final List<String> diagnosis = <String>[];

    // Exemplo de diagnóstico com base nas respostas selecionadas
    final bool isFemale1 = _answers['gênero']?.contains('Feminino') ?? false;
    final bool isMale1 = _answers['gênero']?.contains('Masculino') ?? false;
    final bool isGenreNotSelected1 = _answers['gênero']?.contains('Não Selecionado') ?? false;
    final bool isMelanoderma1 = _answers['etnia']?.contains('Melanoderma') ?? false;
    final bool isAsian1 = _answers['etnia']?.contains('Asiático') ?? false;
    final bool isCaucasian1 = _answers['etnia']?.contains('Caucasiano') ?? false;
    final bool isIndigenous1 = _answers['etnia']?.contains('Indígena') ?? false;
    final bool isEtinyNotSelected1 = _answers['etnia']?.contains('Não Selecionado') ?? false;
    final bool is0to101 = _answers['idade']?.contains('Entre 0 e 10 anos') ?? false;
    final bool is11to251 = _answers['idade']?.contains('Entre 11 e 25 anos') ?? false;
    final bool is26to501 = _answers['idade']?.contains('Entre 26 e 50 anos') ?? false;
    final bool isOver601 = _answers['idade']?.contains('Mais de 60 anos') ?? false;
    final bool isPainPresent1 = _answers['dor']?.contains('Não') ?? false;
    final bool isParestesia1 = _answers['parestesia']?.contains('Não') ?? false;
    final bool isBifosfonatos1 = _answers['bifosfonatos']?.contains('Não se aplica') ?? false;
    final bool isMaxila1 = _answers['localização']?.contains('Maxila') ?? false;
    final bool isMandibula1 = _answers['localização']?.contains('Mandíbula') ?? false;
    final bool isMaxilaAndMandibula = _answers['localização']?.contains('Maxila e Mandíbula') ?? false;
    final bool isIncisivos1 = _answers['localização_local']?.contains('Região dos incisivos') ?? false;
    final bool isCaninos1 = _answers['localização_local']?.contains('Região dos caninos') ?? false;
    final bool isPreMolares1 = _answers['localização_local']?.contains('Região de pré-molares') ?? false;
    final bool isMolares1 = _answers['localização_local']?.contains('Região dos molares') ?? false;
    final bool isMandibulaLocal1 = _answers['localização_local']?.contains('Região da mandíbula') ?? false;
    final bool isOrigem1 = _answers['origem']?.contains('Central') ?? false;
    
    diagnosis.add(((isFemale1 || isMale1 || isGenreNotSelected1) && isOver601) ? 'Cisto Dentígero' : '');

    final bool isAsian2 = _answers['etnia']?.contains('Asiático') ?? false;
    final bool is26to502 = _answers['idade']?.contains('Entre 26 e 50 anos') ?? false;
    diagnosis.add((isAsian2 && is26to502) ? 'Diagnóstico B' : '');

    final bool isCaucasian3 = _answers['etnia']?.contains('Caucasiano') ?? false;
    final bool is11to253 = _answers['idade']?.contains('Entre 11 e 25 anos') ?? false;
    final bool isMaxila3 = _answers['localização']?.contains('Maxila') ?? false;
    diagnosis.add((isCaucasian3 && is11to253 && isMaxila3) ? 'Diagnóstico C' : '');


    return diagnosis;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionnaire',
      home: Scaffold(
        appBar: AppBar(title: const Text('Questionário')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MultipleChoiceQuestion(
                question: Question('Qual o gênero biológico do paciente?', <String>['Feminino', 'Masculino', 'Não selecionado']),
                onSelect: (options) => _updateAnswer('gênero', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual a etnia do paciente?', <String>['Melanoderma', 'Asiático', 'Caucasiano', 'Indígena', 'Não selecionado']),
                onSelect: (options) => _updateAnswer('etnia', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual a idade do paciente?', <String>['Entre 0 e 10 anos', 'Entre 11 e 25 anos', 'Entre 26 e 50 anos', 'Mais de 60 anos']),
                onSelect: (options) => _updateAnswer('idade', options),
              ),
              MultipleChoiceQuestion(
                question: Question('O paciente apresenta dor?', <String>['Sim', 'Não', 'Não informado']),
                onSelect: (options) => _updateAnswer('dor', options),
              ),
              MultipleChoiceQuestion(
                question: Question('O paciente apresenta parestesia?', <String>['Sim', 'Não', 'Não informado']),
                onSelect: (options) => _updateAnswer('parestesia', options),
              ),
              MultipleChoiceQuestion(
                question: Question('O paciente faz uso de Bisfosfonatos?', <String>['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('bisfosfonatos', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Onde a lesão está?', <String>['Maxila', 'Mandíbula', 'Maxila e Mandíbula']),
                onSelect: (options) => _updateAnswer('localizacao', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Onde a lesão está localizada?', <String>['Região de incisivos', 'Região de caninos', 'Região de pré-molares', 'Região de molares', 'Ramo da mandíbula', 'ATM', 'Seios Maxilares']),
                onSelect: (options) => _updateAnswer('localizacao_local', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual a origem da lesão?', <String>['Periférica', 'Central']),
                onSelect: (options) => _updateAnswer('origem', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Quantas lesões existem?', <String>['Uma', 'Duas', 'Três ou mais', 'Generalizado']),
                onSelect: (options) => _updateAnswer('quantidade', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão tem origem odontogênica?', <String>['Originaria de coroa', 'Originaria de raiz', 'Originaria de ápice', 'Elemento ausente', 'Não associada a dentes', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('odontogenica', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Qual o tamanho da lesão?', <String>['Menor que 2cm', 'Entre 2 e 3 cm', 'Maior que 3 cm']),
                onSelect: (options) => _updateAnswer('tamanho', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Existe expansão ou rompimento de corticais?', <String>['Sim', 'Não']),
                onSelect: (options) => _updateAnswer('expansao', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão é lobular?', <String>['Unilocular', 'Multilocular', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('lobular', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão é corticalizada?', <String>['Sim', 'Parcialmente corticalizada', 'Não corticalizada', 'Difusa', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('corticalizada', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Como é o interior da lesão?', <String>['Hiperdensa/Radiopaca', 'Hipodensa/Radiolúcida', 'Mista', 'Hipodensa/Radiolúcida com \nfocos hiperdensos/radiopacos']),
                onSelect: (options) => _updateAnswer('interior', options),
              ),
              MultipleChoiceQuestion(
                question: Question('Existem reabsorção de raízes?', <String>['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('reabsorcao', options),
              ),
              MultipleChoiceQuestion(
                question: Question('A lesão causa impactação ou deslocamento de dentes?', <String>['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('impactacao', options),
              ),

              ElevatedButton(
                onPressed: () {
                  final List<String> diagnosis = _getDiagnosis();
                  // Ação a ser realizada quando o botão for pressionado
                  // Por exemplo, exibir os diagnósticos
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Diagnóstico'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: diagnosis
                            .map((d) => Text('- $d', style: const TextStyle(fontWeight: FontWeight.bold)))
                            .toList(),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Validar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const Questionnaire());
}
