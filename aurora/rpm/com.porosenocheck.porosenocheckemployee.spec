%global __provides_exclude_from ^%{_datadir}/%{name}/lib/.*$
%global __requires_exclude ^lib(dconf|flutter-embedder|maliit-glib|.+_platform_plugin)\\.so.*$

Name: com.porosenocheck.porosenocheckemployee
Summary: **Porosenochek** is your go-to platform for top-notch pet care services, combining convenience, customization, and compassion. Easily access grooming, health check-ups, and more, all tailored to your pet's needs. Join our community and revolutionize your pet care experience today!
Version: 2.0.0
Release: 20
License: Proprietary
Source0: %{name}-%{version}.tar.zst

BuildRequires: cmake
BuildRequires: ninja

%description
%{summary}.

%prep
%autosetup

%build
%cmake -GNinja -DCMAKE_BUILD_TYPE=%{_flutter_build_type} -DPSDK_VERSION=%{_flutter_psdk_version} -DPSDK_MAJOR=%{_flutter_psdk_major}
%ninja_build

%install
%ninja_install

%files
%{_bindir}/%{name}
%{_datadir}/%{name}/*
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
%{_datadir}/icons/*
