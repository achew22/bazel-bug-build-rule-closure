FROM ubuntu:14.04

# Install the package that provides add-apt-repository
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common

# Install a PPA that has Java8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git pkg-config zip g++ zlib1g-dev unzip

# Agree to the oracle java 8 installer terms of service... reluctantly
RUN echo debconf shared/accepted-oracle-license-v1-1 select true \
    | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true \
    | sudo debconf-set-selections

# Install that problem-child known as java8 with its installer prompts
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer

# Clone bazel into /bazel
# NOTE: using a fork until https://bazel-review.googlesource.com/2070 is
# merged and pushed to github
RUN git clone https://github.com/achew22/bazel /bazel

# Compile bazel and install it in /usr/bin which will make it available to
# test.sh. Use ; do separate compile and true so that compile exiting with
# a non-zero exit code will not stop true from running and then true will
# prevent docker from thinking the build failed.
RUN (cd /bazel && ./compile.sh; true)

# Since the compile never really finishes you have to run 
# init_workspace.sh manually
RUN (cd /bazel && WORKSPACE_DIR=/bazel /bazel/scripts/bootstrap/init_workspace.sh)

# Load in the bazelrc that is in this repo
ADD bazelrc /root/.bazelrc

# Make a directory to hold our test data
RUN mkdir /data

# Add our data to that directory
ADD . /data

# Run the test and watch it blow up
CMD /bin/bash /data/test.sh
