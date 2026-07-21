---
course: "作りながら覚えるMicrosoft Azure入門講座（IaaS編）"
url: "https://www.udemy.com/course/microsoft-azure-iaas-part"
lecture: "仮想マシンの停止と開始"
---

## 🎯 Mission

Azure ポータルで仮想マシンを停止・開始する手順を確認してみましょう。

> [!CAUTION]
> このラボは Udemy のコース内ラボ環境 (ワークスペース) でのみ実施してください。<br>
> ご自身の Azure サブスクリプションなどコース外の環境で実施すると、リソースの利用料金が発生します。<br>
> コース外の環境で発生した課金について、講師は一切の責任を負いかねますのであらかじめご了承ください。

## 🚀 Challenge

### 事前準備

1. Windows 仮想マシンを作成します。([手順](https://github.com/m-oka-system/udemy-in-course-labs/blob/main/microsoft-azure-iaas-part/create-windows-vm.md))

> [!NOTE]
> 前のレクチャーで学んだ手順のおさらいとして、もう一度仮想マシンを作成してみましょう。

### 仮想マシンの停止

1. 左側メニューの [仮想マシン] をクリックします。
2. 作成済みの仮想マシン `w-iaas-vm` をクリックします。
3. 概要ページの [停止] をクリックします。
4. 確認メッセージが表示されるので [はい] をクリックします。
5. しばらくして、仮想マシンの状態が [停止済み (割り当て解除)] に変わったことを確認します。

### 仮想マシンの開始

1. 概要ページの [開始] をクリックします。
2. しばらくして、仮想マシンの状態が [実行しています] に変わったことを確認します。

> [!NOTE]
> 開始操作の時には確認メッセージは表示されません。

### 参考 URL

- https://learn.microsoft.com/ja-jp/azure/virtual-machines/windows/tutorial-manage-vm#vm-power-states
