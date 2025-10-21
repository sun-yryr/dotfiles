# ホスト固有の設定

このディレクトリには、特定のホスト（マシン）に固有の設定を配置します。

## 使用方法

1. ホスト名を確認します: `hostname`
2. ホスト名と同じ名前の`.zsh`ファイルを作成します（例: `work-laptop.zsh`）
3. ホスト固有の設定を記述します

例えば、ホスト名が「work-laptop」の場合、`work-laptop.zsh`ファイルを作成し、そのマシン固有の設定を記述します。

## 例

```bash
# work-laptop.zsh
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"
export WORK_PROJECT_DIR="$HOME/projects/work"
