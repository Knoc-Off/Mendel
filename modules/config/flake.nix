{
  inputs = {
    # this would solve channel issues i think
    #home-manager.url = "github:nix-community/home-manager";
    rust-nix-shell = {
      url = "github:Sciencentistguy/rust-nix-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
}

