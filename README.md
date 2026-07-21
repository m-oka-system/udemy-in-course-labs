# udemy-in-course-labs

Udemy の Azure 関連講座で使用するコース内ラボ (演習) の手順書と、ラボ環境の構築に使う Terraform コードをまとめたリポジトリです。

> [!CAUTION]
> 本リポジトリのラボは、Udemy のコース内ラボ環境 (ワークスペース) での実施を前提としています。
> ご自身の Azure サブスクリプションなど、コース外の環境で実施するとリソースの利用料金が発生します。
> コース外の環境で発生した課金について、講師は一切の責任を負いかねますのであらかじめご了承ください。

## 対象コース

| コース名                                                                                                                    | ディレクトリ                                                   |
| --------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| [はじめての Microsoft Azure](https://www.udemy.com/course/microsoft-azure-introduction)                                     | [microsoft-azure-introduction](./microsoft-azure-introduction) |
| [作りながら覚える Microsoft Azure 入門講座（IaaS 編）](https://www.udemy.com/course/microsoft-azure-iaas-part)              | [microsoft-azure-iaas-part](./microsoft-azure-iaas-part)       |
| [合格への近道！Azure Fundamentals AZ-900 試験対策講座](https://www.udemy.com/course/microsoft-azure-az900-video)            | [microsoft-azure-az900-video](./microsoft-azure-az900-video)   |
| [合格への近道！Azure Administrator Associate AZ-104 試験対策講座](https://www.udemy.com/course/microsoft-azure-az104-video) | [microsoft-azure-az104-video](./microsoft-azure-az104-video)   |

## リポジトリ構成

```
.
├── docs/                          # 共通の手順書 (Cloud Shell の起動方法など)
├── microsoft-azure-introduction/  # 「はじめての Microsoft Azure」のラボ
├── microsoft-azure-iaas-part/     # 「Azure 入門講座（IaaS編）」のラボ
├── microsoft-azure-az900-video/   # AZ-900 対策講座のラボ
├── microsoft-azure-az104-video/   # AZ-104 対策講座のラボ
└── modules/                       # ラボ環境構築用の Terraform モジュール
```

## Terraform について

`modules/` には、ラボ環境で使用する Azure リソース (VNet, Subnet, NSG, VM, Key Vault など) を作成する再利用可能な Terraform モジュールが含まれています。

各ラボの手順書内で、対応する `setup.sh` を Azure Cloud Shell 上で実行することで、ラボに必要なリソースを事前に構築することができます。

```bash
curl -fsSL https://raw.githubusercontent.com/m-oka-system/udemy-in-course-labs/refs/heads/main/<lab-path>/setup.sh | bash
```
