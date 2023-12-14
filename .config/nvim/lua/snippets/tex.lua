local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets('tex', {
    s('tmplt-rp',
        fmt(
            [[
\documentclass[head_space=25mm, foot_space=25mm, gutter=25mm, fore-edge=25mm, a4paper, fleqn]{jlreq}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{enumerate}
\usepackage{graphicx}
\usepackage[hidelinks]{hyperref}
\usepackage{listings, jvlisting}
\usepackage{makecell}
\usepackage{multicol}
\usepackage{multirow}

\newcommand{\ctext}[1]{\textcircled{\scriptsize{#1}}}

\begin{document}
\begin{center}
    \textbf{\large{<>}}
\end{center}
\begin{flushright}
    <>
\end{flushright}
\vspace{\baselineskip}

\section{<>}
<>
\end{document}
]],
            {
                i(1, 'Title'),
                i(2, 'Author'),
                i(3, 'Section'),
                i(0, 'Body')
            },
            { delimiters = '<>' }
        )
    ),
    s('tmplt-rp-titlepage',
        fmt(
            [[
\documentclass[head_space=25mm, foot_space=25mm, gutter=25mm, fore-edge=25mm, a4paper, fleqn, titlepage]{jlreq}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{enumerate}
\usepackage{graphicx}
\usepackage[hidelinks]{hyperref}
\usepackage{listings, jvlisting}
\usepackage{makecell}
\usepackage{multicol}
\usepackage{multirow}

\newcommand{\ctext}[1]{\textcircled{\scriptsize{#1}}}

\title{<>}
\author{<>}
\date{<>}

\begin{document}
\maketitle

\section{<>}
<>
\end{document}
]],
            {
                i(1, 'Title'),
                i(2, 'Author'),
                i(3, 'Date'),
                i(4, 'Section'),
                i(0, 'Body')
            },
            { delimiters = '<>' }
        )
    ),
    s('fig',
        fmt(
            [[
\begin{figure}[htpb]
	\centering
	\includegraphics[height=<>]{<>}
	\caption{<>}
	\label{fig:<>}
\end{figure}
]],
            {
                i(1, 'Height'),
                i(2, 'Filename'),
                i(3, 'Caption'),
                i(0, 'ID')
            },
            { delimiters = '<>' }
        )
    ),
    s('fig-double',
        fmt(
            [[
\begin{figure}[htpb]
	\begin{minipage}[b]{0.48\linewidth}
		\centering
		\includegraphics[height=<>]{<>}
		\caption{<>}
		\label{fig:<>}
	\end{minipage}
	\begin{minipage}[b]{0.48\linewidth}
		\centering
		\includegraphics[height=<>]{<>}
		\caption{<>}
		\label{fig:<>}
	\end{minipage}
\end{figure}
]],
            {
                i(1, 'Height1'),
                i(2, 'Filename1'),
                i(3, 'Caption1'),
                i(4, 'ID1'),
                i(5, 'Height2'),
                i(6, 'Filename2'),
                i(7, 'Caption2'),
                i(0, 'ID2')
            },
            { delimiters = '<>' }
        )
    ),
    s('table',
        fmt(
            [[
\begin{table}[!htpb]
	\caption{<>}
	\label{table:<>}
	\centering
	\begin{tabular}{<>}
		\hline
		<> & <> \\
		\hline
		<> & <> \\
		\hline
	\end{tabular}
\end{table}
]],
            {
                i(1, 'Caption'),
                i(2, 'ID'),
                i(3, 'Column: <clrp|>'),
                i(4, 'Header1'),
                i(5, 'Header2'),
                i(6, 'Cell1'),
                i(0, 'Cell2')
            },
            { delimiters = '<>' }
        )
    ),
    s('lst',
        fmt(
            [[
\begin{lstlisting}[basicstyle={\ttfamily}, tabsize=4]
<>
\end{lstlisting}
]],
            {
                i(0, 'Body')
            },
            { delimiters = '<>' }
        )
    )
})

