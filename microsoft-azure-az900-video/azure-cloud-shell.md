---
course: "合格への近道！Azure Fundamentals AZ-900 試験対策講座"
url: "https://www.udemy.com/course/microsoft-azure-az900-video"
lecture: "Azure Cloud Shell"
---

## 🎯 Mission

Azure Cloud Shell を起動してコマンドを実行する方法を確認してみましょう。

## 🚀 Challenge

### Azure Cloud Shell の起動

1. Azure Cloud Shell を起動します。([手順](https://github.com/m-oka-system/udemy-in-course-labs/blob/main/docs/how-to-launch-azure-cloud-shell.md))

   <img width="1158" height="272" alt="Image" src="https://github.com/user-attachments/assets/6f7b86ab-3c2b-40ef-bb78-6b9c8f8170c3" />

### リソースグループ一覧の確認 (Bash)

1. 次のコマンドを実行します。

```bash
az group list -o table
```

2. リソースグループの一覧がテーブル形式で表示されることを確認します。

```bash
# 出力例
Name              Location    Status
----------------  ----------  ---------
Regroup_1k0Tp5CZ  westus      Succeeded
```

### PowerShell に切り替え

1. Cloud Shell 左上の [切り替え先 PowerShell] をクリックします。
2. 確認メッセージが表示されるので [確認] をクリックします。
3. PowerShell に切り替わったことを確認します。(左上の表示が [切り替え先 Bash] に変わる)

### リソースグループ一覧の確認 (PowerShell)

1. 次のコマンドを実行します。

```powershell
Get-AzResourceGroup | Format-Table ResourceGroupName, Location, ProvisioningState
```

2. リソースグループの一覧がテーブル形式で表示されることを確認します。

```powershell
# 出力例
ResourceGroupName Location ProvisioningState
----------------- -------- -----------------
Regroup_1k0Tp5CZ  westus   Succeeded
```

### その他の操作

- Cloud Shell 右上の [最大化] (真ん中) をクリックすると画面いっぱいにターミナル画面が表示されます。(ポータル画面が隠れる)
- 最大化した状態で右上の [復元] (真ん中) をクリックすると元の大きさに戻ります。
- Cloud Shell 右上の [最小化] (左) をクリックするとターミナル画面が最小化されます。
- 最小化した状態で Azure ポータル右上の [Cloud Shell] アイコンをクリックすると元の画面に戻ります。
- Cloud Shell 右上の [閉じる] (右) をクリックするとターミナル画面が終了します。
- ターミナル画面上部にあるツールバーではシェル環境の切り替え以外にも様々な操作が可能です (再起動、ファイルのアップロード・ダウンロード、テキストサイズやフォントの変更など)

### 参考 URL

- https://learn.microsoft.com/ja-jp/azure/cloud-shell/overview
- https://learn.microsoft.com/ja-jp/azure/cloud-shell/get-started/ephemeral
