FROM docker.io/library/alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder

ARG TARGETPLATFORM

WORKDIR /workspace

COPY dist/${TARGETPLATFORM}/kube-green .
COPY LICENSE .

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace/kube-green .
USER 65532:65532

ENTRYPOINT ["/kube-green"]
