"Extensions for bzlmod"

load(":zig_protobuf.bzl", "zig_protobuf")

def _zig_proto_impl(_mctx):
    zig_protobuf(name = "zig_protobuf")

zig_proto = module_extension(implementation = _zig_proto_impl)
