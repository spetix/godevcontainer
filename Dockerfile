ARG VARIANT=1.25.1
FROM alpine:latest

# Install make, git, curl, and bash
RUN apk add --no-cache make git curl \
    && wget https://go.dev/dl/go${VARIANT}.linux-amd64.tar.gz -O /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz \
    && addgroup -S vscode && adduser -S vscode -G vscode

ENV WORKSPACE_FOLDER=/workspace
ENV PATH /go/bin:$PATH
RUN mkdir -p $WORKSPACE_FOLDER && chown vscode:vscode $WORKSPACE_FOLDER
USER vscode
WORKDIR $WORKSPACE_FOLDER

# [Optional] Install Go tools globally as non-root user
RUN go install golang.org/x/tools/cmd/godoc@latest
RUN go install github.com/go-delve/delve/cmd/dlv@latest
