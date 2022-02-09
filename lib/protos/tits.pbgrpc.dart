///
//  Generated code. Do not modify.
//  source: tits/v1/tits.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tits.pb.dart' as $0;
export 'tits.pb.dart';

class TitsServiceClient extends $grpc.Client {
  static final _$getTits = $grpc.ClientMethod<$0.TitsRequest, $0.TitsResponse>(
      '/apis.tits.v1.TitsService/GetTits',
      ($0.TitsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TitsResponse.fromBuffer(value));
  static final _$vote = $grpc.ClientMethod<$0.VoteRequest, $0.TitsResponse>(
      '/apis.tits.v1.TitsService/Vote',
      ($0.VoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TitsResponse.fromBuffer(value));

  TitsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.TitsResponse> getTits($0.TitsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTits, request, options: options);
  }

  $grpc.ResponseFuture<$0.TitsResponse> vote($0.VoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$vote, request, options: options);
  }
}

abstract class TitsServiceBase extends $grpc.Service {
  $core.String get $name => 'apis.tits.v1.TitsService';

  TitsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TitsRequest, $0.TitsResponse>(
        'GetTits',
        getTits_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TitsRequest.fromBuffer(value),
        ($0.TitsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VoteRequest, $0.TitsResponse>(
        'Vote',
        vote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VoteRequest.fromBuffer(value),
        ($0.TitsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.TitsResponse> getTits_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TitsRequest> request) async {
    return getTits(call, await request);
  }

  $async.Future<$0.TitsResponse> vote_Pre(
      $grpc.ServiceCall call, $async.Future<$0.VoteRequest> request) async {
    return vote(call, await request);
  }

  $async.Future<$0.TitsResponse> getTits(
      $grpc.ServiceCall call, $0.TitsRequest request);
  $async.Future<$0.TitsResponse> vote(
      $grpc.ServiceCall call, $0.VoteRequest request);
}
