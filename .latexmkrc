#!/usr/bin/env perl

# $latex = 'uplatex %O -synctex=1 %S';

# $latex = "find . -type f -name '*.tex' | xargs sed -i '' -e 's/、/，/g' -e 's/。/．/g'; uplatex -synctex=1 -halt-on-error %O %S";
$latex = "uplatex -synctex=1 -halt-on-error";

# $pdflatex = 'pdflatex %O -synctex=1 %S';
# $lualatex = 'lualatex %O -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
# $dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 3;
$pvc_view_file_via_temporary = 0;
$pdf_previewer = 'open -ga /Applications/Skim.app';

# ディレクトリ指定
$out_dir = 'build';

# vimtexのコールバックでうまく動かなかったので、泥臭く解決
# タイプセットがうまくいったときだけ、cpコマンドを打つ
# $success_cmd = 'nvr --remote-expr "vimtex#compiler#callback(1)"; cp -f %D ..';
# $failure_cmd = 'nvr --remote-expr "vimtex#compiler#callback(0)"';
# $warning_cmd = 'nvr --remote-expr "vimtex#compiler#callback(0)"';


# https://github.com/PMOB/study-tex/blob/master/Tips/latexmk.md 使い方いろいろ載ってる
