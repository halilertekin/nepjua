{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
  ];

  users.users.nepjua.home = "/Users/nepjua";
  users.users.nepjua.shell = pkgs.fish;
}
