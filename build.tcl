#!/usr/bin/tclsh

#package require http
#package require tls

set arch "x86_64"
set base "1.7.20"
set fileurl "https://core.tcl-lang.org/tcltls/uv/tcltls-$base.tar.gz"

#http::register https 443 [list ::tls::socket -ssl3 0 -ssl2 0 -tls1 1]
#if {[file exists tcltls-$base.tar.gz]==0} {
#    puts "Dowonload file..."
#    set f [open tcltls-$base.tar.gz {WRONLY CREAT EXCL}]
#    set token [http::geturl https://core.tcl-lang.org/tcltls/uv/tcltls-$base.tar.gz -channel $f]
#    http::cleanup $token
#    close $f
#    puts "Done."
#}

set var [list wget $fileurl -O tcltls-$base.tar.gz]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force tcltls-$base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tls.spec]
exec >@stdout 2>@stderr {*}$buildit

file delete tcltls-$base.tar.gz

