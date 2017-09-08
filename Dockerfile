FROM bangaloretalkies/tensorflow:latest

MAINTAINER Sandeep Prakash <123sandy@gmail.com>

WORKDIR /tensorflow/tensorflow/examples
RUN git clone https://github.com/corehacker/ch-tf-label-image-client.git


WORKDIR /tensorflow
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

WORKDIR /root
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' >> ~/.bashrc


# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR /tensorflow
CMD ["/bin/bash"]
