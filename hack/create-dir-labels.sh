#!/usr/bin/env bash
#
# ルートディレクトリからの相対パスでGitHub上にラベルを作成する

set -euo pipefail

# / をworkdirにする
cd $(dirname $0)/..

# GitHubから現在のラベルを取得し、その名前を抽出して配列に格納
existing_labels=$(gh label list | awk '{print $1}')
# findで除外するディレクトリを指定
ignore="-name .git -o -name hack"

# ルートディレクトリから2階層目までの各ディレクトリを検索
for dir in $(find . \( ${ignore} \) -prune -o -type d -print -maxdepth 2)
do
    # スラッシュを削除してラベル名候補を作成
    label=${dir//.\//}

    # カレントディレクトリはfindで除外面倒なのでここで除外
    if [[ $label == "." ]]; then
        continue
    fi

    # ラベルがすでに存在するか確認
    if [[ $existing_labels =~ "\"$label\"" ]]; then
        echo "Label $label already exists, skipping..."
    else
        echo "Creating label $label..."
        # ラベルが存在しなければ新しく作成
        gh label create "$label" --color="ffffff" --description="Directory label"
    fi
done
