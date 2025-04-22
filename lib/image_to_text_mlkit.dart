library;

export 'src/image_processor.dart'

  if (dart.library.html) 'src/image_to_text_mlkit_stub.dart'
  if (dart.library.io) 'src/image_processor.dart';
