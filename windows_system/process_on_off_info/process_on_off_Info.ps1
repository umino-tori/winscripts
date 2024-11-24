# 
# 当該ソースの文字コードはUTF-8 whith BOM としています。
# 
# -----------------------------------------------------------------------------
# Author: umino-tori
# Date: 2024-11-22
# Description:  README.mdファイルを確認ねがいます。
# -----------------------------------------------------------------------------

#★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
# ログファイルを格納するフォルダ
$data_home = "Z:\xxxxxxxxxxxxxxxx\yyyyyyyyyyyyyyy" # ★★使用される方のPCにあわせて設定してください★★
#★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

# 実行環境が整っていないなら処理終了
if (-not (Test-Path $data_home)){
    Write-Host "ログ保存フォルダ $data_home が存在しません。`n（ログ保存フォルダを予め作成しておいてください)。`n一旦処理終了します。"
    # Write-Host "ログ保存のフォルダ$data_home"
    Exit
}

# 前回のプロセスリストを保持
$script:prevVisibleProcesses = $null

# 表示中アプリを取得する関数
function Get-VisibleApps {
    Get-Process | Where-Object { $_.MainWindowTitle -ne "" } | Select-Object -Property Id, Name, MainWindowTitle
}

# プロセスの状態を記録する関数
function Log-VisibleApps {
    
    # 現在の表示中プロセスを取得
    $currentVisibleProcesses = @{}
    $visibleApps = Get-VisibleApps
    foreach ($app in $visibleApps) {
        $currentVisibleProcesses[$app.Id] = $app
    }
    # 現在時刻を取得
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # ログファイルの保存先
    $ymd = $timestamp.Substring(0, 10)
    $logFile = "${data_home}\process_on_off_info_${ymd}_save.log" # ログファイル名に日付を追加する
    $logFileName = Split-Path $logFile -Leaf

    # 当該スクリプト実行時初回のプロセス一覧表示　ログに登録
    if([String]::IsNullOrEmpty($script:prevVisibleProcesses)) {
        Add-Content -Path $logFile -Value "-----------------------------------------------------"
        Add-Content -Path $logFile -Value "$timestamp　プロセス実行記録開始`nログファイル:${logFileName}" 
        Add-Content -Path $logFile -Value "-----------------------------------------------------"
        $script:prevVisibleProcesses = @{}
        foreach ($appId in $currentVisibleProcesses.Keys) {
            $app = $currentVisibleProcesses[$appId]
            $status = "{0,-6}{1}" -f '初回',':'
            Add-Content -Path $logFile -Value "[$timestamp] $status $($app.Name) (PID: $($app.Id), Title: '$($app.MainWindowTitle)')"
            $script:prevVisibleProcesses[$appId] = $app
        }

    }

    # プロセス起動の一覧表示 ログに追加
    foreach ($appId in $currentVisibleProcesses.Keys) {
        if (-not $script:prevVisibleProcesses.ContainsKey($appId )){
            $app = $currentVisibleProcesses[$appId]
            $status = "{0,-6}{1}" -f '起動',':'
            Add-Content -Path $logFile -Value "[$timestamp] $status $($app.Name) (PID: $($app.Id), Title: '$($app.MainWindowTitle)')"
        }
    }

    # プロセス終了の一覧表示 ログに追加
    foreach ($appId in $script:prevVisibleProcesses.Keys) {
        if (-not $currentVisibleProcesses.ContainsKey($appId )){
            $app = $script:prevVisibleProcesses[$appId]
            $status = "{0,-6}{1}" -f '終了',':'
            Add-Content -Path $logFile -Value "[$timestamp] $status $($app.Name) (PID: $($app.Id), Title: '$($app.MainWindowTitle)')"
        }
    }

    # 前回のプロセスリストを更新
    $script:prevVisibleProcesses=@{}
    foreach ($appId in $currentVisibleProcesses.Keys) {
        $script:prevVisibleProcesses[$appId] = $currentVisibleProcesses[$appId]
    }
    return $logFile     

}

# メインループ
while ($true) {
    Clear-Host #コンソールをクリア
    $logFile = Log-VisibleApps #プロセスの実行状況をログファイルに記録
    Get-Content -Path $logFile -Tail 20 #ログファイルの内容をコンソールに表示
    Start-Sleep -Seconds 5  # 設定秒待つ
}
