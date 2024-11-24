## windows_system\process_on_off_info
免責:  
作者は、本プログラムの使用によって生じた損害やトラブルについて、責任を負いません。  
  
ライセンス:  
[MITライセンス](https://opensource.org/licenses/MIT)
  
機能：  
WindowsPC内のデスクトップで表示しているアプリケーションの情報をログファイルに記録する。  
ログファイル内直近の状態をコンソールに更新表示する。  
  
注意点:  
本プログラムは実行中のPCにログファイルを作成しますので、ほかの大事なファイルを書き換えられないように注意（専用のフォルダを準備するとかし間違えないように）してください。  
  
準備：  
予めログ書き込み用のフォルダを準備しておく。  
  
起動と終了：  
process_on_off_Info_run.cmd をダブルクリック にて起動。  
起動されたコンソールウィンドウ上で下記操作にて終了。  
「✕」をクリック　又は、ALT+F4　又は、　CTRL＋C
  
コンソール表示イメージ：
````
-----------------------------------------------------
2024-11-23 18:43:29　プロセス実行記録開始
ログファイル:process_on_off_info_2024-11-23_save.log
-----------------------------------------------------
[2024-11-23 18:43:29] 初回    : chrome (PID: 5400, Title: 'xxxxxxxxxxxxxxxxxxxxxxxxx - Google Chrome')
[2024-11-23 18:43:29] 初回    : WindowsTerminal (PID: 3440, Title: 'C:\WINDOWS\system32\cmd.exe')
[2024-11-23 18:43:29] 初回    : TextInputHost (PID: 14608, Title: 'Windows 入力エクスペリエンス')
[2024-11-23 18:43:29] 初回    : Notepad (PID: 15116, Title: 'process_on_off_Info.ps1 - メモ帳')
[2024-11-23 18:43:29] 初回    : SystemSettings (PID: 1344, Title: '設定')
[2024-11-23 18:43:29] 初回    : ApplicationFrameHost (PID: 9724, Title: '設定')
[2024-11-23 18:44:24] 終了    : Notepad (PID: 15116, Title: 'process_on_off_Info.ps1 - メモ帳')
[2024-11-23 18:44:39] 起動    : Notepad (PID: 6376, Title: 'process_on_off_Info.ps1 - メモ帳')
[2024-11-23 18:44:49] 終了    : Notepad (PID: 6376, Title: 'process_on_off_Info.ps1 - メモ帳')
[2024-11-23 18:44:59] 起動    : Notepad (PID: 12888, Title: 'process_on_off_Info_run.cmd - メモ帳')
[2024-11-23 18:45:10] 終了    : Notepad (PID: 12888, Title: 'process_on_off_Info_run.cmd - メモ帳')
[2024-11-23 18:45:20] 終了    : chrome (PID: 5400, Title: 'xxxxxxxxxxxxxxxxxxxxxxxxx - Google Chrome')
````
  
今後の改善点:  
現在、前回と今回のPID(プロセスID)をチェックしPIDが存在するか否かでアプリの起動/終了を判定しログに記録している。  
今後、PIDだけでなく、タブを持つアプリ（例：ブラウザ）でのタブの切り替えもログに登録できるようにすることを検討する。
