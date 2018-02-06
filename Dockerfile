FROM gcr.io/google-containers/exechealthz-amd64:v1.2.0

USER root:root

<<<<<<< HEAD
RUN apk add --no-cache curl bash && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v1.7.5/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
=======
RUN apk add --no-cache curl bash jq && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v1.9.0/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
>>>>>>> c591486569f3d128ca09775107187273df85b39d
    chmod +x /usr/local/bin/kubectl && kubectl version --client && \
    curl -L https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 -o /usr/local/bin/dumb-init && \
    chmod +x /usr/local/bin/dumb-init
COPY kube-scheduler-healthcheck /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/exechealthz"]
CMD ["-port=8090", "-period=60s", "-latency=120s", "-cmd=/usr/local/bin/kube-scheduler-healthcheck" ]
