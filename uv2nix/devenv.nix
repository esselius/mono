{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  options.languages.python.import = lib.mkOption {
    type = lib.types.functionTo (lib.types.functionTo lib.types.package);
  };
  config = {
    packages = [ pkgs.uv ];
    languages.python.import =
      path: args:
      let
        workspace = inputs.uv2nix.lib.workspace.loadWorkspace { workspaceRoot = path; };
        overlay = workspace.mkPyprojectOverlay { sourcePreference = "wheel"; };
        packageName = args.packageName;
        pythonSet =
          (pkgs.callPackage inputs.pyproject-nix.build.packages { python = args.python; }).overrideScope
            (
              lib.composeManyExtensions [
                inputs.pyproject-build-systems.overlays.default
                overlay
              ]
            );
      in
      pythonSet.mkVirtualEnv "${packageName}-env" workspace.deps.default;
  };
}
