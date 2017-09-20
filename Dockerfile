FROM bangaloretalkies/tensorflow-ch-base:latest

MAINTAINER Sandeep Prakash <123sandy@gmail.com>

WORKDIR /root
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' >> ~/.bashrc

WORKDIR /corehacker
RUN export LD_LIBRARY_PATH=/usr/local/lib && \
    git clone https://github.com/corehacker/ch-protos.git && \
    cd ch-protos && \
    autoreconf --install && \
    ./configure && \
    make && \
    make install && \
    cd ..

WORKDIR /tensorflow/tensorflow/examples
RUN git clone https://github.com/corehacker/ch-tf-label-image-client.git


WORKDIR /tensorflow
RUN sed -i.bak 's/6d43b9d223ce09e5d4ce8b0060cb8a7513577a35a64c7e3dad10f0703bf3ad93/e5fdeee6b28cf6c38d61243adff06628baa434a22b5ebb7432d2a7fbabbdb13d/g' tensorflow/workspace.bzl''
RUN bazel build tensorflow/examples/ch-tf-label-image-client/...

RUN cd tensorflow/examples/ch-tf-label-image-client && \
    mkdir data && \
    cd data && \
    curl -L \
    "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz" \
    -o inception_v3_2016_08_28_frozen.pb.tar.gz && \
    tar xvf inception_v3_2016_08_28_frozen.pb.tar.gz && \
    cp ../../label_image/data/*.jpg . && \
    cd /tensorflow

WORKDIR /corehacker
RUN export LD_LIBRARY_PATH=/usr/local/lib && \
    git clone https://github.com/corehacker/ch-indexing-service.git && \
    cd ch-indexing-service && \
    autoreconf --install && \
    ./configure && \
    make && \
    make install && \
    cd ..

WORKDIR /tensorflow

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR /tensorflow
CMD ["/bin/bash"]
