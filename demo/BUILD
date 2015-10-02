load("/tools/build_rules/closure/closure_js_binary", "closure_js_binary")
load("/tools/build_rules/closure/closure_js_library", "closure_js_library")
load("/tools/build_rules/closure/closure_stylesheet_library", "closure_stylesheet_library")
load("/tools/build_rules/closure/closure_template_library", "closure_template_library")

closure_js_binary(
    name = "hello",
    main = "hello",
    deps = [":hello_lib"],
)

closure_js_library(
    name = "hello_lib",
    srcs = ["hello.js"],
    deps = [
        "@closure_library//:closure_library",
        "@closure_templates//:closure_templates_js",
        ":hello_css",
        ":hello_soy",
    ]
)

closure_stylesheet_library(
    name = "hello_css",
    srcs = ["hello.gss"],
    deps = ["@closure_library//:closure_library_css"],
)

closure_template_library(
    name = "hello_soy",
    srcs = ["hello.soy"],
)
