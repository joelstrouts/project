\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{ucetd}[2012/05/06 University of Chicago Electronic Theses and Dissertations]

%%%%%%%%%%%%%%%%%%%%%%%%% Helper commands %%%%%%%%%%%%%%%%%%%%%%%%%

% These commands deal with options that set variables
\newcommand{\etdDeclVarArg}[2]{\newcommand{#1}{#2}}
\newcommand{\etdVarArg}[3]{\DeclareOption{#2}{\renewcommand{#1}{#3}}}

% These commands deal with options that execute latex
\newcommand{\etdDeclArg}[2]{#2}
\newcommand{\etdArg}[2]{\DeclareOption{#1}{#2}}

% Declare a super class and pass it remaining unprocessed arguments
\newcommand{\etdSuperClass}[2]{
  \DeclareOption*{\PassOptionsToClass{\CurrentOption}{#1}}
  \ProcessOptions\relax
  \LoadClass[#2]{#1}
}

% Default copyright text
\newcommand{\etdCopyrightText}{
  \null\vfill
  \centerline{Copyright \copyright\ \number\year\ by \@author}
  \centerline{All Rights Reserved}
  \vskip 15pt\relax
}

% Preliminary sections following the table of contents and preceding the body are front matter
\newcommand{\etdFrontMatter}[1]{
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}
}

% Special front matter that appears before the table of contents
\newcommand{\etdPreTOCMatter}[1]{
  \chapter*{}
  \thispagestyle{empty}
  \begin{center}
    #1
  \end{center}
}

% Starts the main matter of the document
\newcommand{\etdMainMatter}{
  \clearpage
  % Switch to arabic numbers on pages
  \pagenumbering{arabic}
}

% UC ETD title page format
\newcommand{\etdTitlePage} {
  \begin{titlepage}
    {\centering
    \begin{minipage}{\textwidth}
      \vspace{1em}
      {\centering
        {\scshape\LARGE \@institution \par}
        \vspace{0.3cm}
        {\scshape\Large Final year project\par}
        \vspace{1.5cm}
        {\huge\bfseries \@title\par}
        \vspace{1.5cm}
        {\Large\itshape \@author\par}
        \vfill
        supervised by\par
        Dr.~Ben \textsc{Powell}

        \vspace{0.5cm}\textbf{Abstract}\par}
      \noindent\raisebox{.5ex}{\rule{\linewidth}{.4pt}}\par
      \@abstract\par
      \noindent\raisebox{.5ex}{\rule{\linewidth}{.4pt}}\par
      \vfill
      {\centering \large\today\par}
    \end{minipage}  
    }
  \end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%
%% Load required packages
%%

\RequirePackage{setspace}[1998/04/8]

%%
%% Default Settings
%%

% Default font point size
\newcommand{\etdDefaultPointSize}{10pt}

% Default line spacing
%\newcommand{\etdDefaultSpacing}{\setstretch{1.37}}
\newcommand{\etdDefaultSpacing}{\doublespacing}

% Parent document class
\newcommand{\etdParentClass}{report}

% Adds to the margin size (initially 1in)
\newcommand{\etdMarginAdjust}{0.0in}
\newcommand{\etdHeadingMarginAdjust}{0.0in}
%%
%% Declare arguments/options
%%

% TOC Options
\let\iftocflag=\iffalse
\DeclareOption{tocchapterhead}{\let\iftocflag=\iftrue}

% Chapter Style Options
\newcommand{\etdChapterStyle}[1]{\MakeUppercase{#1}}
\DeclareOption{plainchapterheads}{\renewcommand{\etdChapterStyle}[1]{#1}}

% Options for setting point size
\etdDeclVarArg{\etdPtSize}{\etdDefaultPointSize}
\etdVarArg{\etdPtSize}{10pt}{10pt}
\etdVarArg{\etdPtSize}{11pt}{11pt}
\etdVarArg{\etdPtSize}{12pt}{12pt}

% Option for using letter paper
\etdArg{letterpaper}{\PassOptionsToClass{letterpaper}{report}}

% Options to set spacing
\etdDeclVarArg{\etdSpacing}{\etdDefaultSpacing}
\etdVarArg{\etdSpacing}{doublespace}{\doublespacing}
\etdVarArg{\etdSpacing}{defaultspace}{\etdDefaultSpacing}
\etdVarArg{\etdSpacing}{onehalfspace}{\onehalfspace}
\etdVarArg{\etdSpacing}{singlespace}{\singlespace}

% Options to set chapter head style
\newcommand{\etdChapterHeadFormat}[1]{\MakeUppercase{#1}}
\etdArg{plainchaptertitles}{\renewcommand{\etdChapterHeadFormat}[1]{#1}}
\etdArg{capschaptertitles}{\newcommand{\etdChapterHeadFormat}[1]{\MakeUppercase{#1}}}

% Enable/Disable printing of CHAPTER and APPENDIX in TOC
\let\iftocflag=\iffalse
\etdArg{tocchapterhead}{\let\iftocflag=\iftrue}

%%
%% Load superclass for document
%%

\etdSuperClass{\etdParentClass}{\etdPtSize}

%%
%% Do some init stuff
%%

% Ported from old file, sets up spacing between footnotes
\RequirePackage[splitrule]{footmisc}
\setlength{\footnotesep}{\baselineskip}
\let\oldfootnoterule = \footnoterule
\renewcommand{\footnoterule}{\kern 0.4\footnotesep\oldfootnoterule\kern-0.4\footnotesep}
\renewcommand{\@makefntext}[1]{\noindent\makebox[2.5em][r]{\@thefnmark.\ }#1}

% Setup default size of math text
\AtBeginDocument{\DeclareMathSizes{12}{12}{10}{8}}

% Setup spacing
\etdSpacing

%%%%%%%%%%%%%%%%%%%%%%%%% User Commands %%%%%%%%%%%%%%%%%%%%%%%%%%

% Define text to go on the dedication/copyright/epigraph page

% Usage:
%	\dedication{dedication text}
\newcommand{\dedication}[1]{\newcommand{\etdDedicationText}{#1}}
% Usage:
%	\epigraph{epigraph text}
\newcommand{\epigraph}[1]{\newcommand{\etdEpigraphText}{#1}}

% Output a dedication/copyright/epigraph page
\newcommand{\makededication}{\etdPreTOCMatter{\etdDedicationText}}
\newcommand{\makecopyright}{\etdPreTOCMatter{\etdCopyrightText}}
\newcommand{\makeepigraph}{\etdPreTOCMatter{\etdEpigraphText}}

% Begin an abstract or acknowledgements page
\renewcommand{\abstract}{\etdFrontMatter{Abstract}}
\newcommand{\acknowledgments}{\etdFrontMatter{Acknowledgments}}

% Start the main thesis body
\newcommand{\mainmatter}{\etdMainMatter}

% Bibliography
% Change ft2,master,refs below to point to your library.bib files
\newcommand{\makebibliography}{
  \newpage
  \addcontentsline{toc}{chapter}{References}
  \begin{singlespace}
    \begin{multicols}{2}[\printbibheading]
      \printbibliography[heading=none]
    \end{multicols}
  \end{singlespace}
}

%
% Title page related commands
%

% Basic information
\renewcommand{\title}[1]{\gdef\@title{#1}}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\division}[1]{\gdef\@division{#1}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
\renewcommand{\date}[1]{\gdef\@date{#1}}
\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}
\renewcommand{\institution}[1]{\gdef\@institution{#1}}

% Output title page
\renewcommand{\maketitle}{
  \etdTitlePage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%% Internal Formatting %%%%%%%%%%%%%%%%%%%%%%%%%
%
% The following was mostly ported from ccw_chithesis_YH with a few modifications
%


% Chapter/Section formatting
\renewcommand{\@makechapterhead}[1]{{
    \setlength\topskip{0cm}
    \normalfont\large\bfseries
    \begin{center}
      \etdChapterStyle{\@chapapp{ \thechapter}}  %  CHAPTER # or APPENDIX
      
      
      \etdChapterStyle{#1}                       %     TITLE OF CHAPTER
    \end{center}
    \setlength\topskip{2cm}
}}
\renewcommand{\@makeschapterhead}[1]{{  
    \setlength\topskip{0cm}
    \normalfont\large\bfseries
    \begin{center}
      \etdChapterHeadFormat{#1}                       %     TITLE OF CHAPTER
    \end{center}
    \setlength\topskip{2cm}
}}
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\normalfont\large\bfseries\centering}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\large\itshape\centering}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\large\itshape\centering}}

\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >\m@ne
  \addpenalty{-\@highpenalty}%
  \vskip 1.0em \@plus\p@
  \setlength\@tempdima{1.5em}%
  \begingroup
  \parindent \z@ \rightskip \@pnumwidth
  \parfillskip -\@pnumwidth
  \leavevmode
  \advance\leftskip\@tempdima
  \hskip -\leftskip
         {\bf \etdChapterHeadFormat{#1}}\nobreak
         \hfil \nobreak\hb@xt@\@pnumwidth{\hss}\par
         \penalty\@highpenalty
         \endgroup
         \fi}


\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
  \addpenalty{-\@highpenalty}%
  \vskip 1.0em \@plus\p@
  \setlength\@tempdima{1.5em}%
  \begingroup
  \parindent \z@ \rightskip \@pnumwidth
  \parfillskip -\@pnumwidth
  \leavevmode
  \advance\leftskip\@tempdima
  \hskip -\leftskip
  \etdChapterHeadFormat{#1}\nobreak
  % CCW: The following 3 lines add dots to the chapter TOC listings
  \leaders\hbox{$\m@th
    \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
    mu$}\hfill
  \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
  \penalty\@highpenalty
  \endgroup
  \fi}

% Add "CHAPTER"/"APPENDIX" headings to TOC before first of each.
% If you want these words to be a bit bigger, remove "\normalsize" 
% from the definition below.  If you want the words to be bold, 
% remove "\mdseries". (CCW)

\iftocflag
\let\old@chapter = \@chapter
\def\@chapter[#1]#2{\ifnum\c@chapter=\z@%
  \addtocontents{toc}{\protect\contentsline{part}%
    {\mdseries\normalsize\etchapterheadstyle{\@chapapp}}{}}%
  \fi%
  \old@chapter[{#1}]{#2}}
\fi

% Change names of table of contents and bibliography

\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{References}

% Change the margins to fit requirements

%%\setlength{\oddsidemargin}{-0.325in}  % really 1.5in
%%\setlength{\evensidemargin}{-0.325in}  % really 1.5in
%\setlength{\oddsidemargin}{0.in}
%\setlength{\evensidemargin}{0.in}
%\setlength{\textwidth}{6.875in}
%\setlength{\textwidth}{6.5in}
%%\setlength{\topmargin}{0.in}   % really 1in
%\setlength{\headheight}{-0.375in}
%\setlength{\headsep}{0.in}
%%\setlength{\textheight}{8.5in}
%\setlength{\textheight}{9.3in}
%\setlength{\footskip}{0.3in}

%%%%%%
%% Completely re-doing margins --mvz
%%%%%%

%%%%  % Main text box is the width/height of the paper minus 2in
%%%%  \setlength{\textwidth}{5.75in}
%%%%  \setlength{\textheight}{9.00in} % + footskip (0.25) = 9.00in
%%%%  
%%%%  % Only the left and top margins can be defined
%%%%  % 1in is added to given values
%%%%  \setlength{\topmargin}{-0.2in}
%%%%  \setlength{\evensidemargin}{0.0in}
%%%%  \setlength{\oddsidemargin}{0.4in}
%%%%  
%%%%  % The top margin is also affected by the headhight and headsep
%%%%  \setlength{\headheight}{0.0in}
%%%%  \setlength{\headsep}{0.0in}
%%%%  
%%%%  % The bottom margin is also affected by the footskip
%%%%  % i.e. the length of the page has the following markers:
%%%%  % top of text at 1.00in, bottom of text at 9.75in,
%%%%  % page number at 10.00in, bottom of page at 11.00in
%%%%  \setlength{\footskip}{0.5in}
%%%%  
%%%%  % Making sure absolutely nothing passes the right margin
%%%%  \setlength{\hfuzz}{0.0pt}

% Changing where the page numbers go on pages that aren't the first
% page of a chapter.

%\pagestyle{myheadings}
%\pagestyle{plain}
%\markright{}

% Make the table of contents, etc.,  single spaced
%
% bph added lists of tables/figures to table of contents.
% CCW fixed bug where multipage LOT/LOF were listed in TOC with wrong
% page number.

\let\oldtableofcontents = \tableofcontents
\renewcommand{\tableofcontents}{
  \begin{singlespace}
    \oldtableofcontents
  \end{singlespace}
}

% The following defines the list of tables and figures and removes any
% indentations. If your latex compiler has different default options, you'll
% need to change the following.


\renewcommand*{\l@table}{\@dottedtocline{1}{0em}{2.3em}}
\let\oldlistoftables = \listoftables
\renewcommand{\listoftables}{
  \begin{singlespace}
    % This works b/c multiple \newpage's are treated as one
    \newpage
    \addcontentsline{toc}{chapter}{List of Tables}
    \oldlistoftables 
  \end{singlespace}
}

\renewcommand*{\l@figure}{\@dottedtocline{1}{0em}{2.3em}}
\let\oldlistoffigures = \listoffigures
\renewcommand{\listoffigures}{
  \begin{singlespace}
    % This works b/c multiple \newpage's are treated as one
    \newpage
    \addcontentsline{toc}{chapter}{List of Figures}
    \oldlistoffigures 
  \end{singlespace}
}

