#!/usr/bin/env bash

set -euo pipefail

# comes from flop itself as an exported function
find_this "${BASH_SOURCE[0]}"

export FLOP_LIB="${THIS}"
export LIB_DIR="${THIS_DIR}"
FLOP_GETOPT="${LIB_DIR}/lib.d/getopt.bash"
FLOP_COMMANDS="${LIB_DIR}/commands"
FLOP_PREFIX='flop-'

TF_DIR="${TF_DIR:-"$(cd -P -- "${LIB_DIR}/.." && pwd)"}"
TF_VARFILE="${TF_VARFILE:-"${TF_DIR}/flop.tfvars"}"
TF_STATE_DIR="${TF_DIR}/terraform.tfstate.d"
mkdir -p "${TF_STATE_DIR}"


set_vars () {
    export FLOP_CLUSTER="${1:?need to provide flop cluster name}"
    TF_WORKSPACE="${FLOP_CLUSTER}"
    TF_WORKSPACE_DIR="${TF_STATE_DIR}/${FLOP_CLUSTER}"
    FLOP_PORT_FILE="${TF_WORKSPACE_DIR}/port-mappings"

    export KUBECONFIG="${TF_WORKSPACE_DIR}/kubeconfig"

    ! [ -f "${FLOP_PORT_FILE}" ] || . "${FLOP_PORT_FILE}"
    export FLOP_HTTP_PORT="${FLOP_HTTP_PORT:-"$(random_port)"}"
    export FLOP_HTTPS_PORT="${FLOP_HTTPS_PORT:-"$(random_port)"}"
}


random_port () {
    local min="${1:-30000}"
    local max="${2:-32767}"
    local seed="${3:-$RANDOM}"
    local bash_max_rand=32767

    [ "${min}" -ge 1025 ] || fatal "Minimum port supported is 1025"
    [ "${max}" -le 65535 ] || fatal "Maximum port supported is 65535"
    [ "${min}" -lt "${max}" ] || fatal "Minimum port must be lower than maximum"
    { [ "${seed}" -ge 0 ] && [ "${seed}" -le "${bash_max_rand}" ]; } || {
        fatal "Seed must be greater than 0 but less than ${bash_max_rand}"
    }

    awk "BEGIN{srand(); print int(${seed} / ${bash_max_rand} * (${max} - ${min})) + ${min} }"
}


echo2 () {
    local msg="${1?message string required}"
    echo -e >&2 "${msg:-}"
}


fatal () {
    local msg="${1?message string required}"; shift
    local rc=${1:-1}
    echo2 "${msg:-}"
    exit "$rc"
}


get_cluster_type () {
    kubectl config get-clusters | grep "${FLOP_CLUSTER}" | cut -d '-' -f 1
}


kind_cleanup () {
    kind delete cluster --name "${FLOP_CLUSTER}"
    rm -rf "${TF_WORKSPACE_DIR}"
}



k3d_cleanup () {
    k3d cluster delete "${FLOP_CLUSTER}"
    rm -rf "${TF_WORKSPACE_DIR}"
}


persist_port_mapping() {
    cat > "${FLOP_PORT_FILE}" <<EOF
FLOP_HTTP_PORT=${FLOP_HTTP_PORT}
FLOP_HTTPS_PORT=${FLOP_HTTPS_PORT}
EOF
}


kind_create () {
    kind create cluster \
        --name "${FLOP_CLUSTER}" \
        --image "kindest/node:v${K8S_VERSION}" \
        --config <(cat <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: ${FLOP_HTTP_PORT}
    hostPort: ${FLOP_HTTP_PORT}
  - containerPort: ${FLOP_HTTPS_PORT}
    hostPort: ${FLOP_HTTPS_PORT}
EOF
    )
}


k3d_create () {
    k3d cluster create "${FLOP_CLUSTER}" \
        --image "rancher/k3s:v${K8S_VERSION}-k3s1" \
        -p "${FLOP_HTTP_PORT}:${FLOP_HTTP_PORT}@server:0" \
        -p "${FLOP_HTTPS_PORT}:${FLOP_HTTPS_PORT}@server:0" \
        --k3s-arg "--disable=traefik@server:*"
}


find_all_flops () {
    find "${TF_STATE_DIR}" -type d -name "${FLOP_PREFIX}*" -exec basename {} \;
}
