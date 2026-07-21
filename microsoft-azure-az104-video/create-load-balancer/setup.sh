#!/usr/bin/env bash
set -euo pipefail

OWNER="m-oka-system"
REPO="udemy-in-course-labs"

# リポジトリを取得（既にディレクトリが存在する場合はスキップ）
if [ ! -d "$REPO" ]; then
  git clone --depth 1 "https://github.com/${OWNER}/${REPO}.git"
fi
cd "$REPO/microsoft-azure-az104-video/create-load-balancer"

# 既存のリソースグループ名を取得
RG_NAME="$(az group list --query "[0].name" -o tsv)"

# リソースグループ名を渡してリソースを作成
terraform init && terraform apply --auto-approve -var="resource_group_name=${RG_NAME}"
