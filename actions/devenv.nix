{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.actions;
  workflowModule = lib.types.submodule {
    options = {
      on = lib.mkOption {
        type = lib.types.attrs;
        default = {
          push = { };
        };
      };
      jobs = lib.mkOption {
        type = lib.types.attrsOf jobModule;
      };
    };
  };
  jobModule = lib.types.submodule {
    options = {
      runs-on = lib.mkOption {
        type = lib.types.str;
        default = "ubuntu-latest";
      };
      steps = lib.mkOption {
        type = lib.types.listOf stepModule;
        apply = builtins.map (lib.filterAttrs (k: v: v != null));
      };
    };
  };
  stepModule = lib.types.submodule {
    options = {
      run = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      uses = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      env = lib.mkOption {
        type = lib.types.nullOr lib.types.attrs;
        default = null;
      };
    };
  };
in
{
  options.actions = {
    enable = lib.mkEnableOption "Enable GitHub Actions module.";

    workflows = lib.mkOption {
      type = lib.types.attrsOf workflowModule;
    };
  };

  config = lib.mkIf cfg.enable {
    git-hooks.hooks.actions = {
      enable = true;
      name = "actions";
      entry = "${
        pkgs.writeShellApplication {
          name = "render-workflows";
          text = ''${lib.concatStrings (
            lib.mapAttrsToList (
              k: v:
              "cp -f ${
                ((pkgs.formats.yaml { }).generate "${k}.yaml" v)
              } ${config.devenv.root}/.github/workflows/${k}.yaml"
            ) cfg.workflows
          )}'';
        }
      }/bin/render-workflows";
    };
  };
}
