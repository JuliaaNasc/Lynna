import 'package:flutter/material.dart';

class OpcoesController extends ChangeNotifier {
  final List<String> opcoes = [
    'Todos',
    'Shoppings',
    'Universidades',
    'Aeroportos',
    'Parques',
    'Hospitais',
  ];

  final Map<String, List<Map<String, String>>> _subopcoes = {
    'Todos': [{}],
    'Shoppings': [
      {
        'titulo': 'Shopping Iguatemi',
        'descricao':
            'Av. Washington Soares, 85 - Edson Queiroz, Fortaleza - CE, 60811-341',
      },
      {
        'titulo': 'Shopping Parangaba',
        'descricao':
            'Av. Dom Almeida Lustosa, 2000 - Parangaba, Fortaleza - CE, 60740-000',
      },
      {
        'titulo': 'Shopping Benfica',
        'descricao': 'R. Carapinima, 2200 - Benfica, Fortaleza - CE, 60015-290',
      },
      {
        'titulo': 'Shopping Del Passeo',
        'descricao':
            'Av. Santos Dumont, 3131 - Aldeota, Fortaleza - CE, 60150-165',
      },
      {
        'titulo': 'Shopping Rio Mar Fortaleza',
        'descricao':
            'R. Des. Lauro Nogueira, 1500 - Papicu, Fortaleza - CE, 60175-055',
      },
      {
        'titulo': 'Shopping Rio Mar Kennedy',
        'descricao':
            'Av. Srg. Hermínio Sampaio, 3100 - Pres. Kennedy, Fortaleza - CE, 60355-512',
      },
      {
        'titulo': 'Shopping Jóquei',
        'descricao':
            'Av. Lineu Machado, 419 - Jóquei Clube, Fortaleza - CE, 60520-102',
      },
      {
        'titulo': 'Shopping Via Sul',
        'descricao':
            'Av. Washington Soares, 4335 - Lagoa Sapiranga (Coité), Fortaleza - CE, 60833-005',
      },
      {
        'titulo': 'North Shopping Fortaleza',
        'descricao':
            'Av. Bezerra de Menezes, 2450 - Pres. Kennedy, Fortaleza - CE, 60325-002',
      },
    ],
    'Universidades': [
      {
        'titulo': 'Universidade Federal',
        'descricao': 'Ensino público e gratuito.',
      },
      {
        'titulo': 'Universidade Particular',
        'descricao': 'Ensino privado e com cursos diversos.',
      },
    ],
    'Aeroportos': [
      {
        'titulo': 'Aeroporto Internacional',
        'descricao': 'Conexões para o mundo todo.',
      },
      {'titulo': 'Aeroporto Regional', 'descricao': 'Atende voos domésticos.'},
    ],
    'Parques': [
      {
        'titulo': 'Parque Natural',
        'descricao': 'Áreas verdes para lazer e contato com a natureza.',
      },
      {
        'titulo': 'Parque Temático',
        'descricao': 'Diversão para toda a família.',
      },
    ],
    'Hospitais': [
      {'titulo': 'Hospital Geral', 'descricao': 'Atendimento emergencial 24h.'},
      {
        'titulo': 'Hospital Especializado',
        'descricao': 'Tratamento para doenças específicas.',
      },
    ],
  };

  String _opcaoSelecionada = 'Shoppings';

  String get opcaoSelecionada => _opcaoSelecionada;

  void selecionarOpcao(String opcao) {
    _opcaoSelecionada = opcao;
    notifyListeners();
  }

  // Retorna todas as subopções de todas as categorias exceto 'Todos'
  List<Map<String, String>> get todasSubopcoes {
    List<Map<String, String>> todas = [];
    _subopcoes.forEach((key, value) {
      if (key != 'Todos') {
        todas.addAll(value);
      }
    });
    return todas;
  }

  // Retorna as subopções da categoria selecionada, ou todas se for "Todos"
  List<Map<String, String>> get subopcoesSelecionadas {
    if (_opcaoSelecionada == 'Todos') {
      return todasSubopcoes;
    }
    return _subopcoes[_opcaoSelecionada] ?? [];
  }

  // Pega a primeira subopção para mostrar um resumo ou info inicial
  Map<String, String> get primeiraSubopcao {
    final lista = subopcoesSelecionadas;
    if (lista.isNotEmpty) {
      return lista.first;
    }
    return {
      'titulo': _opcaoSelecionada,
      'descricao': 'Descrição não disponível.',
    };
  }
}
