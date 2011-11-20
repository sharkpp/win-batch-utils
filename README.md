Windows用のバッチファイル群
===========================

説明
----

大体は引数なしなどで起動するとヘルプが出てきます。

### folder2zip.cmd

カレントディレクトリ直下のディレクトリを全てzip形式で圧縮するためのバッチファイルです。
動作には、 [7z](http://sevenzip.sourceforge.jp/) が必須となっています。
folder2zip.exclude.txt がバッチファイルと同じ場所にある場合は、書かれているファイルを除外して圧縮します。

#### 使い方

    usage: folder2zip.cmd

### arc2zip.cmd

カレントディレクトリ直下の圧縮ファイルを全てzip形式に変換するためのバッチファイルです。
動作には、 [7z](http://sevenzip.sourceforge.jp/) が必須となっています。
arc2zip.exclude.txt がバッチファイルと同じ場所にある場合は、書かれているファイルを除外して圧縮します。

#### 使い方

    usage: arc2zip.cmd

### pdf2jpg.cmd

PDFからJpegファイル or zipへの変換を簡単に行うためのバッチファイルです。
動作には、 [GhostScript](http://www.ghostscript.com/) と [7z](http://sevenzip.sourceforge.jp/) が必須となっています。

#### 使い方

    pdf to jpg and zip converter
    usage: pdf2jpg.cmd [OPTION] FILE [FILE2 ...]
    OPTION:
     -o PATH
       出力先フォルダパス
     -d
       圧縮後にフォルダを削除する
     -j
       jpegへの変換のみ
     -w
       pdfも圧縮する
     -r RESOLUTION
       画像のピクセル/インチ解像度、初期値は200

### error_report.cmd

コンソールコマンド or バッチファイル の実行時にエラーがあった場合にメモ帳でエラー内容を表示するためのバッチファイル。
主に呼び出し元のアプリケーションから標準出力やエラー出力などが握りつぶされている場合にエラー内容を表示させたい時に使います。

#### 使い方

    usage: error_report.cmd CMDLINE

### git/svn2github.cmd

svnレポジトリをgithubに簡単に登録するためのバッチファイルです。
authorsファイルが無いと怒られます。
予めgithubでGIT_DIRと同じ名前のリポジトリを作っておく必要があります。

#### 使い方

    usage: svn2github SVN_REPOS GIT_DIR [GIT_OPTION]
      ex.
        svn2github.cmd http://svn.example.net/test example-test -s

#### authorsファイル

authorsファイルは1行が次のような形式になっているファイルを置いてください。
svn-user が、Subversionで使用しているユーザー名。
git-user が、githubで使用しているユーザー名。

    svn-user = git-user<hoge@example.net>

### git/sync4git.cmd

svnとgitを同期させるバッチスクリプトです。
コミット時にフックで自動的に実行するようにして使っています。
authorsファイルが無いと怒られます。

#### 使い方

    usage: sync4git.cmd [GIT_BASE_PATH]

### git/git_env.cmd

git/svn2github.cmd や git/sync4git.cmd から呼び出されるバッチファイルです。
直接は使用しません。

