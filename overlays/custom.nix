final: prev: {
  defaultapp = import ../pkgs/default {pkgs = final;};
  defaultfile = import ../pkgs/defaultfile {pkgs = final;};
  defaultalt = import ../pkgs/defaultalt {pkgs = final;};
  nixapp = import ../pkgs/nixapp {pkgs = final;};

  message = import ../pkgs/message {
    pkgs = final;
    version = "v3.0";
  };

  testapp = import ../pkgs/testapp {
    pkgs = final;
    version = "v3.0";
  };
  

}
