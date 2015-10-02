#Bug reproduction for Bazel

This is a reproduction of a bug that I believe is in Bazel.

Bug report: https://github.com/bazelbuild/bazel/issues/491

## Bug description

It appears that package path is not respected for the 
[closure build rules](https://github.com/bazelbuild/bazel/tree/master/tools/build_rules/closure).

After copying the `closure.WORKSPACE` file into an empty directory and creating
the sample BUILD, soy, gss, and js files, building the hello target defined in
the sample `BUILD`, I get the following error:

```
ERROR: /data/demo/BUILD:1: Extension file not found: 'tools/build_rules/closure/closure_stylesheet_library.bzl
ERROR: error loading package 'demo': Extension file not found: 'tools/build_rules/closure/closure_stylesheet_library.bzl'.
```

For some reason it appears the package\_path is not being respected.

For your convenience I have created a Docker image in a git repo which
should exhibit this behavior in a reproducable way.

## Reproduction steps

> NOTE: This is running with a 
  [single, trivial, commit](https://github.com/achew22/bazel/commit/544d0b0a5024e8920c32aa738ff0b75eb7510c7c)
  that is *NOT* in the bazelbuild/bazel repo. This commit makes it possible to
  build Bazel in a Docker image.

```bash
cd `mktemp -d /tmp/bazellbug.XXXXXXX`
git clone https://github.com/achew22/bazel-bug-build-rule-closure
cd bazel-bug-build-rule-closure
docker build --tag="bazel-bug-build-rule-closure" .
docker run -it bazel-bug-build-rule-closure
```

