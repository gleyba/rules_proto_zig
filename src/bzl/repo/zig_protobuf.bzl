"Rule to initialize zig protobuf compiler plugin"

_BUILD_CONTENT = """\
load("@rules_zig//zig:defs.bzl", "zig_package")

zig_package(
    name = "protobuf",
    main = "src/protobuf.zig",
    visibility = [
        "//visibility:public",
    ],
)
"""

_GENERATOR_BUILD_CONTENT = """\
load("@rules_zig//zig:defs.bzl", "zig_binary")

zig_binary(
    name = "bootstrapped-generator",
    srcs = [
        "FullName.zig",
        "google/protobuf.pb.zig",
        "google/protobuf/compiler.pb.zig",
    ],
    main = "main.zig",
    visibility = [
        "//visibility:public",
    ],
    deps = [
        "//:protobuf",
    ],
)

"""

def _zig_protobuf_impl(rctx):
    rctx.download_and_extract(
        url = "https://github.com/Arwalk/zig-protobuf/archive/refs/tags/v%s.zip" % rctx.attr.version,
        sha256 = rctx.attr.sha256,
        stripPrefix = "zig-protobuf-%s" % rctx.attr.version,
    )
    rctx.file("BUILD.bazel", _BUILD_CONTENT)
    rctx.file("bootstrapped-generator/BUILD.bazel", _GENERATOR_BUILD_CONTENT)

zig_protobuf = repository_rule(
    implementation = _zig_protobuf_impl,
    attrs = {
        "version": attr.string(default = "1.0.2"),
        "sha256": attr.string(default = "02bce1e56ddad5510c852d80870e4fced0bc930b0a107d231ae143bc04803d78"),
    },
)
