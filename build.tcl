#!/usr/bin/tclsh

package require http

set arch "x86_64"
set base "1.7.12"

if {[file exists tcltls-$base.tar.gz]==0} {
    puts "Dowonload file..."
    set f [open tcltls-$base.tar.gz {WRONLY CREAT EXCL}]
    set token [http::geturl http://core.tcl.tk/tcltls/uv/tcltls-$base.tar.gz -channel $f]
    http::cleanup $token
    close $f
    puts "Done."
}

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force tcltls-$base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tls.spec]
exec >@stdout 2>@stderr {*}$buildit

file delete tcltls-$base.tar.gz

