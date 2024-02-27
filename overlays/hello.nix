final: prev: {

  hello-custom = final.hello.overrideAttrs (old: rec {
    name = "hello-custom";
    version = "2.9";
    src = final.fetchurl {
      url = "mirror://gnu/hello/hello-${version}.tar.gz";
      sha256 = "sha256-7Lt6IhQZbFf/k0CqcUWOFVmr049tjRaWZoRpNd8ZHqc=";
    };
  });

  hello = pkgs.hello;

}
