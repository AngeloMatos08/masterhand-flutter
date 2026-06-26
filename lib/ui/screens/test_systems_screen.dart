import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/local/app_database.dart';

class TestSystemsScreen extends StatefulWidget {
  const TestSystemsScreen({super.key});

  @override
  State<TestSystemsScreen> createState() => _TestSystemsScreenState();
}

class _TestSystemsScreenState extends State<TestSystemsScreen> {
  late Future<List<System>> _systemsFuture;

  @override
  void initState() {
    super.initState();
    final db = context.read<AppDatabase>();
    _systemsFuture = db.select(db.systems).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistemas Disponíveis (Teste)'),
        elevation: 0,
      ),
      body: FutureBuilder<List<System>>(
        future: _systemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar sistemas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          final systems = snapshot.data ?? [];

          if (systems.isEmpty) {
            return const Center(
              child: Text('Nenhum sistema disponível no banco de dados'),
            );
          }

          return ListView.builder(
            itemCount: systems.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
          try {
            return SystemCard(system: systems[index]);
          } catch (e) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text('Erro no sistema ${systems[index].id}'),
                subtitle: Text(e.toString()),
              ),
            );
          }
        },
          );
        },
      ),
    );
  }
}

class SystemCard extends StatelessWidget {
  final System system;

  const SystemCard({super.key, required this.system});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(system.title),
        subtitle: Text(
          system.description.length > 100
              ? '${system.description.substring(0, 100)}...'
              : system.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (system.price != null)
              Text(
                'R\$ ${system.price!.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(width: 8),
            Icon(
              system.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: system.isFavorite ? Colors.red : null,
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(system.title),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (system.cover != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          system.cover!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      'Descrição:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(system.description),
                    const SizedBox(height: 12),
                    Text(
                      'Loja: ${system.storeName}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (system.price != null)
                      Text(
                        'Preço: R\$ ${system.price!.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    Text(
                      'Favorito: ${system.isFavorite ? 'Sim' : 'Não'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}