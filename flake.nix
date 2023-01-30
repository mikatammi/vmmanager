{
  description = "A flake for building VMmanager";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;

  outputs = { self
  	    , nixpkgs
  	    #, lib
  	    #, stdenv
  	    #, qt5
  	    #, autoPatchelfHook
  	    #, libX11
  	    }
      : {
      packages.x86_64-linux.default =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      
      let
        dynamic-linker = stdenv.cc.bintools.dynamicLinker;

      libPath = lib.makeLibraryPath [
        stdenv.cc.cc qt5.qmake  qt5.qtbase qt5.qtdeclarative qt5.qtquickcontrols qt5.qtquickcontrols2 qt5.qtgraphicaleffects  libX11
      ];

      in stdenv.mkDerivation rec {

        name = "vmmanager";
        
        nativeBuildInputs = [ autoPatchelfHook qt5.wrapQtAppsHook qt5.qtdeclarative qt5.qtquickcontrols qt5.qtquickcontrols2 qt5.qtgraphicaleffects ];

        buildInputs = [ qt5.qmake qt5.qtbase qt5.qtdeclarative qt5.qtquickcontrols qt5.qtquickcontrols2 qt5.qtgraphicaleffects ];
        
        src = self;
        
        buildPhase = "qmake; make";
        installPhase = "mkdir -p $out/bin; mv -t $out/bin vmmanager";
      };

  };
}
