"""zig protobuf rules."""

load(
    "//src/bzl/zig/proto:zig_proto_library.bzl",
    _zig_proto_library = "zig_proto_library",
)

zig_proto_library = _zig_proto_library
