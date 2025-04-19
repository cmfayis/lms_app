import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_app/blocs/module/bloc/module_bloc.dart';
import 'package:lms_app/data/api_client.dart';
import 'package:lms_app/model/module.dart';
import 'package:lms_app/presentation/video_page.dart';

class ModulePage extends StatelessWidget {
  final int subjectId;

  const ModulePage({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ModuleBloc(ApiClient())..add(FetchModules(subjectId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Modules'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ModuleBloc, ModuleState>(
      listener: (context, state) {
        if (state is ModuleError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ModuleLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ModuleLoaded) {
          return _buildModuleGrid(state.modules);
        }
        return const Center(child: Text('No modules found'));
      },
    );
  }

  Widget _buildModuleGrid(List<Module> modules) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8, // Adjusted for better vertical space
        ),
        itemCount: modules.length,
        itemBuilder: (context, index) => _ModuleCard(module: modules[index]),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final Module module;

  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoListScreen(moduleId: module.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.video_library,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                module.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Expanded(
                child: Text(
                  module.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_right, color: Colors.blue, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
