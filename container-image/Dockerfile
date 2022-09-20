FROM node:14-alpine3.16

ENV TFENV_PATH=/usr/local/bin/tfenv
ENV TFENV_APP_VERSION=v3.0.0

ENV TFSEC_PATH=/usr/local/bin/tfsec
ENV TFSEC_VERSION=1.27.5

ENV TFLINT_PATH=/usr/local/bin/tflint
ENV TFLINT_VERSION=v0.39.3

ENV PATH=${TFENV_PATH}/bin:${TFSEC_PATH}:${TFLINT_PATH}:${PATH}

RUN apk --no-cache add --virtual .pipeline-deps readline=8.1.2-r0 linux-pam=1.5.2-r0 \
    && apk --no-cache add bash=5.1.16-r2 sudo=1.9.10-r0 shadow=4.10-r3 curl=7.83.1-r3 \
    && curl -L -o tfenv.tar.gz https://github.com/tfutils/tfenv/archive/refs/tags/${TFENV_APP_VERSION}.tar.gz; mkdir -p ${TFENV_PATH}; tar --strip-components=1 -xvzf tfenv.tar.gz -C ${TFENV_PATH}; rm -f tfenv.tar.gz \
    && curl -L -o tfsec.tar.gz https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_${TFSEC_VERSION}_linux_amd64.tar.gz; mkdir -p ${TFSEC_PATH}; tar -xvzf tfsec.tar.gz -C ${TFSEC_PATH}; rm -f tfsec.tar.gz \
    && curl -L -o tflint.zip https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip; mkdir -p ${TFLINT_PATH}; unzip tflint.zip -d ${TFLINT_PATH}; rm -f tflint.zip \
    && apk del .pipeline-deps

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

CMD [ "node" ]
# https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases?view=azure-devops