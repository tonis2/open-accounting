import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

import 'config.dart';

ClientChannelBase createChannel(ConfigurationEnvironment config) {
  return GrpcWebClientChannel.xhr(config.serverUri);
}
