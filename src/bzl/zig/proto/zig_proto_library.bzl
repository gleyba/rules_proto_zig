"Definition of zig_proto_library."

load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoPluginInfo",
    "bazel_build_rule_common_attrs",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create compile rule
zig_proto_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("//src/bzl/zig/proto:proto_plugin"),
            ],
            cfg = "exec",
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = ["@rules_proto_grpc//protoc:toolchain_type"],
)

def zig_proto_library(name, **kwargs):
    name_pb = name + "_pb"
    zig_proto_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if (k in proto_compile_attrs.keys() and k != "prefix_path") or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )
