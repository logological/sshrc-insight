%%
%% This is file `sshrc-insight.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% sshrc-insight.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright 2024 Tristan Miller
%% Copyright 2021 Steven B. Segletes
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%%
\NeedsTeXFormat{LaTeX2e}[2018-04-01]
\DeclareRelease{2024}{}{sshrc-insight.cls}
\DeclareRelease{v2024}{}{sshrc-insight.cls}
\DeclareCurrentRelease{v2024.1.0}{2024-10-21}
\ProvidesClass{sshrc-insight}
[2024-10-21 v2024.1.0 Class for SSHRC Insight Grant proposals]
\LoadClass[12pt,letterpaper]{article}

%% Conditionals for detecting the typesetting engine
\RequirePackage{ifxetex,ifluatex}
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\RequirePackage{subfiles}
\ifxetexorluatex
\RequirePackage{fontspec}
\defaultfontfeatures{Mapping=tex-text}
\setromanfont{Times New Roman}
\else
\RequirePackage[T1]{fontenc} % T1 font encoding
\RequirePackage{newtxtext} % Use Times for main text
\RequirePackage{newtxmath} % Use Times for math
\fi
\RequirePackage[letterpaper,
                left=0.75in,
                top=0.75in,
                bottom=0.75in,
                right=0.75in,
               ]{geometry}
\RequirePackage{nopageno} % No page numbers
%% Compact title for subfiles
\RequirePackage[normalem]{ulem}
\NewDocumentCommand{\subfiletitle}
  {m}
  {%
  \newpage
  \ifSubfilesClassLoaded{
      \@ifpackageloaded{hyperref}
      {\hypersetup{pdftitle=\GetTranslation{#1}}}
      {}
    }
    {\phantomsection\addcontentsline{toc}{section}{\GetTranslation{#1}}}
  \begingroup
    \centering\bfseries\MakeUppercase{\uline{\GetTranslation{#1}}}
    \par
    \vskip 1.5em%
  \endgroup
  \par\@afterindentfalse\@afterheading
  }

%% Suppress section numbers in table of contents
\addtocontents{toc}{\protect\renewcommand{\protect\numberline}[1]{}}

%% Localized (sub)section headings
\NewDocumentCommand{\subfilesection}
  {m}
  {\section*{\GetTranslation{#1}}}
\NewDocumentCommand{\subfilesubsection}
  {m}
  {\subsection*{\GetTranslation{#1}}}
%% Count characters, adapted from code by Steven B. Segletes at
%% https://tex.stackexchange.com/a/587567/22603
\RequirePackage{tokcycle}[2021-03-10]
\RequirePackage{xcolor}
\newcounter{wordcount}
\newcounter{lettercount}
\newcounter{wordlimit}
\newif\ifinword
%% USER PARAMETERS
\newif\ifrunningcount
\newif\ifsummarycount
\def\limitcolor{red}
\setcounter{wordlimit}{0}
%%%
%% \tc@defx is like \def, but expands the replacement text once prior
%% to assignment
\newcommand\addtomacro[2]{\tc@defx#1{#1#2}}
\newcommand\changecolor[1]
  {\tctestifx{.#1}{}{\addcytoks{\color{#1}{}}%
  \tc@defx\currentcolor{#1}}}
\newcommand\dumpword{%
  \addcytoks[1]{\accumword}%
  \ifinword\stepcounter{wordcount}\stepcounter{lettercount}
    \ifrunningcount\addcytoks[x]{$^{\thewordcount,\thelettercount}$}\fi
    \ifnum\thewordcount=\value{wordlimit}\relax%
      \changecolor{\limitcolor}\fi
  \fi%
  \inwordfalse
  \def\accumword{}}
\newcommand\addletter[1]{%
  \stepcounter{lettercount}%
  \tctestifcatnx A#1{\inwordtrue}{\dumpword}%
  \addtomacro\accumword{#1}}
\xtokcycleenvironment\countem
  {\addletter{##1}}
  {\dumpword\groupedcytoks{\processtoks{##1}%
    \dumpword\expandafter}\expandafter
    \changecolor\expandafter{\currentcolor}}
  {\dumpword\addcytoks{##1}}
  {\dumpword\addcytoks{##1}}
  {\stripgroupingtrue\def\accumword{}\def\currentcolor{.}
    \setcounter{wordcount}{0}\setcounter{lettercount}{0}}
  {\dumpword\ifsummarycount\tcafterenv{%
    \par(Wordcount=\thewordcount, Lettercount=\thelettercount)}\fi}

\def\characterlimit{3800}
\newcommand{\countchars}[2][\characterlimit]
  {\countem #2\endcountem\par\hfill
    \GetTranslation{Character count:}
    \thelettercount\ \GetTranslation{of} #1
  }
\reversemarginpar
\NewDocumentCommand{\sshrcsupported}
  {}
  {%
    \leavevmode%
    \marginparsep=0pt%
    \marginpar{\raggedleft\mbox{\textasteriskcentered~}}%
  }
\NewDocumentCommand{\sshrcstudent}
  {}
  {\textsuperscript{+}}
\AtBeginDocument{
  \@ifpackageloaded{biblatex}
  {
    \ifSubfilesClassLoaded
    {
        % Force subfiles to read the main file's bibliography
        \RequirePackage[bblfile=\preamble@file]{biblatex-readbbl}
    }
    {}
    \renewcommand*{\mkbibnamefamily}[1]{%
      \ifitemannotation{student}
        {#1\sshrcstudent}
        {#1}%
    }
    \renewbibmacro*{begentry}
      {%
        \ifkeyword{sshrc}
          {\makebox[0pt][r]{\textasteriskcentered~}}
          {}%
      }
  }
  {}
}
%% Disable citation hyperlinks in subfiles
\ifSubfilesClassLoaded{
    \PassOptionsToPackage{hyperref=false}{biblatex}
}{}
%% Localizations
\RequirePackage{translations}
\DeclareTranslation{french}{1. Relevant research contributions over the last six years}{1. Contributions pertinentes à la recherche faites au cours des six dernières années}
\DeclareTranslation{french}{2. Other research contributions}{2. Autres contributions à la recherche}
\DeclareTranslation{french}{3. Most significant career research contributions}{3. Plus importantes contributions à la recherche faites au cours d'une carrière}
\DeclareTranslation{french}{4. Contributions to training}{4. Contributions à la formation}
\DeclareTranslation{french}{Budget Justification}{Justification du budget}
\DeclareTranslation{french}{Career Interruptions and Special Circumstances}{Interruptions de carrière et circonstances spéciales}
\DeclareTranslation{french}{Context}{Contexte}
\DeclareTranslation{french}{Creative outputs}{Réalisations artistiques}
\DeclareTranslation{french}{Description of previous and ongoing research results}{Description des résultats de recherche les plus récents ou en cours}
\DeclareTranslation{french}{Description of proposed student training strategies}{Description des stratégies proposées de formation des étudiants}
\DeclareTranslation{french}{Description of the research team}{Description de l'équipe de recherche}
\DeclareTranslation{french}{Detailed Description}{Description détaillée}
\DeclareTranslation{french}{Exclusion of Potential Reviewers}{Exclusion d'évaluateurs éventuels}
\DeclareTranslation{french}{Expected Outcomes}{Résultats escomptés}
\DeclareTranslation{french}{Forthcoming contributions}{Contributions à venir}
\DeclareTranslation{french}{Knowledge Mobilization Plan}{Plan de mobilisation des connaissances}
\DeclareTranslation{french}{List of References}{Liste des références}
\DeclareTranslation{french}{Methodology}{Méthodologie}
\DeclareTranslation{french}{Nonrefereed contributions}{Contributions non soumises à des comités de lecture}
\DeclareTranslation{french}{Objectives}{Objectifs}
\DeclareTranslation{french}{Other refereed contributions}{Autres contributions soumises à des comités de lecture}
\DeclareTranslation{french}{Previous Critiques}{Réponse à des critiques précédentes}
\DeclareTranslation{french}{Refereed contributions}{Publications soumises à des comités de lecture}
\DeclareTranslation{french}{Request for Multi/Interdisciplinary Evaluation}{Demande d'évaluation interdisciplinaire ou multidisciplinaire}
\DeclareTranslation{french}{Research Contributions}{Contributions à la recherche}
\DeclareTranslation{french}{Research Team, Student Training, Previous Output}{Équipe de recherche, résultats les plus récents et formation des étudiants}
\DeclareTranslation{french}{Research-creation Support Material}{Documents d'appui liés à la recherche-création}
\DeclareTranslation{french}{Summary of Proposal}{Résumé de la proposition}
\DeclareTranslation{french}{Character count:}{Nombre de caractères:}
\DeclareTranslation{french}{of}{sur}
\endinput
%%
%% End of file `sshrc-insight.cls'.
