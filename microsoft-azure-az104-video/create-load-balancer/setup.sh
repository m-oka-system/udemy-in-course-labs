#!/usr/bin/env bash
set -euo pipefail

OWNER="m-oka-system"
REPO="udemy-in-course-labs"

# リポジトリを取得（既にディレクトリが存在する場合はスキップ）
if [ ! -d "$REPO" ]; then
  git clone --depth 1 "https://github.com/${OWNER}/${REPO}.git"
fi
cd "$REPO/microsoft-azure-az104-video/create-load-balancer"

RG_NAME="${RG_NAME:-}"

# 環境変数 RG_NAME が未設定なら既存の唯一のリソースグループを使用
if [ -z "$RG_NAME" ]; then
  # リソースグループの数を取得
  RG_COUNT="$(az group list --query "length(@)" -o tsv)"

  # リソースグループが 1 つだけ存在する場合はコース内ラボ環境とみなす
  if [ "$RG_COUNT" -eq 1 ]; then
    RG_NAME="$(az group list --query "[0].name" -o tsv)"
  else
    echo "エラー: リソースグループを特定できませんでした (現在 ${RG_COUNT} 個)。" >&2
    echo "環境変数 RG_NAME にリソースグループ名を設定して再実行してください。" >&2
    echo "例: export RG_NAME=\"MyResourceGroup\"" >&2
    exit 1
  fi
fi

# 指定されたリソースグループが存在するか確認する
if [ "$(az group exists --name "$RG_NAME")" != "true" ]; then
  echo "エラー: リソースグループ '${RG_NAME}' が見つかりません。" >&2
  echo "RG_NAME の指定に誤りがないか確認してください。" >&2
  exit 1
fi

# リソースグループ名を渡してリソースを作成
terraform init && terraform apply --auto-approve -var="resource_group_name=${RG_NAME}"
