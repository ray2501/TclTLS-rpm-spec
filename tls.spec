#
# spec file for package tls
#
# Copyright (c) 2015 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#


Name:           tls
BuildRequires:  openssl-devel
BuildRequires:  tcl-devel >= 8.4
Summary:        Tcl Binding for the OpenSSL Library
License:        BSD-3-Clause
Group:          Development/Libraries/Tcl
Version:        1.7.20
Release:        0
Url:            http://core.tcl.tk/tcltls/index
Source0:        tcl%name-%version.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
This extension provides a generic binding for Tcl to OpenSSL, utilizing
the new Tcl_StackChannel API for Tcl 8.2 and higher. The sockets behave
exactly the same as channels created using Tcl's built-in socket
command with additional options for controlling the SSL session.



Authors:
--------
    Matt Newman <matt@novadigm.com>
    Jeff Hobbs <jeff@hobbs.org>

%prep
%setup -q -n tcl%name-%version

%build
CFLAGS="$RPM_OPT_FLAGS" \
./configure \
	--libdir=%_libdir \
	--prefix=/usr \
	--with-ssl-dir=/usr \
	--with-tcl=%_libdir
make

%install
make install \
	DESTDIR=%buildroot \
	PKG_HEADERS= \
	libdir=%_libdir/tcl

%clean
rm -rf %buildroot

%files
%defattr(-,root,root,-)
%doc ChangeLog README.txt license.terms tls.htm
%_libdir/tcl

%changelog
