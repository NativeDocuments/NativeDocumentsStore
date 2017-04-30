# To build it manually:
# sudo docker build -t nativedocumentsstore .
# sudo docker run -d -P -v nddata:/nddata --name ndstore nativedocuments/nativedocumentsstore
# sudo docker run -d -p 6000:6000 -v ~/nds.license:/opt/NativeDocumentsStore/nds.license --name ndstore nativedocuments/nativedocumentsstore

FROM busybox:musl
ADD http://downloads.nativedocuments.com/NativeDocumentsStore.tar.gz /tmp/
VOLUME ["/nddata"]
RUN mkdir /opt
RUN tar xzf /tmp/NativeDocumentsStore.tar.gz -C /opt
RUN rm -f /tmp/NativeDocumentsStore.tar.gz
ENV NDS_LOG_FILE=/dev/stdout
ENV NDS_LOG_DIR=/nddata/log/NativeDocumentsStore
ENV NDS_CONVERTER_DOCUMENTS_DIR=/nddata/storage
ENV NDS_BASE_DIR=/nddata/storage
ENV NDS_MAX_CONNECTIONS=500
ENV NDS_VERBOSE=2
ENTRYPOINT ["/bin/sh", "-c", "mkdir -p /nddata/storage; mkdir -p /nddata/log/NativeDocumentsStore; exec /opt/NativeDocumentsStore/ndstored service=0.0.0.0:6000"]
EXPOSE 6000
