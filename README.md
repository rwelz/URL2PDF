URL2PFD and Download URLS as PDFs [Version 6.2]
===============================================

URL2PDF is a commandline utility that downloads URLs as PDFs. Included is an action for Apple's Automator called Download URLS as PDFs, which allows the user to archive a web page as a PDF document in a given workflow.

Scott Garner
scott@j38.net
http://scott.j38.net/

#Release Notes

I finally gave up on trying to update the original action to work in Lion and decided to take a completely different approach. All of the heavy lifting is now handled by a commandline utility called URL2PDF, which is wrapped by an AppleScript-based Automator Action. 

#Change Log
3/10/17 version 6.2.5 by Robert Welz (welz.willi@gmail.com)
- added "open folder" and "open file" options to open folder which contains pdf or open pdf in defauklt viewer after download.

3/10/17 version 6.2.4 by Robert Welz (welz.willi@gmail.com)
Better example workflow

3/9/17 version 6.2.3 by Robert Welz (welz.willi@gmail.com)
- new project layout - now its only one project. Just build the "BuildAll" target.

3/9/17 version 6.2.2 by Robert Welz (welz.willi@gmail.com)
- xib can be edited without Xcode crashing.

1/28/17 version 6.2.1 by Robert Welz (welz.willi@gmail.com)
cli client “url2pdf”
- executing without options shows help page
- by default pdfs are stored in /Users/USERNAME/URL2PDF Output
which will be created if missing
- made compile with Xcode 8.2.1 without warnings

- written a INSTALL documentation in german and english with Pages and lots of screenshots. Exported to pdf, too.

The original project can be found at: https://github.com/rwelz/URL2PDF
This version can be found at: http://rwelz.byethost13.com/?p=199

2013-06-12 Version 6.2

- Fix for paths with spaces
- Page size fixes

2012-05-30 Version 6.0

- Changed: The action is now a wrapper for a commandline utility.
- Changed: Lion compatibility.
- Chagned: Source now available on Github.
- Changed: Versioning system.

2011-02-22 Version 0.5.0

- Changed:  Snow Leopard compatibility.

2007-11-04 Version 0.4.2

- Fixed: Paginated export works with stand-alone app again.

2007-11-04 Version 0.4.1

- Fixed: Version number issues.
- Fixed: Filename from page title works again.

2007-11-03 Version 0.4.0

- Changed:  Leopard compatibility.
	
2006-04-19 Version 0.3.1

- Changed:  Universal Binary (Maybe...if I did it right.)

2005-07-28 Version 0.3

- New:  Donation button (because you know you want to).
- New:  Advanced option to enable/disable image loading.
- New:  Advanced option to enable/disable JavaScript.
- Fixed:  Pages with forward slashes in their title no longer cause an error when title-based printing is enabled.
- Fixed:  Better handling of pages with child frames (; frames--not necessarily just HTML frames).
- Changed:  Workaround for WebKit animated GIF bug.
- Changed:  Now released under the New BSD License.

2005-07-11 Version 0.2

- Initial "final" release.  Some bugs fixed and probably some new ones introduced.  Either way, the "BETA MODE" watermark is now history.

2005-06-30 Version 0.1 beta

- Initial beta release.
