with import <nixpkgs> { config.android_sdk.accept_license = true; };

let
  pythonEnv = python3.withPackages (ps: [ ps.absl-py ps.protobuf ps.attrs ]);
  xcodeenv = import ./nix/xcodeenv.nix { inherit stdenv; } { };
  androidDevEnv = import ./nix/android-dev-env.nix { };
in mkShell (androidDevEnv.envVars // rec {
  packages = [
    pythonEnv
    cmake
    ccache
    protobuf
    git
    ninja
    pkg-config

    nixfmt
    which
    vim
    neovim
    emacs
  ] ++ (if stdenv.isDarwin then [ xcodeenv cocoapods ] else [ ]);
  buildInputs = [ clang jdk11 androidDevEnv.android.androidsdk ];
  nativeBuildInputs = [ libsecret  boringssl ];
})
