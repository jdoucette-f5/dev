# container for project devops work

# Alpine -- Latest version here: https://alpinelinux.org/releases/
FROM alpine:3.13.0

# AWS CLI -- Latest version here: https://github.com/aws/aws-cli/releases
ENV AWSCLI_VERSION 1.18.216

# Kubectl -- Latest version here: https://github.com/kubernetes/kubectl/releases
ENV KUBE_VERSION v1.20.2

# Helm -- Latest version here: https://github.com/helm/helm/releases
ENV HELM_VERSION v3.5.0

# Terraform -- Latest version here: https://releases.hashicorp.com/terraform/
ENV TERRAFORM_VERSION 0.14.4

RUN apk --update add --no-cache \
  vim \
  bash \
  ca-certificates \
  curl \
  jq \
  git \
  openssh-client \
  less \
  python3 \
  tar \
  wget \
  py3-pip

# Install AWSCLI
RUN pip3 install --upgrade pip
RUN pip3 install requests awscli==${AWSCLI_VERSION} && aws --version

# Install Kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && kubectl version --client

# Install Helm
RUN wget -q https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm \
  && helm help
# Todo: then install stable repo $ helm repo add stable https://charts.helm.sh/stable

# Install Terraform
RUN cd /usr/local/bin && \
  curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  terraform -help

ENTRYPOINT ["/bin/bash"]
