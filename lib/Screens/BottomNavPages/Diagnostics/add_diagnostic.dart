import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> options;

  Question(this.question, this.options);
}

class SingleChoiceQuestion extends StatefulWidget {
  final Question question;
  final Function(List<String>) onSelect;

  const SingleChoiceQuestion({
    required this.question, required this.onSelect, Key? key,
  }) : super(key: key);

  @override
  _SingleChoiceQuestionState createState() => _SingleChoiceQuestionState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Question>('question', question));
  }

}

/*class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
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
  }*/

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  String? _selectedOption;

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
      widget.onSelect([_selectedOption!]);
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
                  Radio(
                    value: option,
                    groupValue: _selectedOption,
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
    final bool isFemale = _answers['genero']?.contains('Feminino') ?? false;
    final bool isMale = _answers['genero']?.contains('Masculino') ?? false;
    final bool isGenreNotSelected = _answers['genero']?.contains('Não selecionado') ?? false;
    final bool isMelanoderma = _answers['etnia']?.contains('Melanoderma') ?? false;
    final bool isAsian = _answers['etnia']?.contains('Asiático') ?? false;
    final bool isCaucasian = _answers['etnia']?.contains('Caucasiano') ?? false;
    final bool isIndigenous = _answers['etnia']?.contains('Indígena') ?? false;
    final bool isEtinyNotSelected = _answers['etnia']?.contains('Não selecionado') ?? false;
    final bool is0to10 = _answers['idade']?.contains('Entre 0 e 10 anos') ?? false;
    final bool is11to25 = _answers['idade']?.contains('Entre 11 e 25 anos') ?? false;
    final bool is26to50 = _answers['idade']?.contains('Entre 26 e 50 anos') ?? false;
    final bool isOver60 = _answers['idade']?.contains('Mais de 60 anos') ?? false;
    final bool isPainNotPresent = _answers['dor']?.contains('Não') ?? false;
    final bool isPainPresent = _answers['dor']?.contains('Sim') ?? false;
    final bool isPainNotInformed = _answers['dor']?.contains('Não informado') ?? false;
    final bool isParestesiaNotPresent = _answers['parestesia']?.contains('Não') ?? false;
    final bool isParestesiaPresent = _answers['parestesia']?.contains('Sim') ?? false;
    final bool isParestesiaNotInformed = _answers['parestesia']?.contains('Não informado') ?? false;
    final bool isBisfosfonatosNotApply = _answers['bisfosfonatos']?.contains('Não se aplica') ?? false;
    final bool isBisfosfonatosYes = _answers['bisfosfonatos']?.contains('Sim') ?? false;
    final bool isBisfosfonatosNo = _answers['bisfosfonatos']?.contains('Não') ?? false;
    final bool isMaxila = _answers['localizacao']?.contains('Maxila') ?? false;
    final bool isMandibula = _answers['localizacao']?.contains('Mandíbula') ?? false;
    final bool isMaxilaAndMandibula = _answers['localizacao']?.contains('Maxila e Mandíbula') ?? false;
    final bool isIncisivos = _answers['localizacao_local']?.contains('Região de incisivos') ?? false;
    final bool isCaninos = _answers['localizacao_local']?.contains('Região de caninos') ?? false;
    final bool isPreMolares = _answers['localizacao_local']?.contains('Região de pré-molares') ?? false;
    final bool isMolares = _answers['localizacao_local']?.contains('Região de molares') ?? false;
    final bool isRamoMandibula = _answers['localizacao_local']?.contains('Ramo da mandíbula') ?? false;
    final bool isATM = _answers['localizacao_local']?.contains('ATM') ?? false;
    final bool isSeiosMaxilares = _answers['localizacao_local']?.contains('Seios Maxilares') ?? false;
    final bool isOrigemCentral = _answers['origem']?.contains('Central') ?? false;
    final bool isOrigemPeriferica = _answers['origem']?.contains('Periférica') ?? false;
    final bool isQuantidadeUmaLesao = _answers['quantidade']?.contains('Uma') ?? false;
    final bool isQuantidadeDuasLesao = _answers['quantidade']?.contains('Duas') ?? false;
    final bool isQuantidadeTresLesao = _answers['quantidade']?.contains('Três ou mais') ?? false;
    final bool isQuantidadeGeneralizadoLesao = _answers['quantidade']?.contains('Generalizado') ?? false;
    final bool isOrigemOdontogenicaCoroa = _answers['odontogenica']?.contains('Originaria de coroa') ?? false;
    final bool isOrigemOdontogenicaRaiz = _answers['odontogenica']?.contains('Originaria de raiz') ?? false;
    final bool isOrigemOdontogenicaApice = _answers['odontogenica']?.contains('Originaria de ápice') ?? false;
    final bool isOrigemOdontogenicaEA = _answers['odontogenica']?.contains('Elemento ausente') ?? false;
    final bool isOrigemOdontogenicaNAssociada = _answers['odontogenica']?.contains('Não associada a dentes') ?? false;
    final bool isOrigemOdontogenicaNA = _answers['odontogenica']?.contains('Não se aplica') ?? false;
    final bool isTamanhoLesaoP = _answers['tamanho']?.contains('Menor que 2cm') ?? false;
    final bool isTamanhoLesaoM = _answers['tamanho']?.contains('Entre 2 e 3cm') ?? false;
    final bool isTamanhoLesaoG = _answers['tamanho']?.contains('Maior que 3cm') ?? false;
    final bool isExpansaoSim = _answers['expansao']?.contains('Sim') ?? false;
    final bool isExpansaoNao = _answers['expansao']?.contains('Não') ?? false;
    final bool isLobularUni = _answers['lobular']?.contains('Unilocular') ?? false;
    final bool isLobularMulti = _answers['lobular']?.contains('Multilocular') ?? false;
    final bool isLobularNA = _answers['lobular']?.contains('Não se aplica') ?? false;
    final bool isCorticalizadaSim = _answers['corticalizada']?.contains('Sim') ?? false;
    final bool isCorticalizadaParcial = _answers['corticalizada']?.contains('Parcialmente corticalizada') ?? false;
    final bool isCorticalizadaNao = _answers['corticalizada']?.contains('Não corticalizada') ?? false;
    final bool isCorticalizadaDifusa = _answers['corticalizada']?.contains('Difusa') ?? false;
    final bool isCorticalizadaNA = _answers['corticalizada']?.contains('Não se aplica') ?? false;
    final bool isInteriorLesaoHipo = _answers['interior']?.contains('Hipodensa/Radiolúcida') ?? false;
    final bool isInteriorLesaoHiper = _answers['interior']?.contains('Hiperdensa/Radiopaca') ?? false;
    final bool isInteriorLesaoMista = _answers['interior']?.contains('Mista') ?? false;
    final bool isInteriorLesaoFoco = _answers['interior']?.contains('Hipodensa/Radiolúcida com \nfocos hiperdensos/radiopacos') ?? false;
    final bool isReabsorcaoRaizesNA = _answers['reabsorcao']?.contains('Não se aplica') ?? false;
    final bool isReabsorcaoRaizesSim = _answers['reabsorcao']?.contains('Sim') ?? false;
    final bool isReabsorcaoRaizesNao = _answers['reabsorcao']?.contains('Não') ?? false;
    final bool isImpactacaoSim = _answers['impactacao']?.contains('Sim') ?? false;
    final bool isImpactacaoNao = _answers['impactacao']?.contains('Não') ?? false;
    final bool isImpactacaoNA = _answers['impactacao']?.contains('Não se aplica') ?? false;

    if ((isFemale || isMale || isGenreNotSelected) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected ) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        isPainNotPresent &&
        isParestesiaNotPresent &&
        isBisfosfonatosNotApply &&
        (isMaxila || isMandibula || isMaxilaAndMandibula ) &&
        (isIncisivos || isCaninos || isPreMolares || isMolares || isRamoMandibula) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaCoroa &&
        isTamanhoLesaoP &&
        (isExpansaoSim || isExpansaoNao ) &&
        isLobularUni &&
        (isCorticalizadaParcial || isCorticalizadaSim ) &&
        isInteriorLesaoHipo &&
        isReabsorcaoRaizesNA &&
        (isImpactacaoNao || isImpactacaoSim)) {
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Cisto Dentígero \n\n Observações: \n - Maior frequência no gênero masculino \n - Maior frequência na etnia melanoderma \n - Maior frequência entre 11 e 25 anos');
    }
    else if((isFemale || isMale) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected ) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        isPainPresent &&
        isParestesiaNotPresent &&
        isBisfosfonatosNotApply &&
        isMaxila &&
        isIncisivos &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaNAssociada || isOrigemOdontogenicaNA ) &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG ) &&
        (isExpansaoSim || isExpansaoNao ) &&
        isLobularUni &&
        (isCorticalizadaParcial || isCorticalizadaSim ) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesSim || isReabsorcaoRaizesNao ) &&
        (isImpactacaoNao || isImpactacaoSim)){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Cisto do Ducto Nasopalatino \n\n Observações: \n - Maior frequência entre os 26 e os 50 anos \n - Raro entre os 0 e 10 anos');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainPresent || isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        isBisfosfonatosNotApply &&
        isMaxila &&
        (isIncisivos || isSeiosMaxilares) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaNAssociada &&
        (isTamanhoLesaoP || isTamanhoLesaoM) &&
        isExpansaoSim &&
        isLobularUni &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao) &&
        (isImpactacaoNao || isImpactacaoSim)){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Cisto Palatino Mediano');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected ) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed)&&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        isBisfosfonatosNotApply &&
        isMandibula &&
        (isIncisivos || isCaninos || isPreMolares || isMolares || isRamoMandibula) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaRaiz || isOrigemOdontogenicaApice || isOrigemOdontogenicaEA) &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoSim &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaParcial || isCorticalizadaSim ) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesSim || isReabsorcaoRaizesNao ) &&
        (isImpactacaoNao || isImpactacaoSim)){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Queratocisto* (de acordo com Neville) \n\n Observações: \n - Leve preferência ao gênero masculino \n - Leve preferência entre 26 e 50 anos'
          '\n - Raro na região de incisivos \n - Raro na região de caninos \n - Raro na região de pré-molares');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is11to25 || is26to50) &&
        isPainNotPresent &&
        isParestesiaNotPresent &&
        isBisfosfonatosNotApply &&
        (isMaxila || isMandibula || isMaxilaAndMandibula ) &&
        (isIncisivos || isCaninos || isPreMolares || isMolares || isRamoMandibula || isATM || isSeiosMaxilares) &&
        isOrigemCentral &&
        (isQuantidadeUmaLesao || isQuantidadeDuasLesao || isQuantidadeTresLesao || isQuantidadeGeneralizadoLesao ) &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaRaiz || isOrigemOdontogenicaApice || isOrigemOdontogenicaEA) &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG ) &&
        (isExpansaoSim || isExpansaoNao) &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesSim || isReabsorcaoRaizesNao) &&
        (isImpactacaoNao || isImpactacaoSim)){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Sindrome do Carcinoma Nevoide Basocelular (Síndrome de Gorlin) \n\n Observações: \n - Lesões generalizadas com maior frequência \n - Origem odontogênica de coroa com maior frequência');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is26to50 || isOver60) &&
        (isPainPresent || isPainNotPresent || isPainNotInformed)&&
        ( isParestesiaPresent || isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo || isBisfosfonatosYes || isBisfosfonatosNotApply ) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula ) &&
        (isIncisivos || isCaninos || isPreMolares) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaRaiz &&
        isTamanhoLesaoP &&
        isExpansaoNao &&
        isLobularUni &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoHipo &&
        isReabsorcaoRaizesNao &&
        (isImpactacaoNao || isImpactacaoSim || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Cisto Periodontal Lateral');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo || isBisfosfonatosNotApply ) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula ) &&
        (isIncisivos || isCaninos) &&
        (isOrigemCentral || isOrigemPeriferica) &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG ) &&
        (isExpansaoSim || isExpansaoNao) &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoMista &&
        (isReabsorcaoRaizesNao || isReabsorcaoRaizesNA ) &&
        (isImpactacaoNao || isImpactacaoSim )){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Cisto Odontogênico Calcificante* cisto de gorlin (de acordo com Neville) \n\n Observações: \n - Origem da lesão raramente periférica');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is26to50 || isOver60) &&
        (isPainPresent || isPainNotPresent || isPainNotInformed) &&
        ( isParestesiaPresent || isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply ) &&
        isMandibula &&
        (isIncisivos || isCaninos) &&
        (isOrigemCentral || isOrigemPeriferica) &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaNAssociada &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG ) &&
        (isExpansaoSim || isExpansaoNao) &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNao || isReabsorcaoRaizesNA ) &&
        (isImpactacaoNao || isImpactacaoSim || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos de Desenvolvimento - Cisto Odontogênico Glandular \n Observações: \n - Dores são raras \n - Parestesia é rara');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply ) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula ) &&
        (isIncisivos || isCaninos || isPreMolares || isMolares || isRamoMandibula) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaApice &&
        isTamanhoLesaoP &&
        (isExpansaoSim || isExpansaoNao) &&
        isLobularUni &&
        isCorticalizadaSim &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNao || isReabsorcaoRaizesNA ) &&
        (isImpactacaoNao || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos Inflamatórios - Cisto radicular \n Observações: \n - Dores são raras \n - Parestesia é rara');
    }
    else if((isFemale || isMale || isGenreNotSelected )  &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply ) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula ) &&
        (isIncisivos || isCaninos || isPreMolares || isMolares) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaNAssociada &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG ) &&
        (isExpansaoSim || isExpansaoNao) &&
        isLobularUni &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoHipo &&
        isReabsorcaoRaizesNA &&
        isImpactacaoNA){
      diagnosis.add('Cistos e Tumores Odontogênicos Inflamatórios - Cisto residual (radicular)');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25) &&
        (isPainPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        isMandibula &&
        isMolares &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaCoroa &&
        isTamanhoLesaoP &&
        isExpansaoNao &&
        (isLobularUni || isLobularNA ) &&
        (isCorticalizadaParcial || isCorticalizadaSim) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao) &&
        (isImpactacaoNao || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos Inflamatórios - Cisto da bifurcação vestibular');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula) &&
        (isMolares || isRamoMandibula || isATM) &&
        isOrigemCentral &&
        (isQuantidadeUmaLesao || isQuantidadeDuasLesao || isQuantidadeTresLesao || isQuantidadeGeneralizadoLesao) &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoSim &&
        isLobularMulti &&
        (isCorticalizadaParcial || isCorticalizadaDifusa || isCorticalizadaNA ) &&
        (isInteriorLesaoFoco || isInteriorLesaoMista) &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesSim) &&
        (isImpactacaoSim || isImpactacaoNao || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos - Ameloblastoma \n\n Observações: \n - Raro na etnia melanoderma \n - Raro na faixa etária abaixo dos 26 anos \n - Raro na maxila');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula) &&
        (isMolares || isRamoMandibula || isATM) &&
        isOrigemCentral &&
        (isQuantidadeUmaLesao || isQuantidadeDuasLesao || isQuantidadeTresLesao || isQuantidadeGeneralizadoLesao) &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoSim &&
        isLobularMulti &&
        (isCorticalizadaDifusa || isCorticalizadaNA ) &&
        (isInteriorLesaoFoco || isInteriorLesaoMista) &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesSim) &&
        (isImpactacaoSim || isImpactacaoNao || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos - Ameloblastoma Maligno e Carcinoma Ameloblástico \n\n Observações: \n - Raro na etnia melanoderma \n - Raro na faixa etária abaixo dos 26 anos \n - Raro na maxila');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainPresent || isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        isMandibula &&
        (isIncisivos || isCaninos) &&
        isOrigemCentral &&
        (isQuantidadeUmaLesao || isQuantidadeDuasLesao || isQuantidadeTresLesao || isQuantidadeGeneralizadoLesao) &&
        (isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoSim &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaDifusa || isCorticalizadaNao ) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesSim || isReabsorcaoRaizesNao) &&
        (isImpactacaoSim || isImpactacaoNao || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos - Carcinoma Odontogênico de Células Claras (Tumor Odontogênico de Células Claras)');
    }
    else if(isFemale &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula ) &&
        (isIncisivos || isCaninos || isPreMolares) &&
        (isOrigemCentral || isOrigemPeriferica) &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoP || isTamanhoLesaoM) &&
        (isExpansaoSim || isExpansaoNao) &&
        isLobularUni &&
        (isCorticalizadaSim || isCorticalizadaParcial) &&
        (isInteriorLesaoHipo || isInteriorLesaoFoco ) &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao) &&
        (isImpactacaoNao || isImpactacaoNA )){
      diagnosis.add('Cistos e Tumores Odontogênicos - Tumor Odontogênico Adenomatoide \n\n Observações: \n - Raro na mandíbula \n - Lesão periférica rara');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is26to50 || isOver60) &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula) &&
        (isMolares || isRamoMandibula || isATM) &&
        (isOrigemCentral || isOrigemPeriferica) &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        isTamanhoLesaoP &&
        isExpansaoSim &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaSim || isCorticalizadaParcial) &&
        (isInteriorLesaoMista || isInteriorLesaoFoco ) &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao || isReabsorcaoRaizesSim) &&
        (isImpactacaoNao || isImpactacaoNA || isImpactacaoSim)){
      diagnosis.add('Cistos e Tumores Odontogênicos - Tumor Odontogênico Epitelial Calcificante (Tumor de Pindborg) \n\n Observações: \n - Raro na maxila \n - Lesão periférica rara');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainPresent || isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula) &&
        (isMolares || isIncisivos || isCaninos || isPreMolares) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaRaiz || isOrigemOdontogenicaApice) &&
        isTamanhoLesaoP &&
        isExpansaoNao &&
        isLobularUni &&
        isCorticalizadaNao &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao) &&
        (isImpactacaoNao || isImpactacaoNA)){
      diagnosis.add('Cistos e Tumores Odontogênicos - Tumor Odontogênico Escamoso \n\n Observações: \n - Raro apresentar dor');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50) &&
        (isPainPresent || isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula) &&
        (isMolares || isRamoMandibula) &&
        isOrigemCentral &&
        isQuantidadeUmaLesao &&
        isOrigemOdontogenicaCoroa &&
        isTamanhoLesaoP &&
        isExpansaoNao &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaSim || isCorticalizadaParcial) &&
        isInteriorLesaoHipo &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao) &&
        (isImpactacaoSim || isImpactacaoNA)){
      diagnosis.add('Cistos e Tumores Odontogênicos - Fibroma Ameloblástico \n\n Observações: \n - Maior prevalência no gênero masculino \n - Raro a partir dos 26 até os 50 anos de idade \n - Raro na maxila');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        is0to10 &&
        (isPainNotPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula) &&
        (isMolares || isRamoMandibula) &&
        (isOrigemCentral || isOrigemPeriferica) &&
        isQuantidadeUmaLesao &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoP || isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoNao &&
        (isLobularUni || isLobularMulti) &&
        (isCorticalizadaSim || isCorticalizadaParcial) &&
        (isInteriorLesaoMista || isInteriorLesaoFoco ) &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesNao) &&
        (isImpactacaoSim || isImpactacaoNA)){
      diagnosis.add('Cistos e Tumores Odontogênicos - Fibro-odontoma Ameloblástico \n\n Observações: \n - Raro a partir dos 26 até os 50 anos de idade \n - Raro na maxila \n - Rara lesão multiocular');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula) &&
        (isMolares || isRamoMandibula) &&
        isOrigemCentral &&
        (isQuantidadeUmaLesao || isQuantidadeDuasLesao || isQuantidadeTresLesao || isQuantidadeGeneralizadoLesao) &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoSim &&
        isLobularMulti &&
        isCorticalizadaDifusa &&
        isInteriorLesaoFoco &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesSim) &&
        (isImpactacaoSim || isImpactacaoNA)){
      diagnosis.add('Cistos e Tumores Odontogênicos - Fibrossarcoma Ameloblástico (Sarcoma Ameloblástico) \n\n Observações: \n - Raro no gênero feminino \n - Raro na maxila');
    }
    else if((isFemale || isMale || isGenreNotSelected ) &&
        (isCaucasian || isMelanoderma || isAsian || isIndigenous || isEtinyNotSelected) &&
        (is0to10 || is11to25 || is26to50 || isOver60) &&
        (isPainPresent || isPainNotInformed) &&
        (isParestesiaNotPresent || isParestesiaNotInformed) &&
        (isBisfosfonatosNo ||isBisfosfonatosNotApply) &&
        (isMaxila || isMandibula || isMaxilaAndMandibula) &&
        (isMolares || isRamoMandibula) &&
        isOrigemCentral &&
        (isQuantidadeUmaLesao || isQuantidadeDuasLesao || isQuantidadeTresLesao || isQuantidadeGeneralizadoLesao) &&
        (isOrigemOdontogenicaCoroa || isOrigemOdontogenicaNA || isOrigemOdontogenicaNAssociada ) &&
        (isTamanhoLesaoM || isTamanhoLesaoG) &&
        isExpansaoSim &&
        isLobularMulti &&
        isCorticalizadaDifusa &&
        isInteriorLesaoFoco &&
        (isReabsorcaoRaizesNA || isReabsorcaoRaizesSim) &&
        (isImpactacaoSim || isImpactacaoNA)){
      diagnosis.add('Cistos e Tumores Odontogênicos - Odontoameloblastoma \n\n Observações: \n - Raro no gênero feminino \n - Raro na maxila');
    }


    else
      {
        diagnosis.add('Erro');
      }

    return diagnosis;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionário',
      home: Scaffold(
        appBar: AppBar(title: const Text('Questionário')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SingleChoiceQuestion(
                question: Question('Qual o gênero biológico do paciente?', <String>['Feminino', 'Masculino', 'Não selecionado']),
                onSelect: (options) => _updateAnswer('genero', options),
              ),
              SingleChoiceQuestion(
                question: Question('Qual a etnia do paciente?', <String>['Melanoderma', 'Asiático', 'Caucasiano', 'Indígena', 'Não selecionado']),
                onSelect: (options) => _updateAnswer('etnia', options),
              ),
              SingleChoiceQuestion(
                question: Question('Qual a idade do paciente?', <String>['Entre 0 e 10 anos', 'Entre 11 e 25 anos', 'Entre 26 e 50 anos', 'Mais de 60 anos']),
                onSelect: (options) => _updateAnswer('idade', options),
              ),
              SingleChoiceQuestion(
                question: Question('O paciente apresenta dor?', <String>['Sim', 'Não', 'Não informado']),
                onSelect: (options) => _updateAnswer('dor', options),
              ),
              SingleChoiceQuestion(
                question: Question('O paciente apresenta parestesia?', <String>['Sim', 'Não', 'Não informado']),
                onSelect: (options) => _updateAnswer('parestesia', options),
              ),
              SingleChoiceQuestion(
                question: Question('O paciente faz uso de Bisfosfonatos?', <String>['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('bisfosfonatos', options),
              ),
              SingleChoiceQuestion(
                question: Question('Onde a lesão está?', <String>['Maxila', 'Mandíbula', 'Maxila e Mandíbula']),
                onSelect: (options) => _updateAnswer('localizacao', options),
              ),
              SingleChoiceQuestion(
                question: Question('Onde a lesão está localizada?', <String>['Região de incisivos', 'Região de caninos', 'Região de pré-molares', 'Região de molares', 'Ramo da mandíbula', 'ATM', 'Seios Maxilares']),
                onSelect: (options) => _updateAnswer('localizacao_local', options),
              ),
              SingleChoiceQuestion(
                question: Question('Qual a origem da lesão?', <String>['Periférica', 'Central']),
                onSelect: (options) => _updateAnswer('origem', options),
              ),
              SingleChoiceQuestion(
                question: Question('Quantas lesões existem?', <String>['Uma', 'Duas', 'Três ou mais', 'Generalizado']),
                onSelect: (options) => _updateAnswer('quantidade', options),
              ),
              SingleChoiceQuestion(
                question: Question('A lesão tem origem odontogênica?', <String>['Originaria de coroa', 'Originaria de raiz', 'Originaria de ápice', 'Elemento ausente', 'Não associada a dentes', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('odontogenica', options),
              ),
              SingleChoiceQuestion(
                question: Question('Qual o tamanho da lesão?', <String>['Menor que 2cm', 'Entre 2 e 3cm', 'Maior que 3cm']),
                onSelect: (options) => _updateAnswer('tamanho', options),
              ),
              SingleChoiceQuestion(
                question: Question('Existe expansão ou rompimento de corticais?', <String>['Sim', 'Não']),
                onSelect: (options) => _updateAnswer('expansao', options),
              ),
              SingleChoiceQuestion(
                question: Question('A lesão é lobular?', <String>['Unilocular', 'Multilocular', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('lobular', options),
              ),
              SingleChoiceQuestion(
                question: Question('A lesão é corticalizada?', <String>['Sim', 'Parcialmente corticalizada', 'Não corticalizada', 'Difusa', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('corticalizada', options),
              ),
              SingleChoiceQuestion(
                question: Question('Como é o interior da lesão?', <String>['Hiperdensa/Radiopaca', 'Hipodensa/Radiolúcida', 'Mista', 'Hipodensa/Radiolúcida com \nfocos hiperdensos/radiopacos']),
                onSelect: (options) => _updateAnswer('interior', options),
              ),
              SingleChoiceQuestion(
                question: Question('Existem reabsorção de raízes?', <String>['Sim', 'Não', 'Não se aplica']),
                onSelect: (options) => _updateAnswer('reabsorcao', options),
              ),
              SingleChoiceQuestion(
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
                      title: const Text('Possível diagnóstico'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: diagnosis
                            .map((d) => Text('$d', style: const TextStyle(fontWeight: FontWeight.bold)))
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
