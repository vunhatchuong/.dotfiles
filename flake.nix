{
  description = "Nix templates based on https://github.com/Mic92/flake-templates";

  outputs = { ... }: {
    templates = {
      default = {
        path = ./nix/templates/direnv;
        description = "nix flake new -t github:vunhatchuong/.dotfiles .";
      };
      # nix-develop = {
      #   path = ./nix/templates/nix-develop;
      #   description = "nix flake new -t github:vunhatchuong/.dotfiles#nix-develop .";
      # };
    };
  };
}
