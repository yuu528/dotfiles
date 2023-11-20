#!/usr/bin/perl

$pdflualatex	= 'lualatex %O -synctex=1 %S';
$latex			= 'uplatex %O -synctex=1 %S';

$bibtex			= 'upbibtex %O %B';
$biber			= 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$makeindex		= 'mendex %O -o %D %S';

$dvipdf			= 'dvipdfmx %O -o %D %S';
$dvips			= 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf			= 'ps2pdf14 -dPDFA -dPDFACompatibilityPolicy=1 -sProcessColorModel=DeviceCMYK %O %S %D';

$pdf_mode		= 4;
