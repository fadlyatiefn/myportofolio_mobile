import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty
      ? '$label tidak boleh kosong.'
      : null;

  String? _validateUrl(String? value, {bool optional = false}) {
    final input = value?.trim() ?? '';
    if (input.isEmpty && optional) return null;
    if (input.isEmpty) return 'Project URL tidak boleh kosong.';
    final uri = Uri.tryParse(input);
    if (uri == null ||
        !uri.hasAuthority ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return 'Masukkan URL lengkap dengan http:// atau https://.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!await ensureLoggedIn(context) || !mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;
    final newProject = Project(
      projectName: _title.trim(),
      projectDesc: _description.trim(),
      techStack: _techStack.trim(),
      projectLink: _projectUrl.trim(),
      thumbnail: _projectImageUrl.trim().isEmpty
          ? null
          : _projectImageUrl.trim(),
    );

    setState(() => _isSubmitting = true);
    try {
      await context.read<ApiClient>().createProject(newProject, token: token);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Project added'),
          content: const Text('Proyek berhasil ditambahkan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context);
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi berakhir. Silakan login kembali.'),
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan proyek: ${error.message}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _textField({
    required String label,
    required String hint,
    required ValueChanged<String> onChanged,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
  }) => Padding(
    padding: const EdgeInsets.all(8),
    child: TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: onChanged,
      validator: validator,
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Add Project Form'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _textField(
              label: 'Title',
              hint: 'Project title',
              onChanged: (value) => _title = value,
              validator: (value) => _required(value, 'Title'),
            ),
            _textField(
              label: 'Description',
              hint: 'Describe the project',
              maxLines: 5,
              onChanged: (value) => _description = value,
              validator: (value) => _required(value, 'Description'),
            ),
            _textField(
              label: 'Tech Stack',
              hint: 'Flutter, Django, ...',
              onChanged: (value) => _techStack = value,
              validator: (value) => _required(value, 'Tech Stack'),
            ),
            _textField(
              label: 'Project URL',
              hint: 'https://example.com',
              onChanged: (value) => _projectUrl = value,
              validator: _validateUrl,
            ),
            _textField(
              label: 'Project Image URL (Optional)',
              hint: 'https://example.com/image.png',
              onChanged: (value) => _projectImageUrl = value,
              validator: (value) => _validateUrl(value, optional: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
