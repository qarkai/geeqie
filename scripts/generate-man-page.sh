#!/bin/bash
# Create the man page from the output of the "geeqie--help" command
# and also create the xml file for Command Line Options
#
# This needs to be run only when the command line options change

command -v help2man > /dev/null
if [ $? -eq 1 ]
then
	echo "help2man not installed"
	exit
fi

command -v doclifter > /dev/null
if [ $? -eq 1 ]
then
	echo "doclifter not installed"
	exit
fi

options_file=$(mktemp)

echo "[NAME]
Geeqie - GTK based multiformat image viewer

[DESCRIPTION]
Geeqie is an interactive GTK based image viewer that supports multiple image formats,
zooming, panning, thumbnails and sorting images into collections.

Generated for version:

[SEE ALSO]
Full documentation: https://www.geeqie.org/help/GuideIndex.html

[BUGS]
Please send bug reports and feedback to https://github.com/BestImageViewer/geeqie/issues

[COPYRIGHT]
Copyright (C) 1999-2004 by John Ellis. Copyright (C) 2004-2021 by The Geeqie Team. Use this software  at  your
own  risk! This  software released under the GNU General Public License. Please read the COPYING file for more
information." > "$options_file"


help2man --no-info --include="$options_file" src/geeqie > geeqie.1

doclifter geeqie.1
mv geeqie.1.xml doc/docbook/CommandLineOptions.xml

rm "$options_file"
