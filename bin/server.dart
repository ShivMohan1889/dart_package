import 'dart:convert';
import 'dart:io';

import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/generate_pdf', _pdfHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> _pdfHandler(Request request) async {
  TbPdfHelper().loadPdfMemoryImages();
// Decode the JSON data from the request body
  var jsonString = await request.readAsString();
  print("body:$jsonString");
  var dto = AuditAssessmentDto.fromJsonString(jsonString);
  var h = TbPdfHelper();
  String aPath = "../a.pdf";
  TbAuditPdfGenerator generator = TbAuditPdfGenerator(
    pathToWritePDF: aPath,
    pdfHelper: h,
    platFormLocaleName: Platform.localeName,
    auditAssessmentEntity: dto,
  );
  generatePDF(generator);
  return Response.ok('PDF generated:');
}

Future<void> generatePDF(TbAuditPdfGenerator generator) async {
  await generator.generatePDF();
  return;
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
