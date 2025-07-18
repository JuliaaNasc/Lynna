import 'package:flutter/material.dart';

class OpcoesController extends ChangeNotifier {
  final List<String> opcoes = [
    'Shoppings',
    'Universidades',
    'Aeroportos',
    'Parques',
    'Hospitais',
  ];

  final Map<String, List<Map<String, String>>> _subopcoes = {
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
      {'titulo': 'Outlet', 'descricao': 'Loja com descontos especiais.'},
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

  List<Map<String, String>> get subopcoesSelecionadas =>
      _subopcoes[_opcaoSelecionada] ?? [];

  // Método para pegar o título e descrição da primeira subopção
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
