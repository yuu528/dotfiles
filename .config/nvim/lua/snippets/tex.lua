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
\documentclass[head_space=25mm, foot_space=25mm, gutter=25mm, fore-edge=25mm, a4paper, report, fleqn]{jlreq}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{enumerate}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{makecell}

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
            {
                delimiters = '<>'
            }
        )
    )
})
