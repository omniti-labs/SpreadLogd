%{
/* ======================================================================
 * Copyright (c) 2000 Theo Schlossnagle
 * All rights reserved.
 * The following code was written by Theo Schlossnagle <jesus@omniti.com>
 * This code was written to facilitate clustered logging via Spread.
 * More information on Spread can be found at http://www.spread.org/
 * Please refer to the LICENSE file before using this software.
 * ======================================================================
*/

#include <string.h>

#include "config.h"
#include "y.tab.h"

extern int line_num;
extern int semantic_errors;
%}
qstring \"[^\"]*\"|\'[^\']*\'
string  [^ \t\r\n#{}]+
%option noyywrap
%%
#.*                             {} /* Comments */
[ \t\r]                         {} /* White space */
\n                              { line_num++;}
"{"                             { return OPENBRACE; }
"}"                             { return CLOSEBRACE; }
"="                             { return EQUALS; }
BufferSize			{ return BUFFERSIZE; }
Spread                          { return SPREAD; }
Port                            { return PORT; }
Host                            { return HOST; }
Log                             { return LOG; }
Group                           { return GROUP; }
File                            { return FILENAME; }
Match                           { return MATCH; }
{qstring}                       { int l = strlen(yytext);
                                  yytext[l-1] = 0;
                                  yylval = strdup(yytext+1);
                                  return STRING; }
{string}                        { yylval = strdup(yytext);
                                  return STRING; }
%%