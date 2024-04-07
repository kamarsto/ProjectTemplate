\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ProjectTemplate/project_template}[Template for projects]

\LoadClass[a4paper, 12pt]{article}

\newcommand{\ProjectLanguage}[1]{\gdef\@ProjectLanguage{#1}}
\newcommand{\BabelProjectLanguage}[1]{\gdef\@BabelProjectLanguage{#1}}


\def\@ProjectLanguage{pl}
\DeclareOption{pl}{\def\@ProjectLanguage{pl} \def\@BabelProjectLanguage{polish}}
\DeclareOption{en}{\def\@ProjectLanguage{en} \def\@BabelProjectLanguage{main=english, polish}}

\ProcessOptions\relax




%%%%%%%%%%%%%%%%%%%%%%
%% Provide packages %%
%%%%%%%%%%%%%%%%%%%%%%
\PassOptionsToPackage{table, svgnames}{xcolor}
\RequirePackage[export]{adjustbox}
\RequirePackage{amsfonts}
\RequirePackage[intlimits]{amsmath} %Various maths utilities - more symbols
\RequirePackage{amssymb} %This conflicts with the polish babel package (\lll)
\RequirePackage[\@BabelProjectLanguage]{babel}%This is included because oftentimes author names might have Polish symbols
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage[utf8]{inputenc}
\RequirePackage{csquotes} %Ensures compatibility of Biblatex when using Babel
\RequirePackage[yyyymmdd]{datetime}
\RequirePackage{etoolbox}
\RequirePackage[margin=75pt]{geometry} %Set margins
\RequirePackage{fancyhdr}
\RequirePackage{float}
\RequirePackage[T1]{fontenc}
\RequirePackage{gensymb} %\degree, \celsius etc
\RequirePackage{graphicx}
\RequirePackage[hidelinks]{hyperref} %Links
\RequirePackage{indentfirst}
\RequirePackage{lastpage}
\RequirePackage{lmodern} %Including this package for now because it's unknown which font we'll use
\RequirePackage{multirow}
\RequirePackage{pgfplots} %Plotting tool
\RequirePackage{siunitx}
\RequirePackage{physics}
\RequirePackage[section]{placeins} %+ workaround from StackOverflow = implicit \FloatBarrier for subsections
\RequirePackage{subcaption} %Subfigures
\RequirePackage{tabularx}
\RequirePackage[most]{tcolorbox} %Code in boxes for function documentation
\RequirePackage{textcomp} %A workaround to get rid of a gensymb warning
\RequirePackage{verbatim}
\RequirePackage[backend=biber, sorting=none]{biblatex}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{cases}
\RequirePackage{aligned-overset}
\RequirePackage{esint}
\RequirePackage{bbold}
\RequirePackage{tablefootnote}
\RequirePackage{makecell}
\RequirePackage{xfrac}
\RequirePackage{tikz}
%\RequirePackage{minted} %While a very nice tool, it should NOT be included due to the difficulty in installing it
%\RequirePackage{pageslts}%handling different page numbering

\hypersetup{
	colorlinks,
	citecolor=black,
	filecolor=black,
	linkcolor=black,
	urlcolor=black
}



%%%%%%%%%%%%%%%%%%%%%%
%% Settings options %%
%%%%%%%%%%%%%%%%%%%%%%
\tcbuselibrary{skins}
\tcbset{enhanced, colback=White, colframe=Black!60, opacityback=1, opacityframe=1, equal height group = A, nobeforeafter, sharp corners}
\pgfplotsset{compat=newest}
\setcounter{MaxMatrixCols}{20} %A workaround that might come in handy - it changes the default maximum number of columns in a \begin{bmatrix}
\renewcommand{\dateseparator}{.}

%%%%%%%%%%%%%%%%%%%%%%%
%% Header and footer %%
%%%%%%%%%%%%%%%%%%%%%%%
\textheight = 580pt
\footskip = 40pt
\headsep = 16pt
\headheight = 70pt
\def\title#1{\gdef\@title{#1}\gdef\THETITLE{#1}}
\def\date#1{\gdef\@date{#1}\gdef\THEDATE{#1}}

\newcolumntype{Z}{>{\RaggedLeft\arraybackslash}X}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0,1pt}
\renewcommand{\footrulewidth}{0,1pt}

% Left header
\fancyhead[L]{%
    \begin{tabularx}{\textwidth}{@{}>{\color[rgb]{0.00, 0.11, 0.23}}b{0.5\textwidth}} %lewy nagłówek
        \THETITLE{}
    \end{tabularx}%
}

% Right header
\fancyhead[R]{%

}

% Footer
\fancyfoot[L]{%
    \begin{tabularx}{\textwidth}{@{}X@{\hspace{20pt}}r@{}}
    \leftmark &%
    \begin{tabular}[t]{@{}r@{}}
        \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
            Data: 
        \else
            Date: 
        \fi
        \THEDATE \\
        \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
            Strona: 
        \else
            Page: 
        \fi
        \thepage \hspace{1pt} of \pageref{LastPage}
    \end{tabular}
    \end{tabularx}% 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Creating commands for titlepage %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\documentNumber}[1]{\gdef\@documentNumber{#1}}%
\newif\ifdnumber
\dnumberfalse % Set default value of conditional to false
\def\@documentNumber{} % Set default value of \@documentNumber to empty
\newcommand{\dnumbercheck}{%
    \ifx\@documentNumber\empty
        \dnumberfalse
    \else
        \dnumbertrue
    \fi
}

\newcommand{\editor}[1]{\gdef\@editor{#1}}%
\newif\ifeditor
\editorfalse % Set default value of conditional to false
\def\@editor{} % Set default value of \@editor to empty
\newcommand{\editorcheck}{%
    \ifx\@editor\empty
        \editorfalse
    \else
        \editortrue
    \fi
}

\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}%
\newcommand{\@subtitle}{\@latex@warning@no@line{No \noexpand\subtitle given}}
\newcommand{\summary}[1]{\gdef\@summary{#1}}%
\newcommand{\@summary}{\@latex@warning@no@line{No \noexpand\summary given}}

\newcommand{\formatauthor}
{%
    \begin{tabular}[t]{@{}l@{}}
        \@author
    \end{tabular}
}
\newcommand{\formatTitleLeft}
{%
    \begin{tabular}[t]{@{}rl@{}}
        \editorcheck
        \ifeditor%
        \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
                Redaktor: \uppercase{&} \@editor  \\
            \else
                Editor: \uppercase{&} \@editor  \\
            \fi
        \else%
        \fi%
        \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
            Data: & \@date\\
        \else
            Date: & \@date\\
        \fi
        \dnumbercheck
        \ifdnumber%
            \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
            Numer dokumentu:\uppercase{&}\@documentNumber\\
            \else
            Document number:\uppercase{&}\@documentNumber\\
            \fi
        \else%
        \fi%
        \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
            Liczba stron: \uppercase{&}\pageref{LastPage}
        \else
            Number of pages: \uppercase{&} \pageref{LastPage}
        \fi
    \end{tabular}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Redo maketitle for our purposes %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\maketitle}{
    \hypersetup{pageanchor=false}%A hack taken from StackOverflow in order to avoid a warning
    \begin{titlepage}

        \begin{table}[H]
            \begin{tabular*}{\linewidth}{@{}l@{\extracolsep{\fill}}r@{\extracolsep{0.5cm}}l@{}}
                \formatTitleLeft & 
                % \ifnum \pdf@strcmp{\@ProjectLanguage}{pl} = 0
                % Autor(zy):
                % \else
                % Author(s):
                % \fi
                 &\formatauthor
            \end{tabular*}
            \vspace{4cm}
        \end{table}

        \begin{center}
            \Huge
            \textbf{\@title}
            \vspace{1.5cm}
            \large\\
            \@subtitle
            \vfill
            \@summary
        \end{center}
    \end{titlepage}
\newpage

\hypersetup{pageanchor=true}
\pagenumbering{roman} %Should the roman numbering include the title page?
\tableofcontents
\newpage

\IfFileExists{preface.tex}{\input{preface.tex} \newpage}{} %Can contain stuff such as abbreviations
\clearpage
\pagenumbering{arabic}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Macros and Math operators %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\tn{\textnormal}

\DeclareMathOperator{\dive}{div}
\DeclareMathOperator{\Rey}{Re}
\DeclareMathOperator{\Ma}{Ma}
\DeclareMathOperator{\Kn}{Kn}
\DeclareMathOperator{\mug}{\mathrm{\mu}g}

\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography settings     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\postnotedelim}{}