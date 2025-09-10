# reswitch

macOS用の超シンプルな解像度トグルCLIです。実行するとメイン（ミラー時はマスター）に対し、
`3840x2160` と `2560x1440` をトグルします。その他の解像度の時は何もしません。

## Build

```
make build
```

`bin/reswitch` が生成されます。

## Install (single user)

```
mkdir -p ~/bin
install -m 0755 bin/reswitch ~/bin/reswitch
```

## Usage

```
~/bin/reswitch
```

- 複数ディスプレイでも、メイン（ミラーのマスター）に対して切替えます。
- HiDPI/スケーリング環境でも利用可。候補モードの中からピクセル幅→リフレッシュレート優先で選択。

## Raycast

`~/.raycast/scripts/reswitch-toggle.sh` をScript Commandとして登録すればワンキーで切替えできます。

```
#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Toggle 4K/1440p
# @raycast.mode silent
# @raycast.packageName Display
"$HOME/bin/reswitch"
```

Raycast → Settings → Extensions → Script Commands → ディレクトリに `~/.raycast/scripts` を追加し、
コマンドに Hotkey を割り当ててください。

## Notes

- 特定のディスプレイIDを対象にしたい場合は `reswitch.swift` の対象選択を固定するだけで対応できます。
- 余計なエラーハンドリングは意図的に入れていません（KISS/YAGNI）。
