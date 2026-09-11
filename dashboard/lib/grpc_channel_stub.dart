import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

import 'config.dart';

ClientChannelBase createChannel(ConfigurationEnvironment config) {
  return ClientChannel(
    config.host,
    port: config.port,
    options: ChannelOptions(
      credentials: config.isSecure ? const ChannelCredentials.secure() : const ChannelCredentials.insecure(),
      codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      connectionTimeout: const Duration(seconds: 10),
    ),
  );
}
